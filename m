Return-Path: <stable+bounces-242873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGmbF5la+GlStQIAu9opvQ
	(envelope-from <stable+bounces-242873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:36:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C037B4BA4F8
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88051301700F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DF633F5AF;
	Mon,  4 May 2026 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jPt/YJ4W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C13168FB
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883543; cv=none; b=il5GbNCwVFP6h51+hkvpwThdb7gjRYAReoKZwG7WXlU+YT5UWeq/BPhLPgj+1eCAGaG1PZJcG8nEoOy7rRLEHqITqDByiq0tiw2BlAEJ3MCiDEa5XW2qkFrROBZEgGseglhmUDXGeq0sNyAKJXp1BKzwvt9VaHqJhSZVm3ecFtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883543; c=relaxed/simple;
	bh=IwkcgYVbQOzmAo42kTco3928RwiWPrV0hPfgy3ABNFQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZcMK5WiIer+3p7kMGo4Xq5WKfUm5wEMslbR9m9RGVB1qRu4XfTFP3qQXQzRuARK4l6f2N3Y18XNTm0yEMEI+Rk8VkMnBTXe+Xs0b4F8FRNXQzIaN2noVnGLUA2p56tnpxDuGKrmyW0zjURb0mkFYjuU36m0i4KIvtv9V+C5AO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jPt/YJ4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C28C2BCB8;
	Mon,  4 May 2026 08:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777883542;
	bh=IwkcgYVbQOzmAo42kTco3928RwiWPrV0hPfgy3ABNFQ=;
	h=Subject:To:Cc:From:Date:From;
	b=jPt/YJ4WLEJr71Q4HotlMU98hkKyAdLsMXlQ0/ZZ9TdFBDPeg/UGKQWduXCxSk23Z
	 icnMvLbshEpzj3AXnDAgTcld1yWVPRdojyzmG7ZWIsPXUYWL0+PPX0lKdAIpZdFN4r
	 v2B1QB4iPWoZbf8l9pq1elMtE+aFJbI6co6pGDTo=
Subject: FAILED: patch "[PATCH] ARM: 9472/1: fix race condition on PG_dcache_clean in" failed to apply to 6.6-stable tree
To: brian.ruley@gehealthcare.com,rmk+kernel@armlinux.org.uk,stable@vger.kernel.org,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:32:12 +0200
Message-ID: <2026050412-hug-headed-1eba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C037B4BA4F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242873-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gehealthcare.com:email,gregkh:email,armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 75f9a484e817adea211c73f89ed938a2b2f90953
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050412-hug-headed-1eba@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 75f9a484e817adea211c73f89ed938a2b2f90953 Mon Sep 17 00:00:00 2001
From: Brian Ruley <brian.ruley@gehealthcare.com>
Date: Wed, 15 Apr 2026 18:12:48 +0100
Subject: [PATCH] ARM: 9472/1: fix race condition on PG_dcache_clean in
 __sync_icache_dcache()

This bug was already discovered and fixed for arm64 in
commit 588a513d3425 ("arm64: Fix race condition on PG_dcache_clean in
__sync_icache_dcache()").

Verified with added instrumentation to track dcache flushes in a ring
buffer, as shown by the (distilled) output:

  kernel: SIGILL at b6b80ac0 cpu 1 pid 32663 linux_pte=8eff659f
          hw_pte=8eff6e7e young=1 exec=1
  kernel: dcache flush START   cpu0 pfn=8eff6 ts=48629557020154
  kernel: dcache flush SKIPPED cpu1 pfn=8eff6 ts=48629557020154
  kernel: dcache flush FINISH  cpu0 pfn=8eff6 ts=48629557036154
  audisp-syslog: comm="journalctl" exe="/usr/bin/journalctl" sig=4 [...]

Discussions in the mailing list mentioned that arch/arm is also affected
but the fix was never applied to it [1][2]. Apply the change now, since
the race condition can cause sporadic SIGILL's and SEGV's especially
while under high memory pressure.

Link: https://lore.kernel.org/all/adzMOdySgMIePcue@willie-the-truck [1]
Link: https://lore.kernel.org/all/20210514095001.13236-1-catalin.marinas@arm.com [2]
Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
Reviewed-by: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Fixes: 6012191aa9c6 ("ARM: 6380/1: Introduce __sync_icache_dcache() for VIPT caches")
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 19470d938b23..4d7ef5cc36b6 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -304,8 +304,10 @@ void __sync_icache_dcache(pte_t pteval)
 	else
 		mapping = NULL;
 
-	if (!test_and_set_bit(PG_dcache_clean, &folio->flags.f))
+	if (!test_bit(PG_dcache_clean, &folio->flags.f)) {
 		__flush_dcache_folio(mapping, folio);
+		set_bit(PG_dcache_clean, &folio->flags.f);
+	}
 
 	if (pte_exec(pteval))
 		__flush_icache_all();


