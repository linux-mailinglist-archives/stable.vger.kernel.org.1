Return-Path: <stable+bounces-5294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4F280C9F8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A3F281F1D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8013B7AF;
	Mon, 11 Dec 2023 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UeRMtfMr"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F0A9
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:38:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+1OHqAGQ8iBJzOXRrpSqMZ2w4FB3EBCXKCFGJuL5uICUvk+zuIQZABpFC59hznZeBGHmCmTgNP0ia8fwHrE4isW4GgIRT7qp/RK28uLqixQz0cqf1QI0E/g6Ob5GswYo5YBxq2pmR0raDiyJbi7EhXHiOn0WRJ5z4/N7Wch+jT768DGXQZdDm7NKZiGYaoBl43oBJ9CDUIW2Ve/5vWl9Xlqtsn2HFacVC8WhUdbd0QVWjagkO84SNddZtViCHf2tn4h3nQe1Us16fF4LwM/sozCiVLWrp4lw9eWvWmPmheviWj5LLpcKcAOFLEofx6VxyYjXt1H+wnkK2iYo3wlLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X39HFrO5YHPj9LyEXHBhR0HYXf5Fy70DxaILNYq3RPk=;
 b=hAIdwHAWUzZCRtDwi6ZqY283HtZS6DjgoQRArv9abXt0eyC1Xh7rFT55wiAIOOpt0FY/OJLAqcDne+/xXbWnFsYr8oVytxpBmVVjTfwuajRon6FgUl8emhVU4rmKF2hfNnc4hUrlwRqkt3EEPbi6RJBYvalcZq1MzKsUfICPr8Tq7Pjv/5OWG/qooNBT35Xy0Y4uBCtvDUxmPsxexszk/2aDRjXIYt7KBhHOTfwVb0k6+uXf6Atv3xbv9OEmhr85FgNEar5G/51GhytbclKRChTk/WJOqcncWxUcl5h0u8iYU7XJT2T56fOVxu62m9pVrQfQ/eahIx3Yp1wDDNgU/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X39HFrO5YHPj9LyEXHBhR0HYXf5Fy70DxaILNYq3RPk=;
 b=UeRMtfMrzBvYns9nQUqWbNpTpXWmG+uCWn64CmFsGWkQJhyv+bJ2HTYHSZky6SXiRlaFRMKXc+S2NKwft//68uF1f3lTEqWgLZgtqIoKpbcJGPIF9JRG8hhNoNOTv7GFtg7H6xaJgtZ/knc3AJP7n9t5RFdg0sRLQWwgU03uHz3rvOscCS5G9L+mY68WfiuNfIsSZ4kbFJYa1r0k0BBQrh9lusksGaCCgRs0bHSZBpWSVEuQ1r0xEsY1tBdjBadfmxu9D7bzs0vvioU5SP14xGS1WR8sq06P0bv7359TeSAySUb4NIvMnPDqufA5J9jDPXN3wsTCO7pPZoQuG1NTxQ==
Received: from CY8P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::25)
 by DS7PR12MB5861.namprd12.prod.outlook.com (2603:10b6:8:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:38:49 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::b4) by CY8P220CA0048.outlook.office365.com
 (2603:10b6:930:47::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34 via Frontend
 Transport; Mon, 11 Dec 2023 12:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:38:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:38:38 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:38:35 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 5.10 1/4] netlink: don't call ->netlink_bind with table lock held
Date: Mon, 11 Dec 2023 14:37:37 +0200
Message-ID: <20231211123740.822802-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DS7PR12MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ffbb2f-8b2d-40dc-e97c-08dbfa461ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	exovF1QHawkVGMc8FxPkHndfFHtIQs7zJmTJUFTN+NiOPsEYB7fxodscuAUnVqTckBaa9KzUa34tG1vMjYUnKqc1hqQevBKTx+AP2GIPdDCHvzDC/WQ8lnFWMCx5xyunsZyU6biillLSdit8D0uUOkwBkgDKwIlG7U5CUABKVbhhEl9jt+aW5YdtaWk7JHteYpAgftIURExsqFvelzMfllV+S6Tk0SNDOALOGoNFl3/JywOXpf+m2u4pKzXghUoAQzxvDSxo+BQ1ikYqdqHyJmgqigYMN5x/h6qO4SxQzoxs7ztMq9OSkY7PjKenmch9YJnbX9S57IdKqBHtSKWul7jE+d/vWGH2Czr6YDd1XLo78MpudQtniNGnec9wqXtJZHhVdu9XFc1b9uu6cDgc8s5ZxGvVbrJd6DwBbWft2gmHoUebO1xCecLwnVrBRQt5GaLLXkr3TLQ/TsEAy7wKx8IT5b+/Y+4A/tfg5j7EB/rG+ccEHbwWtxD722n4kNzxZPvO57iIsMb/6noNMf62HCF3jDHYgrfnTB9meFhrjlBVnrMhhb00GsAWXnjkSQ1cls0ZhTdPoIg5msHtZ61KF85gEvrc90VT59Ccj9/gcj5cIXSCnYnrP/kUHiJAIxzRbSXrB1A9pgaydsa+qepPIDBko3vxMIqCUVFXzlU2jFQKrSf+c+5051bypLsMBYxkdlngaowatnleAYq6Aci0O96p79UT3NZunu8M+ZLmvbrODn8fRaHGdIiZzV9jq57s4bCQH8Y89VGQ7AXpB97HICldYd+hcL1svyWXoCgtaX8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(1076003)(26005)(16526019)(2616005)(107886003)(336012)(426003)(36860700001)(83380400001)(5660300002)(47076005)(7416002)(41300700001)(2906002)(4326008)(478600001)(8676002)(8936002)(70206006)(70586007)(316002)(54906003)(966005)(6916009)(82740400003)(356005)(86362001)(7636003)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:38:49.2893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ffbb2f-8b2d-40dc-e97c-08dbfa461ff6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5861

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
index 9737c3229c12..901358a5b593 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1021,7 +1021,6 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
 			return -EINVAL;
 	}
 
-	netlink_lock_table();
 	if (nlk->netlink_bind && groups) {
 		int group;
 
@@ -1033,13 +1032,14 @@ static int netlink_bind(struct socket *sock, struct sockaddr *addr,
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


