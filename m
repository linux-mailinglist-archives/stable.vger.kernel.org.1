Return-Path: <stable+bounces-145735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734FABE92E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 03:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AFDE3BA87B
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 01:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131281A5B86;
	Wed, 21 May 2025 01:35:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAE8146A68
	for <stable@vger.kernel.org>; Wed, 21 May 2025 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747791318; cv=fail; b=PN7wSXLXMYZtn+6pIWO8dwlNt7XEYsjGSEcSagoGAQvdEbyHddSEF2b5oAzbqGaRVchL4kjjAuKT1/pi7VIcKoD5+VPr7DRKJLgSu9kK+SlrBwabmCg3LUQ8Ys3w7dNQCi4ljeOY9iprER7juUrH0jguw6K0ENlNV3FXoNMSQug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747791318; c=relaxed/simple;
	bh=O18KX1e0oTQR1yn5vLg1jTisYrC65d1MbMh/6iNAqtg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=J99iFtHF0mRDG+DBP+fbLV+NsWRCtdecvXbXGn7z5uMFKf+iyj7xgjtMvL4XlrZ5JoEsQVwuC2eX35m/u70sli8F00tAhfYPD5Db3rhNUDoY15JCPk9F9jAgKM7/AihAWFb5uHU1KicGWSwsxFo7cCahwuao/vwdERrpaIjPJ/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L1093q024648;
	Wed, 21 May 2025 01:35:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46rwfwrkpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 01:35:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5X8n7vJJRaGN7lMHFmiexd/KMA86mcxt2P4NEiqYdrmydfRDljJVpufZ1d2s2Z80PM3I1LUobZ5bJ9TZu1HgRDiihtMkpx4nbbzKT22G6892P0d68h/lFjoYTHScezRX5W2AXM8b/AX82mXNu63BAnwF2tDUYiLdZwFGoczrli9bqx2OoTLqC1CMnnHW8XCFKGWAm+N5DIeooW5ss5Kpdn1GCiIoNxCV7ToI3DK3zR4OlPsbiTnyvRndzLjv6+PS/NEq+JxRJpdhggQ0rL9muaByFE3f4hI2aso72vUpMtSiUpG67yrVxg7OhmJKbbVGRNCSAb3czS6bALPQ9aHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIkuvJ5mhxi4QVGh/N7QMgDMsWlJzbnL4ObqIiLQOoo=;
 b=ZKbG01k2BaUPJOIWpVSNUWrO1MP+lEcfS8hj/hIO2xvKhUJOytlbT5OfV5vem+rOFG8Bk8WG0jxHVfIjJjSk2IsfebUSxbPbEkfNv59anoYCRrfWbUx9/VkfgWTNxuukbs6dxQ2PpWHMZGd5jGbiGVc9Il5nKo0YWXQbKqFSXjIBwy2TvNYxCTwxla4IB+NCTYJS6oKZAQLNtBdiNzjuFuVvtKt5g9+TlAHWToQ8vlZBraVkZtbMmKRMZUIoY/H7uNORKlAT/ifvuL5Kw4C8VhENsaoeOFeMvhhu9PMOj1fo8kO3qILS1RQpI21wuYxi+nreaVV3gYkRfDqHLZArjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6965.namprd11.prod.outlook.com (2603:10b6:806:2bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 21 May
 2025 01:35:09 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 01:35:09 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: juri.lelli@redhat.com, bin.lan.cn@windriver.com, wander@redhat.com,
        peterz@infradead.org
Subject: [PATCH 5.10.y] sched/deadline: Fix warning in migrate_enable for boosted tasks
Date: Wed, 21 May 2025 09:34:52 +0800
Message-Id: <20250521013452.3345001-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0080.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::20) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c571ba8-26a9-43b8-ad2e-08dd9807b8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yd20R+VQTHGDf4WyFi6MVWRiWSDsdCZLoU4DTSJsk73G3ST72J82RV4SYVYH?=
 =?us-ascii?Q?JbAHRFAJCtH9F3LfnAGRjBy6PD27NSp2TcvNhMyW/E11rsuNlw2EJLsY4eJI?=
 =?us-ascii?Q?B7YgcETbOKQgyv8/tCvY+11oS3pJWRUwBOOD02zApzZjqqoDrrKC3KqZ0zf2?=
 =?us-ascii?Q?iZFiuFOTBJUK3R8CLO28GwPqSHa3Z9Di/9PzA5mDllM650alRA5WkGiXFDQ6?=
 =?us-ascii?Q?azIyugcSpqSofnh1uVyEQRL3QxzhrUqvqXxDS/rPSPsl7OuXQrGVokGUb9KH?=
 =?us-ascii?Q?yVzI+rIP23uRALUsd1pZsh8RtIxOvq8r+FUsl9tgUIDcRnqyQ0dUtBELOgbc?=
 =?us-ascii?Q?a31ku2DbOdolxM6ohkTyyxy1tjaoOBMH+iHkMZVOKUUWdkfbk3CCcvleLzCz?=
 =?us-ascii?Q?KP9WHjhRcplnjGSc2BfziGVZEVnU3MfKl4AekML11I6PZJauf4eKGBN+Gsvf?=
 =?us-ascii?Q?hdhJywJ459k/XeyC7gIZjFEIwJxepcaZ5B829Ujgu3435V086de9+NXJVDX6?=
 =?us-ascii?Q?ADQCt3bIa6+q4hCggnLm6uuNg4aXK2qq1SC4UBxyXPCi58eoeqd6WEKAFDmM?=
 =?us-ascii?Q?SUb3zKqRYYyiYowmfYYF9mmZXVFTBRaJBwkTfGAcPgf+/Gp2S8yTeE+XKQkK?=
 =?us-ascii?Q?YTFL5GvFQM/+cV6ScSl5FcVtfDUMDWcc8aSjL+e2PP3liGn1+lW+G/vj9/li?=
 =?us-ascii?Q?SjD3kBCMTTfO3PjeGweIiAfiQUjh7b6XbsEn9pSfc2gq3PgFqikEMex4hVmi?=
 =?us-ascii?Q?BzHJ5AhR2MQtrztRbG/cJFCpTiATV37vMZqasc9KVLR19jkx99PIQkIxmEmO?=
 =?us-ascii?Q?vUZUuOnd1rq+m9hTKi9bMxMJiaA5UfyQ8uClFmhNNRRSSMYESdafW5nqUa86?=
 =?us-ascii?Q?1KJ7EvVK4wcFTbN5aBjwuPxR+8EXgncdMTqBtPD5zTrsmLl675w++QCF2T9X?=
 =?us-ascii?Q?vBP5urLfzE4r8xhlopgbASR42UfZa722KBWSFUGYEYkd3eSmTSvP4VQ8uzOr?=
 =?us-ascii?Q?biLgxbn7Bpb82IWYHex+en0MSOAv1bjtKtg+uLTFnH3MOCdKLYzL5/rC7hBU?=
 =?us-ascii?Q?Thl57yVhforZHKrkbAHucMBq/ClGICOluxFOBFhNb4GjPAW5GazwEt5tsI6v?=
 =?us-ascii?Q?xsemNwPl2QyierSUgdi6m7njO8bn3M/pK/0WriAri6TC1i7GV/N9r2Yyhdby?=
 =?us-ascii?Q?TA+0kkF6rCbV1YQ+dOGyudsedDdDGlEsbeXUkoVwFQDu9lVIYyl3CWwImEJq?=
 =?us-ascii?Q?BNjZnUkKaUvOa2x/dHnXUQImd+cZRekrmtjFPw3MCUTyMx2gDv8gizFJteSS?=
 =?us-ascii?Q?3xvfrJ7Fb52cPo/48P/wdEmQ95oW5K1OYlIc6QN+qXdOQaig1Del/lGnundg?=
 =?us-ascii?Q?Z3uFAYT2ZZZsdlOSM3/napahcOTiXQXAUt8f2+OxTUDCG6ImwYfPVl6b9arm?=
 =?us-ascii?Q?+1GcIsjN5ok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RiYnDQicraEDrkGrgXmTsh0NCc6imXI2IOhRDbMMRdKxDdPhOfrM7KcMdrj+?=
 =?us-ascii?Q?6FQwANVEP0WfIJsAPRt8iJhB9Vvrn+QsN/sfBLNcUjzRfTdebCTGixKNb9yJ?=
 =?us-ascii?Q?jMgQz8NOg1fptuT7Dc2YoAUVdtOOFTp9OaT07gFLdgOSkucNmcJEf+qqZskX?=
 =?us-ascii?Q?ALE5ze6xjEhsLIzhjbCZjzK82QJUQAwdVgaQSqQIfgd5IEis+APySy8rOWMZ?=
 =?us-ascii?Q?hI95JJ6NmVQC1QJGSSH+d2+tEhKINXy34jT3PzAI9G4l2KzaeK7Gtpfd92G2?=
 =?us-ascii?Q?aDC/VbcNNOHoC/1iIptQVquiwOWRo95K3niscHF2J44mMVS7YlW3LaMZM1QX?=
 =?us-ascii?Q?qH9AwhRbYfO/41MgLAlX/HXbg2gaamqDaa8F6ZVkKC5Kk+ihsQD6pzkLyKeI?=
 =?us-ascii?Q?x+h4fXdPaO2Thm0t7RGg6iwdZ5soY7RtayJPt7A1UcmWpKk4749y8BJnSLAn?=
 =?us-ascii?Q?raNb4nVkEVY4EgP34qRB1ak9rR8d8LBiDVX5JvgitWpC4dfpvkl3AeomMlxM?=
 =?us-ascii?Q?Z8Yl5uRaSwtLwY4iKfHdataKj4PYApZpeRGETElUrfVIO6431qpBNyKKaoPP?=
 =?us-ascii?Q?NEPVaioAhImPI1SmdvlQeUJL4nESOHX78eYzjVN8HaSFxGLZ9SE7EacFRo5Y?=
 =?us-ascii?Q?mU1oHCZvxDdoNyIs5uaJYK5H1XOnf5xjH/PYTevoEesMci0jX3VYRDZH/T5I?=
 =?us-ascii?Q?j6PWiq1pQ3GkVniesTxnCFA49142jBlv+nwoHqchL2EoXo+0hGq2Jv+AhbAu?=
 =?us-ascii?Q?9AT+bS3fdhAHniTAdnUBr+dBK2qb0MQco8VqXBLRGIUwTODDDA/udFCS9Hg7?=
 =?us-ascii?Q?mdAPie1QI2XsRPvvfjoNreh50ISstjglFfDKSD5YUGlh833Ys9Qfug+3RO61?=
 =?us-ascii?Q?+ugv/GPKAWSLR0WsDfNIOXhsfehrnBAW9ifX7kHRPe++Yr+YkndnOpODAw89?=
 =?us-ascii?Q?Noj4NHzH7NZ+24bYlogQ01A3lZIueYZn1muPGJN4qWbhPVslygIs+NGuK0qD?=
 =?us-ascii?Q?1Tlnv67SgfXwKsZGX7+iyUX6TVgvC3Uu5q2Z5CWDNVUV5D0251uQUYZorM4l?=
 =?us-ascii?Q?PAgctNo4WJIQlMdTAkAZxywmkcaNzaDBx9I/cz/SdhNDF34cJzv/85qVyw2l?=
 =?us-ascii?Q?Y+B2wPdVed4Yke1iUTpan2fPD0V8i9ooCGq0pq6daVJeWROQ/PLm7vNVXYQE?=
 =?us-ascii?Q?8xG4pKymEeNWV7xKvkgCgU6OpI1tPlJD6wuWG7lnTp5mbh9vZzF0dMRSs7t7?=
 =?us-ascii?Q?SwGdrMCX4t628YYNTXlIewZqX+oAF0Z1C3Qj/kdgYEwI+zmLFk/C7NGoVfB5?=
 =?us-ascii?Q?ggU5ipi1hHGh8ZT3sDLtej3aaqm6mnZK/rEmWiTYCXnLlr0kaoUKn13cpe77?=
 =?us-ascii?Q?2F6Dx01WB5ItxNBTyfQ1GwEetjkg317kB8XzTMzGSZFH/zaYBrhyhJujXNHC?=
 =?us-ascii?Q?+kNBll1Ok7viMuTyZrlMAnHezT/fitZyW3QCZnl+5BvcqnpNdq8qi2uYB69L?=
 =?us-ascii?Q?7UDEU2TT7uvn4p6YN/m/zYQp8RBoWCxJyDpqvJNn0uAZWna+DIJlWjucUAH8?=
 =?us-ascii?Q?ewYGpQVsfZNgCWEV6dz69EP0CK1CKgRcye1LuiYs035ynToL806VfLUfOR6J?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c571ba8-26a9-43b8-ad2e-08dd9807b8bb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 01:35:09.0180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSFaG9dlaPfEIlCNTJYA+vN4Hh4w7gWyFd5QKfeXbzHcKZfhKButWM1bE4R1RrakwdDcVmA9DC3nxt/pXefqwyo5Rx7qLU9auWXliTWWZL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6965
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDAxMyBTYWx0ZWRfX2wlEdKmG2NiV 81wewUDRYv1LzU0vVPq47X12cMUgFrJ+v+/0O7QUKSzTzddwb5Fo8KmR+K+OmuITidGVWzsUAh4 de/nkW77+qU1v6V/0cZxnkholnE30GaKyIxU6AHGl3Iv5cYS4kjShUapaGM2J8/6IUGO4oI+7SW
 HN1a7iZEUjtzKAGGs4wLJr4SkrvPjopAmw+Wc5Uy8BbuSx48JaaLPwhvfsKEykEsWfyltla6l8f ww6mGl9bwvcBIVezPf73khzxhKaPtX7lim2bI/ZLAqQe0ZCzn/q2hfz+9e698Kn57h0TY6kTBQE WTA1masp/tooiY2cWkiVhUFMelC6AOWvmP+t/WBhamxZ4gXjBjUqwKJfye7oC/SgSHsVzb1pv1u
 C1CPH0qD62n73dak7WGanqScOv/cda/ZYsA7N3cJ4NT/Ni2F2kQYJy/w5C9K2+0SEKArdmrs
X-Proofpoint-ORIG-GUID: yCAVOBXW0YkQpcDR_B78u3-kuqE5k-Da
X-Proofpoint-GUID: yCAVOBXW0YkQpcDR_B78u3-kuqE5k-Da
X-Authority-Analysis: v=2.4 cv=b6Cy4sGx c=1 sm=1 tr=0 ts=682d2dcf cx=c_pps a=Dwc0YCQp5x8Ajc78WMz93g==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=JfrnYn6hAAAA:8 a=t7CeM3EgAAAA:8 a=TXSmb4N2Zo2ZqIVaM4gA:9 a=1CNFftbPRP8L7MoqJWF3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1011 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2505160000 definitions=main-2505210013

From: Wander Lairson Costa <wander@redhat.com>

[ Upstream commit 0664e2c311b9fa43b33e3e81429cd0c2d7f9c638 ]

When running the following command:

while true; do
    stress-ng --cyclic 30 --timeout 30s --minimize --quiet
done

a warning is eventually triggered:

WARNING: CPU: 43 PID: 2848 at kernel/sched/deadline.c:794
setup_new_dl_entity+0x13e/0x180
...
Call Trace:
 <TASK>
 ? show_trace_log_lvl+0x1c4/0x2df
 ? enqueue_dl_entity+0x631/0x6e0
 ? setup_new_dl_entity+0x13e/0x180
 ? __warn+0x7e/0xd0
 ? report_bug+0x11a/0x1a0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 enqueue_dl_entity+0x631/0x6e0
 enqueue_task_dl+0x7d/0x120
 __do_set_cpus_allowed+0xe3/0x280
 __set_cpus_allowed_ptr_locked+0x140/0x1d0
 __set_cpus_allowed_ptr+0x54/0xa0
 migrate_enable+0x7e/0x150
 rt_spin_unlock+0x1c/0x90
 group_send_sig_info+0xf7/0x1a0
 ? kill_pid_info+0x1f/0x1d0
 kill_pid_info+0x78/0x1d0
 kill_proc_info+0x5b/0x110
 __x64_sys_kill+0x93/0xc0
 do_syscall_64+0x5c/0xf0
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
 RIP: 0033:0x7f0dab31f92b

This warning occurs because set_cpus_allowed dequeues and enqueues tasks
with the ENQUEUE_RESTORE flag set. If the task is boosted, the warning
is triggered. A boosted task already had its parameters set by
rt_mutex_setprio, and a new call to setup_new_dl_entity is unnecessary,
hence the WARN_ON call.

Check if we are requeueing a boosted task and avoid calling
setup_new_dl_entity if that's the case.

Fixes: 295d6d5e3736 ("sched/deadline: Fix switching to -deadline")
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20240724142253.27145-2-wander@redhat.com
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 kernel/sched/deadline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6548bd90c5c3..e2ff343d1c42 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1516,6 +1516,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
+		  !is_dl_boosted(dl_se) &&
 		  dl_time_before(dl_se->deadline,
 				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
 		setup_new_dl_entity(dl_se);
-- 
2.34.1


