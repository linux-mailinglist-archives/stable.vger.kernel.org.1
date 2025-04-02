Return-Path: <stable+bounces-127396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F17A789D1
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96541894192
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED86235348;
	Wed,  2 Apr 2025 08:28:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B85234977
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743582517; cv=fail; b=lvs7MDHQea/56s8/EwnYYuF82S5Opo1k1urZhnPr1T5I3sg+7P/xVGG/x9hyeTCPxVd/XkXb2lI+uaWR6igt7xlCDqniBtrUnIpdlxmT5nRkZeeVRWDytjWpRNTuhfpvWNeLna6ghz+SK/0Nw1kxmeWzfEnwA8T3ZH5HzJF+74o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743582517; c=relaxed/simple;
	bh=/uvA/PJRHaTUAe43cOwflGC4NSfYwP4FpEjiQDgFDmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mbUqUS/ak3FBe53mCpvfplQnAt03eJK+VU9dc4Y316kAg8noPt5jDHia8EUZqkFtOQsC2XdHUWB7i2+Uqb1FAGoZtep5RG9ImUMA549Qu2MyPkV5l9cEH2agxISpdTPcKjuAB35weo0Wak9xFrpuKDWLWwiPGMHUKByaywwU+zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53246w6M028242;
	Wed, 2 Apr 2025 01:28:30 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtc9rh7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 01:28:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeERsAonmNmCXIW62vXZpzPXvWWR/RUcCI1m5ilLPrLhqRalHW0wn+t8944jlI6Lq3uKny1PMcU52GwSRnvRcz//LFeLqIlpYHcq3xTAAxXveCLv8YI6DXS7k4rg1UV/uROFoR6xtehFJ07YZ7bOLSgtAB9urFDKeufzpQvqvY4jv2DSuud0iilpQ/8m4psINJm7zQeyuvSSif8H3fQxKcgZ6u9zslqHO0XzumU2wbfQnb7iuup6YP6z+ZU6mFDmD2DUpcWNoUusGazcbU6SQmzqikrsEJzwqu/vlxL9FLjIs93lmj2+TgNDpFvuJwRZ/44u6UEpw2A3pxa7kvWSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WliGUHm56/PCCYSt087lX9QwboBwclUXMl9ZXfPU4hQ=;
 b=HhnpegHXm8DW2mOXQTWTZ8bRt2RMv/v3qyzdmEkd23jhQMW2Jrt3/FJMKgz4fuhUexacfcBkW4VTt5TwAollEhBBvHcuKIkFHv5P0Q/P/DHIQBfoRjnOE6SRPDQG5ghB1DpSWCAc86tAjSVY3zbBcIkmqE+mFDXlAojaMQdC2nkDEDikdS9aalLlpOQDsn+UHpWdkCbT6tjeZflSrjqhXypD2p4BBBX2tx58AZrkEph8ltsTOdOUnkING9HUkf5GRzNiuMrm1cL/D4y+9ArJKE2+Pw36RHoOivb2EXsKboi5whd3P1swj+iPieN7/qaHjn4EAZI/9VKcvS0nfZsmjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) by
 LV3PR11MB8604.namprd11.prod.outlook.com (2603:10b6:408:1ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 08:28:28 +0000
Received: from DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a]) by DS0PR11MB6325.namprd11.prod.outlook.com
 ([fe80::d074:3eea:6500:c94a%7]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 08:28:28 +0000
From: Kang Wenlin <wenlin.kang@windriver.com>
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, akpm@linux-foundation.org,
        wenlin.kang@windriver.com
Subject: [PATCH 6.6.y 3/6] binfmt_elf: Use elf_load() for interpreter
Date: Wed,  2 Apr 2025 16:26:53 +0800
Message-Id: <20250402082656.4177277-4-wenlin.kang@windriver.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250402082656.4177277-1-wenlin.kang@windriver.com>
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0367.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::14) To DS0PR11MB6325.namprd11.prod.outlook.com
 (2603:10b6:8:cf::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6325:EE_|LV3PR11MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aab8f64-5c6f-44f3-b833-08dd71c057e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xa/8U3730LAcI8t8/0W7aXtJmQ1ZsF5MGHoWQ9cAwA1YPov+7iSX9NRUubpg?=
 =?us-ascii?Q?YfC/e2677+IsS8KpecJkr3FZVmrwyp9aR2A8ph+4EGDiqS4PR95L+nK4xEK8?=
 =?us-ascii?Q?9ONWRtmTVgvv4MGdv1C2h8juST2SuQPTVPJy8cESDP9pKczjfQWvbfO/hA9S?=
 =?us-ascii?Q?RaHHB3p0tTZUmBsKFh7qZpOCgb7nfOyIFJPU4hV1WJK2MPZZgUsHdA3dT8GO?=
 =?us-ascii?Q?aBixrpnhso9jVa9lqC9NRyl4DQYb8zKPdJMjNULWyELK67+uWQfn5Bk4EwwC?=
 =?us-ascii?Q?haj9HdmO3VPkXCmmPLDL2SyUTvvoNrnNzbg2DvBsIuyDnuyUJmO2Bucpnfla?=
 =?us-ascii?Q?Ba+Vm1uBxcBW9b5+wc1dbSKIoRb8JWlHGSJGeaeBIcWIWtUS1fe/2z0tzleK?=
 =?us-ascii?Q?9Kgx1WJzV2yWCsNk4/963m+i2+ZEM2wH1MAEs5tSD6XOqyA3t705CeDKbBAf?=
 =?us-ascii?Q?E0KplgARUWxQfi45u7v8M/sIMQPtZKpYwmN0gG65Y87qgl6fv0qYqSDuC4ZG?=
 =?us-ascii?Q?FhWe3S6WdWctfeqDJT/g5izRXpTfNjaS+CHuZ22WHGxYn7RedoDiSUqI7DCM?=
 =?us-ascii?Q?Je2dIftBA48CjYCyuW4wTFmly+FXuE5ZV2tNZI5XTVAPLzRrrYcQRKd1MLpR?=
 =?us-ascii?Q?zsDv0zIZkkmvXohH9DV94vwsOfIiwDUeAp9r8CdtZEhwPPttlC5Dp+H7t9Bd?=
 =?us-ascii?Q?CLKzXWfYF1155/+zJR1P66SEjMCQf/3wm+FAW7l8TtBLxCWGTT9BYDsoBNYt?=
 =?us-ascii?Q?5ftzE/IFrHIpvlzgblcnfidFTVm3y10TGu+BlkqLqV0RwdZ8UsjsFz69+1dN?=
 =?us-ascii?Q?SORgBqZ58GY6jwFDDsaNOP5nlXqP+Ujx7utcLXaU4I2r7WK8gJgCukLUI32N?=
 =?us-ascii?Q?LCuEHfc+pCw7NkTx77V5TFQPKj0ZHfHvmRfKuE/LepqVMRFRVCm1bOM+PgRU?=
 =?us-ascii?Q?bXS+nz9GkgxVNVAWt5Vlb3moEWkslK2M0fXWFlw7g7VHnXZqMuh/BKVklv+C?=
 =?us-ascii?Q?TyDai7cUOUSUFrnX/5rNkikfSNtvrpYI5eWzy3QJqAwYwB2aMwXBdr5hP1sS?=
 =?us-ascii?Q?ffSPPIcOsv++9TVL3J5ajDlmxwYma6mfaN8YLmfH4WJZe4x/xhi5T1KRJ9Q2?=
 =?us-ascii?Q?drKEaBGryUR/TnOUPyXRFwXpIR6DOjQq8YQjxciWGa4JKKonT2RgeRTuS4pz?=
 =?us-ascii?Q?574GGIse6AvdFSx6hc2zNscZsUYU04DMQNDaToqsxJ43m0MLsyd4slb29JMF?=
 =?us-ascii?Q?KGPXXFqvohvLknGfJQo/b0HT+dkIlkZj/kW7mrSOQ7NVuXEt75w6dMVgmpLq?=
 =?us-ascii?Q?8vLUMkyPQUwN6siPuMBC98MyXQ50XkUSqnJVOW1E/iyz1ySgMCh1NKKksdPW?=
 =?us-ascii?Q?AzYnG3AcpcUbdYHvRaV/Yx4Y1LL5dg9IW9T/8dJ6lXCfYyXriL/SMwOOYdCW?=
 =?us-ascii?Q?LKVebFFJluUZ0cTvefv73mNpeHhX9lekXaEU4kQQQlhNIMoY5Nd3ujYuoo00?=
 =?us-ascii?Q?ZNE4gAAboXwylb0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6325.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y79fnIWRcbjcQPcCPLMpzr1bWWIU+kH/AsroPZGOHFtLVb5Up+7XDB0fyMXT?=
 =?us-ascii?Q?RDaSzi9mEn38rQPb+TlbfyEQ2jdqUTKCWZCTSC/jI/+yHltjXgDCQ7JyYUnK?=
 =?us-ascii?Q?oV8sLvQ6s66bmboI5BENcbbzY0RDu3GXSynpCVPcgox1bOHkH/cfBEJ5F3rD?=
 =?us-ascii?Q?ScI2aiO5pgY/KIQieEgVQVE0mrvzgBdeWO4irD1sVnqsDXoDkyydyAKPq+N/?=
 =?us-ascii?Q?uRIkH0Sh3T/s4HDzvvb3sGwM3IkjnhqmQno2dRCg1ntlqcpYE2auVe8EshMd?=
 =?us-ascii?Q?bYjoM5ym78p9WdEr8GbWTFVosbkCg2Na7VQ47kOprB3UATh6UwmSH0P7UkkP?=
 =?us-ascii?Q?PWMyZJybqNd4ICkQywihBM7pLaLuhnK7ZxVDPcB9i/dfHfrKGMBQrDXyoJyS?=
 =?us-ascii?Q?8tq76yiTHkJPZ3i2q/m0Z+YUlvxHs9zgOWT7ildvlb2P1VlRQucThQQuJeRJ?=
 =?us-ascii?Q?DSP+l4blkceX8sakSnpTI/0T49IJki6XDh5M8MTFgzK5d0k0eDW+vyzN5JSw?=
 =?us-ascii?Q?omwT79JLg9ri0dQVy939bTux8Qa1CRRx8zn9Slhsig8fXIkZJb6tm5/YDs2p?=
 =?us-ascii?Q?6szrX7b7W4B4RDkb4qX/jderQTnXqnH5UOR++pyDgJKTEsAgHkvwPsGf69ua?=
 =?us-ascii?Q?jY0Q5pTHSsh2sQEDLstxOjwONkPsujfivMJh/OzH4dqWcfqc2OSQ6S+ghaI8?=
 =?us-ascii?Q?lU2nyekTjP/bM7OvXhzPjP24aexRG8P31E9UKYlEiZpOi5G+r0NbKfSGxFIj?=
 =?us-ascii?Q?94fG+5r8jnKNF1TnOYS02UNvx7Qc3iQviB9oUfJpCoAzJWLyS85wM0bdlHHJ?=
 =?us-ascii?Q?Npn7QKSsHGC0Q0zFL7wrjxP/NiISW9N1NX2khcVflmyTAw27w0XJshN6xKyL?=
 =?us-ascii?Q?ZE82uIJSikeqoBx3sQilUivE1GoEIp9ZSlLbNttmfK1XDyM+ITH4SFkD61Cf?=
 =?us-ascii?Q?Amx8JfYL0sy8D/V6GkMaVf1ESPDcqaDZF2P7yKJYNn8hUK9+w8ArUI4/WBZ1?=
 =?us-ascii?Q?QJ/8op3ACNO/wHFkiqyFKikS1UmgCZCq3yvDnXeKft8rGRjewH8wT261FDey?=
 =?us-ascii?Q?TSpOpa+6qG+/nvMDu49czEaMWeJ/89AapefGQEiUVl/NyXfgoJK+nZp2EiR3?=
 =?us-ascii?Q?mndVumiWPyJC5xkKFQK3vp6ho31FgrT0uvaW/UxkzXgZyKssb1+wZSwc/k6U?=
 =?us-ascii?Q?6HQqI2a7z3sZ0qpia6TGklYk/NzEdGfokAB9Kc0P/iDfRcGt9iAq3xOAeOy9?=
 =?us-ascii?Q?bMyLbTTLG/mm8jDgHuuKhj0c3nb4nnjESOJV/fwAHvoWTn6ReilvahKXZJMJ?=
 =?us-ascii?Q?7mhCEz0o6CQ0JXbB4bq2t/nwXttgsq8UFGxdZeRHXF4MZbBuyiFzDkkad0ws?=
 =?us-ascii?Q?Z17Hy7aGLXNsCIbs747YV9u8FvZCc7hgwEzsZy2WzmRoYcY+luYySBRDjISj?=
 =?us-ascii?Q?n55fYp/Amg64QD0Q+hMxMtBqOC6dhmUtSEr0l4igEUqZmlHQuhuqyL+SzJ2e?=
 =?us-ascii?Q?rEMt6i9Y2YJg4R+u0bI3ITssr9EjbrIpkcMCS2MHMe1HwNtMiOMxK1ULvKgz?=
 =?us-ascii?Q?v8nUBzXXBT+RtcbFons/L+SxGYMdOJRxjUSQND1N24t1wzd29zUX0e+ueWDW?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aab8f64-5c6f-44f3-b833-08dd71c057e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6325.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 08:28:28.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MBHhrWdWJ4qQLhFTtT2YY63xJlgjN89T4V22WTDsl/biTvvrzJzvHVD9xDW+qqQJOEV2LTt0gKrwgHVDyI6x8bRLLgQ3vMdvZVkIE1UT4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8604
X-Proofpoint-ORIG-GUID: nLbdXowDZyO0luT9LVGA63KOsabvN6A9
X-Authority-Analysis: v=2.4 cv=Tb2WtQQh c=1 sm=1 tr=0 ts=67ecf52e cx=c_pps a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8 a=PtDNVHqPAAAA:8 a=drOt6m5kAAAA:8 a=37rDS-QxAAAA:8 a=20KFwNOVAAAA:8 a=t7CeM3EgAAAA:8 a=pfM7RCkbe295brOvbPYA:9 a=BpimnaHY1jUKGyF_4-AF:22 a=RMMjzBEyIzXRtoq5n5K6:22
 a=k1Nq6YrhK2t884LQW06G:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: nLbdXowDZyO0luT9LVGA63KOsabvN6A9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_03,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020053

From: Kees Cook <keescook@chromium.org>

commit 8b04d32678e3c46b8a738178e0e55918eaa3be17 upstream

Handle arbitrary memsz>filesz in interpreter ELF segments, instead of
only supporting it in the last segment (which is expected to be the
BSS).

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
Closes: https://lore.kernel.org/lkml/20221106021657.1145519-1-pedro.falcato@gmail.com/
Tested-by: Pedro Falcato <pedro.falcato@gmail.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://lore.kernel.org/r/20230929032435.2391507-3-keescook@chromium.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 fs/binfmt_elf.c | 46 +---------------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 02258b28e370..bed3c0cfb63f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -622,8 +622,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 	struct elf_phdr *eppnt;
 	unsigned long load_addr = 0;
 	int load_addr_set = 0;
-	unsigned long last_bss = 0, elf_bss = 0;
-	int bss_prot = 0;
 	unsigned long error = ~0UL;
 	unsigned long total_size;
 	int i;
@@ -660,7 +658,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 			else if (no_base && interp_elf_ex->e_type == ET_DYN)
 				load_addr = -vaddr;
 
-			map_addr = elf_map(interpreter, load_addr + vaddr,
+			map_addr = elf_load(interpreter, load_addr + vaddr,
 					eppnt, elf_prot, elf_type, total_size);
 			total_size = 0;
 			error = map_addr;
@@ -686,51 +684,9 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 				error = -ENOMEM;
 				goto out;
 			}
-
-			/*
-			 * Find the end of the file mapping for this phdr, and
-			 * keep track of the largest address we see for this.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
-			if (k > elf_bss)
-				elf_bss = k;
-
-			/*
-			 * Do the same thing for the memory mapping - between
-			 * elf_bss and last_bss is the bss section.
-			 */
-			k = load_addr + eppnt->p_vaddr + eppnt->p_memsz;
-			if (k > last_bss) {
-				last_bss = k;
-				bss_prot = elf_prot;
-			}
 		}
 	}
 
-	/*
-	 * Now fill out the bss section: first pad the last page from
-	 * the file up to the page boundary, and zero it from elf_bss
-	 * up to the end of the page.
-	 */
-	if (padzero(elf_bss)) {
-		error = -EFAULT;
-		goto out;
-	}
-	/*
-	 * Next, align both the file and mem bss up to the page size,
-	 * since this is where elf_bss was just zeroed up to, and where
-	 * last_bss will end after the vm_brk_flags() below.
-	 */
-	elf_bss = ELF_PAGEALIGN(elf_bss);
-	last_bss = ELF_PAGEALIGN(last_bss);
-	/* Finally, if there is still more bss to allocate, do it. */
-	if (last_bss > elf_bss) {
-		error = vm_brk_flags(elf_bss, last_bss - elf_bss,
-				bss_prot & PROT_EXEC ? VM_EXEC : 0);
-		if (error)
-			goto out;
-	}
-
 	error = load_addr;
 out:
 	return error;
-- 
2.43.0


