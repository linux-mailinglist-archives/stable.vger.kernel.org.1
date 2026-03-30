Return-Path: <stable+bounces-231123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOVkCPZHymkQ7QUAu9opvQ
	(envelope-from <stable+bounces-231123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:52:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BDB3589B3
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 11:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92852300B1A5
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40393AEF57;
	Mon, 30 Mar 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2b1LLrEj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878653ACA5F
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864360; cv=none; b=Mht6HbxbbuEAPYJe2hreV1MmARfGQ83kWXsm0nxpP7I5JGZAEg3O6Ks2VDIE7NV3Xr//4dtzSrA2LMHRbP7Cu+wd6yWCBTci9G+razrBXJjx/cG7xNYKzrhZkM16TTC+PzBK1ab3XT+CECxp01Hz5KZE4r1Eo6OZhYreK5EHTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864360; c=relaxed/simple;
	bh=zrGJ35mGyQ3M4OyncZ4cMsXv62T+vpP59i5WqWNIVNM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QlfbFlAuUuPVSjtGjuv9pK6RNyrGR8FGcbP6/CNQwS7hBk5RAaA5oL9Q5J4fWS13ZxtiFJSP7DpBKH9VWD4KEC2tMVCKSQoIiYZH5S7q53lSXX5aRIZgAOmnEwdsWl6VD+GQU+iRyOHz6hjpjW7HrHxyU/NKzwVlNMeuUbYLs7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2b1LLrEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DE5C4CEF7;
	Mon, 30 Mar 2026 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774864360;
	bh=zrGJ35mGyQ3M4OyncZ4cMsXv62T+vpP59i5WqWNIVNM=;
	h=Subject:To:Cc:From:Date:From;
	b=2b1LLrEjamT8LWYs7iB8OIXUvWjp2QZ12HpzhFw7WgkeyTtmAM/wEd0c9UGasr4Ut
	 iNWVVGvfS7AOT0bqHPtZdV4AuzaaKRQys1or1WgqHWMUsk5X/2YeUsgFveMD0Yg8/k
	 IAFwxS0M1MQjYMpmGgNe0jZWpfOyDjDPDTevEzK8=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs: check contexts->nr before accessing" failed to apply to 6.6-stable tree
To: objecting@objecting.org,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Mar 2026 11:52:37 +0200
Message-ID: <2026033036-ecosphere-leggings-7691@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231123-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,objecting.org:email]
X-Rspamd-Queue-Id: B3BDB3589B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1bfe9fb5ed2667fb075682408b776b5273162615
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026033036-ecosphere-leggings-7691@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1bfe9fb5ed2667fb075682408b776b5273162615 Mon Sep 17 00:00:00 2001
From: Josh Law <objecting@objecting.org>
Date: Sat, 21 Mar 2026 10:54:25 -0700
Subject: [PATCH] mm/damon/sysfs: check contexts->nr before accessing
 contexts_arr[0]

Multiple sysfs command paths dereference contexts_arr[0] without first
verifying that kdamond->contexts->nr == 1.  A user can set nr_contexts to
0 via sysfs while DAMON is running, causing NULL pointer dereferences.

In more detail, the issue can be triggered by privileged users like
below.

First, start DAMON and make contexts directory empty
(kdamond->contexts->nr == 0).

    # damo start
    # cd /sys/kernel/mm/damon/admin/kdamonds/0
    # echo 0 > contexts/nr_contexts

Then, each of below commands will cause the NULL pointer dereference.

    # echo update_schemes_stats > state
    # echo update_schemes_tried_regions > state
    # echo update_schemes_tried_bytes > state
    # echo update_schemes_effective_quotas > state
    # echo update_tuned_intervals > state

Guard all commands (except OFF) at the entry point of
damon_sysfs_handle_cmd().

Link: https://lkml.kernel.org/r/20260321175427.86000-3-sj@kernel.org
Fixes: 0ac32b8affb5 ("mm/damon/sysfs: support DAMOS stats")
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[5.18+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b573b9d60784..ddc30586c0e6 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1749,6 +1749,9 @@ static int damon_sysfs_update_schemes_tried_regions(
 static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 		struct damon_sysfs_kdamond *kdamond)
 {
+	if (cmd != DAMON_SYSFS_CMD_OFF && kdamond->contexts->nr != 1)
+		return -EINVAL;
+
 	switch (cmd) {
 	case DAMON_SYSFS_CMD_ON:
 		return damon_sysfs_turn_damon_on(kdamond);


