Return-Path: <stable+bounces-83305-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B2997E12
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 09:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FB1B25CB1
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 07:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549691A0AF7;
	Thu, 10 Oct 2024 07:01:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CD12AEEC
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543676; cv=fail; b=C+TnSxSmCPFnKOlV8iCt3usWKRHWVMSbCuzgjVZonTsvfbOoPBLuKxLcr1W83QQXpEpKrxVcoeMUXMceftyDvw5INcQqNi09KNnqh+IU7vK0m7hgsY9DrbS5Hqotd/d40Z1EErnF3E4flHnpeznaZv7U25KuEbiy0R4NrOC3oaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543676; c=relaxed/simple;
	bh=vMpDUwHeCTzTFBOHqPTUsIl8J0zsMtWXdLt0qkfqAuw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tiM94msrdEJcO5vvJQZsgpXtdGM6uTeDEGwfbSFA2OPEjL29IC2BzROrfeIm/D3ZdZuLuyWHvUAnZrN3g4ZFD3oL6oMWfSu5iaBHE2sV8YnXI4G35TNHePcowJktq6N2NlNSM1EGW8ycyKNEaTrvQPqRi1X0DTOCZEU7UoUpL6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A5bZOG000671
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 07:01:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 422ve8wcyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 07:01:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UOSyopRaoFRUeuBTw4t79ohZi4b+ZtqNVs4inPuptxid1YZXxFUboSLIr8YVE5diC7OI3NiqZcw9ArfsCDMADUM9T1qFWhQBsOknj8kmLVmBKwx7UgSkzWObxKT3odbDAiUkyUWbVjmXchcNqsQZy+IixYlZWWfM7nObHnPEu5k3EXQfajOz1GJ8Mq1LwVoEOTBz25g7pS0X8RyIbxTGqkQjIL7qb1wRC4R771GHJN8u2M40hTFnL3isQXuHiDG69p2Om4y7uwnLMt0INOjHpZodegLqvOvyxtKV8mse1YR0tSNZwYvm99MAbnBL1hbkZRD/tXWM373sk6W1dI51sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtnfUE8KIVdKJ1mv/tZqPclFwZT2J0OLEpev08KLni8=;
 b=Y/0zyKIYWqxsQ7AwOFuoyCpG2n3qpB0O4ZJZcsm4SJk1rsNLE1BvEwtx1xejWcoKgSQPiGSnuySASVFsdc5qM7kbv+V8x8n7QujFh2x+Q2KQTrviiR1VWjlbiNoUfhF5YAi47ZQf3FSg+iENerW/YrYXbXISs386GreWnH5hRpR1s9noD1LWSu6kbyGO8Ufm1lH5K1aOgU3IWTF4BaLCEsvCL9uJDoDolP6JTQI4SobPT/7PCQZXVnhBUXWKttHgWllcdCjBwEcZDy5rrzZExbJEUySlV4QPIm3Gmw8M6qxbmFRca9Og3cZ0YX/Fbdf6D3crYapV0YIJJhIkWsrARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 07:01:09 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f5f6:a389:b6fc:dbc3%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 07:01:09 +0000
From: Xiangyu Chen <xiangyu.chen@windriver.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1] net/mlx5: Always drain health in shutdown callback
Date: Thu, 10 Oct 2024 15:01:07 +0800
Message-ID: <20241010070107.596981-1-xiangyu.chen@windriver.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::30) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|SJ0PR11MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 18085b9c-37ce-4381-16b5-08dce8f951b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QkPqYBxyIGt3aRfPZb+RGxnyQ3ZAp1pIkdJ9Aq+bn/dAyw0g94M/BBlW0S2s?=
 =?us-ascii?Q?oYIIu+xNVqg2LFZrEAP3DGuafnyRRv8Xxa/iX2Nz866jqBDN6g1cdZc9OE9C?=
 =?us-ascii?Q?WtZCzk1FqG4wsOwXt+2l5Q5PCtFeEQbATR+4FUx1BpCmRYP1RlI+d98gmEBe?=
 =?us-ascii?Q?bJymcK4ggvL9qelFRYkFUnn8eAhYI5WOIGvgN+wehKYFXGld+2y/FBKjcqUw?=
 =?us-ascii?Q?SySxR5nFsNHImot4aiausNYfo143m/Twae+o+sE7uBJ4uJibL0nJB3l3ciGb?=
 =?us-ascii?Q?cayllRwLnOGos8oJF42A9infZqM+2DEG5AKxgWWRMcLsAs+TBYUsE8JvQIXM?=
 =?us-ascii?Q?qVvGG/NYJwr2Lv5Q7yTDw2UXic7a3Ec+9iH9FIJkei+7D19ZSQpjwFyom/Ws?=
 =?us-ascii?Q?j6I+kmnr4GMxh0yYsVZq2ojl/aVsvpALTv1h5/+8+zjDjugKjS8btBsTlmJ3?=
 =?us-ascii?Q?B6uRLo1sT9yA59mO2T/cvlDolPetKYAfcsgC2p2LmRtE+rPdKRhZslEjc/GU?=
 =?us-ascii?Q?g7WjsBqdtY0nzwr4PKyb2iBlNHyMicCJf1U98i/7kNK82fYCr4M0J84+UYkZ?=
 =?us-ascii?Q?ONa7xlGpouCWpXwRs2doo7FoNZHIipFDz3Mt5LBlrRk6AfHuS8/jRqAdnq2E?=
 =?us-ascii?Q?ybVC0vExLoRuup3IOhnaJMjOioPO8GJ0SZL55/ryIkTybsA95Djut04qup+Z?=
 =?us-ascii?Q?/IZcNJn7ZWdB70IDlqeb7gVU1HtLeZsnGf498BiIu4CF2mO1IbvJOeLQs2Zc?=
 =?us-ascii?Q?kEKsa141j7mWrRx0d8J8648ZvZug/aBy4wK+A0KawoRKg/efu1uFJWWtuGZ7?=
 =?us-ascii?Q?uimGisu6QBQKGtbcbtCsA2vEseQ26POc8eAFXGOqH3mrDjIV89fA91fD9yDu?=
 =?us-ascii?Q?YhYWKok8bm5BiP1+7QGQkqM9bpkt/z5UtYzChVUTnFDW+ONQc5/dYjHl7Mu5?=
 =?us-ascii?Q?sc8ulmPwvIWuFvgwNmnMWJbK94gNCpr8kvblNz/4CD3NNbD9qaqFIIM+XBI6?=
 =?us-ascii?Q?334NvkEKgOv9+7M+9i0kqwK2QOoaJclHM1iO+oKNJMO3HUk+1FuyrITATfLh?=
 =?us-ascii?Q?97GvtIH+z3r4vkjuFuJWplqMT+uqslnubzQ9s0VTK34HjzO6nz2eQCpvbvUC?=
 =?us-ascii?Q?HVLw0sJph4Erzj6cK9Sih8Cj2Qs2W3gxwyKEEGpt1jWXWMzi+B4IyAc9OJqc?=
 =?us-ascii?Q?gTkYYbe1vXgNF+C4AfuBKoNsqOYqtTUAps/jUAySQB7vYJiuEtODDhmfQF4F?=
 =?us-ascii?Q?+H9PurjKNqH2OG5BTG4ayKd38+dZqJ23jqxM29LBxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WZNZhv4sBwls8WeeBNrQb5LyYA3OAZc8NUvyYLvOTrSoy5ba/R8UwLfcMBWX?=
 =?us-ascii?Q?y9W7ow6zvLeeRk1qC1GZaL6aAsGMks63SZ09q41rzs+Id51nBLgqZ4KpYbgG?=
 =?us-ascii?Q?J3xGV32GSXIAkQGoyTNEtQ4rwfFLMJ2jbgoRoncHlXoB0zWSGN5DH1xjmSZm?=
 =?us-ascii?Q?NG0a0vqDzhEvni39AwSHf92oQsjhjmIgaPJjh2zBWk456ZZsm1h71VTCkBsb?=
 =?us-ascii?Q?w+MdFi+IBkYfpnohKtcwKNem4pegHDt7XWNod9g4APfSPk8LFJJADW/VBVxn?=
 =?us-ascii?Q?51xF26MWtLzmBE+tPpiAQet9Wrwd4ofcilrr1xUdKDV24hbwJBKgurmKXrLw?=
 =?us-ascii?Q?f5yQFn1OJsWoAjNXNlE7h8Ptd8XtaRLP6QbvZshfug+x+831Z8FblCAnwVGn?=
 =?us-ascii?Q?jCdnQ1b00hj/b535Ne0TPSR32//xBIYDlGtfFsDvTeMdBhuOOcq3RWFaMX9V?=
 =?us-ascii?Q?ATGsEad/RRkIE6p+FbQ9biUJhRaImu6KoMu3tv/5FB7bI71e670wlAluoMEb?=
 =?us-ascii?Q?4MzWgaH8X9RphDUyWhGGycPw5+7tbKJO771QgwOO7dWcW9O2IUNJRYvNNwzp?=
 =?us-ascii?Q?Q/XEHhvFzL6WI+8WVND7VCnpZkVA8SVieG+Q12gmX966BfEL+8xtWWdr7Scd?=
 =?us-ascii?Q?buOidaQa0FbALSAt8b+8j3x8LP5qBLuLVCehd8JoxvGKpfZEgszJRKPOsSXU?=
 =?us-ascii?Q?+SRCAnn50BAlVuhhfmtMbt6cVSfxj6C61LPKaZaWPlypEshxwxmkkb+KNDyc?=
 =?us-ascii?Q?nDsQW6cs/3jbjdz0jY39qgy8wqHbi/GQpgZBM7nP84ZBhpqK4lCOpbf0qxXB?=
 =?us-ascii?Q?r2FXK3dT1wU+xIqCGJVis5oCNJQ57oVxeijEQLGfXYYLBqJ+ORJNZHbt5g3P?=
 =?us-ascii?Q?3mxbKQPmlk+XEtG5/MzumHKn1qvTV7BBRvYrCdJ0s9voyz/QDqZSMMbYiAaY?=
 =?us-ascii?Q?/x7X5sJa24uUPSMcY1jlDC4Togu5KQhYKArN55GS2WNisMp2CdbLTl48NbtZ?=
 =?us-ascii?Q?FrLTPSR4RWIwYk8vIR5KQnZoifR5mRVJ6U0g+nDJUkVye5fd1K49psv2cnce?=
 =?us-ascii?Q?Ye/ohe2Re/PgZZRKDd0dYe3kcZKjLJLAooyJTgnrUZxbBFg0f76+W46NIm2E?=
 =?us-ascii?Q?HzRvla3olEOxJMPCzDiWqBy1oZSycLr229ukHXu6V9hy3A3CVO5XyA5eSQF6?=
 =?us-ascii?Q?Y0xyQX4CKr7QDjhwQgOWYjsQAPTNrdiA3S3clIMQRJMdK0Mn4wLUkRU/+aOr?=
 =?us-ascii?Q?+3SU8nk1jPAFHb7f1Entl/FisRr9iCQzkAzAWIZep2en7KC9imIc6wf1Kpa5?=
 =?us-ascii?Q?JqfbscN0+VnN9pxYMIGawH7vAbr3kl2rGMfGYEYLeGu61GsRdMVxquBbj2H4?=
 =?us-ascii?Q?ABU7nqNhyM3wxnIzqXaAtBaZ3kDqeOjVZ9N9/fxMb7mEdtEbOIIOR33PHYAw?=
 =?us-ascii?Q?+lwNdiNHY9Cfz0qKA0PKrufD6sMgu6DndoIjyknqy65Eryk1HgkJqUt5I4bM?=
 =?us-ascii?Q?/W/0c9ThJ7vvlPjic8bjdqeXb0VDlHBL39/ACiQXpWJgDDgwvuRTplpoYWsz?=
 =?us-ascii?Q?o8FD9hLMFAQ0rvaGMy7PMzW/ernhp4xRYBOGh/7R5WIrIw7M6sQoyZdD1Ctu?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18085b9c-37ce-4381-16b5-08dce8f951b9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 07:01:09.7054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r+lWeCGI2C1Tn6QGOjHaIi8sSXgDYjdMj3+69doW19ae47zEkh5QyYu4oIR7ief+d95+VHbqhiMwTvLkm7bdlek7pNbRRTB3041Lcs2Vo5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4910
X-Authority-Analysis: v=2.4 cv=CPp4XgrD c=1 sm=1 tr=0 ts=67077bb8 cx=c_pps a=o9WQ8H7iXVZ6wSn1fOU0uA==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=DAUX931o1VcA:10 a=bRTqI5nwn0kA:10 a=Ikd4Dj_1AAAA:8 a=QyXUC8HyAAAA:8 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=bTaAL2OeqWjxgekj42kA:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 54u1KCw8E-U3hMrMulkYUi-EU875gAJC
X-Proofpoint-GUID: 54u1KCw8E-U3hMrMulkYUi-EU875gAJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_04,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=915 bulkscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.21.0-2409260000
 definitions=main-2410100045

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 1b75da22ed1e6171e261bc9265370162553d5393 ]

There is no point in recovery during device shutdown. if health
work started need to wait for it to avoid races and NULL pointer
access.

Hence, drain health WQ on shutdown callback.

Fixes: 1958fc2f0712 ("net/mlx5: SF, Add auxiliary device driver")
Fixes: d2aa060d40fa ("net/mlx5: Cancel health poll before sending panic teardown command")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Link: https://patch.msgid.link/20240730061638.1831002-2-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Xiangyu: Modified to apply on 6.1.y to fix CVE-2024-43866]
Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c          | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 76af59cfdd0e..825ad7663fa4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1950,7 +1950,6 @@ static int mlx5_try_fast_unload(struct mlx5_core_dev *dev)
 	/* Panic tear down fw command will stop the PCI bus communication
 	 * with the HCA, so the health poll is no longer needed.
 	 */
-	mlx5_drain_health_wq(dev);
 	mlx5_stop_health_poll(dev, false);
 
 	ret = mlx5_cmd_fast_teardown_hca(dev);
@@ -1985,6 +1984,7 @@ static void shutdown(struct pci_dev *pdev)
 
 	mlx5_core_info(dev, "Shutdown was called\n");
 	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
+	mlx5_drain_health_wq(dev);
 	err = mlx5_try_fast_unload(dev);
 	if (err)
 		mlx5_unload_one(dev, false);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index 2424cdf9cca9..d6850eb0ed7f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -75,6 +75,7 @@ static void mlx5_sf_dev_shutdown(struct auxiliary_device *adev)
 {
 	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
 
+	mlx5_drain_health_wq(sf_dev->mdev);
 	mlx5_unload_one(sf_dev->mdev, false);
 }
 
-- 
2.43.0


