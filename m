Return-Path: <stable+bounces-226928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFlfBs/luWmGPQIAu9opvQ
	(envelope-from <stable+bounces-226928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:37:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 889922B4669
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 00:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E171B302B4E6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46673372ECB;
	Tue, 17 Mar 2026 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQspB3S+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD55311C15
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790667; cv=none; b=Qa8AmbEaO+19731XyGVUtzy1GS/fwsG4UFKKI8fUx8cRyfQUG1e0VmIyVgzmwZTUvoPdbbUrvUv3rTC0fLIgfoVVOIRkHmEEA6s7taItPUa2akhfRlToln9Y/MsTvYIkRQlVznVu49Ow2xRuckIodg0gl6yHngEvgoWmLWxnx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790667; c=relaxed/simple;
	bh=ImKA+jy82DV6WhScJyAuoDzG6c4+lAtr+rqzuAp/HCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+hgSqixZj/pObS20CwEgl2Gk3iGUefpogTrrXMo2a9TNAzsGYcO99NiP8D5pNmsIEeyjc9xkNk9w61UrlDOO5rm6iyKg7jd6qPQA2g6QtOHZLrxV4xxyiZqJLvLIp3tj6rcR+YZqdSfrytFafOS6Vi3rdz1hiFWzev5niRl/kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQspB3S+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9B3C4CEF7;
	Tue, 17 Mar 2026 23:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773790666;
	bh=ImKA+jy82DV6WhScJyAuoDzG6c4+lAtr+rqzuAp/HCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQspB3S+ef1kSk6TjXEMHFTBgjxFE7TWCH+fzhfGqazNnXWF4nQhJqqI7g0Yq6Mie
	 0N/bIbXnblq1ML/5IHtRHl4J+oDVMMKTpBGxyHzRNTff0/R20N4GgOoMRfszN+/+89
	 +faEItEicJODs0DLG45cFQi90rEcuH131wO5tsT5p0obH8WITW5mTPgm0Wv4baZ2rN
	 fPBUgMOCZ4pE1cjcLTYVx7crlQuOCyH1VFHuQJ0ZE2msw4gY9IiEZw0BkyLzLomzYL
	 rEQeuzkm3KHFjRvkdHEOY0q6kx6MfPkI2ygoTxJnh3sMssQgjWLxnFkz2XQ16rDDBN
	 YtClPoL1F+ZTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nsfs: tighten permission checks for ns iteration ioctls
Date: Tue, 17 Mar 2026 19:37:44 -0400
Message-ID: <20260317233744.360057-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031747-sixth-replay-81e6@gregkh>
References: <2026031747-sixth-replay-81e6@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226928-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 889922B4669
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
[ Different file names ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nsfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index c675fc40ce2dc..0f4b0fed9265f 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -12,6 +12,7 @@
 #include <linux/user_namespace.h>
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
+#include <linux/capability.h>
 #include <linux/mnt_namespace.h>
 
 #include "mount.h"
@@ -152,6 +153,23 @@ static int copy_ns_info_to_user(const struct mnt_namespace *mnt_ns,
 	return 0;
 }
 
+static bool may_see_all_namespaces(void)
+{
+	return (task_active_pid_ns(current) == &init_pid_ns) &&
+	       ns_capable_noaudit(init_pid_ns.user_ns, CAP_SYS_ADMIN);
+}
+
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
@@ -165,6 +183,9 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 	uid_t uid;
 	int ret;
 
+	if (!may_use_nsfs_ioctl(ioctl))
+		return -EPERM;
+
 	switch (ioctl) {
 	case NS_GET_USERNS:
 		return open_related_ns(ns, ns_get_owner);
-- 
2.51.0


