Return-Path: <stable+bounces-103996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CA59F098B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925E2188CD76
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD48F1B983E;
	Fri, 13 Dec 2024 10:31:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D81BE251
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 10:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085913; cv=fail; b=B+AkDSTyrYE8T/5Wq4FOiwI40KiKkPnGbHt0GqTuo5cKlM/qR6VAU+rkStqmaefPk+61rnW8y2X9iOoJ/S4oMRMfaRDep1wvI57pNgmnf96aXplDeV44vZ+txX+JlySG8WuiRQ14iKVvA7XWp7lGNOdMQVNiVLl6MvYhpySLKH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085913; c=relaxed/simple;
	bh=bhzU/+939C18twR+2VmWrzXXXhwyZ+uQOzevNc/WJXw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QOHxAnyloCN7LFyxXSl8oy5uyfpURjv+10mC8bhkMFf/OIm0yD07RdCtW5/AgBfhn2Dc14Qd+rIWjSCoStJZw/phz11AWUTI3+G2D03MGku5zis6G4+NnM6fLN5T/u95rCzoMossJ3FTqK8ZaVf4aWTCHuFRrMvWtKB0VMU2DuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD5B5pF008564;
	Fri, 13 Dec 2024 10:31:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cwy3pyv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 10:31:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xb7A0cJpNwwWp4R53c/8Gn7kW1KyMI18fug40PJtL/XCwRb+CEL+DNY9NVeFIWN2RRRvYCb6+b1N/ifu3mgquAk5ASDTWDdu5q/5Qs49YqOGeWXQqHeqOGgXks/pTnTeVzRH5U3BZwHg+7jBdGaPn2mZAyMGV1+j5qGs0cznIwgTyk2Zkv6scXxxGFgHlROJKgtRrzHgTxShu1nHQX4TcdZgP/epnaMGR/5U0A0JQviw6NqoM41llQSpcBolzSV/1h0W7lWiWEOi1UIrCPV8JsJN99xXXxHI6NFua9MK/thbFiTHfP1m06maeMq4HWwaUagHEP08aX16uw7KPV6LGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bnn+G6Xd8DrzY7rW4LvzqUUXTmQSvm3DRpxr6c9RrRw=;
 b=vasUND24EqhRxPRxVUWI4+46mwKficJgNH7dyGdtTWe44tgc10EH3ly/TqqeV9QaoTkFP/0OvAa1eP7hMzQD48yY22K+QndKQCARj1VjNA7h6CCGI08kVLMLpsQz3sUZS/NGlrpAGCrXG31RKTNCy5M9w55vTBUt8TR3iWPNkFX2IDothKFxBq926mYwAl/9DveB4y9mBuEGL8364rtskn5MKr3tpTVGs1KVlXzYBj6gZCQG6ewdU/jnTDCHc0COJ1jIBZkQeEye4Vmgfj8cxbGRK2NKYf/8Rfwd/jmuGti72+9C2OrpLvKjp3TY0AfLFYuVhPKDq69Zl/+uz5Ttwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2671.namprd11.prod.outlook.com (2603:10b6:805:60::18)
 by CH2PR11MB8779.namprd11.prod.outlook.com (2603:10b6:610:285::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Fri, 13 Dec
 2024 10:31:45 +0000
Received: from SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326]) by SN6PR11MB2671.namprd11.prod.outlook.com
 ([fe80::3e06:cc6f:58bb:3326%4]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:31:45 +0000
From: guocai.he.cn@windriver.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, ian.ray@gehealthcare.com,
        bartosz.golaszewski@linaro.org
Subject: [PATCH][5.15.y] gpio: pca953x: fix pca953x_irq_bus_sync_unlock race
Date: Fri, 13 Dec 2024 18:31:22 +0800
Message-Id: <20241213103122.3593674-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0079.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::15) To SN6PR11MB2671.namprd11.prod.outlook.com
 (2603:10b6:805:60::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2671:EE_|CH2PR11MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8a390c-1389-4385-9715-08dd1b615786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?veOqCvlA01epoyNDGj8IeHigskD3+SzTNkJI/GnLAj9CgpNLG1z0VLAh+o4K?=
 =?us-ascii?Q?fjVnM5yKDl1dx7ZcGU453vOGcEfQ2WIVlOrPP/8Ov2ljf++i6eF+j3XQi5nM?=
 =?us-ascii?Q?MurjQ48G8HOzRlr+A1O03jj9vOsPh2EBMdj3Gjcn0JWm/Xb/Lw2KZlsTxzZ7?=
 =?us-ascii?Q?g2h5Wj9giEUhuKgmbrKaef+B0B+Ano/EGuiX4DFveVa8xQneQK9ljf/EDQuc?=
 =?us-ascii?Q?uzNxcY4VzWmmKxq8KCSVqIhWXhGfgZIcE6n153ysgzf6KQDLFQyn9mx4GCUb?=
 =?us-ascii?Q?hdIVdPSH11zYyPzoPwr8QORDJzgiHxROO1zgnxDWo7XLLLnUazRvgRSgy+9j?=
 =?us-ascii?Q?QbGv/xvDMZFqNefCV7iQz9OQLxB34ohv7+/zJyEutvOyUGiAt+duvJcCFyx7?=
 =?us-ascii?Q?d99UJBSXBWsDbqHcmIVnJfcdqQjrbVc87nMwvJytv4OmTP/dzxaem4cyyD0J?=
 =?us-ascii?Q?GUtGGXBDFtUbaR2gQcB/EivIYozXUGXGzEDfmIeXJcc8Igl7h6yibsk8u4K5?=
 =?us-ascii?Q?SBW+/tC2hTgzIWx4YgGbxs0qdHMr3SOf/dDN7b/wcmO2Qd0XlfOumFwZ2TyY?=
 =?us-ascii?Q?uRXeXqrfQNraIdVeDrwrpqgGS8sR+roBroWIFpcZsja0TITebOSQcOoy6NOT?=
 =?us-ascii?Q?zfjdHhYnLK/aekRvjs3g6w6bPNQ7pKPOONS2eyY0zPhBSuQYvSyX/MvmuwG+?=
 =?us-ascii?Q?U8wdXlcj3WsI0iAD5NlHaiiFmS5I2OE6KPF7NB8QAPTiH9t7yUpL3MzlqWya?=
 =?us-ascii?Q?5rfke8EhEmpOHioHnsqG4W+e5mHnl+iggFR4ZBgaXfmhhQ2afdnxgxZ3tGOt?=
 =?us-ascii?Q?Wb/WpAkHGJNGyxtgVqt3fQ7BBnl+VMH32OZbk0W6i5/jTxUKeJSZGhY6gJVw?=
 =?us-ascii?Q?XEfQA9/ow1iHN/Rkt+5zqpVKOBWfvuYPncKm0VcbFkzNSG6mVX6kzdBq7wRF?=
 =?us-ascii?Q?/Nw9Tb+YazowbtMiT1ID5/4vaVXq3+lyfsDY7NKQ0B7LDNdcFdkp8GzGO20a?=
 =?us-ascii?Q?x+8mxkQaVN+q8w2Whd+bW+qY/mSlwUDrpzGThJLkDI0F9S9DAB5gOtpk4oNM?=
 =?us-ascii?Q?ktwwZuHbdNxpGA6ue49rDEDiLD5Kmww2n0+mCTmHOt2NsISsTFFsO4EpAzvz?=
 =?us-ascii?Q?CAhsFGF9QXMRpRsskLE5LI5uNQ27yxqpTGsUrxkEiXcVtifiZfW7vOUqF1gm?=
 =?us-ascii?Q?gxmT+3tcrP3otAytzL1aQA87vrPv89FFQq2vhxvR5gXlz046pmLd5dcuuma/?=
 =?us-ascii?Q?3h9xp8tAhbJxw/UKANkfgC25pg22d90dPZXhAaIsd7NEXaZ0xyfV/s+rX3BQ?=
 =?us-ascii?Q?OkVHS1zixrgXKqjpm65ebhuSUp0aZyFiUbDd6i1nD/rkQdPqCbg3k3yZyH1y?=
 =?us-ascii?Q?CR1VuPhvVO9iPeT9MP0ebC+smZpC8jO/yyRx+a2DeU6VNK2nng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ptiu8LZ5vsTmcQ0cjY+Dp3bECvB03HmQAxoIB/KdTrHNEKHvMNlksM9xQGQ8?=
 =?us-ascii?Q?4unwZATX8kQhh/d79fr0O3537Oh06hB51Nnu4dNnXIidWa6Mz2/bplyuiv9o?=
 =?us-ascii?Q?jv/FXpU94hlgI6ppvylcwaHcktJRIev9mGU+w0Rl6ppXZBO0WqnKFPWGxQfw?=
 =?us-ascii?Q?H1z39ssP/ijvErT637mz2LLbgCNUDiYuAMG9+QTDOwEv3WtIo7JBxkwrLGgk?=
 =?us-ascii?Q?FHV8nxMjrYvIDwQd13kIb71BxBGf1iwnuOO/rcju0IwNiLrTvuSPX+WF7CP0?=
 =?us-ascii?Q?2AylCKJR2tKwm3P76UQgDglk18KWInN5/YRqkSIYt6OjFCVmlUENnulFmKw0?=
 =?us-ascii?Q?J2I0Mr2pnb2t4OYykShfO722XDwHBd3uilVnCFpUkcXfDeHCeP1H0Cquovyd?=
 =?us-ascii?Q?n/CSwEkkKRyilNYUVGK8i65ypiZmNp/VmMW9PjtzxBaricmXLvFa0s1mGkUW?=
 =?us-ascii?Q?EboR1QeKtJd3mefKGEqnVxIDBS0Uc74dUHOdX3vCtZju1zdCNEbgJ2i/RA3R?=
 =?us-ascii?Q?Xjbt9593yuw8SGqXoh1gw3QulO0mk23TbcyQjM/29v5A4pTSEL95Uw+6aDem?=
 =?us-ascii?Q?YQr7rTMtEIIWTpXOf0lRjxVkpJx9CnIjQpufPfu8NGy/h18Gs7gLejNKmcwj?=
 =?us-ascii?Q?SNYof3VMB7/3tG2gVoijZ+lc0u7ft62Vt5wTcQ3NhGdPj901Xw6+Msgwbhb/?=
 =?us-ascii?Q?x3/raEhC3n3Rb3uZk1JVwZUCGBjW435B9Ir0xWfzGpuy2g3X3oRHmEG7IddN?=
 =?us-ascii?Q?EN2bnoYk5Xn/wkPuI40zxkQHcuZkCl8SoM5NCKs+BIxx+mkWlNwEWDLtDCJ7?=
 =?us-ascii?Q?lGcNqgO5v8JokTKMy6j9NKQSepfiXT2288c6P/fjKu5VAfCIHau7PLOX/LVu?=
 =?us-ascii?Q?MdnOBOILYumvfLcHEXuoG9ZV0VwDNjvKCnHiaKkWt8onbU8+cDrfamRi3WcX?=
 =?us-ascii?Q?oWRqwTXvEM2psVhh5e/HdPbjAqTVzVAOfMNlp+HmErRJRhaPSwqZ01yh0O7R?=
 =?us-ascii?Q?LmlB+A2fqOMjD60jFSYloq6UHlc/u83AU1tqG56P8A5tPE2rw9J8SFhj+/lk?=
 =?us-ascii?Q?r15FnPnkYhbss5otVt9qScelusry/xsQM1mpH6CFw2dOMDSw1ZWd6yqQEZRa?=
 =?us-ascii?Q?HxYPkS69JBDOtSJ1/2AQGN7k2PkHvWiwAWBjX/W/2gNZ6GtfDE1X1yqj4NWW?=
 =?us-ascii?Q?uAKPCx6RTQeJ6blZviUypAWEw8VeiTFGR6iqhO5Mtx9a8Ds60GoI6/yBpU/I?=
 =?us-ascii?Q?Cqhs9CujtZc5y/JBfJW6RNfmP00yTqr8P/k5FxlKY52Y1WM4RmsdeaqJ6ueT?=
 =?us-ascii?Q?8x2FXLMcKQI27Ew/TRL4yPlAinfAQeCs3E2KbqNPKKGHJR/0yq2f47DPnWCD?=
 =?us-ascii?Q?VWCn/E1MJRp5NQOVGQhTSDzakM8P0ptEKk5iS1mKe8cVmeOkJE57Mg68EacJ?=
 =?us-ascii?Q?p4C+cUvpgkHIQIfWE9fienQ/8ScV4BfpDuvvyzd/THnMrvZ2N3zPX0hXUSNm?=
 =?us-ascii?Q?ca6qzsWUBHCZPz1pOXaXiNMKeJ7FBSjeyklRIHF602T1OW/j46q4W8fTzKFr?=
 =?us-ascii?Q?qjXEnboZMxpdY+SKDXCJzBMSLsXIKEbRVu0JQEwJzyV+TLTgftBQjlLdQTk3?=
 =?us-ascii?Q?Hg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8a390c-1389-4385-9715-08dd1b615786
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:31:45.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+VGwHkmPwxOG3CN+QZvS2qLqOVMw2Fqbbms0Z+YpWiJEHVl18pqnqE9wZW1pD5XqnAr/p7RPV0TitPkAxWTwTZG/ai9TlGhHNpct+Jh03g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8779
X-Proofpoint-GUID: jhnqTszDPQD1crdZ8Kjjx8yWvxRxC1LA
X-Proofpoint-ORIG-GUID: jhnqTszDPQD1crdZ8Kjjx8yWvxRxC1LA
X-Authority-Analysis: v=2.4 cv=D7O9KuRj c=1 sm=1 tr=0 ts=675c0d13 cx=c_pps a=e6lK8rWizvdfspXvJDLByw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10 a=VwQbUJbxAAAA:8
 a=lb8OlhKpAAAA:8 a=KKAkSRfTAAAA:8 a=t7CeM3EgAAAA:8 a=NBQNZUlFNAa2cYorCkcA:9 a=7GnFejQYy5TgUzHuXd-m:22 a=cvBusfyB2V15izCimMoJ:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_04,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1011 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412130072

From: Ian Ray <ian.ray@gehealthcare.com>

[ Upstream commit bfc6444b57dc7186b6acc964705d7516cbaf3904 ]

Ensure that `i2c_lock' is held when setting interrupt latch and mask in
pca953x_irq_bus_sync_unlock() in order to avoid races.

The other (non-probe) call site pca953x_gpio_set_multiple() ensures the
lock is held before calling pca953x_write_regs().

The problem occurred when a request raced against irq_bus_sync_unlock()
approximately once per thousand reboots on an i.MX8MP based system.

 * Normal case

   0-0022: write register AI|3a {03,02,00,00,01} Input latch P0
   0-0022: write register AI|49 {fc,fd,ff,ff,fe} Interrupt mask P0
   0-0022: write register AI|08 {ff,00,00,00,00} Output P3
   0-0022: write register AI|12 {fc,00,00,00,00} Config P3

 * Race case

   0-0022: write register AI|08 {ff,00,00,00,00} Output P3
   0-0022: write register AI|08 {03,02,00,00,01} *** Wrong register ***
   0-0022: write register AI|12 {fc,00,00,00,00} Config P3
   0-0022: write register AI|49 {fc,fd,ff,ff,fe} Interrupt mask P0

Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Link: https://lore.kernel.org/r/20240620042915.2173-1-ian.ray@gehealthcare.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
This commit is to solve the CVE-2024-42253. Please merge this commit to linux-5.15.y.

 drivers/gpio/gpio-pca953x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 4860bf3b7e00..4e97b6ae4f72 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -672,6 +672,8 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	int level;
 
 	if (chip->driver_data & PCA_PCAL) {
+		guard(mutex)(&chip->i2c_lock);
+
 		/* Enable latch on interrupt-enabled inputs */
 		pca953x_write_regs(chip, PCAL953X_IN_LATCH, chip->irq_mask);
 
-- 
2.34.1


