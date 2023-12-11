Return-Path: <stable+bounces-5293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF14380C9F7
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4451F21069
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282273B7BB;
	Mon, 11 Dec 2023 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gozvrXjQ"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE6AA1
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:38:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccsu7FXtrXh0nny9BUp2OK+0X/EnZWxfo+vjlC+4II4fRZMNoF3dVm9bVuFCRhSxJLBZSZg1vz1rgyrhHWuAeP1R+6utDHi4v5ZNpEGV1Q5e46hI1Tv8t2RPeCBgQLBXblJ+WdWAumRNvH0j06gbILUX4ngZrFxdp3W6KSarLHZD1e4i3clKdwK2WENK2U253oeJjZsK8liHumVXfgFFBEUdsC+O2G7rvVK9t+ZDCkI+GtYDVzSllrRY8th3r47cbON58UBtUo168RJv6n3Uo9+MQCFn2Jwnk8cJkisNfMI2JA2A+67OfNFQWadWPJ95WSQH3QoTHTvJ5x54HvI0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiI9syoZFgVRUMAo+qHTpNe9iFtf0Z+5QAoPaZ1r4eQ=;
 b=QiwNlsZXOzhjHmS71BgTBHORbHVXbg/zw+Rai6dmcE9nmmy0W8NXacushne84gDa5Rc0vY4bRjp661xEUVlm7ipvA7kOLGoPs4cuKG6gxvJdU/2FoPyPxiq2Qq465FX/91BHaldujxYBjyOmfWeX8lGDqc/Gc72/w7GuMqh6J0XY/rk6TjTC889MUJABXKiFjl1hduXNs3lEmtcE/XtiD6BYzIImjoUhk3Ml7SRRQacgEtjjuV0CwXcJbpMJrSfvGkX45N9UpPegMAGo1r8eKNVRuyWh5g2yvFSETIbpY2r6WG6YRZxqFroT+DrPoMmmF1sF5QxG4WDjaKFSNOQ4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiI9syoZFgVRUMAo+qHTpNe9iFtf0Z+5QAoPaZ1r4eQ=;
 b=gozvrXjQntbztE9a1oKL9QkEI4uKsAtVPHL63hGfdSQ0+pEH2CsQcBuPgWtxk26JnBs/8gzLv/FI0VK0+oij0cI9g9SnKRNhFjYZdEy7JDtX/Vbvx9OnWU+gpFrHFgCnOEW/vB9apHpS0wAkHIGDMiH2uoKnDSui8k52XEx5zT9qWTwnmIMRNV9yNO5C7wh0QhMIDeUr5dmnNhIKrX6HCRh0B7BLjDgvGtB+jV51am0KdmKJkgllXJmTOyR87+0MJTs0XCdZBT3EnAp4pLvHc1JjVzIJl6AGRUt9gZkw/vZ55bNz5UAu3ZZtULeTZpMp5YWnMNVccdfJGokgWQ3jmQ==
Received: from CYXPR02CA0008.namprd02.prod.outlook.com (2603:10b6:930:cf::14)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:38:52 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::64) by CYXPR02CA0008.outlook.office365.com
 (2603:10b6:930:cf::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 12:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:38:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:38:42 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:38:38 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 5.10 2/4] genetlink: add CAP_NET_ADMIN test for multicast bind
Date: Mon, 11 Dec 2023 14:37:38 +0200
Message-ID: <20231211123740.822802-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 53047faa-5d56-42f2-e856-08dbfa46214a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ON89a0yMLyrh96XOWGpAG1UtGMlU0kqundP7sa7q6PafUJAHgeijU0fKbjjUpiU3HViYQNLhbLlDrQjo4aQeo/A1goRlj5Fbrnlk3tpZAoanvnH76jGtNDuJxA0Zk3L2ca8PthxpPvmnXGK2k7EZI0IMSVbki4HaG0Hz+EbBOUFZEri5Ioc9MNlAz5614z3qv0CgmtH9CArkBMrVonNKSXRSA1DQX0TexwjWLMCjfO1XHHdWBzhJIEIMycCTBq1jTe5/ZKi8Kl/PSgWwxBZhRycPJtWAMjUzPq/OQxzQ/z1Rmi+lUzUz2/ZGkuomLg3D4a9HB+78ZEm6Y/obixZJoF9Dv+4Hf/LDRoc16OzcOPYaLiBAJn2qOy7pSqd8JsXmK89pnPoGBv0vj3ZH0rNXklV9b5BGfq9U5c0mZGX2VLB61/S8HHYDwc2A7lY1wnV/Ttr4lmzvPmDuFTJdIY/AjV3MSg4xuZRuXog+Sspn3XT+eHJ3gLDXfUWhOA59bpIu6iEh1elQC0p0U5/Aj7XnBWWv7PTSrfEMzo2g+fmyxKD5eyIT3vhl5EqI77Npgd7B5td7mAEDevpy7Y8U1K1hrCK0XIuF6EzKj3p5YLRAgQSu2K/uRwrJ1dmFGkfUZnY9S5A0XgbymNTReoMXjApYLcbyFYFe2Q16FAdLA6Yq6Z6k4SX8hVmz13zHYsAXEIomFUtFBogEoXUYZ8pCF+iCs/aV0aYVf7tM8+mUVK2EsXpXw0FRCV80LFOFuv9lgNGSgla4bIZlpLwmNqd/shsY0Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(26005)(426003)(336012)(107886003)(16526019)(2616005)(40460700003)(82740400003)(6916009)(36756003)(7636003)(356005)(86362001)(47076005)(5660300002)(83380400001)(7416002)(36860700001)(316002)(70586007)(70206006)(8936002)(8676002)(54906003)(966005)(41300700001)(4326008)(2906002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:38:51.4862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53047faa-5d56-42f2-e856-08dbfa46214a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

This is a partial backport of upstream commit 4d54cc32112d ("mptcp:
avoid lock_fast usage in accept path"). It is only a partial backport
because the patch in the link below was erroneously squash-merged into
upstream commit 4d54cc32112d ("mptcp: avoid lock_fast usage in accept
path"). Below is the original patch description from Florian Westphal:

"
genetlink sets NL_CFG_F_NONROOT_RECV for its netlink socket so anyone can
subscribe to multicast messages.

rtnetlink doesn't allow this unconditionally,  rtnetlink_bind() restricts
bind requests to CAP_NET_ADMIN for a few groups.

This allows to set GENL_UNS_ADMIN_PERM flag on genl mcast groups to
mandate CAP_NET_ADMIN.

This will be used by the upcoming mptcp netlink event facility which
exposes the token (mptcp connection identifier) to userspace.
"

Link: https://lore.kernel.org/mptcp/20210213000001.379332-8-mathew.j.martineau@linux.intel.com/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/genetlink.h |  1 +
 net/netlink/genetlink.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index e55ec1597ce7..7cb3fa8310ed 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -14,6 +14,7 @@
  */
 struct genl_multicast_group {
 	char			name[GENL_NAMSIZ];
+	u8			flags;
 };
 
 struct genl_ops;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 9fd7ba01b9f8..4dce39013d75 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1364,11 +1364,43 @@ static struct genl_family genl_ctrl __ro_after_init = {
 	.netnsok = true,
 };
 
+static int genl_bind(struct net *net, int group)
+{
+	const struct genl_family *family;
+	unsigned int id;
+	int ret = 0;
+
+	genl_lock_all();
+
+	idr_for_each_entry(&genl_fam_idr, family, id) {
+		const struct genl_multicast_group *grp;
+		int i;
+
+		if (family->n_mcgrps == 0)
+			continue;
+
+		i = group - family->mcgrp_offset;
+		if (i < 0 || i >= family->n_mcgrps)
+			continue;
+
+		grp = &family->mcgrps[i];
+		if ((grp->flags & GENL_UNS_ADMIN_PERM) &&
+		    !ns_capable(net->user_ns, CAP_NET_ADMIN))
+			ret = -EPERM;
+
+		break;
+	}
+
+	genl_unlock_all();
+	return ret;
+}
+
 static int __net_init genl_pernet_init(struct net *net)
 {
 	struct netlink_kernel_cfg cfg = {
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
+		.bind		= genl_bind,
 	};
 
 	/* we'll bump the group number right afterwards */
-- 
2.40.1


