Return-Path: <stable+bounces-5311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C7280CA12
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459201F21554
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4573B7BE;
	Mon, 11 Dec 2023 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Exi0ydJw"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697DA8E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXxmMm6iy/Q587kT/g3clG8ijp6K3wbNwEYO7iyxfKAcwgngKYvikm7gCEdUtW1eqlnNqaGVrvA3InwDfPXXWAJ3HN8eSaI0qmL0JpPUSkgyAOnNVzSvipO33nyiGXnYpqPztBk1wsT/lZd8Xv0ChIQndjiFh21CUAj02tAAY0P4uy8hYlktX5W1SEz9PFIjZ14YZb1uYy4KU97zgMvcnJTmiTKFGE36rTAqPvs0M/rkaOx95DRD6kIQJsBak+/8eAKne43Iq85GOHDa9toi3MINgPTw8J44nDcB7eu5WQUnxkelSBcs2dQY3gRidAw0Rp/v/1rEm/FnLfCgccAccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikLqf9fsf84KRClE+nmqXJMrE0F3tZUcUsTvYzPrwHQ=;
 b=U93uLFzzC8bx5Q5YJXtebeDJUX/9tXz2UH+NMMoFpRdkl80ZSR96+tYdpDW6BBkYp9n1d2TocdIVKstKsRJ0zfcuXmGBxaPeFgrSd/gw0KQvY22Toec8dKxklF5E7oif6zF3R8fRH4G1Fr24vmDG81RTIak1LrTE3cOCehb7rzman+O0VFYlMPlX9tDJCZ05G58JHeOKiTf9VcMbt7SWXYChIYdvvDcpgTEiulqplrrSBwX5RpbrbEI7Q5vxM64IZUG/ynMhxBHanRy15F/cfksN0vrWII/xPp6o9YNYtTKRuz1QUXcZ1TQoEOC9GA5JjDyfGAd2b9198Hv3VA4aTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikLqf9fsf84KRClE+nmqXJMrE0F3tZUcUsTvYzPrwHQ=;
 b=Exi0ydJwEQmqoe8ofy4qFCiKQ/Ie4319OAobzPUoRGbsp3b3D3MltHCQ/9iXesqYW6HNcPvwni9zqtOiRPXj2THqsyBcyqEXcNw2mWhQHNXc4WcWiOUGqh3BxE0+2pzMDorx4dlQHsYsyAVfWdHyWIyNntwQMT0cy/v2pAjQP8S9pgZnY8lpyqH7nct7QsvU1PM64SVceKVcMw0EX8WQIhC34X42esd4ngkolfp11N2r02h7MERZEvl1aMKZR/rdcoIeWsYVEqvaYiG1/vjGW+d3k1l5VvvS1MCqTVFqrZlLBdTj+hZoCRWWYSNDcNU1xVtWwti1EoP2QFa9SUkCYQ==
Received: from MW4P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::20)
 by BL1PR12MB5254.namprd12.prod.outlook.com (2603:10b6:208:31e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 12:43:44 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::97) by MW4P223CA0015.outlook.office365.com
 (2603:10b6:303:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 12:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 12:43:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:43:30 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:43:27 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 4.14 3/4] psample: Require 'CAP_NET_ADMIN' when joining "packets" group
Date: Mon, 11 Dec 2023 14:43:00 +0200
Message-ID: <20231211124301.822961-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|BL1PR12MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: 559faacb-a553-4071-7200-08dbfa46cfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rWt2y/9ngHOO6mWsmlHbeRdSR0xSI4ESeJIwzM/y5q7x5OmO2vYymuXsmimx10tAScpeAvysdmGoGwj2YYg2qJ1xOy3nGqcmctdydgNDuoCOFNUP+WkPRm3DOiHFZUkMFO0oMKSBm15AGiHJjZR7IOxC4Mzde8M63s9SZVZGdVENwZPDqyieEva6ju75cQRlgHmOmSgjjwLLVE+Xj6RO3406y5wdKzqKZ3dehu/uYm8cOfduLp1WzyydOKIdS2ZjGvmMvALaMpRyXMv0mReetlcqtAuVlRf6QFuEamH5CSSL3pS87AXxUZFs3gcKlk3lv+CMejLhWi6Yjn6aB13/BLaayUNFMl3jt1r+7NPEWK4L1jE9zEb3fxh95ZGmPQRlQFq0S2zpHByN9HgEyukQZV3HxkYAaTaVXCaBcey0SiJyDqjevQr/NXqbNXTTxVz2cIEo4mCd706kirlhamjUhYZ1zhKsK2VW6k3wfW6JvoRHjdrjxEV9qA7rKFroF5uLmFzB8Oh1DK6RSYYneHcTPSQKJ4pP8H+i3kICcCUA15wlHpZnBD/7Yv1iSEJbLTHOS3SygAaDivZfs0D3FJtAQL3cn1SaByxPHUMuQleFW/OVGQjh15undBm8X+KC539eq3UrcbtlSl/d6Tq0FQ2hp5akQjgVN0S1LSx2P/bF8XfPWpckDSuSnGDMRS2NAlsKZ97JN3Tm2YPObmSgYpJ3kiU6waKHWRf1r/Wa84W+qwECF7b3DWYHzO80+s2mKs5QI7u/2VszD3sEZuhHxx+GE+Wh9TsWpRlxGC8TG+F7ZjU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(36756003)(966005)(2906002)(478600001)(6666004)(426003)(83380400001)(16526019)(26005)(336012)(1076003)(2616005)(107886003)(4326008)(8936002)(8676002)(5660300002)(7416002)(70206006)(54906003)(70586007)(6916009)(316002)(82740400003)(40480700001)(7636003)(356005)(86362001)(47076005)(41300700001)(40460700003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:43:44.2456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 559faacb-a553-4071-7200-08dbfa46cfca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254

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


