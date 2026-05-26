Return-Path: <stable+bounces-254233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLJIG2j/FGqpSAcAu9opvQ
	(envelope-from <stable+bounces-254233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:03:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA065CFA8E
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A07B8302C160
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 01:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063B2D73AE;
	Tue, 26 May 2026 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="SXlwCmCd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9D32C21F1
	for <stable@vger.kernel.org>; Tue, 26 May 2026 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779760724; cv=fail; b=mcDmQAznUn4C5e2OLJtzHTA9sTDH0NCthWySXoETCm6Ht8xl8oyh+ryLWkCIPp+aF2lERQqRv9vWMCrlfMo2o805VI07volShQSFD5GT/DkNinJfUSK0DP6+otvbfdgAL9KbJ7E24dKh962aqGJKllSHDfLQZQIEqzElNVZTIXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779760724; c=relaxed/simple;
	bh=5bwV/3BRCWvV8TOcz2ByxH9Hjtpf1MIZCw4Iz2cp8pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HxwxLRuzEOHatYAWojWOcLUdwg2ajBUMi3ZUZS8XylwM0/EaoAVPz+g+er4QnqevdbfXMgL6lmv3LVqiqPpUX0k8CBDBzfcNHmX8q3U+JTvYjfzmiS6z5HJrQDvdP6eIXvhMeI4RBOfGeLi+Nm+eKJMwOck7L18AqD/ULIQ2EdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=SXlwCmCd; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q1k0B13688769;
	Mon, 25 May 2026 18:58:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=fDkFfwX4mzUAy2RPCPpL7J6zyh++RjQkGWOyqGaER90=; b=
	SXlwCmCdqYfcSe5SnBwHrlyVdu1fi6MzOY1gN/Q2r6ESnLC4eSjDOCX05b6+AuEB
	NQQCKSeqjQ0w5azHwR1Uopbxeb0Piha1THChz2kE0kO8Wogwk7F3sTEYGNU5BXpF
	PXCIww+m/k9hzPnj7/tn7WhJv/ENYph2FgzuWVEDNyj2kPUViqd/xYIMAJOhzlaB
	SaL0EzbivDW5PLDMeg8zBCYR261GLGBwF/OU4eY3s+tPvP9RVsVXA3EWfwo2z+WA
	wmrlrxjbihUIGQIYUuIbBigkkIo5WjeDwwtwQ42T9alABcEDERmCrBxbKyelnGh4
	iJmxQoJBy7RaNKZyZlNfew==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eb7h1u267-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 25 May 2026 18:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Otn+kJ1+XM+Icp1XJVcoyN6fgvgIk3TjsQsYV03IsJVAtoKsDqGoBl1AEj0BJs9ReWnnzVNgVUoqhpLHKmodfusu5ABaV5pbWQ/JmKb/Uwm52etdDwv5ePcDfXOdh1zgF1GX5jJs7W9r88uQ6qMgwRAi0DTw65EUEWiwlmWNa/BtYS/CHMZLm16Ebtom8OPZXCiuTWX1zQA5NaZtr0nvxYaoHZ2hyeJAqPH096wGasYoMc61Cs7PxNzDB3eLEz7dpMKelRf2uD/4J0v8j0Zu/ZsxWqBfv76Dud796i2KI740UZn/LXWu6sdWwPCgW+SDcyKzmSxiWy7FFgdU9PGaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDkFfwX4mzUAy2RPCPpL7J6zyh++RjQkGWOyqGaER90=;
 b=c4NVT8rYmkcPhaLRSTVHR7B0Gi2/5RuKwSez2zpnS/Zhx7pGQI9gML5VD4s7v3CqHAVj1LehY2nWJZSbzmBGTOrdgnBkXKdhsK083vSod/Xn9GOel1CtTDfyE3gARxuGzC56M9CsWnIOsNWwinl7YThJDyG4xNekgA2tEG9qnjLZjkVUvnLglRNV3Rko3BnSIwZwIHRkESo46L01HcKJ72aJT03bex3jgVdNdg3rnq1V3bhWbo2bMQzDF7NsricckGu5Yag41VeBoXraa4tgXqRNc7gwjdDIxBLg7PkF5I5YP72GMElcNLkhpSm69/3WYQCnc5l6jVBRaR7CLLG5HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH7PR11MB6498.namprd11.prod.outlook.com (2603:10b6:510:1f1::21)
 by SA1PR11MB5801.namprd11.prod.outlook.com (2603:10b6:806:23d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Tue, 26 May
 2026 01:58:28 +0000
Received: from PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::492d:f133:b4c3:f94e]) by PH7PR11MB6498.namprd11.prod.outlook.com
 ([fe80::492d:f133:b4c3:f94e%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:58:28 +0000
From: Jiping Ma <jiping.ma2@windriver.com>
To: sashal@kernel.org
Cc: michael.bommarito@gmail.com, stable@vger.kernel.org,
        stfrench@microsoft.com
Subject: [PATCH 5.15.y] smb: client: validate the whole DACL before rewriting it in cifsacl
Date: Tue, 26 May 2026 01:58:22 +0000
Message-ID: <20260526015822.4076817-1-jiping.ma2@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425003718.2642374-1-sashal@kernel.org>
References: <20260425003718.2642374-1-sashal@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To PH7PR11MB6498.namprd11.prod.outlook.com
 (2603:10b6:510:1f1::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6498:EE_|SA1PR11MB5801:EE_
X-MS-Office365-Filtering-Correlation-Id: a6a567d5-595f-47ab-bd06-08debaca47bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|56012099003|11063799006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	ljDpx3jlkmkgb6QPimTU4tIhLz6CQS/km90YUpOmJvx1W6rInkyMRODUSklMaF37AFycJI9r4oK+nFk2lcWe6BJ+4GuYqyv7jIyMwf4uQA6nWeOn58JHnBjxThhhDhQ/cDOi5g563qQn6lWdzV2bpzNzD8kawX7cGD1XFimhktVojB0SNsFjzTSuDltRlOVVGhnL2pFi+h8afbOdCp62v+5ePSyeIZPHe+5EYRrZOy/3DFSBeu/UED+dpQIdNyhNDlyu+I6z0Y5pXq7U5vtjVAhyvNgYhZcP/Kc7Vul4hQaHMArxoPV/iajBra7nTiRFci1BElD9TiT/aVOIUNByO/Vu3zSzkBWBSznXLyVnYhJw6oGumvY0MhTqJ5qahi+PxW/A7GgRVjIzEOz09ux31HpTTUIQo2OyZKqgekLT9wmwq9AwifLgINXWbEvxpAorEofGWlXh1jIVM7KyEibFIpylo47hn8aZo/ZLbFddl3P2NNI8yVH5A8rABtk0yrd+r5UEtf/I6m3EK3D+bvRDxeWChAc0B6iZRhVQqxLiQIG5IxBdYLSJdqaMn+nKjiafffEi3EN6x93oTM5liGU8d055yGP4Imr6H653lnQSuSziFkBt6gwYzMjc+IMnZeafZGYksWyj8CkWwtVEPUN+GyHH6e4qVHHgaGaoJ/HZaJVx8w8sEksYSK0lR1HkUtgiV3pTvbfKDDef+Ikp5a/YWCLpK7PjAjoaHkT9Kgl3L0AH2LnATq115u8+9sqyxmzM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(56012099003)(11063799006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LU7Hoz/SzdhzXCdG+EIBUWGhYu3y/rTm+QTwRMUnc47ihww7yxym9bunBYzr?=
 =?us-ascii?Q?xhTLyqAWxsfwr2zzhrEmRPCH5HrPSjkM+XlIJYg869u5S+TGDl0wFRtp77x1?=
 =?us-ascii?Q?6Q/Yr9MgHsMnxmCe9aUmxksQjTAIdEO3aeb22f0xOlYFD0ZVsfB+kfPNRt5f?=
 =?us-ascii?Q?9qyM/d+Os+i8uNnH5NevVWnjvM/0VUp5+/+nzYPSaCWCVlzdf97A51uh7qRu?=
 =?us-ascii?Q?DBO9C7k8Vfmiwu9GV172p8WfzuIDXT/bSOT7mg0Zx4AKSSnNhb4NMCt/XAqy?=
 =?us-ascii?Q?Xaj8V44GzPBao1yO2kMAo4ZKj2zoGKsP8KeEUyphyEtpvpbD2K5vsVm+hUim?=
 =?us-ascii?Q?JyvpIMbRfJvTaUdwqKOrDDNvJhttPwOgltOGhFqbK+sflHGNcJjQdY27G7Nz?=
 =?us-ascii?Q?KwrsQuYw0Fto5NeljUCkhVFxBnt3SttcRBXe8+ZbJ2nlXlPaGpoKUzp07VcD?=
 =?us-ascii?Q?rrqJX6glauPqU8jYbnpzr41EoSytJe3Q1hNzmaqH5Pfv7o+cdy8DOThCSt/S?=
 =?us-ascii?Q?eAPVHNKKE0Ru1R7ynpJ72WGdDNVa99NxixXq3wPult9qrrWsFqNEjkdq4mxl?=
 =?us-ascii?Q?v0JmKtcYQWGCz/mL7kLgXHK1qFMj2yZn+N3Lg5nGc4E1Z1PAgsarF5kaPv3w?=
 =?us-ascii?Q?ipLiPmwvQZBy1mab7+Bo0vUOaFiGbKyJKuP9zdzM8JhKUHGnERtZwzhPwSrt?=
 =?us-ascii?Q?wT80pPUY/3dQbtfgoVIsxsVtpWQTzUU9kmY0nuckAJqgZ7EVG0ySvtSZGzuf?=
 =?us-ascii?Q?/bbTqAFjEVd+qQb90tEhJxs9y9VnUzw+mGci2BSG9ysiJ5zuENMdP7LaTSFt?=
 =?us-ascii?Q?76zE5MtRsbG0MUrd4aOVP/P9rFTocqNeSA6kqhEGXlnvFlOvp6ioaDK+Fgya?=
 =?us-ascii?Q?L58ITdg7O8ZMRlp7cvvLOTfvPjplu2gQZMyo/aUJi5NpPTIi5XhA40WMyy4h?=
 =?us-ascii?Q?iQqrPXqbJ+iCZTE+WFEKB97aCsKBo+7gL/VbuBgvabefCrCrXNPvF2g//4J0?=
 =?us-ascii?Q?JPW8QEkeZJqS86eIzMxP0a8+IVBBNFmINW9W4/6lL0Jx2cY04oHer2x3cTgM?=
 =?us-ascii?Q?gTzqnWqNgJPch3oo0sxb4uYieR7ltR1wsvJUXRTy2ShulcXeZ5haHanuc0/V?=
 =?us-ascii?Q?1CUo2LNaYOY6dHxi06iKFZoZ9iTiZPRjqw0LnT1vNtizqWp+TQDqN4E+VX9r?=
 =?us-ascii?Q?ds9R33+OxjiY/ThInG32awff8l97SPVn2E+p+6Vk4lVJFvUDmnyeegizTY92?=
 =?us-ascii?Q?I9XRh/A4c3xLtALZI1/I2sMe15qaih/1OC73JxcQLe94kig8tgiBNxWeTlZl?=
 =?us-ascii?Q?SqiunXphQZP2waN7geNuaMMqApwB9qXvzRFoe/gYaM0J/B/JOrTavkd0sKxD?=
 =?us-ascii?Q?+w+lF+7C8ZVtCSre6H88WGvjgoeXKD3CUgNa+v08xR1O3PYazV4A7OsHE97/?=
 =?us-ascii?Q?UAIK1X0hZ/pgNwbnC5LoFGrz8EyrctfvPbXRdAlqasGR4npENBNAcZUFBCLC?=
 =?us-ascii?Q?lnyNe7ItWdcLolTj+YP+1y5yL4AC2DwiNCFr3nt/2X8MV336kx3QUz06fDku?=
 =?us-ascii?Q?zUDMqiUV4DCFEfBChAidRJN7cqRnaZQG/5GRojIDHn84FpXB+uDjmfaShx+u?=
 =?us-ascii?Q?2gc0In4giLDjzJ02/Qhi6j3sfmyh+3zRhjstfRLLRAtuTjrf7zrSwoaGC7vc?=
 =?us-ascii?Q?4hxG7cPqUVlIRfmfDp1IiL/pPvNzO/+tjQHpZWON21VflHD86dgOOWx9zEsA?=
 =?us-ascii?Q?WvHhYV+DIA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	Cp0gWRDMptb1jdCqW6PV9i81DjPbhwwfpM6DT47n71h4l8PQmFVWv0FYW3YBV8qPHl8+QZgUE4Cq3ikMzIrKBDjAb5S4LwzXN7yygroGGfLQSzkfxlctv3TiK1R/f/CHJwVhCdx5aK2xVqT9Io1r52th0aubLHF5obte+jmca353C1O2OVUtPPAYT0lPz8a7EfWFTnPsMXWKofA2DkHwsOg/LSjAaOUE0XicNDfdKWte8OkAnDKuaCh/kFW7Qr3eap+qg4rHy/S48FERJhFxzyRDn3cM6P0OabeySG0IR4NineXO9bWs3RpmDmrBSGXykukAak0M1PxEi/L82i6TEQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6a567d5-595f-47ab-bd06-08debaca47bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:58:28.5387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOBBty5HyxsEDMRP3HYeMLCBCwtBOqw0Cg31zijfgX6MIrDVBw4n0ouBZdrY9yslkxAqzSBUOGFtVP4c/Nkp/TIjT2v/tFcjtfHCGXd2gQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5801
X-Proofpoint-GUID: 6laf6QQV_ixU6B5IGjw0WMKuPz2HRtKC
X-Proofpoint-ORIG-GUID: 6laf6QQV_ixU6B5IGjw0WMKuPz2HRtKC
X-Authority-Analysis: v=2.4 cv=OuB/DS/t c=1 sm=1 tr=0 ts=6a14fe46 cx=c_pps
 a=wCl41NmqrnDcz9wBTMCcbg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=avIV8m7szhv8wqwrJqcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDAxNiBTYWx0ZWRfX+7q3rmsJ88XU
 +1uTGM/QQhSJ/rtMS/Vlm5LKnKqF/oTEFAsQHmN3vF7VR65K1tx05onqtwmssIqV2Zktw4xOxnb
 Pf0GfJVLO4NcQ1B1hukP3lqvXmPooELpTKJwUBYtCpWugggYMVqIYu51jxs9JbtQSgBd2lancrR
 20V7DmnZZtHYueAs2ULQMd7D4weSzzyFigPGzTFL1njW7rSniUuksVV9XTrt5AOxSbXWi7L8v2m
 oGmIomp+iT7PFnXlSzgaM4PYeVm/bjrNXl7JIsT+tCzbGQytUbVr8Kap24eaI25CvsIC9aVG29w
 ZoBE9G4awMndRPBSDF/G7L6QODxAmSxGnnRlZdLAIfDTe7GyR7YmkITyKpGoW9PNbd/hVpqvszy
 DelNowjrdVaoNvSUt15ktBvQQ0Vo7uWJUgsdKC+7sUcbzUaixeINzqcejscyceyBL8Ub2VE7FE/
 VqTI8KN2L2hZNxtCo9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_07,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260016
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,microsoft.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254233-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiping.ma2@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,windriver.com:mid,windriver.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CEA065CFA8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, 

I can not find this patch in queue-5.15 and queue-6.1 of https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git,
Do you know what happened to this patch for Linux 5.15 and Linux 6.1?

Thanks,
Jiping

