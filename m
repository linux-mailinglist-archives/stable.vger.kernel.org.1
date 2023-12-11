Return-Path: <stable+bounces-5309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA2980CA11
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A283BB20DA0
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC1C3B7BE;
	Mon, 11 Dec 2023 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i1S5RFbi"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C708E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:43:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp9jluYdjNATQajeKuHY5lQDMONG5OdbNWQ18mNOT9OsCB/ofJbt0+OK8utlAYthp7cXzoVQ7hJps3uTbwURM91wKqW+sDzFOGEMXQTHuTq1Zi5dR0WM3y1erIyHfZ57a1bK1mH4fHp1OPib6bZ81q6KfK7ZM6d/JICm244JyB1j94U6DE+5WLlyH04EURwFA7Kdvn0Z8mm3mCdtlDz0+l79OC3QZwYKbovSxXEcg+rD3aRofW7RGoMU5LpD88GebEcC8cWvl7G37xuUZJlY8RaOxweL+9b6QRNPnKol4RxwIMm/jnw0FVXUItJroJeTafGLF+xmsCvCS1ooa2nFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seAslw1z+1m/TCUgrCwPOCCPEwD+eH4Ssk/Vla0U228=;
 b=E8YVrKyVJoSeQBJoGHD9Pb6SG6SoEqGcvwLPSyfTEdESgIduljzO9vQCXVxqSXvOKukfenU+3fp3HImSQmB0vZ2d40vOu41oz3LQypo6LVdHIKjIXVhMp56pVghaQqKUZPF8WBeNgjpre07+db5iUbzO6D1rR+sVL1dnd9Ll9jAT6XXJbNe3iAN8pSDRfW2lILynD3RiaI1aTQPRp+LBcIM2W9QlDS+4KeIMA3tROoqr3L42ACKwYcFlLgRFZesGu80N4mWytJ06OCfJgailpjUhyHGrwHAIV5tsZKzngx+IGng8WLyWC2PJHTTpSsBZOVxdE1fFKPKWb0EEXJf+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seAslw1z+1m/TCUgrCwPOCCPEwD+eH4Ssk/Vla0U228=;
 b=i1S5RFbi3tDNwi1bAo42XU2Knt5oX/K9K282vM6ZsbMKbtyIT0B/CiuE/sFfrvfrlfvZrF2Csn1D6RdGi3fbrmtTxYRKSqeYlTsf5Xsik6X3MS6Cu4tLVOHmIGdgJqkMVpr7x2AbsV90o9/700fjRLxHKkO2+hzHPdYenjYlKxWaF2+9nJhw+IeyNuY+gP7X8Rllr2DVPiyys8PcAZxJ64fExiHiNBBApNJBoysmt6Pvlhi9kPVP0IP52BZde6zeulAcXM2A+ERcVqAOhhFovSiHdJN8n7fWPp/xeSNazAZt0pwg0gNebsdJsqgjBTQC+SajWkTmlZx/xttHwUPeVw==
Received: from MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35) by
 SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:43:38 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:23f:cafe::f1) by MN2PR01CA0066.outlook.office365.com
 (2603:10b6:208:23f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 12:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:43:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:43:24 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:43:21 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 4.14 1/4] netlink: don't call ->netlink_bind with table lock held
Date: Mon, 11 Dec 2023 14:42:58 +0200
Message-ID: <20231211124301.822961-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 295c58f3-2c86-4fd7-b321-08dbfa46cc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MfdJEzZGAFmWqAueGLEi7WExfQSiN8Vdz5CHZu1DrHZCvUCyjIch10w+CCVfZmNGNhlZtJ7OymwwW4ueioztslWx0FKiz0lCYOkJQU+2kjdeYVSUSdBChBFSOO+NYX4Fb4C3lLPM5afr7okv9BO9DkLeBoIBoh61KA3aAi+JFFMKBXMeZArx1D04I9/CySmL/DHSFlR5lUYHMmuBEOaO2j9KKWG8NGV/B8Nrxm9lHTa6H6nPxJy0UNRmIS2RzYxSWufCjdulHq9/Y4kjVJQr75Kbt2U2B7PFIYO79pnkqjnZK352tgEyBBHcA6UrnqgdsPhZ1VIwabsHE5nmP8dFDCV6VM9gY6um/9btgDADidSh9kvnGiLC4i2ZAeuGphRoUjGXzPrsu2aYn23P77ayRflieh6PyxJUK/UrEmr5EkG/wYLcNJp8xj5kQPI8NJUlZOBkLmNX+ryyMEIc0b+4CBWFtpDxPiUl0xJUgQnQ8lPGhhn5H7ufy8nYBW8+yOJtz7x53dow8fCtfkIZEIKspSSs68A7N/gkkHQih2H/Wek2ekd4pKO/ImeFe+hSWxBD/MkZLwAwX3Otr4tozKp5GnB+aos9737u3LPt5jK75MiHmegXvWpKTYiRcoatLpQl2Y87OroM/fkQj4VzMdN0z9OVQ6cKWtMB8hLA6DBh6P++7O4Bhgae/sMHtVGw45CfvkMlO+HNIG7tNGN5EBDdGA9+kqOfqhHfToYW5RMC47NH8MvhU3SPuoMKeMqF1WuJFistnwtkxAvhhpdZ+Lnu3uRPAfqjgqEaR3zf6HIukMc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(7416002)(6666004)(2906002)(54906003)(70206006)(6916009)(7636003)(356005)(86362001)(36756003)(8936002)(4326008)(8676002)(316002)(5660300002)(40480700001)(70586007)(966005)(478600001)(40460700003)(41300700001)(36860700001)(107886003)(82740400003)(47076005)(2616005)(26005)(336012)(426003)(1076003)(83380400001)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:43:38.0204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295c58f3-2c86-4fd7-b321-08dbfa46cc1b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343

From: Florian Westphal <fw@strlen.de>

commit f2764bd4f6a8dffaec3e220728385d9756b3c2cb upstream.

When I added support to allow generic netlink multicast groups to be
restricted to subscribers with CAP_NET_ADMIN I was unaware that a
genl_bind implementation already existed in the past.

It was reverted due to ABBA deadlock:

1. ->netlink_bind gets called with the table lock held.
2. genetlink bind callback is invoked, it grabs the genl lock.

But when a new genl subsystem is (un)registered, these two locks are
taken in reverse order.

One solution would be to revert again and add a comment in genl
referring 1e82a62fec613, "genetlink: remove genl_bind").

This would need a second change in mptcp to not expose the raw token
value anymore, e.g.  by hashing the token with a secret key so userspace
can still associate subflow events with the correct mptcp connection.

However, Paolo Abeni reminded me to double-check why the netlink table is
locked in the first place.

I can't find one.  netlink_bind() is already called without this lock
when userspace joins a group via NETLINK_ADD_MEMBERSHIP setsockopt.
Same holds for the netlink_unbind operation.

Digging through the history, commit f773608026ee1
("netlink: access nlk groups safely in netlink bind and getname")
expanded the lock scope.

commit 3a20773beeeeade ("net: netlink: cap max groups which will be considered in netlink_bind()")
... removed the nlk->ngroups access that the lock scope
extension was all about.

Reduce the lock scope again and always call ->netlink_bind without
the table lock.

The Fixes tag should be vs. the patch mentioned in the link below,
but that one got squash-merged into the patch that came earlier in the
series.

Fixes: 4d54cc32112d8d ("mptcp: avoid lock_fast usage in accept path")
Link: https://lore.kernel.org/mptcp/20210213000001.379332-8-mathew.j.martineau@linux.intel.com/T/#u
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Sean Tranchetti <stranche@codeaurora.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/netlink/af_netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 6aa984971577..89ece1f093e2 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1001,7 +1001,6 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	netlink_lock_table();
 	if (nlk->netlink_bind && groups) {
 		int group;
 
@@ -1013,13 +1012,14 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			if (!err)
 				continue;
 			netlink_undo_bind(group, groups, sk);
-			goto unlock;
+			return err;
 		}
 	}
 
 	/* No need for barriers here as we return to user-space without
 	 * using any of the bound attributes.
 	 */
+	netlink_lock_table();
 	if (!bound) {
 		err = nladdr->nl_pid ?
 			netlink_insert(sk, nladdr->nl_pid) :
-- 
2.40.1


