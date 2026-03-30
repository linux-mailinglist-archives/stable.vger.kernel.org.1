Return-Path: <stable+bounces-231121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLU2A21IymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:54:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7D358A4E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 05DFC3007216
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658333AB265;
	Mon, 30 Mar 2026 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IwaV8mwX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2949738644E
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864331; cv=none; b=d7HL7cEatPgxNGF3UQbRFBsMHehK+ARPwzZWYxHS7i1GcznGilzb223r+AhlesxmGvDHF8fpeswofB7VCqhcep5Dc4YLpu6OpOxJiRMDW7JLUTgrfGPd/esys4p2b8wAcTtxloMdVKMLnUulswZG5sGk0Kq28S8UHrqORfAk5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864331; c=relaxed/simple;
	bh=rVufLvS7UlFHbRKoYwPMwQap6cGGaBkT+6o/G8puBgA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aTL1+BxrLetsbyJfEXxJvNNWAnaDtevy+qjtOgluGHVIQvz06tRu5cOdmPBrZonFkJ07FVchzW1gcQvppm+8IwEscquhBbfIknWlWFLpjJVKWlf4sB2DHgxnRozz4/7eGoGE+9eUtsRyA7OAqmHYJj4waDtvJL5YYdfPnVD0HBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IwaV8mwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB30C4CEF7;
	Mon, 30 Mar 2026 09:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774864330;
	bh=rVufLvS7UlFHbRKoYwPMwQap6cGGaBkT+6o/G8puBgA=;
	h=Subject:To:Cc:From:Date:From;
	b=IwaV8mwXdBa2N9SaM+u+nSmdw0MElCrJA4aCRZZYYWYYV3326pLrPt2ENDh1EfsZp
	 dTLcwFfYN9Td5kaFBaD5E9qN1PWH9XtPK8WwLBe2JJsRR0kbyGo96qthBZtJFvRefP
	 lEAerBcYCoEDMK1ZE+Ct10q5HNI26oUAp9S1mlHY=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs: fix param_ctx leak on" failed to apply to 6.18-stable tree
To: objecting@objecting.org,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:52:07 +0200
Message-ID: <2026033007-talon-immature-91a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231121-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linux-foundation.org:email,gregkh:email,objecting.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DF7D358A4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7fe000eb32904758a85e62f6ea9483f89d5dabfc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033007-talon-immature-91a3@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7fe000eb32904758a85e62f6ea9483f89d5dabfc Mon Sep 17 00:00:00 2001
From: Josh Law <objecting@objecting.org>
Date: Sat, 21 Mar 2026 10:54:24 -0700
Subject: [PATCH] mm/damon/sysfs: fix param_ctx leak on
 damon_sysfs_new_test_ctx() failure

Patch series "mm/damon/sysfs: fix memory leak and NULL dereference
issues", v4.

DAMON_SYSFS can leak memory under allocation failure, and do NULL pointer
dereference when a privileged user make wrong sequences of control.  Fix
those.


This patch (of 3):

When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
param_ctx is leaked because the early return skips the cleanup at the out
label.  Destroy param_ctx before returning.

Link: https://lkml.kernel.org/r/20260321175427.86000-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20260321175427.86000-2-sj@kernel.org
Fixes: f0c5118ebb0e ("mm/damon/sysfs: catch commit test ctx alloc failure")
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[6.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 576d1ddd736b..b573b9d60784 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1524,8 +1524,10 @@ static int damon_sysfs_commit_input(void *data)
 	if (IS_ERR(param_ctx))
 		return PTR_ERR(param_ctx);
 	test_ctx = damon_sysfs_new_test_ctx(kdamond->damon_ctx);
-	if (!test_ctx)
+	if (!test_ctx) {
+		damon_destroy_ctx(param_ctx);
 		return -ENOMEM;
+	}
 	err = damon_commit_ctx(test_ctx, param_ctx);
 	if (err)
 		goto out;


