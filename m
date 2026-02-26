Return-Path: <stable+bounces-219793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEYbFY0voGkrgAQAu9opvQ
	(envelope-from <stable+bounces-219793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:33:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3461B1A5125
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A09B1301DA75
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49A0332EC5;
	Thu, 26 Feb 2026 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hItviFXI"
X-Original-To: stable@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011051.outbound.protection.outlook.com [52.101.62.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0443311960;
	Thu, 26 Feb 2026 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105607; cv=fail; b=rbkwwOa8vgBACnCdvWXAZ/meACBGkpD7+IUsaJ/MxaN1DvBxJjy8pM5CisciSRxa0DgGb+xwwTn53NVeR83UbBpsN+Sqw5MsJf+DgzqPAWORozjPQoH3FrML3e1HGfqRv9Ba7ARpWa3MZgYgkoK4a40S1dgHq3WVxwigYJA87Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105607; c=relaxed/simple;
	bh=DOfdBpcBdACnWCavRBhgu4+1AGQl4zDdqVTFpCPi0K8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JyJS3jn1ifjRx5NoffXfq46cYB8aICIV3NjwAdzmU9zxLqsEUSwRXGC7TNCyZYtTQVUmNAbrHasHCHQyUTMbPdGVaOrO0qbVgWP8/MBt4pr8ga76aaxOnoX+wNjr00OBBUJgQ1Wh+O9GQCOBRenXCJ/LD2295vtQM3VMXtg3UTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hItviFXI; arc=fail smtp.client-ip=52.101.62.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBVP8SIzGcx4hUNDGitz8CYJkggOrHniA09cNnIUPrDS/5brCwjwL6bli6sbqRSNae/ysWfb6YBUKeQjezqCY4+qf3g47pst76FGIGFj7wWHUq5QmQkGt5Ejt6Ed2rriolFNhmXlqvarNp+kO+2ChZiEcKbMz3EGwTATmuAd0kFuNjjPxVMZtTzQ6xIuvO8r1JTyd8w8a30KtZz6QIHPftWmZqjU4kn0aJ8O+kUuRIm4dm0teYejpEyYil6DDcFz+glMsDEyFr59OP5S6xsLot7ogZmHnKeo29rgZweznt3YUgj1M1DLiWQ+OkuSC5xigCm+jV40bwKHpUBgzKN/Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf9Lsk9tqa0JEoB1QAiR37ScRsWtnO5bb48lhJxCaFk=;
 b=krqHDt7FbqfBllJ0JqHHdZwRIorIwKagY2W4cluVip32/DTmYcbXofpxhavybc53qdkBKXns3G53SgMMqTykqjbekSQFdsimFYefPhs09fHRXhY296D5muX1AtWI6sboLyXWg4NFBehhoUXN6Tl1W2AlLNukSinZq9dFvPuVt4ix3OMd4owby1eLdMMcqyEa27guIMAnwpp569qG8uvmjcCeSRI4dDmoOWngTkSbxaOpRdIGBSe4WvxUfQE7BYjjBu4lM08BRjaHImMCL/6QxN94qv9klcGPu8BVrH8NW0jMqor2b5AxAllW2YgnCwNgd6zww+2FPU1IQR8rQddHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf9Lsk9tqa0JEoB1QAiR37ScRsWtnO5bb48lhJxCaFk=;
 b=hItviFXI+0+803aK2GTfv2CsnPbrT6gxl6I1yoIfEltbvkaVKQBWFRJ7IpbcZNNSXTxGCYt2804RBo5aDC1OUU7SJVu3Bf70jmu++HhNQGzbTiH9XncMcVJaTenUM6daRK3XEB6VK1Qfmi4McEOi2MN4EffIhdj56qkvSoctW/o=
Received: from CYZPR05CA0013.namprd05.prod.outlook.com (2603:10b6:930:89::11)
 by SJ0PR10MB5890.namprd10.prod.outlook.com (2603:10b6:a03:3ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 11:33:23 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:89:cafe::15) by CYZPR05CA0013.outlook.office365.com
 (2603:10b6:930:89::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.14 via Frontend Transport; Thu,
 26 Feb 2026 11:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 11:33:23 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:33:21 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:33:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 05:33:20 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QBXFg62288259;
	Thu, 26 Feb 2026 05:33:15 -0600
Message-ID: <668bab11-0362-4b12-a935-c2db784fb034@ti.com>
Date: Thu, 26 Feb 2026 17:04:45 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
	<horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
	<vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
	<vigneshr@ti.com>, <m-malladi@ti.com>, <jacob.e.keller@intel.com>,
	<stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH net 2/3] net: ethernet: ti: icssg_common: set irq_disabled
 after disabling TX IRQ
To: Jakub Kicinski <kuba@kernel.org>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
 <20260220041431.372610-3-s-vadapalli@ti.com>
 <20260223184840.06069afa@kernel.org>
 <57e05b57556e94ed666acd8b4c542efc28e7408b.camel@ti.com>
 <20260224154953.63b558c1@kernel.org>
 <be80263f-667c-4330-bc24-5078fe07b994@ti.com>
 <20260225160958.64bbc4c5@kernel.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260225160958.64bbc4c5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|SJ0PR10MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db4e07b-c3b2-42a3-3ed9-08de752ad9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|34020700016|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	pni9iQC6njGGA4/4hxKnpRhJUub6ChgWvjEURJxh85qnWeq9RDKS72AbPobP8J2JqZDClIhSohmHcHIeVLVxsn4lX+g/hDMeg1VKbaYBjucDbyZ2hsx3jXUqVpbDyySvM7Y1x57t/GX4tr3jAhfmgofGnFnGcZD+Z5chp1Xo6JAVzUFUeWNLoXhsOl0FXAYV63yS/myTu9q0rU6peg0YJteMrbhuxSfgzKxMjMi7poKkELHejGpF34Ku6twNYOHjhXTfwhO149NnIU7fuUNEaeqJgZmbRK727azY1u/mfiexwPU6mhAH78f/8lakVUtqeNUNXnQmewv+kzymiPVnc90U5d8eCP6FN74BPlPCkEfio7jgA2kEUN/2fn5j/jLgp6cB29LptGjPyEV4/ppnUh3XkmwPe7bS+j6I/CwfKV4sX0FEMRxWUJjZrHKNwe6KO1yHW87NsytXbUjSxK4cW6cs0HAfKsPrJdDZL2XUViBUd6tvTGvrfy3IH2Gk5EdPzhrZicorqDK1i+7eI5Z+xley+5hpfSfyVohuRkPxzr27wq78q8eeXMrbSv2hhO3yzNtWEyJ2NwSndD2Ocf1iyTwnLJch0LdbVzs0ygGKrHaPvwVyq/FpIIbAgIxtmPT1aOFkLax7eQVNt7ebQ8fGOzC2tIZJW5gzFqsGMaBUH5NvZRIFrq7cbkZ88KxUgfDDwhe/LdSb++pD58qmZFeehMe3OHu2Nzb/zdSnrgaMTkJ3AZlyM0GdD0vEvoI/R767U2YoAlxr0CYHZS2mFqSDb25EY1SH1NFFBzKitvT4JWuPTdtG/ts7GuZctiqUfEeaf07i42YmLwLJw53cd6fRmw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(34020700016)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gZnurVpEXGr65YH527d+wITAb+HZH/QebMctRcFIwSb+k3sp61NPqdb2nVX+LiIV23U8We2GdsixzDk9J8ICkBlQGUXFQWDV2MFKLbl8/pCO4MdhoSBzCHhEQbe/iFI9DV8cIAUk5Ma1OfQyqdaKVAetk35DT5DTGQcAkVcvo5sqUXnaR+d3vL4vC6XDPB8OMJnBtrvCViETGNuhxMYhPhRqb0b7tVJx8u9VIsZNvxHw3xnTDCAoYLOw0TW/XyGWtIBXR1xqh6IdrNqBj/A86lqdbMHscfKY+hQJNRljk9vHnJJ6FVERDMkbug3gcIGnLKFyb0uWqgWGgY9TUBS7gbAQ0QEPo1xqG33N/348te4oXaaQ4h7qtMOdCLq5B5/SNl6xgaNJZK0a7Yy7U9AHW7yCcvq1/jip8uwyz2m6JRayQ2qHc5AJxxQW/69mKKnP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:33:23.4000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db4e07b-c3b2-42a3-3ed9-08de752ad9b7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5890
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-219793-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ti.com:mid,ti.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3461B1A5125
X-Rspamd-Action: no action

On 26/02/26 05:39, Jakub Kicinski wrote:
> On Wed, 25 Feb 2026 17:01:31 +0530 Siddharth Vadapalli wrote:
>> 	net_rx_action
>> 		__napi_poll
>> 			NAPI TX Handler
>>
>> It does seem strange that the 'net_rx_action' leads to the NAPI TX Handler.
> 
> For historic reason rx_action runs all NAPI, it's fine.
> 
>> However, it is exactly this path that causes the warning, and it is due to
>> this that we could end up in the following situation:
>>
>>                   CPU0                             CPU1
>>      -----------------------------      -----------------------------
>> 1. TX HARD IRQ Handler entered         NAPI TX Handler is running
>> 2. irq_disabled is set to true         Sees irq_disabled being true
>> 3. Calls disable_irq_nosync()          Calls enable_irq()
>> 4. Enters disable_irq_nosync()         [WARNING: Unbalanced enable for IRQ]
> 
> Right, but for Tx NAPI is only scheduled from the IRQ so this is not

But the NAPI TX Handler running on CPU1 at step-1 is a previously queued 
instance and not the one corresponding to the TX HARD IRQ Handler running 
on CPU0 in step-1.

> possible. For Rx yes, AFAICT there are paths in the driver which
> schedule the Rx NAPI (AF_XDP?). But Tx NAPI seemed to have only
> been scheduled by IRQ. And if that's the case the NAPI can't run
> until CPU0's IRQ handler calls napi_schedule().

Wouldn't net_rx_action periodically schedule the NAPI TX Handler? Please 
note the following:
1. The call trace shows net_rx_action scheduling the NAPI TX Handler.
2. Since CPU0 entered the TX HARD IRQ Handler for the TX Completion 
Interrupt, it indicates that the TX Interrupt was indeed enabled at that 
point in time. Hence, a previous instance of the NAPI TX Handler has 
already invoked 'enable_irq()' and enabled the TX Interrupt.
3. Given that 'another' previous instance of the NAPI TX Handler is running 
even though the TX Interrupt is already enabled (given that CPU0 takes the 
interrupt), it indicates that it has been scheduled by some entity.
4. The entity that seems to schedule the NAPI TX Handler despite TX 
Interrupt already being enabled by a previous run of the NAPI TX Handler 
seems to be 'net_rx_action'.


