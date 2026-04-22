Return-Path: <stable+bounces-240271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCKBDh9U6GkcJQIAu9opvQ
	(envelope-from <stable+bounces-240271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:52:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE444203F
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4477A3029C0C
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 04:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346502D97BB;
	Wed, 22 Apr 2026 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HQgJIo+1"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D822417BA2;
	Wed, 22 Apr 2026 04:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776833564; cv=fail; b=FA9jSJ1Incb/8Rpbh8VxJhGmfWsOjKQKTJAmH/Aw0eWEZrlTugAGalMLsax3lcvNVEy5Mrydukp2jE1CbHbSNV+RCNGPhvQj7cWtBIt6rzFgMcsmFNh5DJOoleH9Hw0rSZHAoQvR7OlleCFb0M0eg+KNl+zZHwH429m7x5/VNqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776833564; c=relaxed/simple;
	bh=7gWRBoH219gGmvJ1bGT/XjQ5nfVwSWaWzcU7Fqq75Yg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L2NERHB21cSYRjQnKqy7s3KNZAc/NW9DZoNL9DXcis5vfgjckgTjRKaUtHSMXTuVvCKSGqBuB/Sj4YMzl1ESM3F4WuGOmfgQbWojBvgaPDAMklaNDP9x2dAWC1s5z54qf1GusDx6rV/xulDvkPHa6fc8qniGvMJfz3LhvgB6Bt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HQgJIo+1; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkD1k6sp6+v2ds1p4bAm5s2wKPewWS5Z1aVvfLbn4QQ5pdfZ/ytbnEahFiuyy4j1Ml6BGiXv2eP5jm3unLsqJ8EUqOL5ltYpRlkjmSwgBTiw3UPLh7+mGBuAz3xNljhEWm6oKTpGRuoMvHpj18h+c7TCTfFqiLn7o1+SkOdhqDiUoXZhEqhESWubXQiXPxSQxBwSY2lyXMaTLIDde1wb2p2PO10vcREgc8TuKduj4eazqRUiSgzA/4agckbEBBFCZXegzXe0f/HUHHssYxq3CatpaQBDwQPMaU55S4jSe5NsyxpW2gBgw8sBfGntUp87HQstrTOGGRzAPCfMOBstmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ko9GXkd3Iaci3n7UyVaUhaBHQVeN8C+51txJrwyt8lA=;
 b=JcpPD7Cs5/7J96k4LHNAhMKnFzqV44lJcdDoaq5tuIXUdjOaLu106QvSC8VHZy2fnQ4S8/X3QAbKXzJRxTycRaOSmNPMQFgdu8oXx0zTlvX4l81EDliCTJroFiDKLQpvBUAhCzy4cXO+Zw8+K/VdtilJ0X4HMIuGyjfuhVumuCL7lFuCqJKi3as8MJUWVM0wSx3Z7H+WRGSlbS//vQe8GDOkYSs8PhIdOVA7MpDs9Qe45M7fy+cwkQhytPKk2kVrpEVKZy+er9RbaABAEmF6frHVfyVeKSsd5IrRHYcOBOOeySO1CArpb4J2R2WFCukmEr5eVdpdvLOeaExItBff4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ko9GXkd3Iaci3n7UyVaUhaBHQVeN8C+51txJrwyt8lA=;
 b=HQgJIo+1oA7ZWpbR/t62d2GDEUUrOE7X28djqyPbZC0bgUGWkBmiDWSAck1O7RGrXgRBvZLgJ7+YkZC1wLRgA7xzJc10xFLpw5gkl2bx9gvmiVlhZGToykvpUPG2qWNwkyD9PscUEoiw6bxdd4Q9Inhgv08i1Pz16O4X4zcI0fM=
Received: from CH5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:610:1f4::6)
 by SA2PR10MB4650.namprd10.prod.outlook.com (2603:10b6:806:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 04:52:37 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::88) by CH5PR04CA0001.outlook.office365.com
 (2603:10b6:610:1f4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 04:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 04:52:35 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 23:52:35 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 23:52:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 23:52:35 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63M4qWsr1530095;
	Tue, 21 Apr 2026 23:52:32 -0500
Message-ID: <60924843-6647-4ec3-b869-bf57f3747414@ti.com>
Date: Wed, 22 Apr 2026 10:24:50 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <nm@ti.com>, <ssantosh@kernel.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-adivi@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] soc: ti: k3-ringacc: Fix access mode for
 k3_ringacc_ring_pop_tail_io()
To: Hari Prasath G E <gehariprasath@ti.com>
References: <20260413065125.627180-1-s-vadapalli@ti.com>
 <d36239c2-98d5-4e5b-b99e-470f4d753a52@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <d36239c2-98d5-4e5b-b99e-470f4d753a52@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SA2PR10MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e9665c-a7d9-43a3-73fc-08dea02af8d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TeUuL8OtFaf8tYZ3j80OT6oKIqJHYN2vvH5p9Ny27AUGIrqtTVTZxEjzIwdPk+c7GUyonXylonMMk4zRxK4dBa2jAxB5WmVKZSnHY+A6mj3ooD5UACUavk4seASfbI+hZtEatsmOgfYTkXc8rCKIMKXkfnWV4lq8qQP9pAAhzeN2TkLizs9Bbm+sJEVWIEhQUukoQvrNVQpZi1SI+C2SCVsgKB/sfU07bbUOowxnaIL5nGJSxI+68pP7VKG6DMv6OG13/vxLWe/l67mUZ0X3ehAM2gd6XXfc1StJCYNS0Iu66ANY5+Caf1vMEH7eMy9PBkn+aCeQanLNb8NjTh6sBFvS/3fV3pIkGNGxPL5NJ1hjSi0ep0DxnHqEhTQAPhh7NgZfdZ0yy6y+LtvWmD4ywnee8dbZZRaEAEc//k7b7s3mwTXB3oEEoOTZLCkT0B8+4MojCypMJOPzHCfLxp6PHtF9zCuzBFXxaLTVWqzpKLR/mGAYlOIQHI18jNallKi3MZp5xs76tIJwX+Ac2NYUv2JAvKf/UBO1R+8lhN2V3nMS4G5X/Kok9MulWlE1cFQscy3gaj4HMmAGu0qnFF3BYX70BV+it2kgx+TRw5eSV+ltyeKaVpRgXEkK2A/9PALp2FeYBqcHPNJYWUv2TfF2b2eWUV+2v+6dRzHcM9HK7bgh0ZqTGduj1ZKFUhcmOVEyQJbWyKM411jokoh8Adkkqz737VGrv2DEfeVhQ5aGN2R/4xkSS2mLcvMN0Y+A/gL4eB5TZPipiDf7bWhbLxhXoA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JjDfr5BraoWFxjz8z4DZfqmXAwAszYSb5aXJuhDSJJNDFXBKPYSV0Ub/S8JdYS0UkMksgGlpBzz3MD8Sd0CGOy8pa7K6av98pS3mOuQbvLmCLXX1RfnSpVQC6kH43ESjeXQRlX8GENhE0hNDP9E8F6sgIaOODvz0DGsY/L1YkeV0fyZaskugR9XpdCDJiDbz4YoOEAdsKrRUEPtUHMibY6PFUPoL3Ty6NZpB6f7z9FP4UA+t+uIZ/E19CTmBoeAwhzSGgFHNKA9YUKcNZSmojchl7yYvoq1kW/KEPhKHlbswYfNQTyPu5y2VZyBQxln5bStauMv0uiGhqnQ9h0f9r2ZTTbx3bY/4DObhixIpuy26CzyFj09o4mGNt9DkJtqVq71eIeedV9QerZSIp+Lsd3ErulwksVrxNaLHSzqpK6n2vpTuFkwrj9WILYru3tJL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 04:52:35.6061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e9665c-a7d9-43a3-73fc-08dea02af8d5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4650
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240271-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 64EE444203F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/04/26 21:20, Hari Prasath G E wrote:
> Hello Siddharth,
> 
> Thanks for the patch.
> 
> On 4/13/2026 12:21 PM, Siddharth Vadapalli wrote:
>> k3_ringacc_ring_pop_tail_io() invokes k3_ringacc_ring_access_io() with the
>> access mode incorrectly set to K3_RINGACC_ACCESS_MODE_POP_HEAD instead of
>> K3_RINGACC_ACCESS_MODE_POP_TAIL. Fix this.
>>
>> Fixes: 3277e8aa2504 ("soc: ti: k3: add navss ringacc driver")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> Hello,
>>
>> This patch is based on commit
>> 028ef9c96e96 Linux 7.0
>> of Mainline Linux.
>>
>> I noticed (visually) the incorrect access mode while working on:
>> https://lore.kernel.org/r/20260325123850.638748-1-s-vadapalli@ti.com/
>>
>> Regards,
>> Siddharth.
>>
>>   drivers/soc/ti/k3-ringacc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
>> index 7602b8a909b0..24f658e8c1dc 100644
>> --- a/drivers/soc/ti/k3-ringacc.c
>> +++ b/drivers/soc/ti/k3-ringacc.c
>> @@ -1083,7 +1083,7 @@ static int k3_ringacc_ring_pop_io(struct k3_ring 
>> *ring, void *elem)
>>   static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void *elem)
>>   {
>>       return k3_ringacc_ring_access_io(ring, elem,
>> -                     K3_RINGACC_ACCESS_MODE_POP_HEAD);
>> +                     K3_RINGACC_ACCESS_MODE_POP_TAIL);
> 
> I see that you have noticed this visually and fixed this,was there any 
> impact you faced without this change like data corruption or something ?

I haven't tested it with / without the fix above. But if I have to guess, 
the impact will be out-of-order completions for transmit descriptors and 
out-of-order of packets on receive. Although I have described it in the 
context of Networking, the out-of-order (reversed order to be precise) 
issue will be faced by any user.

> It would be better to mention the impact this change brings-in by doing 
> some analysis.
> 
> There is a similar function k3_ringacc_ring_pop_tail_proxy() few lines 
> above where the same change might be required.

Thank you for pointing it out. I will fix that function as well in the v2 
patch.

Regards,
Siddharth.

