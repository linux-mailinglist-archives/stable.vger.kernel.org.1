Return-Path: <stable+bounces-142976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76117AB0AA9
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FBF17C305
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DCA26A1D9;
	Fri,  9 May 2025 06:35:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A356269832
	for <stable@vger.kernel.org>; Fri,  9 May 2025 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746772538; cv=fail; b=EFCeCSYKrmIYixcjzKZiz74NggRNHaP405ufFgb9PgBqr1UoAC/OkKyTO1WslzN81TKEar93ucv6TXHrIRnHyCALVSo2x0btUkeAG8hYJeTw4s1SBR5AWF8+bWkaRbfYjA4861iUWFoN1s0e7PRUWZK6Ou2frFxYKKTQRN9ATlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746772538; c=relaxed/simple;
	bh=ApzzksyoZzXCz3N0qtVo2iKw+CRKTzttvcD6o/RDjB0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eEUZ8OS+RZuzp0Rt/eyBxnx9qnwUPCDjEJVNXKbgAaydgB5vFjhXJPoqIBG+tANGg8gsrSql73eV1Lkh7qZ2wClnng0RpDN6UnuskiKTUPs+LpwS44V6ribnjoRwl+S849KlnGhBEbMDPpSf4j3qeWwbefGNuNhibOpnYG0b420=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5493gfNr022318;
	Fri, 9 May 2025 06:35:31 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46d8c170w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 06:35:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pruVCwrMfGkaMd8Oe4gf1lmqXSplHl2lBhsg3zFjBqvkHvujG0xjRQuP55ruNqh1sZtt5/KiO3fTvoS14ag6I2mZ8jYGGOxOc+Fy/GNY/2djfExnk28BgDfdH+q44lArwhVwc0C0TCn1zixMYUfuhpTGA0LhVU3SpG8VSkWxTDX8D9RASY/7xh+RjeBUqgBa3Nr6kNJvThOoWZcqj35VQTjggm70BTt9B0Mt8TZqMVFfpD8TaRo8rUcxZOMYNkz185vEswO73UxzOZn5T2mbKO1FH3FC7kvo1oXbqp50RXWE6b12o0qSaHZwmWuLxSCdFtlhtJvD4YBd14ojd/kBsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sho7fXnN68DdKEEDTfUrCLkRGhTPmBx0LBjMr6Ntfmk=;
 b=L/lbSfcmz2UBWG4IrMXNtdjrt+jsbsk6I+2pFEshyi1Xu9o9nMRjirQI/aIYg2uK3tpEeXipV/uWanMljXE0K7TVbK7o9X/AXeBIAmmdw+KHgYB7mGIemIaJq0TAE5OiXUePX0wSb3O0/W5B0XNNUA8/7pp9wGaZ2YWCiK9tVMaczMPI61bJSLVkhuCFb0PIqfXQ1Bhz8i3G2CdC2wkrXVo3Q5MyHo+U4z396V77nixtIKJuxejPESeKm4/scKZdNtj34r9IZzZKjgYEemAA3UJhv2GdGOfduEAOVkHe9FlbpVRqP8Vvm+VkqJxvnVAK34/eh6Z/qDJXsYga01Ygyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CO1PR11MB5172.namprd11.prod.outlook.com (2603:10b6:303:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 06:35:28 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%6]) with mapi id 15.20.8699.037; Fri, 9 May 2025
 06:35:28 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: heikki.krogerus@linux.intel.com, bin.lan.cn@windriver.com,
        dan.carpenter@linaro.org
Subject: [PATCH 5.10.y 1/2] usb: typec: fix potential array underflow in ucsi_ccg_sync_control()
Date: Fri,  9 May 2025 14:35:11 +0800
Message-Id: <20250509063512.487582-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::20) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CO1PR11MB5172:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d17f46f-09ab-4318-2a08-08dd8ec3b022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hl7+FezU7yUQkt75EOE4H8KlichMwJjdUpTrXYV6kyW5YlsTNwhNjDi6FqqC?=
 =?us-ascii?Q?lcNxjhYxuK+9I9GlClzNYCvwwLb3A1iMJcxpJkXonDhPAnqucTpQn/GalusP?=
 =?us-ascii?Q?c+vCBZ3jTx57+9OciuVarlF/yDXtxxlnjlqGdZsc1yPEWOuF8KuZkrBmz+le?=
 =?us-ascii?Q?syXlqkblFdFYynnyi/gJHe5nkywffhiuGSCRvMcwH5g0OkUseuX1U3V5Y3bT?=
 =?us-ascii?Q?HtABNKLeEbzcZ4v8YiVebLuQ0qKKnWz8fuibk7NeK0iOQph+8sZ/AB8o+PbH?=
 =?us-ascii?Q?XhVWVgdfbNHvZu5wlPV2MTVyQjc2m+FyLQKtIGlErpRlYJpSkNxaG0iX7Nvt?=
 =?us-ascii?Q?MLsKhBnbXHhaLaaTxAJP66R/VGWanm1agbDLJT7X18pWSr8LBdW57xn9qEko?=
 =?us-ascii?Q?9/ue20PmXbCCUqtcYv1MdUWCnIXeGONLw5PW1S9zQS8m4GpX+1IhA68lTEJ1?=
 =?us-ascii?Q?9hsHwoqrmfcBTfIhIhPfxBJ8KaCKdWNOgoI16q1mqLfmdDYkjkOlK8ZKTmJD?=
 =?us-ascii?Q?VmBDcPWY4hB9wL1YfwbUOcILdI0A8lbr9dPdDHViD7eRtLsNGz/6oU9TSPjY?=
 =?us-ascii?Q?Z1+nxKk7bgtijc3RSGOv3dHQApKUyGX3IaRJf/Qdbt2Ku+6iuXlGeP/Ie3WT?=
 =?us-ascii?Q?FkqmqTdoQVetUQlWRLldfiPfEk7HXuLjeFw83c/PE6AzgJNxMAVntQ7u+y1s?=
 =?us-ascii?Q?eIz2zNOqWQRERcYcyf1PQ+hlSn1hHkZxRtNZbQKaE1o5mKoIEC35Jhfgzrkh?=
 =?us-ascii?Q?jsFzd7dMFFSsOcv7JYR5RbRn8amJvSRtn9F13gyemJwoAvOouFB2zd5G0zEV?=
 =?us-ascii?Q?N54varnrthOiLT8XOnPyOZSWG9/l5ud0WRm4uYYE5FaOzrmdByUOmZtlmBz0?=
 =?us-ascii?Q?ZSmQlu7pRwZjwXfgCwJVnPJ1WXCVfd0OhKziPvtb9ff9nJ91/Zi/uhWhMLpq?=
 =?us-ascii?Q?VJwgNch7xxEdDfPQ43ikJNHY7FbIXQKYANSwQNlUCW6LyaYWHuRMQV7GajDo?=
 =?us-ascii?Q?1rC20z1GZl7OaUSJluq5wFDZqvR+HaupOGCKZi+r2fV4Ex1K3FXHHQVeanor?=
 =?us-ascii?Q?JrylasXKAPyMIsYt90/3NYcCMRoe5RzlsppmPE+Ia18sV5s5EJO9e0RpCPU+?=
 =?us-ascii?Q?hkXuQ2Fj7tY3sDSfJ6m6Nzi1FbEWZf/xVsYaUER06PVBFmKUlrkC+O+NuZiY?=
 =?us-ascii?Q?rtObdPw+0tXzKksdg9nqKzjXg2zCBPBBlCE8OKnqC9Fqn+N4BJWy9o9Uw0Ui?=
 =?us-ascii?Q?lfm4QpegNOfl8kLx3NlOaCDVIr0NgvYUrTzvJ5ZrNCy2hfnXhGjLkxOafiB2?=
 =?us-ascii?Q?aoMbJAzniIEfPSbie8lPMnYtlunK1ofqP1+CT1MQnEKIKP7afnIcBv9XWfNm?=
 =?us-ascii?Q?Lg6mAiA42ufjVWFH6qPzS/E2zqs1FXehM/Py6b2BwyITd1NoDFiJN4lluq+4?=
 =?us-ascii?Q?Lr2LXfJvok2KzGqThOOV/6epyiCi/yvCzFtyRNIHItQsJqrbHKAbqhjmbo9h?=
 =?us-ascii?Q?DntlQsIjAe7McsE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nss1z3zSH9seSRebibdxpkuZ5Ix79NmBCNNMCmGO5dcKEmsNdRwXe/34mscW?=
 =?us-ascii?Q?ikAkZJozfsDsMIA8c+lkKHMeVOMxzYOxuqGsgQ8yinc51HCOMrncXKiB1HV9?=
 =?us-ascii?Q?eLIx4AC4p4uxkHIFLs6M8pZE3SC0boZSIaMQl55jLwXpddp5T+xbe99JBJjM?=
 =?us-ascii?Q?DfdzBGuXeuJ561a5B3gGzpFGF/d367RHd8gVlizqui8WojAeZjXWNdFNMeY0?=
 =?us-ascii?Q?gupdmZZec/t68mTyVg7sjsjXhhLq6AtNcPARTZ6dmZFRk/N6jqhjoexlqGV5?=
 =?us-ascii?Q?fMkI+BfxAS1hShsRxhgA6HxzVqPCYOr35SHbcvM9ZWyVDUKxOFjF20ZEY57x?=
 =?us-ascii?Q?DKfbYl54rNkr9T3P4la5noaGsTEbFm8il/G3KK4vsRhSuwrkMqep8qZW/u0j?=
 =?us-ascii?Q?3hpNTTSoKWetUz5ieMEdESqRNgZkh7mFr4mK95KBWVruH7I47gKt0YW9DBHs?=
 =?us-ascii?Q?+FSjLntEon/iIRm4nYKNpOS++YAtmoGrifmmdOq5SOwuH5s+EUZ+L/zv1dfj?=
 =?us-ascii?Q?OFv1Ac/MMtknxufNGI3bMFQaAL1mn/FvGoRLVV2/CXjIK2odWbPfYOLbVt+r?=
 =?us-ascii?Q?3UmEx1UcOUhuzeqsN1zeYBEZsGXiibFX6Pa0y0iQAN4J7pX8lkGK3Z3c94M1?=
 =?us-ascii?Q?d/nMYo0Ssv199AM3ag+ziu8vjIEYdGfDdWix6rDHJoTfHEMAP9AqKXxSib4c?=
 =?us-ascii?Q?2eO7EmkHXLNIUJO4AQqOh3DnYO8d7YksqNOslS+ZKrzlW1e5numMR9zw1ZIy?=
 =?us-ascii?Q?jHzMDB7Q233nMKx9xCYoiFdoP/SsUAwlEu902PnMledLzFKRQ4TxxVNlevoP?=
 =?us-ascii?Q?VMhVGKPURhTw2KJaOxEvb88GOcRC1VVivyV3UCHPG/DERXuRY3johS223BSa?=
 =?us-ascii?Q?s8yKK8+65OxQ4olm/cLv+TJfFGk8AngdHnCuJsdnpVoitqApx0XBbn7Oaj7q?=
 =?us-ascii?Q?joTYy8FwzasdtHQnE71B6jSQheqOSbOZu4qUZ/teVmEEcDEZysxEE40Sv3Hy?=
 =?us-ascii?Q?SphqZ0aEcPnv1YBjgjSUSHXHS9xv53Rv7S+r6X8HX8sSrCeXH3OUt+1O6zLF?=
 =?us-ascii?Q?qmAIjJ/KAbTZh+p02lvJnTL2r55lqMkpWqj+LsLjK73KL/8D/5uZaUSscCle?=
 =?us-ascii?Q?+1c8fb442P2nmyjJFlZzvyJ1ECv8Jf7Hw6GvduKrQVD4TrZhnzNQQeRZQ2Xu?=
 =?us-ascii?Q?jug6ruW4+E9rTSj3Lsc5JFpEVF4tSmlaTe5lBahrScjWA8ap3ffB1Oz4EyxH?=
 =?us-ascii?Q?x4u55/SArxj/24E8cNAiyJS0lDko5bDiMiR/7Zg46pxGslN6XXgVZHnIV7kG?=
 =?us-ascii?Q?ipvYr6QLJyyoJwsWuPjV0wb9fK0fsgnYwP/2vlaPZe1Jrfa0J68J+PdZc1a1?=
 =?us-ascii?Q?f3w6ap/mx0hkrYghLPq+4ofzPB5YNmDz5JFlYS8hGf0Qieg/LfPSw0PD//le?=
 =?us-ascii?Q?HYY4WSMm4FJO52cR7neBaqKtu2agaphBNt+xFtqQhUpnjakA53eZaRyY4mrf?=
 =?us-ascii?Q?pi1AmQCAYLXcTq4MKDT+gRV00XziiTo2tKAaq2zlPMheshvCSUP20RAGxpJm?=
 =?us-ascii?Q?OIOC06HZTjA/H5hIaAMzhtwkvhpa2a/OC+77LYgbGuce4tHyZ19mOtyHCv4T?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d17f46f-09ab-4318-2a08-08dd8ec3b022
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:35:28.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awK2+3xZ0piW4nsr6I6NpKf2vATvjpw1B1cnT/rQFhvBpJQbshFNdeQCtT3QbNd/dNTjeVu89AjDae6thTOrlGUxpqJpYHmvwSV02FPeDK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5172
X-Authority-Analysis: v=2.4 cv=NIjV+16g c=1 sm=1 tr=0 ts=681da232 cx=c_pps a=PZJ0/dUMjH0jBWORzn298Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=uc3al3VmiIQHG6Bas5kA:9 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: qSKjkWsBS2t8b58DInmGV6FfUn0WS5Ky
X-Proofpoint-ORIG-GUID: qSKjkWsBS2t8b58DInmGV6FfUn0WS5Ky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MSBTYWx0ZWRfX1hV+f/92wwBC hdwgn5kOBGq5XK6yn3CcxEGRx/YXckQPvFkNXka8ciKdGelitAPRGxox/T2z89ePs+Zcm13J81g un1FI9RWLu1LDL+/2cUVl1PiirhPFCXsxfmjhdRTx9BKNZeOolk1S6YPjF+GYqDK9s5NPsRb28b
 k0kLHu6mVznHJfyYhvqk9ChD7HFMnMWqIpyzA0YD5XalMPS9FwwMR//gFKtvKisddSNGN4CkDCJ LNSHAyJhLHgKsHUMyXjiZnxZTFqwuC/JeLTQcK6Wo5E7uiXzXyvZubfX2ttYkZYQUkLCcOtaI2j RSW89sbduyftTW+rr4a+tC86isyKOnXqfZhkf5+LX6AboZj2ofOOQoICMN8PHgC34bpr8hd3pCE
 u258F3X0ZHxEWRJxnnlhfhnFMKOrq4+rne2Gg/tps/jaBjv8McTKzH2ab6l7wS0F4Lrds5bS
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505090061

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit e56aac6e5a25630645607b6856d4b2a17b2311a5 ]

The "command" variable can be controlled by the user via debugfs.  The
worry is that if con_index is zero then "&uc->ucsi->connector[con_index
- 1]" would be an array underflow.

Fixes: 170a6726d0e2 ("usb: typec: ucsi: add support for separate DP altmode devices")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/c69ef0b3-61b0-4dde-98dd-97b97f81d912@stanley.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[The function ucsi_ccg_sync_write() is renamed to ucsi_ccg_sync_control()
in commit 13f2ec3115c8 ("usb: typec: ucsi:simplify command sending API").
Apply this patch to ucsi_ccg_sync_write() in 5.10.y accordingly.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/usb/typec/ucsi/ucsi_ccg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index fb6211efb5d8..3983bf21a580 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -573,6 +573,10 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 		    uc->has_multiple_dp) {
 			con_index = (uc->last_cmd_sent >> 16) &
 				    UCSI_CMD_CONNECTOR_MASK;
+			if (con_index == 0) {
+				ret = -EINVAL;
+				goto unlock;
+			}
 			con = &uc->ucsi->connector[con_index - 1];
 			ucsi_ccg_update_set_new_cam_cmd(uc, con, (u64 *)val);
 		}
@@ -588,6 +592,7 @@ static int ucsi_ccg_sync_write(struct ucsi *ucsi, unsigned int offset,
 err_clear_bit:
 	clear_bit(DEV_CMD_PENDING, &uc->flags);
 	pm_runtime_put_sync(uc->dev);
+unlock:
 	mutex_unlock(&uc->lock);
 
 	return ret;
-- 
2.34.1


