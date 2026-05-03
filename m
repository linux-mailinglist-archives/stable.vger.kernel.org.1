Return-Path: <stable+bounces-242786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJfIF/BC92mkdwIAu9opvQ
	(envelope-from <stable+bounces-242786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:43:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F174B5D50
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 14:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E4CB300B041
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 12:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE143B8935;
	Sun,  3 May 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MksvOaSz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A23B894D
	for <stable@vger.kernel.org>; Sun,  3 May 2026 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777812180; cv=none; b=oIdVTzeYJ/XIqbIWKWYeatIT8OWLYeYR5NdksfgMh7QfF6N9csN8v9WO0nrTscTDmpdS3I2ES4V0bQgvrQ0na8mzavxoZw3Ya6p2WEf4lFBX5W7DYes6B4E1bPp5lJFdMuXm4+CdE6t58jH0Qf2j6QOm5bIU8WrqcMvqQ1GpgyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777812180; c=relaxed/simple;
	bh=9E4P+vJUK6lbzPyC0y41xwhbJUtAiMxk/0m7CWTBQ4w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i5eHKRvbbxnAFb7ovaz2pzcxfY4ZGqs3U26M5X6t07cpYnjACJGBFi8tsRh6EnC6l32Qh8KSd+h/scwGpFz/58eOgEzVh1JdPuBYshU/dVSdMpDneXDd9ZvBQK5roMZGgQFWARuaxAtKou3jzOBWibbu53qEYS3ueJIx8NnNcTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MksvOaSz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867FEC2BCB4;
	Sun,  3 May 2026 12:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777812179;
	bh=9E4P+vJUK6lbzPyC0y41xwhbJUtAiMxk/0m7CWTBQ4w=;
	h=Subject:To:Cc:From:Date:From;
	b=MksvOaSzLSo4c7J2EFQt0BBqK54tyiFCAbyiu/JEJXrfuWpqfuBaCmfSO3oEigTkw
	 6c/BUaew9yhzj4XhEoPOzTEJm2g8TIrG21TCMN4aCLcf0pSc9utEwelESGFW2AyYHZ
	 fIZtSlOyjebb4ZrASpis/YLrIb4T3HP8kAdZ3U40=
Subject: FAILED: patch "[PATCH] mm/damon/core: disallow non-power of two min_region_sz on" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 14:42:57 +0200
Message-ID: <2026050357-senator-aroma-1859@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A8F174B5D50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242786-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linux-foundation.org:email]


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 95093e5cb4c5b50a5b1a4b79f2942b62744bd66a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050357-senator-aroma-1859@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 95093e5cb4c5b50a5b1a4b79f2942b62744bd66a Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Sat, 11 Apr 2026 14:36:36 -0700
Subject: [PATCH] mm/damon/core: disallow non-power of two min_region_sz on
 damon_start()

Commit d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region") introduced
a bug that allows unaligned DAMON region address ranges.  Commit
c80f46ac228b ("mm/damon/core: disallow non-power of two min_region_sz")
fixed it, but only for damon_commit_ctx() use case.  Still, DAMON sysfs
interface can emit non-power of two min_region_sz via damon_start().  Fix
the path by adding the is_power_of_2() check on damon_start().

The issue was discovered by sashiko [1].

Link: https://lore.kernel.org/20260411213638.77768-1-sj@kernel.org
Link: https://lore.kernel.org/20260403155530.64647-1-sj@kernel.org [1]
Fixes: d8f867fa0825 ("mm/damon: add damon_ctx->min_sz_region")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3703f62a876b..c107d74c77e7 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1368,6 +1368,11 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 	int i;
 	int err = 0;
 
+	for (i = 0; i < nr_ctxs; i++) {
+		if (!is_power_of_2(ctxs[i]->min_region_sz))
+			return -EINVAL;
+	}
+
 	mutex_lock(&damon_lock);
 	if ((exclusive && nr_running_ctxs) ||
 			(!exclusive && running_exclusive_ctxs)) {


