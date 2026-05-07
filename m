Return-Path: <stable+bounces-244534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE1XMW5T/GlOOAAAu9opvQ
	(envelope-from <stable+bounces-244534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:55:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3574B4E5430
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 10:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFB3B30EA094
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 08:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7A9366073;
	Thu,  7 May 2026 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rlnXXvQl"
X-Original-To: stable@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECE3644D1;
	Thu,  7 May 2026 08:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778143402; cv=fail; b=IhbZ5smXccNQ3/TIsMBUtDazPeRdn4OVHGpe3VbIhWIVSkYFkjwHYf9FdAyRZWgXxNg2XWam8jLY8buIXPKOMsGEJNQHtJ8M48/nTpXBAJ/4oKLTRlSPTuu823wxHMzL3fAvvIuEe8JJ0fFzx5NzeikmFeTamhpM4I2UI9z9+Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778143402; c=relaxed/simple;
	bh=opEx6PyRdykcsNdg3LM5hUh2yBYM7hZ/2e9CgdaSCz8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SqMlJV2WaM29w4n7CFfIV9VgpqgzS9XD3OXjEBTZHEFE9tYnxlVd10NEC/IcUjiHodYdy5yJghFMiI+nYIVdegrtrrkJDHdhVI0gar97l/BSrLIJs0JusWrog8jtAb+hXCpxtlxgERpNl7R29sSz4hMrdGCnMJfgpYkk975jvG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rlnXXvQl; arc=fail smtp.client-ip=52.101.57.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBvIH+SFJiKYcFzQfl8sUuED0ddlXSZloVL8CdZX4u+vvSUDwGFlDROZcVwvq835NryfOc4CKtEKFkRgUcWcDpPHtERaiDTDm/4rtGQXbsRF99Rr6oVVIldcUpdCTfMrGuAM8cLkR1WbKcptCYDA+JwNSgxcoDErvxSWBtH2VxRxNwcNwHKihFnGBY9Z+waH0COZXeJ4zxr+9oCSrrCysKGwjwZ5N0u14+wacZFb55eBfRnlAmSEzGqNO0uWJTbP/ajaRKs1I35LUy98xIMPlhXOj/PPAe1h3lZDFaRTF20EDgeAHihrbmW8dqjhcmSxDDNNRRuUeiodyvXxmcyJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rl6LgXxPLAVsnYwBosaHNVVrrWGDgEJ44oBQ4KSFjBw=;
 b=gWU4yxvj66f57ZBUPFGVGvbRDfJvroV5CnsdKp8bnVELdE3sCABLZvpsEWTMIGUMs+Wb0igo5Y8Pj3jrs1bZAZ6Wjx1V4LFdP8YwgW0WyXjKNp233nwTdiTSlsH7WdoCAsBu+nRY7uTssYVy+A7L3/JAfpDNJvXsOAMK0OHVCRIoCXIyPOH6GzZ0mCp7zm9VyZ/784Yx6ULN4hBOonhImRlon0yK9ny3ZuZPShL0l7HDZ+8oD36AiLPktW0gMcyJ3zGIgj3EgfVBAL18i8iWX9VRBInoLdzrwwul1LS7FQ5gK2DcWsbepRkVDddVZw57BgOYvpVmcbIOWmKFE/W1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rl6LgXxPLAVsnYwBosaHNVVrrWGDgEJ44oBQ4KSFjBw=;
 b=rlnXXvQl2LkShuq5oFB0slPLh7y8K23fka061mpM2xYWReCV433J1MM6LYkG79tT9jdresOAvGR3HSrdCVSONPg7WkxQEkMNHQU0+7BdydyiZ2zrePbiTQrOvX2ZxW0VdARgaePPYkjjdT1J51eCki1YhBCT/vNSzzY5wBjEp3w=
Received: from CH0PR03CA0373.namprd03.prod.outlook.com (2603:10b6:610:119::7)
 by PH7PR10MB5816.namprd10.prod.outlook.com (2603:10b6:510:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Thu, 7 May
 2026 08:43:06 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::69) by CH0PR03CA0373.outlook.office365.com
 (2603:10b6:610:119::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 08:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 08:43:05 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 03:43:02 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 7 May
 2026 03:43:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 7 May 2026 03:43:02 -0500
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6478gtxF2944601;
	Thu, 7 May 2026 03:42:56 -0500
Message-ID: <0043574e-6721-445b-ad01-54446dd72395@ti.com>
Date: Thu, 7 May 2026 14:15:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <josua@solid-run.com>,
	<matthias.schiffer@ew.tq-group.com>, <d.haller@phytec.de>,
	<francesco.dolcini@toradex.com>, <joao.goncalves@toradex.com>,
	<emanuele.ghidoli@toradex.com>, <ernest.vanhoecke@toradex.com>,
	<rogerq@kernel.org>, <eballetb@redhat.com>, <robertcnelson@gmail.com>,
	<afd@ti.com>, <u-kumar1@ti.com>, <stable@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <luis.parga@ti.com>, <srk@ti.com>,
	<s-vadapalli@ti.com>
Subject: Re: [PATCH v2 02/13] arm64: dts: ti: k3-am642-phyboard-electra-rdk:
 fix USB clocking for compliance
To: Wadim Egorov <w.egorov@phytec.de>
References: <20260506141040.1368918-1-s-vadapalli@ti.com>
 <20260506141040.1368918-3-s-vadapalli@ti.com>
 <d0eb7931-bcbc-4ca6-8ab5-4c12d134545a@phytec.de>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <d0eb7931-bcbc-4ca6-8ab5-4c12d134545a@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|PH7PR10MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2f48a0-7f67-4ff6-faef-08deac14a80e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3iWMAdsYcHK4yyYuf5YSMJyL88Q5DYFsom2dNEUkOZHgrQmyL0kSAcPVjKDj5rdFRPo+A1QEw8whLJ5Cq86reT7y2Ql64iSk42jVYXwUZGiUlbzVfut6D53VpiTrNZVgFpYQARan/TBb9oUt8hgV0vJJGFUlXu5Qpi2evixr+en60jlWFcnfcupv3JGSTij/J80w3q3lsXYAmNTaj8SGCOXjscRq/QwXr/ZaXYh8waI0iC0H6GyAjhsnkWkw6P6uQKhkRA+S9/VeKra/cNZCXQvCArwVCngshnRp96GMswLTrT8yICzC8AiCPvrO1z16Wkp/XCq0vEXf81ntCko5ZdmooJRHQSqgZ9CSmdeWATc4YVXz224bNZAp++TGdXy2xCUkoChuCQqrRevP6riPUWPseioeSa2uJ0TMZkCD50Zlrqjt1APjapLvXz2HnIFPa1SHwvwM3gHYf3ZMzYlgPwxuCNpUtYgfJv1GzQfhlcXQ1s2oOj2zFAewg7poQJRGR6AL07YhYapXsopT2+yYgf5MH3lXCOnqirdcdxWGBdpvUaC4OWSUANYqaGDcD5fVKmiObeV7zj7w6XMy4+QqAEDdKlTQictX7JybBY/m/qd8RMYkbgBvBlI8CbXzSNbahoQIel1rQrbRGiUJz8Hujs271Av+d7GU/0jCwn5KHTAMtDYsy3GPh2P58tA9ncrDZpn8VU+30if/8wYKlY6k0os2HDZF6AfAmiN8dAivpYo=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EtS32vw6W2Aa8fjYsSIWAmILhm/yx5986cxUgXpJ6plOVAMx/+TiowUWA4WX/QkJ55QC1otABm3D+CuBwG4MveS7matpAjOvJuhY3jfnZF6AQwW3tEnKZRH2W97mviiY05DtzBRy0769T0XDm1kupKhiRy9c5KlkJitZ2Ox9pg0GgW1JgrR3rLGOdZvTKCP9A9u0yypdW1ro8EeyO91BNEUK9Di8pOcVrANhomHK+znCkFzziqydnNHB//AzQrXuL+SDW3gVwMO8FlWXNlgmGJYk8bvFyMOtZYmfCzpyatPUBxHreGQDhH9RDb9x4Y+iGIKtGtW2zAWpjgRXgwqZXwhXEByft/+geTCUMokbg85OByVOsJpxAqjTtRX1MAAbZo7JKwbWQa/b5Rc7X002AbGA7Vb/wSABJTnfMV+yyeNUfzDBkWr5EYCc8tgnqaXf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 08:43:05.1071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2f48a0-7f67-4ff6-faef-08deac14a80e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5816
X-Rspamd-Queue-Id: 3574B4E5430
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244534-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,solid-run.com,ew.tq-group.com,phytec.de,toradex.com,redhat.com,gmail.com,vger.kernel.org,lists.infradead.org];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s-vadapalli@ti.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On 07/05/26 13:55, Wadim Egorov wrote:
> Hi,
> 
> On 5/6/26 5:09 PM, Siddharth Vadapalli wrote:
>> According to section "6.5.3 Normative Spread Spectrum Clocking (SSC)" of
>> the USB 3.2 Specification, SSC should be enabled by default. This protects
>> against EMI violations. Hence, enable internal SSC for USB SuperSpeed.
>>
>> Fixes: c48ac0efe6d7 ("arm64: dts: ti: Add support for phyBOARD-Electra-AM642")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> v1:
>> https://lore.kernel.org/r/20260505110631.1144200-3-s-vadapalli@ti.com/
>> No changes since v1.
>>
>>   arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
>> index 793538f94942..a85d7d08bd1b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
>> @@ -439,12 +439,21 @@ &sdhci1 {
>>   	status = "okay";
>>   };
>>   
>> +&serdes_wiz0 {
>> +	ti,core-clk-sel = <1>;  /* Select internal reference clock */
>> +	ti,ssc-enable; /* Enable SSC */
>> +	ti,ssc-type = <1>; /* 1 for Downspread */
>> +	ti,ssc-frequency-hz = <33000>; /* 33 KHz */
>> +	ti,ssc-depth-per-mil = <5>; /* 0.5% depth */
> 
> I don't think the comments are very helpful. The property names already give a meaning.

The comments have been added for three reasons:
1. The meaning of the following properties isn't obvious:
	ti,core-clk-sel = <1>
	ti,ssc-type = <1>
2. For ease of 'grepping'. Grepping for '33 KHz' for example based on the 
USB 3.2 Specification's modulation rate will not show '33000' in the results.
3. Completeness / Consistency. Since some of the less obvious properties 
have been described via comments, the remaining have also been commented 
on, although it is obvious what it means (ti,ssc-enable for example).

Unless you have a strong objection to removing the comments, I would prefer 
retaining them. Please let me know.

Regards,
Siddharth.

