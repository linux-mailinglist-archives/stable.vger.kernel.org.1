Return-Path: <stable+bounces-247331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLbYDIOtBmrImgIAu9opvQ
	(envelope-from <stable+bounces-247331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:22:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A78A5497ED
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BE723020FD2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C531C31A556;
	Fri, 15 May 2026 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i6jHKnte"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182A2868B4;
	Fri, 15 May 2026 05:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778822527; cv=fail; b=RDvfx1MbGFtVOaY/P4aQTsEIxNairmtK1h2HFkoLhxjIhHCvBIhre1Qr/z8QHRNMSoRJzLcrDCJHKyAwTWBx9tsmekpkoCSdeHi2u6uEnYpZxkYNohi2YgGNACuWok+Dj1e3DA0PRlmFZ5zSTZ+ZG96/kUf86pNtCvdkk6yy9VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778822527; c=relaxed/simple;
	bh=r+sODJuso5XYTMaNcgJ108f6kYMXUueLduCp3qCios8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HDIOs6XihYmmryPliZnCLb56VED47QnPedb0GUBatW4A6AM67GB6TEwDd3+E2MFJFPbBPiCT8bfq/zlBK9ofXdcOW62cXT/aegvucYNqFrnK6vH+A376XcE0GVOZdBsJ1WTG6F33uu+BGwqbjhAxHFw5wpsGt5uQP+sPuI/uzDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i6jHKnte; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awzBgpx2sRk89hg9ZR3cDSnS2jzOrjNc2ofeBOszYbMX3JhOKm7cVeUR/SHU17uJx1iH8OeJOu/bplq3Nr0eivoqCeY4cmDJaf4CesVs1QGhHwvSuraDGIaL3OI7mKizB7Rie6OP2Hp9Ee9tZUs7KfZDFVB6rKdmSbhImTy0CUUu6fXXvnoQCsyTCQ1LiNp+X1LIOG8spSyCisIZVnkdUCzAJYooa4Y6ZxRGnIXxIx62FZ1UTN6k5mO/ugpzfU2DGPaFFwlbhzTfWySZYyR52fdynnWDHbjDKIBaYfpLNZ2daCJVKWAgOLIhrBfd/Ihj0aenmRsjWGDj/qRbxNJqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quwkjYOWK5mXLmSCOcRa7vg+tZDx2/baHWDpIeHq/j4=;
 b=hr9YT+3WrO9u7qfZKQnHRp5Gn39t5pQ0ufTbCxVZ1gattPXBWZvKdR6V7XbQ10rT+J8V9Ct5TzKRnFKHPV82Omw3b0aVx2hbKOrsPQwTDkriTSJqyvKlbMB9Sd1p3vNfssZ16u36/vCerK7fKSUZnMXJly7aKWxxQhkIMGgpHeSYODshcWjpUIVh3viGgH3Q8cfE/vHIyJUDVmbXJFoTyWNL1wUro++Z/zibxlKF/7QpJsMl+izTfpML+I45M2NmStdQQ5KyXJA19zbEoZO1kA9+s2Mw7uFr9UFdmRe/ON5y9n+jWQUCsBoGTkmicz+M7apii3hhpcSt+bBhNfei2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=quwkjYOWK5mXLmSCOcRa7vg+tZDx2/baHWDpIeHq/j4=;
 b=i6jHKnteT8vfhnQy1ffglJDH2R3WUnWCSoB2P3Q8cVuGNHT9g2YsYS9o/TpW2vpd8FqgCMchXKmxMe7JKd01RfHuml2cPhbjlDWdrz2AyzuFP0x0ZrHSilHwCm5F7zpmMGqgJI8pespsGDmfNIq8jTV5oOUOn+B/MAHCIlS4vRc=
Received: from DS7PR05CA0027.namprd05.prod.outlook.com (2603:10b6:5:3b9::32)
 by SJ2PR10MB7757.namprd10.prod.outlook.com (2603:10b6:a03:57b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Fri, 15 May
 2026 05:22:03 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::39) by DS7PR05CA0027.outlook.office365.com
 (2603:10b6:5:3b9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Fri, 15
 May 2026 05:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Fri, 15 May 2026 05:22:01 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 00:22:00 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 15 May
 2026 00:22:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 15 May 2026 00:22:00 -0500
Received: from [172.24.233.55] (uda0490799.dhcp.ti.com [172.24.233.55] (may be forged))
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64F5Ltr53750021;
	Fri, 15 May 2026 00:21:56 -0500
Message-ID: <8d496b21-fc3c-48c7-aa75-8f1938906ce9@ti.com>
Date: Fri, 15 May 2026 10:51:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pmdomain: ti_sci: add wakeup constraint to parent devices
 of wakeup source
To: Kendall Willis <k-willis@ti.com>, Nishanth Menon <nm@ti.com>, Tero Kristo
	<kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Ulf Hansson
	<ulfh@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Dhruva Gole
	<d-gole@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<tomi.valkeinen@ideasonboard.com>, <devarsht@ti.com>, <vigneshr@ti.com>,
	<vishalm@ti.com>, <vitor.soares@toradex.com>, <ivitro@gmail.com>
References: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SJ2PR10MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 078f0290-b256-4617-5348-08deb241e4af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vQSUFOuCnZFFkGNoVuQ3i5z2R9G5Vxg9z3OVCugeywrhGTBqymyIOezt2jFPIcNmdHI0EioBtjrugbe0rzc6uoDyO+1MEwrq7Kj2VZxUXES9Q7lry5lv53HBLPqyJwPVXNv5svgY+btqhuicGQnLJqyqllpC2Oj2h8EtP5b3um4TY9HG6cFiQtnvqc0HKUHIikg2aCO24vKx/MCVXn5nmaA8FOltPW6CJh7bCnraP7kpnLZos5jHPa5LJadz8ks58ESb8hNcWuz8zwAg8rODv3ygAAJXx3D7qAQDr4j28Z+ZaL+62NoWVn/d1F9YJrdRRJAwxCYQiGyOxTsN9PRPIUVl5gDC3TLhNMFZjyA54GJRiLE9WZZqdEKpWt4BpE5NATIojavhfZlN+RfjmyWCFsLTDgJnYuZu+0JoBOzEipQjEynsAzjCNKGO1DZC6RtvNwV7ZgLORKEMut6bf3HYEeYOdcBY4M0U75Q/hFTJemC5kdbrxG3nSXoEUkwCnNnYCfEvhkv4E9WO3j8cLMmtfW6d9MqGhq+3v4J2yDvkAXC6EDrTGGs1fM37nTLOb/J2qkvW/fyZpys4MuC5Yf1HAkL5+qtyMcs+aIRwWQEAEJ3gcOV/+3qpoXNlGr5uRhiqbFXKuclWZGiwXpAidXYLj6/zKlAO81+hRy48yFBr7ULv967qrV6w6dgdPymv9JoZjIPnZGCjAKFDuqUQosnc1NE+uyh5wdPv4JSVoWlk5aI=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OM43YDgym3d61kv7CfCesvX6Cp9BJADFwjuijgpY4E5ajItfZXVmCTcASIuQbxScxK2LRQgBcLZz9UAxm1s848Kxkl4K3ZZcGgw22eDqt+67DtoYybOx2i/zKnkwY1hGpvBR0zJ+L7AA9BW6Gv6V3duS4OvWbRb/QGKD8q/Msx9do1an9zy9Hd3qGtwZ65srJ9nfUqsIWJils3efRooacWtXj0qJSxN+BycZ5NnFWb26WM52eJvxMQ8sajhNn1ytVRNdDdFBH4qjRTGt62xF0cZTRXFrdM4Nmrl8JKlfAUIWT4fi9D1PYSJAif/M7qFlP724d36VDY8mUS4JwvEDuezvUGrXrlVbbociV02T4XTiNgjWRxHt+QFJ9ODyWJUjo1lA8bbG38CjLuW9pbe/BpXSG+8L845pzprYU82CzjKFFeBCzAsK6ZDLXsaSnpqL
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 05:22:01.1484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 078f0290-b256-4617-5348-08deb241e4af
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7757
X-Rspamd-Queue-Id: 9A78A5497ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-247331-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,ideasonboard.com,ti.com,toradex.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toradex.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebin.francis@ti.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



On 07/05/26 08:46, Kendall Willis wrote:
> Set wakeup constraint for any device in a wakeup path. All parent devices
> of a wakeup device should not be turned off during suspend. This ensures
> the wakeup device is kept on while the system is suspended.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9d8aa0dd3be4 ("pmdomain: ti_sci: add wakeup constraint management")
> Reported-by: Vitor Soares <vitor.soares@toradex.com>
> Closes: https://lore.kernel.org/linux-pm/c0fe43a2339c802e9ce5900092cd530a2ba17a6b.camel@gmail.com/
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---

Looks good to me.

Reviewed-by: Sebin Francis <sebin.francis@ti.com>

Sebin Francis

>   drivers/pmdomain/ti/ti_sci_pm_domains.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 18d33bc35dee1b3bf6107af1e414db377d515199..949e4115f930b93b18216fde46131b5c8931c9aa 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -86,7 +86,7 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>   	const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
>   	int ret;
>   
> -	if (device_may_wakeup(dev)) {
> +	if (device_may_wakeup(dev) || device_wakeup_path(dev)) {
>   		/*
>   		 * If device can wakeup using IO daisy chain wakeups,
>   		 * we do not want to set a constraint.
> 
> ---
> base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
> change-id: 20260506-wkup-constraint-9b0261b04df1
>  > Best regards,

