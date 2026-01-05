Return-Path: <stable+bounces-204800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF67DCF3FC8
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AB61300E4C7
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E2026A09B;
	Mon,  5 Jan 2026 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DRk6mr0z"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEA27F724;
	Mon,  5 Jan 2026 13:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767620578; cv=fail; b=BGKjb63JlRz60bfz/9r7GAYicjQW3bHpLPeutD1oshqaw8KPZNf5ZKrxfv4QO7ZN4AH5eHrWH3vvnaSi469XM7YbgTEq0a5suScWFJ+h1rezdb+Q6yoVafjRjinNBoB85QKjYL6VYd2kG5UnA7bdKfsSSiI7J9cJvHv68Qqd93U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767620578; c=relaxed/simple;
	bh=gK8Y5obdwWG6oZyMJZRve/yyBmuWIPA/5KTaLIOzsyA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRaAOfjUU14VVAGr6OvEhdQcWzsrCGHt4jZ4T69Cw0tVaWJ6Cx+J0okNApumwwiyRN8a0LgfIuoKHeXOxQZu9a2LtnYoOCPYNsnicj6kSvj+egL2CGCanralfio0gWTbvHIJatryIj/5D3SzD85kpnlHZcsKLGgI7Q0hj03mnAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=unknown smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DRk6mr0z; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQZ7CB390+xNoeOGTj4RJNsPZXvygRRVXWUqL0x7jLvsGQPKinQBZSdYzIhN8JaHtK7KdwBnmBuoneegzGonSKW4xOiqjZNw9nuUVVLxIIcgMjtb8lyQ2KLYtJQi9EFlyUgVkd8i0pQSVFQDBGoLb83wLAYD4nGz5B7Fl+gyGhwOrSVmmL7NO2uaOvd5X/s+e3iQKLnN1ihf1Ou1LjU3NPihKnOfd5Fpog7LzYQ3pczIuUIm+CRE+uudXhMO3mnmicLZfqXcYXUOZVDI2mkV46kJJjNvD0jIOtUT7IB+c4mTXdJIV5hDiJ5AM4VWiZ5ZkHNT51LMB/3Y8Pd/cEWOkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKXFWrqaSMIh5zv6ejKduXsLYO70vNrcLHgPEXF60R4=;
 b=ACxzHe9cEd4iesgvgQoZSaeQ4S5qZHOk2/sEeyNyE0AxifQcuh4G9bEAt+TmDvx9m+ZPponnjeeJ8LeAIcReEyJXySvOj5IxyEivxuoiuegqIHdFwKRmuCPGje5cksGb1z9vevZYMsV9U2FPl1smOUDNE8lN+uWLInERnA71XmF8X1vVJens3sEdWJRMDh/XOTSRbn8xY1n0JQRGl6AlocdKTJIk+Ky8buZEls0vEFk31yl7ndFEaJo61af2f84E0jtLi89xGP1Biz1lUpw+w4JPxduoCxu337RKjWr1LBsLJDFDoNefAzaLYzYTre8c35UXHDBNjutDF66NoymqxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKXFWrqaSMIh5zv6ejKduXsLYO70vNrcLHgPEXF60R4=;
 b=DRk6mr0zX10sjIs9e2tbTT4MkNv9id38cPQ5L+bZ+GKAkuGuj+Yrweu26bpvm/c6wArJj7/f9A7opVoA4wcXUuENAaswUsEkR6NgtjhnUN+VxHlD2PqHj2CmRlDtlFdat364YAjDHz4nJdkWbD0O9v6ihJdrFODStHC7DZpxe2w=
Received: from SJ0PR13CA0094.namprd13.prod.outlook.com (2603:10b6:a03:2c5::9)
 by SN4PR10MB5623.namprd10.prod.outlook.com (2603:10b6:806:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 13:42:49 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::23) by SJ0PR13CA0094.outlook.office365.com
 (2603:10b6:a03:2c5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Mon, 5
 Jan 2026 13:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 13:42:49 +0000
Received: from DLEE113.ent.ti.com (157.170.170.24) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Mon, 5 Jan
 2026 07:42:45 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 5
 Jan 2026 07:42:44 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 5 Jan 2026 07:42:44 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 605DgifD1229634;
	Mon, 5 Jan 2026 07:42:44 -0600
Date: Mon, 5 Jan 2026 07:42:44 -0600
From: Nishanth Menon <nm@ti.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] soc: ti: pruss: fix double free in pruss_clk_mux_setup()
Message-ID: <20260105134244.hahgkijqfsb3h4al@storage>
References: <20251225143256.2363630-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251225143256.2363630-1-vulab@iscas.ac.cn>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SN4PR10MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: a01127d1-f9f6-4eb7-c856-08de4c60513e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FX1xut2Od5/eKeoYMGJDH65ObW3IYTeV7CfxG1+fqpCplg0NIlV2sUIyUvOy?=
 =?us-ascii?Q?8+esxLzqxkjj6OyHnw1rcJAaRYO9iVDOmdidm50TCjan/wZrII7s3SJSVGze?=
 =?us-ascii?Q?WIcvxazAI4cHIpEM+gEgloDA8/hSpntkVyvf2JxgiAo2xSR7EiRaKMh8Abfe?=
 =?us-ascii?Q?Jk4gb3uSK45SymxF6flUhOQRf6Dy30FV/7PHYNev5OMsHgSnRL1U8DonghIW?=
 =?us-ascii?Q?W57vtcCwrfDDEnu5ddN7NsBWqE2Jo9TXKJYZcx3OIeX3ox+18llyrRf3qauA?=
 =?us-ascii?Q?+4eGpbAk9PCqF7s+aFtkh/+/aC3Rvz+x69F1Pz+VBaYuNJ/RVLJ0nvBbk55Y?=
 =?us-ascii?Q?I/zdhyOr+0Zp6gass4lwckrF8ofF8y+k1Q3iRRWOysmAH5gnVyOx/wC+DAdU?=
 =?us-ascii?Q?SnK+vQL/ywIqoSoblLnLAEl8JX3TG5fg2dyywZynb2FxMIIFa1pql9W80Rdh?=
 =?us-ascii?Q?6Wi4BBLlduSK5LzHVhjvZr6Gb9in/PMnJicb701wYchYTVhLISqL7zWxNSxz?=
 =?us-ascii?Q?rlrYMSLT+GZA8qRAdF7F7jWB9hQgsqfaXhwiPPxC7iSbkva/gDYVFd0UP9l4?=
 =?us-ascii?Q?qrz9lNRvynOUPyuGidVkRHBfUxdZXD9f+TOWoq7X7jc5/JLl3k5bunxsTPhM?=
 =?us-ascii?Q?31RqzstNLEsP1yanMl39xOglCpOuh5u/n+aW80n3ittGFb4xB/lRJfrVaO6d?=
 =?us-ascii?Q?zn2vdIwoaJ5eUoAOLEfvIzPeQNFak64BfH0pl30xAf7X6qwsiA/fEbGmL6dD?=
 =?us-ascii?Q?68npYvL8li4OZcbn541aGlb4kIt3Xoi35VTcOOH+7FWaq5Jx5296jev0ErIa?=
 =?us-ascii?Q?ezqMTHHx0cvDAO52QUydlp6xHzkCSYKj9FJ2lPw8K568WLj0fId9idKyet7z?=
 =?us-ascii?Q?pGnOazDkl9ssaibc7MMqRjdqIOMU7b2/p9qUu6ykH2y3J9PpM36Secooig3n?=
 =?us-ascii?Q?CIWzhAE68qlA6Gy9+V62X8/vhE20Hg0WAijn5TLuZaiQUxQUlzBnKD7DZRgB?=
 =?us-ascii?Q?rg1KyfsNy4dWUjGOIW99WnEFyCImuuciYWP8TMDlv45oP/Zv1gEf107moA/Q?=
 =?us-ascii?Q?rFbNM2OgFFVAacVsI5ufsWLZFarTFMPb6y3rKp5RSPVVsBs1LgaKm5y9cR5u?=
 =?us-ascii?Q?tM2/VuejgzKExC42c1fe7qeh/DM8MuAfZBoNOTp1K9DgPkBL68j3jny+pCxs?=
 =?us-ascii?Q?d6Z0OcxK3rSgravBJcFKpfHohHAnhhJ4++WsMdg2mHbEMbXuEqwtJJic1NHd?=
 =?us-ascii?Q?CTCgJVOwZ90eqA8xOESJDFqfHq8HXkK5s9tMGSMxga3gJOap3nVLgONsGLXd?=
 =?us-ascii?Q?Kbs7QxaUH0JML0lmSCXlNvKmC8ZN7yxytMBZ7x8EBmnqFKAzr+p7oycwytWp?=
 =?us-ascii?Q?WnCBRCDtf3w+xNt7A54tY8RuIc5lq9yDckUF8f6u2xA6/GTlBhkzhijAGd/H?=
 =?us-ascii?Q?6ajusITrP3KBTa543Rxaodor/GNOcb5yUjZxFIPupozScIVxsTuHuT3Q0Qlg?=
 =?us-ascii?Q?Ul93Ak8xA4q5ivLNZmAJXzA/hNN0UouzHFKLo2z/TAeLyfdUUWy96brmEnJ+?=
 =?us-ascii?Q?L8z/bcmK0rJu74WT0ts=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 13:42:49.5821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01127d1-f9f6-4eb7-c856-08de4c60513e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5623

On 14:32-20251225, Wentao Liang wrote:
> In the pruss_clk_mux_setup(), the devm_add_action_or_reset() indirectly
> calls pruss_of_free_clk_provider(), which calls of_node_put(clk_mux_np)
> on the error path. However, after the devm_add_action_or_reset()
> returns, the of_node_put(clk_mux_np) is called again, causing a double
> free.
> 
> Fix by using a separate label to avoid the duplicate of_node_put().
> 
> Fixes: ba59c9b43c86 ("soc: ti: pruss: support CORECLK_MUX and IEPCLK_MUX")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/soc/ti/pruss.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> index d7634bf5413a..c16d96bebe3f 100644
> --- a/drivers/soc/ti/pruss.c
> +++ b/drivers/soc/ti/pruss.c
> @@ -368,13 +368,14 @@ static int pruss_clk_mux_setup(struct pruss *pruss, struct clk *clk_mux,
>  				       clk_mux_np);
>  	if (ret) {
>  		dev_err(dev, "failed to add clkmux free action %d", ret);
> -		goto put_clk_mux_np;
> +		goto ret_error;
Drop this or just return ret here?
>  	}
>  
>  	return 0;

if you dropped, then replace with return ret?

>  
>  put_clk_mux_np:
>  	of_node_put(clk_mux_np);
> +ret_error:
>  	return ret;
>  }
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

