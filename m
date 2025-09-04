Return-Path: <stable+bounces-177710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C52B0B4370E
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 11:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82AC31C26874
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191F2F2900;
	Thu,  4 Sep 2025 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="l0VJ39Ey";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="OCcl5gB+"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142A2F3604;
	Thu,  4 Sep 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977996; cv=fail; b=UFkPhFOImAGi5CwDlseRC/7loRaGPPp+qweFNy5nwiIr9l6UsXvgcB0ZSopuwAfqU+ytlZCefbAtPe9RaiprND+piELNqil4tsc5guXPOY2HTBGVVytqqpZmiOWEkQMd2dhKhxTxSqQjBlICpJFc37TlDQUp5wOpCKzyj3/cW9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977996; c=relaxed/simple;
	bh=1uy6sqXz90q15HBwQ6Y/Z+tGgokrrfnq8Vk8FtSK05Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CY37VfmlpbE8E3Fx3ghC9Q1sZe4xOYvo/Hexu+ggjCEkXQsnD2pJBv3waKPSyesaAZ2RFepllCi6WjPaCxnrSXSUez/wR37SbzfN1l+NdQHymn/QE+My5Hn0yHl/2ue0eTvwBxh2pEqiAdsO+astEs5q+csEe4olg8TyeNm6yPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=l0VJ39Ey; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=OCcl5gB+; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5847qeH01987260;
	Thu, 4 Sep 2025 04:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=P62Fbg/VRLUZq2nzBZ
	v5leVJNG/Xj9TkHPkm4rupYmU=; b=l0VJ39EyKhVRRUupoHmQohjVApstjeB7Cc
	c1ff3kIpmeZwz53vwYmbg9aoVxY4Z8kVDQAPgy4YTFxZQ8slDVGKX2wN1/NK0yEX
	YQowmfM+6d3C9ytmylXz//KotqzDsGDNL7YFA3HvywxkBbNdcsr9OXxM7bBok1Qd
	f1AWG1UxeAOO8KWLtyOqYuk6VfL3KQh4Eb3JGyLPUVHYXFaTFYcoyQEzcczSsybP
	08mtybWn6S+K1VRPW1sR8VjnWn9IU3nV15eCGA3SGCvqvx9uY5hT4/sTfPIS+h6L
	KEwNtToyDq3dQHnaRm/r8rS7mzOSkccI/SXMMHYFqYALkAOHCbCw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2243.outbound.protection.outlook.com [52.100.156.243])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 48vensdx17-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 04:26:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmTRZqXKnHMA3l0Z7iT1LLoz8aBhkMW6tyGnrtPRyoNfiZwWVwIfVlEPCTLtkpGRdc0Oh3tD+DnlxaOFPb2rZW/jCZeYHUcP88YA3EgzaTxybW7V34Q9vBlJDfGIRX2pU9rYnF1ysR9cKyXGwmTlXpoUMWUfZFqOJaP9HMcUFB+8/EQYyN0NuF6brcFR5vL5MCq2n22ZR/pjAvwPs/OlOAkJSZRdphW1qkxNCDN4flQiRBEgiS62AdgVrGuNmzcxzt3/wcGSm0LEwoAqJq8BFH9c5G0IBzEhAoDkBE8YMSJbA2UwNsmYmXlJiHir/YwUFgglrUK35NE1kGoDK7kDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P62Fbg/VRLUZq2nzBZv5leVJNG/Xj9TkHPkm4rupYmU=;
 b=Wxd+H+cChwA1uS6PXEUOj6GhjsXGTmprrM+Jq+UqiPMr+IIs2IeHENwvbqy18VynwdZChHx/YHHzrdCpGYQNrNgzMf9/WUgxBQJGdyveO6ntwhx9nsn4/5B6aG12e826eri/36JPPjBoUg9Bg/bMkBPXnldhexj6ukev2mEyIVIczq+sPERKfKx6/TRZny3/KDpS+12JlLHZnW47X4npgwJCsiYnMxdity+iF+b9RzJxyqx9jbuIVNGB0NS3C32Hn/mKX2LWKqxuB156j7SdL/0UOmLN8Wkc/39TvMRHGU15hbPNe9N9qszHo4LkPheqyr3Dkr2jOKV1FRdb2wDQUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P62Fbg/VRLUZq2nzBZv5leVJNG/Xj9TkHPkm4rupYmU=;
 b=OCcl5gB+CLWQ8hQYxUSc5qZPjkWO5CfJCVso3YZnwI5cyYQbkQa7eu+eVLQcMaCDiXEsDMYju2jIGHZjYS7bW2dJ3Js9rv/C92JWZMAzF9N54NTPlc/0vQRFu2Pd1LE0IhswLyYyIRkmp3lgHhDgeeCz56flfL56C7mp2twLaLE=
Received: from CH0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:610:11a::13)
 by PH8PR19MB6764.namprd19.prod.outlook.com (2603:10b6:510:1cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 09:26:14 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::27) by CH0PR03CA0351.outlook.office365.com
 (2603:10b6:610:11a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 09:26:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Thu, 4 Sep 2025 09:26:14 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 25BDE406540;
	Thu,  4 Sep 2025 09:26:13 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 07DA5820247;
	Thu,  4 Sep 2025 09:26:13 +0000 (UTC)
Date: Thu, 4 Sep 2025 10:26:11 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, patches@opensource.cirrus.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: SDCA: Add quirk for incorrect function types
 for 3 systems
Message-ID: <aLlbMxIGrtwa4uoT@opensource.cirrus.com>
References: <20250901151518.3197941-1-mstrozek@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901151518.3197941-1-mstrozek@opensource.cirrus.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|PH8PR19MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e209a7-d23b-475e-b07f-08ddeb95181f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|82310400026|34020700016|36860700013|13003099007|12100799063;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yHC3UGC/rPQc4dM6rO/M3tKgtIFJLi7qqsD1bynvlK2BUgQkRaeqjPYwguaw?=
 =?us-ascii?Q?2lmJeBPkRCgcDAZygwkcYygjd1oimW6Gmixs62onChHQOUEGINluIALrxO0a?=
 =?us-ascii?Q?FmdV1XH5hFlhRBvkivIcTEEEkwoV7il9nJbt+AzY6Jp3gwlQaCFFcv/rz5ke?=
 =?us-ascii?Q?AGN0aIqsY4QFR0JiLm7//LxR6O+EWAmvBixI71+rtFv0eGFlkr9idLdO2SeZ?=
 =?us-ascii?Q?Fn2rwgFJUaP1NKQaaDliqjjdnPQOY4sED0tj3SRGKh2PBlot7QMQPU4EfM5P?=
 =?us-ascii?Q?40QOxALD8qG93Uge6rwVtttUwU4kt0Q0ketPiOoiMhhF3+EglO+oAMr4/qtB?=
 =?us-ascii?Q?Z2fttIzRxY9k+hpSLsHT+5Bjc/w9ng3R5qmJeMkN+xUG+uAil5wJ3pds65iD?=
 =?us-ascii?Q?V3VbldFMj6i5n7GYRGrJPuu76hFJMXZV023GTv/LW/PriUJxx2FQDN4OkQie?=
 =?us-ascii?Q?HSaPfJpW+oSScnoAPCATC+2+Ce2q3y3CNyuuMGxZsgYlamNqsPlFJgCfQlhF?=
 =?us-ascii?Q?VmX/J+S+riBfULedBwONhG6dhB6guDHyrNAvYWb00Rf25zlmOVIU9eBbXrYI?=
 =?us-ascii?Q?FSpMg+wPavO4i7jlV2IOVlaV7BDVRriK3tSWJOsQJeuEaM6FMXUEYzP9DidB?=
 =?us-ascii?Q?2iaXQex1Exp0mtMDuUM/ssK7L7jfvP2VcNa4e2NSk6+d94TGJvgfNtYi88/6?=
 =?us-ascii?Q?C14MkYnWEFUIGAK4JjWZodP7koK2dChikPeG8cTr11nGgKBvOzHHchF714xs?=
 =?us-ascii?Q?ZuK+lqirV5Fle6K3Q2cDAPBYJRUPjjjw9azE2OkqZTLK9Z+1dyEMq9B2UDDu?=
 =?us-ascii?Q?wS8DazcVDy8kKa7JPX9wslNe7q/5tWGkZ+raqo/PQNCARDlQHcGGDbGEGVMO?=
 =?us-ascii?Q?+muQB6Eg8imAEVy9D5o5DhZGCR5Iu6YO+u+RJ6jpcxeKrNUBfK+7n164Kprc?=
 =?us-ascii?Q?XDtiaRPEGWdV//O0Isw44FwIB1PZn6MeWatPashr+88hRCriQa2YK6zFZ3ur?=
 =?us-ascii?Q?jhg9vIWDIHwmkA+9FScvgQ5AWdFetagCQAAx3G2oRjpKCOl5OlF9hmnITo7D?=
 =?us-ascii?Q?SCG3ZhLND+Qu5jhk1ADBzVbyBHEle44tTkKvQWBhiKLcScd4L5jDsGb4rEN/?=
 =?us-ascii?Q?BZbxA55FrL8yBk1xMKcIQs+/RtBNx+OchqoT30FczxFkaK6VyR5hSJHtYlDz?=
 =?us-ascii?Q?RIgzQiiQtQhe8X/exlwu3YNU/DCdYycq3KVc4eSaDAxIM4/DlEUCDLLZIMfb?=
 =?us-ascii?Q?Sr7pM+XrxEaBoDXptYH2NMWkGF6NB4C/iFttucP+IclJPO804EkvpLSAWY0i?=
 =?us-ascii?Q?PIctvGzijohw/FYZsfe2wTwb4kl2ZSWEWQhnfV6NAVOBBBpYJKCW60+Am8Yj?=
 =?us-ascii?Q?fKZ+NuPo7GCja+8t+23oGQFuPgbXqQWsfndktHGAOhkOsWxtXOAspyAcxhkw?=
 =?us-ascii?Q?hqD1yeGJUwN1U4b9XWG5R7lSVGEo6Oef+bcVESW6KH4G6bqpbzciRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(82310400026)(34020700016)(36860700013)(13003099007)(12100799063);DIR:OUT;SFP:1501;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 09:26:14.1552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e209a7-d23b-475e-b07f-08ddeb95181f
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6764
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDA5MiBTYWx0ZWRfXxMwY8FeVblja
 xf6Bs4y1iupNaQ7D5rXihswPH4j16CXYzNgyy0rxUgmrC32zzNz0KP44LPxMy+sieKGaTJYa4AV
 1mu6Lu6rfmCmGewdhrAbIt9NhxU8NkoKqxckxx3i/3K38I/Gsk7hPjOJp7D1jN0VMawIyJ4+PbT
 MNhfh1dqfmH/YjlrJ/oxuWj7iGLy1T4jHa8uQkUgnhDmtEV/fWF2y/zal/hNCdPWZz5WkFPTeRV
 SRzGQ4CrCwAEqf7SU4WRx2KPM3IMYlyzED/RCNAwh6MN10K+PkQZlT0tu0ok38S5F6aEXoYILpo
 Tc3l+MLmFNLsZsdeAiV/16XZS7QdnXBx3RSsSQ8C//OLP324Dt3xqLSciybdco=
X-Authority-Analysis: v=2.4 cv=BY/Y0qt2 c=1 sm=1 tr=0 ts=68b95b3b cx=c_pps
 a=laPecl6sZCz36GXbUkJg+w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=V3ELVHPMIu9roCqhGxwA:9
 a=CjuIK1q_8ugA:10 a=jZz-an6Pvt0H8_Yc_ROU:22
X-Proofpoint-GUID: Aisc9RhNbC6m8vKGJWm8LMhOGR5RSOLm
X-Proofpoint-ORIG-GUID: Aisc9RhNbC6m8vKGJWm8LMhOGR5RSOLm
X-Proofpoint-Spam-Reason: safe

On Mon, Sep 01, 2025 at 04:15:07PM +0100, Maciej Strozek wrote:
> Certain systems have CS42L43 DisCo that claims to conform to version 0.6.28
> but uses the function types from the 1.0 spec. Add a quirk as a workaround.
> 
> Closes: https://github.com/thesofproject/linux/issues/5515
> Cc: stable@vger.kernel.org
> Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

