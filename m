Return-Path: <stable+bounces-240268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CMyDnJB6GllHwIAu9opvQ
	(envelope-from <stable+bounces-240268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 05:33:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A73441C76
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 05:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFFEC301016F
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 03:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC442D2495;
	Wed, 22 Apr 2026 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pv72wQu8"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2F93A1CD;
	Wed, 22 Apr 2026 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776828780; cv=fail; b=dfx5XF2g0t49Mo2hn5HSMNLSBXsaTuWet6bU/Pe2NSxdAAIaY52E/VVQ0qk8UyIidU29qcnPHOEmxbaTzzSq0Ve+OplOVA/RLr9Eo4RgaAm8I0hPrxQLi6ztnPyb5Da/bodI47FQTgynGJp1MDtgmpD4/meT4qtFCdJUS1c46jE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776828780; c=relaxed/simple;
	bh=4eHMVgza7Pts/84jqZ7vwcGeSInQd+pv1I9g7+pWaPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kbwfarD1Skx6l/I5cTQroXn4Iyk48cONwPrPiWUc/osBMjluEjRuMkeL88hLfdq5SJqbNIl0fFyyFCRnOC8Q384ksZvyJyVJ8G0U461DN0AIci/f4Bj0MuHTV9n8VVAq+hmedZa7857/zOUNzLlx9RDZko9/zcFucjFrUPe7F4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pv72wQu8; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbLo/pGjiR1/YA/s74cwvbOZjXN9hkgr8nPM199QBbQlgSE1Zc3k5ywLBlOkbJ/Z7xMS6sbkF5xJnRX5huwqx/PQTWyvvJ/6e3X4BLuzhC4dk8I9CM9qgQ8QGnyhQJYX1L/kx3L2MNQUVNAnrnlPlH7WpeRnYCNlRFel2vJFHSiEqWZShzw2fHBMJrtpuLD3wh32vl/RFlF0RJgpu83+eOZlZDIdS6LvJZE163C3CmR/u5yiF3yKCR0AjBoyq+J4gSA9wHlXr+qDbs0W6/XwC43Sl/afWcU/OJMAPZv9/ePFanzkSZ2+ugeAWSJynIfoQevDbCcX/MWF+5dSk0WaDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SQX9sztERvki5DaRILeXuPIzXDzQ5vliC3+8d/kra8=;
 b=B/lw/O6Z+VGWiRJqAfIG90EVTS8JTicViuXJrP/aJEiBoycCI9F5csm4RyO8MSjsMlHnp7JmCjBLhiVkQgrYKqROvtqQytrnrCjgWRCrbHJBvDBuFzwRz+UOwgActgjx97gTWELWcmXacuHO0Oo25PlK/GO1luPvSREnkRxFrkArUIPnbVKVfgri8G8Y1E/R++QH+3z0zvzxlxz7NvW36OGYAI2j8dYsdgDspS+XdFhl/1otl9WIipsKn1lLBOP2ZXAdZYZL8hCI8im0Vwfo+fUXlHFP5I3a6tpx64E03mKUXzURowPGSo7WI9ntv/tiszkMjRxj5L+GrSe03fMZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SQX9sztERvki5DaRILeXuPIzXDzQ5vliC3+8d/kra8=;
 b=Pv72wQu8xldxs2Dzb0qR41798wxxE7BwH01koFy9nYPmdGcLdpNf0NcmvOgH58ROspXKevkPmEpcdCbBP2+C1yuOJCb1H9sSNtQyA2AuiHlDCE2Dc0m50XVGX5brM3yrj9eQZ1Cu9cuoLIXwkRjRBSoZalmeF+7HHcy4FSFJe6DQEdzUo10KZJguBE+0M3+U+ayf3vwjTkc94lDFSupaiTsaadD/VnP2riYi6TODfJh5tEpxgx9fg/6iVZNFpmbTEmzuq6u2mccXuaLN05/mEMjs571pUn+2EInpOwP8wNKGB0ESKz9IXsDgcAw0BLN7liDZ1GwIZ0aMBBQAorhxwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 03:32:55 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 03:32:55 +0000
Date: Tue, 21 Apr 2026 23:32:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: imx: fix runtime pm leak on probe deferral
Message-ID: <aehBYJ-R3bXB0RDo@lizhi-Precision-Tower-5810>
References: <20260421125632.1537235-1-johan@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421125632.1537235-1-johan@kernel.org>
X-ClientProxiedBy: SN7PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:806:126::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: a566c5e0-ce27-4e72-7ef2-08dea01fd728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VgQ9X9jLbSV6wECRDX1q8oVRf2VxiJJVgL/Ruy1O+OSWb7cfpTh0dpdhpkfabNl8+eP05nFpHB5RaMtzx2p+N3MizJIcg9dL9J2JDUPld8JwIBQTGzRzuxQdo694i58mMBUblfZBmy0wSoaMp+C88vZ09vonZou5yHyjBU0VDrB4ZD0O/EOc0HY+CJLApYSuR5oA1LAysOSKpSSZIHIr89i0s0zYQYtUY2AIw0etY4+WYVXDs4YALWy2qYuLEH+zpPK8dr8Ws0lKL91TjM7eBCAVnn0mVGpbES/cY+YMjofVbcbbr1SW8uSvf0OWqruJRv7hQJ+LrWLTdzN2YW/z416XyORcDnDvDB2DsR48TMUpxO26ow9hTsav33SWvIC+8KcP+LbUoWEO7iWSh7AVHGiyarlsa1tRJILmGOCC+3U2BfqpJ2G6IjK2SeDp53iIQBRHt+SqN+0frP5Pa88CYdSHjdx8+/OOGIo5Z1H0aOTmcR9A6BEI3PSiJiQntgHa3MhZjJgYeOoFe/Pez2j0OUmmwzMdMCmq1+XddMDP/Ji0yO21dRaNQN/FIGlH2a8mSaAUM0qp0HoEd69Xhynak6enTcBTp5aeIWnrVKSiYGRRlKD77Vztkzf8HMBX41plbd+LuqrUOn+ikUC89pWPUVqu/CXufExPH7Qlyng6Ju/rfSw2NNOpNkjFP34xiIZQD3RZ6rf3PjXTn5CEt/Ga/ckGvbuppvy5NkaMhUCuzWnmN+RZ8B/V3JG4ccgh7OpLO/P9kI9deKPC5ebo+ZepQ69eefBhJhGJWRA6+16mr3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q3GN94zUeZ8SAaVpZs3zrfzo8vJNX4wKd51QARz5VlvJ1LLuSnDrGuGgSXGF?=
 =?us-ascii?Q?AaKYp1+UyqppglgJYL5qG4kVdd+9kGb1Ls1CnnGR3ndK5A60PXKUBHgWTD7U?=
 =?us-ascii?Q?kW6TnB6uY8OKfw0FpoV74+2Mk99JcjJRAYv8BnlBo4pobQIBy9GbdHnbleO0?=
 =?us-ascii?Q?lZt1XS4OGw1dXBZtHfqi5MaBQIxOvkjmfkJoBuJ6R1oIc+AK10YdTNSLe6yO?=
 =?us-ascii?Q?XxvdvLFqGIq3laGQpkCa4SjM/hoCxGl/ZBwHD0yvS8zkcPx2yzF08PjxCBTn?=
 =?us-ascii?Q?3MIXciogO9NLw6XcgTfUAEkvnQYZErbV87a+JGeZEiBHAw9CXka66qug1VJQ?=
 =?us-ascii?Q?8n/MbvTdI04EEkjv1i5o/GxXqBpv/DVOJ6TaJgF5uIQhSoO1WdY1KKUyYfM7?=
 =?us-ascii?Q?bJfUJ61F+Jih5CpxeJ4aj1kLe15jYHCpkkpWyX+FYehZqks8EU0NOAwxSMgx?=
 =?us-ascii?Q?5xh7kZvvJ/YDMMSQkADFOe1WPjdUzzgRPPVFUADm1paMxX/6t8rHYv14sAl1?=
 =?us-ascii?Q?0qxhQ+J3L7Af986U8MjoDP3Ft4ZIz1G0BlIhrP7JPhI3kOb4n9YHlMyLdM5i?=
 =?us-ascii?Q?3wOn3mkhWKlzohPINyu/76dpwYLh+n6nW3ysXJqtGpWoWqwcoR5NZHMgSQit?=
 =?us-ascii?Q?qaGcQTbK0eUPm95UWUlXbnb4GxFWrDfo3qrxJxDS64aGdHm0PVSsXiGVFmXo?=
 =?us-ascii?Q?536Kz6wA0i2dQx2b0JCf7tTkAxeFEsan8FAolhhLkLGG79flfVqv62999Mo4?=
 =?us-ascii?Q?tZ8JUsmiHdAPARW4RM51yJTTGjRtdV9UnxTiHYJ4FmEFNiaqQPALrFXwlds/?=
 =?us-ascii?Q?RMwpJBELw4TPQtXC3bEZQENPKjAxUz1rhk7rk4bbxaD6ZKzR/Bxa4ydSJ37H?=
 =?us-ascii?Q?0dOHeGlYtEL0rUDGLQHaNxgN3tXMAQDg+qtvfsa7Rt/SXotaPWf1isy8kpHm?=
 =?us-ascii?Q?xsccjEBmInlHxyT39jE1Ww8M6drmoDmU2OnCTPJRbgC2YtUv3SaZwZoP7JjH?=
 =?us-ascii?Q?+etVZt4Yj4c1pEA7J4j5NuJEC+qFq8WldjnsMXExyMg/NyDoh2dAg/V/79tL?=
 =?us-ascii?Q?/V9jYA23vkYjLhMzJ9NhQCVoSFpPaLbIykxdduYMeyp2z0Y73uenxj3RysOO?=
 =?us-ascii?Q?jGZ0zvpnvi3qMX21iMLISJtFFr/uwafpFwBGEeCC40ifMNcJaWwtyazBcqZ+?=
 =?us-ascii?Q?qIUOb/4fGVRgmUef3LQGs/4Yl9yGnEMW6Gu7bVJK/nnoPdgSmWoEgnUdftra?=
 =?us-ascii?Q?+wYes5rbtBWNVTUfjQYUgj6ZA1iUIGQKF9wQYbfX3y/EuPv1mqQnPmwdcgRH?=
 =?us-ascii?Q?sLqC+r2VodOSDvEMuX4YS3VubIUWLBF3r/3cHWsoucrWh73wnfeX+amNzXjt?=
 =?us-ascii?Q?kmwKM+PUmNMy/ltsrhNzyg+EAqCGuNrSLpaYLWuCcrBRUXvVxo0vSWPnWTQ6?=
 =?us-ascii?Q?UvpYtPnn97VZqusnNSXp6q2yvIAQXBwzn2cKWALVng2tmuen/yurcIv/XhDs?=
 =?us-ascii?Q?/dVbf/nzev0ote7PryQzc0esKHqkK7PpSxetQsYe+FZAXrZsVbg0E21+usOY?=
 =?us-ascii?Q?LgJR4PZBIjRZTMoE0yQlLUbAaZQ7MG/nCs5k1f6BmSeS9GEk2BnxO8keDU3g?=
 =?us-ascii?Q?quekgAjPtwZ3N6T05OPjJbBt10gr+4gRGZ3HYFAmafIS5lukHTdl5trJ3nJf?=
 =?us-ascii?Q?lii2bKiM42hZj+PXUV9p/mhFSjAz1LmnVsX9uPYRBBbap4vpJESgTAg0ZJZu?=
 =?us-ascii?Q?FBR7SitpIA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a566c5e0-ce27-4e72-7ef2-08dea01fd728
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:32:54.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bT99ymI5vSYS524QtYFZJUyZpyyWBRr108PU5pfsuY8PU7/XpUBS8H7j9AHSWmpkTHzQ6OdRHValCpnX/Y3LnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8487
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240268-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D8A73441C76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 02:56:32PM +0200, Johan Hovold wrote:
> Make sure to balance the runtime PM usage count before returning on
> probe failure (e.g. probe deferral) so that the controller can be
> suspended when a driver is later bound.
>
> Fixes: 43b6bf406cd0 ("spi: imx: fix runtime pm support for !CONFIG_PM")
> Cc: stable@vger.kernel.org	# 5.10
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/spi/spi-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 4747899e0646..e5c907c45b87 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -2373,6 +2373,7 @@ static int spi_imx_probe(struct platform_device *pdev)
>  out_runtime_pm_put:
>  	pm_runtime_dont_use_autosuspend(spi_imx->dev);
>  	pm_runtime_disable(spi_imx->dev);
> +	pm_runtime_put_noidle(spi_imx->dev);

use devm_pm_runtime_get_noresume() and  devm_pm_runtime_enable() to
fix this problem

Frank
>  	pm_runtime_set_suspended(&pdev->dev);
>
>  	clk_disable_unprepare(spi_imx->clk_ipg);
> --
> 2.52.0
>

