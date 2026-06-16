Return-Path: <stable+bounces-263811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id avw4GFNoMWqMigUAu9opvQ
	(envelope-from <stable+bounces-263811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:14:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B80690D97
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:14:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ls2Pb51n;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263811-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263811-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBAF731C8181
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287B33BFAE2;
	Tue, 16 Jun 2026 15:08:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360636E470;
	Tue, 16 Jun 2026 15:08:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622492; cv=none; b=XhkgVGAGPi5/FV7KBss1kxDU4g+jXnpicaH640gzeSAy3+0w1Lzwubls3tctWoOD6TPCXJNwQ+iVLjHN43uKuVeh+aNkAKItWAzHwwla7CIUmZd63JvqHWzTZtQOxmy9ngltaMLwLnEFMMsPJ2xknhcTErbPJefrWLgF3rM784U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622492; c=relaxed/simple;
	bh=fCjAj0vMsfLuot7z4UInHlpSeXDqxeHEKkJ8cZ7amN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThzAEpJ4wD7mBfmpCGhd+800dufmw/rNopLgwkgl8mJClWzjog+NEzXqIjN8yki7OyV/25jjRx3aMUhEmR1tWPzH2RChsANXlx8dJEO1X8QNvGp1n9kUZDw4283qFUCR+ealbZl8HAJHclyMu8cTqNoyNIvlFvWtrp3aU7fUIUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ls2Pb51n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AE11F00A3D;
	Tue, 16 Jun 2026 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622491;
	bh=ZZJvukK+QeWGa66OlJbzsfXvbzZ6PONorbXgJM2DI3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ls2Pb51nLrjPvGfMkiOXuxyzufIp9bvflKPROlCFKXgVzd1R1Wvma97bCIjo7fpOI
	 UjCLy5l9AfLJ963KgmXHfe/HXsL24W+13SD9CSiA0sSIrfmSw6Pe9iCqLnH+BNGNlk
	 8M1WLVKjCjemIPCOJWGHrn8Xf2NSqUHJMOaMc2fw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 003/261] ARM: group is_permission_fault() with is_translation_fault()
Date: Tue, 16 Jun 2026 20:27:21 +0530
Message-ID: <20260616145045.163543051@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-263811-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rmk+kernel@armlinux.org.uk,m:bigeasy@linutronix.de,m:sashal@kernel.org,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linutronix.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,armlinux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6B80690D97

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

commit dea20281ac88226615761c570c8ff7adc18e6ac2 upstream.

Group is_permission_fault() with is_translation_fault(), which is
needed to use is_permission_fault() in __do_kernel_fault(). As
this is static inline, there is no need for this to be under
CONFIG_MMU.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/fault.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ab01b51de5590b..4dca7b75ae5e43 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -128,6 +128,19 @@ static inline bool is_translation_fault(unsigned int fsr)
 	return false;
 }
 
+static inline bool is_permission_fault(unsigned int fsr)
+{
+	int fs = fsr_fs(fsr);
+#ifdef CONFIG_ARM_LPAE
+	if ((fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL)
+		return true;
+#else
+	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
+		return true;
+#endif
+	return false;
+}
+
 static void die_kernel_fault(const char *msg, struct mm_struct *mm,
 			     unsigned long addr, unsigned int fsr,
 			     struct pt_regs *regs)
@@ -226,19 +239,6 @@ void do_bad_area(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_MMU
-static inline bool is_permission_fault(unsigned int fsr)
-{
-	int fs = fsr_fs(fsr);
-#ifdef CONFIG_ARM_LPAE
-	if ((fs & FS_MMU_NOLL_MASK) == FS_PERM_NOLL)
-		return true;
-#else
-	if (fs == FS_L1_PERM || fs == FS_L2_PERM)
-		return true;
-#endif
-	return false;
-}
-
 #ifdef CONFIG_CPU_TTBR0_PAN
 static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
 {
-- 
2.53.0




