Return-Path: <stable+bounces-93521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDC9CDE57
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A6CB22907
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 12:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395591BD00A;
	Fri, 15 Nov 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GutEOMx6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gw1PDfXA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0BF1BC9E6;
	Fri, 15 Nov 2024 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674259; cv=fail; b=utPnSyZR60i8NdeGx0q94aH6pmnVCf1gV3F7/EA9mtel7LCOGJ/RnPVpDg+ICahxdjTKiY0QkqDq4ACpFHWUlmyt3L0MgFxILTcG0NVaL33fAXpkwM57zQ/B9Hu2BZOEWb/4Jjhv9jEAcss9/27q8jGE4mbzd2/k2wy96N5DJgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674259; c=relaxed/simple;
	bh=PwJOnIwrgbk/R3MCXw3oz9MB6l+a9N1JKHv6iKh+Mgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKZL7zaoJm5F+0uz6NgkBi6MV++qQxkSDag73RbuswTWPGwPtLhn/5oD0GmOHObnzWbL5gyOaa+zndq8VdK1TOkvSiOy1gBVhwVgzCalE+Ss78G2pLqCe5pvkzko598dQ3qAvMzt2NmlLr+p0KWN9/m25q+h9sVeAg5jzL0wckc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GutEOMx6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gw1PDfXA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAH4VP030282;
	Fri, 15 Nov 2024 12:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0YO6r84z6d4rGgD1e8mQW4WUPkS0navErPTnR081+LE=; b=
	GutEOMx6MiSjMMA8ufsOVfF9BfPzNWusbZrMb/+3dF19/UrbEWV72tGoNfAGlzV4
	QcMONCgpXzpEBipFjNO0y80sax/JxtJ1c1Bpu5s22ACH0fQTtp78RpXrxZmdgi0s
	huvhyC8a2rrzvHO8S/reAyU8e7wfYOggFrueQvzdf0HS1nh5uFbriu28dFxFWas/
	cfi3jtx/Ll0N54mPRjt5hAvi0tDuuvaXpZ3dEHVCEUS1LR4f9b400t14I/pwulEU
	+gWsXht2JxTb5d9yjji/zI8fZtsDpPHDDmZ3nxiPWf5NdxBULCiE9vQWhHgdMIec
	f47IGbPoFw4J8rBkGmI+Gg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n539t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAVLFM000376;
	Fri, 15 Nov 2024 12:37:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbpbjcxt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 12:37:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oV83LeQve76m8QAG/X8OqOiBRb8FJLeOuYXKq4JcMfNgDJtPXlf7CENWaXxZYK9a5fd2v9vyuoLlRR0CR5N+np8mQvjjKe2P1y4cz1Rdph6BVZya21KNQM7wP1Y4AkcEsW/x8Vi2pse/vtooZDpNETZd53cTg4hRkKQ0X51wmmBSpDsfRSvF8VbvXQQHElHfVnaewYcKQKMx0EZWIkiNi6I+a+4V8xwERj4iSGYBbmKwhz+ubjtw9JvSVV1lnli/BbOxH2EzcD9eQLkhi3GCVcGOVoQnirKrA0McpL/VRjfVILtpQCof23rQ/Zbk6DkAlvWOeVYohU/eHl6Wq6/Z9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YO6r84z6d4rGgD1e8mQW4WUPkS0navErPTnR081+LE=;
 b=KZ6f1+AUGGlbM4FL5slrDDEcsVbq5eDYyfTz77AGlGyVQf+yPs5Wsm/2JzT7gRyRnBpj7MdJbYw6sxgYaDcDeNA99SXACIVgvq1tmY/ZowjJps0ajWzVlRzpy5sf633xs7sgTVq5nmqO+njoYGJMvtA3Qhv01s1NAVh6JIam5liq5Iai8rhPjsEAxJGCnuJ9WycOM2anmm3XPxmtBRkFzWNIhfMg20/LcWKZiieLdzF4UnGZdURziQABo+jKreEgPRuL30RYO9E4L2waOxyW4P8J/V6riboaWlCQn0YnzOYaIY8ejaZH8YTn8P+RtUFkSRfsCR/Mh3aRSHC8FVywdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YO6r84z6d4rGgD1e8mQW4WUPkS0navErPTnR081+LE=;
 b=Gw1PDfXAa5WVCgPjLJ70KiTvE3FOn2WyIDCvoZcZuuIuv5ZU0MwHYuOg/F0hBJCo1uD2WWgTsNYiAKDIGb8ntwzBF6/HfAZPuNLUNU2WndZE68DWWcEuG2t0b+mMcgDZU8CqAHfpHpXSvafj5gPjXYnCEjdbZ1diRGQDYV6YeT4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA6PR10MB8136.namprd10.prod.outlook.com (2603:10b6:806:438::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 12:37:07 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 12:37:07 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: stable@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 5.10.y 2/4] mm: unconditionally close VMAs on error
Date: Fri, 15 Nov 2024 12:36:52 +0000
Message-ID: <a0a4cde203f9b3b4fa42577e43ca2679ae63b8f1.1731670097.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
References: <cover.1731670097.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0450.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::30) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA6PR10MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 779c2df2-6419-4dde-1372-08dd057237aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Wa/Pjh+MfjDfwQUMMLyVsHbUhLz1pOUhXQbgVN+SSqMREUJloiSRwkqCN/B?=
 =?us-ascii?Q?JzAAM3ctpIZsPSbw6ws1MAGqC5tXbV/DdUKFQ22t5bYcjcRWJzveva7EUrLA?=
 =?us-ascii?Q?WMj3Q3qjquSrR+4hCz2Oj7TYVdX6wEffF6dtsI+IN8ciA1ZjVozsZTndQYrv?=
 =?us-ascii?Q?D58gNmtXYXuyKPqxucsmQMExiwM2jG9/uSJabrH+NKIYc8LP6m2o7M5nJI7y?=
 =?us-ascii?Q?dxRJo5mv07hFF3ltDZTPo+1dggunW8ypKv32W7j9GLiSsKgtH+hdf0xQmxSy?=
 =?us-ascii?Q?g+9e6leDc15MuDzZPx4/rpO1lSqvW9HmSL4qkjwbbrw8oclgaYXRNxnzFXIx?=
 =?us-ascii?Q?/ttMIBHTFI71glff1COqeOwyUGA9wBooFZsVwjr4+hwor5bpnh6HTQ4oaRma?=
 =?us-ascii?Q?EK7IcctPaMPPif0j9Lb++kjFshu2vqCcpf+vl86pIs8I88YrEmBBibOZ/NHL?=
 =?us-ascii?Q?bwwdVB0MK6fqzAPTMFFnfrdBWycc6edbQjKN3vfXUWssGd6NjCySQlgLxnGb?=
 =?us-ascii?Q?9TpIuuKoJNp7PLOTCBdwCt/RNXMIxMeORZuoZwUgXcmlrWE0FC2AKTwzlt4n?=
 =?us-ascii?Q?l58fvUFlUkdSJ4MjHTr2IFIez/mD+XGgl02XroNOVSCgY+tfW+4iTp6PA5/n?=
 =?us-ascii?Q?1wQm+lPZdxXEbo2/+k2LXsLD565CK/8YY1eZsB23ZdyPK9uevVrCPvL6QDt5?=
 =?us-ascii?Q?ETmAWYcI/Nr1C7P/rMSp1VD7XroFTy7704lzsWZv9PX74f5vX4QP60IbRf6X?=
 =?us-ascii?Q?ktNQOh7hcTjoM4kYmH5VF4SzSfeH8iTxrXB9+5by3JloVOLpuiTq5+4V/NKC?=
 =?us-ascii?Q?79AowvZj4UKtwMcZOB7tDz9FudtlmnG8ButZ2g+A81s+JggWefyoEzuuFO5J?=
 =?us-ascii?Q?mHmVY+v3WQF+iXY+yf/83uGqiz4OfTpSUHFP0kshFFTBG/a+/Cjb/FWKtNOY?=
 =?us-ascii?Q?bunsu5n1s6DoXoHU+HZb+dvJnOLxKHRLs8eOeGV99lD7891lTOjW/Y7Y3Bzz?=
 =?us-ascii?Q?NdKw5G3/K28bOW1umen6eoE9WrEvKH+YOlpBkFe2wrJoy3QK+ez0kko8uLJ+?=
 =?us-ascii?Q?DhCA/31Pa8/he4fC23PWw6FZ/V3jFmTvEMxAdKiiHvPWKb66eiJI1jim7Ns1?=
 =?us-ascii?Q?23Z7Gfv5hDwF4RGz3Sz8wTZTM8RAWTf8b4l9lvrpOTeAF79GCF5B9M5e3k9E?=
 =?us-ascii?Q?kMr87gEdopLIbmGto85tnWJS/whqXXcZnBgv9shlqMGtZKGy6Nxu+uoO35Bh?=
 =?us-ascii?Q?lGMHplc/V5Zx7/zAST+O9OH39zb5EELrrbBLB+hmilkB8FOCWP1BSj5i0ifo?=
 =?us-ascii?Q?47JqLyqZHyQWNsfCg1YS2Bg4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OkMk3R2T1ciZYzP7MRyZrra1fwbNAxZOS/TsABQyxgApC0F8v7MvQ2YC9Bmv?=
 =?us-ascii?Q?EPerRDuahe6h/hLJtnxv3I/eykC6OPDFEORQcOrrIi5MfEtI2Ujt5ESA2Msw?=
 =?us-ascii?Q?uhw0oUmhE+SHtJARiBFg6L0dv1tV9iw1672uldjcgMJwEfMLPoD1TPenWQFZ?=
 =?us-ascii?Q?CNdavcV/xyZx1qINjrwKrOpeIg+4V98fjbLqnelgtm0Rctk14d+9oHe9w+n2?=
 =?us-ascii?Q?7mIUUpThm2ZF7uyVD5K5KnnrQOFGcZFC7Wb80F4WikkTE/Fv52SC0lDRk0wm?=
 =?us-ascii?Q?obbWl8tgprsRu2qzo85EwkJgdwKcujUyvlax2BIfAQdEQf1V7eCyNV8OQHf2?=
 =?us-ascii?Q?Y5//Fc+0OPLH+PRZ4T/i95E4Lh7ZMHQDq2ekirYl6M1tPwkOapTS8Zcl6EiQ?=
 =?us-ascii?Q?OiZR9TEe4mA8EIf0QThGm5uZrEXWTbHMnBhnJhzeWCML4Fbh7iXtZuE6d4o8?=
 =?us-ascii?Q?F/i888Pfr8kWAhbGFgUGdmxAxdSkxV5hamnnzCwifyAFUlL5SvyVHjp4jHN1?=
 =?us-ascii?Q?f3XxdbRa8UCg31u7IVVBxgAEkDDzWenK4ETTVjrsldf2BmnjX6fQiq7RV5bw?=
 =?us-ascii?Q?Ik3A/A09RmrFyPQdIK/CM+oWalMx7r6FnGipOwCm/zPHCoMFMvfdxwm91dkx?=
 =?us-ascii?Q?0n+jqwr1GQT4J6J0fa7A2ka3FDMxk5W1NI0hXeLle67vbIfllQrrcUdBjDKr?=
 =?us-ascii?Q?0euJW4Cy1vIMd7EuH+WMeJn8EgFYyT+NwpayW+YLGoa3zFTsu4S7/2BaEk7y?=
 =?us-ascii?Q?+0gW3RTMiaP1wky6GxFMaYgeshLAWQ4yT4TAd05haVb8e8zBDo9Dn8bfQIru?=
 =?us-ascii?Q?9MvRuJgPJ6DHqTzCBJK3KRf7SZ60MXg8ybMFAEuIB0Lb0dB3XlpKTtEo2K+O?=
 =?us-ascii?Q?y7l28VNen5toVuc5Sb9YsyHY7JyG3t5uiSr1kN4a7GIfpHEY2yoVBik8pbWl?=
 =?us-ascii?Q?LgEa9fa86WQhOADplkYYtkBa485nsHTiD4lLp9C8uKaQmUxQ/QOVjhxwXIFH?=
 =?us-ascii?Q?ZNjR5czdemnnunrZ8K3GXEbYJdEdhVPwg56X5AZUrJG6NGDGZWl3gZFqT4J0?=
 =?us-ascii?Q?3x8EvjfjylYsAP2GlNEkJGni0SaGp3wJ1uEPVbEzDIAdXBux2dg5S+3YpgI8?=
 =?us-ascii?Q?9s5PHlglo3j2dTXA/kMegjZWtOm1xk8ZHHq49uENn6lHUOtu8viO7OlJhc6Q?=
 =?us-ascii?Q?BOd5ahoMIEYitcp3koMgb7Ae3ii96jCo3OmDFdjIpze1AJgWx8OY4LiewD2g?=
 =?us-ascii?Q?2HtuAgv2PBisI/agy8K5BjB7+8U7QZvPvqEYFykvhu/q8/4yP1+86Snkhx0d?=
 =?us-ascii?Q?bARqOxnfCy7xsjBufjVmUpMk7hFNqdU1LHtZJunMlodX5adGD0jSet1IJrt5?=
 =?us-ascii?Q?MCI2nd5BOPSOm8hH+gPCn+G06V7SRDpQTrygJvwe34EeWmv5WoWsT7qZNaqh?=
 =?us-ascii?Q?FoKccbyQexHLLa62uo2MpirHlIpjTK/Fb/xhiuTJjwgXcNx8zhTO0fFa3Wgr?=
 =?us-ascii?Q?eqQ/siIBPO1EQXtgsI2Ljib3ZsgotPuwx4Wiqyag0LG2cOLZbLLgFxs1Z/KK?=
 =?us-ascii?Q?BTslsErcKiD7JOHOOf3iK4JVWIJIdDn43/naNVuhzqgDbis9tsvQfwX168ua?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ogS0zrO7RWzStu6SGHNdXfKIXJto3uPVBzujEK7pPuKCMR6K9qL1nmzSGlARWGy4xAVYELnQ+5inZ59aHP2fRmhl4my2xFVE8r63ZoZfv1ythU9+CJxEL0+qEkgya4MHQyYb5sI4oIyMaA+yjWwYGw6lQmiUbbCCULn7L5hxNoxakd/fn+cQQPRhynSuYVfynQtglWH0YDjN/ppALJECs4D+zoyg1cU69TdNuv03aYEix+XQZtqPIXawxUp+hJXlhMNPqpG3BGYHRUguA9gZNqh3PT+WF8lxlrcKyDIRwk+ak1MGVnciKyYCOeDds2qJz457w7RlvciTU3Qu1OgKpN6alDyH3KccusnRst+skpswRZsNA+Ns5aZpyHXBepUQ01hJBIqr5D/fVZUTgoi5/0cenwW+ozZ5gRwJ7eo8DzdlrP2xMekMqtazDAtSGUrciOhBD1npcOM6KvqIZfMEkKp5UZ0/ZN6pd6YC766WnhHv2lFVPa1gjSNEZUlXSnI3DpA2IRxCIeIaGnEFALta4Kd2s7MrKRXpqqix1f9LqSITtB3hS4del9jaJwHhMu3oqo9IdDxw2z1L8lS0O+uf6hrFjlEIB4yZlq/U3hMYZ0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 779c2df2-6419-4dde-1372-08dd057237aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:37:07.7142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bA3sNcqbSpzyFa67M1I6eC/KDnN72Ds6ansCWnXMejIEbj7Xatk6Cof7ey1UxHNwX6wTFu6ROatf714V4242tOF1FbS/dvWcHGYSfY+eLbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8136
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150108
X-Proofpoint-ORIG-GUID: 8N0rPsEK10oZH9mlXBsUAiJLJpU5ohVg
X-Proofpoint-GUID: 8N0rPsEK10oZH9mlXBsUAiJLJpU5ohVg

[ Upstream commit 4080ef1579b2413435413988d14ac8c68e4d42c8 ]

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Link: https://lkml.kernel.org/r/28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  7 +++++++
 mm/mmap.c     |  9 +++------
 mm/nommu.c    |  3 +--
 mm/util.c     | 15 +++++++++++++++
 4 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index e47f112a63d3..df2b1156ef65 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -46,6 +46,13 @@ void page_writeback_init(void);
  */
 int mmap_file(struct file *file, struct vm_area_struct *vma);
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+void vma_close(struct vm_area_struct *vma);
+
 vm_fault_t do_swap_page(struct vm_fault *vmf);
 
 void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
diff --git a/mm/mmap.c b/mm/mmap.c
index f4eac5a95d64..ac1517a96066 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -176,8 +176,7 @@ static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 	struct vm_area_struct *next = vma->vm_next;
 
 	might_sleep();
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -1901,8 +1900,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 unmap_and_free_vma:
 	vma->vm_file = NULL;
 	fput(file);
@@ -2788,8 +2786,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 		return 0;
 
 	/* Clean everything up if vma_adjust failed. */
-	if (new->vm_ops && new->vm_ops->close)
-		new->vm_ops->close(new);
+	vma_close(new);
 	if (new->vm_file)
 		fput(new->vm_file);
 	unlink_anon_vmas(new);
diff --git a/mm/nommu.c b/mm/nommu.c
index fdacc3d119c3..f46a883e93e4 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -662,8 +662,7 @@ static void delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/util.c b/mm/util.c
index 8e5bd2c9f4b4..9e0c86555adf 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1091,3 +1091,18 @@ int mmap_file(struct file *file, struct vm_area_struct *vma)
 
 	return err;
 }
+
+void vma_close(struct vm_area_struct *vma)
+{
+	static const struct vm_operations_struct dummy_vm_ops = {};
+
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &dummy_vm_ops;
+	}
+}
-- 
2.47.0


