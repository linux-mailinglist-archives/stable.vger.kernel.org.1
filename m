Return-Path: <stable+bounces-13647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4774F837D40
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2CC1C260E4
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173A85101D;
	Tue, 23 Jan 2024 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BIbdLTV9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AC3A8F4;
	Tue, 23 Jan 2024 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969860; cv=none; b=gAHDGo+U3+4fk/53GgY9DuBFsReE6ywlNohHqS49dsDvEVFOrFZWnZ3mamTkFfn2H9azKh8gGucPrS49unkQgKNxm/5HbfGipzJCwCg5dmQ2zYoVsHN4y9lpbJUYK9aK/uG8MmjezJfabN+mH6kugHhgmuSoaLOyqQxI5X0HCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969860; c=relaxed/simple;
	bh=4OWMHqo4y9E1+Z484Rt3bwJKTpYdBP80CeRuTER3dUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gy4ZXtWlCQlG545l0ZTwEM10zZCCqyWyk6sELNiGcLtekKOLh8B2PjaFItsX11G1tNqi3dz4e/7NQn9fKyld0fg1P/CJBdouunUHdMYi0H8ioJqsDJQErvXUk3Bjaigm8uw+YhEPxTFlbAPi77S1gOkk+lMxKJI7s0TW8bv+tR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BIbdLTV9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926F1C433C7;
	Tue, 23 Jan 2024 00:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969860;
	bh=4OWMHqo4y9E1+Z484Rt3bwJKTpYdBP80CeRuTER3dUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIbdLTV9SEPYvjhlDsO2xikuppb3NxoCbHSHWT83OxNPNNv72OdOn/PhJfebkni4t
	 6wjlh7fSZx0b7xqCgZORdSiKEhsMx+Bhc2tCutB2hcrMBwEEGBsu/U+/f95pY9FFjf
	 bHoYMmcI9BGNi2fhcyBt9UWURcke27y/wJ3NdKoU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Serge Semin <fancer.lancer@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 491/641] mips: dmi: Fix early remap on MIPS32
Date: Mon, 22 Jan 2024 15:56:35 -0800
Message-ID: <20240122235833.437407018@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

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




