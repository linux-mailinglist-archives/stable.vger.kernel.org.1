Return-Path: <stable+bounces-5300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675E580CA04
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878DD1C210E3
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07083BB49;
	Mon, 11 Dec 2023 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LAaM6QEf"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA2BA1
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:42:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXALqKjRuc/qunLtDCrghsJCxkm9hMe3bn/fjm+cnYV5HD3lyhB01cWa3dYdqTZjx0DJvGizPzAhWvD2SEGPgYjXeh6SOIch6UodbwFVW8EZ6vbxm1ormNhikRRe6pTP+Y5r2zQT6TP+M8kTdmDvx1hGyshB8mHpySyJnFNVpEKqiE1mDlYoJrafXYXTRhsQUt3EJ+h4LL7SZSKCl26eKC/rqhNmWNnP2Pq3pi0afggWhNRLLffS+41P8TxSxbz60Hd0GzPPwSYPnIsgNM2D7Pgnt6HuDO186NWNLmHesp2QRMkU9z5U4QESqQgQSDw+jiEGyBKy5qbxMn1L58IYeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgPz89jdQgI3/3Z/MidE1YN8wdlU1kvwqrxeBCP2w0I=;
 b=AAQJ4KEHjvZEG0bw+zuUPan8NsCU/EfvR9BeTROQ/ueM3Nluz5cXGQmHljL/sWMEEklgcAQjFOhQKfeGCcKyb3TxAt07Ousgp24CQJS573Ot3GtG24/X//bz1wcSUExSAOr1YTXTjoJ79gHVB9PgNLeW6Yq/5QA8WjnuYVDeHEpTA6Bk3csvXyVsmDYdIHn+vBL/uKJFrobko6AnfYBCsQrQ2GmI+CTE6xqNmWh520eXpiBTKQtWdIgRegwicJVxzUtWexCPgU1KSPf2XmfroSSHj3cuQZbmHcVY/YkpJhJRdIrzI8SxXvaj0lfxJNv+WCZ7QlZ6Q/+uPkf/zO8FkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgPz89jdQgI3/3Z/MidE1YN8wdlU1kvwqrxeBCP2w0I=;
 b=LAaM6QEfTo+fJ1BcdQ8KMDWFLLNeQERI9RzypVbmTcBWDZ2Rp+HpauSZIve8ajrUR29vparaDCw2eGqPuWyHczop6I+aXqRZ7W0uMjsdO44NgsAAyeYpR4MkrJ0M4JYpo5FagUsGT6XDDy8d5KTiBYmFLDw/fqq82/n2jlKh2LDHm9BulXLdoXOxha6veSUEFaydx45IfRv3eX2uesIJ7Ry1N0b/+HofjjQpn3gxyR7NUoNtzWXgx8a98e/1sbTgdNE1lyYP4IzTvKrLlJvLiAINUa8sdYNJXxS9M3KKToz2fSQMqdnYRKQ4M5TTT43xv9cR08ydTUeV5U96Mf7a7Q==
Received: from MN2PR15CA0043.namprd15.prod.outlook.com (2603:10b6:208:237::12)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:42:13 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::d) by MN2PR15CA0043.outlook.office365.com
 (2603:10b6:208:237::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 12:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:42:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:41:59 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:41:56 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 5.4 2/4] genetlink: add CAP_NET_ADMIN test for multicast bind
Date: Mon, 11 Dec 2023 14:41:31 +0200
Message-ID: <20231211124133.822891-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: e91c23f2-67e1-46c2-cdc6-08dbfa4698f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uyyx+Z74q1b3V13wLVn2mHR0hXStBE26z+p3JMtl/g8GVPtgZXkfPEcQax5RZbPLH96Ky/0z4H7WHMBog8kN2VYrp/TyaMr3jggGFB/E/i1obhpeBXagW6ws/fv2Ob7x1nCreusWdo8R4m+dDze5FAX/X4hJinxmVIx72VqnzFL++gQCIcEsCFQmKvQT1PLKG6VrQwykZHetWANvuuuMOUKr6moU6Eqe2fYphvUwwUy4M/Lhmm+s1/5X9rPlbFJn7ojRHnroFyLi2EX35t1r5+k8oalPi+1v64IzzrrExZpL2uEbtT2PB7s4xlCDlKQcx4xuE3Wp0Io+/5dySjsvZEJW9jfER6pP/sX8Eo8y/XdATL4QvKUa41ZIz1isLMxektPR5qgwRXq/pN0sGKPgJ4wLgQ5YuWoxs3bPOaQ00GwVKl3BRXWSklBPOYRyMlRF0y3Z71T5K2oD+IVezvlCPiEkfZtD3IF1uZpg+oIhjBNxhPXXhK3TImTLFmwZFE3L3mT0Q++Kr5+0TqoRBvTwvWcLwLhJK9hWKke0pe4Ju1LqcbrCw2cwcdkAVsAoyV6L5HObES3nnlLC8mhKjID8JCFVmrz4m8dJ3kw/FV+kmCVLeytu/wX8lMf/QLCQ4+B9nfahwtGAYwgk3TT1WN89qKU8NKnmfNzbXJCt+kZpL+Ziqc8FgkCYAAtCwIJaiozlKy4lHoI56AO8IHAIii/TuKgqKoYGHm8YQEFV89RFZxFx48mkyXwWJELGkUjKZ4oEVEeuyTr5RL9Im20sNoEVsA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(26005)(426003)(336012)(107886003)(16526019)(2616005)(40460700003)(82740400003)(6916009)(36756003)(7636003)(356005)(86362001)(47076005)(5660300002)(83380400001)(7416002)(6666004)(36860700001)(316002)(70586007)(70206006)(8936002)(8676002)(54906003)(966005)(41300700001)(4326008)(2906002)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:42:12.2017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91c23f2-67e1-46c2-cdc6-08dbfa4698f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033

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
index 2d9e67a69cbe..a8c9c8d1eb51 100644
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
index 102b8d6b5612..34e3c8eb5911 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -989,11 +989,43 @@ static struct genl_family genl_ctrl __ro_after_init = {
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


