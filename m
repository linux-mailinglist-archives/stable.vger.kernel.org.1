Return-Path: <stable+bounces-226896-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C1mDH+0uWnJMQIAu9opvQ
	(envelope-from <stable+bounces-226896-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:07:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D22B1FD6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F34D309B42E
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2742877CB;
	Tue, 17 Mar 2026 20:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMYb+Uon"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF891F1513
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 20:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777747; cv=none; b=YyE5L0Ev8AG163jYro0U6ye5tEid73Wo7SdRCM/DARRQv1lo9YirmkmosNh38mStNnH8xIW8/41elvdMFCLavYb/qbaSagR1Jx9Ivoy7ITSOz6RXBsDYKq/YMdyJrx9zgd9ZWTCkvpNlf0+L+cg3WxVnMUoOQy5B2J6o33lAHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777747; c=relaxed/simple;
	bh=sN4Vf2pDN7kgMLPMuV2gKMJzwX5GD30GCootex/qxVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a9ydPL47cCAXDTkshVEpTxpENvabfAE9qmLOG/mttWtUMoKmzBdpnDwb1Xeu9k6fSiQcH9WVou/iCxDUA+UDjxZ3CQoJOy8c7ONzCaienc2IJZTzZFBJegBWLF6zwZuHice6ncS1RXJdq/esjhx1Fnxy2tw83O5BKt7v5HZMjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMYb+Uon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE96C4CEF7;
	Tue, 17 Mar 2026 20:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773777746;
	bh=sN4Vf2pDN7kgMLPMuV2gKMJzwX5GD30GCootex/qxVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMYb+UonGxqQJPKdlzeWWDJIy0hBxoqoVInABZmrvTEGtqdQtVXZ6h1676WxdhCwX
	 3OaE3Leqa2p0yJeWSac5SCc1YEjeZHXtbpwkPWE56auK45bW7D6murnqJ5RJawELBz
	 lfj0Sdfvqv52CyU9vTv1izY/iY+080yFN+iwO/KtmvNbySGbUOf+L1IyblgxAPt60j
	 50SPiqkFrgwecsNsK7Yw3+oUZSCcVIsl6Giy6vnKEkzanEslCxtCKbC2MIgBMk5jKe
	 8hmWXR4H49RDe7marXDi6WrK+hK7JP0HY6dJaxjcklooUuMJih9ZFFV25XYphK34n6
	 ZUmk5Cvtka3VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] nsfs: tighten permission checks for ns iteration ioctls
Date: Tue, 17 Mar 2026 16:02:24 -0400
Message-ID: <20260317200224.272095-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031747-sweat-levitate-59b2@gregkh>
References: <2026031747-sweat-levitate-59b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226896-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F0D22B1FD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit e6b899f08066e744f89df16ceb782e06868bd148 ]

Even privileged services should not necessarily be able to see other
privileged service's namespaces so they can't leak information to each
other. Use may_see_all_namespaces() helper that centralizes this policy
until the nstree adapts.

Link: https://patch.msgid.link/20260226-work-visibility-fixes-v1-1-d2c2853313bd@kernel.org
Fixes: a1d220d9dafa ("nsfs: iterate through mount namespaces")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@kernel.org # v6.12+
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nsfs.c                 | 13 +++++++++++++
 include/linux/ns_common.h |  2 ++
 kernel/nscommon.c         |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 79b026a36fb62..f22c2a636e8f3 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -194,6 +194,17 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
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
@@ -209,6 +220,8 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 
 	if (!nsfs_ioctl_valid(ioctl))
 		return -ENOIOCTLCMD;
+	if (!may_use_nsfs_ioctl(ioctl))
+		return -EPERM;
 
 	ns = get_proc_ns(file_inode(filp));
 	switch (ioctl) {
diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 71a5e28344d11..f3c52904343e7 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -144,6 +144,8 @@ void __ns_common_free(struct ns_common *ns);
 
 #define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
 
+bool may_see_all_namespaces(void);
+
 static __always_inline __must_check bool __ns_ref_put(struct ns_common *ns)
 {
 	return refcount_dec_and_test(&ns->__ns_ref);
diff --git a/kernel/nscommon.c b/kernel/nscommon.c
index c1fb2bad6d729..22b5c5d0385f5 100644
--- a/kernel/nscommon.c
+++ b/kernel/nscommon.c
@@ -75,3 +75,9 @@ void __ns_common_free(struct ns_common *ns)
 {
 	proc_free_inum(ns->inum);
 }
+
+bool may_see_all_namespaces(void)
+{
+	return (task_active_pid_ns(current) == &init_pid_ns) &&
+	       ns_capable_noaudit(init_pid_ns.user_ns, CAP_SYS_ADMIN);
+}
-- 
2.51.0


