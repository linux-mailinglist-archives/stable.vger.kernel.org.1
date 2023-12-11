Return-Path: <stable+bounces-5308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2297380CA0F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57EB6B20E32
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540DB3BB5B;
	Mon, 11 Dec 2023 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rn1ZuLRF"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C508DA1
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:43:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgtehYd17MvCogWCt1E2JQeSakHPXCORisqcs590Q+X7OFrpl1ZpATw+BfjXkD2d1BfXvPWr33n17Pa+OqcbEdvtmSyW9MDY9mNqAbNViuJJRy8arCzuvTNfrSAWoKAuSTNtoxySzmL7aVjOMyAEQU0BSuGJU0O4p2/n+WzXfIh9iz86rIVQfVsPJ7fjPkz4FDjM7nGzbqWH77uQdba6CkkodE92sFu8lGU7XKOxvuKe0O4tSMvb7vz5nNmHpKNQDzFMapjhsTJ11yXsRd8fK/4cGDXtIHgWG+oddtdItW8RtIjgkg830uVJb9HR/qq9AOBZnWTvdXi5KCPzHT6qbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWgKbm4a9G0QGodtiaDqkC5QYubmPKfsFLeTIf5QGaQ=;
 b=EmpZZAn+lFjvRmKOjpZXv52WAdmPB5d+9uTlgnimYMMiuQfVG6I92y3SWZD6g70XVG7zP2/CeUrqNeR0QOuMQa+JA9jO1swuqgnz42bF3S7BdwNwaU3VSbW5PfVal/YPiJ7KdcZHMWUeWqwhtwTlNYUX3b0pbELhMZWIg1ipJAFmQbFvGxX1RSyrxuPUPxUc3s1ilmngq+1Dn39oQyaeedk7EmRAmRmAPKCltRfN0P29vN1rdEXXcsfpuCJIV8oZT9H9LN/Zhd1Ae6liY/vlU7JKwW1JDlP+cm2NfYOl72gTJ/fN8XTd0mRNdIFSXLlTUz9StE4qzDZVWvl7We2Dog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWgKbm4a9G0QGodtiaDqkC5QYubmPKfsFLeTIf5QGaQ=;
 b=Rn1ZuLRFPjWkzAzI1ZLQHk3UcaOmWhuhOABr85+r1SRM8Cge3zj8nLwudYdMcH1AoszyS0TYbdW4o/6SpLVtEXPIjQ4kHfN00bE8Y36xNlWDU+P7yNnP3Uo2OAwCPwQEXY/P33dTVTDsWaTbr/J4YwF/bUQ665LCSEuihaKLmbY8AyVAyKmksEjHNJ/y5B3qXDCaRSDiaAqNzJz7MxCkSqhoI9NvGVh1i1BnFQNEs+CjLF9ZyAIR/vBt1H0cu76TD1fsDkoM0b2X61wqquTM8eah32KNl1lVEOVm7uB9AUR4+Zfb6EhWgOsfmmvwFaNN82LjVPPZrWItnYZNYGC1Gw==
Received: from MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::7) by
 BL0PR12MB4932.namprd12.prod.outlook.com (2603:10b6:208:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:43:37 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::5c) by MW4P223CA0002.outlook.office365.com
 (2603:10b6:303:80::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 12:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 12:43:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:43:20 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:43:17 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 4.14 0/4] Generic netlink multicast fixes
Date: Mon, 11 Dec 2023 14:42:57 +0200
Message-ID: <20231211124301.822961-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|BL0PR12MB4932:EE_
X-MS-Office365-Filtering-Correlation-Id: 187b6ace-1733-4019-2dcf-08dbfa46cb78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L3LJTgVTcVtNqjsKUk/cnvWcyAnQb9gDmAV8n8+bucNrmPlk+T52ovgWTaGEtFJC0YFH6sNEwDveRemCnBRiSHfeiEkBw+UsD9hbcV1w/tDiJnjHXFo7u2Abq8neK7N86p6rpNsFwkYpRz7WdxUSnnxIjnISli1gteas889OkX1yBLXN7E9dLMM7PQL7RyrXiraJHPFIMiU1FWcgG4INMlM88Dl2AgRotoyBwMfkAjxVhJQepbIwJyo/cU82bGzemsJPmLJlPXuEqvu7Mxwg0WAVbt5b6P9n1aM0wq37e8izXEUfPVnI1dAbOfzCegPh7Po8/qeJM3JF8Ws3ymCYp1D+JBMWsROT+mqZBo8o265kHYfOWw3GQYaVa27sMjJDj2yrUMUtjaDyi2CeGYvDm4X7kYSkxPWEeC+EwFYMBTe4Gd3+j7LwLtYEB4yj9QL/VXjCC16H34HjNvXZAE//vb8ly3IlIqObojTadNQHJKVPor0iwVKorRNzk/0fjmVsDCBNo3jidywkLR78ixgI2yYpFo0TXF0VPLUonQIiaotBmJia4uXmW3lL9FdDuiT22ZrK/9VBKaVjJPaGzOQXfXytUQ7uqgjC80qm46NJ4xKLljZiqHYFJv4uC5zi7rNrZ7Bs5J87mdFkoTPLavPRyjJyfVxpJvf4bXyUO5ncP1NgYGgUCI68YxkLOhYvuN4jRh2oGvS0K1G6EG0Crff+OidZ63tp38XCnJkHYFwqGYSSnu2J0w0QkNHZaaFZEtY5pknUuyn91K5xtjBY2zKjIA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39850400004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(1076003)(107886003)(16526019)(26005)(2616005)(336012)(6666004)(47076005)(478600001)(7636003)(82740400003)(356005)(86362001)(36756003)(70586007)(2906002)(4744005)(5660300002)(6916009)(70206006)(54906003)(36860700001)(426003)(41300700001)(83380400001)(7416002)(316002)(8936002)(8676002)(4326008)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:43:36.9956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 187b6ace-1733-4019-2dcf-08dbfa46cb78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4932

Restrict two generic netlink multicast groups - in the "psample" and
"NET_DM" families - to be root-only with the appropriate capabilities.

Patch #1 is a dependency of patch #2 which is needed by the actual fixes
in patches #3 and #4.

Florian Westphal (1):
  netlink: don't call ->netlink_bind with table lock held

Ido Schimmel (3):
  genetlink: add CAP_NET_ADMIN test for multicast bind
  psample: Require 'CAP_NET_ADMIN' when joining "packets" group
  drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

 include/net/genetlink.h  |  3 +++
 net/core/drop_monitor.c  |  4 +++-
 net/netlink/af_netlink.c |  4 ++--
 net/netlink/genetlink.c  | 35 +++++++++++++++++++++++++++++++++++
 net/psample/psample.c    |  3 ++-
 5 files changed, 45 insertions(+), 4 deletions(-)

-- 
2.40.1


