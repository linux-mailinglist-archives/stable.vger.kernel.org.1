Return-Path: <stable+bounces-223566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEnLMHmgrmntGwIAu9opvQ
	(envelope-from <stable+bounces-223566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:27:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A652237060
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C0D43043003
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0965635C192;
	Mon,  9 Mar 2026 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1iXt9u2m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2057D27E
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051979; cv=none; b=E7An1dXpM57qODudlXoziRYBc6IY2gAIQ3li/fAqh/yXvOfvTOE/WjlhONtIRiiGZkHtJbFfYwY2NOIDrhsobmeouA3EKbgBoLGoObZ0E6E2hNdWUQjDICExukBw2mJg6Rmjpp9gJ/aoULbUN6ON+W6DTjxxblQouq3ocVBPhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051979; c=relaxed/simple;
	bh=PFC9Ct+gqPUWfKxZIoznprzQMGZl+DKhwxkATc9Ytvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uQjAJDN/s2W03VVH671lCzBx5+061cWMfetWHJTK9bZrkYGrhmof7EqujYJePvskxcimKr5vQFvCI1m6MwKoBv3FQ6GuNhVnZZo7mbrIeCIg5/TvMLwcD2mY03Up/NV9ItwGAhoYNs5Q33cYXfQH5cEXG6SYv7TRaz/KsGqkLTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1iXt9u2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E67C4CEF7;
	Mon,  9 Mar 2026 10:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773051979;
	bh=PFC9Ct+gqPUWfKxZIoznprzQMGZl+DKhwxkATc9Ytvc=;
	h=Subject:To:Cc:From:Date:From;
	b=1iXt9u2miV0+QXveDRR1Id8q6HY3k2r2nNAYU/96NGLhIkpVtbvnJ1UZYJhvKaPz+
	 3/Xc39KA0k8PV9K6XfofofCpAhd0HS3GnmSd/j3By3+zKHw4w2D5GO7yB5RDf2O/QZ
	 xahspeE7BCrGvYDoerV2EEF1G8NWh6b6uJf0ldqw=
Subject: FAILED: patch "[PATCH] xfs: Fix error pointer dereference" failed to apply to 6.12-stable tree
To: ethantidmore06@gmail.com,cem@kernel.org,djwong@kernel.org,nirjhar.roy.lists@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 09 Mar 2026 11:26:17 +0100
Message-ID: <2026030917-lagged-volumes-b38a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A652237060
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223566-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.241];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cddfa648f1ab99e30e91455be19cd5ade26338c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026030917-lagged-volumes-b38a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cddfa648f1ab99e30e91455be19cd5ade26338c2 Mon Sep 17 00:00:00 2001
From: Ethan Tidmore <ethantidmore06@gmail.com>
Date: Thu, 19 Feb 2026 21:38:25 -0600
Subject: [PATCH] xfs: Fix error pointer dereference

The function try_lookup_noperm() can return an error pointer and is not
checked for one.

Add checks for error pointer in xrep_adoption_check_dcache() and
xrep_adoption_zap_dcache().

Detected by Smatch:
fs/xfs/scrub/orphanage.c:449 xrep_adoption_check_dcache() error:
'd_child' dereferencing possible ERR_PTR()

fs/xfs/scrub/orphanage.c:485 xrep_adoption_zap_dcache() error:
'd_child' dereferencing possible ERR_PTR()

Fixes: 73597e3e42b4 ("xfs: ensure dentry consistency when the orphanage adopts a file")
Cc: stable@vger.kernel.org # v6.16
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/orphanage.c b/fs/xfs/scrub/orphanage.c
index 52a108f6d5f4..33c6db6b4498 100644
--- a/fs/xfs/scrub/orphanage.c
+++ b/fs/xfs/scrub/orphanage.c
@@ -442,6 +442,11 @@ xrep_adoption_check_dcache(
 		return 0;
 
 	d_child = try_lookup_noperm(&qname, d_orphanage);
+	if (IS_ERR(d_child)) {
+		dput(d_orphanage);
+		return PTR_ERR(d_child);
+	}
+
 	if (d_child) {
 		trace_xrep_adoption_check_child(sc->mp, d_child);
 
@@ -479,7 +484,7 @@ xrep_adoption_zap_dcache(
 		return;
 
 	d_child = try_lookup_noperm(&qname, d_orphanage);
-	while (d_child != NULL) {
+	while (!IS_ERR_OR_NULL(d_child)) {
 		trace_xrep_adoption_invalidate_child(sc->mp, d_child);
 
 		ASSERT(d_is_negative(d_child));


