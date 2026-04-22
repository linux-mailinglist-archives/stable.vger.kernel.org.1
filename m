Return-Path: <stable+bounces-240289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG2EGFx76GlvKwIAu9opvQ
	(envelope-from <stable+bounces-240289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:40:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE0443096
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 229E9307446D
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464A37266E;
	Wed, 22 Apr 2026 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bn/6xQhe"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E21A19E992;
	Wed, 22 Apr 2026 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843254; cv=fail; b=Wk9jhj6807Q+pa4kz0Vj/lwrUH4v2S5k2V6FTQABbpWmU8WxmtnHA2OhRdTbiGd0atJV0ao7cgrwQEmxmbz7cDBF2WGjLWfh4aP4udhRyCJuMb8Ccy5S5ZXmRQ1CN5SXNC7hSxCiovWAiozl/2I5y334a25CCZd5sPV1+efqtJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843254; c=relaxed/simple;
	bh=lUnSK71U/kN3aClxvgh6GZOJyYSIcM/ruAIX9+tqvuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t87YRctTUytypqO+6DPzSFinEUXOdVm8XzSyd14y3YLU5xv1gMJf3zOIAsZ4tBRtjP5NN/XZSxxnKd3lzjAv/4Te76HaqDr+3+igE+crwv8pes/gJbnEhzE/sHScUXaKrOUINf5/aJVMSdZcjoxzY55KmQiNq/Jq50V/HQHzxWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bn/6xQhe; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PniTqQOIemG7+uTRD3hE5DbOc/jDTcVBRjkVzOaXTyHMLXLPjqQ3k8B15gISgIPmBkBRadd6p6pfrT0xFMtkfns2qo8xYXY9hNcKfOH7/wr7JXMaQlOxkXRvnNFbxhif9vs28XJnpzFK5/6LAf1ry0T1L1r8fzLWiK/d54kIcRUINgc7zGieEyRHKMaUh3sgTfysvlFPr4s44ed/G6wWtcBWCb5ueCtZYdSBgxewolK2smAsWGAY4CkCvxYgMes4qod+L3OS3hq9SehynygxmephS/Ylx8r6eBUCUVPgTK+b7iqBX7JvWLXI8AgmA16HMxkeOyxAYbaCB+kbtmqdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6SIwd7Vbbfro5EGz+kUvKauIKyJNDm6z6N4Smpjz4E=;
 b=CV00vLkSMm4g3oq18fH/d9P998wr0ZK/idB5OmiNKAZ1o4ivjIQs9NslbnoQF44peRbNlGzAEL7o5lc7SsAdS2yjkPr2d/b0WFx0Dp6T57s0/8pirUeECwevXVdXxDy4lBMHBUQ0Jbo2R77vOhLQ1+bndHHBwPwqPbcHCviaWR3fvv6Y5J4y9cBFfm43zwaN74t4bv2P7hiNphBzFTOnWi9KCt+IVNJ6DOVcRvbGK2V2jEwDqROcWXL39vnR5q6dcu1wuFpUnon+333hU+HfARmMnxIN0uo5MSv0YZJXlaPcktUTsqunYHCtEHIrjZkx1rK6mNjkUqo447UyHwGauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6SIwd7Vbbfro5EGz+kUvKauIKyJNDm6z6N4Smpjz4E=;
 b=Bn/6xQheIW5ft4UcruJ1PMJ22joHlx8sXWQ3laiZ9diBoVROJaVb4AAxkOJE0SiXGCpYsVz/IfCNqItM9zGLxAG8ZWhkjnaU+d0JmeQck698RclIaNQ5Vk3VCDUaUJepHaD7icTMIkAjdSlhbP3COOci40rECVwpbOWiCLuIS5eMiuJr/PsLQlPhDk7YakBMP+qSlRNjJdRW7yLuumhguH7K+EbmWJuhZYXLuCDv2F34mBxVC/GvBsQ7e7Pg06uXOtGhI2o3kHpfude79dKrWDlEsIn9CF90F+fZalCDZ0MQAIyBe/8sRYC4MHat2E9coc0JfN0x01z44MTXDf9GVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 07:34:09 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 07:34:09 +0000
Date: Wed, 22 Apr 2026 03:34:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: imx: fix runtime pm leak on probe deferral
Message-ID: <aeh56bUlX_apG3Pa@lizhi-Precision-Tower-5810>
References: <20260421125632.1537235-1-johan@kernel.org>
 <aehBYJ-R3bXB0RDo@lizhi-Precision-Tower-5810>
 <aehvHZMjwMNmru0x@hovoldconsulting.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aehvHZMjwMNmru0x@hovoldconsulting.com>
X-ClientProxiedBy: SN6PR04CA0084.namprd04.prod.outlook.com
 (2603:10b6:805:f2::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f622829-0b8c-49f9-e243-08dea0418a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	z40ykDMws0wieoAHN+EcTjHeWUM6aC5TxsAesvVhZbS4RMGOOSOPqT75mvyLXBRgG12Epy9jVmi3tC5QAgoBpImvzBGFynbR9JWt2Qn7NA2mGGgRn6NB1FkAU3vua9C+wYXIS/cFLvZStSUJMDsqisrNEBEkCt+8kWM6yDPE2GM+dNe0N3kPU42BRjoR6FbBtUICnuk49AC2QgolTcRskDQZv/MAVcY71spWU727orjWPmO3I33gVQNosGkPIiKcLeK6Rv6eT6qMtk+ys50w57Ad0Xhmzxsp4tnkFq/KzoLmM7M94/UU+NUAH8DEJF5i1OwvY2sPXtyA8RrMcfeqaL8saHg4ZJGfaQVAh+QFEwHQASHu5znSLbioPyuZ9kKiYxUNpOjQkSHYvczx4+a9N6BZsC3cm1aVRognXf+clugVYTby/WQQBcx77evLuAdi+sVCHOaUoz1Wjx8lsGoOcuFfXxyR5Mdvx2DJFZt2HUWTGJ8Gy2R9qQGllTvvB+aMksiyXK/oA8W4rvGVP/RMYdCq2A98yh6LOc87R6Y8bz+kcj+D0JSRBZliGld9Cz/nZ5uUFJDeJ9wyukPwPUvUuHiqeRniRs24SFNjmmERtySeLgL+NJVGAjA3TI87gpyFhhwW0KpIk1PLYsd3xrubfbnO4mbKJ0iUIh6nQPqz7sbXFPCfHz3NX7ElhgxleglIdyvPPG8CbthCLEx/7w9UvSa3peVQrovPHPDP2rI9Sgn+x3lPJgzUHyU429eED41XpPFdvh9spIxIaH5JlsPrfSHj+aMWLX24slIwEXLaea4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cd7wyyCfK5lMOUs8fIEAkhnEnj/vNAcKOFUsyXt8Vwcq0i/4HV8XCPI/ZdLK?=
 =?us-ascii?Q?YHdJNeoLjB/WX8St+M6wNwD1JNWUCMuQxftGV23QzEzzMp8NCuVlSjbzXwCB?=
 =?us-ascii?Q?8gbh0sj6MolWapyhe3l3qikSD8MeM5G5MkRkm9ON149F9EZhwTmosEjOxdZh?=
 =?us-ascii?Q?D2ze9fUMpI9eKvSoA3XItX/OQkebu8QZMlxd4xttqilZYbMWiCWy2piRJeY3?=
 =?us-ascii?Q?Q7sVoyTgnD3tsK65PJuidOXOY5XyxlmXo57qSALjn5EcnIgZ29wCbgTrJasb?=
 =?us-ascii?Q?0DuPbqsfCdHHu0wbjtYgvDh5rO5qTjFp70x0ed3IiKMKHiXlSghpKDAbBkW2?=
 =?us-ascii?Q?Et5kNy4uwwC5MxTHeAztur5jMGpE4N94qsnRCan+ZC54PoiCfo9as8/ZaXdL?=
 =?us-ascii?Q?OdVe783Pb9lBlqujxbHMtSbb41Q4t0Lk5eorW03gShHcF30Nj8CQfCR2MHJj?=
 =?us-ascii?Q?dBWzGbXwgRphW0TLRYBs4tJos5tFcmyFt6wRni8geqrFBMglynVdJ9E8RJfT?=
 =?us-ascii?Q?8xjG9+CWvXU28yjMR9pZ9RD82yAmvgksRyyKYbtks6feVC2g3Oc5lSrITLrF?=
 =?us-ascii?Q?+yMBUQaHK2qhCCIKf/0Ev68uRvUrJu80l3LZSFt2khEP8ttVaokKfjwVONx+?=
 =?us-ascii?Q?E7gCiTIfzXz2wNKFPzZW5xt2K3djFu8sNh+56ASUybvsfMb5M+WzkD1jvj37?=
 =?us-ascii?Q?CHfITGZES0OD15TZGYGZe9qLoXLLJLP+W8LxMGF9A+s+xO+toHSpv6i5+TYb?=
 =?us-ascii?Q?9J5e27g8nWy4TJWVeAeoTo7VpvTZougfNerzcRx64YpIQyxQDFpfhwauvW8b?=
 =?us-ascii?Q?QYuWWRrOjoy9lGtu0iHJW/NnDssnCUab0EfdW4TpLQ7uNUnVvEzaNccConyq?=
 =?us-ascii?Q?nh7CI6YC9Z0UEBSe6vgzANnpi8b456yrcOXSNktVAGY2F0diFADIsbi1j23U?=
 =?us-ascii?Q?Sxe9LbVUBFNQ7yLg0kTKrafb33kSgSHIW2JjmedFG8n6BUE2/t+imjMSbRAE?=
 =?us-ascii?Q?fn8pCHB5ChPqhO0jZ17jqdl8k6/xy3LBBXeROcSH0PJT+octKKTRAjyYrwxJ?=
 =?us-ascii?Q?QwYKN/XOZyXqwHWSuvqQvQ/xHL6gE+XurA/CfjRRHDP5bW0//wTPGF0IXFxf?=
 =?us-ascii?Q?82w2rh560B9FI+j7RX3EkKV6vwT030jWUqz+xJiVJ/71tbmBjavRPuZ0+W2G?=
 =?us-ascii?Q?oWJBTFvDX1n3f/rg8GWyYi7kocJtlvGmKYdJeAmjJkEUNTeaYYbilT9uYvPT?=
 =?us-ascii?Q?e2pTnEQPnHJeziIbTB0fZ9HxJixl6eBNWVFCLRwvybgVTNItQohrYcDq+AFJ?=
 =?us-ascii?Q?eEi0Uq5Bzmol781qScxS7UmUbXsHdlJix2Z/NvzRIWzVvVACILIWLLWBwTdB?=
 =?us-ascii?Q?NquMROVWJzNy6Dut9i8EdEnFt/VvItnMcsq/q4uLz3+dpdPPb9cmhfp5XMHn?=
 =?us-ascii?Q?VAeM49emQTCxAf/MXQz9cQvYDhzXELFPl0y/6EfiPlYJG8EFf5n5o2KD2dTF?=
 =?us-ascii?Q?ElMDMIelyMmReZAhx+nn2lQJ7VtqeBUCb20Pg+wf1MBvgtvLxlvngRD3SMU0?=
 =?us-ascii?Q?2OmfZZw4FlXhmElpAvdXD1U31WB5VkUvD91XM/DdExj37RLEOBNOLbN/Rdd7?=
 =?us-ascii?Q?Xm7WnJPF3MAebS0bA7NsSQOXGCfh4PnPt0dzRDhLvwxbpvlksWaZOv7xVYw/?=
 =?us-ascii?Q?p/n0co5S18I4lThhtkQlvlSz+watJ9mJmH1dAVNqRWK1m+YK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f622829-0b8c-49f9-e243-08dea0418a91
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 07:34:09.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPe9IzlO3VL4jV0+kukpFYhG9HHudHISs68+FtzwFwHpSds8dRD4YIv/qZsOlstFcINSD1+Rb57W/qXFaOiOWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8660
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-240289-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4AE0443096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 08:47:57AM +0200, Johan Hovold wrote:
> On Tue, Apr 21, 2026 at 11:32:48PM -0400, Frank Li wrote:
> > On Tue, Apr 21, 2026 at 02:56:32PM +0200, Johan Hovold wrote:
> > > Make sure to balance the runtime PM usage count before returning on
> > > probe failure (e.g. probe deferral) so that the controller can be
> > > suspended when a driver is later bound.
> > >
> > > Fixes: 43b6bf406cd0 ("spi: imx: fix runtime pm support for !CONFIG_PM")
> > > Cc: stable@vger.kernel.org	# 5.10
> > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > >  drivers/spi/spi-imx.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > > index 4747899e0646..e5c907c45b87 100644
> > > --- a/drivers/spi/spi-imx.c
> > > +++ b/drivers/spi/spi-imx.c
> > > @@ -2373,6 +2373,7 @@ static int spi_imx_probe(struct platform_device *pdev)
> > >  out_runtime_pm_put:
> > >  	pm_runtime_dont_use_autosuspend(spi_imx->dev);
> > >  	pm_runtime_disable(spi_imx->dev);
> > > +	pm_runtime_put_noidle(spi_imx->dev);
> >
> > use devm_pm_runtime_get_noresume() and  devm_pm_runtime_enable() to
> > fix this problem
>
> No. The first helper you mentioned was only added a year ago and does
> not even solve the issue without rewriting larger parts of the driver.
>
> So that would need to be a separate change in any case.

It should be less 10 line code changes. separate change is okay, but suggest
create following patches for this also.

Frank

>
> Johan

