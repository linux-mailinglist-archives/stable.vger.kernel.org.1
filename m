Return-Path: <stable+bounces-5306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D18A80CA0B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F5191F210B6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B2E3BB2B;
	Mon, 11 Dec 2023 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Zv70NLWF"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB02BC
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:43:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUJEO+/lkoo59o/9yhPkcAE9TTnPoGy/6Vc8/cUboGYfTU7YkzTAETjS6nr7p8CA23JABMS2Gq4TUIcOGU18vm75yx/LTL7nFCTRwEW8+W/DZNoNBSB3YsbmCI7ee/3PoI4RVy24K2PZ+it8H4ocC13K3pUQo8ODum/MkAijW+yvoqjmGaaOmCb9kIwJA/zLOWpad42DIE1B2FhlPCxaBPjFIhspRvElGgY0RthwmGvYRe2Bw9NnNt4O/SzYpRChQfkhA+53pJznSPkJ3L1T19Xa5rC+gXSmQCDXJmjKxglsBS+/E+a3/PiWiP6/ZsPNTkEQ7fyKZ/kWSf/fHWhk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikLqf9fsf84KRClE+nmqXJMrE0F3tZUcUsTvYzPrwHQ=;
 b=gCxBlf0i6UvOMdZVUInrP0oUaU0rJQQ+ARpzZrByG2J8aJ/CdWRd/lUJqk0n8ZKSUvwKRMw0A/kTmKU/BPJzCUJVaff9NuUdNWYBczwyXMlCh4SJhaXCfvdssJZGC2MrfPRxFy7qLX9+tgeKSLiWPjqNO42oREYILvMqZX0qHM8tBeARwKPFlIkoxLqp+23eTNpiCXDarkZti3qDEz4twaTKNT0K0zRWyT7z/zHniWXrL9MJIfeBkHpNwOoj+bBeukwonzc1zjBBIMrl5zgrP4HDA8B1UYGnROU2Eq8rv9IIizbfuBCjDJiQz/ftALB70ZF2qVuXAqhEfvI8NMosAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikLqf9fsf84KRClE+nmqXJMrE0F3tZUcUsTvYzPrwHQ=;
 b=Zv70NLWFIfjD1IRZ0gM/j/IMWegs6y3YJSFyB//L1S6epgwlA07ljw33afkEwD+vxwqbn8EYO7z0CqprBMKOZWRAPz0YrmMH8yf65bWAwn6KiCph0dmTROxQ05dpSO78DEg6WUPtCL5NUkiZzthmvncGx1sTCfBdw+gUuyrVtwV6lOhYvw7Iz1bMuSD1mo27HwBYnaYm1v+0yyp7EP+RINeA4XQzdJh2vKnYdJYbnwN/v2Vm1hygsjrpvv2O3X8Ag72HWZYpPa+1yPqChCHXigvX34rpAv07h9RlhngFJrZYz79HeQVqeiVheGCz9cFRE2hZNTtjjWSHVgZkLIGhXw==
Received: from MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::9)
 by PH0PR12MB5482.namprd12.prod.outlook.com (2603:10b6:510:ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:43:07 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:115:cafe::95) by MW4P220CA0004.outlook.office365.com
 (2603:10b6:303:115::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 12:43:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 12:43:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:42:47 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:42:44 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 4.19 3/4] psample: Require 'CAP_NET_ADMIN' when joining "packets" group
Date: Mon, 11 Dec 2023 14:42:21 +0200
Message-ID: <20231211124222.822925-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211124222.822925-1-idosch@nvidia.com>
References: <20231211124222.822925-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH0PR12MB5482:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0c64a2-6ed2-4adf-e925-08dbfa46b9aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vFyA97fjTZi1KOI0L3Jmg5Hr0MLLgjv+s3obAdDrdiLxBBJi87tqIFjqdDUv+LyMwQhcBNyR2mrjK7Nba+yIiQQP2dNFW67RPaO7CeNaQRv7wQ8cB6JiVT4rPnbCoFKXYCBpr9nypwKp1K4OpgAo9cA3VlLZ0eBHpKF9M1p7WiF5oqRBOCl1hcV9GfJ9Qjz1DVZ4UBmU8eR7ohyN7DkCJDxQe327zCuaGabhF9HiFQfLRd0HfWx2pMVgbJXcNeVDIWYUGD9fQWiKLU0Ckoi227J4+zBIKBDip2EWVnFTKdgNaX1JaiwYrSrEsdPMHmpYvhmoXTPV15TJWzosw5cro8V3WdJ1dZVtaEdYKJ5TwJG8ctJLC7YGKjXXmOIRrhKkTMYpH8rxSoVdT2B6/mkV+AqlrPYapO4t09hBI6dxNa9BIvfA6JxvqvoFVLUkeKIHrvqxR/rCKGX/cAWZdawKqUyxIecfhbL8325OzKr1TATkwnVDpA6SQfZAplchUUy1zRb6oZxbkTVZoVMTS3N57y952YimK3q228sizLyv7MDLtLiyYff+KeZIDydUfMDlK9dGDDuQ8vt0FbQFwUBziq1xL5dleb7wC5fsAIbCjYh9XlRyG+73gCepbjAvLuIcyaOw+aycBhCLaL/cRu+wMfR9wMgNBPOxB4mY+SD3roUPeeR2mr4g/ol2gm8njGAOtYyXi9jdgIuKyZIoQtaaOcht8tEatnynclHSWWIonhNinscWCm/QP4Rs74ZwM5liwTyGkhpsl9bPgs/RBEab2jep4vArUZ4I9s0jbcfxJAs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(1076003)(426003)(336012)(107886003)(16526019)(26005)(2616005)(40460700003)(82740400003)(36756003)(86362001)(356005)(7636003)(83380400001)(7416002)(5660300002)(47076005)(6666004)(36860700001)(8936002)(8676002)(70206006)(70586007)(966005)(54906003)(316002)(6916009)(2906002)(41300700001)(4326008)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:43:07.1135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0c64a2-6ed2-4adf-e925-08dbfa46b9aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5482

commit 44ec98ea5ea9cfecd31a5c4cc124703cb5442832 upstream.

The "psample" generic netlink family notifies sampled packets over the
"packets" multicast group. This is problematic since by default generic
netlink allows non-root users to listen to these notifications.

Fix by marking the group with the 'GENL_UNS_ADMIN_PERM' flag. This will
prevent non-root users or root without the 'CAP_NET_ADMIN' capability
(in the user namespace owning the network namespace) from joining the
group.

Tested using [1].

Before:

 # capsh -- -c ./psample_repo
 # capsh --drop=cap_net_admin -- -c ./psample_repo

After:

 # capsh -- -c ./psample_repo
 # capsh --drop=cap_net_admin -- -c ./psample_repo
 Failed to join "packets" multicast group

[1]
 $ cat psample.c
 #include <stdio.h>
 #include <netlink/genl/ctrl.h>
 #include <netlink/genl/genl.h>
 #include <netlink/socket.h>

 int join_grp(struct nl_sock *sk, const char *grp_name)
 {
 	int grp, err;

 	grp = genl_ctrl_resolve_grp(sk, "psample", grp_name);
 	if (grp < 0) {
 		fprintf(stderr, "Failed to resolve \"%s\" multicast group\n",
 			grp_name);
 		return grp;
 	}

 	err = nl_socket_add_memberships(sk, grp, NFNLGRP_NONE);
 	if (err) {
 		fprintf(stderr, "Failed to join \"%s\" multicast group\n",
 			grp_name);
 		return err;
 	}

 	return 0;
 }

 int main(int argc, char **argv)
 {
 	struct nl_sock *sk;
 	int err;

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

 	err = join_grp(sk, "config");
 	if (err)
 		return err;

 	err = join_grp(sk, "packets");
 	if (err)
 		return err;

 	return 0;
 }
 $ gcc -I/usr/include/libnl3 -lnl-3 -lnl-genl-3 -o psample_repo psample.c

Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20231206213102.1824398-2-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/psample/psample.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/psample/psample.c b/net/psample/psample.c
index 30e8239bd774..196fbf674dc1 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -31,7 +31,8 @@ enum psample_nl_multicast_groups {
 
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
-	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
+	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
+				      .flags = GENL_UNS_ADMIN_PERM },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
-- 
2.40.1


