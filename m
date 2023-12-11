Return-Path: <stable+bounces-5301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAAA80CA06
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB1D281D50
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD823B7BC;
	Mon, 11 Dec 2023 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cem8pGQe"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2088.outbound.protection.outlook.com [40.107.212.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B768E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:42:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+4u2Xibg7ur03n2tFkNFlizRVXaYSraBJE2XMwLLrf8oOtBUmVkx+D/URvEcrWSPUJZkCfHSnQu7L+DsZ1zLev2PkCK2DiHii6ynh9EdDUq1iHNsj34aZUyEp53fp2zU7ucDDEscIPwzRShe8dcC+etm4XzmtYbKYFkNwawvvMMx1Pba3yLJUI5VYxa3COKDQTciK7q/wN1WloeZb4Y4m6bUH/bCsGKhHmlbHxod2Rk4K23Kl+1j63T/ni1QpfiEHtxoF7xgCCmY4/Zd+oH5a/taNTTozhvHj8lG4kPVzQk8hFGJAM35uKsMO5ZXC52RprC/47ncRWaOFqcx4CPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFzDbRu6Pfy7y9AxaLWGqadfTlc2sM01f7HDKzEILSk=;
 b=OcZ2ryvVCoaGRindsDf+BLtr2OCrZxFXdGVpFvj6gjAOc1YRuYCqpAu++gAwUKau6mMhMgvUIYGLbtMa8EqcjMZ23hfYpY8eKobXqUkLO7yYI8E+oXkhHQ2OtTbLs3fZGa65qrOoXCz0y+TVkcUDVhpYFcgN1BLKcc7zVqH9BP98ZjiWS0BfPhjC90pBQjwuY9iI9a6TN6ekh0M1o8WNHR+xRHlReMqRpLxhOjYBNWLyHElTbKhmTtZlS7JGUeuIHLV2wqanvsm8CZOopoQAMgF0KKx0EgBi7ycwCas0a2hsSxu2kvb7yfXR6CxlNIR9ImSIDiBIKVSPvXI6F3nfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFzDbRu6Pfy7y9AxaLWGqadfTlc2sM01f7HDKzEILSk=;
 b=Cem8pGQefvpuHhPBQrtb4Rq65ImZrF7Er9zAXfFvAMahPnKSTt8ope2P18q/RQvbKdE3D8zX3V83Ggc5QKYMlJyCImRghHAB92T9J4yueNX34U7+SPoyneeHelxUzjmkpWOR0OfaAnYCCvjlCCXFE6gehdRTio97XH8LIXOnWcWz+0ctWD890CHqbYu5czYMFXBPVMYFppl0t4vxlW1eUfIAydneyhCx+3zBio216PSVBvkiebtChTc5ULH9nq89I57fMUbyZqLT5PZWqsUCgzz4QUPI5F92yctvAsh1w0VaEtgAUrV/HES/SNf/F9Wg1pu0cCCkWCLgDo7fVE87Nw==
Received: from MW2PR16CA0004.namprd16.prod.outlook.com (2603:10b6:907::17) by
 IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 12:42:16 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::f4) by MW2PR16CA0004.outlook.office365.com
 (2603:10b6:907::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 12:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 12:42:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:42:02 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:41:59 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 5.4 3/4] psample: Require 'CAP_NET_ADMIN' when joining "packets" group
Date: Mon, 11 Dec 2023 14:41:32 +0200
Message-ID: <20231211124133.822891-4-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211124133.822891-1-idosch@nvidia.com>
References: <20231211124133.822891-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe25c3b-54e0-495b-dbd1-08dbfa469b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Dp1d+dWPj3lfYh7d1f6ZwytjZDoVAqr87no3XuR4O8xInd0zkuvkE+grz9J3xls2BD8pisItvKhH7PI13/Vn6j8lE7owE6Yj7CoOTqsMN8iNsm6wiOuyc89T5egsP+RcsFIjUhHik2Q6ztrGzO/gEx6b1tBp2I8/xqxxgiE1MnjIFhSrKXu7sSVIxaGtPu9i1Ufwo3/x5TZkd450rovemc1rSlhDoQRdFlijp1U0/yu8iWE/byjGS21chywYpaVIYIzkiDUARvY7Z4Ld36yxY2HiRu6AGHSt5kACwdrY6TbrwEoPRX31UoUQd3kBuBc8xD/isEE7lbGk9QcK4KDA4itgmKAXSykQBAs150FJi6HKL3oL9GSVPR0wqWEzuBNKK6dcng6n90oVKTBb/PQk49ftut/LDsdPfCYXtUmczK6CMao0XCH0Ks0PVZs4mR/HUfYb1P6RKG4YO2l7Oolax86IJHboLOakyvqGg3Hrd7PUOqlbhifKpcD9jmf1Onj6n772s7Hn8fIu/ft3wdAGiCZVaPqws80wN+phwbS8p6hixVgFVzdMZEOZpLEqxnFVJlSb9RwJzcTk6kBz/0deBj98JuARmFniN2lYcpF6+oNMDlrI7kROI8HqhM5qLOqORwFvtkUrsufmErP2oUGWcy6owhPXRo1kO7/2figOZXSBj5o8VPvsdeQU8Ubg5T77ReX2etN5Tei0OH1yawdyue/d2FZKOVAHWLjAQuC+PNNVRIdmc3jWvAtY6oOoTYvvYTSzaIl7zjE4k76kLlDbJqM5L4SvzyfFToCYOl5fdAo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(41300700001)(36860700001)(107886003)(16526019)(426003)(336012)(26005)(2616005)(1076003)(83380400001)(47076005)(82740400003)(36756003)(86362001)(7636003)(356005)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(6666004)(54906003)(6916009)(70206006)(70586007)(478600001)(966005)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:42:16.1261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe25c3b-54e0-495b-dbd1-08dbfa469b46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087

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
index 6f2fbc6b9eb2..6d29983cbd07 100644
--- a/net/psample/psample.c
+++ b/net/psample/psample.c
@@ -28,7 +28,8 @@ enum psample_nl_multicast_groups {
 
 static const struct genl_multicast_group psample_nl_mcgrps[] = {
 	[PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
-	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
+	[PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
+				      .flags = GENL_UNS_ADMIN_PERM },
 };
 
 static struct genl_family psample_nl_family __ro_after_init;
-- 
2.40.1


