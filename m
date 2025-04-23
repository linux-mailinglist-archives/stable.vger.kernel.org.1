Return-Path: <stable+bounces-135219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E17A97BF8
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 03:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6226C3B7046
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 01:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA651256C6D;
	Wed, 23 Apr 2025 01:04:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26561EB5DB
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 01:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745370284; cv=fail; b=N9t19KDiB6i/RNPreWofUQI+zc2cofdnf0bwNf9BdFsvtpS7mjntuchQancrC+yjo6Tyl5RLqniwizyvRTLtCUHBwLT9MOeCytRC22Z0QAnWyu1sZk1NgNvZh65WDW1xrkaaVKRBNwoOmO4CpGC0r+GQHkTroJLlouohx8x7jyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745370284; c=relaxed/simple;
	bh=HJPHRacmZOBLAu2b55EiBk0DI5BMyNlRv3uIZDgcMI8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ArivcOvtP5wMaTStzgdN59hs4YsoKoOgF79js4I+F6CZ8be5ag8lfPXu0ZsSprN+pizP2AJkCTZnMvXaNT2Y+TkraThdAtEiTkg26fqY7RmgJSBPs4GjHW3a9l6ImhoJUPSp+lNO667a1Zq+OIbKUpjzxKWKmyzWwBAAxiTHMpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0AUng027931;
	Wed, 23 Apr 2025 01:04:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 466jh605xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 01:04:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHeT1df5uUBuA4lcbLQ/j8V5P7hALd7Fczusf51xVa715PCA83f8UdMBawMY/1THuKD26DeanYXGntGqdk8LZNQafUK9+gA5dhi4IUhxElUDiIitGn+cHXrZ3c207MIQ67RaMj5UNfU+4E9b0EiZnJamQDLLru3K+yt6H1t3egEvf+/WxyT2ME4+Q/UKLbjORsjBj2DEYV7raYNMePFa4qMQtugai54vFSBJ1XB7Hv1Pq1CGDV/7RBEHEHFfb+jOBSxQoa05i7dC9gdUvGtl5Eq59K8zfIG+SwxDvJQqVre2C1x/Mx2Ve4TFBNGbp2AU9QYH6877uJ9Sx1Nv8biKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UqKapj1lZm87lOXZ+rEgKLut0Y3bZ3nuWu4Sd0/2aE=;
 b=dUWyjPna6zGdmMq4dUFqp5c90hAQIzkd400FgTUVvILbn1k7RFK4DN+Iuv4+NBit5J8J7c/BazbX0ibKA5aJzdFejPEll9hVle6ke6e4+NQ1Ce3S3Pq27QD1oDJAo0OW7VyhXVf6IvBqEnNH+9D+M/KX/u50jiK0bKFnaMEVzLvBRLYKlIHmWGyIFCgtlXZORXgPB+pRbK+P6HsC1UhoBJpcc+Y8ze78luMSp0GsuTW2UxK7VAR1y8cmbWMnbHrczJMT6t/NY/JbiYfo4+eeupZVowRSW9k8WXis2OfCxWaOBIqdtSWp4+P9bfdPCzfmAts8OADLNGAXUel80awPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by PH0PR11MB5045.namprd11.prod.outlook.com (2603:10b6:510:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Wed, 23 Apr
 2025 01:04:22 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 01:04:22 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: chentao@kylinos.cn, ulf.hansson@linaro.org, sashal@kernel.org,
        Feng.Liu3@windriver.com, Zhe.He@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y/5.15.y] pmdomain: ti: Add a null pointer check to the omap_prm_domain_init
Date: Wed, 23 Apr 2025 09:04:10 +0800
Message-Id: <20250423010410.2131206-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0170.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::10) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|PH0PR11MB5045:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7d0648-cebd-4d72-28bd-08dd8202c873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bvMJ/6uPYrTr4fD64+17n+juUcLbn34IY0/GzLATVQRluHh/E5zwnuE4teeP?=
 =?us-ascii?Q?cb9tHN0pzkGSV6yaSqxqEGY7efEoXocEqhzsXB9jhHSGa0H4+aaPVa4yNSxi?=
 =?us-ascii?Q?9uSwrGXbGQvXLII0/dDj7WLgm3tWuJvteWt5tqhZ7rPE9gv+iVIbshUKTBIG?=
 =?us-ascii?Q?mgL3ivmYvcMDlD0ukyS5Zaj5wEfIFUM9DanI7w0D1xGniKAsnC2guR0XUJ1r?=
 =?us-ascii?Q?oVOwo6MWYXFYg6aX1iBD/O49UyAmPgppISnto/gN/mukRV6I12o9mmhxAI7B?=
 =?us-ascii?Q?jjacYlICf2UJPepkLXLqSnEi+qn5kTtuzGUFlpk8KiJXjcVxc4O1u3odSnE2?=
 =?us-ascii?Q?v1TK6LicOOpJQIpIEwnwtQLV1cuu3w/9AkD8zfBoLJa/KBUW/YZlKm+Qffdy?=
 =?us-ascii?Q?wnI8SzMDCeONRTNrSklu/GUG7f+xDGLYC2t228WtxQn8OQXpPZ8AQvewD+RP?=
 =?us-ascii?Q?GGabJZDPUZNXono0yRPyRtuy81QEx3Bjx8fc+rz0/qpwx3O9H0naO5znV1XC?=
 =?us-ascii?Q?Q2Lq+yUl6LWlvWh8klOpRH0IQItbeOHvGvM2tkS4AGHpkM072nJZ+VWYRaVy?=
 =?us-ascii?Q?K0i3tw+BDnYpdR3ZKatiFVMqZRXsLCPjke90iSDw+rEUhMNwls3ZZHxIeK0p?=
 =?us-ascii?Q?aFUIMl3eQqJmQMBe6mYDAMjLPQBMJ9UkU3nDgkijXj1I0lFeVhe9+4fJObhM?=
 =?us-ascii?Q?5dxAo6O672JJmQIdvLZhSuA/HrZB8zo3JtWUeZ7Zg7Cm3i3GWmqt37/fjGzE?=
 =?us-ascii?Q?xji1bnclQ/5muN0E96ugQOBOuDmotj2zFCj1WmBYcPFcxFpQ7tUa1eGy1ftH?=
 =?us-ascii?Q?db6GHsL5ZU6VC2tXD85vlFcoDhm94p4iIdddIflqkbkJa6f9YCA/nBK5gpuV?=
 =?us-ascii?Q?WvI/lT/aqnFoCUdod5rCOCr7GoBIPZix5Pt3f9kVTbP9FsIbSgMxP/aLc6SI?=
 =?us-ascii?Q?DgTr4bVPXsolYCg+sHCHADYJblOO97BgjaNLY9b13Rc5IcwdBftVandCgEky?=
 =?us-ascii?Q?gJf6U2AtB+T2DhvEis+Ofu2av1Cj+t/BnYkfC/NUgDHr1IRFuKx/qSL6gC4E?=
 =?us-ascii?Q?MXc+HLs7hK+1TPp3Y5fqRu6Om2/WTofEtod9M6LYNRMEc5QmONqS0xDbJyq8?=
 =?us-ascii?Q?GwLhe8XeeUX7b4oVGF1aUmMaWjtX7CollAmihYaYc0goZNq1FQZO4MHirZcu?=
 =?us-ascii?Q?3vC/fuzczwxutROddsmCYX9ghGFDj5rpB0zxXR7Y93vkVLLU7JYtzEXec9lP?=
 =?us-ascii?Q?v173p3iDUYFH81tlJj3y/0kAxTPJaNxFKQ0zYt3GXQVlKv57Vc6HF5xoBlvv?=
 =?us-ascii?Q?5thOVZzueGL5g1QuEtG832CGuFWNSgMLWSEQ71fLYikDN2xmBUaE/B2TNq47?=
 =?us-ascii?Q?ZmPvTTzA4iB6ZHUICiGOkQZParALI4rLSGptx9v6duHEHvcyxYpuuzCaS/5O?=
 =?us-ascii?Q?gqAydaW16ZSGffhwzFMVDz4kAuR0iwcWUha6BBoS0GUFjBF+eSvIS2rsPy5j?=
 =?us-ascii?Q?4f9UDGjHRHl71dY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7/uhzGhXmwDoUvrZ0gwHZp+/lzKWsMZKehMG83aMnOjvY4yXSdXim1HPKcN+?=
 =?us-ascii?Q?vUT2swajDm5glk1dQ4AJF1AsGWt7BSY+wRdOAEBykM+863if5xqLrADHRwrQ?=
 =?us-ascii?Q?9hfI74j28dq504R8oEv18zhFadgKjZEK4yYYn7rTiWYoTS+gcyhVNkGdR+rT?=
 =?us-ascii?Q?Bo+jX3RyznovYXbQOUiXpzt2O6F9Jyizk1Lk7IowLEMpYC/BBp1aJTxURnmT?=
 =?us-ascii?Q?RpcxQwBF/RBsYL+SHktI0tu3nEUQx7AriNWmoyb+f4KtW0xNmLRpQNYMpvRg?=
 =?us-ascii?Q?f0Q0e9DP59OUsAzeYCXhjVP69+cZT65ZS68lxbLQYrXGXJWVpkstnfUz7V+N?=
 =?us-ascii?Q?Y5QRLmZLBnFtsnoUxNVvBxQ+RV1Lq0CpNLIuYJ2QCq0AZpK4fY38Xw96lAp+?=
 =?us-ascii?Q?yE0TptmDIMjbXNdKOgFhIkqZtewiFmmkBwyoSMvb3hga33VAb/2bEoHQoNEs?=
 =?us-ascii?Q?6TIKwnR4lsxoOm6k+vNBT8djQv1wIK41AZMrGdPKRR1lQnSlfm2vAfLGZpeb?=
 =?us-ascii?Q?1p/0d+fuDA4haq70FmH82XhbCYsiJrgE52N+587ZHiaKN+ujuc4qhjY+gJBc?=
 =?us-ascii?Q?EoD8sw9nkGxoy+FUk2NgCsIqf1/xOpFnCZSHu9TtpFQQabvi+LAF/Su8hLBI?=
 =?us-ascii?Q?XogZ0RdV/8BJSgypsJIX8x5ZIkpNGitIJllh4hLRLEovjL3U9PLTNhCJcNQ9?=
 =?us-ascii?Q?wTHlIzGBO4sq2lxDVb8eMrqmlICrAfDTOdVZ2dYY6jGYR2JoC+Ier8grSwCH?=
 =?us-ascii?Q?efBXDBqz7nuAtBg611s3jrdSIpysOZsYeIQyIWVO0asx0lto0zKSiyXaJe3q?=
 =?us-ascii?Q?43YSJwuZNc72rocq/Y9Lm5FJp6k2Gwt822HmtKmf7Q7Fjli4k05bBZYEFHS6?=
 =?us-ascii?Q?RizZF6Bg7hjnqcTml3KLWUOHQxARItO1lfa+jek27FNEyxGgaA8JeNjAATlG?=
 =?us-ascii?Q?C4rfaH6GeXMK8sbKl2aJW/HRTymuT4PjQ29FTX+i9P5tWysNU2b0+xEd3TiN?=
 =?us-ascii?Q?PYW2cWP+RqsLvXaMUjbJClpugdlmnKn7ZezGEOumVoWvI9Qq3rtk5RMQQfuy?=
 =?us-ascii?Q?75oi3B7L0Kn+l5DJ8JLcBbu+M2ETb9QZqTH4s7CX4/7CrjlfGxx4QNnb+xFG?=
 =?us-ascii?Q?afgZMIX/U03xKC1s3SSmHotGF3q9YDsgLY2c+lwgSNiAamcYqvypzz/67CtM?=
 =?us-ascii?Q?6J2hVvdWPqgiT4/k1NqTzLjY4GDXTUGn0EQo5PuDJie5ZfjXbwUs+AFfUgwr?=
 =?us-ascii?Q?343jyP+XodGNcDow0s2eH7AAHVPPimG1qHloyADpzcS6OW1HeZwni7tZk+JT?=
 =?us-ascii?Q?fYKDatmzaSOg7yzfVJLLo1U2iRorjTPT1IrINg+qrFMzUkvZ9pFGwZGwpSbX?=
 =?us-ascii?Q?JAKEwLIVqROphjp1Op80R2Tr1ABTkZo4aWMVyAmHk9pvKJ4TTk48cPinMlrj?=
 =?us-ascii?Q?5k+5+yKHig/GGPHCuoj8WPK27NCiAOtdWxBqbaE7uvUMkODY+Mv551uNjOMa?=
 =?us-ascii?Q?36i/luGO76s5CEmUVZ0+brTVYokPyzdpqIQ7sCMVLw+xr6T2emKdWD0sMfqm?=
 =?us-ascii?Q?lEHZ6rviJ2ZThhI72m3AyUklaLzV54jcCG82Nfjr?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7d0648-cebd-4d72-28bd-08dd8202c873
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 01:04:22.4840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ba6wx3ouj7J2l65qGZDQUN0E0/Y+v+pmbyYjx1xHQhxEaJnkk3SC/XIsXlxnkWRbXZYem0UPu6KWGozI3ycPAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5045
X-Proofpoint-GUID: gy_85MzawMjgX_pMp_UtyO4duTUGeme_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAwNCBTYWx0ZWRfX5N4V+zI7CXXk LDqqBNEi25jvnMXd3+8z/bxCUMVeHb0AUjdgXXp03+8F25v9+32vMAUk6CgUVGH3IdDyzXHHDdI 1PoEeQ06MIyDdWD8t16gNNA/1fJVWjSEaSaEydQUkMVVH9PabDGIEzzQIxSVn9yfWdKrFxauzcN
 NW+/vt3HEggHzYbRSkAgphvG//xX1+/OS5JIG9OuEU5vIjLqmZA24mEeTs7orxZH0PxwpNoM4lZ N1WayuxlnAgs89bTUq01lWOyHUUrMbHqJcClsyAvZpnE93DNwiQ6X6o9Ng3HzzyCEyrmcao9aee GNhprd5FVmHq7hhmrKhT2tcxwjt8j2eWqAfX7q0ddxtEE/nsNdSJe5kaNl4u3dETTQ/88fCV4VB
 1FPII/gMwGegt+j9N6THIDvaWSb2GEnp8sTKgiYgV5K/sN+fSFAkWInhY8g6zy94mYgQNAx9
X-Authority-Analysis: v=2.4 cv=Lu+Symdc c=1 sm=1 tr=0 ts=68083c9a cx=c_pps a=9T78G36u1E64A7MtQSounQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=t7CeM3EgAAAA:8 a=-MYwQdQDn_qFyHks7dsA:9 a=cvBusfyB2V15izCimMoJ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: gy_85MzawMjgX_pMp_UtyO4duTUGeme_
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_11,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2504230004

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 5d7f58ee08434a33340f75ac7ac5071eea9673b3 ]

devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118054257.200814-1-chentao@kylinos.cn
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 drivers/soc/ti/omap_prm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index 4a782bfd753c..d4c0c700b35c 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -381,6 +381,8 @@ static int omap_prm_domain_init(struct device *dev, struct omap_prm *prm)
 	data = prm->data;
 	name = devm_kasprintf(dev, GFP_KERNEL, "prm_%s",
 			      data->name);
+	if (!name)
+		return -ENOMEM;
 
 	prmd->dev = dev;
 	prmd->prm = prm;
-- 
2.34.1


