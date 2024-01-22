Return-Path: <stable+bounces-14366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D8F83809A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F87C1F2CDC1
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B57130E2A;
	Tue, 23 Jan 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RGB1Im9n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED112FF73;
	Tue, 23 Jan 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971814; cv=none; b=n1h0yV+tE1tszcQ5Je7kEQDfiyZWigQYLlHKLOBwIDg/eU7BiFA+lHIPk1m+u6u8jQDOllmYKWdctfeB184QideBN/UNC0oOmjD+yOkpBWWSF3lubEgi+bKIE5ZqN2MnF4DbHcTbbGGeC8QrdzrR/nPu+xY9gaNPSYwoYjCvaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971814; c=relaxed/simple;
	bh=MBxQfqbflByCGHzmeqMLgWEUtQdsmf81oVh6Yu0POKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0Dm5ZqGZP1HzVW2a/9u4SLGTF7jmycHTdoq8mRu6lpwcBb03Uqp1GPfq5+2X3foOpKiffM+tB9dH8J6KpMKYhaX6hkeT8VxnK13Ojg9yuVAX2gPqJMRryJwz+XrNc2eY9mAE/MORxc2kSSGHup3aU7q97D0EJRUIonsBRxchCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RGB1Im9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F5BC433F1;
	Tue, 23 Jan 2024 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971814;
	bh=MBxQfqbflByCGHzmeqMLgWEUtQdsmf81oVh6Yu0POKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGB1Im9naT/KLNPPLlwyV+gUqMQr5vw7BWHEjGFe6SSl07xvdsT/KTvn2V+WEEub4
	 xpZyiqrAVhFDiIo7krfSUaOL8Rs9OFW7zHMCqGjmPyLxBU56vAdKWJ6qVu+O79aVfA
	 sniJoP7yOlR4jTbgvigN832d2eb7ljLs/945Az9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serge Semin <fancer.lancer@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 327/417] mips: dmi: Fix early remap on MIPS32
Date: Mon, 22 Jan 2024 15:58:15 -0800
Message-ID: <20240122235803.125920022@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235751.480367507@linuxfoundation.org>
References: <20240122235751.480367507@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Serge Semin <fancer.lancer@gmail.com>

[ Upstream commit 0d0a3748a2cb38f9da1f08d357688ebd982eb788 ]

dmi_early_remap() has been defined as ioremap_cache() which on MIPS32 gets
to be converted to the VM-based mapping. DMI early remapping is performed
at the setup_arch() stage with no VM available. So calling the
dmi_early_remap() for MIPS32 causes the system to crash at the early boot
time. Fix that by converting dmi_early_remap() to the uncached remapping
which is always available on both 32 and 64-bits MIPS systems.

Note this change shall not cause any regressions on the current DMI
support implementation because on the early boot-up stage neither MIPS32
nor MIPS64 has the cacheable ioremapping support anyway.

Fixes: be8fa1cb444c ("MIPS: Add support for Desktop Management Interface (DMI)")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/include/asm/dmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dmi.h b/arch/mips/include/asm/dmi.h
index 27415a288adf..dc397f630c66 100644
--- a/arch/mips/include/asm/dmi.h
+++ b/arch/mips/include/asm/dmi.h
@@ -5,7 +5,7 @@
 #include <linux/io.h>
 #include <linux/memblock.h>
 
-#define dmi_early_remap(x, l)		ioremap_cache(x, l)
+#define dmi_early_remap(x, l)		ioremap(x, l)
 #define dmi_early_unmap(x, l)		iounmap(x)
 #define dmi_remap(x, l)			ioremap_cache(x, l)
 #define dmi_unmap(x)			iounmap(x)
-- 
2.43.0




