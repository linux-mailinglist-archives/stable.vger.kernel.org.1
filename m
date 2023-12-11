Return-Path: <stable+bounces-5310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E280CA10
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F9F41C21286
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E4D3BB42;
	Mon, 11 Dec 2023 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nAk88ZtJ"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84CF8E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:43:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKFMo6FDyAKa/O5YMKVFpDUE9SX8dTuVRW05yu/avSwNUNy3ZDkOezPtL1fY55vWcX+gQX+bbT/cRh25GkT7kjK6PupBgpJ79JcXm6IsKh85eVqaFtVff0SZ0LLfKyE3Z0zN0q5FLN5uN+BmK3cS5ZnHCgb5Hl2p49jZQEOesxB5eo9vIAMBoXyKNT5FeF6JjfI0edfd2beHpRt0SBNQgG9UWfYnjnhQ/OCe90PSMGkTWamCAQinPFaHjna6ansT8XsKZZFMeehCKvfQi1d/XFrqqaSooQwvzacBZTahVlg8L+L7NGlV3Izc4CS1puSbHw0Klc17vLy0tPZPxaNA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG2eGZO5KYVUbjKeabYaw4X0ulHYZyBSHLLE0I2lgDo=;
 b=SYk2CoR9JmUFxY+cUuXgYOVPZp31qYrNf0E0L5Ux0OB/pBb/fRw7r5jUxA7I6D7Kw7ktyIgreKIS6VPz2j+6s3hwTejcKC0scLSJ8iIlumUuDwea8BH1P73IkQMlJA9aJ72zyoxli1m/F6fBMyvhbnbSCillKVr5vbHXr4zhbafIuuqahnDHN7hv8mgKvqbP+J6qKkNSseJEtDqRSYKhS8KtyxsWgZMPhvHI4lIGNUS0eO6F9J1q3IRCwJ+uwlnuqTnSU6yDEelTb7QMsKKY08tjgffrgjjt9OJ2yYAevmoI8wK0FZJ2u5Yls/a1NC153FB8yftT+TEbQ6Zr2KptAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG2eGZO5KYVUbjKeabYaw4X0ulHYZyBSHLLE0I2lgDo=;
 b=nAk88ZtJ7h17lEgpf7+Zv4nbKBmQ2OWt8kpslcJcHS7/oVPM4CyK3b66+/wqUK4Gc98l85bG41SBDupsh+tMtP7UyuM4FWaHwPFWFWVL9rjlD2bwjheGRXs1/DhvpC2FbAmz9hAhTEn6mNGAqUuxV3bmeekNIqf02qftJKVqly9lQDPFrzAfZkKGIExuVCNvUIflxPIFK5V3FEuDUrYCgFI32GnKhT2lcyQ8VCBMe+pONHVprW1N46/z6mc/eINrWald47KhfhPUVk7TxaxUfaclW95ZQ/dQHaZTJ0Ew9P3wVumL+pXhwWkKJzWgeY77B7CCizrJc4rI1zsfR2rcBQ==
Received: from MN2PR15CA0051.namprd15.prod.outlook.com (2603:10b6:208:237::20)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:43:41 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:237:cafe::48) by MN2PR15CA0051.outlook.office365.com
 (2603:10b6:208:237::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 12:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:43:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:43:27 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:43:24 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 4.14 2/4] genetlink: add CAP_NET_ADMIN test for multicast bind
Date: Mon, 11 Dec 2023 14:42:59 +0200
Message-ID: <20231211124301.822961-3-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 586c8c78-490a-48cb-ff03-08dbfa46cdc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yh6UvIH6dj8NGQQK0D7p8GABkhkC96pPEcnFIk98dl9fdJNeNqoMdq96XPJZY4dSZWrJ2XBHmDHac6r7vrZ8p5qfLRMbWW1S+4rEn8gO0EO5GnNICPq3YNfKQ/DqqAesbDmsi9Z/woGT+G76z4Kw7IOLQHjjAddTWFEYwSlrk6LjWsNJxqzqt6+ORRl+TXhbygc4+9yOQsJzn+yNZSzTM3Xmmtw8AntCn0cuRM1UvmnZdcaLuGQZ+IUI0ozQCEbMZ776gVfDw5S+zFfT3vPs4Hbkd3CIeeTT+II1Pbyw7PBblPqljDB434jrmAAzDT359GXFtmjw2acZMSHrZBQbJhMIzfFvcNXtyLVKO9yUt0ROKi67dwKf3ORSYe6mR96seLOO8bbAk8Qe6BrRY4Nc/OHMvYgx4J9rVRWPcZpiGASslNtAsWulMF6SIu1oLZUGOIeDl7gFg4WugwLX1MUbMz5dPpto/MP7JifYB0zbnG1XESnJcx6QkiF7zMlq375L/TN07MF32qIvg+T0ss4O6ico32SqLjU7yY8fLdWkgUNIyheJhxYx1fYSB9FmFQx+aLhEYaA0Xe3A62FqRl7CQ3Dfp5lxpNwOY1Fme5ZfX0G3hxVbzRdXJVXx4y6w5bNFXoDRiaq7bqbBM3YLtiqg44FHJ1zOhxr8huPsCR6IueIbnjBW1Gw2a3tt/6rEMSrCvBeFCe3DYCWDnD4WxWJrniVJqztF2MT80jxPTER2mQxpkEIOwCn+6JLQ/U5w1ZOU2rhjeXfVmy5eC1SvOBFyog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(2906002)(82740400003)(478600001)(356005)(41300700001)(7636003)(6916009)(70206006)(70586007)(54906003)(426003)(7416002)(40480700001)(966005)(316002)(6666004)(86362001)(4326008)(8936002)(8676002)(40460700003)(36756003)(1076003)(5660300002)(47076005)(36860700001)(107886003)(336012)(26005)(16526019)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:43:40.7960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586c8c78-490a-48cb-ff03-08dbfa46cdc7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410

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
index c25b2e75732b..d9c4936c9941 100644
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
index 7bc631bfb101..366206078b11 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -959,11 +959,43 @@ static struct genl_family genl_ctrl __ro_after_init = {
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


