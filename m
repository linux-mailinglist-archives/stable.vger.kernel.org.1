Return-Path: <stable+bounces-240194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFCnLied52ml+QEAu9opvQ
	(envelope-from <stable+bounces-240194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:52:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FB543CF39
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 17:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5511304D1D6
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46B331C56D;
	Tue, 21 Apr 2026 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jTbn/WX/"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DE81732;
	Tue, 21 Apr 2026 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786668; cv=fail; b=rDTwMIcHeWHivvmSrcUKv9K1FYda7dtq9x7kgj5zzwCiReomReEIG+Z/UrKxpT7DSWIt6kHtG9U2hry4NVa7Kd0EhYcg7ME9QX6uLx44J8lrvTCGYEDZgc+JMstpPZVqTkEK0r48uVxTaIoKrrC5UTbyduHUA9kivFvLiNnBjPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786668; c=relaxed/simple;
	bh=euvvWRifv5Ci8GtF4s4ewW7v0Q8GH2xvLxhYYqnlHMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LNV/vSMh+hnDAvRjtZf1vFKCGszXyd/oo1ZX+/mXqpefkLCr0ROVMFKtMkApqMIIKezqibbhpPJN+FEIG2TM4QUw+AcWnk3A+P3k2ZPes2xQ+j3gfgapSp5JCgIcKtPFE/xhQ9B7agiN/6b1e7zIFDbatE0okiMuL2ANvzJPKOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jTbn/WX/; arc=fail smtp.client-ip=40.93.196.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqTCQdwwM3/HuCZBIh47e630imaX6TA8/8RGwJVbSgY6geHsEdpGZs9fj7A0Ei18uTLv9J0tcVhbcX1rZeJBX+yIKoUkofvrs/zjHuE4vQfORd+4V402sj3kSuMYNuDSbGzhOlMh5MNS9SdGyl1NbGbfbUJjbxF3EVkDlRM29oVywQ934MNJAD0Dwb2mvtsSxk6vlIpaAEYmW2oYDyMJG4kpTwvk3taAWMfFuB1Vf/2HNMMSLrO95Vaj3819KzZOBuJn6wu3zlllbe3ae9+gQ6C0WZc1F1iwLzXJ421DE8jOo58GsdN2v0C9KdjQGuCOsQ1Dwv1vxyUMwHJtG+rysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah2xOvWaDKLvoRx+Sugm17sPEJa2Hr2jwArmoO66aQk=;
 b=wcBe2lysjyVr9lUKZAHN7fqKx8f2mbPmgIYpj+8aaY5rIWQzUpzYyp9SN6H8XDAFp7txSvltqOMPdkfyXIPw3po+15BMe2egi/OV12ggt40pslRig3JN6qFz3ByVJCX8bVtZumpuW3beGrc6ZE65oTXRnTFsgRTpAk8Rc1td+IiVad2uOF+ZfMlmm7Pp/Ks+YTZfamgz8ySTfmFoj3JEjgpj0YT7IQtqXkdSzN4bvfp0fCFeF5mCJ4STCc6kteNDA1j699Dut7fXFcFnSzuS6JHLBBKW7ODZGGnz1T8ZwtUNAWV+nQhPqaFdbs4XcMVEbJ1cwKRLuljP2YAIUYwiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah2xOvWaDKLvoRx+Sugm17sPEJa2Hr2jwArmoO66aQk=;
 b=jTbn/WX/yeu0qHGdjy7rL2wjLm6Fqpi3PxrkMBG5j5KyEpZ0E/2dAoeTedA2hkBuYG+WD7GRR8/gp4VDCgszvyieu7M/sS3L5050AcdSXjMPyKWJjldaEiUBKX+sWnc+HfgCBBdlcRdr4Oz+huDDHzd6AXpJp1ZjokNDTDxfgiw=
Received: from CH5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610:1f0::24)
 by IA1PR10MB6218.namprd10.prod.outlook.com (2603:10b6:208:3a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 15:51:03 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::6a) by CH5PR05CA0014.outlook.office365.com
 (2603:10b6:610:1f0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.15 via Frontend Transport; Tue,
 21 Apr 2026 15:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 15:51:02 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 10:51:01 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 10:51:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 10:51:01 -0500
Received: from [10.249.135.215] ([10.249.135.215])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63LFov0d736833;
	Tue, 21 Apr 2026 10:50:58 -0500
Message-ID: <d36239c2-98d5-4e5b-b99e-470f4d753a52@ti.com>
Date: Tue, 21 Apr 2026 21:20:56 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: ti: k3-ringacc: Fix access mode for
 k3_ringacc_ring_pop_tail_io()
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>,
	<ssantosh@kernel.org>
CC: <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-adivi@ti.com>
References: <20260413065125.627180-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Hari Prasath G E <gehariprasath@ti.com>
In-Reply-To: <20260413065125.627180-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|IA1PR10MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: 304c728d-14a3-44b7-c8fb-08de9fbdca31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Wiu3voGBI0kyePGzqj+0wyl12m/lXs1T+ZfURBB9bNdedzL6usl0d0uJIXCz1UBUBMl2F0SSX9Kmqs6Zp6zPK/sCGZZAAtucgiJ65cyVy4PEQNrXfXO3oDGa/F4IqCg6bd/9CD43HEWTlSFFf+PEszz482m8cGwCB42gRqmk5Tbkeq+oSkF/U759n+1JV2cITKlRakurfQv8X7SgOWwXNHHFS/CL+QvgeSJFntrvhPMS+O/ZOAksvzftsdpUeoU5k20CuxIsXqKIv4DVXj7/3Oyr14JxhtwwXc/Ocw6ytGNkv138Pfoz/zoGeBK25h8BAF+mScY7uB9BqePTPIOHOZFt/Fl15kiH74HueuXJP5bPCLBaUyn1Whyyi9rrCmSmFu0kIDisv7qhbecqE96hf4iIJRF7TKVQvFYFWByYQnes+67C4y4GwFsbMJdNJc4K9eVAQn9/Y2hueGZVAmr48iiXoFZE/iGa1rLyNX7XZ/MyS4CwW7LYA3n2F6z8p1OS0l4Sz1/4odLGzsKzXDDBF5tSTtxE4TaB9u/ox28tR0FZpU5QhizLIgIojcBq5d0xOrKsOlyWoT2ZRF9dB3GU6t289lFUh0sm6mGsbJzaWyewUM+LlzSeD6H1ZcqYxm/vHwx4hxwrb+KQWPXer+wCJCX+ravv1k5jdaHn9yRrW86RpkklTvf3gRhtkkISptc3lZ4FXBBLM52BmCrj/6XHGul/sCxy2Chku5QSIRhpFVwk1zcYF9czgJVRywfC2j0l4qEUc9e3gCLy9l3BNvBhRg==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Tpy48nnqGaYcL9TEc/6hlBtHlqyWQppgzMnH5+cKEsj1UYk57ygRgs+tnY1DPwTXOlwsyVSMGj53m4ZneCErIyKHuwAHVVHs8UU6dW109OCcBRZ2xG9HF3XLUL4sRL6NoGLDIlVzH21R7MINZDkvKHpi9Z07g4gffaooHLNLPyxPQMdIBWbwbqBn1VOLte2A7Xxje3HKJ62nXjEkGiTfK8j4jhk3GXFrkYGP/RwHEfLO4Zmj083fAwsJX8vtoQwEA2BdV8w2HAUCURaf3sxY5SEpiV7dT50x05XbCg/bZDq55J37s1m4f4gfWeCwTRM5DWr7xmMp+QkGg0fF/ameuh5R6XMLFCqH7fkKb8XR5wemldO6l3J0nWeL5R6AZqqX9ua/j3EOTHhfHUTmyNH64MncbMzAkWq0NFDocCaS68we9Msx+w7VTm3xFZx1wmvN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:51:02.2036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 304c728d-14a3-44b7-c8fb-08de9fbdca31
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6218
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
	TAGGED_FROM(0.00)[bounces-240194-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,ti.com:dkim,ti.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gehariprasath@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 47FB543CF39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Siddharth,

Thanks for the patch.

On 4/13/2026 12:21 PM, Siddharth Vadapalli wrote:
> k3_ringacc_ring_pop_tail_io() invokes k3_ringacc_ring_access_io() with the
> access mode incorrectly set to K3_RINGACC_ACCESS_MODE_POP_HEAD instead of
> K3_RINGACC_ACCESS_MODE_POP_TAIL. Fix this.
> 
> Fixes: 3277e8aa2504 ("soc: ti: k3: add navss ringacc driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> 028ef9c96e96 Linux 7.0
> of Mainline Linux.
> 
> I noticed (visually) the incorrect access mode while working on:
> https://lore.kernel.org/r/20260325123850.638748-1-s-vadapalli@ti.com/
> 
> Regards,
> Siddharth.
> 
>   drivers/soc/ti/k3-ringacc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> index 7602b8a909b0..24f658e8c1dc 100644
> --- a/drivers/soc/ti/k3-ringacc.c
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -1083,7 +1083,7 @@ static int k3_ringacc_ring_pop_io(struct k3_ring *ring, void *elem)
>   static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void *elem)
>   {
>   	return k3_ringacc_ring_access_io(ring, elem,
> -					 K3_RINGACC_ACCESS_MODE_POP_HEAD);
> +					 K3_RINGACC_ACCESS_MODE_POP_TAIL);

I see that you have noticed this visually and fixed this,was there any 
impact you faced without this change like data corruption or something ?
It would be better to mention the impact this change brings-in by doing 
some analysis.

There is a similar function k3_ringacc_ring_pop_tail_proxy() few lines 
above where the same change might be required.

Regards,
Hari

>   }
>   
>   /*


