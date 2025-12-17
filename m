Return-Path: <stable+bounces-202831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 861CFCC7E3C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 14:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F41431024EF
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084AD33554A;
	Wed, 17 Dec 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="l87z4Ft9";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="zL87o8BW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F425C802;
	Wed, 17 Dec 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977434; cv=fail; b=R8vDaspVxxoBM0KWFU++XgMKAlMawQTy3HdI8SD1cPLk8XCfhInAYJBcdaHpEA7z6VlWgNyAuAqo6uSCLY6nvqvGu2y3MemFJVVUKhjWBFPxAtBfoLHE/Ks/e6ukRDbSgqlanCYgQrt4sdzNRzwl+IxIbbt/Z8rIr8zf0jukzQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977434; c=relaxed/simple;
	bh=R2Iw2edCBVAGT7FVrPSk1kK8qUfudaEtDO1VCvE2iP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZIM7AZ3piL5gaeVUmUMXFRM4sOpKcYyMvPer1k7LsMXVnOmB/xzFvz4r2J9SDYeF/f8e/L+WIVND3kQW2Pyo/O+dfx3TTFTVttWfw7lKBv+tjHBJ71duSQBU1qJ87W23dQgaX1IcJoZzdPgQ4gB5tOP08TAK93AGbAiTPdlU2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=l87z4Ft9; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=zL87o8BW; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGLfwux1895399;
	Wed, 17 Dec 2025 07:17:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=VxzlVkwVQIbAF1CP0VLrnXbVrwZDpBcbeBV/mYez01Q=; b=
	l87z4Ft9YkPjUZOHbhV3vOGSKgYGivTgtS6k732xZew6kx+CGSaKV0DmOEZulxHk
	e2UrMxmTCvZJ56Hqzu39B+KMVeB1i//0uaLsVUKoJJnVq8pO27RNIlOftMH4Fjgk
	O8wy+GVuvAl9w1hUlmKFcV3/7jWCAiele1Q6uPj/8MmDNpLec0evb1Ll/+hS/ny4
	Yz7lgIeolPzKZLBhN1TQDtEFb9dzBkVgVWwgCZP8lp/eyUjm50PvwvO4jjKus6t/
	fqPSAr/tJrncsaD8IWM+5Q+nX7NBJGtqwjx+TgzDqJsHrhNUl2v8QbErUfQjcCd6
	SeQIgA9w6N/bsAl5G+hHjQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11020123.outbound.protection.outlook.com [52.101.193.123])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4b15ejcu3p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 07:17:06 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3xOW7FO+Gkz9MWfWvSabH2rjsJkswtt9wo8e4Fwfpb+uj2MKkF7SFY1/xTkztVYWJsPKotAwlRemmwQCMIXNdh8lioQkF8PMFr1gO9jlRIUTaRZ3pMQOAhvmzWa+xOf6a4vuoBzpYkX0A+eF9EFZQrCDbsepEAiXOkdkGydIrH3Gmv47kq8nAClRVFJQ1RtjFw/LKCD1o3N5rG2Ppy7UWZjirryrqzCTHLB1eu3APLHGvtuDH8wof3qrKFI8wTq7bprJBVRAS7mL917OTAYXBH11uciHRryolrP4eczQUdB3kvj2FvgLgRsitZ0cPC/XAlBBzeni8dMN9c3eZErWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxzlVkwVQIbAF1CP0VLrnXbVrwZDpBcbeBV/mYez01Q=;
 b=Od+Q+/lKg2ReO1DEhEr+PslA5UBlobGapNZmxgj37igxpyRKdpitxUb4ZGoihTsi+2vpLalYs0rKW7aFJlyhXXLr+uhEcdljKyXxaGXiNEwct8k7UEL5dBtaakwZL717CxcOpoC5Tcipy7xvGJSwDvFQlCTO1zF4ts6Se9rcTt6OPc4aRRicUiRYtLZHkwPEm6ThJ9b2rb0I3ZK1OTrAEUYuOMQ6XyVwqxgodexSWznrldxoEYpjICo+YPK72hd5dss4AlhtQ9pp6ZVBXHLqjomQdFw2xOvIHyUjLaleK0C408NG3Aj6WoMeVP5kKuhWl8xQUzdwprwCCtyuyu80ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxzlVkwVQIbAF1CP0VLrnXbVrwZDpBcbeBV/mYez01Q=;
 b=zL87o8BW45yfO3A2KDTxPoTtHBr4sQtDVNKA1nBpi9tFwOY0/F2gaMeosbZ1+Rg4uZqJH272D7OrtsH7k8fu99sgfvIcnau4m3nH3iOWlgLxVRgMiTqQCuBBrJfdXF6f+o6+TyfOY2p5Lm5U8Yq4ViQucVopwhpxq32xU+jPz4M=
Received: from CH5P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::22)
 by MW4PR19MB7079.namprd19.prod.outlook.com (2603:10b6:303:22c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:17:01 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::89) by CH5P220CA0016.outlook.office365.com
 (2603:10b6:610:1ef::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6
 via Frontend Transport; Wed, 17 Dec 2025 13:17:01 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E2D4B406540;
	Wed, 17 Dec 2025 13:16:59 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D5AEB820247;
	Wed, 17 Dec 2025 13:16:59 +0000 (UTC)
Message-ID: <9f1d5b88-e638-4b87-bee0-fc963231d20e@opensource.cirrus.com>
Date: Wed, 17 Dec 2025 13:16:59 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-ops: Correct the max value for clamp in
 soc_mixer_reg_to_ctl()
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
        kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
        stable@vger.kernel.org, niranjan.hy@ti.com,
        ckeepax@opensource.cirrus.com, sbinding@opensource.cirrus.com
References: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
 <6e97293c-71c1-40a8-8eba-4e2feda1e6ea@sirena.org.uk>
 <27404fce-b371-4003-b44b-a468572cf76d@linux.intel.com>
 <af368a9e-16c0-4512-8103-2351a9163e2c@opensource.cirrus.com>
 <56411df9-3253-439a-b8eb-75c5b0175a7a@linux.intel.com>
 <bc6f3e66-ca9b-4ba3-bbe1-5ef31c373e6d@opensource.cirrus.com>
 <e98a78fc-0b30-4af1-b6f5-2bc5cacc8115@linux.intel.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <e98a78fc-0b30-4af1-b6f5-2bc5cacc8115@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|MW4PR19MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e48849e-fe12-4cb8-cc47-08de3d6e909b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|30052699003|36860700013|82310400026|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjBkVmdNT0R4YWU3NHpOd0VrM1Y4YzJaRzE5UStKczNkdWJ3NTFXajZrVmlM?=
 =?utf-8?B?ZjNpTFFZamJjWlZVTGpNS3EzUmlWZGpBenU3S2k3dnhOc3VVd1U0SkFmOFZS?=
 =?utf-8?B?eHZuZmhxMDJhcnRhK3hzancrTmVyNmRMRFRtTGxDUGdSZ3U3V3A5enNLeDJn?=
 =?utf-8?B?YzdrcVJCMzBsSXlKbkM1WHJkNWV3L1JoQUpndTI0OUtLZEJ4QWU1RHdpdnhn?=
 =?utf-8?B?eVU1aFhXVk9aajBGVmhUSWlHWndVNElEK01ya2dNM2xNRkVNQitoU2tlTFlq?=
 =?utf-8?B?U1M3Y3NXQVZJa3hzTVRIS1Zzek1wNm9Mc081cUpBamlwOThrZWVqNUlqeEZY?=
 =?utf-8?B?VzN0U3RkOHJjd3BvYUdPZ0pxLy9rWnNJQVVKeE9UMXRKSmFLZDYwaGFhcXZm?=
 =?utf-8?B?QjJEVkw4VHRUVm9PV2NXZjlzcE1kN0ZXZHlzZGx5djF4Z2FFbURaWGVhL2VJ?=
 =?utf-8?B?c1RibEhvSzdQU1dVMmZBbGtwbmIzK1RvMFlQaVpCQzNGMHhMVjZDU1RHMnp0?=
 =?utf-8?B?Q2N1V3hONVpsU24zUlZBSnFpT004UVZBaUZzcnhJbHhyZDZDOWZwL2lWZzNU?=
 =?utf-8?B?SE9uNlNPcXFPSUZiNVFKM2MraHlSR3VTY0pPdlB4SGhSbCszNjVSVkpwOHAx?=
 =?utf-8?B?VjZ4TncvNnRrUkxMUFB2ejVBRG9DeDFzaWEwRWxmcW1mbnlPMnFZSzlhcWZ4?=
 =?utf-8?B?bE5MLzk3aGx2VW1zcml4YXVITHBYQzBpeUdLK1VKbzArdnB6d2RLVzNYZDEx?=
 =?utf-8?B?dmhMaVV6RDFHRk9XekJYYkdydXU4bndVK1ZQZlpLWnY5WnlZYmNTZG1WTnAy?=
 =?utf-8?B?bUs5RU9JWkMwZlNRd3piSnNjMWNHMlVReUZJQnBCamhTNXRZdTFGKzdBUTVm?=
 =?utf-8?B?QnUrdFhTMlcrdlhoMEIvNXlpeVhrZkVHZnNNK09BS3d5dmhOUjBYMjQvT1A1?=
 =?utf-8?B?dXlSVEhSNEJFUzhhVXpFZktCQmduSG9HTVNnUVRCN3ZvOUdBaUJjdHlDLzFW?=
 =?utf-8?B?K2lSTFNCWFhJU1RFcVMyYUx1dEgxN2xCOHk2SHJsM1VxWVJmbGFyRkw4UzBw?=
 =?utf-8?B?eExXK3BGTTdXNXVEazh2dFBYV2RqejMwZmw1ck9BRkMrelhBaU1qdHJ3OFNO?=
 =?utf-8?B?QXpBckFhUXJlZXg5TGN4ZE9EV3M3Z2JSY1JCeHh1K0ZRQ01yVXVOdTRJQWt2?=
 =?utf-8?B?UTBOOS92M1FQREJtbytSQ2J6Y0RGdEpGMjJ3ajV2cVJ5T1N6VnUrS25GZ3Ar?=
 =?utf-8?B?V0V2SVF2S2RJdVhLQXhSSGtTK0VzY2plTXAxN2F3R3U0bmEwQnJVd0VIak5X?=
 =?utf-8?B?RTBSNTVRUkUrUXpoS015MGhYNkkyR1JZSUpyampKRDZJbjVXS1pMRlZ1djFM?=
 =?utf-8?B?RUxlYm5TblFiUU9MekVJby9FUTFnc0NaOFBwcnA4aGt3a1IrdnE4N2R4dkRz?=
 =?utf-8?B?UEZWQ3dsc0dwbzJ1czZ5V1l2dVI4K1B6cTdMSUIvNUtueWZ1YVcvejg2bFZL?=
 =?utf-8?B?QXBXc3UzV3B4aG41bzZmVTBYYnZ2TGRvT0IxMGI3WkoxMS9KZnFWejBzWkNx?=
 =?utf-8?B?WUlWSnpXNndhUnpjZlJaYW1heldQdjY0cjY2OEQyV0xpRTFzb0lKczJPRm5K?=
 =?utf-8?B?V20zUGRNWTVzUU9GU1RFbGROSGFxOFNpRjkvb3B4R3d4RlVkMjNXaUhvRFhD?=
 =?utf-8?B?QVVRbG9jUVorRFRlTHFsSlNDNnZKZHJOUzlGZ3NOa1IyUldYUmd6K1QyODk1?=
 =?utf-8?B?Wk5CUE4vcXpjMDJBRVA4SXVVbzJiWENtc1AvaE83amNPNll4Zm9mNFJWU3Rr?=
 =?utf-8?B?bnJ3TVRDOWhsclhDeGJwNC9LY0hhRmp1K1RjLzN0Sy9RTU1nOWR1M1hMVW50?=
 =?utf-8?B?am1kMjU5aXVrMWc1NUNNbDUrYnFkQ3NhWUNqdzRFc1RDb3RMQ3lyRlpkVis4?=
 =?utf-8?B?eWNRZWhneWE1Q04vQkJ0TU43anhkbld0QjcxWndFbkpRWXBFZ2l0WjBJMmNC?=
 =?utf-8?B?anlUSDJ2cW1HeFhiR08rMEpLMklxQWlwbnVPNkVoWkFleXM4cmVjSFoxejZX?=
 =?utf-8?B?ZWV4U0ZhMEwwK2duUXVzdTVRdVNQTDMzSjd3eTVSRGJzYk1WYnJscEY1aWpE?=
 =?utf-8?Q?A6e0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(30052699003)(36860700013)(82310400026)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:17:01.2642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e48849e-fe12-4cb8-cc47-08de3d6e909b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB7079
X-Authority-Analysis: v=2.4 cv=ZZUQ98VA c=1 sm=1 tr=0 ts=6942ad52 cx=c_pps
 a=zwG93V3sI98pkU4B7UI0OQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iwh9IePOAZXgNE5NsMMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEwMyBTYWx0ZWRfX/5K70TSluw7q
 xqWQXVP8rS1TSMciTJjiG5Sjt17CyIMGvSXt4Y/UY+IuWGCZ9T8ffXlD7L6RrhaYOBhiaiuTSfU
 wc4RcTI2u2elYdjDILdvWxD96KPqSHggSnAggIZzZMGwD36vlyJ3wjCfkdG1+z2Cp0ToE7OwdKd
 P5oeCHPqtFBMqZkcxzrBiZHbVssVj8/GKG02D//5Iqp7qgmrN/nVVCye5VsTYY+GHQaWW2f1fFx
 3HBluNxBOMHqGafNuK8428WXCv3KTrTF5Uni67c7i/a8AxwAHdDSBqBHyo+rqNj8QUQw31v2Lkk
 72a8mqCsYL+GExBTlTcyWbPtmyql18Y/eJZze/+GwgWQ0Z5B84PMxvzGcEQkgZfVas0bFrNLUKJ
 76e8jjA7jz3nfoC6W4C4RvQNNlBksA==
X-Proofpoint-ORIG-GUID: fGzQyqeb9X9elLg6yeymkkDZpz1fqdeS
X-Proofpoint-GUID: fGzQyqeb9X9elLg6yeymkkDZpz1fqdeS
X-Proofpoint-Spam-Reason: safe

On 17/12/2025 1:01 pm, Péter Ujfalusi wrote:
> 
> 
> On 17/12/2025 14:40, Richard Fitzgerald wrote:
>>>
>>> It passes my manual tests on cs42l43, not sure how to run the unit-test
>>> for SX, can you by chance test this?
>>>
>> The easiest option is to run them from your kernel build tree like this:
> 
> It is in my to-do list to get kunit working on my setups (Artix Linux on
> dev and DUTs), so it is really something that will take rest of the year
> easily ;)
> 
>>
>> make mrproper
>> ./tools/testing/kunit/kunit.py run --kunitconfig=tools/testing/kunit/
>> configs/all_tests.config
> 
>>
> 
The kunit tests can run on the computer you use to build the kernel. It
takes a couple of minutes to run.

On my desktop box with vanilla 6.19-rc1:

rf@debianbox:~/work/kernel/linux$ make mrproper
rf@debianbox:~/work/kernel/linux$ time ./tools/testing/kunit/kunit.py 
run --alltests

<SNIP>

[13:12:31] Testing complete. Ran 7154 tests: passed: 7082, failed: 36, 
skipped: 36
[13:12:31] Elapsed time: 110.250s total, 3.072s configuring, 55.003s 
building, 52.119s running

real	1m50.314s
user	15m52.878s
sys	1m18.186s

