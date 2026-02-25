Return-Path: <stable+bounces-219587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKqkOlLdnmkTXgQAu9opvQ
	(envelope-from <stable+bounces-219587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:30:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9DC19682B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C18A53027E1B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E24335BBB;
	Wed, 25 Feb 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VYee9wS6"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7F30EF6D;
	Wed, 25 Feb 2026 11:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019024; cv=fail; b=Xwn2TvnZuG5a8tTv5rOZJBzBdlodnUXNJneLgZ7MaFE2menFO6H3LqmdjA9sUu0U0i2PEn8F9Zfv/9RtWrFHSNN69GuZjZO+keNlCoy6qUW4m7BuulzSifUE/2G78KbL2aqIpLJRDs8wtlC8rJXAXgw3Y26dnNr2l5PRWwnK8Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019024; c=relaxed/simple;
	bh=1A3bQG6kfFK4eYKDdyRnpmo3ZJp13lAt7XYYn9XKcO8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JsbYQYfOrQkN0cuxTSgIt6fEL4HuAztX3NVghSWYp3lNdme6vF393BsEFprWqWWXXnq8WLT609MC+70LLQX225gaIJmq4gC3/Ug9tfdFWzD3l5rppjO2wr5YP8YBoBZWUX6zVfWXqWU6hmSdnCZ7PuA9RAjDS7m9H/vhyzvlsVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VYee9wS6; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i++4MCa8engPMJvzu7jwwsGH12i0ZaYJKr5GGrSeFLh041L1kvdqNBoaQuptD7SEJahjPhorzkUKZ19rNO4bPWkMtw9fUkrlmRETQcTzJq1IuvCpibq78RP1K2lqjPYZ+GRgGenCU24b7YsvBauMw/sBXoYdf2xnlTfrrzokuVImRfu1i7nwqWEkgnJSINm1/DR4a+w30P6rZ788y+0kDAfC6RkcQcmpW7+AejzgTz+PES8Qx5TCA5Fx+dd4UCV73bkdmk9CyiKRo0t5JlByAtCBbsSOal8vj0LH/+9fE5dGyM5XPwD+byfFEu9eeq9Vbn3mO8oyLNoYan5hrL/M/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIcjRkgDXXZ21fzpUwT34Kz0T0NXfaHGRqAWvD2CI+o=;
 b=wPiigvNvj1HaxZcBW8BwojNdrKqZwIqOqjbv5/OUTFeAYyeY9EqcUXk8tLXME9XQwpxcrmJkYDMy6YskNna+5N/c1GCjXdItpi28rr2FgSJU+b5besJQwvNeQqtYp9/j1IchH8/oSGAhJZDI0SzAsJQsY6QhPKTsXXSVIPBwVfrBQvbTf3kYiaKG9jG0c/zDaWX1MIP5IIqutXlYTTrK3j4keVa+m+b017nxLk30m25qfcmw1v5QLg1GJ0794VuX9OUOj2hiEJYyD9/KNAphASy1grWyNHVXNPKlRBx6dtG/ESl0VrwUrqAPB4XzPDltOK1Cn7I5p7HTW4WsJbR84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIcjRkgDXXZ21fzpUwT34Kz0T0NXfaHGRqAWvD2CI+o=;
 b=VYee9wS6REKazjzTl3QX7CETfSXHR3PlvZ+ejTawK+7JNgBE32l2vT4HWDeylNxfIAxZr69bogOjR1n3dPMvaEbe2bOe7wagq5vCQzwquF5qLhjfx/SdcstyRSRN/MA32LUxAyDdMMquClYItTRz1rXkkWQ9AafI1985NrHQPNc=
Received: from MW4PR03CA0007.namprd03.prod.outlook.com (2603:10b6:303:8f::12)
 by DSWPR10MB997826.namprd10.prod.outlook.com (2603:10b6:8:36e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 11:30:17 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::ad) by MW4PR03CA0007.outlook.office365.com
 (2603:10b6:303:8f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 11:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 11:30:15 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 05:30:07 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 05:30:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 05:30:06 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61PBU1k64060009;
	Wed, 25 Feb 2026 05:30:01 -0600
Message-ID: <be80263f-667c-4330-bc24-5078fe07b994@ti.com>
Date: Wed, 25 Feb 2026 17:01:31 +0530
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
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260224154953.63b558c1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|DSWPR10MB997826:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c66ef88-c5ff-4160-11de-08de74613f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|34070700014|36860700013;
X-Microsoft-Antispam-Message-Info:
	Q/KWWsiZtI6c8XlZ3Th+YENMCjHuZiOTw31tUfjz8z7HzmLWzQ2ZVUDtNUX0DDStAUpXkaWx5BeWA6RQvAv+h6vbZDXQDIgR4Rv3B/kxDYdsBG56soC2TM0a1/QDz1RUCZ2t6BjbswMvlLFFNbrzeb3y82Dt0HcL6E0Fre4/t71gI/EICTX3pcgtvsBwmjttnYrMBxQCImI40XtkStpVjRXR87FSQMdv7LdUXUnmjKQowR15hScKbqOgBBcvP8OCCw0m9drFdFgeuTZrDE7QyOP4+PTpfJIs5h2oA1AiqA2cYCaGASOp+T5BrZx9JM7p7x9rckO8WBapJJTcGcN8yAIxE95AxUrP+2Oit7WaWwUt+U6ECCmCUtGbnr/QjKoiYe3Jr9pwc5KUyQbXQTh41l06vdlX5LGzBSbZi2S2Efw+nCHFL0QlEZ7bLk1JdFXpFUcGPNY8BBt/Vqwil3QYdmHLM1qinFGPQsF5VKLwzopdAiMDsKEKKbInI2k/Lj4hZ4X0HdCt9NaPTsNk1jpfTVMIhAC0M5MbJZDCe2MtCuS98Cg4xmcHPA5EB1FBJJJM8vd88GL82Lo4O+afNGcnUrv+Hy1OzVfXpREIv6YiMp2NkoQomrFOngZiwxSh0dksq0z5SG02VtMv21FAN8SEIEP+gOdLHiAEd6qEAC7hXU6Awf6wMOgL/DxIy8xsQYj3HuHU8/xvNhBcpI8YHKiidU4w2Ra73WGwLd695M+sNG0JHvKbsRYXSpiEvfzTvs1hbug2kfXnk7fWZSlfsEiEXIRo+pMQqQEVa/prosvg+95o0CaDYJ6TnCbq3XLte44icmC/WTHOz2cF5fnYbCfqUA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(34070700014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CvoVt9bcxwyZoUPsHFh6TwdNrq3UnR942LAbiD6i56a8leDz6Wp+7wFKEIPf+DgdQ1wPlGRVRjaD97yuzlpp68DeQaPM2KURKmLW2VNVgNI7Q9Vxnm161KGY2Zmo79Fct+tt635HAiIsD57SSF1Ck201MiHem6v5sGG14GyiC7LwKdAWy4LPdL4mDd4ivqJTxPCvWgntoTz4CeDq5PwghVSLuAVbYhsax3cjjbQHZBUHE+9K9zDz8qU9B4NsjfAAjtJW70CP8PIBiIKsGIcloR0QNlW4YIKjelWFUUh7zeIQ4YJOqpmQEGER1pdnExjLyIUmmDU75XkgAxVe2122ZzojfKMMuRke8XiQ5rh61uHPSUhMDGUtEfKFBr4XOVy6nuA2euOttfHL7vj/ngIwtxpdH3WCJiTYjxPW3zabj1jcZBNnPiaDTdCOW7/W0YY+
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 11:30:15.6814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c66ef88-c5ff-4160-11de-08de74613f70
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997826
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-219587-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8C9DC19682B
X-Rspamd-Action: no action

On 25/02/26 05:19, Jakub Kicinski wrote:
> On Tue, 24 Feb 2026 17:54:18 +0530 Siddharth Vadapalli wrote:
>> 			CPU0						
>> 				CPU1
>> 		----------------
>> 								--------------
>> 1.	TX HARD IRQ Handler entered				NAPI TX
>> Handler is running
>> 2.	irq_disabled is
>> set							Sees irq_disabled being set
>> 3.	Starts executing disable_irq_nosync()		Invokes
>> enable_irq() for TX IRQ before its really disabled
> 
> Could you resend your last email fixing the line wrap issue? It's very
> hard to read as it arrived on the list.

I have changed my email client now to fix the line wrap issue. Sorry for 
the inconvenience cause. I am repeating my earlier message below with 
proper formatting. It is in response to the following statement:

 > AFAICT the flow on the Tx bug is not buggy, owner ship of the IRQ
 > vector passes handler -> NAPI -> timer. I don't see how those can
 > race.

The issue is seen in practice. Interrupt coalescing (hrtimer) isn't used.
The call sequence leading to the warning is:

	net_rx_action
		__napi_poll
			NAPI TX Handler

It does seem strange that the 'net_rx_action' leads to the NAPI TX Handler.
However, it is exactly this path that causes the warning, and it is due to
this that we could end up in the following situation:

                 CPU0                             CPU1
    -----------------------------      -----------------------------
1. TX HARD IRQ Handler entered         NAPI TX Handler is running
2. irq_disabled is set to true         Sees irq_disabled being true
3. Calls disable_irq_nosync()          Calls enable_irq()
4. Enters disable_irq_nosync()         [WARNING: Unbalanced enable for IRQ]

> 
>  From what I gather you're concerned about the case when hard IRQ and
> NAPI run in parallel. But I don't see how that could ever happen for
> Tx (there are some complexities like netpoll and busy poll but those
> will return false from napi_complete_done()).

Weirdly, net_rx_action() is leading to NAPI TX Handler.

