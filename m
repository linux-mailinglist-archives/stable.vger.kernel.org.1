Return-Path: <stable+bounces-223486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAJuNQtOrmlpCAIAu9opvQ
	(envelope-from <stable+bounces-223486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 05:35:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8232A233B33
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 05:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63BA23006785
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 04:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC29283FD4;
	Mon,  9 Mar 2026 04:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CECfa9Kc"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011064.outbound.protection.outlook.com [52.101.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3467FBAC;
	Mon,  9 Mar 2026 04:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773030920; cv=fail; b=EA2RNr76OCB1VNdNPRtmx2ndY3grY6pYQqga9YEUy3P4C2WGze8lGkZpi/D2JQhzlWtFCp0gC1hfQ0//fwbI1ittL0ViXB5f+BokL9RRFtXJyCawTODhKQepRl5X7I+WkAUvEVCN7qnxfgS2bnMfyAtOs/PIlsLFGVyu+RURoRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773030920; c=relaxed/simple;
	bh=1MJFK95MG0ICryrLf7SYBNQ9q7uze1nfvR5+Gjctmyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pb0XKhyDoQZXRjYlNJDOXLEb8jad4sXRkEMOPvhQ4m8CxV2s5B3fEe7rG9iavK8Ao+F1znGMTyBrGbroqiI5iKjodmGTw2ZRD56ijXof2RlxlR3DoIJhcWqG9vy5BlMaVJSLw+TxeN/kgCdWTKtVquMf7WJ03r6KBA2qwkEZ85I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CECfa9Kc; arc=fail smtp.client-ip=52.101.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcXq7niSo/StjmZuZ7GUbxNvUtbWDDlRi8B8yqOSlysczOWsRs10Y36ttIWWl3IgDtT0XD6gjzYKRKuAU4kZM8449ud8CI/UYJxY3dstsDp1aYhIJ1CVlR5t1RRiaXyNWteGneghh+NVakbVAyz1Oun3t5krHfOIscmIwXMX6rAeeVTjJg4hdb7WD0VPdDKLaPtQWvTvK1jx9ln5JsVhC+PM2ua8ispKt4pMbUHFZACTEHh+7KxZ7qY7liP0j7Xxr/lcSQGeezocSYWx29nQmqONiUwuREznnJxmGfimsbo4hJ5w2WXg1U5o8VHQryJk73VQovjNH0okpRr5MKw+SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3E+EUAXtkii6IMzBDsPvOQS6R2JfkwNHrgvmoqSWRc=;
 b=gZ/xfQIdL4RZFQZZHU3Q2hExumXSLfXbHSknbNSer1yaIQbEWrKPYLizHFFUzxbwj9h7nxThPWNMPlvqPb9iJMtbi+5KQyoLRVXFbLjlLZAN5gb25dhwAhYN9A7hcr8GUifBtw1WBtSxvEZbiQE7aAyQoVjNwfZDIOYWLxX526MgkbxbPhPKRCcw9q0UNkhggINyqgBRY5mouNC0ip0Eq8h9XhNBPYzjk3B8BypZ/kxY7ufYoAL+OTzOIqY2gf0diysLzs/B8aIBdIBCOTIUyBAlIUDFgOdEvbfS+WzzqbpK+LbL5O2s2XAPSjlPbbYAF4+4jFxDq47Iu/BrOzCnaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3E+EUAXtkii6IMzBDsPvOQS6R2JfkwNHrgvmoqSWRc=;
 b=CECfa9KcD78f7E0PPzBoplMlkDA+lC2EqsuKSgNqby+V4AQeIZ5FPhIEZpSbUZFLFT5/PnXRPxZfPPoymDjXKgK8ChpSy4yL43Qn9/Ci6UhSEHHPayUAAa9sj5i/nQCyQ0bZXh7n1/BRWRL7wB6DZNtwsWeSuYZpJbPZf5FmHMk=
Received: from BL1PR13CA0167.namprd13.prod.outlook.com (2603:10b6:208:2bd::22)
 by MN6PR10MB8072.namprd10.prod.outlook.com (2603:10b6:208:4ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.20; Mon, 9 Mar
 2026 04:35:16 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::68) by BL1PR13CA0167.outlook.office365.com
 (2603:10b6:208:2bd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 04:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 04:35:14 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:35:14 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:35:13 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Mar 2026 23:35:13 -0500
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6294ZA1E389753;
	Sun, 8 Mar 2026 23:35:10 -0500
Message-ID: <baba390d-e695-4df2-adab-e76061a75601@ti.com>
Date: Mon, 9 Mar 2026 10:05:09 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Fix pinmux for pin M19 used
 by sdhci1
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Judith Mendez <jm@ti.com>
CC: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <stable@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20260212130843.1054100-1-s-vadapalli@ti.com>
 <0633e48a-27a3-456a-8b9b-32e88d417560@ti.com>
 <ebf6ad7e-cd22-41aa-b168-9b07f8387e62@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <ebf6ad7e-cd22-41aa-b168-9b07f8387e62@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MN6PR10MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: d6dba21a-6f7a-459b-087a-08de7d954239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	nFKLpRWv0SY1+xnUcZjF/XoaoHkl7hImPfTQ0pBuBRO7Y9txR17mvCD0zY5zoQiy3SWLdO8WSmGPUUTIBp5YgQy3kSWDh6/Yj4g6d20w7R8xncve0v7ecK00D4FpAdKkVatHAl8x57RwbGNqqr2vAqp+IEoJxlFeYKdEjthzLDiQSW5bMj8gJTRQGQKNdOwulrFC28CjpB5K9F/vjRI+QEsf991Aj4ScgfAd/xf5OxTovJAcooU6t9KbOl3LHH9lmMox0DEnuc8VpY4jWYJ4l536OPIYt8OYsBlzMMKhc3H45PQEYt/6zNnPLhToLl80F+6g+p4ELxjxIfglJkAMi6l42x3uqXa2vk6i9nv9zo6sA5jsXSR31bl9xdzN01eMNfv8N4poIl5h34BmeQsSM1NXTclMbaJr4vVEBILp3fX443a7C6+KKB9MsS5sg8H+XkokuXXGs5UF893/4UdEWoPgjFADf/KiJf7lVFYsghtl/OqIJ7qzjmraYg4u/nD9UYLWq8kyWA5mXfcKpAqkpEkAET5KiCT4GDCQFsTw8Qvmw4OnTvO/d6z0QJpYqkrcuQ3LDvXVx7slcGEtqVZbOu9zIgiGlpanFcghT23d85PyPplPrz4IBOEJTFwSmzCjDiyzbuYHH9JWtTN6VHA0SGhrVDK2Gs4HoSTE5727jSym7yNqU+te3bUn3x0kaEWuGhUaiYPbuDVi8xxefkB9wVGi6QWwqhmt4ZIhhAwgmYs=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iH4Lc0cv2pi6rWgvKZ32Cga3KC/553hLOWFCM1EXKE+wlXxpnVH4cqZmCgd1/dIhDn/vRZZnZpHJ8cFC+a7LLMfV7OGJ3jUJTC4gRbMMY3AQ5l7zXpjAZu5Yy3+tnkzqUsFf/mNvy5hcYHUvYqlMYjA8IhDH9Fhf4qag++N2oEGKqqqBcoZkY6u41rrCfabE+DJs4VbBGCV4HWHK02QGlvVtjO+6Fnwa0jBfLq/Jz+4/a3y6XUdqrqlXKMbnftHhw+2oyCTiTvAyea6wVJwPP0wsf9+uiwcGRCqzIW6ceDbEs7HDge3k+BPIb4BWaxMWHJWm+8syS7MkId+0uSqV7iGpUXEvLHsEPXjR0gu4ZswEnnaN3/sa4yhAfZ0hdG3/kQfQBWcD4C0g5d2+R7q530dSDEu19r3f5M5tcRyutUAnbIY+nE5ZGe/63883cdMQ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 04:35:14.6618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dba21a-6f7a-459b-087a-08de7d954239
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8072
X-Rspamd-Queue-Id: 8232A233B33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223486-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:url,ti.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vigneshr@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



On 04/03/26 10:24, Siddharth Vadapalli wrote:
> On 03/03/26 22:06, Judith Mendez wrote:
>> Hi Siddharth,
>>
>> On 2/12/26 7:06 AM, Siddharth Vadapalli wrote:
>>> According to the datasheet for the AM62Ax SoC [0], pin M19 has the
>>> address
>>> 0x000F40A8. Therefore, the offset to be passed to the AM62AX_IOPAD
>>> macro is
>>> 0xa8 and not 0x07c. With the existing incorrect offset, the following
>>> error
>>> is seen when Linux boots:
>>>     fa00000.mmc: deferred probe pending: platform: supplier
>>> regulator-5 not ready
>>> with the SD Card being unusable and the boot process halting due to
>>> the root
>>> filesystem in the SD Card being inaccessible.
>>>
>>> Hence, fix it.
>>>
>>> [0]: https://www.ti.com/lit/ds/symlink/am62a7.pdf
>>>
>>> Fixes: 8f023012eb4a ("arm64: dts: ti: k3-am62a: Enable UHS mode
>>> support for SD cards")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>> ---
>>>
>>> Hello,
>>>
>>> This patch is based on commit
>>> 37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel.org/pub/
>>> scm/ linux/kernel/git/netdev/net-next
>>> of Mainline Linux.
>>>
>>> Regards,
>>> Siddharth.
>>>
>>>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/
>>> boot/ dts/ti/k3-am62a7-sk.dts
>>> index e99bdbc2e0cb..9cfe7e7b317b 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>> @@ -398,7 +398,7 @@ AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15)
>>> UART0_RTSn.GPIO1_23 */
>>>       vddshv_sdio_pins_default: vddshv-sdio-default-pins {
>>>           pinctrl-single,pins = <
>>> -            AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19)
>>> GPMC0_CLK.GPIO0_31 */
>>> +            AM62AX_IOPAD(0x0a8, PIN_OUTPUT, 7) /* (M19)
>>> GPMC0_CLK.GPIO0_31 */
>>
>> What! I don't think this is right.
>>
>> Looking at device tree, regulator-5 is using main_gpio0 31 to control SD
>> ENA with PMIC. Which is GPMC0_CLK (N22 pad) and VSEL_SD_SOC. Which is
>> 0x000F407C address in the device datasheet. So as far as I can see, the
>> original address is correct and just the (M19) name is wrong. Did you
>> test this patch to see if that fixed the failure?
> Yes, without this patch I saw the following:
> [    2.108345] Waiting for root device PARTUUID=076c4a2a-02...
> [   12.261669] platform fa00000.mmc: deferred probe pending: platform:
> supplier regulator-5
> 
> Since the pin was named 'M19' in the comment, I corrected the offset to
> match that of M19 and the issue was fixed. So it seems that although it
> fixed the issue, it isn't really a fix.
> 

Refer to the schematics and not datasheet for pin routing. Please submit
patch fixing the comment to say N22

> Regards,
> Siddharth.

-- 
Regards
Vignesh
https://ti.com/opensource


