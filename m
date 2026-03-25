Return-Path: <stable+bounces-230289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHJKF56pw2nAtAQAu9opvQ
	(envelope-from <stable+bounces-230289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:23:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F00EB3221C8
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3F4B302AA5A
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742D934E75A;
	Wed, 25 Mar 2026 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rSkHsvCy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A73537DE
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430617; cv=fail; b=gizPRPhHRRvNT9Nirxp+IgMKv9sMj1IlD80m5VudQKRm5if1kKAxj8KZd9Zqaqd7x2a94XsKh8HQn6RNIHvuzID3E2C0sZQcVZut1ELxyZ0msSSB+tpT3P/5r0k53nWTgLRw7nRtWiQ/BAl+zXYpICccXVqfJacQFgiDwvlM0OI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430617; c=relaxed/simple;
	bh=Ax6Kf3pi+kb3XS5tHVlgTj4fh9+BFaXexoZUt1NkvD8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dsX8guntPcy28X9Zblz/rAo+oGgycayuyJAdH2X8nG0803T0I+t5dphzw1lAxxBEQn/bQ8bbbLbxwT8AkW3Ns4ZBQqb7Dc/6oy4Mo2r5RwbvO8E9umnHzIu5pCnJ6o4mPgnQp6VCulC7A9TuKVT93XN4X77N2+Ws968Xvxz0j2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rSkHsvCy; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P63pX22104771
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=yDX1j7r3YKBmMe6Qfm3VU9fdLqwFKt1NwK2lsC+kEgo=; b=rSkHsvCyjjxw
	BNsQ2kAzrZEWRULUh0BybPqMN9smwYqcxpX06fscxWkuEBK/2FaLQyh8t0G6uX4X
	sZ6wxlXGbLUtOetVb2laTQC5Ewwj2BTqSqB39YuZjm9OB25Od2HBGy4MSQ1mDKUX
	2nWmO+J9ZB++3/iUwkz42EHEIu9mmLc85fqI9AQztpbqpH9bMklqoi9FmmHOATUu
	42ON87oaTZybag1Fzj5C5FezeJ3yVcbdThR2tlluGyp7+CStWAx1t3XoimGcdVA1
	zBDa6U5UbEJ0160w2MYm0vaGumebYo9EuwlUhZZcJALYQKKtbHTrXM/jt0hln+n6
	FRLucc+NxA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010023.outbound.protection.outlook.com [52.101.193.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6vrbs-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:23:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R4dSdrejMJMFzkid8F3wWg/0mcVgjOdrUudRzr82bdD8YaTJvvEtUhvAKGRezL9fcM2mZA9s3F1DsbpspMmO2Wot4WJApTiez/s1szIUAIsf7esacLG9NnPtrlANq4l1sQ+TjKZ3JRkNTNOpByyRFlCts04WlQBSBpXvwXCvIK22c+rdFkF2N3lh9vSCO2d/u3j5MQzcoT7dYqAlyljdMPK4O2u+Fl/zxmqaOCJgafuHf51cQnvlOQ66u2ZdBlSw2L/JJel1rdobRofUnhxXO4MUAjax318fDwxgnjf5LLMdCm2FPQsL+doJa7Do97XBbf46sl0uKEPFP+FXWZzDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDX1j7r3YKBmMe6Qfm3VU9fdLqwFKt1NwK2lsC+kEgo=;
 b=KWvmcgV/mLJOfXf3RFFkqBvLb2PODe5kcK/w4iNztkN32hdssNZyaodG4XS/ezycBA81iBITpqgPAI4ln4P2rDQsEaMvkp6uDqekAlsnKZ/KOZ92tdOVrhzxKmYPj6KQe+9MuVeK7FYDFbzbmNayevx/+U5SECUQKfrJ51ph/73esNe0SD+BEUUhCFsYwJfcXkNHbV8+lVPIFI+ezJDRphIIdyrXTkjUCjDfhmR/JGGgQP0nEzKA1ovsphH6oJ9LzedIz7bHa5XDmOt17CmNq/u1tIolM59Tn/k1nfGY4qKQMP5tRHnYhwx8bBTh7L1wqssiLfoS5T33pMn+wAQ/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 09:23:32 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 09:23:32 +0000
From: liyin.zhang.cn@windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: spi-nor: core: avoid odd length/address reads on 8D-8D-8D mode
Date: Wed, 25 Mar 2026 17:23:14 +0800
Message-Id: <20260325092315.956451-2-liyin.zhang.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325092315.956451-1-liyin.zhang.cn@windriver.com>
References: <20260325092315.956451-1-liyin.zhang.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 00020853-480c-4838-1e26-08de8a502ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HmxyNnjFk8ljFIVxxTDdNpt6mGidvzBRZiSG+QloqSGDGP3WTsDvVmUkQG1nafeL66+tWToq1nTZ3Sjk/k+F3VrmL+Efa4YNpIrTK6oK4REukUlKkAohql5Yw0BRCjvZ1h9JY8HK9cgqF/Nklzh3UUe9iLDI3uoNdOi/uz2kDyCsicrv10jhPnbscTSsfJOjhyINfiHGayGFW9ZBTfiaNQssJA1IvqmQM68CQ/Q6f9lgZV6XfBdwQ4OM36c7tpnlduv7mx35/1nR2fScB3tRsel2dp1jBcEyqq8VHlna+3A+r/5Mdn+DcCTIqV8Z0wu5i7A8DkMkEnY06qxZBerzrIvGdTtM7mtaL+AyKITJZmp4ats8GazeRdPV7mreXNI7jQvI2ybPQdO6BfwZTr0zuFWL4X8WKBFYxU02sWv3gzyPVkqpaevgnZqAZBGQn4KV+6DNppW/1fYVvKQwsRoecPPcTnx2vGG/jQ2BWtdQT1mOTYMp8KlVQ0J+TBpijbtcDqB6mBxPvaM4Zjtw4mhfnHBdysdNRMiu5u0JGIb1zH0APb0AMN3TUSLTVb482cMEWqdBQXwbeHADPjU5jgI1PE9Ji6I2HgCY52MYLFegm5n+zCvu29vwV1/YzQH8CsyVQA4jSCMSG68Qzk5Kod5jj0K9djoiIQYbxjxblUsA0qeDiqaI+HUzWqH6OvifM0KHNSwYeyWekrjfCng2J2oc+0tTLGryJ5diEMBCh5Ob+UQkdRDCgjOP3Yc0rpXf9T7SqcN//OaQKp5J/wvbI/PrIQBoF84fwwEMwhNI3bCFXNM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jlE/wEHSyAhoKxm9FT6FwOmYNB/Y0BOO0bZjaBLgfXqv7VZvgmEaqOV6IPQX?=
 =?us-ascii?Q?cNs88pvh+1NpVT/KD8E+KPWhZTO9weOu+yr8xoC+p/yQhB8PbUptErKEHnuQ?=
 =?us-ascii?Q?UD9WH4fSC66paPS/GEY4xgpw012V1Q/I2Myw7CRkRNaxCIj0UiyoH25iZxcO?=
 =?us-ascii?Q?8/uOih21ro1DS3pQocil7ZdLyYlkfSwx5BoIE+TTst6m9d/+Kk2k2wE0tYBU?=
 =?us-ascii?Q?IeeytCwX+FuySRrKeLeXj1tVyNLgTpb72+MHr8brnn0uUGjyPF4luNvw3Iaz?=
 =?us-ascii?Q?HJDJZ0xtVaLNOLrh2kTShO3P+ONFwxL7Ztjwo1IaK0PWAxHIMUMKBUDGpzHI?=
 =?us-ascii?Q?AZsecvHC81Dukr376NFFFasSC16JTi6oXKA+QfW4VQ89q7xz22wEV6QwxFLV?=
 =?us-ascii?Q?n0V+pQzKl9TaYeoWjWf6b21oKmeluQU2imyeFaMI+A1OS/5x9SL4OpxDS/Yu?=
 =?us-ascii?Q?IBVtPOEc2/nTNt+Q0pLCxwFKBA57v3Q6M0IDgEDIm6hTH1ZoA0QJOuOXBoAx?=
 =?us-ascii?Q?PS/xAk+Ir3WT9CX3IpyOocXsZS9gyt8i3qcft/WqKF7RKQmLcasCXcPXV911?=
 =?us-ascii?Q?2ay4ZmspvdPXhU7fF6LnmliSsvVwGYg68GTSU97lUjFmt/Q5DpphXtyQHg97?=
 =?us-ascii?Q?QsZESBfPC9n7p9ShX2LSTgE/cigAdnePqNFgKui7UllSU3KGFa7I5igxk+6D?=
 =?us-ascii?Q?Pa+XbMjETJ832vvnX59aKMyLXAMlTZ008Y7RBe6HK0m7lWwYYrVxD8a6yuNo?=
 =?us-ascii?Q?mG048+v6XSOhQBHhKSJvNl1LaaGp/xfUuxtKstaGoDA+XJfDxQGbx7LGl8Ue?=
 =?us-ascii?Q?X0BDyXsOMAPoN5LmB9FKCjNJpKfFMoZyc3kMNM+IuUV5ZZPApgeiejGVdwdA?=
 =?us-ascii?Q?1rtVb+siZmGfjGKkUujv6/eVYe69zgPK+kCV+by5MKMCAIE5avzLBhj07lbe?=
 =?us-ascii?Q?/4qWakz7MTSkSvTUBV6NIYLawYjaR0p/Ll+B3qI0EyXaieKhmaiTgvRBQ8a5?=
 =?us-ascii?Q?JDzDqvBV5vy0jC0XEJwLanCc6O7Awv5OXnOPaecdRw1G8gUrL2yhit23qhgo?=
 =?us-ascii?Q?JNhVDG1UMRCa0weuqLtZ6aYlDND4TNF8827xIksbt5rqThDo5MeeTTw2gElS?=
 =?us-ascii?Q?n9pYgZ4MG2XNBPW9JR4vJriQ3oAmoT49bWwH7KEu38Jelno0WTyTrpc/Ddcv?=
 =?us-ascii?Q?+paQRpE/BXMTSypA+dwm656CPgbQrkQ81Zuhykrtb8AiPTLwHZewm39n0CFQ?=
 =?us-ascii?Q?nzR5DI+5/zkqV9e6H9uW7KvIlhhwXtuQa/JTf+FvL+I1RX3iwoi4656Q+8yV?=
 =?us-ascii?Q?v4wcchsRsJD4OlKteXiPI3xyvtlvO3jWrY7pKzxIPLBsgNkNXCDdy0/wqOY9?=
 =?us-ascii?Q?JIdYfg6LGram3ERE9FIph+w4xnGJsOep79JBQBirdKnd47IIsX8n9SUTxXYi?=
 =?us-ascii?Q?GEAHJCyqItlCheMXfXm+lI0KXeV4sW/tRRUNmARUQVyJ3f5oUW4p5L06yG3w?=
 =?us-ascii?Q?2EyJ2VYAHPs5TZBQqFTZBbEKQwoc3FSnanwQ+Freb754WXFtv/myo9v8S6AO?=
 =?us-ascii?Q?2bbnpc9ZIZ6TuJS4WKqBa0K2RlpX9m8kKnR0NvqoOS/aqY8rKUCCFkIe2mf5?=
 =?us-ascii?Q?eCn8I4KtEE7Hu2roH9IDDX4f50MrQw7sfitx0Dc3vGM3YTs44TRz4CuSKT3V?=
 =?us-ascii?Q?jUMCOYkR0CtyCcJeitCrhodprlAdTxBaQCdLIUF0vpAPNBvT2nNPzdQi/jz8?=
 =?us-ascii?Q?TayW/kaYx9CWCzuNAiMwPADRJUK5dJc=3D?=
X-Exchange-RoutingPolicyChecked:
	JSQRkhV4GRbIh9lQqHeLk/9o/sU0NofcJvD/mYdB8VROCT6GAhwlnm6r3v2ksyXJiNYTIS2xANQKPWS1XbogrYfo9VEk0/jSOTEsaDnw+z2VM09JeWlepQ69Z5Ue+7Af2S9imkxQ3QvIEgw1SCQy2TzDtNmQWS5Qj1yKZs8LmAces+WtaaqbmYQbwVI6SrbS5KXp2fMhToXtOGo5cfNvH+0xiqTTTBYVlFjhqmOJ5SnZiSGINmHgHGy4tqBhxRSfZVNg7x7FtjxDtw3akit5hH1xXuA924fu8ziCd6UlEa8sTFlblx5MiWNZMn5yzlCYS9Y9WS7YdCxawpTWdHctOg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00020853-480c-4838-1e26-08de8a502ed7
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:23:32.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztCbgW2zMK0BSS/6AaK4BvoEvTukset/CcJ3hUpPx6A29tDvTXAsuxPWkYvSESyy8eg3Km+NkSbHhW4P60n+oTMb8ZldZtSHMoT67DLvof4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2NiBTYWx0ZWRfX5f6jrpZRUieT
 2uJqGFMM2x0PVrGaF0zxr0yKWDKnkFpFGx++Hpo/WgY6WZW7eEuApnx/8cP7OmBNVmtukGi2y2j
 mLd8XpcyzPbncSQth7tVKxamBy1wgRQwz6xMWgVqGa7Ak9VGr7JSajYiGprs59zu+jy7rLMTmPt
 VXCTJ0Wc7dORhkLZDQaaH9cCvLnUBtfVyb6k32vdtNfDf6MS0R3ntEwYvlMNFhbYJ39UNk6ImJn
 nGDpoLYDo07qqg8h64Ucfw0YjgZpSafxcyBm8aqNAZFAarOqNYthUP6RBw0CFnvINzvfMJzlzs6
 iyPJDlH3UA/jtkSy7t+9IkbPUv45SKlGeYE2dHKK9cOTCUmR/V4xTUPYF+qljRO/Xn340M5L/HB
 nzmh9gOjViXKNWZV7s+b6MN7TDFdR8K4ipFl7aJcu3hCPoKi5IucuzpVN5S8P+zHtYjluYo+NYi
 3Abq51618181uFLSuFg==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c3a995 cx=c_pps
 a=ubRrNrA1i3DLWGMHTGxaeQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=8AirrxEcAAAA:8 a=sozttTNsAAAA:8 a=t7CeM3EgAAAA:8 a=Wf9njZRE-XqjpBJJj7AA:9
 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: C-WJu27yPwC62DDH4bBF9WnpxDtbN8l2
X-Proofpoint-GUID: C-WJu27yPwC62DDH4bBF9WnpxDtbN8l2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250066
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230289-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liyin.zhang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,ti.com:email,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F00EB3221C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pratyush Yadav <p.yadav@ti.com>

[ Upstream commit f156b23df6a84efb2f6686156be94d4988568954 ]

On Octal DTR capable flashes like Micron Xcella reads cannot start or
end at an odd address in Octal DTR mode. Extra bytes need to be read at
the start or end to make sure both the start address and length remain
even.

To avoid allocating too much extra memory, thereby putting unnecessary
memory pressure on the system, the temporary buffer containing the extra
padding bytes is capped at PAGE_SIZE bytes. The rest of the 2-byte
aligned part should be read directly in the main buffer.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Link: https://lore.kernel.org/r/20250708091646.292-1-ziniu.wang_1@nxp.com
[ Resolve conflict in drivers/mtd/spi-nor/core.c.
  In spi_nor_read(), 6.1.y contains a spi_nor_convert_addr() call
  before spi_nor_read_data(), introduced by 364995962803 ("mtd:
  spi-nor: Add a ->convert_addr() method"), which does not exist in
  mainline. This call is specific to Xilinx S3AN flashes, which use a
  non-standard address format. In mainline, S3AN flash support was
  removed entirely, and the corresponding spi_nor_convert_addr() call
  was dropped by 9539d12d9f52 ("mtd: spi-nor: get rid of non-power-of-2
  page size handling"). Keep the existing spi_nor_convert_addr() call
  and insert the new spi_nor_octal_dtr_read() branch after it. ]
Signed-off-by: Liyin Zhang <liyin.zhang.cn@windriver.com>
---
 drivers/mtd/spi-nor/core.c | 76 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a9000b0ebe69..2939ffbaad2b 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1677,6 +1677,76 @@ static const struct flash_info *spi_nor_detect(struct spi_nor *nor)
 	return info;
 }
 
+/*
+ * On Octal DTR capable flashes, reads cannot start or end at an odd
+ * address in Octal DTR mode. Extra bytes need to be read at the start
+ * or end to make sure both the start address and length remain even.
+ */
+static int spi_nor_octal_dtr_read(struct spi_nor *nor, loff_t from, size_t len,
+				  u_char *buf)
+{
+	u_char *tmp_buf;
+	size_t tmp_len;
+	loff_t start, end;
+	int ret, bytes_read;
+
+	if (IS_ALIGNED(from, 2) && IS_ALIGNED(len, 2))
+		return spi_nor_read_data(nor, from, len, buf);
+	else if (IS_ALIGNED(from, 2) && len > PAGE_SIZE)
+		return spi_nor_read_data(nor, from, round_down(len, PAGE_SIZE),
+					 buf);
+
+	tmp_buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!tmp_buf)
+		return -ENOMEM;
+
+	start = round_down(from, 2);
+	end = round_up(from + len, 2);
+
+	/*
+	 * Avoid allocating too much memory. The requested read length might be
+	 * quite large. Allocating a buffer just as large (slightly bigger, in
+	 * fact) would put unnecessary memory pressure on the system.
+	 *
+	 * For example if the read is from 3 to 1M, then this will read from 2
+	 * to 4098. The reads from 4098 to 1M will then not need a temporary
+	 * buffer so they can proceed as normal.
+	 */
+	tmp_len = min_t(size_t, end - start, PAGE_SIZE);
+
+	ret = spi_nor_read_data(nor, start, tmp_len, tmp_buf);
+	if (ret == 0) {
+		ret = -EIO;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * More bytes are read than actually requested, but that number can't be
+	 * reported to the calling function or it will confuse its calculations.
+	 * Calculate how many of the _requested_ bytes were read.
+	 */
+	bytes_read = ret;
+
+	if (from != start)
+		ret -= from - start;
+
+	/*
+	 * Only account for extra bytes at the end if they were actually read.
+	 * For example, if the total length was truncated because of temporary
+	 * buffer size limit then the adjustment for the extra bytes at the end
+	 * is not needed.
+	 */
+	if (start + bytes_read == end)
+		ret -= end - (from + len);
+
+	memcpy(buf, tmp_buf + (from - start), ret);
+out:
+	kfree(tmp_buf);
+	return ret;
+}
+
 static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 			size_t *retlen, u_char *buf)
 {
@@ -1694,7 +1764,11 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 
 		addr = spi_nor_convert_addr(nor, addr);
 
-		ret = spi_nor_read_data(nor, addr, len, buf);
+		if (nor->read_proto == SNOR_PROTO_8_8_8_DTR)
+			ret = spi_nor_octal_dtr_read(nor, addr, len, buf);
+		else
+			ret = spi_nor_read_data(nor, addr, len, buf);
+
 		if (ret == 0) {
 			/* We shouldn't see 0-length reads */
 			ret = -EIO;
-- 
2.34.1


