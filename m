Return-Path: <stable+bounces-5295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B2C80C9F9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30751C20FBB
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8F3B7B0;
	Mon, 11 Dec 2023 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KA0yTD1p"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD52A1
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:38:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyrvLcwMy7P7IjTfJYPeM6t8R9+WzFfxSTIlU+7L59529ho6Xq34min89TRuTiiTyNWKlBrje2P1AAc1qftThK2i9HmN5ZiunhXzjhU+zElNakdQLZORJEl+Rkrv4w0gv8KytAD3FYjVUubihA0zufeVeHDv4Pktjh1FY8ql0n5upjDtP3VQjSy8pOXQ3GFDDD60nwmR0bGN0Tr0vDD59XxL2kucz6Lc9CHeuZ40c9cMDlGJ+CrzvuZY1YKPhfgGMXR74XcV0thxAXKBwBrsbCSw0ruCdcHTz8BvKeN+AsPFpcYtwT24obkoZ0oYnRXNNXt2xYFYn7Q3Fx59NyAwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvGaOR2rrwbjxGKvcUgILj+J6bicF1r8ml8n8yiamJ4=;
 b=Do96CIbOB5qfYYXxS8nNSfyPEEORLbxThfxLo9GYSZU6tAgMmoFWhAqQlkobz+BMuEK+95TnbU19jthzLtFIEwEcaGB8aDYIUp2FD8+9PSiiAkAiyNl+JWodBnIVuOgTQpvnoUdqjQVqrwtn4ZzJ8qeBGvW6jQokjeoZYnL7CVaa9FGAWYOTrlqF2iuhqwdf+Y+TPR6vfg5yx8cjD+QhHhjdhWZTIwSsJTrUPG4O2rAB3xX1/bMIbGVH9i5mZiPXRZ+hvVA8aYbl9LUtS1yYK+Z6n52LQf2qyeEKBMP0ha97SgAe8bE6sOiSXLfZF0YDqLOn35ArExovo1i5h1pBFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvGaOR2rrwbjxGKvcUgILj+J6bicF1r8ml8n8yiamJ4=;
 b=KA0yTD1pai9qQLQ/fdOXcfxcz19P/StVb1UEySiJ8en1rU4WDAkqB7hLoowHjCdrKv5+Pqhz1iWD2Mb2DMaab/JK0tVlcVJ00l9Hbs/8GNRZ4fDnnuumgxCsZ73aFSreE/7kDk0flNUxkiIvqfBfHEZ3YyEory3ORc0WH2oO8B8inBMhKlAI2aJvyXzvITF1WoyVL1Bd2uwQtdr8JfwM5owTRmFflx9MytaMdmE1vB9ZNg0BkMgSIHy3rRtQg3AamxO8TE//CoY4tRbT/tW4JeEOgxqnujMKKqeqE0WCX4+APRcDO/gg/s56tNy/+E4gmc7rWM3y1OEF7CBDXCrKFw==
Received: from CYXPR02CA0014.namprd02.prod.outlook.com (2603:10b6:930:cf::20)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:38:56 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::1) by CYXPR02CA0014.outlook.office365.com
 (2603:10b6:930:cf::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 12:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:38:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:38:45 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:38:42 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 5.10 3/4] psample: Require 'CAP_NET_ADMIN' when joining "packets" group
Date: Mon, 11 Dec 2023 14:37:39 +0200
Message-ID: <20231211123740.822802-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2bd526-7bd8-4357-6224-08dbfa462430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h6tJBUsZx6TRVXUFYdoSw1339pR0KSbqeCqrLoUmnhT4GTGuDFm34eaKfcyTU3t7Rxyqh5WLLjmejNnpr6YCO/x8aqpS1jraL+9RWTd6LFWdznd3H0ZQR4dLfDzQUnXcb0wPV0H/d89hvDUpURvuf5mLijTQZsGdEObpHyp1sd9fN0rOjwzFFfIkEwkp/OAE5MtTJSq7Uv+u8YLBNXi7Lf0/g+zwHIh4wsEtAa4a0Xui9kYkU7irRVH8/FsJ9W3qjr97U4y6qT+HKkmlqiMJnzVrk3GUkKW5RjNTQjzp5/L5ktOwgZOBnI0PYRicbz2scywzEHlnXpVua3kpf3t6/tonhw45FjaV9G7vXvR7wa/lR8NOrxvqVkwzacD9NcGrLIT27KE5GI4CRN4CRWZRl9j9+lHoiKUd9VUXYXiFixayhMLqqjcmih7kS7vnYgOeIXu5FksjNcBU4XockGLf0ETF0sFraZHnFWvb/0Bkc3vN5IEEZHCYtFrQ0sLDhDWWREy6Wy5np3Os18SY/Oc3j8s6vmqREERoiONeGbCDHmn/zmWt15HaEAiWyX51GD98bb9fX8S5JBmAs52XY8IPsu66q1hTj8hfpCKbKZ6y3oGsErzmz+zNVGc2dmMyNfaYUmXThd0HyPNt63lcvpizEGsESQ8MZxvZqwmBuFmjpng4NPFFuF+/2rC3v4ogczc7rewNH2gmOENjKJ68Huf4+OC0LhhywYGb93hJjCYmlUsrH5q1wR/Q9aaHTyNu5nPZijukPRvRum3N+SWc5tit+yWlwCFO9GA8+iHr4UnhH6M=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(40460700003)(2906002)(7416002)(5660300002)(316002)(4326008)(8936002)(8676002)(6916009)(70586007)(54906003)(70206006)(7636003)(356005)(82740400003)(2616005)(36860700001)(86362001)(36756003)(47076005)(966005)(83380400001)(16526019)(426003)(26005)(6666004)(478600001)(107886003)(1076003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:38:56.3456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2bd526-7bd8-4357-6224-08dbfa462430
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123

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
index 482c07f2766b..5913da77c71d 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -30,7 +30,8 @@ enum psample_nl_multicast_groups {
 
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
-	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
+	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
+				      .flags = GENL_UNS_ADMIN_PERM },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
-- 
2.40.1


