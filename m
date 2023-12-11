Return-Path: <stable+bounces-5303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB580CA08
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21FB7281CF8
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1F13B7BC;
	Mon, 11 Dec 2023 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T6JVRTvT"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A638E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:42:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYLKxEPftymf8Sdz3XD11rJ8ISUEJAPO64799qWeTsINLCIfzzgR29YH4Xn/nAxp2TR3zyb6qYz2eP9pM0YGVHfQSq18DYZxrapf6EsToKnJXhBwcC1G4OgMZZh82nHaGw0MTOgc2j7OyQzVWg8J11uKpDm7GMHyRxZ2uGVzaXZGO+YzLjUragbIXuhZQJBE9pT8Xf6LVzr8O+YelslktX3fG9G4iXk7IZCR0yeoaIySo5MrLpGnJX2y2XlTr24+5cBwyFlYc2BOnis5i7LyOUYiWSFbOz1R+YmOfK/vuV2v5AYHsDh1+pf9YO8C6RiZjDnhWjbhz3p0H6MhplNqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWgKbm4a9G0QGodtiaDqkC5QYubmPKfsFLeTIf5QGaQ=;
 b=c46NTQgS2ikojjZmCs7s8I3KZtW3xJcDufCKFpNm1NYI97Nd3IwroUA1Ai/MolOSnKzkbLlW3ihPh8EAQuvGuDj3e49FdBbfmkPRaHbQALt9MpWB6podHQc7Zv+k8aiiSelusaEm3LzKNbBXmafN9YsTBZDbJDi8jPMLEOXyCE3nfZZaL0nxXKuyMcSaJujBfi4klxfEnUtDIWJcx2SGTcds8UMMXqwTc7vBaqIdDtUpM2v+zzhMBLJ4NwYthAU6xqHzhY1y64Za5/63DMqFxGmleVTC8HX7ET/gYP7vnYVvWdbBivX+ryIsgYeVvnMNz5+O5FnHNU6cpT3s/tDtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWgKbm4a9G0QGodtiaDqkC5QYubmPKfsFLeTIf5QGaQ=;
 b=T6JVRTvTxU+4hnZgT6C03csda7NZZ32Gs1O6D5fx5vghLd75TSrdbFVyQydrJwVqgVrN5TZD/ZK9EK/i6UpMrOmNwUTeZ/7ossLW/PUhSPaaAzSdRk8Qgm/qsLZJBT2DmJI0kDyeqyG+3RvNJURYPHu54QlLwVxlBqt0u0rgNwABtS5YEZ7I8AizmDnsF6bRIUY7kzwz96FKooS9pkTQMGHJ61d0YvB7glMgGvhZXtVEwjC4SE5cmbJ3mBvxXWspJQVKwjioxSu/0uZCxkGcmgJdm538giqIKYENzb87in+EhTn07IIts5iWugOFNtHDceeBQgXmPLicL8WovyeXMw==
Received: from BL1PR13CA0086.namprd13.prod.outlook.com (2603:10b6:208:2b8::31)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:42:53 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::1b) by BL1PR13CA0086.outlook.office365.com
 (2603:10b6:208:2b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23 via Frontend
 Transport; Mon, 11 Dec 2023 12:42:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:42:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:42:38 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:42:35 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 4.19 0/4] Generic netlink multicast fixes
Date: Mon, 11 Dec 2023 14:42:18 +0200
Message-ID: <20231211124222.822925-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|MN0PR12MB5740:EE_
X-MS-Office365-Filtering-Correlation-Id: 44621085-e48c-416c-56b4-08dbfa46b125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uug1UQ6XseN5h7TzZeIDSuxym2XH38TJJqglxKl0itTjsZYKvqgpP4ftgJUJMi935OfUECO1xatdNUBBVLTocwb+FLvePnEcbiAdIEDAbtohCgTKok4EPtaG0JOMJhi0NWLnLHmcoYiODJ709qCXCWVbJGmdhVFxwG/BW0cvVOrH3c99zNe3g0baoT5KjqTtDGT3aIe6Ug0RpiFlK55SPgokK3pRtESDeXwWuCtLDiOVH4SgDUyxhtzQRPZAtG3Onefq9EiPiH5eRjd8pQotYfiXMYEEZnL9XXFnclMgdDybEN+7SqRIpccpM0+L0Zb9+qkHMA5jh5KYLMBk9RByjsRYVogAA0XlLJ8mDjwRcDLnnOEz7Fb8YVN2ANzimqkYIsgFWTMaNtiMD4xTCpv0yw0NmaiCnCbzk4iAgfJxOf97FJ2ibzaFqeKCVnA+8Lpc9pOxk8CXPAgjxdbbl2mQVjd2G6k93cAlUpI0z8XaVgqvIKMVTjrrmPlLF4rmSBRbpFSXq+ioeLJIVSHdYbrqzfEi1MRijdQCDSfGdXaUmSjqwaLy06V28FGE2gPnM7VcQ1+/Eb3sblxOW0FouW9yM6CjQfl2c4s/23eJAmAIxHhgLNzmL0cdlN/3iqSUMlVCtukDPYoujibLa8YgPrdOhKAjN8Wox7fpWvcUeFuKPhN0/g6WQ1mjmkGF8t6X7qrgqvhKvzfnPRj9frjcjJtQYw11KulpXlLXWmP//VpkhKwsu2zMYjNlO3ZcxiTcnBOYT6O96Gh5EZNF2OOke+TOTA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(4744005)(40460700003)(2906002)(7416002)(5660300002)(316002)(4326008)(8936002)(8676002)(6916009)(70586007)(54906003)(70206006)(7636003)(356005)(82740400003)(2616005)(36860700001)(86362001)(36756003)(47076005)(83380400001)(16526019)(426003)(26005)(6666004)(478600001)(107886003)(1076003)(336012)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:42:52.7538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44621085-e48c-416c-56b4-08dbfa46b125
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740

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


