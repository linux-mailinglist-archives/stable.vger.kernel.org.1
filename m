Return-Path: <stable+bounces-5304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4667F80CA09
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D5D1F216C9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE7B3BB2B;
	Mon, 11 Dec 2023 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bE22dS1R"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6958B8E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:43:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUqDZmsqt/HWiokL0DRMT0vVraPdKX7Iz2vF1IRFcbfx7jYjButg3Haz9HEJ+2+mXHYMyYvN4sCH8nowUzX07o5pvXncUU6sZi48h8Mjw2V19Tb9noH49EFXIYHyFp1H8YMq9oGfiewE+DrxGdtMGRGETIOF+/aaUCpoJ8Bp9K+F1DxVQmi4OCnm6uZI85ylskJJJ9GRhAmyiK6vPPwEQ4rL0hFigMV/agq0jP3OYxKLQn4EdJYuKUixh89T6EniRFjnACtvgIHsMGz4c3+jRFRe+JcHWKbDXHC0WpUq+J5B8IOdNSjK5Hgfd7t5BFxHuhuccBXox5w5AOuQ0a/rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZjw3r5HRGclH4jhOmkxUUNygX/4hNzNgNwvZSRR6D0=;
 b=fC4NcgxbqOKW5TrGu5leiSixfThhSd4VcgofkkANSrVK6Sd0ohJ+V/+ym2tV+gAbC/tLR9xXopKh7zKIcmpnHM8V58XIQtfzMOr7HIzQo02y6F9XnkkKHbAEpK/yyJmsqFb7Xc5KVBgmEhBw3mBwcHCnlC+iCJ4s6EPYFO5Sjslz0mD3EWwrZYvRyGUzACcXMqqbfx5SzHFIB2AIeRGxzUhMqkrwnGZO6uxaPTkpU+/X7yffmujpEhlXwyqkbOobrXURzR8mJNwjkV4dsOkuNlpuqkb6w0uiezJo35nBuBdbboSHUHO4BrXfKzHd7iPjiWNq50dFM6oK85RzjGonYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZjw3r5HRGclH4jhOmkxUUNygX/4hNzNgNwvZSRR6D0=;
 b=bE22dS1Rxj3OtZ6OKmv/lV0EGMv8n55NgU84uj2cpPu3ebXpaVXybGrZOEWsvvZU/NjOWJZrhvY2eUQs3ATyZVAAYAhC7lE8m79B3WXBpM/Jo06eFRVwd++ByWMI10utda6PJgFBPB+Dm7R0l++DrKQxZ4/3PXantrqmsguKDB46mz3Rq+N5+QIkb7lM9p2LO3JBwOuwLL0Fru3EOpuPPqn+Lw35KFK8UXwcaC62JnwDChEInWW+obXAWUuFP20w3/+pPThNP/FIQ/+1Do95EkgohMEXsxQEYZnbYjWw6gZ0zV/pnahYEgr+jB6KuJ/dUC9BZ2NzO5kLwKiPz3b1+g==
Received: from BL0PR1501CA0027.namprd15.prod.outlook.com
 (2603:10b6:207:17::40) by DS0PR12MB8768.namprd12.prod.outlook.com
 (2603:10b6:8:14f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 12:42:59 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::37) by BL0PR1501CA0027.outlook.office365.com
 (2603:10b6:207:17::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Mon, 11 Dec 2023 12:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:42:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:42:41 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:42:38 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 4.19 1/4] netlink: don't call ->netlink_bind with table lock held
Date: Mon, 11 Dec 2023 14:42:19 +0200
Message-ID: <20231211124222.822925-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS0PR12MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 92ee8137-76a6-4e64-eb9d-08dbfa46b49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Jzd1tdS+HIdR5jzYknauAF1QEr3E/wWt9DXDl3cLkg6nJXgTXhCeWgNxF88/YzsGFXpebB2jSr0Hq9ALQWOBGYz+9GoV7bbngnExYFJuVwfNEwU0v6RIXHz3rNMGCPYN6HfWAG7e0euoaalLcRdhvarx8dI44ONvb7kymsYFewNb43F7KMWqopHI839JOUjTpqga1QN4RYsoxbeoPLDxFnLFa1v29iewzvc379piyX2pXmubMjUL67KOMRtirOOizLuPbvHf7vnTqOFnN1hy9i+gOxjJZexuN5IKBHjJX9Dn0rCWtYoFS+8SBcKNWseBUT2Dwz9XetJry3WyN8Rflfn6SSwKUVIlk171M4XWpPD4d5/0K+sh5A7gAOWZHNyThcYDiQAsXqERDw0AzrOnJsFXPf92bprcfGF73W+xqx6+M02Zv1JH7wlOUSZuB6kcHwbD7oUt8WuclFAX/aBTHq3ama0PJ0DclEn8Pk+fRSHwehEH/tUyU2SeSz1LZq8up9xNG0uZnW5XlyvzQe3y0ImiVrCoXuCyUtJhpL/u64TZSGjp0Fy/xTf5G0WFkVBINESkMdqlPXacbuS3hyXTf9q+6qvbnTzxpAeuI6B/sZB0CmqReBn0hLV/q5njfCZge4RT77L2NVeh+V/Ht5SfsG0RkPndhHXh/64ZuT62hIzfnaxBuLlVleiNlF48hh13olhD5EQsVC9zfnvdK/0o2++vT5LZECpz+YWViLk1j/+yMwMEc2uG0dQW3DU9Vp/tAyV2XVUlQqsAZbEwc8Cy+KoqkpHnFSiYAP264iRn1Bo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(36840700001)(46966006)(107886003)(2616005)(1076003)(36756003)(6666004)(966005)(478600001)(70206006)(316002)(6916009)(54906003)(70586007)(8676002)(40460700003)(86362001)(4326008)(7636003)(356005)(82740400003)(47076005)(36860700001)(8936002)(40480700001)(26005)(336012)(83380400001)(426003)(16526019)(7416002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:42:58.5732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ee8137-76a6-4e64-eb9d-08dbfa46b49a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768

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
index 35ecaa93f213..e91489b3274c 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1030,7 +1030,6 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	netlink_lock_table();
 	if (nlk->netlink_bind && groups) {
 		int group;
 
@@ -1042,13 +1041,14 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
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


