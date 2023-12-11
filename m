Return-Path: <stable+bounces-5298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1380CA05
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19D8AB20C55
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 12:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AC23B7BC;
	Mon, 11 Dec 2023 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YYLLGEoo"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E6CA1
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 04:42:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzilVkioCX2jKCkXF44CcGyLeO4iPwTx/eY9viTm3o8znmr34Hncgy6evW9U2MNYTsbCfnePBcRVvVJyXzvuJ7XuOVv8InLdDLtrpi/H2dSLoZCEtXVWtRplvacwTMXOBKhbi9SdYpMvWrdQQvpDdkHMnVOODxwHMmYpfQ56/8VAkMvudc0DzuNjnqBOZioMl0LHRdmadsBwM7E5HvJ0oWynFvUmlY5e/JvBZlkDh9ZWdxLoJOFnkRlxuyH5T3BtSqjwR/2IbYAbUzi14NRV1fkF6Wy1s4QbNwWRZTsV84zzjgW+DNBX5DtTAw7IOFz5cYCjPOgBECuWESgOY7Ryvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWgKbm4a9G0QGodtiaDqkC5QYubmPKfsFLeTIf5QGaQ=;
 b=SdVFlRsrjyP0YRIXx1cqnE9qxWAObGdXhD2Sef0D8DCLopADQJIIkr5Bm/EcclpqXVAiGXky65K99jBf5q9mJ2bwMh1O1cfSxxxjuihTtMnYVMZzydsD3ijinOjsuLzDBcTWs9okMHbBdcbO2dAKqHgSw4+fMM+TCGu9iuGGRFXfxfzdYMH4/VDnsQdCM8kBoqbVE9/ZADFxzyX3kssBigLAh4O6nQyiapXufG1mv0EnhnN2GlmXyRq8PrlZixZqbY1a8+or/FqctWtoOCFR7sMWj1kebcCSbNwnEZIWSmKgSIsCGcsiGk7F5LFN9iO9ZvOd3XShJDgBa8OO49Xdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWgKbm4a9G0QGodtiaDqkC5QYubmPKfsFLeTIf5QGaQ=;
 b=YYLLGEoouMjGYZpj3eSbHoWI8UqACQ4DwA0+jEU0AjZEHLH4je54vERjTX9QlfD9HVS7b9wVFgB87ABkPDuvntCWyC1b9IpFnqKxHtfuEGNygohjlpQkOnGnld4aXuwmnYbyuA2vwtKvVw1VtswFyKzXQkXLSHRUme7fCHOk+gv4BcDUK7n6ZKPpxVbhhF13z8wN8j252lOtEDSU+3J2ZFxe/sfYjx5P9XZZqbeyGaSYAiKxiNRiSBrtCsKnbs0Urc0A/DgXYfHuIOOzc01KoQFJgxhQzumMqrKxoobipWdhpuPnoiXLO+yqXmaSW1xqnCd2YkTim2Fg6remsVY4MA==
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 12:42:07 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::5e) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 12:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.2 via Frontend Transport; Mon, 11 Dec 2023 12:42:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 04:41:52 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 11 Dec 2023 04:41:49 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <stable@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <nhorman@tuxdriver.com>, <yotam.gi@gmail.com>,
	<sashal@kernel.org>, <fw@strlen.de>, <jacob.e.keller@intel.com>,
	<jiri@nvidia.com>
Subject: [PATCH 5.4 0/4] Generic netlink multicast fixes
Date: Mon, 11 Dec 2023 14:41:29 +0200
Message-ID: <20231211124133.822891-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 21961bce-233c-4029-2b61-08dbfa469618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QEfTUDbvFUDzQfAHoQHoIL+XZbV595TKYGur4eV5IDyQTVo1kBeWbClCcmpOOBrDirhTah/AZNHv1VZCWpdyJ2bD3dLdHl30PToEjAwoW+XgkqPZbqqG2j1a1uNy0YqBBCJTzg/1Fc8D3xt5akGDVpHLOayIi6IqK2/c7fhHscNy19eBlQ1f/ul7c5GGFMIZ2EmdYCSs0wX1DvOqe7HufHXmNMYcXWM6yp+ONAru16jTVbLJ+JiU/ZEfdDhh4+viCpJVBW3EeFrALfnWchPwiXe4xu7FKPBVIwWLZrn6p9PW8PdqCY6hQMNtpU2Jx+KRCpjUr91WxxtWYoRqTpB+rWTvMWG5mgDVKPBcW/mIDK6ONtAHkJF01hfrj7uWidbZK8IHokkwON5C0gTf6k6CIuj6DLT/gtPnWZKYSeZ93GgkgesAIqYzGNRzesteLfP42J+GFoaCTBooUPmUZJo18Rcu9aIi1Gaae4BxRVgjAFedoQ4K8HwntjRyWNWky7r/amwJbcqeC4xyap1LWA6rW7PVo+bmfWS+H4JJjm832VKtveh7QBz4ionaeNmWcdprK7dpYvmAvGdqySFXHcFLOOcCP6Litzl9/aJVBZ1LmsG47hav1axKgNrbpZ9yTNcVB0Qa+UYaxvl4R3wF/XZOqs3Jrh1n+wU6xGUNhYTsuBZg8Mt7MPIrl3TWEPSP8l3e0x5oFqmEfMz5yTc01ksZ7AtYPlVqDwGpE2ctUqG8sAumHTb49f//Rf4RQUYHUM2Rn1vKG3VEraC26Qj1OZ0zDQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(2906002)(82740400003)(478600001)(356005)(41300700001)(7636003)(6916009)(70206006)(70586007)(54906003)(426003)(7416002)(40480700001)(4744005)(316002)(6666004)(86362001)(4326008)(8936002)(8676002)(40460700003)(36756003)(1076003)(5660300002)(47076005)(36860700001)(107886003)(336012)(26005)(16526019)(2616005)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 12:42:07.4315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21961bce-233c-4029-2b61-08dbfa469618
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748

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


