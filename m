Return-Path: <stable+bounces-144727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8D8ABB2F2
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 03:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9373718946A5
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 01:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD86189F3B;
	Mon, 19 May 2025 01:44:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA924C8F
	for <stable@vger.kernel.org>; Mon, 19 May 2025 01:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747619096; cv=fail; b=KecDXFoMYv30TtdKRbtdN7ozQDMkNpSAEUNO19wCrQovBzXeQyPEE4pMWnLRL5AHU685SamvDES6+s3QlmDsYdDcxy4DPMrLy9vH5uldsfWa4X0ACwvKHRp8rFBDyyQfA0ndaQaei3u3toxwS0A8JtFys8GQu6rtXWS+jezTJdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747619096; c=relaxed/simple;
	bh=xhp0nKtTdLlRug7jeMoFyFSTB/wGOe50sqIf+xWhQRw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kHJn0ms3w+F7HlZoVMTaEKMmg0DK7kSOaTSP0N6Eor2a728pGSC2p/DEnIVUK3KAqy4QjIIVzwPkLHr0ieYnqvS43ZewCdwa/fxuBqYKjSyqO/vdWxLiKiBJAHnUq37pZiIts/otGarKebMno/gP4Q+nusdRKJ3LyRIXGo83a3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J1HkwI017100;
	Mon, 19 May 2025 01:44:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46phe8se2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 May 2025 01:44:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dB3ipeJBzdwebfeL9hMhJ98IzJi3sJBtZJzaEGQcyuD2VsCIxe7u4JUOhx8CauDvLCUQ+avvKrM+zpQYwUjmnXFaCpj24eVdczGazQ7dXwL0is0kC3LcBHnmXbrcZJp+0G5qRpatwot/2iyo9oAA+PzJ5vzdKWVbiMmx8PLvxQ073FgXb1rAeXrQu3eNDjcnuEiO+TQ3qKXScfqYXkeets5z8v5M80jkztKrrCQUzfzqy+Bf+JAb9CnzfI6ytL//kevlHyrBabYvrVKWPMqc7OpFBAEVsf624jPfhfcAS5H9cDC4Wqx9S8SrbTnb7gA+ZwJO9vkc1ieob3rheDAfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axnSsQRBS6VESRz8ewQL52Vjkyi7cbjh6dgOnLDcFK4=;
 b=UuM2TSBl5a4yuhfDyilaLe6ezW5XZu8cCP0WXnAfxnWVI7JyA+5n6mXt+5MT9XXHr5hye6kzL4K/P/3MM6aESLBevEIoXNgk3u3S0qPaqLujuT0Xt/tbfRCMiSw2ldN7fVcBmb2QZTu3SUVYLM0L5fJpYcciNZfRaf7iB+aktdA+bT+ogohhrFyU6PpHKo6Kv4R9lPHBPRB8lgCfBg03ihrJe6t2Y6a7ZsDOumorxhYAzWxA4LGdPeJLGAlZGNc5xhY4/m7Cd4tGJusgs2girF1oSeVF2PgOK/qD7ZNeQTpFnI6hGDoJA9v1ZdXBPcbC3X9HoMqkCNMGBhICyRlqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by SJ5PPF3A51834D3.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::821) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 01:44:34 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%5]) with mapi id 15.20.8722.031; Mon, 19 May 2025
 01:44:34 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: deren.wu@mediatek.com, sean.wang@mediatek.com, nbd@nbd.name,
        sashal@kernel.org, Zhe.He@windriver.com, Feng.Liu3@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.15.y] mt76: mt7921: fix kernel crash at mt7921_pci_remove
Date: Mon, 19 May 2025 09:44:22 +0800
Message-Id: <20250519014422.3677354-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::13) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|SJ5PPF3A51834D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b36cf1-aa8d-4904-0ace-08dd9676b4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9QMthdCiT0q18XezR6vyTEdUi0NioAAo2+Wa5HL78kUTozIo5F42+YcwHhRu?=
 =?us-ascii?Q?K4ja32z1uDIztEQxY/J7Sd+0GxwFdyx+U/3CdAnK8hhYVWZwVRzzOQHIzlv6?=
 =?us-ascii?Q?Vl3+a4u7PDJYogmH2mDbCwhYVykCiwAhKjjqF8bdcoOje4/71laEY/lPbcmB?=
 =?us-ascii?Q?GYH9hUCiNuxP3MRRuJumlJ/R575pYTSBT9RZZ87bA4eSnIkeI9RoAv3iie/r?=
 =?us-ascii?Q?2ksZBkw6rD7p7Ife4cslsR4bMw+RF97LPk1x6ZwNptAB7oOKWDV7mo0yFPr9?=
 =?us-ascii?Q?y+ifP3iD6CsEA8haQ073M9y9OxvuFLcsnU+O9+WVN0MUtb0/y8zAuk2hKD1G?=
 =?us-ascii?Q?Gyg3WX3d3nJQn6DJ3gx5vjjWvXzzFZ+rn3LqdoJ+QRzBo7ksTqlOZeh127nX?=
 =?us-ascii?Q?BkXPnqAaHF2CB8vnqv9vKoodX8Cw/PGcPjGpIwkoLxdWYm7aOlz8DY2rRRLV?=
 =?us-ascii?Q?Dg7M6XMyC2rXKlzAjcg4ln94kTdQ+tAgmN9dPl4niU5C1qJ6KVhRtfXmoSUM?=
 =?us-ascii?Q?XYsUkrJreSMXx9f+KNPP98L94gzdvr2dr5PIvnKp5njpBaGHnQ2kGoSr7KNe?=
 =?us-ascii?Q?TDzbWdCkANebveQ5zCGzw3A7zjqvc9q1yXIGODMzqwLlGCEMro0ZNcB9ZOKT?=
 =?us-ascii?Q?tACuBYLwyzheiZ0zFj5UhdzKai+pOt8QI17Cea8djDb6K3OEJrQ5e6L5A7Ss?=
 =?us-ascii?Q?eEopJ+Xv52CuB+l+EMVl/MEgHzQukCNinuyQ/WIm8H8yL3GvVaAA6OWiVhO/?=
 =?us-ascii?Q?jE9bz98eahlZNc+UiW0Kc82nGWUB6aQ9QdAylkBMojUOauRbnsSNjq7rJyKo?=
 =?us-ascii?Q?t1yIaMLwLwjvffqCithw41+OONuBF3hPQ7vUef4QEHOfv7UugBoQziO4R0SJ?=
 =?us-ascii?Q?Kb9DBCounK5CLv7JtvzsuIokd/bRiD/i77pwjRRHtFE2MD/pWpA6Fk4EcEaW?=
 =?us-ascii?Q?dHb+3vbI8TfTM8Hq1RjW/qja0xPcaQPJ2DdYPYraffa+gHKvkXw7DuimSBMt?=
 =?us-ascii?Q?rl5KjPQ2+2FZlNsEwuKnuhlf7FtdjuBniWRHqiy49gMf7XtjWDSE1oFXWBC/?=
 =?us-ascii?Q?NEZvECiC4wJwylzrNEVhS2QZXsGZ82FQZsrOLJgZZ/LfUz2FRbsQjI5ZcqdT?=
 =?us-ascii?Q?mmkj46IzQQS99pU7g+gLT2lefO9dXyUylF0SWFnmcfFChDzlTkPeCthwa1/X?=
 =?us-ascii?Q?Fn8KAOvIfc8cZsP5c67FcGt88qiHgry2sonsG3UdYBKVy+IEOoLNLM3P3LSk?=
 =?us-ascii?Q?y4k3qIBu5mPVad5USQ1mBcwsBx7CA4VULyPu9jM1ixkjibKaFD6r1HfpU1NQ?=
 =?us-ascii?Q?ekKOWs5RwGAz7j13vIIVNomv64SDQbecejBt3OrwaWoGJxYoxfoCRA3qwMsE?=
 =?us-ascii?Q?JzQ5MKMTJZfizksBBYLAvbkMVI5PJ5ND/+5tk+gtLncXMpCPHjS+GZ27m7j1?=
 =?us-ascii?Q?F8SEqIXY9B4gGDbRI9dVIkktOAwu2jXlliCtTJagusQyWMBykb8dCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SI08NxwAovb8EBm47SDC8Q8lNDpyzz+H2EWh0qS/KJlATM9Qjv3BHPhFa2ht?=
 =?us-ascii?Q?X4luudWyTi+RcV/8B809MU7Y5vXqy1GUAD6pMJkU2Ffzk1ACEcDef49iF2CJ?=
 =?us-ascii?Q?hVdcjpL8fNovn9xbULZkXX2gG3Y8mSQdeli7aq+xRr/eN8VIIGV1/AQTA4FE?=
 =?us-ascii?Q?CmPyOkmzO+QbBYOXKcRARluG04vLSPiqvIx8g02GqXNJFvnJj7tKir0hlhGf?=
 =?us-ascii?Q?fQTvR9ucXWsSuHqWi1bI7QGymlaR6CbuxyxtE8VtduHyT1x83uKIU817WsNU?=
 =?us-ascii?Q?5/OMi5idu6rvJRf28LMQiYjhMcnsak8k3C+9lxPURCoLi+tnZMOiC4URm6ul?=
 =?us-ascii?Q?NfCBwOf3mYGDNouzQoskQvIQh2JP9DLbDSWZLyvMBnlcy/J1SzPudVZF1flX?=
 =?us-ascii?Q?PKVHVGjCB7miOFn+ZIw18Cg7siO2Lzm7Ru6/aX9B2WRjy4xFMXtUWV/86Bc0?=
 =?us-ascii?Q?2Ubcf9Tbt08XAsKOq/E+bZa2++OwwGb8dFpg1riKU06q6lrZOGIyH4MZ3BT1?=
 =?us-ascii?Q?8VvzUMqDU+Wrv6+t5bz05vHCQMaJgIbpeRplu/3xB6KQyuJ3ZnwzBwhhzXMx?=
 =?us-ascii?Q?xR7u7sYOEMN8kQtGociGTh/Kb/xcEir+WPmROa+eVj3vUb9nqXu5JuKpOyoY?=
 =?us-ascii?Q?9zLelVJr6IrLOPGue78fANo4YkC9NB7CZVlL+ZBTT6J32PXOewVwaT415MKt?=
 =?us-ascii?Q?RsZ7pPszBYrHyjp4v8yG2cMI6+BfIJcWeU/PX5lHfHis1PIWclKfo4SSiveb?=
 =?us-ascii?Q?zE2JvLmFHcSiW8MF2cEadbGJvjSZWrwBzbOmJ35BwzCWSV2OI/Qz/Wxer6t4?=
 =?us-ascii?Q?qyHpaXribhSq23oR0CNpXS0AOT/Ds3HOVBBYNWqO5lDIS0y+OBOT2H1R+Bsm?=
 =?us-ascii?Q?p2mcACwSqnLLwJd2Ch213DGj1WldMA82B/B/sF93LF+SUh+9RkMhl3NWwFEo?=
 =?us-ascii?Q?T02fzaTdgBnR6AqLEktgF+QzStADGdkNC0R8Ud4CZcbQIVQQXdBilgm2TIuF?=
 =?us-ascii?Q?q/cFpXgNjOp5iOCqz4af/L2Y/6qJgeGe1i7kmHcecXanA8jvUQz0to1g0nDC?=
 =?us-ascii?Q?BgND6YKd2YQgomYSnal/yVkHpWKF597iScKhqKzMTjYcPMf0pt4ZebFDw2iP?=
 =?us-ascii?Q?/UZnXLnfXj710iI6qnBtuTQBNU7898nhb2ONP48M1klKcS+4JhGdjTvrv4UY?=
 =?us-ascii?Q?qRQMniVPnuB+nJY+dloWCq7mryj4Z8OcRBlJyhO9BkOhju1C9VzljDmKFXI+?=
 =?us-ascii?Q?joRxglkSxamWqdooMQn5JqbvRaa5iwL/ZEKxdwSr0cnvHVYeJKZyS5U/cwJU?=
 =?us-ascii?Q?ZdqlERYomFhXLFjV5oEVtDtCKJfRdpyGo6/t5aIYLtQm/63MoC4tZCTY1QuV?=
 =?us-ascii?Q?XCfW9a/K+jCgnOzpLgYOFKug8yuD77oP8ygBHrWfz/cD8pcy+lXFZZcEFjTW?=
 =?us-ascii?Q?ew22xoe4HnFPuH/UB4SLY9jQyWf1yT4t6Yws4omD/E+jCMELjSlTLvFDgVN/?=
 =?us-ascii?Q?tZYGBOI+QoGOPvdX1layyMPh+ZineasaGliI5uhciqmElPDVurKNkgA7gApv?=
 =?us-ascii?Q?T6zMYbTRo08gvOtLCn6IfcRdEwTt5j/LRltSmXVi?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b36cf1-aa8d-4904-0ace-08dd9676b4d3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 01:44:34.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78oiGU+J/0tgC/vIhRF6+U//KSqi2jgg2Q3zWe9OdUB5quSA/nFjjU1bJNfQ/kn4P5MDntmVtq5j6TRMKJKG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3A51834D3
X-Proofpoint-GUID: P_WMm6Lf_jsegRwIZBlBdEfOIIDg7xp5
X-Proofpoint-ORIG-GUID: P_WMm6Lf_jsegRwIZBlBdEfOIIDg7xp5
X-Authority-Analysis: v=2.4 cv=arGyCTZV c=1 sm=1 tr=0 ts=682a8d06 cx=c_pps a=VLWBoSTBoww685Dj7+Q0uQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=mpaa-ttXAAAA:8 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=zh2Hh6dTTspcz_ygnF0A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDAxNCBTYWx0ZWRfX2R5dtD90s0KS dB4I8AmQp9D2UymOqvFwC9efUrb8y6dQeMyBTPMmohLU2GBXhJFVXYG0BednM2/44IXty+szfLR VRAEupNkv24hkOJG/aPPAePVqtQIa7JlT80brS4HFgRfYAwmuTt/ofUgLmp7Yumbr0gKEwQGut/
 lFLB2cofXPnjZRKhSn5LRNZYURP8nM1XoiIlpJaf+jxNdUKiQ7EEMvlru5d4ItYLDek60NPnxI4 yPvQLz+oW3PNir0QIE+JJrb3yOJVKyubxHFAWxgQRyiH5AK4jl+dkdkaWTfajzl/S05AWoB/Zwd D2v+n/YQT2E9eQzF+ElC540UdC8+zhsMspFoKlu+QkTBMDjwNhbOqfMEz2dQCH9+LMjYnDRKLLR
 F5Myb5vOJQJuq+3XiEQvrTIntwgEwopeO/l7iSAxR8DwIQlkRKbfiCAxjJBCFZZhh1wPyvmO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_12,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505190014

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit ad483ed9dd5193a54293269c852a29051813b7bd ]

The crash log shown it is possible that mt7921_irq_handler is called while
devm_free_irq is being handled so mt76_free_device need to be postponed
until devm_free_irq is completed to solve the crash we free the mt76 device
too early.

[ 9299.339655] BUG: kernel NULL pointer dereference, address: 0000000000000008
[ 9299.339705] #PF: supervisor read access in kernel mode
[ 9299.339735] #PF: error_code(0x0000) - not-present page
[ 9299.339768] PGD 0 P4D 0
[ 9299.339786] Oops: 0000 [#1] SMP PTI
[ 9299.339812] CPU: 1 PID: 1624 Comm: prepare-suspend Not tainted 5.15.14-1.fc32.qubes.x86_64 #1
[ 9299.339863] Hardware name: Xen HVM domU, BIOS 4.14.3 01/20/2022
[ 9299.339901] RIP: 0010:mt7921_irq_handler+0x1e/0x70 [mt7921e]
[ 9299.340048] RSP: 0018:ffffa81b80c27cb0 EFLAGS: 00010082
[ 9299.340081] RAX: 0000000000000000 RBX: ffff98a4cb752020 RCX: ffffffffa96211c5
[ 9299.340123] RDX: 0000000000000000 RSI: 00000000000d4204 RDI: ffff98a4cb752020
[ 9299.340165] RBP: ffff98a4c28a62a4 R08: ffff98a4c37a96c0 R09: 0000000080150011
[ 9299.340207] R10: 0000000040000000 R11: 0000000000000000 R12: ffff98a4c4eaa080
[ 9299.340249] R13: ffff98a4c28a6360 R14: ffff98a4cb752020 R15: ffff98a4c28a6228
[ 9299.340297] FS: 00007260840d3740(0000) GS:ffff98a4ef700000(0000) knlGS:0000000000000000
[ 9299.340345] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9299.340383] CR2: 0000000000000008 CR3: 0000000004c56001 CR4: 0000000000770ee0
[ 9299.340432] PKRU: 55555554
[ 9299.340449] Call Trace:
[ 9299.340467] <TASK>
[ 9299.340485] __free_irq+0x221/0x350
[ 9299.340527] free_irq+0x30/0x70
[ 9299.340553] devm_free_irq+0x55/0x80
[ 9299.340579] mt7921_pci_remove+0x2f/0x40 [mt7921e]
[ 9299.340616] pci_device_remove+0x3b/0xa0
[ 9299.340651] __device_release_driver+0x17a/0x240
[ 9299.340686] device_driver_detach+0x3c/0xa0
[ 9299.340714] unbind_store+0x113/0x130
[ 9299.340740] kernfs_fop_write_iter+0x124/0x1b0
[ 9299.340775] new_sync_write+0x15c/0x1f0
[ 9299.340806] vfs_write+0x1d2/0x270
[ 9299.340831] ksys_write+0x67/0xe0
[ 9299.340857] do_syscall_64+0x3b/0x90
[ 9299.340887] entry_SYSCALL_64_after_hwframe+0x44/0xae

Fixes: 5c14a5f944b9 ("mt76: mt7921: introduce mt7921e support")
Reported-by: ThinerLogoer <logoerthiner1@163.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[mt7921_unregister_device was in init.c in linux5.10,fix context
accordingly]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
--- 
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index c059cb419efd..6dee0268c4c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -266,5 +266,4 @@ void mt7921_unregister_device(struct mt7921_dev *dev)
 	mt7921_mcu_exit(dev);
 
 	tasklet_disable(&dev->irq_tasklet);
-	mt76_free_device(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 7effee4978e9..f86558d897e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -310,6 +310,7 @@ static void mt7921_pci_remove(struct pci_dev *pdev)
 
 	mt7921_unregister_device(dev);
 	devm_free_irq(&pdev->dev, pdev->irq, dev);
+	mt76_free_device(&dev->mt76);
 	pci_free_irq_vectors(pdev);
 }
 
-- 
2.34.1


