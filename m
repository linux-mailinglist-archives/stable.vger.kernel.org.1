Return-Path: <stable+bounces-244491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDQHFjAO/GlaKgAAu9opvQ
	(envelope-from <stable+bounces-244491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:59:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DDA4E2BE7
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B26843015890
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 03:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92BB312815;
	Thu,  7 May 2026 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zs0KUFgD"
X-Original-To: stable@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010005.outbound.protection.outlook.com [52.101.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7D30EF84;
	Thu,  7 May 2026 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778126376; cv=fail; b=p5O/vg77fwLy2qER+3hL5N0IyR+og/BiFXRxD4hcHTSIee91LMM91lxLDYuDi4hmb16QcYQ2xRY1CueQu9CNkb9NlvjkMO6jeFRtXsMJoST5+InD3QF+6re3EOjx/l3AnvMnnPk7gIB/ivLgQFchI6SEAFmFLYjRS1EpM/jZaX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778126376; c=relaxed/simple;
	bh=woZuMfWi/WLbMtToM3KUxMl30ZPuY0cOQTUWHZ6LMaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pySiFbZ3CBNs9Anl2QPIWR+/JNVcAU+Bn09rK1c3WfLf1pnlIJxUTtQGEnxTew7SRRLcAKFGUGbCYbypDMmQPQCzLx8mvw3kYGjpB2dg37BcHeFENSq/L8d6lUYgOyG0XG5IGYW4GMBuLOkYsE1BMe4B8hOj/ys5JmHYSaT30+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Zs0KUFgD; arc=fail smtp.client-ip=52.101.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlAy9NwatMejnYMaDadnFZ4ObPrQe2OIzsj7JYxePRQ/Fre9reJBB39aCaDGAV35UV4/AtRjFjXv5nscvAGH2flRjBriMPlCuOJROYg7CVAK76IKaNZ73ydZhsYYsPpn6JG3+vRg9Dtj9Yex+kS6Zze0MVzK1f6p53mA4mkTSgHe6VaidZjh9eAuEl99ZyP9k3iBWhbsJlvTEG6qXpQGj+29zvuVhlh1cNwQgBbCtJ+Bycj8MkuTl0fBuXcsZwM1D4WQ/H+xWS0H4HUErerBsiIqEpiTl8iYzjNuoxK8HEs7PZ31LBc8bA1pdt5ZZflgLZes0E8c+8eEVit22RYGAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZQFEwGWEejZnIjR16srvUHLZyDzW48Tun86OyBW5Vg=;
 b=P0ka/Uo0xg4fH4V2N6KS3Gux/P0PAVEn64qnf39J16BijmdL8eRnIkEjdOz24+PxKmjFWa4nx6MYailV9a1e5tX5aYNZ5TdCN0dJDwiBQS26YmLRB3QAo6l+hhaB/1WrBVJEQkBwIBNULIZRjY1r/pDY26FOW8dp5gm/FjsITEFwL+pFI8T2w4LD2nmCyJ3eOyIwr+ndlQBUIETO+1WRO5d0AHnHQU10+w2vTVn2GKoLvgdhF1PHuyrQDkRbAeHUgCEtjbQi/nE73A/nX9Wck6J1z6DsgSiZMEVm5+4CJ1EjFEfBDbm6VyWHLo0hNWFMErTdc9aFsvxSTITQ3LAXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZQFEwGWEejZnIjR16srvUHLZyDzW48Tun86OyBW5Vg=;
 b=Zs0KUFgD3xjpagyBqrLGlmYyQRZuhxhI4rK+fduMy+L7Osmd1PFeZ4IqgugUC1DKhJXkwdOabmgPJrQVd/WWq5RdjtLcOGewKlUYNlgQJLKjZfTMydEqE/upETpBoqKltZc6wQ5nYE7YukWWUII1SkrMVtfjIE6SP0oIi+/pYaY=
Received: from DM6PR06CA0069.namprd06.prod.outlook.com (2603:10b6:5:54::46) by
 DS7PR10MB4942.namprd10.prod.outlook.com (2603:10b6:5:3ab::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.15; Thu, 7 May 2026 03:59:31 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:54:cafe::ff) by DM6PR06CA0069.outlook.office365.com
 (2603:10b6:5:54::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 03:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 03:59:28 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 22:59:09 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 6 May
 2026 22:59:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 6 May 2026 22:59:09 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6473x4RY2782454;
	Wed, 6 May 2026 22:59:05 -0500
Message-ID: <4cd95d07-302c-4572-990b-e054d6d0d7d9@ti.com>
Date: Thu, 7 May 2026 09:29:04 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pmdomain: ti_sci: re-sync TIFS with genpd on resume
To: Sebin Francis <sebin.francis@ti.com>, Vitor Soares <ivitro@gmail.com>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Ulf Hansson <ulfh@kernel.org>
CC: Vitor Soares <vitor.soares@toradex.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, Kevin Hilman <khilman@baylibre.com>,
	<vishalm@ti.com>, <d-gole@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
	<stable@vger.kernel.org>, Kendall Willis <k-willis@ti.com>
References: <20260427074808.3244226-2-ivitro@gmail.com>
 <1fb0739e-b84f-42f1-9c96-88b5cc5866a8@ti.com>
 <c0fe43a2339c802e9ce5900092cd530a2ba17a6b.camel@gmail.com>
 <17cbaadb-5aa7-40f4-848c-ba8e88fbd333@ti.com>
 <0cad7e5e41b9e2c6ec545050dd0d3c6b3e085d2c.camel@gmail.com>
 <bb80889e-0b25-4ea0-b895-83c2b1683272@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <bb80889e-0b25-4ea0-b895-83c2b1683272@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS7PR10MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: c1395ffd-8b53-495c-7c1f-08deabed0973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	n0D1hviRSuXX4u7YX9W3IB/OOqMcDpUHMrSb9T9FndqK4QJitwJsP8iYT8ib6klU6lgqeOmbd84MdQw3DiuALJWDBry4eYqSUVt4PHBkftTj4EtXfoOvXJVm94HbjtFyefuF8OdW+iGw/FLkzEWT1FhUbf15SAAGEJE3YXZ4NKe88UXh9ldKD5c69qO0oS1qeOs1lVJRr6JlhUct0gFrZpX9nnUFVypQi6OacedArkbp0N/6fwclrGGbwqN7cNRktLhEDyrMfqwSH+awWUQm/wdCYmahkridyeASpY0RZu6R4MDuxtfoJJQMVwIHCqT28q5Ekskttezx0L0d7aRJ3Ngm9WjRRdb6qbQto1EeKihdzBxU14bMSZFvw8OB2dIYm+e2e0LvkVNr5yNwYi9oLeMQ7TFMGR3gP/3LJDL7e7Va8Ia8owzlHpRm54IP/A0eKsI9tv4S5omkRcEDuxWYfvO5om+LrzxbXTUEgKHOiOuyBYdUc2+JLj2imuZK3zXQuYPILSLvrmz40h4UWMF3rJcnK9ng+KLZ7UXxQLE+1UJOitG/dCYo6smEFKq5pFf1l7aErWxAiKFUMY57dn6gjM/iMMo2JwkRLBijBJNrAxKOJUbxE5l/03ohKDEjoMxEaHqtouVS1Tsfmq3fq/MTWuu4O2T700WKQtjQXhnWX/QlFfp//UVgsQkYHC5eUCO/B0tdPtyBXFVieQClyX3JFi3+WUwJM0hPi4uyYUgKAjg=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4St4tFo7+IArMXDBcgU1twtDODBiRkQZSx+V/suFuauPHLrkhFBqHf2pk5jXsilD56uXs9w1YyvrWaq2CSPtJNq3yGmIOQHj08/O2jyGkRO185pi1a7nuYXWQRRZHFmmhnEotoL1wc+IhnuoPpQ9C85Z7LmnawsJ2AX4jW912moic1w77k7h90yC2Fm1KkMaDUgSyAeXkfE2QH4P6Dl+b3toBIyS1EK0ajzRMq5o0HSpjg5xLOrN41frM+fcrzPP/uYlq9bBH+OFFI0S3hXqRMF/DPfRYU2tF8HhY9Qmc0jXb6Y03QRYSvNHc/scy9Gz6ZPGGvYie9sOYV1hAGozcv+RVL6ctEQ92Uwlhxc/2t8PmVIqCf+KqqC3+8PFM1LPPDk2fJ4OynvuJOmbxDROtP6nQCF0lG8R94Ym4ZDjW2d1jfTEvM2Z7OHsUOr11Rn1
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 03:59:28.6390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1395ffd-8b53-495c-7c1f-08deabed0973
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4942
X-Rspamd-Queue-Id: D3DDA4E2BE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-244491-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:mid,ti.com:url,ti.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



On 06/05/26 19:56, Sebin Francis wrote:
> Hi Vitor
> 
> On 04/05/26 11:56, Vitor Soares wrote:
>> Hello Sebin
>>
>> On Thu, 2026-04-30 at 16:17 +0530, Sebin Francis wrote:
>>> Hi Vitor,
>>>
>>> On 29/04/26 21:56, Vitor Soares wrote:
>>>> Hi Vignesh
>>>>
>>>> Thank you for the review.
>>>>
>>>> On Wed, 2026-04-29 at 10:03 +0530, Vignesh Raghavendra wrote:
>>>>> Hi Vitor
>>>>>
>>>>> On 27/04/26 13:18, Vitor Soares wrote:
>>>>>> From: Vitor Soares <vitor.soares@toradex.com>
>>>>>>
>>>>>> When a device in a TI SCI power domain is on the wakeup path of a
>>>>>> wakeup-capable child, the suspend path skips genpd_sync_power_off().
>>>>>> No put_device is sent to TIFS and the domain's genpd status remains
>>>>>> ON.
>>>>>
>>>>> Correction of terminologies: TIFS is Root of trust component and is
>>>>> not
>>>>> usually involved in power management, that would be DM (Device
>>>>> Manager)
>>>>>
>>>>
>>>> Thank you for the clarification. I will address this on v2. Also, I was
>>>> thinking
>>>> to replace put_device/get_device with ti_sci_pd_power_off/
>>>> ti_sci_pd_power_on
>>>> if
>>>> that makes more clear the content.
>>>>
>>>>> But to be really sure who is doing what, Could you provide an example
>>>>> and the platform on which you see the issue / external abort?
>>>>>
>>>>
>>>> This was reproduced on our Toradex Verdin AM62P WB and the driver
>>>> for our
>>>> Wi-Fi
>>>> module on the SDIO bus calls device_init_wakeup() during the
>>>> initialization.
>>>>
>>>> After enter in suspend, it show the following error resume path:
>>>>
>>>>
>>>> [   41.759341] Internal error: synchronous external abort:
>>>> 0000000096000010
>>>> [#1]
>>>> SMP
>>>> [   41.843286] CPU: 0 UID: 0 PID: 933 Comm: rtcwake Tainted: G  
>>>> M       O
>>>> 6.18.21-dirty #3 PREEMPT
>>>> [   41.852762] Tainted: [M]=MACHINE_CHECK, [O]=OOT_MODULE
>>>> [   41.857891] Hardware name: Toradex Verdin AM62P WB on Verdin
>>>> Development
>>>> Board (DT)
>>>> [   41.865537] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS
>>>> BTYPE=-
>>>> -)
>>>> [   41.872492] pc : regmap_mmio_read32le+0x8/0x20
>>>> [   41.876941] lr : regmap_mmio_read+0x44/0x70
>>>> [   41.881120] sp : ffff800081fdb8e0
>>>> [   41.884428] x29: ffff800081fdb8e0 x28: 0000000000000000 x27:
>>>> ffffa95bb64aa9c8
>>>> [   41.891563] x26: 0000000000000000 x25: 0000000000000000 x24:
>>>> 0000000000000000
>>>> [   41.898697] x23: 0000000080000000 x22: ffff000002df5c00 x21:
>>>> ffff800081fdb9b4
>>>> [   41.905831] x20: 0000000000000100 x19: ffff000001286400 x18:
>>>> 0000000000000000
>>>> [   41.912965] x17: 2d69696d67722f79 x16: 687020726f662067 x15:
>>>> ffff00007fb74f40
>>>> [   41.920100] x14: 00000000000002ea x13: 000000000000031f x12:
>>>> 0000000000000000
>>>> [   41.927234] x11: 00000000000000c0 x10: 00000000000009e0 x9 :
>>>> ffff800081fdb7a0
>>>> [   41.934368] x8 : ffff00007fb6ce00 x7 : 0000000000000000 x6 :
>>>> 0000000000000000
>>>> [   41.941502] x5 : ffffa95bb57948d8 x4 : 0000000000000100 x3 :
>>>> 0000000000000100
>>>> [   41.948636] x2 : ffffa95bb5795034 x1 : 0000000000000100 x0 :
>>>> ffff80008025d100
>>>> [   41.955770] Call trace:
>>>> [   41.958211]  regmap_mmio_read32le+0x8/0x20 (P)
>>>> [   41.962655]  _regmap_bus_reg_read+0x70/0xb0
>>>> [   41.966839]  _regmap_read+0x64/0xdc
>>>> [   41.970327]  _regmap_update_bits+0xf4/0x140
>>>> [   41.974509]  regmap_update_bits_base+0x64/0x98
>>>> [   41.978952]  sdhci_am654_runtime_resume+0x138/0x208
>>>> [   41.983830]  pm_generic_runtime_resume+0x2c/0x44
>>>> [   41.988445]  __genpd_runtime_resume+0x30/0x7c
>>>> [   41.992804]  genpd_runtime_resume+0xdc/0x2e8
>>>> [   41.997073]  pm_runtime_force_resume+0x68/0xf4
>>>> [   42.001517]  dpm_run_callback+0x8c/0x14c
>>>> [   42.005439]  device_resume+0x11c/0x34c
>>>> [   42.009188]  dpm_resume+0x178/0x1f0
>>>> [   42.012673]  dpm_resume_end+0x18/0x34
>>>> [   42.016332]  suspend_devices_and_enter+0x4a4/0x668
>>>> [   42.021123]  pm_suspend+0x170/0x2dc
>>>> [   42.024610]  state_store+0x80/0x104
>>>> [   42.028096]  kobj_attr_store+0x18/0x2c
>>>> [   42.031845]  sysfs_kf_write+0x7c/0x94
>>>> [   42.035508]  kernfs_fop_write_iter+0x130/0x1fc
>>>> [   42.039949]  vfs_write+0x200/0x370
>>>> [   42.043351]  ksys_write+0x6c/0x100
>>>> [   42.046752]  __arm64_sys_write+0x1c/0x28
>>>> [   42.050673]  invoke_syscall.constprop.0+0x50/0xe4
>>>> [   42.055378]  do_el0_svc+0x40/0xc4
>>>> [   42.058691]  el0_svc+0x40/0x15c
>>>> [   42.061834]  el0t_64_sync_handler+0xa0/0xe4
>>>> [   42.066015]  el0t_64_sync+0x198/0x19c
>>>> [   42.069680] Code: aa0603e0 d65f03c0 f9400000 8b214000 (b9400000)
>>>>
>>>>>
>>>>>>
>>>>>> TIFS powers off the hardware during deep sleep regardless, since it
>>>>>> was never informed to keep the domain active. On resume, because the
>>>>>> domain's genpd status is ON, no get_device is issued. The driver
>>>>>> then accesses registers of a powered-off domain, causing a
>>>>>> synchronous external abort (AXI bus error, ESR 0x96000010).
>>>>>
>>>>> Hmm, if something is wakeup source, I would expect even TIFS/DM not to
>>>>> turn if off, else module wakeup wouldn't work.
>>>>>
>>>>
>>>> I tested UART as a wakeup source and I couldn't reproduce this
>>>> issue. My
>>>> understanding is that UART has its own TI SCI domain and
>>>> device_may_wakeup()
>>>> is
>>>> true directly on that domain device, so the set_device_constraint fires
>>>> correctly and DM keeps it powered.
>>>>
>>>> Here is my tracking of the issue:
>>>>
>>>> Wi-Fi driver registers as wakeup source:
>>>> device_init_wakeup(mmc0:0001)
>>>>
>>>> During suspend/resume.
>>>> dpm_suspend()
>>>> ->genpd_suspend_dev(fa20000.mmc)
>>>>      ->ti_sci_pd_suspend(fa20000.mmc)
>>>>         ->ti_sci_pd_set_wkup_constraint(fa20000.mmc)
>>>>           device_may_wakeup(fa20000.mmc)  = false
>>>>           set_device_constraint never sent to DM
>>>>
>>>>
>>>> dpm_suspend_noirq()
>>>> ->genpd_finish_suspend(fa20000.mmc)
>>>>     ->device_awake_path(fa20000.mmc) = true
>>>>     ->GENPD_FLAG_ACTIVE_WAKEUP = true
>>>>       genpd status = GENPD_STATE_ON
>>>>       skip power_off (ti_sci_pd_power_off)
>>>>
>>>> On deep sleep entry, DM powers off fa20000.mmc independently.
>>>> It received no set_device_constraint nor ti_sci_pd_power_off.
>>>
>>> In AM62P fa20000.mmc is part of main domain. During deepsleep the entire
>>> main domain is turned off by the DM, that is why you see the failures.
>>>
>>> In-order to debug this we need to check why pd off and pd on call is not
>>> getting called for fa20000.mmc during suspend and resume.
>>
>> This is an expected behavior from genpd. On suspend,
>> ti_sci_pd_power_off is not
>> called because genpd_finish_suspend() takes an early return when both
>> device_awake_path() and GENPD_FLAG_ACTIVE_WAKEUP are true.
>>                                                                 On
>> resume, ti_sci_pd_power_on is not called because genpd sees the domain
>> status
>> as GENPD_STATE_ON (it was never cleared) and skips the power-on entirely.
>>
>>>
>>>>
>>>> I attempted to fix this by calling set_device_constraint when
>>>> device_wakeup_path() is true but it prevented the system from
>>>> entering deep
>>>> sleep entirely.
>>>
>>> In AM62P the DM manager selects the low power mode to enter based on the
>>> constrains set. The mode selection logic will ensure that if a
>>> constraint is set on the device, it will select a low power mode in
>>> which the device is kept on or can wake the system up. the MMC is part
>>> of main domain and there is no low power mode in which the MMC can stay
>>> alive or generate a wake up interrupt. so when a constraint is set of
>>> MMC, we cannot enter any low power mode. that why you see a failure.
>>>
>>
>> This is consistent with what we observed. I am open to suggestions if
>> there is a
>> better way to handle this.
> 
> We looked into this issue and found the root-cause. What we have
> identified is that, there was bug in our ti_sci driver. In ti_sci driver
> we were not handling the devices in which the child device can act as a
> wake up source, we only handled the cases in which the device can act as
> a wake up source. Kendall is working on fix for this. soon she will post
> the fix.
> 
> With the fix, if you suspend it will fail because the wake up is enabled
> for the WiFi, as a constraint will be sent to the DM firmware and DM
> will NACK the suspend because it cannot suspend with WiFi acting as a
> wake up source. But you can disable the wake up of WiFi from the sysfs
> entry and try suspend then suspend and resume will work.
> 

To avoid above and still have wakeup from WiFi supported (if needed), 
this should use IO Daisy chain as the wakeup source and not SDIO 
directly (MMC IP isnt capable of waking up the system but any activity 
on the IOPAD can wakeup the system (similar to Main UART)

https://software-dl.ti.com/processor-sdk-linux/esd/AM62PX/latest/exports/docs/linux/Foundational_Components/Power_Management/pm_wakeup_sources.html#main-i-o-daisy-chain

[...]

-- 
Regards
Vignesh
https://ti.com/opensource


