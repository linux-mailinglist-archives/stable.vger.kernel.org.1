Return-Path: <stable+bounces-6015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B508380D852
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F59F1F21B12
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66005102A;
	Mon, 11 Dec 2023 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RpPEkANg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D7FC06;
	Mon, 11 Dec 2023 18:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D418DC433C7;
	Mon, 11 Dec 2023 18:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320283;
	bh=p4ZCQ9QHKWRgKD0dGbS0N1rSqnJ71IDW6XY+PFeufMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RpPEkANg4yK44WrC0b6qhQIX4yTN7OUmyzgmIqq66HHe5UCUyaViDBYSjul+RS5yG
	 /eybGMcuEGvF3E0Ab0haN3zXdpEippwn++TFBGSyYEoAbaXc59U4RQqycWEdGA61N2
	 UTgMOAXp1hPaV2Ig/B+xsZnoStjihSCOvteLHMiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"The UKs National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 61/67] drop_monitor: Require CAP_SYS_ADMIN when joining "events" group
Date: Mon, 11 Dec 2023 19:22:45 +0100
Message-ID: <20231211182017.602080012@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182015.049134368@linuxfoundation.org>
References: <20231211182015.049134368@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@nvidia.com>

commit e03781879a0d524ce3126678d50a80484a513c4b upstream.

The "NET_DM" generic netlink family notifies drop locations over the
"events" multicast group. This is problematic since by default generic
netlink allows non-root users to listen to these notifications.

Fix by adding a new field to the generic netlink multicast group
structure that when set prevents non-root users or root without the
'CAP_SYS_ADMIN' capability (in the user namespace owning the network
namespace) from joining the group. Set this field for the "events"
group. Use 'CAP_SYS_ADMIN' rather than 'CAP_NET_ADMIN' because of the
nature of the information that is shared over this group.

Note that the capability check in this case will always be performed
against the initial user namespace since the family is not netns aware
and only operates in the initial network namespace.

A new field is added to the structure rather than using the "flags"
field because the existing field uses uAPI flags and it is inappropriate
to add a new uAPI flag for an internal kernel check. In net-next we can
rework the "flags" field to use internal flags and fold the new field
into it. But for now, in order to reduce the amount of changes, add a
new field.

Since the information can only be consumed by root, mark the control
plane operations that start and stop the tracing as root-only using the
'GENL_ADMIN_PERM' flag.

Tested using [1].

Before:

 # capsh -- -c ./dm_repo
 # capsh --drop=cap_sys_admin -- -c ./dm_repo

After:

 # capsh -- -c ./dm_repo
 # capsh --drop=cap_sys_admin -- -c ./dm_repo
 Failed to join "events" multicast group

[1]
 $ cat dm.c
 #include <stdio.h>
 #include <netlink/genl/ctrl.h>
 #include <netlink/genl/genl.h>
 #include <netlink/socket.h>

 int main(int argc, char **argv)
 {
 	struct nl_sock *sk;
 	int grp, err;

 	sk = nl_socket_alloc();
 	if (!sk) {
 		fprintf(stderr, "Failed to allocate socket\n");
 		return -1;
 	}

 	err = genl_connect(sk);
 	if (err) {
 		fprintf(stderr, "Failed to connect socket\n");
 		return err;
 	}

 	grp = genl_ctrl_resolve_grp(sk, "NET_DM", "events");
 	if (grp < 0) {
 		fprintf(stderr,
 			"Failed to resolve \"events\" multicast group\n");
 		return grp;
 	}

 	err = nl_socket_add_memberships(sk, grp, NFNLGRP_NONE);
 	if (err) {
 		fprintf(stderr, "Failed to join \"events\" multicast group\n");
 		return err;
 	}

 	return 0;
 }
 $ gcc -I/usr/include/libnl3 -lnl-3 -lnl-genl-3 -o dm_repo dm.c

Fixes: 9a8afc8d3962 ("Network Drop Monitor: Adding drop monitor implementation & Netlink protocol")
Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20231206213102.1824398-3-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/genetlink.h |    2 ++
 net/core/drop_monitor.c |    4 +++-
 net/netlink/genetlink.c |    3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -11,10 +11,12 @@
 /**
  * struct genl_multicast_group - generic netlink multicast group
  * @name: name of the multicast group, names are per-family
+ * @cap_sys_admin: whether %CAP_SYS_ADMIN is required for binding
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
 	u8			flags;
+	u8			cap_sys_admin:1;
 };
 
 struct genl_ops;
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -180,7 +180,7 @@ out:
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", },
+	{ .name = "events", .cap_sys_admin = 1 },
 };
 
 static void send_dm_alert(struct work_struct *work)
@@ -1539,11 +1539,13 @@ static const struct genl_ops dropmon_ops
 		.cmd = NET_DM_CMD_START,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_STOP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_CONFIG_GET,
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1012,6 +1012,9 @@ static int genl_bind(struct net *net, in
 		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
 		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
 			ret = -EPERM;
+		if (grp->cap_sys_admin &&
+		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
+			ret = -EPERM;
 
 		break;
 	}



