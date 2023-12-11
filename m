Return-Path: <stable+bounces-5292-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F680C9F6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6F1281E71
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD793B7B0;
	Mon, 11 Dec 2023 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UnWOi9a0"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60183A1
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:38:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijwOHiAQpsw/C6Q8yvHp5+eGlAzOtCSjtkZVHsn7hF+zIyU0skDuXbbYhrYl3A2rI2/86m2rB71/mqAvuXBsOKU4OhTdkmyo9N2bh8qfxdK6SnPrt/7yF2aS35lFHn8bnaomperrMAmA6Eo+0WioNlkaEfdqrrPlqUWt7M/brfTAV1slSwhONxILhn/dyG8mQaqCDiOY/toDIUXPDtQxBwWEnJ29MdPIhlfLv2eTgS0Gt09l6qK7QZOc+8NFQBMI4hjmQ9G4kKVBNhBR66bUQfBDjkq9AYlgzkn3MYPUgkjIo3gJOTMP/x1eIlF6X0vt+as+N/zlAweQ/hj92TL1VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWgKbm4a9G0QGodtiaDqkC5QYubmPKfsFLeTIf5QGaQ=;
 b=XH9ZpmCYc+l9+Gerrh1G+NRJY5aL/WqL8qjxHMk/luoQGvDwCmlv5zOIHy9qLuq8xnMrzmR61wA96EoKuYm0I4evmXZdjurtT/5uPu5K7RLxBO5zaE7aJsA8cUgWb2qi++d6jyEp832QWjO3VLJHHvGAFZmpk88ZZc0dSGBlP/qWZQB6FaGj+Nve6yuNjAknSt/kW6W5fAzrnxlEFS34kc8l8l58DC5Har5OImiYDP2sc/R6/bDIe114+eREaQQ8iwb6V+R9l4Axh2cI77gHet3B69DWwWY94DJC9CM3AI2hAc/qcAX/19nwQvM+E0P4tV4lj7rVSqy8ZhdjjbfwoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWgKbm4a9G0QGodtiaDqkC5QYubmPKfsFLeTIf5QGaQ=;
 b=UnWOi9a0RKNh6XYtUU62OUPVUYaF4T3XWxP6soWiSe61HY9OeBDk3QNmLgEzefDUtvWdUAmW5JV34wfTz/PhPeiwg09l4hUlJrPx7Z+zbhmWEYFIlXGCIp6peFV9zrnILt2xkduC9wwpMNrgPHKvbh/2x1FPHtqTHtElD484fyrvWgNg6u07zI6aF2oQIlYkq50boyLRNLYBVdeTJs9+Fq0GgM6azhwILMHOj1Cd7NJb6TSaGHoDDslehjJFugelx5AKoaT/FTbqz22vlBKI46c5RZp0YGAIVDLXtFSUCJkYyiyahp05mt9KADlmUX0ncZSIYSmTstE1xninN0PvZA==
Received: from DM6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:5:134::18)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:38:45 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::25) by DM6PR13CA0041.outlook.office365.com
 (2603:10b6:5:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23 via Frontend
 Transport; Mon, 11 Dec 2023 12:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 12:38:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:38:35 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:38:31 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 5.10 0/4] Generic netlink multicast fixes
Date: Mon, 11 Dec 2023 14:37:36 +0200
Message-ID: <20231211123740.822802-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f147f05-7a66-4ccf-b590-08dbfa461ccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yGaHXCKMBm0ZKR6zr8RWVVab99e8CZU8tuDsA/0L9yJRo7SvIRTlyJQQACvDyvde8zbB0VcQy5u+sfDormRsy9YaqUfbYSLYe9jZ4uiRguk1MkI8Djakjzs4S3QVEwibnkA5TEe0hQpvQ1efnWqm9r6LPb7Pzuf8Kw04rXhsOO+ru/Vt0JiVdJjPTE6JH020J0xveGZuQPzC/X1A98VfmKuXgYxuG3m+3CV0K5r9CbgVg1WSvJ9niNUoY46Iu2AnlWaATn/qVqH6EQ5BqiUIIOlNs1oHkkf/eObLbOn42EeS5qtNvKm6pFaKcuGGcrETN+WxhyAhaT02218ZLdEgAZahvFsmf2uawucPUd0zGhu1XO/zjIszr5L9dXNa9lHPytPPgqc6BjRLql/MFGR8Okn8Vyher6eNpolzLIbfpEqN5sphxnFS7Vi6Fmb56Wrt2vcpkKjMfTjghlvBSSCzBEiI6S5sPDTQsu7smwRfTkMyNvVKKwspsboAhlpCPJAk6kntuPtZTNX3eNk4V6uc2HNKoQu2WzJO7BoFsRa8v0a/UT0gPVig6Pb6MbSK2pC3je21/OrxcuGD/Kfl9k/ymfweOT3vZEW1bKU9qvpnn3ek5t0Z2miyKDM3C7epK+2sxiLAv7k4x5dD66stuxum+MBNboCv+DVwcE7OqSsA1LRcwBZ8EPJV8NrHkhnQUaH3nDeXsniCQnS15qbyUGDUsjFscAu92i3NScvXYTeCkNTEHvRuNK8P9Y8EY3QIc5KJ9ZhUy+qBP9/AM2IXY/ykFg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(40480700001)(41300700001)(4744005)(40460700003)(2906002)(7416002)(5660300002)(316002)(4326008)(8936002)(8676002)(6916009)(70586007)(54906003)(70206006)(7636003)(356005)(82740400003)(2616005)(36860700001)(86362001)(36756003)(47076005)(83380400001)(16526019)(426003)(26005)(478600001)(107886003)(1076003)(336012)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:38:44.0017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f147f05-7a66-4ccf-b590-08dbfa461ccd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155

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


