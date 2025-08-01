Return-Path: <stable+bounces-165711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C03B6B17BAC
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 06:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291AA189B276
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 04:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F717B505;
	Fri,  1 Aug 2025 04:08:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6F61C683
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 04:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754021280; cv=fail; b=ax+FZJUAC0qr+hSH4t+5ppAzVSQ2li3k91uFtl+HnF70rfzmwppKP/gNpNliKQVmAT31tCW+86rnHLDaQbho70cO1Qh9gMURkk0Hha9IM2HFTKGGy0JfEmmh7oU6Wk46Q8cHYLj8F3VeJLNb0rkqWYBR0YJvQscE9xyk1qAWOa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754021280; c=relaxed/simple;
	bh=k1K79Zl18aL1t55naSccS1DthvGpSukzWQbHayZWkpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIaMQ2GhIDl/qWiUrxvpwDtPVvv1KIAS6OyXd77/yhnHeQU8ZN104uBQ3B4o5ksjO7Z3tJd2LZHzKsb0nhzlZeqJJhLMPMvephK4/dHIU5pKbhMZ+4Hv42g1lIx+9wSej4pNT98PGC6pO43Su6NjlzIlCVulVEZKIpGv7dUTA04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 571180ah2581181;
	Fri, 1 Aug 2025 04:07:43 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4888htrrtf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 04:07:42 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTuR5DTHZBQPAT1YuSkPsyjEnamFMzqQtjBqjAewB1tQiL4BM0//u5wPDn4f5FFzrfevcEBqjtIFXjUmXqvIFpSshSYwYEX0iA/KNIMUyOehd3pohrHbq9BZatSByl2JTi75PQMYAOovBceelbjckS8luPzRxMX6GKpDB8Oia66rQ8pWtvD/zvtxRvJ3gE92BVzB8S9gNBBEg4wJsdWeMVMomr3Wo64vqWw6U6zRxZTQkxXC9cU2FLJ82r0EYE/GDGyHIZB/l30rKcpDXbiCPANyzSKtsh9eNkGudsQAdj8dIL4/mo+Ja5kY089xFjbJgjGx49NCqg22GwDoA7YRzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnMoneIPl8735C3Yabh7sX89nTvS6GVxkspawo+De/M=;
 b=NSlaI2/Sn+Be5cdNQuFzhNis9iatzofamD3gI12kRZX89MKypTAGCGOKzgV2wqDGJ8mdMMrF41K6aIClEruiJ8cMGb0UyyRpnTjYMug5c4/DzHKhrYdS3P/oIlZYHGWixTjjkusvEsscfbfZViQ5ShBAm/q21E8fEMyjaInGfuJ+deA2s1jwKJWHdw3F2Z1niiuzQSPfuE9hZ6/aDzVPWLJYqjYWRAAVihaJAj3n1M/ZdyNRktAZbGI6LeMwuoeBeELKmCrYnyd8x4R5uHQJ4yjx7JK29hlCF0GnxAvkpo/aUnCfqp8xiZwCvblOyMBSe3pOoa/ytnDz6yHp8FB5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) by
 SA3PR11MB7485.namprd11.prod.outlook.com (2603:10b6:806:31c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.27; Fri, 1 Aug 2025 04:07:40 +0000
Received: from DS0PR11MB7959.namprd11.prod.outlook.com
 ([fe80::a6d6:fbc:7f77:251b]) by DS0PR11MB7959.namprd11.prod.outlook.com
 ([fe80::a6d6:fbc:7f77:251b%4]) with mapi id 15.20.8989.013; Fri, 1 Aug 2025
 04:07:38 +0000
From: Qingfeng Hao <qingfeng.hao@windriver.com>
To: cve@kernel.org, gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, qingfeng.hao@windriver.com, zhe.he@windriver.com
Subject: [PATCH vulns 1/1] CVE-2024-26661: change the sha1 of the cve id
Date: Fri,  1 Aug 2025 12:06:35 +0800
Message-Id: <20250801040635.4190980-2-qingfeng.hao@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801040635.4190980-1-qingfeng.hao@windriver.com>
References: <20250801040635.4190980-1-qingfeng.hao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::13) To DS0PR11MB7959.namprd11.prod.outlook.com
 (2603:10b6:8:fd::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7959:EE_|SA3PR11MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee19da4-60d1-49a4-70dc-08ddd0b0f3ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vYegGYmKUwpOuoG33hcNU5pYG/PLthG4QBrAIkS9U4qDW3Z9uMeBKroxwlij?=
 =?us-ascii?Q?bdPrSqdLEj9TH3ha5fHmYC20+lMHyQmygl1slyeU57QLddFB0LKuB0L+c6Ka?=
 =?us-ascii?Q?JFuQD+zcagEK4Fe2jDyDJOmX4bvTSpLnKI4TSeC7rOu2IBb3trwkbk+GEyxy?=
 =?us-ascii?Q?BwZvD+gdjUleISI4dtdNhXQ8k+yUebxFjqzQ1p+ezfeSf8xccXTQ613aNo9I?=
 =?us-ascii?Q?/avPSwGlHnBxk7eZ1z9EzIH6XErJhhX4m1C21XrI/PrrUnOxB85ruUR7kOQ+?=
 =?us-ascii?Q?SYLA6ffEr1GIYRlP5ri+337AaeDf1GNYypzptXklnIRZVNFNU13FXVuFokRf?=
 =?us-ascii?Q?vIhwPQRhzz7WMsN/bMc52ly0C0M5eQ/rfqF2NZC04OnJoh9nntcRoB4kWwP4?=
 =?us-ascii?Q?HVzjX1bQIF8LaP33ZLNaHw7VWlmVi05YMyiJE5CUXTn67jbWfIJVBqYxUsPT?=
 =?us-ascii?Q?Cm24w6JSRPdKA2SUYh1sjepeL6OJhm4uSCwe6IWZLvlBleGoZXo/mKmMAcJ9?=
 =?us-ascii?Q?kDyyJTOKCYoHYB2KPyTWQkbkZ69D5+U0yhTu7Fsi4WTPk+KWzsuEYusIw/0P?=
 =?us-ascii?Q?M7G2/yEqdCf2JSrFYVp0uItXAEMo7PZLtOD+ozSWddRFz33+0g9kUgXsW9kj?=
 =?us-ascii?Q?eoj+fGE1VGg4rOHHK00aelhDKNnOhzJBw5fpCRJdMJcaRk7J1Tssd9mwYob1?=
 =?us-ascii?Q?o35UhGb1Iz1O8XwGfeSpiOAXRVIYylzTp+dRJ2jzSEK7KDNVXkQYi3+FPzgT?=
 =?us-ascii?Q?zVyR8lcqw22+ApiRXzox9PXHcQjDQ1qCne34TtM89LGqGhZ5Vo6ck3I4CNsJ?=
 =?us-ascii?Q?tnVQyPRUpBRODCjfYhQm2DigGr7VS9SVShGiLBifBeBUlZLtnpjc7RuNRiBz?=
 =?us-ascii?Q?BKfrO+neXCiRmxwCXxa8ChCPPBg7QSxKy4IBuirE96lDKbUl38j4084Sn33l?=
 =?us-ascii?Q?MbT36QI5bChJo7lFcYDs2e5aUusjwgdnA+x424otjMdzo+bK2ae6pUA4+UxL?=
 =?us-ascii?Q?n4euwu/2gKbAFC8u0vBHRRP3RuPAAQu637wZG1Kpi8cO8DmXpwhxtOon2Lje?=
 =?us-ascii?Q?FOWvGIz6YWaXdogOrwc6Z58w9gxoTTXDPBCTMQ+eqLozNnr53CNp8TzPIqCt?=
 =?us-ascii?Q?YIVHM+BH55OzJ8mZWJo8kMb4YFHyL/8wN14PzR8wK0oO9JjX01zupc4eTXd/?=
 =?us-ascii?Q?9I+I2bhNBb3YZMyASEhr1Q5mBgVM/7MFZe9/IJZQbBJ+UC5utB/deisCvfLY?=
 =?us-ascii?Q?brpqtaiiDSVRjxk6f642Ct07UUoPf4yxeGNlCdtzqS9bTXEjK2IJhqrjTFyP?=
 =?us-ascii?Q?dHze3YcmFhfGheRd3bgnb8ugsGF1OeyqcymjWRJJpY9UcWYYELU3jTlsEAg3?=
 =?us-ascii?Q?ktljCT2Dvc5KFIlp43tpd8mt9IUz94+HT+se5k/CdfKARCfMukWhB9zhUU5o?=
 =?us-ascii?Q?F7ZWjeZTtZyz2hAtNMTYHXpyLnQ1L1qp1JdbxyR631YXLGPaNfd2mBDydggZ?=
 =?us-ascii?Q?yy3vU/P75PAai/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7959.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j5bxFy0d6VzBRCFjvbqe9eW3S+XMTuMtmM/17dvPh4kHReck0MVRoPj7rbIS?=
 =?us-ascii?Q?F5SI3vq8sRKBO10dqBZ9mVNKS4PWB6+ggfWnaOcyCVmHsEyh1D3ukSoufBVk?=
 =?us-ascii?Q?05b7nglkZUxlVdz9bOYvuLzPuUPH+QGpIUujSW16ShmiEqisMA8qQl2hlsbF?=
 =?us-ascii?Q?HOLtJy1NBGagQFg/kajCZzmGBYC5NG/xHScPk6bQzmc+Vr0fqJ2HOH1AduCc?=
 =?us-ascii?Q?Xf08aiB6VdUropkSzvQkCdhAr12cGG8QNnS/BowdjrB964SX6NvRYvsXy28B?=
 =?us-ascii?Q?xnXYVIX4jtVjdRkkUHTMQ46GxvkqFV2k1cFBQ814h8PyplPzIljPx8YpJe1t?=
 =?us-ascii?Q?QT4pGare7h0D6WAv3NJmdHlHyG4zIo5zNuVKX63yLCGKJKw5FGTphXS8mgv1?=
 =?us-ascii?Q?Tgfr3YH7rUTl3DIrL2wSO3/A3tELiZ3WMpwiuGGRh2XZheIrGvBgjg+NY0Ed?=
 =?us-ascii?Q?UPX8l2vwUJk+Bkq5lI+hJuCDLHxmrn0n+VIpBIyEtETzzbGPrHbKnd/Mlk8r?=
 =?us-ascii?Q?UqaVC6Zz1707ZvvRW49ZzlzB4reYNd5H8iALtXQOs3k2d+yV4plvOXwA4BPj?=
 =?us-ascii?Q?MyWiVgjpXbNPIzwzHlq+qw/RbuylhA87C60WOX+OExPRlOLWSs3inp92a61C?=
 =?us-ascii?Q?v/YjM3o89m2eS2sTEHWv7X4AbXcLnRxLP2GifvzCcXYNIFxODfZ+Bru8NR9d?=
 =?us-ascii?Q?xGAE4THsz8dswNkH0mKJa9ZGwZO5x+UulPSTO0ta3MJVYAy3fiip3eD46KIQ?=
 =?us-ascii?Q?UvDh42EaAlNXubtpQOLkmdgeGzRkSbEvlaN6IX5BdROJqDsY9yiAbHDuIWr2?=
 =?us-ascii?Q?rdSSXIQBZ5NGVEN6bdXhBQH/c55BoPR+EXIXsHnb26n86cAV/vXBIWTIK6y+?=
 =?us-ascii?Q?qbRpBbIrAZJnCiRN2acPXyftuezdC9gD6/ufXk55RIGwsF9Rae1hZBQJKqf8?=
 =?us-ascii?Q?1uPCeA1fTx3+fQ8ZX1YTAxAQYk3MrKDAMcGRUyj4KTGQ+F0upc0x7j/cepxn?=
 =?us-ascii?Q?CAVpt3KPAuHCcCnicB5ztAqL0kwcZnoymchubPlYNFEpeMWPLiolB5TxkLuL?=
 =?us-ascii?Q?RizVzSihnKCD6OOXu3U6We15piSDfivaMRrk+AwPJSGVfQDql8MAVDIVf+Hy?=
 =?us-ascii?Q?A3un9sK/hAtOtFxIh7wSPpntUbVuPE34F+p1psdwcYBXCAzEGtypLT62kvZn?=
 =?us-ascii?Q?UmqFtBBEaHd9/GHbJ8OG9L2/CgKC0bZkJWzBulEn96KEGpIpRqG+pkvVUExx?=
 =?us-ascii?Q?ldqtGs71uot7HGPCkR2t5si26PmTDUTloWLVv/S8qULZSVuAPaMIycH2nK6H?=
 =?us-ascii?Q?o6A4K/5A5HOmPIDaZoPR2gV0aqBZu0Jzel4qAP4wb0NMvUAnRLrXjHGH1evY?=
 =?us-ascii?Q?/OoEYlFUeOkrNYu+ETK0UrGhn+nTarBLP4Coq6Ogma3wvZt8t7tsQL8Bjms/?=
 =?us-ascii?Q?2lk7cG182A9W4v3IBMOEZ6vtVBlGfC4HMoFqY49F9/2nljyDTKdmeUKyWx40?=
 =?us-ascii?Q?payL8QRCe4VtIL02OGc8FNE6f4bn1WOhZXRHqC/sXel/veRVUbNDmKZH3NNv?=
 =?us-ascii?Q?+IrKBtgCTJ2BKgikLPkx5UCHky3o+buRnNuKcYoOrsQ6G5a6FccI13dJvSMx?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee19da4-60d1-49a4-70dc-08ddd0b0f3ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7959.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 04:07:38.1466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLNBR87YA6UB1YgLILcB7PaOS/5ZjKH6ifWZNCRZ5OB4RV8PB1nM89U2Kj1rS0TkPYP/Ex3EqZ/+qhaDiYfyKobRSJstsd6DurshMSgTskI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7485
X-Proofpoint-GUID: 8N5DIeiAixH-SQZwpHaAO0YBNrfzNxDR
X-Proofpoint-ORIG-GUID: 8N5DIeiAixH-SQZwpHaAO0YBNrfzNxDR
X-Authority-Analysis: v=2.4 cv=ZtntK87G c=1 sm=1 tr=0 ts=688c3d8e cx=c_pps
 a=Q3dO48fyEwVoXzhC5DUY0A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=8cwnhZt92UZOMXfodO8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDAyNiBTYWx0ZWRfX9ag+iEg2ArDe
 9c3YOd2EuGb2l7QxmigyMmdtrVWe1kGOfYYGLXQDyUcQ09kXasVb6QGiPAcZiGo3SvtB+pWDDAP
 nY1puAOzHBVJduzowwy62+8VJ/SqE8scRyL1H1PZu9y8qTBI/1xRf2jWLA50Vdyd7akR3Tr94Rn
 Vyow75+EEw2/tGan2idtmVMakVgu8592/BJoVJrAAxoOIQG1GZqhZwyIN/jAoMl6zbjIwtq6BK0
 hTwaJsWOHhE6yC+74AU4ch9z/62+58h5SuWyjNVifrrF/Pz1VebmCgtykaB/I0sgnf71P7dN9JH
 wiUwzbshKv6c+AmtlKAIHWqK4IftLAi+Ju4hQlhVpCNyIv7OIE6bLawYsrKcvjl8OudkxoIFDQV
 eWvSadV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_04,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507210000 definitions=main-2507310086

There is a fix 17ba9cde11c2bfebbd70867b0a2ac4a22e573379
introduced in v6.8 to fix the problem introduced by
the original fix 66951d98d9bf45ba25acf37fe0747253fafdf298,
and they together fix the CVE-2024-26661.
Hence, update the cve files accordingly.

Signed-off-by: Qingfeng Hao <qingfeng.hao@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 cve/published/2024/CVE-2024-26661.dyad |  6 ++--
 cve/published/2024/CVE-2024-26661.json | 46 ++------------------------
 cve/published/2024/CVE-2024-26661.sha1 |  2 +-
 3 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/cve/published/2024/CVE-2024-26661.dyad b/cve/published/2024/CVE-2024-26661.dyad
index 120c36d66..fc4c2091d 100644
--- a/cve/published/2024/CVE-2024-26661.dyad
+++ b/cve/published/2024/CVE-2024-26661.dyad
@@ -1,5 +1,3 @@
 # dyad version: 86b352798e93
-# 	getting vulnerable:fixed pairs for git id 66951d98d9bf45ba25acf37fe0747253fafdf298
-5.9:474ac4a875ca6fea3fc5183d3ad22ef7523dca53:6.6.17:3f3c237a706580326d3b7a1b97697e5031ca4667
-5.9:474ac4a875ca6fea3fc5183d3ad22ef7523dca53:6.7.5:39f24c08363af1cd945abad84e3c87fd3e3c845a
-5.9:474ac4a875ca6fea3fc5183d3ad22ef7523dca53:6.8:66951d98d9bf45ba25acf37fe0747253fafdf298
+# 	getting vulnerable:fixed pairs for git id 17ba9cde11c2bfebbd70867b0a2ac4a22e573379
+5.9:474ac4a875ca6fea3fc5183d3ad22ef7523dca53:6.8:17ba9cde11c2bfebbd70867b0a2ac4a22e573379
diff --git a/cve/published/2024/CVE-2024-26661.json b/cve/published/2024/CVE-2024-26661.json
index 91d11967b..7c7b2a818 100644
--- a/cve/published/2024/CVE-2024-26661.json
+++ b/cve/published/2024/CVE-2024-26661.json
@@ -22,19 +22,7 @@
                "versions": [
                   {
                      "version": "474ac4a875ca6fea3fc5183d3ad22ef7523dca53",
-                     "lessThan": "3f3c237a706580326d3b7a1b97697e5031ca4667",
-                     "status": "affected",
-                     "versionType": "git"
-                  },
-                  {
-                     "version": "474ac4a875ca6fea3fc5183d3ad22ef7523dca53",
-                     "lessThan": "39f24c08363af1cd945abad84e3c87fd3e3c845a",
-                     "status": "affected",
-                     "versionType": "git"
-                  },
-                  {
-                     "version": "474ac4a875ca6fea3fc5183d3ad22ef7523dca53",
-                     "lessThan": "66951d98d9bf45ba25acf37fe0747253fafdf298",
+                     "lessThan": "17ba9cde11c2bfebbd70867b0a2ac4a22e573379",
                      "status": "affected",
                      "versionType": "git"
                   }
@@ -59,18 +47,6 @@
                      "status": "unaffected",
                      "versionType": "semver"
                   },
-                  {
-                     "version": "6.6.17",
-                     "lessThanOrEqual": "6.6.*",
-                     "status": "unaffected",
-                     "versionType": "semver"
-                  },
-                  {
-                     "version": "6.7.5",
-                     "lessThanOrEqual": "6.7.*",
-                     "status": "unaffected",
-                     "versionType": "semver"
-                  },
                   {
                      "version": "6.8",
                      "lessThanOrEqual": "*",
@@ -87,18 +63,6 @@
                      "operator": "OR",
                      "negate": false,
                      "cpeMatch": [
-                        {
-                           "vulnerable": true,
-                           "criteria": "cpe:2.3:o:linux:linux_kernel:*:*:*:*:*:*:*:*",
-                           "versionStartIncluding": "5.9",
-                           "versionEndExcluding": "6.6.17"
-                        },
-                        {
-                           "vulnerable": true,
-                           "criteria": "cpe:2.3:o:linux:linux_kernel:*:*:*:*:*:*:*:*",
-                           "versionStartIncluding": "5.9",
-                           "versionEndExcluding": "6.7.5"
-                        },
                         {
                            "vulnerable": true,
                            "criteria": "cpe:2.3:o:linux:linux_kernel:*:*:*:*:*:*:*:*",
@@ -112,13 +76,7 @@
          ],
          "references": [
             {
-               "url": "https://git.kernel.org/stable/c/3f3c237a706580326d3b7a1b97697e5031ca4667"
-            },
-            {
-               "url": "https://git.kernel.org/stable/c/39f24c08363af1cd945abad84e3c87fd3e3c845a"
-            },
-            {
-               "url": "https://git.kernel.org/stable/c/66951d98d9bf45ba25acf37fe0747253fafdf298"
+               "url": "https://git.kernel.org/stable/c/17ba9cde11c2bfebbd70867b0a2ac4a22e573379"
             }
          ],
          "title": "drm/amd/display: Add NULL test for 'timing generator' in 'dcn21_set_pipe()'",
diff --git a/cve/published/2024/CVE-2024-26661.sha1 b/cve/published/2024/CVE-2024-26661.sha1
index 2e7b06c75..b6301aa3c 100644
--- a/cve/published/2024/CVE-2024-26661.sha1
+++ b/cve/published/2024/CVE-2024-26661.sha1
@@ -1 +1 @@
-66951d98d9bf45ba25acf37fe0747253fafdf298
+17ba9cde11c2bfebbd70867b0a2ac4a22e573379
-- 
2.34.1


