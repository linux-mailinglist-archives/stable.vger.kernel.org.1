Return-Path: <stable+bounces-256658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPcoNGXHGWoIzAgAu9opvQ
	(envelope-from <stable+bounces-256658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:05:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B10360616F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 371BE30A4E83
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A973F88BE;
	Fri, 29 May 2026 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERFH2rLP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972836655D
	for <stable@vger.kernel.org>; Fri, 29 May 2026 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073493; cv=none; b=rgUttSsE8e7IvA2cZjL2hZ9JrSF93ezM9SLBU7sqgRwGzbPXW2Uzdwt/VSVudK6AOTMIFgveOgGGlJDglipYSsw7VezjYhhq2n2AW4z28KydXqdlIbUTqKeEoxeLZfGGs2/mFG6Ss2D2z5ST5FMIPg1q3jTJYWTX3JzGYH+dsxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073493; c=relaxed/simple;
	bh=6b5dRqoAaT461qBAyEmh8qbOjQCxOORp477P7wsQ/mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKTN9vnR2BNpsSidsS8UhBcsL965c8ZUIY+9+6F4Tn79QXU3p8yNMb4tHN4DFZ5ccqpBSMSgN97jRL0yJ4Q62Phra0wOR5fcLXkUqMU+ETCl0iEcExZPcAlXy1erDhxL9S4CiH/gVISEUVOChoOcCdQ/6lMP6yyP6K/fItB0qo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERFH2rLP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BC71F00898;
	Fri, 29 May 2026 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780073489;
	bh=t8LAmgIPXeI7zqyZjyWpNMN2u6Lp/7csGjp2hL8UfNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ERFH2rLPpwBXoLx89acL4vIKdRjQqlhnbJMK7jkSRGjrcEm8tx1lqluorGDpiPja6
	 eLJWLRxNv/i597j3E8++ZP4sZaNC7jYUiZXDg5aWZr6568Lbq5VGB9/1TBAofSHutv
	 EhoYu8ViQ/hnaUXhLEX04ErM9BzaIs7A1Phrj85NxdAjYoaTn0w0iNFdugxrQuwYeO
	 7zDPgkrYgNccizZMdBupfmj0ylgQk0slSJPd4QRcMQzffpnZQNBH/arHqpuGcwoXw7
	 7zGg2X9C+lXDdnCKQXgvcK5Ro6LRjxeNAvh0nFqKUw7x3IR/uHUrL+GV0W9UfLhWue
	 ICCzeeGLiUolQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Mat Martineau <martineau@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] genetlink: Use internal flags for multicast groups
Date: Fri, 29 May 2026 12:51:26 -0400
Message-ID: <20260529165127.1228435-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052829-prewashed-duct-fb51@gregkh>
References: <2026052829-prewashed-duct-fb51@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256658-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6B10360616F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit cd4d7263d58ab98fd4dee876776e4da6c328faa3 ]

As explained in commit e03781879a0d ("drop_monitor: Require
'CAP_SYS_ADMIN' when joining "events" group"), the "flags" field in the
multicast group structure reuses uAPI flags despite the field not being
exposed to user space. This makes it impossible to extend its use
without adding new uAPI flags, which is inappropriate for internal
kernel checks.

Solve this by adding internal flags (i.e., "GENL_MCAST_*") and convert
the existing users to use them instead of the uAPI flags.

Tested using the reproducers in commit 44ec98ea5ea9 ("psample: Require
'CAP_NET_ADMIN' when joining "packets" group") and commit e03781879a0d
("drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group").

No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: d1ebfce2c1d1 ("smb: client: require net admin for CIFS SWN netlink")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/genetlink.h | 9 ++++++---
 net/core/drop_monitor.c | 2 +-
 net/mptcp/pm_netlink.c  | 2 +-
 net/netlink/genetlink.c | 4 ++--
 net/psample/psample.c   | 2 +-
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index e8c34aa4a640d..8e14e2ac9ba7f 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -8,16 +8,19 @@
 
 #define GENLMSG_DEFAULT_SIZE (NLMSG_DEFAULT_SIZE - GENL_HDRLEN)
 
+/* Binding to multicast group requires %CAP_NET_ADMIN */
+#define GENL_MCAST_CAP_NET_ADMIN	BIT(0)
+/* Binding to multicast group requires %CAP_SYS_ADMIN */
+#define GENL_MCAST_CAP_SYS_ADMIN	BIT(1)
+
 /**
  * struct genl_multicast_group - generic netlink multicast group
  * @name: name of the multicast group, names are per-family
- * @flags: GENL_* flags (%GENL_ADMIN_PERM or %GENL_UNS_ADMIN_PERM)
- * @cap_sys_admin: whether %CAP_SYS_ADMIN is required for binding
+ * @flags: GENL_MCAST_* flags
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
 	u8			flags;
-	u8			cap_sys_admin:1;
 };
 
 struct genl_split_ops;
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index fccda85ce8fe1..a3f73588fb6cf 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -183,7 +183,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", .cap_sys_admin = 1 },
+	{ .name = "events", .flags = GENL_MCAST_CAP_SYS_ADMIN, },
 };
 
 static void send_dm_alert(struct work_struct *work)
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4a5802126c8e4..4b3e18a9089e1 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1327,7 +1327,7 @@ bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
 static const struct genl_multicast_group mptcp_pm_mcgrps[] = {
 	[MPTCP_PM_CMD_GRP_OFFSET]	= { .name = MPTCP_PM_CMD_GRP_NAME, },
 	[MPTCP_PM_EV_GRP_OFFSET]        = { .name = MPTCP_PM_EV_GRP_NAME,
-					    .flags = GENL_UNS_ADMIN_PERM,
+					    .flags = GENL_MCAST_CAP_NET_ADMIN,
 					  },
 };
 
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index d6eee5140c8be..9825369505669 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1683,10 +1683,10 @@ static int genl_bind(struct net *net, int group)
 			continue;
 
 		grp = &family->mcgrps[i];
-		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
+		if ((grp->flags & GENL_MCAST_CAP_NET_ADMIN) &&
 		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
 			ret = -EPERM;
-		if (grp->cap_sys_admin &&
+		if ((grp->flags & GENL_MCAST_CAP_SYS_ADMIN) &&
 		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
 			ret = -EPERM;
 
diff --git a/net/psample/psample.c b/net/psample/psample.c
index c34e902855dbe..ddd211a151d0d 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -32,7 +32,7 @@ enum psample_nl_multicast_groups {
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
 	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
-				      .flags = GENL_UNS_ADMIN_PERM },
+				      .flags = GENL_MCAST_CAP_NET_ADMIN, },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
-- 
2.53.0


