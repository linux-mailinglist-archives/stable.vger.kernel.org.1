Return-Path: <stable+bounces-4972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0B7809CC5
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 08:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495A61C20E21
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 07:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232B7D289;
	Fri,  8 Dec 2023 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="WWBA7S3p"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2104.outbound.protection.outlook.com [40.107.243.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03985173E;
	Thu,  7 Dec 2023 23:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/V86jzdPYNXscfN1EWNrZy92Bj8lkPGfHOFc0eMWVh2SxNRw6dyvdoWXNfZy/Yvr4m4++6BJt+hB4yqf5cuaFRezi9qKAD52DG7/TFvCUjKhe1GupSO1G5T5Yl7/mTYbiRr6wi4IbHF5vwPTP3Jl4bXvJf56JyHG2phCbv430U7mffyMXShyysLCkOSZ2imWE0XA6uB2HrIbHLv+QkOG0plvj4xQDZiumUuZ/q9WodtdjxEMdjcMj0jrRvCeIwht83dAarcFtXUCBSyX35OvIvsR42ckXLvcAD4SocrZhWf05kpsoY7t83GIMwK2xvL5Ro4Z9WCV9cB+FslW3WZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtlC+gjkald5hvkvmC0T0FWt1sp+A69zSnaJY8CEuTk=;
 b=ln0z9Gprv+jo1T4PahMY1LxwHka/WJKKVqFHLIXnN77xELnMCfCyCUS8Moyo05ap7FgmczbrbP4ePuU0Kf2NXs9LJWZaeP4VZKry6YmYBrY3nk7Y4dZX1NmMrNLVv774v8aRLnf+8z8Tpm5aQzLKXj35t53CpWKoPKynAvRO0uiS5wBal8VShuLukcHC6hD0PVhXAwBeLDXNgZI1Tiu2Bymz2PjNIaFq+MFd+nNJJzf3SnfATZh3yRoyRGplo9llAD6purQih2kMnT4C9+LuM9Z3WalGRkqTgKvJrZFKG9pMQbiCw4b5M7/BXv3ygX99HGZwWsSZTD/l/EG4ARrqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtlC+gjkald5hvkvmC0T0FWt1sp+A69zSnaJY8CEuTk=;
 b=WWBA7S3pp162w4TNBq2uz5xTBGZrxCnJXhbWrpJwZLpP9wnfWx0M2ZTUt3GpfgdYe/umBsLMrfqdjMICMxJ75gqJcu5UM36/cNPntKzfGZRPUrMXHDQb6sgrQvAeDUdmud6rWlnMNm13WsQnnvJq0Ag/QIIUI2+KTvv0MN6ltdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH2PR13MB3702.namprd13.prod.outlook.com (2603:10b6:610:a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Fri, 8 Dec
 2023 07:00:22 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::d3c0:fa39:cb9e:a536%7]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 07:00:22 +0000
From: Louis Peens <louis.peens@corigine.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Hui Zhou <hui.zhou@corigine.com>,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: [PATCH net 0/2] nfp: flower: a few small conntrack offload fixes
Date: Fri,  8 Dec 2023 08:59:54 +0200
Message-Id: <20231208065956.11917-1-louis.peens@corigine.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JN2P275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::20)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH2PR13MB3702:EE_
X-MS-Office365-Filtering-Correlation-Id: 1494bda1-0fe9-4b07-fc9b-08dbf7bb5883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I5AghBHJ8S7zHE8nC5hLQO0vyubdFrqRgsGocSzKDfrYevASiwsfVD86hTwQyRLk1qSTqJyRyLqNj8Fc7scB+jWNDsYcGajsMa+Mz7acQ3jVhE1JsVIdCFxPr73lItQTu0HARjRvLr7xRpa7hJo2RDDTUt9ByCvzV5Djf/I5UBk9b7oCxYCnLAE+OHq1dP5Izy0g6yVaeecQLvjBLnHOkaBSqhu7aFfZ0CWVjKI4jj4Q3Cmh+jn9OlJdX3P9piqawQKWlYTfkOr+103YS1+m+Aad9ksuoadfmdnT/sjGo2o/NW+gmWlHKVQIzMcat4q1yuRBhclr8EA2A+SkCV5NhBqCa6siB9E8LjotYZNgeCd8DATcpNinXL+D2xK5ihTN9gEB1hYGt7yVZH2/qIR6LRszYG8AOrLttkRzIS+KSfKJKmHgJC7yXDyogYZoVJ1nOIbrEjXH5ElIjM9ixzU1dUhCbs0KEnrlj34mqkCF87rk1wNmnpdmZHcAilew4VcgpGRQ+KDQUZndtBmS9kJbJuDZPCRfgkU3lKJ4WvKeMMmq1+qVyO4WLT0Iuk8A5gTxuVDPAfN6X4bsSS4cPZStalIhAbLT4iEZ/d3q1HF1TeLOEv196JE714c/SgamiA8Vl+lJ9GaD5WHDHurM0vcmvwdo4M9CSLO1dnJKnMl9C2g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(346002)(376002)(396003)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(26005)(1076003)(107886003)(2616005)(2906002)(66946007)(86362001)(44832011)(38100700002)(8936002)(4326008)(5660300002)(4744005)(8676002)(110136005)(66556008)(66476007)(316002)(6512007)(6506007)(52116002)(36756003)(38350700005)(478600001)(6486002)(6666004)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3UfRLmq40NZjnyWC0oDXVu7JyiG+PFi0Ff6mCAJat+yoOCWbMlroYUoBYi9?=
 =?us-ascii?Q?IQS99dxDD4V50W5QgRHC4/dyIqS40m+5CTw6xQNzTXXa/QDQLYHUGFz2pQMn?=
 =?us-ascii?Q?8kb/Vx8FEqRmmsk37iPT2CmeFKIuTshQiIOGUBg2TqpSr885B3V6v+TRuFfU?=
 =?us-ascii?Q?eXQxjjRTERMmuAbzdGIdHXBTQtvG0LPSQoYJmNjJE6muTTyQP7l7xYbqKCYY?=
 =?us-ascii?Q?TNejVRTZBPX8136ZrO+9EuOPGhRQXQYvCC5Gv+aHlKwc/A8K9yC2LDheTvt8?=
 =?us-ascii?Q?pz26V96Aao3Chl8L3y5IN95tc+JJJZnB/OB/H8IumMht4u8vIzOfD4lhoykc?=
 =?us-ascii?Q?n/bvNSUUrX/Gi6XcWEn1UGTBPjolaeHoeppcEsRvyZWye66xQr8egzCTvSC5?=
 =?us-ascii?Q?F2CzPBamzB2fSbP75h/OfqgQ/+qpjn6J9cZ6pwbXG3VrPE+Q3t1rN56c60MO?=
 =?us-ascii?Q?rPhmZxiUqFTZaqPr9AuCv+dvInSeZYXs3y8hHOmmZcB1NyoofBzBuSKtdcRi?=
 =?us-ascii?Q?p2QHkjFyGnjJWKILRS2+5S/0qtivp1asA5DQFAORdIzfQ80ZOo7u2llZedhc?=
 =?us-ascii?Q?ChA4kM/4pCPnSPCY5parBpO++k9zltxclSBx6S+c6RPz0pOSUOuPmIjo8V3u?=
 =?us-ascii?Q?py6EH5Jgoe9mLScLfJKNLkjVYz8AzSSg1Ieeq1zXTmWoLoQD2kP1WlAoqdZA?=
 =?us-ascii?Q?MmYDPajigAKvwNAACJFhLvoWLf0k+uR+aQNmch5+Jx1cMAOhSYwN9057IvUg?=
 =?us-ascii?Q?MomgxZK3cu02p5xuFV2IkWr4vlY+G3FBjGdlLYeY+RPmTUCbakos0qLnV6hc?=
 =?us-ascii?Q?VAe0MUP78K108ZV4UjH/D/dWgkasZhCkzJw18NYzIeG7d1BxonoczhuAjh2X?=
 =?us-ascii?Q?QMz1wSaPDG77qGC0loSbYwzvI0BhVnLl+fgQb6nUBhWRjygTT+C7rBrB2QXT?=
 =?us-ascii?Q?ARyxyGxomfutXH/T4bX+R/sFh/oyGnxaF2fI3PmYAKXBwhiNV9FzhnEbYwyG?=
 =?us-ascii?Q?SFcOS31IclbcKJhMtAkSixCL2gqfUFZNwDx7SQp2kSNuMNJZK5mc36UKhZ4e?=
 =?us-ascii?Q?K6HZ+jeOsP1SrKgiEDlgGTabTzpDajYLLnwMeU+wAIGzSK6XFdNNvgZFPxB0?=
 =?us-ascii?Q?GMT2of0fj0U9gmzpdX0nfDTZoD8Z9RZACMXl7iyf7vt1fy5lDyPGeDawcgTd?=
 =?us-ascii?Q?++AY3YgxFQl9Hny5RwiUqKtAfDw9ByC/XYulvoa8iUBfBUfxMVHa+cBTSf/Y?=
 =?us-ascii?Q?2oOE4QgoAkfQC7ZY2bpqRL9fk7QJY4hykeajp9vvlP1zHeqY9v+ZG4Ti21l+?=
 =?us-ascii?Q?+mutW+H3L37RujBSd8PQD7fMo1fmdes5F9lr7VGHktDN0jXjRtQ80gg8J+bx?=
 =?us-ascii?Q?fsPIzIWmZmwR1Bij2z3C8YoU9qJ2yJ+zxLR5UAwDL/fZAJXsbkz4+uCwqJ8I?=
 =?us-ascii?Q?CxpDEaQdz6WYhqqx4qQQbbgC94fYHzH+UXVkIj78Ta8/HipMHcesAxG393NL?=
 =?us-ascii?Q?n7uVHYpgpV3dQejGDqBIQ/DNr3J8eIshf/0gg90f0kDg3UKCZDR3cKA1s93y?=
 =?us-ascii?Q?TkUuAJ44s2mtDtCD+x+Ex7KEFU+Un7i7IuJGH297E7MaQVIXBskFL6rl7EdN?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1494bda1-0fe9-4b07-fc9b-08dbf7bb5883
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 07:00:22.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wq2voqW23HYSXvZ+LOjSQUdu7VmxQ+9PJgTr1uxC/XsjStRxay+xN7TtZ3++26OG3EW9rgbo7N89T4zTbCt6IHCb21Ye7IdSnfiwzx2LPvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3702

This small series addresses two bugs in the nfp conntrack offloading
code.

The first patch is a check to prevent offloading for a case which is
currently not supported by the nfp.

The second patch fixes up parsing of layer4 mangling code so it can be
correctly offloaded.

Hui Zhou (2):
  nfp: flower: add hardware offload check for post ct entry
  nfp: flower: fix hardware offload for the transfer layer port

 .../ethernet/netronome/nfp/flower/conntrack.c | 42 +++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

-- 
2.34.1


