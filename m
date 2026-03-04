Return-Path: <stable+bounces-222979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLL7Lbi6p2nXjQAAu9opvQ
	(envelope-from <stable+bounces-222979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 05:53:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7421FAC43
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 05:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B7423068166
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 04:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22BC37F8B2;
	Wed,  4 Mar 2026 04:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FHyAmdvl"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813934D394;
	Wed,  4 Mar 2026 04:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772599980; cv=fail; b=BG2DPPSkA3XDBTyqGDc3ikOjar3ohbk25VRRzfY5ML+FEuL134LavczN6iOdeElKvnMy/TdxD6D66K1HibIRS+MPi0q2zdHYl4Tao5U4vqpHggFzzMJEENKfVNF6eQ2q/8WEkwKAeqvdhQHnj6rHQBWZpV3FzJ0U/hiL6JDamMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772599980; c=relaxed/simple;
	bh=1ImqFkc3/+Bm9S40WGHbcX+XPrtY9TJSmQ/n4/54umk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d8+ugalC4tl+0Ajw7uH5eteCqBgEfNMTYrBemRw6c/KiHUuiBpY4QK2IRkmHjtlRC0pNX2dvauZHHHceqXZH2pdaNDJMRZNCyxBIO9ZxnanZqvBIgFtfvSvMzPHZAxOtdTEme39Flac0e85FFbZ6igfR691Lq5KFY3axyAgIZtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FHyAmdvl; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNoo/WWOUAYNTa10YWQsv0zHF7LbOjMX5ab8ncqlwGW3MMKuJoI4vkcnrVEYuqiDLJh+9cXONFpgxyvbq5bBvffLWSOGUTmHBRVbPu3l0dVD0pTE4jE5XMZ/8ZTqhEbdgCcofr3Xsu8i4EJoGyhWPpjbfndhH9Vbq0Z1UmM6MRZ7Ck4+Cg/ltv/WELeTdC47mXIJnd8ZIa1VD9hA0cmhG7bNI1CjVPOOjHpu1B/lnN6kPe28i9/VUqDq8dp3BBG5Y1hPG1TJCPuNn3OpvEq+ouUYEJ14BkzZAmjYtolTWu0rxU3iT2ruhaJaTqutdCaT2v996lJPvfiWfXrD9dnbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmyyVG30bX101bf2W34RW/cyuzhm7tLo/emel09MezU=;
 b=sb9s+R0qzSvSMkiUF28U4B+Ag7C9Hcj8G75ZtC3EHO2Y0XMA0ECAkLB1TIh+ThOMPc+Z/jkLfuKsJGFaDzYsv6c49lEOESpcsWJPvs1SiJynH+DG8WOkOu99g7ty6T0eAhekvbtMAYDKIKo3tUjpWWl2GtAdz9OlJFCemmXRlsv4RBV/8kSxu6P/3IAkTKxEqQ/GXvWwtILGb4pObwRhXL6p/4d3/vEq7LeOVG8u/0/kSGHg7bHJJ9cFhchjmUMmWYX0VJPmb6XwO/DFJwyS9htjAB/pyl+6r+oojv72akT8d2JGIWSvWoabk1U0Btp+usseuc8Q/3K5MCAmt2mvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmyyVG30bX101bf2W34RW/cyuzhm7tLo/emel09MezU=;
 b=FHyAmdvlgOTee7tCdNkcBj7ZW87NzJKko0Wfi7ULuO9eK9RXubo4c3mIhfRxu+e9h+UyDSBgMxLWF564x10qFkXsNwI6RWUMS+vZM7VPyA4ZDU3Surex/xFNvX/n+Ha17oHrB8Xsur9KHA2Wvj0E7EuNxpPzmnxfVFoXIsp/wt0=
Received: from SA1P222CA0120.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::16)
 by IA3PR10MB8276.namprd10.prod.outlook.com (2603:10b6:208:57b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 04:52:52 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::c9) by SA1P222CA0120.outlook.office365.com
 (2603:10b6:806:3c5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 04:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 04:52:51 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 22:52:44 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 22:52:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 3 Mar 2026 22:52:44 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6244qeJo3916368;
	Tue, 3 Mar 2026 22:52:41 -0600
Message-ID: <ebf6ad7e-cd22-41aa-b168-9b07f8387e62@ti.com>
Date: Wed, 4 Mar 2026 10:24:30 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <stable@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-sk: Fix pinmux for pin M19 used
 by sdhci1
To: Judith Mendez <jm@ti.com>
References: <20260212130843.1054100-1-s-vadapalli@ti.com>
 <0633e48a-27a3-456a-8b9b-32e88d417560@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <0633e48a-27a3-456a-8b9b-32e88d417560@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA3PR10MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f66f94-f4b4-4199-b2dc-08de79a9e436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|34020700016|36860700016|82310400026;
X-Microsoft-Antispam-Message-Info:
	qUbzulDMRIbKt7ezcoRkmLqq5XIFQH/mlM09sJcQ5sCgxN6IfBzkr61sKjD5ANahXGnxnbUcN+nKMs/9XWdURqaqeOBNJ1xvd+wj1u3AV8+cLfqRi25Q5d/9/b9AUir/JRjLmrq6FxGdJx1BpxBpei8dvlFQUxEFB3KEYuRxUfLVE/EKk4OI5QIog1jea6BKmKDquPfTFeEXJqWlHQuKDHCLa9X6FD5rD3vG/Do6FmgPlVobskGMjTbBT/6bRw+CndZ2xvKpn7THDZeyyojQ79wypa4XWFCsh8siVu/7SIOISzN8X30QYaO5VM7qutO7AEXvDm48j9ZCzJKlbT0cpX6ysQVrFy2g3TzqkQtR1NsKg/UCDxLg1Wiv0l0GnVA6r2jFFqW2j10bNYN2VE7ImqaikvWnmh3OMI4C5YjSV4NRA4dgAg0DvnRkfT69gPScHeCLpOJ8ZvRK8xHqYHXL5s190PcYKxw4mZj/jj0cAHEa4nNKX0amvSGXUNCYr+dn/M4vxb8cA8XzSe+P2gTlXVhrNZhlnh+cgJYy5LMtmjHRLmNSRsDh6QNjIhyRyxeNh6QRAkzC6se0gNVetsIx4F3rEoJzBx3ZlIh3HiNj/Zaqz7+2RXh52sYV6h9q1ulPypg356HI5ICNVrfAkJuO2t7DDsTKrbCeyskYFaMVEVsS6L6w8KImu7qz/wri/gEHRX6S4i2DqvA9jOMVvTx20dD3CB5+G3KYVNkwnrxqWFNVjPzI9JTJkz352uEh082pgEf0yVE/WNDAxiH5F5qUrQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(34020700016)(36860700016)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k5PAFe6WAjKlrK04vPHRy/A9z9BKyd2Vt0jNpajHrbge2EP1k7UZv/SBI0rungdQi2O5dDqshiT43DdaCK7CJrtWLodH6ItRubzrbYeL7P1CDvOIJPHoYShrLlzly3Nds1fVbqqvok1WJ77qOUbo4tDSRPNJbEf4LWJBIE3iQaXJ1lMgPQsMVwSdprTrnbOVzTL2TFHzaCcSVSoubEM7/C5WAmywANpgrEiV/P+s4zZ7QWmSOBlq1iXkBEQVrkDvv2htaGhZfm3mlFo9MVOHnvDg2ZtHj6XoT0C8dV8hH9ue1Ar1oKAALCXazd0WwndbWqIg5b7lTq5ABUVr15y2AmuMpn3OajQoLjbKmxF2Yjbm88Oo3Un5NbfAP7bYPgeSHWJX9kIxndfxuQ9h+hLf+daqhnGTKWl1VD3UaK82R4yAuOI2gC4B5vGtb4PwfsmM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 04:52:51.7615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f66f94-f4b4-4199-b2dc-08de79a9e436
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8276
X-Rspamd-Queue-Id: 3B7421FAC43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222979-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:dkim,ti.com:email,ti.com:url,ti.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 03/03/26 22:06, Judith Mendez wrote:
> Hi Siddharth,
> 
> On 2/12/26 7:06 AM, Siddharth Vadapalli wrote:
>> According to the datasheet for the AM62Ax SoC [0], pin M19 has the address
>> 0x000F40A8. Therefore, the offset to be passed to the AM62AX_IOPAD macro is
>> 0xa8 and not 0x07c. With the existing incorrect offset, the following error
>> is seen when Linux boots:
>>     fa00000.mmc: deferred probe pending: platform: supplier regulator-5 
>> not ready
>> with the SD Card being unusable and the boot process halting due to the root
>> filesystem in the SD Card being inaccessible.
>>
>> Hence, fix it.
>>
>> [0]: https://www.ti.com/lit/ds/symlink/am62a7.pdf
>>
>> Fixes: 8f023012eb4a ("arm64: dts: ti: k3-am62a: Enable UHS mode support 
>> for SD cards")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> Hello,
>>
>> This patch is based on commit
>> 37a93dd5c49b Merge tag 'net-next-7.0' of git://git.kernel.org/pub/scm/ 
>> linux/kernel/git/netdev/net-next
>> of Mainline Linux.
>>
>> Regards,
>> Siddharth.
>>
>>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/ 
>> dts/ti/k3-am62a7-sk.dts
>> index e99bdbc2e0cb..9cfe7e7b317b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
>> @@ -398,7 +398,7 @@ AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) 
>> UART0_RTSn.GPIO1_23 */
>>       vddshv_sdio_pins_default: vddshv-sdio-default-pins {
>>           pinctrl-single,pins = <
>> -            AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) 
>> GPMC0_CLK.GPIO0_31 */
>> +            AM62AX_IOPAD(0x0a8, PIN_OUTPUT, 7) /* (M19) 
>> GPMC0_CLK.GPIO0_31 */
> 
> What! I don't think this is right.
> 
> Looking at device tree, regulator-5 is using main_gpio0 31 to control SD
> ENA with PMIC. Which is GPMC0_CLK (N22 pad) and VSEL_SD_SOC. Which is
> 0x000F407C address in the device datasheet. So as far as I can see, the
> original address is correct and just the (M19) name is wrong. Did you
> test this patch to see if that fixed the failure?
Yes, without this patch I saw the following:
[    2.108345] Waiting for root device PARTUUID=076c4a2a-02...
[   12.261669] platform fa00000.mmc: deferred probe pending: platform: 
supplier regulator-5

Since the pin was named 'M19' in the comment, I corrected the offset to 
match that of M19 and the issue was fixed. So it seems that although it 
fixed the issue, it isn't really a fix.

Regards,
Siddharth.

