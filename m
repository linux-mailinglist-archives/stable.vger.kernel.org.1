Return-Path: <stable+bounces-225804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDd8FCMsuWmVtQEAu9opvQ
	(envelope-from <stable+bounces-225804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:25:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0072A7D77
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DC093011767
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A304C35DA6B;
	Tue, 17 Mar 2026 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zlCLy0un"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6793B355F48
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742791; cv=none; b=N7HeT5Zo4sNhVOzCsE6FXQ/JK9T6F5WhTCaQJbCpDZPYHKe3EX2cnZ86HocQm2umqyYtgyh6gkIWhq3YC7DTDKNApvkrJNfE9tQI0u5ikjpcTH95EHMJqQoVCnrDLyy03SJyhHFp9PRsAtqQ5Glm4KBrLQ2m6mSY2QS9v0OoVVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742791; c=relaxed/simple;
	bh=tq5tOwZg8L0xpLiCBDq7/0SDo++SY20scHUM/wOS7ss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KLv8Clm3RN+1jjx7thhgWYKWXr6ySZZFeLkjdmGTgqhijQykum1rZcXA65feetydRpD9YWRazy1Bew0bc8J+z3sT2Liu/3JFdxtL5R2ngBbHEVX/ecoI320ZESnU8usRGwfL2a5KDi0nLB2yteY9qagR6HcQgWvHfR2AEFhCBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zlCLy0un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767F6C4CEF7;
	Tue, 17 Mar 2026 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773742791;
	bh=tq5tOwZg8L0xpLiCBDq7/0SDo++SY20scHUM/wOS7ss=;
	h=Subject:To:Cc:From:Date:From;
	b=zlCLy0unYrDTcgTEKlDFDKIeklxp4b6LUeARHCptQbbZnAzpbWNZ54+l/EMQ4N8Wz
	 uRpqwJPdbRjH0sNUGkgIM/WMj/kZy1BJ58s5jzhxm+KUOeA7Eg7+OF+ZCb2Hg4vtiv
	 ufN2c1gI9JAbWmG4K19PuN1+mT1LJQ924iGSnxLc=
Subject: FAILED: patch "[PATCH] nsfs: tighten permission checks for ns iteration ioctls" failed to apply to 6.18-stable tree
To: brauner@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 11:19:47 +0100
Message-ID: <2026031747-sweat-levitate-59b2@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225804-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: BC0072A7D77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e6b899f08066e744f89df16ceb782e06868bd148
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031747-sweat-levitate-59b2@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6b899f08066e744f89df16ceb782e06868bd148 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:50:09 +0100
Subject: [PATCH] nsfs: tighten permission checks for ns iteration ioctls

Even privileged services should not necessarily be able to see other
privileged service's namespaces so they can't leak information to each
other. Use may_see_all_namespaces() helper that centralizes this policy
until the nstree adapts.

Link: https://patch.msgid.link/20260226-work-visibility-fixes-v1-1-d2c2853313bd@kernel.org
Fixes: a1d220d9dafa ("nsfs: iterate through mount namespaces")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@kernel.org # v6.12+
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/fs/nsfs.c b/fs/nsfs.c
index db91de208645..be36c10c38cf 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -199,6 +199,17 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
 	return false;
 }
 
+static bool may_use_nsfs_ioctl(unsigned int cmd)
+{
+	switch (_IOC_NR(cmd)) {
+	case _IOC_NR(NS_MNT_GET_NEXT):
+		fallthrough;
+	case _IOC_NR(NS_MNT_GET_PREV):
+		return may_see_all_namespaces();
+	}
+	return true;
+}
+
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			unsigned long arg)
 {
@@ -214,6 +225,8 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 
 	if (!nsfs_ioctl_valid(ioctl))
 		return -ENOIOCTLCMD;
+	if (!may_use_nsfs_ioctl(ioctl))
+		return -EPERM;
 
 	ns = get_proc_ns(file_inode(filp));
 	switch (ioctl) {
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 825f5865bfc5..c8e227a3f9e2 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -55,6 +55,8 @@ static __always_inline bool is_ns_init_id(const struct ns_common *ns)
 
 #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
 
+bool may_see_all_namespaces(void);
+
 static __always_inline __must_check int __ns_ref_active_read(const struct ns_common *ns)
 {
 	return atomic_read(&ns->__ns_ref_active);
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index bdc3c86231d3..3166c1fd844a 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -309,3 +309,9 @@ void __ns_ref_active_get(struct ns_common *ns)
 			return;
 	}
 }
+
+bool may_see_all_namespaces(void)
+{
+	return (task_active_pid_ns(current) == &init_pid_ns) &&
+	       ns_capable_noaudit(init_pid_ns.user_ns, CAP_SYS_ADMIN);
+}


