Return-Path: <stable+bounces-5305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4553180CA0A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C7F1C20F8E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2DC3B7BE;
	Mon, 11 Dec 2023 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="al/5o2Mj"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0731C8E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:43:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1dRkKdAyCBERWEKbQKvKLA+eqo2XBi+PX8DvuCcNIBwcP2hAxMcqvnYSUOUS4koBmoIgdBGb6GKbPPQCMwGdAFO+VbTRgWyH9zCZZClFvEvw+0F5d7dRNlxfkGZJEd36oFoi14v18vZHZlFX7ezaPIbZQtouUhGjjVMVsPOcBMfaxNXytZiGjXMPU54mttAfvzSOSaMS4KYXnpvL304kUaTzytumafyeQUgdYWn2mFvkU6vVAsGjSO61gcVQn/WtZ+AvdoN9fmqpUfpDZWoHLGd4s3qoXz7OKtKTVpVz1rlR4nwG+1lbbpftBNLeKIFfdicdKeY3ddhzNbYg4F5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3UYdROB5wHSU5BU/O3lI8lgc+9ULtfKf9w3U/y57kQ=;
 b=Vu0e5eNGZXfVA/CobtuCL/lUpX4vxkLLtCBWa1Ocg1vhZaEzbWDGRLfLdEeNmMYiME8fnXQrVlYZwsbj+hfSOPIAuN6Se/13oe2j2XtCKkKOMVkMZ2rm2iDKBZ/VfSsSoOnuam5d00e/RSreTV/5LgHDcxEzp08/N3T+wJ+jQ1H4IrPZAE3FLRmWMDkgKjEERVxG3yqNOKtN+4JUb1iHCMpSig6zcKX+vh7sejS8aZNrOAFRS9vhjA6IPT5cyndKe2WHc79KcPk5+eoguKNq7CP14skzre5euAxhYdgjCdRkdvqRgLzjfQsy4pOE874c7k3xkBa3/eNIBM9fsDazeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3UYdROB5wHSU5BU/O3lI8lgc+9ULtfKf9w3U/y57kQ=;
 b=al/5o2MjSpVOROK3CtmhJdTzT8UdAcf3a1LVCPA+UhyvRdelETqJlpXWL7BhcG8GoP0S+hUmJ8qSuv1+sTiSw0niH1VLiYjZuGPfkj3EWrMa2tO9TFefMOv78X5odsgsM2sT7OkuDjGxI3yi5Wbwp1z6/1ZQ+U6UbCfIVO12LWJto2c3VXdEZMXMA1qRfZiCgAtAHCr0i+xyjA4SmtXMyqX4g3nw58poMjO7q/8n/jvch2gqWxMXIUJhY9Yt1csiGbq6H4tZW88jgIZf1b9zcRS9v7HD4aN9Cf2wZQZPs/dPwWe0b/pIVMi3bNuf7stAbXxxDiv/3wtkBKIffxeg4Q==
Received: from MN2PR01CA0063.prod.exchangelabs.com (2603:10b6:208:23f::32) by
 SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:43:05 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::3d) by MN2PR01CA0063.outlook.office365.com
 (2603:10b6:208:23f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 12:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:43:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:42:44 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:42:41 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 4.19 2/4] genetlink: add CAP_NET_ADMIN test for multicast bind
Date: Mon, 11 Dec 2023 14:42:20 +0200
Message-ID: <20231211124222.822925-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: d3458dea-3543-4e5c-7599-08dbfa46b81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pIDREVB5x881IyK9BnvPGpxI6KiLRKgwTBLAClyT7oQyrjQaq26oqyHRBdSjYaq0TkguSTfRPdzEpkVfNCrxQOFsarQxo7YAN62ikyfKdakgr5xkhc3z64+f8bJsdCbviodfVqtIV8p+lYnJMLyLDOl9ZGRNWtfVPImk3GwBXgSjynnaD6TSGTvFNM1eU9pagta9EoRzAOCQOTSTZ02c6PmuV3EF9gtOMm4IuR5QLmZfZ0P9GCmRXgbajgsxkD4phtMMIPm/M3LAcjSYLxhwctp0OvXtIA+srmgJbUgl2iBLo+6PwvFaIc/QBePeljE7PuYLxw4xNo4BJrGbrMu3VCSa+RRMUSUJL7vfPKb7XYJuA/xr03fJE/3ApsRuRLwfZ3WPZfu5qgIN4j0b+nBpslFI5lGEdo7rccR83bU+/PKFRwsbmQwZSKac/TObDp87aN4K+Jm/BIn2/I2BjPqkR3XNFs6jcF+tP2a/iYxNmcdsZ+XUu7igVfcZSctnSfcaxpy+CCNTp86OUxiHq0HyvxB4kP+OPZXU7KDq7JheJ88jnfbspdraMsDTF7zcQ6Z6K5bbbeK1g+Gb1fVyZhqNLj85dfYewzMwWd4VmOAPKxVrlrup0pc+d0yKGVCF9VHwVIvUNoRKiCYt+SSi3xUNBQt9KfjAmLws7xzmN6WtsTFgyT8tnndJESDAAqsw7kKhxiLawdDmWudaiUbB/Y8wjv/nagfBHpIk5PgiQ3OIxcFIqOG+0gFuWxSCeQNppG7FEXURYaDm3JIVl3ZdykU8aQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(7416002)(6666004)(2906002)(54906003)(70206006)(6916009)(7636003)(356005)(86362001)(36756003)(8936002)(4326008)(8676002)(316002)(5660300002)(40480700001)(70586007)(966005)(478600001)(40460700003)(41300700001)(36860700001)(107886003)(82740400003)(47076005)(2616005)(26005)(336012)(426003)(1076003)(83380400001)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:43:04.4422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3458dea-3543-4e5c-7599-08dbfa46b81a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146

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
index 3e3a1a38884a..5a1539aa963d 100644
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
index ede73ecfb1f5..2f4c2b35a386 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -961,11 +961,43 @@ static struct genl_family genl_ctrl __ro_after_init = {
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


