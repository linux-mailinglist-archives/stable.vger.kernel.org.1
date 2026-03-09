Return-Path: <stable+bounces-223488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJyFNvpSrmkMCQIAu9opvQ
	(envelope-from <stable+bounces-223488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 05:56:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0C8233C83
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 05:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1A643012C8A
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 04:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9E42D321B;
	Mon,  9 Mar 2026 04:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SlfUhn5m"
X-Original-To: stable@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55426B2CE;
	Mon,  9 Mar 2026 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773032180; cv=fail; b=BzE94bBzDKjuL6v5weYDVAInJwZDuUy4wVS3POYVCR1oO46gvDNMnyA6sCshie7SBrBzazTUIyPiZKdJ3GiMmU820Ndd2B4+CTrucpqg/Pzm+cLaJ7pkvBsEX4yorgQakaRdB+kV5XTC19HUW6mV/HdDypr1h5cqp5I91Jfue/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773032180; c=relaxed/simple;
	bh=LvU8xs299pLyON/VH7FkC1rljZPGao3yERFLnfhMYt4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KF0Ilf/7mf0rzdcBvp06whosxz2cqFx/vxhTyTsE7xLlwZyh8kvCfxFond3pkRY3StiQaF0cL+ASodSHbaJnv19ghssFkX+m3tbsBfn3Pr3YXhxXXHr/bt83YkGyh5ZE3YwlCjJZkSCNlL7s3ykEA0D//Kx1yFhRS14Ilgq7/EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SlfUhn5m; arc=fail smtp.client-ip=52.101.48.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeaWxjD43OCu1GodHwNHg7k0JjkmLUv/tXzyONZPyFtyuWAlI+Jtt3ESbBjzqtwZ3gXwrjLnuwobQEwM8F+6HiTZ26VLR00N7whmeUMK9EZa067ZveyY3X8BeGM9aEIzSaZg1EHhJENnG4ObFu2suVAG1pmBd2eHfogDtRvyZS/72aRawJfaURGJQ+Ymn0aErlpJTjIdDDXwmJArV55Kn5jJhVvkuF/BPrIhdYLZMyd9Fr1++Pg1+tdGERCYz3eKHx3wBd0eO9fJ5rqOfB9mTJh9gDnrtuOQEo8qsYsho3AdQ71DOdSgFY9gca7gyvx8xFpd/U19QvRJTqL19bx1QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yN28b/yUakql1dNxHOqRv+cf8EQsleCrn08EGd46sCc=;
 b=HIvtFXcKKdnoCTSMa99UXtH3ZSwmGJCxLbDpQPXXD2Jw33bmQFhLyYleEWR4qR6CRwppupBVAi408VT3kHfF4CkUNwkeGd0iiGw7ctDhFiRVyYrNPqSbiQOlrifSbQ5zBI0szoxBiH3XGozAthWVd0iQEeVdPHWtWcs+1+AWWO0/oC6OwfoaCFSXLMwCmnqNA529nPk2UVrs0oCnyRE72Y7Bjwz+a9eryR9JYnWM4hBcZdSg4l+01N8JWF889bs4dH90ncuOv9CyPPqfqcYuNNHIRaYXcglVWfzaybwn1tXtkYUOWbxCBmJl2MADKJyHnOOc6cdV/egoILoH41HX5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yN28b/yUakql1dNxHOqRv+cf8EQsleCrn08EGd46sCc=;
 b=SlfUhn5mc0hfYj+deHY32FENlUHgHKLnCC3wdEUqLb4wbPqnkI/L1odR8++Bwxyt6KgTmhZb3l7WkXXZXMit5DWd1pD7SwfUxBekQHOetdXHKHjgGL4YCwix2+eha9o0AoD/Dd0MPWc2eMJ4LjeymGsUxHS2nOAhZ049VyVlwEI=
Received: from BN9PR03CA0115.namprd03.prod.outlook.com (2603:10b6:408:fd::30)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 04:56:17 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::6c) by BN9PR03CA0115.outlook.office365.com
 (2603:10b6:408:fd::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Mon,
 9 Mar 2026 04:56:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 04:56:15 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:56:14 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Mar
 2026 23:56:14 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Mar 2026 23:56:14 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6294uAP7413614;
	Sun, 8 Mar 2026 23:56:10 -0500
Message-ID: <677ef6a4-7825-45d1-a4ad-a5722e0d01c3@ti.com>
Date: Mon, 9 Mar 2026 10:28:01 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <stable@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Fix pinmux for pin M19 used
 by sdhci1
To: Vignesh Raghavendra <vigneshr@ti.com>, Judith Mendez <jm@ti.com>
References: <20260212130843.1054100-1-s-vadapalli@ti.com>
 <0633e48a-27a3-456a-8b9b-32e88d417560@ti.com>
 <ebf6ad7e-cd22-41aa-b168-9b07f8387e62@ti.com>
 <baba390d-e695-4df2-adab-e76061a75601@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <baba390d-e695-4df2-adab-e76061a75601@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|PH0PR10MB4616:EE_
X-MS-Office365-Filtering-Correlation-Id: 987ea973-e614-4bcf-3a72-08de7d983196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	AAd9QEO0c63Oi7J5fHq3DEJ6fcoiHLbhSzithJKRRBzT2OcyDocDvtb9h9z1cRG50mHkT1P7gZ64OvT7hvzzRUOBM/AloxY0D9mdCQT4oCZ8RoYsipy2Tn+CXArkgORM/cnzM//udH+obLaVIFauSlfUOqJe2s8MtaZJfOl1Qt64Yqm/XRim4Z5/F/kxI/+vdqolJzR7CtNIS3vivUPkEvv/HlxKTYer4hzkfqye7DTLdzgd9YI23Z0nTS4XmpHbyhe/x/F932wV2OaF/7D1lvE+9Y6H7kCnx+iJC1yf+Dxuxt/mG2o7b+oaSeOAkVYBl670gNbGO0YhtsRNYc/HYIe2fYt0F8CpnkDi0Wb9iqs5PSnVFU7c/EBP1RyGrsGxkJx+D/BOaq3Wcc4oXPaOjHSQjeSBLUoNKKhSpkZNhS/EH149HFJ4lyFyL6Ug/ZJrceKCN2yh3YqijkT4OzoDjs5cEpm1zSFm/3BDuEzddLmU1FZZyVhko4d83s3bBd32gTYKL+a55CdP/BWGZcsPKKuI5VG1A6ODNirGRGCc0IyQ1A4NrPK5nIkw4+J/MWqGPDEy9/R/RaqhVov8CgfjIdzQY0T/1wnGaLqeTQvgJGbzh1KyMLhB0NFHEOxddeVmBhXXK0fCQl5pN7Zgl780ZlJfrVLJyIF3465j5A7X+8Pvk/dePKBfP0zML5TyymiAlo7os/QlmbQETfi7umOl/wqbV/W8JLiD72BamLSqHHU=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	d1NwJdMDzBvt8rYa0FHBcjyFPWFM/HewPhxCQa3P5Aruf+ajRSQNKJpSk2s3MihTukjbKO4tckDFo4+auovPd+L76kjC7RUPu3ujUpw1EKed486qHpIrmrZ2Pm6cYRMMCM1a8GZi7So5ufK53XOcekqtKy3OEkFS5u1Om3jDpOCqSg9NN32hZoV41LG/ZIUA8o4w3i9J/4GTkzWM6iO7Zc9/7JHtczlO5qEfvfYY8bu0/LhD8VC38F1Q1iejh/NXBAi8TCKGH8Ym4vhRdeFJSHpJWbRU44lal/ZgV3mpgpnls8jwzbM6BAunljxcYo1QLzr/jfPNbU6JGk3Z6tTYcRzd9eDFH49G4DKW3cLWT+SAM3cJY/JnAcVIY9dBYESZMnuJyww0fnvIoao01TXEZ3J+KAoDjsjJ/s/NjWqs1r/nY+WP5e0BeDwbOWSRN5si
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 04:56:15.2490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 987ea973-e614-4bcf-3a72-08de7d983196
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Rspamd-Queue-Id: 5E0C8233C83
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223488-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ti.com:dkim,ti.com:email,ti.com:url,ti.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.967];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 09/03/26 10:05, Vignesh Raghavendra wrote:
> 
> 
> On 04/03/26 10:24, Siddharth Vadapalli wrote:
>> On 03/03/26 22:06, Judith Mendez wrote:
>>> Hi Siddharth,
>>>
>>> On 2/12/26 7:06 AM, Siddharth Vadapalli wrote:
>>>> According to the datasheet for the AM62Ax SoC [0], pin M19 has the
>>>> address
>>>> 0x000F40A8. Therefore, the offset to be passed to the AM62AX_IOPAD
>>>> macro is
>>>> 0xa8 and not 0x07c. With the existing incorrect offset, the following
>>>> error
>>>> is seen when Linux boots:
>>>>      fa00000.mmc: deferred probe pending: platform: supplier
>>>> regulator-5 not ready
>>>> with the SD Card being unusable and the boot process halting due to
>>>> the root
>>>> filesystem in the SD Card being inaccessible.
>>>>
>>>> Hence, fix it.
>>>>
>>>> [0]: https://www.ti.com/lit/ds/symlink/am62a7.pdf
>>>>
>>>> Fixes: 8f023012eb4a ("arm64: dts: ti: k3-am62a: Enable UHS mode
>>>> support for SD cards")
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> ---
>>>>
>>>> Hello,
>>>>
>>>> This patch is based on commit
>>>> 37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel.org/pub/
>>>> scm/ linux/kernel/git/netdev/net-next
>>>> of Mainline Linux.
>>>>
>>>> Regards,
>>>> Siddharth.
>>>>
>>>>    arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/
>>>> boot/ dts/ti/k3-am62a7-sk.dts
>>>> index e99bdbc2e0cb..9cfe7e7b317b 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>>>> @@ -398,7 +398,7 @@ AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15)
>>>> UART0_RTSn.GPIO1_23 */
>>>>        vddshv_sdio_pins_default: vddshv-sdio-default-pins {
>>>>            pinctrl-single,pins = <
>>>> -            AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19)
>>>> GPMC0_CLK.GPIO0_31 */
>>>> +            AM62AX_IOPAD(0x0a8, PIN_OUTPUT, 7) /* (M19)
>>>> GPMC0_CLK.GPIO0_31 */
>>>
>>> What! I don't think this is right.
>>>
>>> Looking at device tree, regulator-5 is using main_gpio0 31 to control SD
>>> ENA with PMIC. Which is GPMC0_CLK (N22 pad) and VSEL_SD_SOC. Which is
>>> 0x000F407C address in the device datasheet. So as far as I can see, the
>>> original address is correct and just the (M19) name is wrong. Did you
>>> test this patch to see if that fixed the failure?
>> Yes, without this patch I saw the following:
>> [    2.108345] Waiting for root device PARTUUID=076c4a2a-02...
>> [   12.261669] platform fa00000.mmc: deferred probe pending: platform:
>> supplier regulator-5
>>
>> Since the pin was named 'M19' in the comment, I corrected the offset to
>> match that of M19 and the issue was fixed. So it seems that although it
>> fixed the issue, it isn't really a fix.
>>
> 
> Refer to the schematics and not datasheet for pin routing. Please submit
> patch fixing the comment to say N22
I have posted the v2 patch fixing the pin name at:
https://lore.kernel.org/r/20260309045539.2070793-1-s-vadapalli@ti.com/

