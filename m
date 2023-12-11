Return-Path: <stable+bounces-5312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654CD80CA13
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19955281F32
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD433BB45;
	Mon, 11 Dec 2023 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rCJT55z1"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A49A1
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:43:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njeCcvFrG8GlxNR8X7f3Urv4CayPZymw40v1jKGGXIUtvL2HPkE8yLzIcB77Ua+gz7tUNz1/3KlQ3ILlwB4BfKfyz8NvruGrVjGn49rEstZFbhB+cKeWuerMFTr8iqHm5fwBXgejARqh/dLuVz/qBmHhMGU6s8k99oVRTJOK8zv63HAnC+dUs3gRY3BoPp4nIR01Nh8aPkAYDruFiGUKPJIzPYl+0cBuStaoeVXAdDe90u1jaHejeBmf2xmtYbVsxfCg10u+z3IPeR2QYu/WWdCSoLLKSxsoB/ApUu3jf7QpDZQP5akBtd5pyCJU2KOpUCD+A6J+vWiK0j/96OZAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yGLhzDBVfXJUICza7cASbkMdyB3ltyLaw8l4Kdkmg6w=;
 b=jG2QC/mPM6J9ftgpYNVgM7Lr7JLymFGd61xbisNeSpedbQ4iKyZvM3Z+fn5g7WspzpkB0gCV8Bmq7oOZgN410DAia4R8ew8yvIuvuadUrVc5K6B2OWILB972wiZvplDzbGvehf44FKSDzxBQy5XzzqTot9LlxZel4g2Ib33Z5ulknCqnXap88TEcU7KrD5roNJqZhv0QJN6xFsGRgSVcCfMu6DbVa6wLaAtH1WkFcLlVDkRXANF6wgDIKLFP0HTU3ifBHHMcYAX0DCrNurAhdVSE5RhxsPl03Oreo/beK4ZNz7hicW8YS/E1pvvYNhguJ/Ex963enqSSgpMHeZsgfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGLhzDBVfXJUICza7cASbkMdyB3ltyLaw8l4Kdkmg6w=;
 b=rCJT55z16LAyp8vqjmM+ipEKBmvnQHevttoNTrMLyrVOvR9Ed4aZ9cWu3VwqdCmrUfELCkGpTqB6T24VlhRwOeb3P0dD3SHuHUYISVsWVFDRdUPOEmfK/GwnZi/2WLeaaf9W3pMgdoUnLd1dlTXEDQgfLxdTK0KV+Hu6M5cX32X0QdBPKVHfcGXYi8gTzu4NVZrpTtQRBhHJOX+IajUC7VuGZ4BljNAxz9ZAQVNJfpfSOXSkPmTHRB2FT8O6KnGm2alqP+8bP5u/z6kHMms8qAfTdEg4ZDH5ueymIiwPfV7GUAMrDGyUDbZnsEKJFWzL7N7Wp64lBQI6D6vw4/Bv2Q==
Received: from MW4PR04CA0171.namprd04.prod.outlook.com (2603:10b6:303:85::26)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:43:47 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:303:85:cafe::6f) by MW4PR04CA0171.outlook.office365.com
 (2603:10b6:303:85::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 12:43:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 12:43:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:43:33 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:43:30 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 4.14 4/4] drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group
Date: Mon, 11 Dec 2023 14:43:01 +0200
Message-ID: <20231211124301.822961-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211124301.822961-1-idosch@nvidia.com>
References: <20231211124301.822961-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: c5945049-3020-44aa-ff79-08dbfa46d11f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AK5V118kmVGzQ4YlcRAmPnsKTHusB8zYeP9JVR0nYqnayiRuFdGHOyI39ryUCnYEpMQuICKZXBdyw1CtyGpvyKX4rfT9qUKp3VZrS37rGb1sKTIzNvU6WtsASkmV8BBEM3ys9aYebXaOiBMOQOZOi5RF55IRaS5l4lXmISTPKqTpjgqfE9+bzjpyvGJYP8W0RFcInBjxyrsIZ7JOZgFff97/bQUwgNemulv7yz3//oCcTQvL++wsAc3uaRsjdKB5cOkBUMUcMxMte9xhoarRSfYL8b6z3tJ4EDWM5FFCMF1Txa4+fvV3HfOs4tHHWi3iNTLinwA3Dy0VqvNxo26wYcjkd7Yx20PcyMiDSabkGdPzcFq61yG8bdtRoljvGn9xCf0TnvkaGcbRA5UZiqMtVeO2RWUvWB07sy/rpwA8MSxKTBeJRdV3ekmUfaVJV6p5ZxEGn2PkpGHIlHLoVpVO689hqTd6FxpG/80E9PmjAMcI8FIkx5+CYTEkYTlAomh0S2JjgqXPG9mY8lkK4g75km0AJ5LRM4oxQIFl2lX2TcW83YYpRVexmlS2IA1iFP8sbRbHkUSmaJsOnof8q6CyAFqncDD8lVTcWZc/ji1jJ6DR9KPV8svO7LO7PYnjHFPWimenJT+aQ07FkdN29jUKWUGeLHEp4JnHsUApINi/43tkIkPHglcGKw5Z4BqDBmlCOUhYqgAqpmPcDMW/U9J2wrJaqKYqmSKD2hu+9OaB7xtqUjPfsJZlU6LVSmsz+IDQbQ/sRQROFxHRtC2VsU6r0H+g0DMxdCYw6ywFOjlSNQs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(426003)(1076003)(26005)(16526019)(107886003)(2616005)(336012)(47076005)(6666004)(36860700001)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(966005)(70206006)(8936002)(70586007)(8676002)(316002)(54906003)(6916009)(82740400003)(7636003)(356005)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:43:46.4840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5945049-3020-44aa-ff79-08dbfa46d11f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843

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
index d9c4936c9941..08302fa8085b 100644
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
index 006b7d72aea7..9ca28e66fabf 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -122,7 +122,7 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 }
 
 static const struct genl_multicast_group dropmon_mcgrps[] = {
-	{ .name = "events", },
+	{ .name = "events", .cap_sys_admin = 1 },
 };
 
 static void send_dm_alert(struct work_struct *work)
@@ -370,10 +370,12 @@ static const struct genl_ops dropmon_ops[] = {
 	{
 		.cmd = NET_DM_CMD_START,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 	{
 		.cmd = NET_DM_CMD_STOP,
 		.doit = net_dm_cmd_trace,
+		.flags = GENL_ADMIN_PERM,
 	},
 };
 
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 366206078b11..acb04573ba1d 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -982,6 +982,9 @@ static int genl_bind(struct net *net, int group)
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


