Return-Path: <stable+bounces-5296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF3B80C9FA
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11781B20E44
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DEE3B7B9;
	Mon, 11 Dec 2023 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DKGlRopP"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71651A9
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:39:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIJQP9B7PnIFO5gTTjfd5GmqBwL/+7ZKRSNbN1KxRshZESy5BZSi4cHI7+J4gRgLUVRXBvUHWUUxaokc8YrXFxMZ2KHJn4/FnTjf2TF1uNmcl1Ca3wRpIxlLH5a71vE6NzHy1L0z2xHGFsX/p7sIIsZLy1ZGMrmzwisi9DZAjtjCFKl/2+Wr4tnYaeBJ/Eo7MwypKoSY0xvijpYGCv6jW3tMEX+UdaecZYFRUFOyOtE7J8IJrCdl7q+JjqkXdXBU/EKoUYl6GS8vqEupqgenF4LY1xozwu6jYKaWm3OHea8H/nA+cLvgBCLAyFLBnoKjUGztJvybAl9BewpeuRS65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmetpAO8bKwvN9wrkHbiialoYKLqD5aPsIoHgFOFX8M=;
 b=b3RAD6TQeQLiixOycyBBtgp1taT4HNvkWz50NGHUwtFcftWqI/gl3NOdS2EJl2KiCNmNe9j/P5InUvbvNh6MBcuZ7jvHKWwGQGgR1sENg7kQcOrZQm7NGJCb5PMRoiTg17SwSBfajr/+frgqeWxWkVOZtxbp/M9+zm4RPo4iiqb+T2vTsPH1mVXkPtOzyyurCrJzKSaZHjElLGBTKsgRctwN75DZ7NKjjxJn41JcFQ5X6O2jcuYE/UvWpXN0hs14QsEBudJ5Ba2AWTCQSxev+4hcpCni7G8tkaAPPri2LdHO+bTGfi5HGs+DLhqFNHDAP9Cfa4VVQhk8doz4PygmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmetpAO8bKwvN9wrkHbiialoYKLqD5aPsIoHgFOFX8M=;
 b=DKGlRopPpf/K2YHGhTYiKzTXHITBRnnE+vScPD99F9v/DJ0SESpBsQkFnem+5VtPXb08EGKWngD1J3DJ/7IrachvrTvhlGDW68NrbeiRdDMeu6ukFbUVzpYKmzMqrZ2f8MaqXfS91TjZ+tuZVXmaqnqgtmf6S5qHHag18gtAg7hQ8yEbBRqYodvDiXHfVPZD1myNt3CrXqkqNUoc9C7l+PieFySVszxpWjnnXKS48J6l3r+P0poh6blzIw2iy2vwkHcxgPRTY1YxVQ08TqFayLihlJXMqEaGpMeR/+UvT/MHQsky4zOS06u3BghedAr2YRdyd3lPNo4x39A8J5+rxg==
Received: from CY8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::23)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:38:59 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::35) by CY8P220CA0033.outlook.office365.com
 (2603:10b6:930:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Mon, 11 Dec 2023 12:38:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:38:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:38:48 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:38:45 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 5.10 4/4] drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group
Date: Mon, 11 Dec 2023 14:37:40 +0200
Message-ID: <20231211123740.822802-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211123740.822802-1-idosch@nvidia.com>
References: <20231211123740.822802-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3156de4e-7f0d-43f0-b97a-08dbfa46259b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7EF9ZtdA90LezCCJOt60SajAx8sUJ8aH7j754R0aWSykTnVxVBxnJSICASWqiqj1s4DeLCPTvEojVirckuCvNauDzE85h4Cl3FFjcyOWn1Xx5Rk2aFyGIvPqld+WTZLFeohXiXXZqakBQmw3YjHWjjIJmoKmHb+t/FKEGzgSUf3AH4sVbffzVwNjo7aPILOlo3Z8s6iOU/Q64tMdqCUA70ndxacTHfdkwgMzGXqLGW7CI893yv5eK+y9bLc3kn90voQWqBcw+6G8fGSEmt7cDE5o9BwTMibRZW7crpdvmLdT6h8/woLOOUl7ihIlmZJwgQj7oJ1UvXenocw+c9UxJYqVBAGqhCX4pryns6dEt1aF3ZZUkuhFLrKhJWbBEqRvISE26UP95wS3SMqdEqMTYq6Q8sbV+uhCS/+tLOrmh6lWM+zZOyMtWoviytYu/MJYTwtKa2PpmijUdL4pEYGzxsiZ2vaVhpY4aelGS4Pq2/Q+KuDwRdGK9YtRhlDVnkNW4JEz9EAerCZcHzi+wSFZf8uQ7TAYq1WtXHAn/uYzA0zfXTSVkcxUAAKxo9rciIdhO/jyrGyDbHDb5v82q8NNA9Nz2f4njdAGEBCIJaCC/7wnPsQDDONmjrTZ5m0Ca7Bz2PmgJvhcKL36U0ED5b/oAPYO6slaMt7FZzELuxNUKNiV9w33uKr0mMgfIBX1/Dqydx0j6hVj1yHq3MZYObd/kTh4Uit1mkyonVzdvZS9Kfpafw44h95svxGD7drIf5LxwGxjHoV+JNdsbSxeTr/zZ+9+tfQHkR11fhJdWywSAZM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(2906002)(82740400003)(478600001)(356005)(41300700001)(7636003)(6916009)(70206006)(70586007)(54906003)(426003)(7416002)(40480700001)(966005)(316002)(6666004)(86362001)(4326008)(8936002)(8676002)(40460700003)(36756003)(1076003)(5660300002)(47076005)(36860700001)(107886003)(336012)(26005)(16526019)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:38:58.7580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3156de4e-7f0d-43f0-b97a-08dbfa46259b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

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
---
 include/net/genetlink.h | 2 ++
 net/core/drop_monitor.c | 4 +++-
 net/netlink/genetlink.c | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 7cb3fa8310ed..3057c8e6dcfe 100644
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
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index ed9dd17f9348..7742ee689141 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -183,7 +183,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", },
+	{ .name = "events", .cap_sys_admin = 1 },
 };
 
 static void send_dm_alert(struct work_struct *work)
@@ -1616,11 +1616,13 @@ static const struct genl_small_ops dropmon_ops[] = {
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
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 4dce39013d75..e9035de65546 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1387,6 +1387,9 @@ static int genl_bind(struct net *net, int group)
 		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
 		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
 			ret = -EPERM;
+		if (grp->cap_sys_admin &&
+		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
+			ret = -EPERM;
 
 		break;
 	}
-- 
2.40.1


