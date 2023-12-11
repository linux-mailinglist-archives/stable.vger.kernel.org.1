Return-Path: <stable+bounces-5299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ADD80CA03
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359781C20A19
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249F93BB42;
	Mon, 11 Dec 2023 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ja+POTCq"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E539F8E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:42:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXgfIjjersZrL11aIIsr75Yolv5gCuMgrFthKbbFg1JZoHa2nSuqSKdGd0X3mEUwjbTl3K2GQsVm3WJLgK/Iq3DICBo8IdKX1GPumLy6Tb04RT6gkEd43g8cwatQgfUOAsbV3Nix3S2dQFE7ML/VlT7coNMqx2Zmxy4Hl6U9f9GeI4TSe1VMLGlNsoi3rMcarVVD0U3KO/G9xJNXzVCjel6a4h17/n4ijLjYxMe2zwJHBMfbhcWZLgWNt+ZNaNMjVIaJpRQ6IVR2wYT7fSmzFuXeLwskKO/G++zcC6ecx8jMPWVrue4kqmKV2YciuSjTVKpFedHZvfoITrFis3P8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fku19e6lywWja15ocvjP0otN1WuH8d/N16SRqI2GOk=;
 b=BnufQFcsUEvB6d0ABVbTBgReuMCvM12wsy/pPXjJlmr2SIugWlvimwP4sTDjDUaFTtdS9ly7eewX+yW7Ba8Mo/3qOVWj6gWommhuRIvk39SrpsEG4AawszKYmESnl/J+QGXzx78RNsPG0mtf8DJdPKZuwmF0BmxKaULusqsfa66Ox3FnuoG/3+DCuSYH/PBBNkJzkkbj44NdMY4laF35/QeLBQIluegrfCwTxjvWYtdEZGlnqWwomECxG9OQWrmHfsNmDIQJQHaBomenepLUWABZBQZRk0/RMdQBYZ+gGGuvI4tbWQ+JASsF+TGccyt/7hu0KEfqfplTNMsu7jSpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fku19e6lywWja15ocvjP0otN1WuH8d/N16SRqI2GOk=;
 b=Ja+POTCqanWd9eMm4jiCjxatVqQ6TxwoqG0uxGCH4R4r2ytx0jqHZ7OvLrPc/0AzEf0GtQpbblD3lZUwqrahpfh6evw+N+RtfpO3qv6xLuTux1jMcLomq+WUXXOq6IEIRpl9B5aCQsDn7J0FCgiqvGYQdUW9teC89/y4kpIdPeBKUuooRhz1FpgwTOTNbOhNWAooQSymtK6nmymhUvO9pVVSnDAsVK8J6fN3d5pa4CIJdoSB49l770uGdf6nXUBukirb2XlK4TvZltWYda98+h9fjD93ct7hBcFBJ5zDpRnqZhvHRV8RUDFEwBFRhdFvLfzXPWW+FRXmhZq5S5sCFA==
Received: from BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) by MN2PR12MB4341.namprd12.prod.outlook.com
 (2603:10b6:208:262::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:42:10 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::71) by BL0PR1501CA0035.outlook.office365.com
 (2603:10b6:207:17::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Mon, 11 Dec 2023 12:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:42:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:41:56 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:41:53 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 5.4 1/4] netlink: don't call ->netlink_bind with table lock held
Date: Mon, 11 Dec 2023 14:41:30 +0200
Message-ID: <20231211124133.822891-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e7e508-0e16-4b02-2a47-08dbfa4697f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pAb6YO8QSdyNaKxjEWcoraGkdf5QapzuiWC30ERygvXdxqAbNc4hNt1+bx+iDYWrjmi28DsRaPOw23r827yGqyTG/4w+/D38r1VYKWGb2//mQ1zgtekU+qMo7knc0tmyCu4xLTQR5DJ18hAAZvgDnesRUcqDxA3yOobqNAJMP9k2CSGZnmAPfGTnLArSHNvJsY4LNCJ04V0sbKTbAUKQPayrnZhXhjn68Ppb81VH1r0fOLVqA3WcH6hSKSNZN6sr1gl+EbF+HFLPFi+ab2TiKIfFPQ8tF5EAskwXqvhlxhKPl0Y3hNCTNZTHrwrlW8Aqpj3T+h9dYpDHZOEcQeCwM0P+l7XXXNrU6m1d3wtnrzpe/Gdb19plOAMaLtZh/6khYloEvGK4F4LF0aDi0Eda2sp5myyeRrtPOtDEmg809cDlnCWA3NYsE/R++5y0+wIYyqPJgCuWr/UxtoVsCCwNGMwWa62Cw9Dw3I3+28Yk4bEbQpXFYKAkseKdlE2AbQEjO24qK8D3q9oXFgkpgYb+3ONyEZ2Q2h7EACyQw35qduYkZMpzJRNjW/tuKZpxvV/fXOC/1r4IyiIpiU3YKi/iLDiHIl43zRgCgcukG8/ew1PlqQ+gcXNeL15EFg3Iq8AJkNZ1T3J/dHE0ov1RoUSTLtrt9IF05E5w9dNE56h05Q3y/dqBn6uwGfS5lhaQ4UbKmVPd1kLAcbMZ56ifSvRx8Yzzn4p63YJ+FH6n3Y3NP61edJTIfU6UueiyGtS+9PSjQoma8hb1VuubJTWzKCQz1qj+8jmBj2igLt3G2HnZK44=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(46966006)(36840700001)(2616005)(107886003)(1076003)(36756003)(6666004)(966005)(478600001)(316002)(40460700003)(70206006)(6916009)(54906003)(70586007)(8676002)(86362001)(4326008)(36860700001)(7636003)(356005)(82740400003)(47076005)(8936002)(26005)(40480700001)(336012)(426003)(83380400001)(16526019)(7416002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:42:10.5107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e7e508-0e16-4b02-2a47-08dbfa4697f5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

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
index 29eabd45b832..3cb27a27b420 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1020,7 +1020,6 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	netlink_lock_table();
 	if (nlk->netlink_bind && groups) {
 		int group;
 
@@ -1032,13 +1031,14 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
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


