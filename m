Return-Path: <stable+bounces-41142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361208AFA79
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21D81F29699
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CD3149DF1;
	Tue, 23 Apr 2024 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RerSEZe9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5D143C41;
	Tue, 23 Apr 2024 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908706; cv=none; b=DxJI058gxAUinzFzq+8SZwDtMxjrmTXMLw/tDXHn7pzwEQH6MVlVWozjcXyTrLbByIseJTvqMMLLPFJNj7XgZlx0dOTmQC174bmgUXyE9UoPKdsQQ5e8nKwC7SeFzKnEitKQKj8jJn4p770Zjep8r/U2uj2CxLb6RzntOsNlFco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908706; c=relaxed/simple;
	bh=ttOxlreeqC4NVbTete9S1dmmkXekuNoW7gz4VktxoOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImPzZ2pSb9zWLK+lYmA/e6ubROidby2rZmS5T1rybqNnMNPsnUB2ngcn20/QY2HhZ0lqiIWLKQqD4a5NzTRImJGsHdwIOiHJMc/M7DpEwBxlWs0G7lknqyYdbSez8SafrPJ3iH/sUT2fEmtJFKRpSK46MfcKCYCeyeDC3TLoe+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RerSEZe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE33C116B1;
	Tue, 23 Apr 2024 21:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908706;
	bh=ttOxlreeqC4NVbTete9S1dmmkXekuNoW7gz4VktxoOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RerSEZe9qUEF29smjOdYCABtVTvBjHKzTj+17aJeYI+x7AtSUE4yIYHMLZIiybHhA
	 8wfLfU165jfd1nFgwoJ3g7VX/2MF/Pako1Vv/kA9OybWHaNckXUJ3xr3v3kwdWg+YC
	 0CXMwrEMa8ML5PNhj6iX4cOFrYfpCM3+hzNC4SWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 061/141] x86/quirks: Include linux/pnp.h for arch_pnpbios_disabled()
Date: Tue, 23 Apr 2024 14:38:49 -0700
Message-ID: <20240423213855.230977851@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 056b44a4d10907ec8153863b2a0564e808ef1440 ]

arch_pnpbios_disabled() is defined in architecture code on x86, but this
does not include the appropriate header, causing a warning:

arch/x86/kernel/platform-quirks.c:42:13: error: no previous prototype for 'arch_pnpbios_disabled' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Link: https://lore.kernel.org/all/20230516193549.544673-10-arnd%40kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/platform-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index b348a672f71d5..b525fe6d66571 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/pnp.h>
 
 #include <asm/setup.h>
 #include <asm/bios_ebda.h>
-- 
2.43.0




