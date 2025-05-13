Return-Path: <stable+bounces-144108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2547AB4C32
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223113AA98D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE201EB192;
	Tue, 13 May 2025 06:43:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B63183CB0
	for <stable@vger.kernel.org>; Tue, 13 May 2025 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118638; cv=fail; b=p5q73dVuXKF6GyO/eukrRF604n7wMvCfV1guJ3UXURbucxegcnQTrQQJVHxkIkRJsOYt4vOF1ZAShf7XqDvdGR0bJWVLTpjV4Ag07Q5bexVSvz6KvnkZdVlPoShF1CMCoGImenzhAOyMClluo3Qt4YwsxXY+wg2PQ7t+vuaRDec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118638; c=relaxed/simple;
	bh=5DxVGIlr82msxQNrdQ1MIVlXFoSHqb0ecxlfdoC058M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WIVK0AB/yCTeVVqGoLUT0yi+iwpYI9eSTPDE/AFVReWbTwK5EyH5CEOAvn5cIFa/ElEtBOykgfVHmREqghNa8p5Ppp52/1tr8KcjP5hyZE/Se0NEd/YxUZ2GPvPQJaqVmyp7ndN7kmUnD0PlbZz162lFUd9A9FBRQdgkA0wIR5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D5F243003991;
	Mon, 12 May 2025 23:43:27 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46j233jhn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 23:43:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXOxbv6U+2l4rjCF9Q0RCQi4y/l2rGCA69V8fPy74Z25MIKbaRVCeWbHGERXeG1ZLNFJJ2Kw5/YayUqaNH8sK287OJAzylnXqcat/73M4k5EtPnxxcl/n+9Y7Zhu4/GIYRdXoY2IZwYUuho3yuPxDR3ztmrhBMVwq9B1gqjrejJBHHul3lrWclkL3IS1S4Zo3wCp1ygGvVYcVea38i0Z8+M2bbzBe6qGTaJvDc1F6J4Yeh/cn/NkX1hTHq7k/oMiDrr2YPLHiMINIri9g5uxc+y9sgLfP8+85BYoGXOYfYqTYJlmzFSgCfISZnrN47yfWuH+MhvEdOUFv7Rwg54pdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UmEK+uNAV1fgHyj+ndJhUVxmZvLtWpg9koshq7976Y=;
 b=CjDGJjDjHtAz9RIBWqzc7MPn04Iox9TjJRNmnd8/6hKSV/fUhcDbOTz47dWgAPFay+jPKD/kwyc+BdUlbQuSaWmFTnyzWADCdPcnulHdBQuJ7k4OGg7sRlcvukmmFHMleaD/hdX8XbxFhNlsO204nwykZWYSP9zKeJWL5pBi5BIaCI7y1UVjptN93Sj5HCRfpCV0fNF2efJFecjstckcVSiDEj0McQqRTKp+Oe9MEzPVm3g//L2D/Rk6jr7xJkDUAG+wUlyyqz4wAHksorjRHMe3q/lMDqyMEEyIksmzzzfB5ypgAUtCDYQrb4vlCfLu4KIU4t2ihFtxxx42wGdNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by SA1PR11MB6686.namprd11.prod.outlook.com (2603:10b6:806:259::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 06:43:24 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:43:24 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com, puranjay@kernel.org,
        SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com,
        daniel@iogearbox.net
Subject: [PATCH 6.6.y 1/2] bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG
Date: Tue, 13 May 2025 14:43:07 +0800
Message-Id: <20250513064308.1281656-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0111.jpnprd01.prod.outlook.com
 (2603:1096:405:4::27) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|SA1PR11MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b4164c-6782-4832-5b18-08dd91e9755e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LNVCKDoQxlZ/TlAxLMYwW66QIBoOvwGoksbCsXb6PcS+Mcja8HLpI+zmX0tg?=
 =?us-ascii?Q?Q+9dv4OBjZOOvXp29ens4Q2kD/XRlikVshxutyPni67VpHJjkvHKyILtQXei?=
 =?us-ascii?Q?J4NF3QDa7eUNxyLxetpwWT3wNyo+9YEdctk+1iRKZkg7VJNod/ckLBxbhzR+?=
 =?us-ascii?Q?8LOnPmEkzJB+QK+tgpXLYIcXQUO/oybVdXTTWtTotKztHvH54qBfyx1Ity3e?=
 =?us-ascii?Q?mgmfYpU3J45LEOtkY4MeMveKfKbtirSZC4bFlq/SAhPzPVRoUC80PD9bXyM0?=
 =?us-ascii?Q?BhU3ysSOIXfzZiVS2laZfaJtDnZSoyyhCba1ZqUc0xQQP8xRVe+e/uQz5J2k?=
 =?us-ascii?Q?QxCqJNopv5FefAsklZD6Q6DjgE2aELUZAsw7ZfFXIyAW06i9qibttLyx6nRv?=
 =?us-ascii?Q?TiowHCr+BfNWjuCPbfE95J1x2aU3PkL3h+iNg9asIYaUrG+pHq+SCDKTvM5u?=
 =?us-ascii?Q?dpqOTzehV5ynScTqOwVSM9YzW6Ax+rheT/WwdpNa+QTlf/MbH4YzZQ9UDdxJ?=
 =?us-ascii?Q?G0u4dbm3rjGQXHwflX6pogfZn22dy4Xri3dqLacdY5MbVVFiIt3/XkKpEcAF?=
 =?us-ascii?Q?9GG21VzMlQUhTMtI+ffULJHM0KB2JsupMXJiK8Jl5hSp+JgSxyjXZjBsg2mi?=
 =?us-ascii?Q?L7nzdESz4imLvqhFdoV/jb2KQx3a0EzhrFFHR36+EP9PVTwCpC/fplXFaTOm?=
 =?us-ascii?Q?Zkc3fReoRg9S0A6rkuACF9fhtyOQXPNrADq87MAjM3SUGVNTcfRYNtm7Q8mF?=
 =?us-ascii?Q?99tb0nV3NicbIUsyIEn6ntf9ZIkxbiGtF2dY/nyTHUSehEuqeSJuIRFPUZLY?=
 =?us-ascii?Q?jwj5duK5GlrqNsw1nkKYsAmOGIGHq0UeRId6UjZ+yRKEGwvbKsFcTplka1rm?=
 =?us-ascii?Q?gWASvbvQncj8HZw48rTn7FFz+3iSSpv9yeUD0WndygbmkAE1UHk7Gcgehnm7?=
 =?us-ascii?Q?0udSDFkrOCYIzKThT7jGqn5Efg2OOxxCqTc66XMhO3fnkVLNgXRggCeSm8+q?=
 =?us-ascii?Q?ic4dUp92p3OflNkd+fw4wjpAul5ROhTjVKhXWd45vioQZLWNZJZu7WdGAc9n?=
 =?us-ascii?Q?GcoJGT8sdASMwjnLHs0/2NHSuCRaVLuASJMSPrNvp+rBAqwknQGdrDSTdiOZ?=
 =?us-ascii?Q?uRv5QvH88FacNHXxvfwGuijZ/vW3zFZ32am+VmVDPcdzQzuGGzavbA8AWu9C?=
 =?us-ascii?Q?6N5VO9mb8XP4KpNqe/TpRLSAeAJ59XeXVUgYsAYSGp4lA4fTYLes1QHJJU8+?=
 =?us-ascii?Q?Zwu3BFDIFt/eL36Q2hCglJgtUUD+j2sXudfyMTHHYbaDoexBxMsZveKXevsk?=
 =?us-ascii?Q?G8ZILXX1iofCDHopJUadeRbBUetS4X1zEa0hB7fjt8nUeJJizoI75UnS0Taz?=
 =?us-ascii?Q?609+XDl/oaMmMbKp1Wrfm2r4MjchwskgaAK6ZPrB25ScBZb0NkRydmCMnJqN?=
 =?us-ascii?Q?P/FIWqdhzLOJBqMrH/p3kEqFgPkVCmcjYVsOniccnEFUCduulxcF+kWJEDAO?=
 =?us-ascii?Q?EvB3faQCGK3lIuA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWFYBU9G+jrzXkFk5BtEvL0jk8LIiv4x769SlYx34J5lx1oZPQACce2HKukx?=
 =?us-ascii?Q?ErYHrRmFG6/1Vfa2DWKFC1KU0fuHb6qjWks7LL+TQb4FuBRHNbT2Dez5ftui?=
 =?us-ascii?Q?5jxySzDil6VPh9711f/imMwECl5aZoOlo6KTV/6FORxdSAdPkBzMvPs9jWeB?=
 =?us-ascii?Q?k2lNCgHOOb2qdCE/vZe+tbhAjxWiw+Dbm9BkU3ZBUKCs9BGeRFAQbWqNwxy6?=
 =?us-ascii?Q?ozwKcNeD52et5nhq7Rqtl9Vt/6ucEP209pE+sIaoH08YdGOQpK42Hf2IhpXs?=
 =?us-ascii?Q?DD1A4ZicqmbTmq6NMryL9cHCKKL4ueRbvjQcRpw/x/UnCPlYCWQ1QxEbtlyt?=
 =?us-ascii?Q?ei7OGfAci+9gbA9tFcOOjofZ9WOeaEdeCGWWVchXezTDKJ+8P3y+qUBoZ30C?=
 =?us-ascii?Q?N5IzXFDtOeG6h4bVlLA5M4CD0Gxa/Sz96oauI9J0tQQje50bylx+7PCWRgo8?=
 =?us-ascii?Q?7UGC+ViAyKAwHZ5oyEvIoFQQLcjfOikbnhqykGdKkYIorFUvqb/Z+e53p25/?=
 =?us-ascii?Q?anHlQjjqut6qLjVVRun0XfAJG1j489wQCiOm3pUC0dorAVm7bwugg2ZisX1c?=
 =?us-ascii?Q?hqghRkqCuTnxPriST6gwQ5791Tt+17x8SxxQuSqWYLq36Lf+SzhE5mr0sKi3?=
 =?us-ascii?Q?Ee4aNw6ukT8EG/ZB4F8xoUX1RcRJFTXlbKLBcfXafYaQiXsDmGdH0PWA5D2E?=
 =?us-ascii?Q?4fUSoEMyK6R+m1f1Op6ATb2g9Vf2bbYUU4qKrsqmq1WqXveaA1U1KMA7Yuus?=
 =?us-ascii?Q?oOrx3P4h+5lYsCDzNTa1xIKptX6dCnqQvVhguU2rSbcePJeJy9VHogiJljvi?=
 =?us-ascii?Q?+o2rhh/XrErwcXEjWCBuh4Cv2m1CRybOqS5W3fe0oYUPKCz+prDTeDEngUMN?=
 =?us-ascii?Q?3ej4hBY6t4Qyv+rCiDm17IvLT7ydzMQA78XyAxSUXGL0mGZqQkTSrj5MQO8s?=
 =?us-ascii?Q?vf8h23xCdsA0L0TzNLjOS29BGBmx6yKYJvk79lU7v2YrQmchug/uFIZp+gaK?=
 =?us-ascii?Q?zlt6pPBNyvfyxDkGbbpGbtGrish2vM6WLxmN7MzJSIUhHBmWOTVEuYbeyLvt?=
 =?us-ascii?Q?TIXLUFhTSzBtiGh527o+1t9IDPjJ9ii0DVO6/Uwk2+dQNv+/uRH28klJIlDX?=
 =?us-ascii?Q?hiyH+J7Ffdep6KRqlmXeWM6SSKgENXvpzhms9+HPYdTIkAy1Y04qv00BfQBr?=
 =?us-ascii?Q?VjYbmnfBYFxd3tyM6d73CVLAeMBvn7t/mVt+h/ublVaYl27cBoXkngf5rOCs?=
 =?us-ascii?Q?ucuHcD2xSO2RaZ4vpHD73n8ovCaFaObB1sUKWtRZuCY0KhNXEk8owA69J9Dj?=
 =?us-ascii?Q?0vVagXR49KPGyIMRsMgq4bha6WoK8BTakff0dYQJOO+a80NREAQAYIY05Ppf?=
 =?us-ascii?Q?a792ZTI7tbnAFG3e+CeHlhD+sNelbrQa5ybPx6zyGtn3ORLzT1zNEfX6zue4?=
 =?us-ascii?Q?jaLaXsrVHhwNt/sBwu0VZMfhSAAWvUeIHIbnXsKRt506cPeVuZW2B2Ym6NWy?=
 =?us-ascii?Q?U9k+N9PgE7L8yS0s+INEmQ2VLnfGTCMroo7cgWd//AjN4l0PhXrP4fzvkIVk?=
 =?us-ascii?Q?wjvvvycC16rm3hnis8D6plPOQgP4kaK4FsA18sSlbizfR/6ma6m+OlB/XxFk?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b4164c-6782-4832-5b18-08dd91e9755e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:43:24.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3sMg3nWYikvTHRgq/t1xQ/psyrcqbycbFaxmNOY98ZiXl3aX3GKWo2KxSDPrbCTm9AyBbVFBCfPzajm9+eH94nQJ7i2aKOQmCUc113e2QE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6686
X-Authority-Analysis: v=2.4 cv=EojSrTcA c=1 sm=1 tr=0 ts=6822ea0e cx=c_pps a=WCFCujto17ieNoiWBJjljg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=hWMQpYRtAAAA:8 a=t7CeM3EgAAAA:8 a=-PzTzOnoyufgpEh59qkA:9 a=KCsI-UfzjElwHeZNREa_:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA2MiBTYWx0ZWRfX7v6gA4uIJNfr DsxeAb7T4N3spzD3mQOF42r34Rf/xr3Z6uFwHfMOFC46/nWIbHR0+cP3AolSLkLgKgXbtjDlvS5 JJUfUGVEmWkvxobZszqcFxQlXqfFiiyaC+POdECWj13H1Ge7C7dcmyj57n6Exl0M145cHiIKeyT
 VjHLWxo3lSxC6vMrVinTI69YMAybh+/nfehi2+MptwFDKI+RRi1AKLNUFBVLx4KAS+m6J9/7hYe zGaoefaGwhfuCHxPk83M0jRF2l7G8PpwS8QpAi4dZceLtAOBnlUDoe+qy3ji6kCp6BFY2iKhnVu FaJopdSh7iyAl1I2EP1RSDywZ/zWOVhmcmAeTzoTNWZBjZBWknnV2dDDYamsbwNmx++0dK6+PUV
 4vde5+XqcOkzNgvm2QWZ6ZXpST940rwJMxmhpXBzQEn4PgX5nyNXccAAMv0qW4hWN9OkXR0A
X-Proofpoint-GUID: qZXtU1GHZL4y7ejp1nEDX0Zu1xiZTkK5
X-Proofpoint-ORIG-GUID: qZXtU1GHZL4y7ejp1nEDX0Zu1xiZTkK5
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=983 adultscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130062

From: Puranjay Mohan <puranjay@kernel.org>

[ Upstream commit 19d3c179a37730caf600a97fed3794feac2b197b ]

When BPF_TRAMP_F_CALL_ORIG is set, the trampoline calls
__bpf_tramp_enter() and __bpf_tramp_exit() functions, passing them
the struct bpf_tramp_image *im pointer as an argument in R0.

The trampoline generation code uses emit_addr_mov_i64() to emit
instructions for moving the bpf_tramp_image address into R0, but
emit_addr_mov_i64() assumes the address to be in the vmalloc() space
and uses only 48 bits. Because bpf_tramp_image is allocated using
kzalloc(), its address can use more than 48-bits, in this case the
trampoline will pass an invalid address to __bpf_tramp_enter/exit()
causing a kernel crash.

Fix this by using emit_a64_mov_i64() in place of emit_addr_mov_i64()
as it can work with addresses that are greater than 48-bits.

Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Closes: https://lore.kernel.org/all/SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com/
Link: https://lore.kernel.org/bpf/20240711151838.43469-1-puranjay@kernel.org
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 arch/arm64/net/bpf_jit_comp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 5074bd1d37b5..7c5156e7d31e 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1952,7 +1952,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_enter, ctx);
 	}
 
@@ -1996,7 +1996,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->image + ctx->idx;
-		emit_addr_mov_i64(A64_R(0), (const u64)im, ctx);
+		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_exit, ctx);
 	}
 
-- 
2.34.1


