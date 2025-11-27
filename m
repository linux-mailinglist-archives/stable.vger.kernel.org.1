Return-Path: <stable+bounces-197116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED70C8EB60
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59A4B34A896
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8EB3321B4;
	Thu, 27 Nov 2025 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="G+mPzyJ3";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="TgEKRbfx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E81F12F8
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252646; cv=fail; b=GuMooo/Er+qpgvRErRNmEQFnwvMj4TyahyccPZ0KV77hCwIVutIPgVDPCcAM2jDpArlceAMnMP4f40lYwqoWSszR2wCTyR7s8PR4I8IlfBp3UhAldzWnsnNw9CDEboLAhR2hVOaO6zHzpXn+LjKRlTGag0+lKbUKflD8JpMQanc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252646; c=relaxed/simple;
	bh=BsG4XqwuB3a+5emx8suwy9UjhBRCIDAAIY5aoL0ys+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/fNoAljTa+Qyzp29VnYLDv9AoC1wEdgkUwXQb1owAF78WF4/DQlsTzjU4jQ66Hz4lLfsxhtxUSvUyjOjSWVyxJJqW0GYPO/hyFxpCD12qhiAxxZDdNAmKJDPeFA9Oh/1hq5NYZXLns+Ogy9Fkrkv63MzCvZSGm1bboJc72PDus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=G+mPzyJ3; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=TgEKRbfx; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR6JArR211443;
	Thu, 27 Nov 2025 08:10:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=vlBsr//fWGpHGUHxxYNTW333qI273QwLl/YUVGHxOc8=; b=
	G+mPzyJ3FjSo7ZoPjkZ5H/lNgKfL1mNckEdmOvPPsZ47z7MAGzbyQayvdL+UNXBy
	T1LC5M45Fr96sCv1PX4FK2kmmIKfdHyooPrS7SR8beas3TjDxv7FATs4X9ziRJsI
	4ZXta3s0g7lp2BbqR9iCI87Yg0qoGxIDiM5s5FVi4jDhWZzFCTVj3lr4SmyX7D7W
	xE/riPp1ErQyX/8FtlzMxjyZG7NLECBOQjYp00xjX9+7v8UnL8ox30Nvqpyz9aVM
	gTvbIPQfXJ/3fzd5ETbcV4sK4Itc9fHU9dfsjT9JPJoQHMA+FpltuFzWCE+wxwS7
	AIF4fCYIzWQ4OS3W79M9lA==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021122.outbound.protection.outlook.com [52.101.52.122])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4anjw5j8uw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Nov 2025 08:10:41 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K82n2A9DSAd6+g9hCtCERYMxhkTYKB6MzXGTa9uDu3nay0Tmi8+mlxQZxjcApH6zGMmu9rvmHgC99cKC2kKvORSimaCJd1m5Y1ew5q/VT61RZ39B0Sm4G111ggJARdi8L9th/Fm9CP7LpqubOUU8GV3iZRvu2qnIy6QQbdZpZkwuiYG+OY3OdtM4/y3csIzrpM8g4UcLOVZsF0JEUt8ZxNPtDzbcgWkSwK2JXMWYhfmZKobkNqbnXIVRtazCD7V7Y6xOGoEDgkr9EcJK2DJlQ0eswOF2T0yISLNy7kWHpkP476lG4GjQxRln9dt1X4fG5iSbzFkvhEwIUWhULgXFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlBsr//fWGpHGUHxxYNTW333qI273QwLl/YUVGHxOc8=;
 b=TjK2CwRvtr+lMSxT8+wBUAx87BSnWGCYYbv4uHZDI4Wzq741Gw/In/Wei2K6kUM25VYAjy1uYmSCqkVjvKViX47e56VxUlTo0PVjY17jJBsdVzx6WXJAttlOeHJ4oc/wXK174M+ldFCZwWsUCmtS36H9SPrsz8qtc+wHWjnMXCgOx2oTRcofHCTYazr7zHR+zikY/EFzMwpmLFgGZ8VTTCq/1N/Z49Gs3Z5k1Mw2Pu/Mq52hrbMPCcK2qX/2aCEe9R9/TQWDbq0ocYl2F7UBlzWhn7Y2XXetk+bodaUztFHCVynVkl89urNSg+AV2PVPMgiPo6B1qZ9APYhANJlWNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlBsr//fWGpHGUHxxYNTW333qI273QwLl/YUVGHxOc8=;
 b=TgEKRbfxcw9bKX2Ad9nHuagGy0F9SJSVBistvlPMWMV0jP4VRuhgAEStVIg4bCvuIIRW9RivIAD1lonONKcSnPn+BlMJfoNsqI4t5RhQlbwF4L5p15yTDRWPYCv4Tmip+prpJs0l05agoT2WW9hPzh2X7MqgxP3+1ClU77d0Jmg=
Received: from PH7P220CA0101.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::17)
 by LV0PR19MB9360.namprd19.prod.outlook.com (2603:10b6:408:328::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 14:10:37 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::8b) by PH7P220CA0101.outlook.office365.com
 (2603:10b6:510:32d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.14 via Frontend Transport; Thu,
 27 Nov 2025 14:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.7
 via Frontend Transport; Thu, 27 Nov 2025 14:10:35 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 6704F406541;
	Thu, 27 Nov 2025 14:10:33 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 50AB482024D;
	Thu, 27 Nov 2025 14:10:33 +0000 (UTC)
Date: Thu, 27 Nov 2025 14:10:32 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, stable@vger.kernel.org,
        linus.walleij@linaro.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] Revert "gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup"
Message-ID: <aShb2K1brBmQtioZ@opensource.cirrus.com>
References: <20251125102924.3612459-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfoycdnEFXU3yDUp4eJwDfkChNhXDQ-aoyoBcLxw_tmpQ@mail.gmail.com>
 <2025112531-glance-majorette-40b0@gregkh>
 <aSWXcml8rkX99MEy@opensource.cirrus.com>
 <2025112505-unlovable-crease-cfe2@gregkh>
 <aSWl95gPfnaaq1gR@opensource.cirrus.com>
 <2025112757-squash-hesitant-d8d6@gregkh>
 <aShagMFXfpIYyJPO@opensource.cirrus.com>
 <2025112721-suggest-truth-bfb4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025112721-suggest-truth-bfb4@gregkh>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|LV0PR19MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: e23103b4-db80-4ea5-59a3-08de2dbebbef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|61400799027|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SW5IeXNhTnk3Wi9iUnllL1pPS0tGVDY5NVNNWWxvWWpIL1VYUk84a1l3S0I5?=
 =?utf-8?B?L3VmTUdzL3pSVXovR0lmd1FUWmg0R3Y1NUtJazZ6blFTYlYvTkF0SmY4SmYv?=
 =?utf-8?B?MGV3RzZpQVJ4ckIwWnEvTVJvbUFGdUFlQ3c3ZmtIRmZjaXRlQUVpYzlxc25p?=
 =?utf-8?B?Q3FHRFovL2Zja0hWSU5wc0pJbUlQSXNQbGREM3BBU3R1aHlUQ01PNFp3SGxm?=
 =?utf-8?B?b1F5Q3hQRlo1Nnk5Qm4yTDNsL3UrUnV1aVBEWGxlNjhjbFlYTTVVd09KL2cx?=
 =?utf-8?B?NUY5NE5UOE02Szl2c3RpUWRSaFN2L1JRcndZMDFqLzgvbHlpaFA1SVJHMzMz?=
 =?utf-8?B?aytPYmxobXVnU0NYZzJHZXZlUUh0dXloK2VlQ0pzV0dNdjc4a3lRUFRJOXov?=
 =?utf-8?B?d2hYR0NoaWFOaWFwZkFaZXZRTXFod0txUDZ1cENvMnhrSURrN3JDUzhOT3hY?=
 =?utf-8?B?UGpLSjRZMmp4b0c1RlpVRHlLVlBGdWxxZ2VCL0RaeGVlVmx6L1JZOC9takZk?=
 =?utf-8?B?VElVMk9Udys1UlJQNHZ0MzU4TXc1bzBjS3VneUMrTU8vczhPdzhWbUNzbVdF?=
 =?utf-8?B?QUNOMXZSalEwM2VQWlNLd2RuNTNnVERTemkvUmRSajJXVTBQdmNHNFhFZ0Yx?=
 =?utf-8?B?Nkg1Q1VzamcrV3VsMXNaazJlZm92d05NQ29ISWdBNHR2c0xtTzJmSElCcGNr?=
 =?utf-8?B?Ym5uMG9HNklWUmdELzVZLzlvRmhUSHQyL2V5QVh0Yysvb2M4Tzh0QkxaLzEr?=
 =?utf-8?B?elNkU1dMTVpUQXlxOEYvSndEb1BWOHg4ZlB1WGpaVXNQdXN0SlZhMi9HVHlS?=
 =?utf-8?B?elRiNlNJVmMrWTc2Y0RDbzZjdHFKSlFQNU1FOEhrRmJzVGpFUWdlRjhkMjdt?=
 =?utf-8?B?MHN4UVl5NkFVTC9TVW51UjZveUlNYlMrcTczRFZjZFZrVi8waUVSYTVINk1D?=
 =?utf-8?B?RjVYdXJ2V1BBTjlMRWNTeGxLMVVXTkVvT2Z0TEc5ZUJEdVNzSDBoNWdNWkhW?=
 =?utf-8?B?LzA5RzFQRllsWmlzc3VVaXpESW1VZjRTcGowZGExQlhwcVRGSCtseE1JT25K?=
 =?utf-8?B?QlhFd1hocStGb2xmeDU2LzBFVHBISXkxb1JVYnRqbitRM2duNkdYUHEwaEFL?=
 =?utf-8?B?UG4xREFIek01NVNiKzAyQ1ZNNTJZZmRlVStscjBkUlZ2c2JyV2Jtb2ozS2VE?=
 =?utf-8?B?QWRPN0NleDl1TWdDKzBRQXZRdlpGZUxYY1IvUkFxd2FDQVlWU3EzWGNibFBV?=
 =?utf-8?B?V3ZHWjdqekVGSDNzRnlpY3Z0aitkNHVSdzRIQXVLaU5mYVJsRytqU09QQXAw?=
 =?utf-8?B?c2g3bE1SUFJScnFULzZ1MHBnZFZtTEVZQnBGaTV4b2UvSGFQd2VBbHlNbWRm?=
 =?utf-8?B?anNHQ2FQajV2WjhWNlp2K09JNjVrTm53UjJ4VnhLY29xS1ZkcVlXRXdOZ3BR?=
 =?utf-8?B?QlBRbnJpNGQrUkwrTWZRbFpZRWgwODl3NHluRDV4Wkp1WFlzQlc4T1VqcFRD?=
 =?utf-8?B?dDFIL0l3ZHc1bkdFdnpEaHRhRzExVHkyMkw0aDBnTW44RHBQa2ZCVGMxdGk1?=
 =?utf-8?B?M1AyRFpEOCswdlNVZStGN0I4WHhwemlqQXlMSVJoRndRK25uK3BwQVZ4TEZI?=
 =?utf-8?B?UjlYeFZKeTNXUjBLcjREY3NxeU1YemJFbm5CMkRScEwrL2tTMUJpeGNFOUJy?=
 =?utf-8?B?UGtZeTZpR1dTVkRkSmtuREJycVd3UjNIMDdWaWVxZ2tUMnhCbWtjRlVWOGdq?=
 =?utf-8?B?a3F6SzI4NEU1WE9Ea1VOTlBUNHZacGUwbEpZVzdyYVhIeFRrc3h4RkFkelpu?=
 =?utf-8?B?UENKcjgrVVNjWVgvblNvZnJNK1VGYWlFM0c2bDlaZkppa0N6K255SHhDbXdu?=
 =?utf-8?B?cEVPaC9ZQktLbm8wTmNpS2FvNHB0aTRVdDdUdWg1R1MyRWpPb3NLeExKZ2lx?=
 =?utf-8?B?U1hUSVZHeDlLQ1p1aWRteHlqdFJGWXVrSWpDaXUxdysvNVhlMzBkM2FobHdu?=
 =?utf-8?B?V0YzZVFvaVN0eloxT1NFRGJTWGtVSFE2VlR4UHV6Y2l1YVIwWXZUN0N2d2hh?=
 =?utf-8?B?Y2hvb3FENDhiOVI4UkVPVnl1TDJGZXNvWE1WZktna042NE93VEtDTEJFbU56?=
 =?utf-8?Q?5XbY=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(61400799027)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 14:10:35.0166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e23103b4-db80-4ea5-59a3-08de2dbebbef
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR19MB9360
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDEwNSBTYWx0ZWRfX4twFvHRr4L1J
 GghB+jD0olriKn4XJc3s3VFDvTQ9fV4PcjsJHB9FtZofUcqTh3snuAdn8pesRCSRMHlqqQwyd5n
 0CR1oLu+73bXeGiJ21M6znwOR3BY4pwNJtQQk3elG2wkJyRjLzzVmupeYTMyrvc32Sz52etj9nN
 DpL9tb+XrMJ7CgJvz6qDMwPcU+ReWzFc88IPJv5US5RjXmzP3b8vqBp+7rXxtfRcQTT6VHRZTmV
 j50kt8/ghwcrK+ddC16vHmrUOc9QGA0jexkKUAacUepEwuQQxnKBCaZ2o78I1Z4GW/fFuOqQ5qc
 SFEIpMHfSvPFJb7bkx+bCg9V9CM5yIVBN3FXIFUipZlN1Rr1j5Cd/kOk77tCJV8hDQn0HUYMtQy
 kV7oJgYp01JB0thzFNxrKV+Jkeoh4w==
X-Proofpoint-GUID: 78KjMX6OWHYW0K8y0-mZZmQS0nNRa06W
X-Proofpoint-ORIG-GUID: 78KjMX6OWHYW0K8y0-mZZmQS0nNRa06W
X-Authority-Analysis: v=2.4 cv=V4JwEOni c=1 sm=1 tr=0 ts=69285be1 cx=c_pps
 a=83jsKCSeZiZisq1MDa3xoA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=O_mYIUxG9PxvoMOS:21 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=W03AKKEhPEvQUwN8D1wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Reason: safe

On Thu, Nov 27, 2025 at 03:07:48PM +0100, Greg KH wrote:
> On Thu, Nov 27, 2025 at 02:04:48PM +0000, Charles Keepax wrote:
> > On Thu, Nov 27, 2025 at 02:51:50PM +0100, Greg KH wrote:
> > > On Tue, Nov 25, 2025 at 12:49:59PM +0000, Charles Keepax wrote:
> > > > On Tue, Nov 25, 2025 at 12:58:30PM +0100, Greg KH wrote:
> > > > > On Tue, Nov 25, 2025 at 11:48:02AM +0000, Charles Keepax wrote:
> > > > > > On Tue, Nov 25, 2025 at 12:43:16PM +0100, Greg KH wrote:
> > > > > > > On Tue, Nov 25, 2025 at 11:31:56AM +0100, Bartosz Golaszewski wrote:
> > > > > > > > On Tue, Nov 25, 2025 at 11:29 AM Charles Keepax
> > > > > > > > <ckeepax@opensource.cirrus.com> wrote:
> > > > Do we have to wait for the fixes to hit Linus's tree before
> > > > pushing them to stable? As they are still in Philipp Zabel's
> > > > reset tree at the moment and I would quite like to stem the
> > > > rising tide of tickets I am getting about audio breaking on
> > > > peoples laptops as soon as possible.
> > > 
> > > Yes, we need the fixes there first.
> > 
> > Fair enough, but it is super sad that everyone has to sit around
> > with broken devices until after the merge window. This is not a
> > theoretical issue people are complaining about this now.
> 
> Are people sitting around with this issue in 6.18-rc releases now?  Is
> 6.18-final going to be broken in the same way?

Yeah regrettably that is going to be broken too, at least until
the first stable release either does the same revert or backports
the same fixes.

Thanks,
Charles

