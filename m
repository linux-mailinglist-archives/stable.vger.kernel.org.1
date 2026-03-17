Return-Path: <stable+bounces-225862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP8UCRNBuWmB9QEAu9opvQ
	(envelope-from <stable+bounces-225862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:54:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2920C2A94C2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20E92302BB93
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FF3B0AF5;
	Tue, 17 Mar 2026 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SQamij4V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97283B0AE0
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748412; cv=none; b=rdMWRO35eh0geCveww9yhpLdeJUJQtzeayHPqZbMUM4yi4dF/V9dEH4Xh7V/JwFE8A5pdHQPb4sa68u8H//m94+6yjeONeGlRrlfgco00kLqthmDehZQOaWv+Y/HLqjvqetzZ7vn61N7fCM4HPCgFQA7K7kBmwYXRFySb7lSQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748412; c=relaxed/simple;
	bh=JiXk1IUFgHs49ScBpibqtEnwqAU9IwqUt7Amx+TV/xM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mgjlzha35cw0oTqD6zGanbPxif8CjXTOwVoyBq/kAl8RflmTkK31v51gFk1/trdwpXVpK7Pl3NXuoc85f0nq7wYZq3zcCDLeIcnAe/ie9gZKXJBJVcazo4IcqDjFDdHWFxSQFWZz1R53LHUOhchcXvKF2NUUSvCNQRyt+IhXiSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SQamij4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56C8C4CEF7;
	Tue, 17 Mar 2026 11:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773748412;
	bh=JiXk1IUFgHs49ScBpibqtEnwqAU9IwqUt7Amx+TV/xM=;
	h=Subject:To:Cc:From:Date:From;
	b=SQamij4VBdmMDBXCbHMtGXB8m94S7qMkNIaFDP4QgN4TrTqoauwzuPdflS2BGHmPQ
	 JLQAAJzP9H4DZpgZoTYOIcm6j5mnFh47X66ULOfZ2wnw2JMSFljMQxhpYwjrn+ZZ1y
	 BCVeL3/RXK1fmDSMsb/AY3q7vZC55QqwplK+Rg6E=
Subject: FAILED: patch "[PATCH] nsfs: tighten permission checks for handle opening" failed to apply to 6.18-stable tree
To: brauner@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 12:53:28 +0100
Message-ID: <2026031728-canteen-ramp-ec25@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225862-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,gregkh:email,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2920C2A94C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d2324a9317f00013facb0ba00b00440e19d2af5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031728-canteen-ramp-ec25@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d2324a9317f00013facb0ba00b00440e19d2af5e Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:50:10 +0100
Subject: [PATCH] nsfs: tighten permission checks for handle opening

Even privileged services should not necessarily be able to see other
privileged service's namespaces so they can't leak information to each
other. Use may_see_all_namespaces() helper that centralizes this policy
until the nstree adapts.

Link: https://patch.msgid.link/20260226-work-visibility-fixes-v1-2-d2c2853313bd@kernel.org
Fixes: 5222470b2fbb ("nsfs: support file handles")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@kernel.org # v6.18+
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/nsfs.c b/fs/nsfs.c
index be36c10c38cf..c215878d55e8 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -627,7 +627,7 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-	if (owning_ns && !ns_capable(owning_ns, CAP_SYS_ADMIN)) {
+	if (owning_ns && !may_see_all_namespaces()) {
 		ns->ops->put(ns);
 		return ERR_PTR(-EPERM);
 	}


