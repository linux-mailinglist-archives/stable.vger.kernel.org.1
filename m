Return-Path: <stable+bounces-237712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGGfMke33WlRiAkAu9opvQ
	(envelope-from <stable+bounces-237712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:40:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9603F54DE
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 05:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0F733013682
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 03:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009802BEFF6;
	Tue, 14 Apr 2026 03:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Dz+eVvwJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319B3883F;
	Tue, 14 Apr 2026 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776137937; cv=fail; b=RASWt+1SXc19lKOeyPM+SHPtNG5ezJinb/N85aK0G655rLSqMJjigRjD9wZEtdkuomujoepz63TT65FvibjoBgzy+ranB3dK9FnZWsIQ7I9boZSOAjHxmkqyNBqx+IBhUGTFZkeVX9+CMJ3evuSZ3MsxJyR2p/xWsAweXVDFOUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776137937; c=relaxed/simple;
	bh=6n9ADFzz5P0RsEx2E5CL4XYxBP/UEcEP90iLTXhePY8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KV3Q6s+DMOdBEIwbXJKXc6petAdxiOfVgpBrMCYg1xMYvzB/qXktyZNo82fml6fX1M391Tnt9n5lXxHZKZKs8e8JboPAtO+9o2OnFDUeiGta7YFTZyBD+Bxwo93qL2j5WePi9Dr6ADO8VlNqKHVgCjQQb1bDb8DVXuGztj0uedE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Dz+eVvwJ; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E1U2tC3723448;
	Mon, 13 Apr 2026 20:20:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=9YRiMffHo
	51Nt0aFTBN6Sqm9U+t5t3yTvvR+etIAEL8=; b=Dz+eVvwJ8WHm0EJdDKHLQZkXZ
	h+3ebC3B7QjiZMD7tepPg53GLNV1bQvF7e+L0rR+oiM/8pch4WX1wpSOjduAOtk3
	FzDbPZFSoQwE78EmUdLU8VI0pscDeIGPd82r2vT+mrOtdLzU1NFPJs1h3vaeJ3B1
	K5BT9sUAaeG/HVENIKQ0oy6RapeEPgDzwuODef5tvsiXIIt/bBYB7JqHbAVUMGwd
	w7ztgl0ysNmB9uTLoOBg0MevizTReB1OfM5jm9V8idoBttWYEcGMzVNgGogiyOuK
	IpXRdalNnvPMKP2wWr/Rtv4Wk015h54ay1CzObAAH+hibkyk+D4J04ng5z+kw==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dh86m87tv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 20:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMKTmzdqbS2o0aIQ2zmF5I7kSjAWCRRYMTC6JC5TTjdf/uKk131vmJUJYvPOn+Z5NiytoqdOKB8oBG+O4wsBLHp+XJhy2WLqjTy1mBsUlMus6vbe5RiDtwOPKXWhR4GOltdxIhkgW0bgcTh0z93mXrDqqyoG21Si12lt1cipxXvJORoV/gP8g+07v5MohRu4sw3IzCahqp9K+zKBLmOzIsyCYgQsRALv/R/SDngIXUH8YAkhdzr75wvy8KhhSjUQ3yrxRVYOYzBg/yG9hAw/zHy8e9XyOI/XK7Jt5LruppcEsVhDpLhblvO+njQejulSJOwhILcAQIisjNabH7AL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YRiMffHo51Nt0aFTBN6Sqm9U+t5t3yTvvR+etIAEL8=;
 b=ZHHTf+P0sGRlMP+jggSpO886SL6CDEvr1Ju/zbucybmW3kbj/Hv+AFDID0zox9AI1TY+uQU94CkbsidNkp2veYVStaba6KNsnAJpjLFo7joA5pesADAy3L83490ANzyWe0S9gjxAX7YFu5WdoA3olk9NcO5YwXe7yVg1522lMePpGBNXp8r1Mn4I7IDW+01F+zhRnMWygNP/o97SrTh0i8OM3NzrDy9XWRzzHeNisrlFneAWCt75j1c4N67SqHr5UQkNBksfie/v1+gWZyg7FCzhbz+Fn2/b6LldEn2pR+sDOW5mLcnPJHXrq7Dr5HzDXxkA/jWSyfqll8zDy2kaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5586.namprd11.prod.outlook.com (2603:10b6:5:35d::21)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 03:20:29 +0000
Received: from CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6]) by CO6PR11MB5586.namprd11.prod.outlook.com
 ([fe80::89ea:ecfa:c345:3fc6%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 03:20:28 +0000
From: guocai.he.cn@windriver.com
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org, johannes.berg@intel.com, netdev@vger.kernel.org,
        regressions@lists.linux.dev, miriam.rachel.korenblit@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] Revert "wifi: cfg80211: stop NAN and P2P in cfg80211_leave"
Date: Tue, 14 Apr 2026 11:20:06 +0800
Message-Id: <20260414032006.2887625-1-guocai.he.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::16)
 To PH0PR11MB5593.namprd11.prod.outlook.com (2603:10b6:510:e0::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5586:EE_|CY5PR11MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: df152830-9934-48fe-6208-08de99d4c6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nmVxMSp0MTaGwhKb3J74vte6Mb8fZ4OL53jqVAHPyAo8Qnr3KHgEUqVpj4UwjHAVqV/ZVJkdmrLCRljSWkHO9mPHMTyAdtMkpJ1VEwHQ1Y7HY0UxUeGurDraReh6LtkCS73viDLlLo/e03JaA5/Yz1F5Ldy+ewlZRQtI2ZlZgRDl4FdXy5ULekaVazgHwjfPPJ1ww5h6n+eiGUUSm9M6TKJC9vTFQU6xbvoFlajtzrvF5nii4lYoOKPtIL/YMeI52nQKkIcN8Cw3pWL5wTNl1ibni7ofX8ltGQrnLVtKD8wT1v6jggbE/Mtm3XF/RGOw3GpHm+Ysy+EROXvIvrEN0bI6mKIm+rBc19yAA53VcC/T9BoUWrrFwAx9ZwM6Mxwx/+r7Hbi2a9XkM6TThLbBjVYZbjy2nWFH17LMeBxclixrNi5JG3rrO1kE/5Rq5RbOOzQiZGUOxQT5j8FHaPbRpKNkPGnkcXahKaEnQtYyMZ1cntpwF7VTzpMbgBRdRCbSyzvtno4yHqZRLUNfCPBSbXfWUgTFrUTSaxdMIDMU+GAIpmBFAwIgcMkNK9ylbU5LepD++kX2pjN1CqPXBjZmucLotOFMFP/ACAVrgHBatg5a6XM2gz+REoC35sF9Ms7ig4m6JPFSzKgM+nbZiMmwO5xCehQNwvc9HwIJ2hEYIo+KjX6ywi8PWeTiMW7BFY7tHLya5KJy+SSAM7odN4afzZZ5OJ7bLpWySQbKyCg5+TfL1b9gG0tw+efgu6xde4paDRDzz3lrHn8GxJw0fCqUt3NKFHHtOziZ19Teyui3KLA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RDpSRUnPvFB3acu/B1lL2SrjKpVnOI/GGUUVbF/Nun1pkWAb4vGida06bVaw?=
 =?us-ascii?Q?0ZV1QF2lbwRSLZr+du0DpbL3Ug3/CWDSCvblrxC+PR7bAlxLG39oYTJYwn6J?=
 =?us-ascii?Q?FssMBiZrKXe0ZNNK4BnX6IYVObFSRpGGUKFYoZz+uBsRu4uQDcgB0lOhs8FU?=
 =?us-ascii?Q?WroHj1Xjs9lZLCQmdz7pXvqw5UT5kuVUt1H+QQmOQ6XF6gYdjDu4TibkxspM?=
 =?us-ascii?Q?+hZdMNuU7gSNmV2JzhKTZXkFjlKAKdtj/TuyBfQO0RPiPgMo6SD7lGkn3s+6?=
 =?us-ascii?Q?MVB92lkKo0CWncqhflIz3Y2EBWSyU4Ye519cUuW3Lwvaf52SE6d2bSGCswqW?=
 =?us-ascii?Q?5rKlrdQZgA43kCJi4qZ3t6Y64ksKr0JU7KGd8Lv5kLqQIIOtsrRK5PAVMErY?=
 =?us-ascii?Q?i5uERZlmPyuoJduyDcVzzg3RVfV84GqLkHBRp8fgaHns450F5Rsp3+V3LbFy?=
 =?us-ascii?Q?/Ozr8lVEaplggMWUsaJ+f1V5SL8S2WXLoCGuJ37kFSUuJ29LwDZ4G4eDY54a?=
 =?us-ascii?Q?RUMLIy9IqLMhRiHBrUuahpu2ipMclm/fdyseWZh+zPn2qb/W1Kpy8GRuAitm?=
 =?us-ascii?Q?nbuHoH2M+pv0oo/uiwmuqhDcyfdoZiIKOCP6be+wF0IOYsyGhqSZvHahS+cG?=
 =?us-ascii?Q?gj7agsAf2eY/rfHVGA2fSvcxUyIIZIPLZth6rJhocABGGNw0aPt5gUOUG7hf?=
 =?us-ascii?Q?ZHobJhX49UJy/aOIWNKuuYLrZHoxncGbXXfZOa+4dnMeZsGLRcUoxqViFh7w?=
 =?us-ascii?Q?pavZBkoEu2MbDwqSE0FmmKtLKMX/02XMAo5I+HHoSjhE+wEjSsTksPPa9u9E?=
 =?us-ascii?Q?YRexsCFEVpmspHxXRhTuRRWDTsaEqQD+AfMrtkPTaTJD5MWgBzjXn7UlOZWn?=
 =?us-ascii?Q?gT5omTeM6C9reqbh+8K+qzxsvNlO1benk0TYj5qogD0kHaCJaJh9ss2qDH/j?=
 =?us-ascii?Q?QehEeomiZd+ltA3qND1T39/U2T+1oWss/lPllWInHhcBN1Fb//iN6/Y6NynG?=
 =?us-ascii?Q?YJ2ytgj3X3FdFlViAnDu86A8OUxo42tGpuiJ9bh3rH8DQF6EJTzIJSgRiGg7?=
 =?us-ascii?Q?Xv8Xe5KRhxyXRIX0/YXk1O0jq+C39IjDinBMd01icr/li7Z7P2LA09T4wrfG?=
 =?us-ascii?Q?NiP7kVKqOHU4G0CYVbKuKe2tWNd2l1dvR4WfNe0Y19P+NjfTabBVL0PwBuxn?=
 =?us-ascii?Q?TlozpZNa3kWI1MqeJCH+pAntwVgPakmCbeGHCGv2fPguWV19siTcvXTByXas?=
 =?us-ascii?Q?g3P2Y8u9qJnBEhe7cwVajHcdP4D780PAts2ForFH+eAJIlOSNLvWQUSoxWpc?=
 =?us-ascii?Q?UH5YQ8WbMKvDXAZTLLKGhlaoYHkIglSS8x+wngyTPaoqMETAQtreaRiwRuqT?=
 =?us-ascii?Q?ENYCjjesGWvf/kmEKoMgABI0NUVEw8aSMvYH/UA2sBWrQItea8SdEyBxGbyv?=
 =?us-ascii?Q?DJVLodpUeOvoLOR9EftaLKZh+tv3rfsq9LbNa44Q4T978TbrJoILFH0kuHvl?=
 =?us-ascii?Q?q1WYhTMIPAdTU4mPElQJR3gJ+1rnz7bnkGZ3JbG+UsA9lY66nygRZ9U2MREY?=
 =?us-ascii?Q?67XeAk0B8cuE1DQpAkj4sGm8tIhHTJZki34qb9sVbNpBhT4o5vrO8mEgh4gR?=
 =?us-ascii?Q?q3bhFid5vTODzyTnfNKAeQkBx8IVHqAbztBBwhTw9bfoPwY/XbzuNYOMu7iT?=
 =?us-ascii?Q?gu84ca02V44nQM1o1PVo4ZVznUv0ulH1R2Nh3E8UZFTpIhJtCtoaQut2MSNy?=
 =?us-ascii?Q?8JUeT1nQ7xhnVXxZ8vHfIyUwAEac3rA=3D?=
X-Exchange-RoutingPolicyChecked:
	g+AbT9Df//GTDDdKjxAmP4VeIb7agxI4p+xpAsfNTioUnIwdO/Ely0mC7Cm59S3fsOie8Kn31fDlBIVg5AdQEXp5dWwIcQM/8kDstuMBIP5w5vjcnLn5teEm+aOiqSPm3xSI3PgJBFKvOYtftTHvbybqDwPyy01bWJDwWH3JbERjF8lVnP780h5Bw1o11tAO7v3fISR4KWZm39Mm0I9l1Ff3FflKnQGNAnafjlxlJgVBr6RQXjaYgr7Cv0W7rI8P89KPqehe6UBS5HMnYUhsryMgt/ZxAuBy9yh9Hp615C3BtD40LGLjy0Nydon4mBekg+lfiT1mRvO2Lq3k3BhNsA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df152830-9934-48fe-6208-08de99d4c6b6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 03:20:28.8871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgT+SdMqCbWJRPDX4xgv1Lhyig4VHot9StiO2TDOH4VYNN9NlCWN8CfLxWV4qAORcdiRgmHljgVhdETZ1z6LHeDBmiXBGA9WDsgu+GkP47A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
X-Authority-Analysis: v=2.4 cv=Q5riJY2a c=1 sm=1 tr=0 ts=69ddb280 cx=c_pps
 a=qO1H+kaF9sbjJIkK6g+tnw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=y-J10uEhvVOKljhdnB8A:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Ibap8DFinM-IFRAjtYxxEqDqLo0YUrWn
X-Proofpoint-ORIG-GUID: Ibap8DFinM-IFRAjtYxxEqDqLo0YUrWn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAyOSBTYWx0ZWRfXzWxV6KAHBU36
 7TOXRINdpz9bawWooiFXAiQORdVDNAoNKei928uNl2jhsAcQtfovSqFyJh5KhJrcLDMPKpldiQx
 qryNc/ErZOPJd3rJmGc2UN9qYbplQdjtbOR7iT82eWM1ohQH7AdA65E+TRiw2zmaYBcGl9ayy0+
 FOCCC3rG0Ms6NvQvNpE8dKSr+Fl0NiGD3YuKayigpXIKJQb5pU2mVFhNIdEbDMtZJTcFirDRL2F
 MEEczM3cnc1QcOXWiKPjrHRPMzvvzxW6EFejqQhMgNnSC0zq7JGWpDahfloGxKNLSxmXVyQsYYx
 odz/n+DJ2BQzQpLgzpjE20ytK10gNy+9iUYSzP5lDcPlJXQMi82WKqRkyFso1l7UqSnPHxzDNLK
 8TV3gmS0AVkLE+UiHQIj3e7uNLYXKjD8/OMZby6/b8d0ap2As1fHpvm/v03pJOvVOzi9cUOYdwD
 Qv8uA34hX7bcLHw33tQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140029
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,windriver.com:dkim,windriver.com:email,windriver.com:mid];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_FROM(0.00)[bounces-237712-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guocai.he.cn@windriver.com,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3C9603F54DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guocai He <guocai.he.cn@windriver.com>

This reverts commit 31344ffecd7a34335ce2b52e8c205bce3cbfca4b which is commit
e1696c8bd0056bc1a5f7766f58ac333adc203e8a upstream.

The reverted patch introduced a deadlock. The locking situation in mainline is
totally different, so it is incorrect to directly backport the commit from mainline.

Signed-off-by: Guocai He <guocai.he.cn@windriver.com>
---
 net/wireless/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 22e6fd12f201..58b91e9647c2 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1300,10 +1300,8 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 		__cfg80211_leave_ocb(rdev, dev);
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
-		cfg80211_stop_p2p_device(rdev, wdev);
-		break;
 	case NL80211_IFTYPE_NAN:
-		cfg80211_stop_nan(rdev, wdev);
+		/* cannot happen, has no netdev */
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
-- 
2.34.1


