Return-Path: <stable+bounces-250651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEEzLin1DWoz5AUAu9opvQ
	(envelope-from <stable+bounces-250651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:53:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A9594DCA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A0DA37B5A25
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC436D9EA;
	Wed, 20 May 2026 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gtLczqxX"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E807E36B05E;
	Wed, 20 May 2026 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295967; cv=fail; b=P6NKY55Hc5tFSj881sAMPBjnnpSBUmwXeNuDZblARgNYdPkvG7M9AfDWOZ/lumh5CEkjRD+6X0lGq8sAPUtyv1u/NfZheFTv98e1/07F1LR6w4hSqrs4znTIzoZB91SClEIcxrzQo9EydsE2o875XmJlF/UMFoTA5NAvrg/v/20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295967; c=relaxed/simple;
	bh=fhUEdYzXShk/NIW+pnUOF+dS6nLyqQNVspwXDW3Pi+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C04tLql/CkQlbGn3zyTAs4OVk4HkEAuea4tgj6G4PvCLNz4OCXDvkt3/5D/us7o8UXIQlN+ws9IvUGTEghcuVL7bhXfCvnEQ8brSEp3hYkGKZ5JBx8uIeKS+sfvruMbp/nHefGOVziS87THNqkhpvzHFK0ubCbz9O3enPN8nI0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gtLczqxX; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SyY8LDw3FD3F50gPnHt6E7VnUSex/aPgbwPJyc5GnnOjNf+sfdt67cVj1E6l0Z7AhMS5EqOHV7iMwb999qlssaXL9oNuIqIf2pxHfg/LE4rk3g2NGldBkNUebswo03VZzLD0eJs8WU1KzomaF0cj4uTlITFnzJUmTqC4ZVS6FKS7uIBL/3xQK1a5PQMi5kmq5ZW7vG8z/iAzDBcB/UIUquPnp/72PG0sFokZLzMDLYaBCGKpHp2xbxrHCQ6/8ylq/xhusYJ3KYuZc5E4K2lS/8XguNbCvmaXd5dEB1dFECQIP7R2AGydD95Iju4HG9xuENfp26WwpioWp7BUC1gk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rjjxmhhvDNeBe6EORfOzTk0YDHvggR0J7HCF/0FQW0=;
 b=gRJ8OgvHc0Dej+uZpZVEcnOUlehA2WgmuVHUt6hYTwamZjnwHPkWJOJp1bnlos20lYymTudQVCSEXvGIJ7M2ZTZ4kg+3solKv1R4A5CGNwgvOa7ztGlRQHinSjy440QEwQkbjOEShrJlohBStgUpZa5n6wefN1XqvFvdHQl7c4li4Rgo2pN5AdR3ObOvwdqNlDFHVlCiF6u11qH0whOyEn1xZvpULUvmfQyfPFG39BvTjRtT2lKIsKkbu8LAe3XqrluNSSDl2djVKKubzbGSHO9xZYnW4ix9Q0///icJWgxFBECSrw6weqrAylOn0jyHC5pZjCU1HHcGxE1sWjULeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rjjxmhhvDNeBe6EORfOzTk0YDHvggR0J7HCF/0FQW0=;
 b=gtLczqxXyu1eTVfjzl+RgFrVmLb5+d+Ti3338nl6ZDyH5AZVtdFCN5KRlamGd0XBdezQXCJ5y5lMVd4ImxQawn5KiI/lDpm3SvKkxp1WtnHtLbjeBHyJZeCohB5vy0fcBDOACLd03CvN7bKVJJJatBAZjf20LhqZjjmaCLCx9SwGR53Be/R0JR4JBXNbXrh0giQ22PGqz6FiTypd1sK8Bo+8JLGCkgqnAJTY+LG941z8cVijI9sx47avdxMsbJ+t2oGDgJlUP1UWmuZBxCuBOBL7D2AUhGwnNFlvApdFKFU6VWrOUQosD+vgubY5K37MkJGunxT+gdRlgNvciXK/sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11471.eurprd04.prod.outlook.com (2603:10a6:102:4e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 16:52:43 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 16:52:43 +0000
Date: Wed, 20 May 2026 12:52:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
Cc: broonie@kernel.org, xiaoning.wang@nxp.com, Fugang.duan@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] spi: fsl-lpspi: replace dmaengine_terminate_all
 with dmaengine_terminate_sync
Message-ID: <ag3m0tCvttHAatdd@lizhi-Precision-Tower-5810>
References: <20260520094308.2882892-1-carlos.song@oss.nxp.com>
 <20260520094308.2882892-2-carlos.song@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520094308.2882892-2-carlos.song@oss.nxp.com>
X-ClientProxiedBy: SJ0PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:a03:333::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11471:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bd021d-63f2-4dbf-9f1e-08deb69035d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|4143699003|22082099003|18002099003|56012099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	AL5XaSFW4yVywoZ+Gci8Mfvvi5eACIqM6TuO9Dm0Cf1RNHVackPPjSRee0Lafc2RRa5Voug6VQzNk8c93OhsZV5ZSMzm7hWZduXb5YLPoOZpHZrIrIakqIIhZzhj1jqN0uh5MEzT9YXXeanLhHVKA3JgvpWLrKmlc4IXYQ5y+gMeEeQlRR8UmzPFkuBWwG5WPMD7+tQFaJ8AvsbfvLT1cHqTewy/c+BUGAIiwadYGpB8MXU3INsMF8KuDvBq4eBjyJgjMkxRSUfRAkUxKXHMqSowsUydJXO0v4uW/yeeH/VVLSHfZngu5eM7Jp+vxfgACu2z7jrgGrPMDMdnqtKsJzgjr4M55V2nYXXZr49uSzUtdEna/PmIDBDHJivpjApdUwVZwrVeSTqfeuOKNVzv2SFXMgIEBdlkE5iwuOtXLCzKg88iV5/edaTdgJXGvB7j/GDgTRABbskZyg+2igJAapvquLb8zNNL4YxnsAeFDYRl6BOWFMzZsxMQtZy5DqqmAZ6Uh60oaYFRAcz9ELn1En0tXQV9+5ydws4JRWilyMSci+pnKs/uXusmEfu8K7P2OzEhG4jHEkOEErRQEY0A+eUqtLiurHThWWezuvHQDlJbBTUiieGhem46nsUgt0qHSPeZ23Fdm3PkXHrtQ7RQWvusg8EKVFK/PZh+yMa+bte0cM5EJM6vwfPEIA7V6XOZoBg2HV12407LkSyrbRPgKTvjeR8lX5RZFE4QzvUqXgPL7YY9y9uHJsO0aGA/JUCp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(4143699003)(22082099003)(18002099003)(56012099003)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ognE2LCnqvAtsol73zVTw608SWfMBmcoi6xHGbSVeaj+v47OaIHvR4hrGLvt?=
 =?us-ascii?Q?7E3HJvFydYm6OB81vp8M3eYmkMBXAm5hQYZbg9Sp8KxkoNKADhx9faGiR83W?=
 =?us-ascii?Q?uPWy83OYfXScGsgHFIyHjEzlo/PXwvL775wEuFmg2mLiLl03GLaS5Z9rL1bb?=
 =?us-ascii?Q?zZQfYACr2qm8sy/uJ43GH+wYp9GmUb7oP5efhY2jSVfW5bwY/n6cRtltyn6U?=
 =?us-ascii?Q?YrGCzIceZbQ0p6BDHALzTmJajPfLHmWmyju+2iCIhS84K1PY4sdTJNpiwhJu?=
 =?us-ascii?Q?vmUs5pndq5i2YsDDt9KFt3lOoHXFXThnCLIXVwcbKb2fQMAXYfZAjn6RGFhi?=
 =?us-ascii?Q?CIm5sbi3t07nIG0st8ZI0ajLeKTzkVJ0GWZvqeoMXngMpswTK0sSz1ULu86V?=
 =?us-ascii?Q?vLdgK/GdkUnl89gJR1waQhsWHLNvCIUxrdHB4iJGNUC8tvKopvpDc7hdV9Lz?=
 =?us-ascii?Q?N5L1DiMm3qUPiW4OBaYir6aY7oKVqiH1KGuxo0VLiv49IKh3EbKHmz1iwk3g?=
 =?us-ascii?Q?Ovfmh/OzvJ5WHi1N3OXUXtxlANmDCiqyAoula2ZqjY2BEBaWaubgD+JTba9R?=
 =?us-ascii?Q?3vE4PDObC9dpVPSaX74p4Cg1d4We+22Q6mqszQ8DhmvVKTFbIbpoI4grcTQ9?=
 =?us-ascii?Q?57H4mRoip5rFxnud5fH4Z0tsC4Ch/FmUhrmoW9boNS2ftl2ZwERyZhQAEULg?=
 =?us-ascii?Q?trFkBALJvYw4CLwl7mKioXb1T72sdMe47dR6hilQhTsluHs2PJqnvE5d6KPp?=
 =?us-ascii?Q?k2Eh0KXFcNGlGoYPveY/XFrbvA31UkuMsGRSnd8Llvgstc6LtUXPBQf/Pwp+?=
 =?us-ascii?Q?Ybj/y5cN88yGnFhK7M0dRfzfD0+WCfvecD6d6hQmXm9UdaKLd9DXPRMPaXOa?=
 =?us-ascii?Q?lXE5Zd3W8kVGXGDA6kYZoDlP8K45dqk28zZEFyRjdPnkAxpoWKt/VMLHXem4?=
 =?us-ascii?Q?fB54e5x02AOihBE0zwHDeXuesgQGxSGdCokn0y7QAtiKT9rLcvo7VF1oPDMF?=
 =?us-ascii?Q?1xhoCL/bVL7WDRXRA1Xq3EQMKbEHR0XMXY86+TS9t+yWrFrIB8UzkBPnk1IC?=
 =?us-ascii?Q?nmrEWYWVWKscSBB5ykLrYbtK3RyIOBrbnmoKj9k9Db3QXKiXyJo5Hhzh98WD?=
 =?us-ascii?Q?Rrmj4xZE2UGpNkq9X9Dd9fDRDXI2WF3iKM2yKTtwMQPY7Ja46PkQZ1Wzfqf5?=
 =?us-ascii?Q?Sed05m1BP3iRGab5qXyPFkC3ID8BImawTWXSnMKeQQNiJAORyoEvsS28CcRr?=
 =?us-ascii?Q?YQC6u1axE4unQET5QH2SE0iPgB7FocDa5BLHqy5YQXbavkvA19X25Pj0ScZE?=
 =?us-ascii?Q?jipJRNMKKrbcdZoZZUcW7h0kSpBXPp1YVbwqsGDHrx1E36M3zKwzXaGCXUOP?=
 =?us-ascii?Q?rHCPsG3Yk2Rjtug7chDrmX1Cy1zK5CgW64lr4T4gNGMxIsngD46sPTyJEaK7?=
 =?us-ascii?Q?t4qMRtdIoVInYcPqhf1ODqHPJgvYht56YTl4OhCDKpWppeYWigqPS9ljKqJG?=
 =?us-ascii?Q?Tvy/3jHCRdPzmiHt0do8PsE3StmGIIgQuhoQt0Y/D+HOoA+uyU4f8bXxeOMQ?=
 =?us-ascii?Q?J0SYNx7kUCz+0T++FInSqaxnVQA5EzAuCMrOzgX6jBqThw+zPgof2NG+/wHj?=
 =?us-ascii?Q?RGxWp27dhV9vN3QnDlp1OpEPeOBlWCtvVgJ6pB6OfBBpFozvVheOimA19sYG?=
 =?us-ascii?Q?U4GMYoAG2SFzCWbL76+Y0XzeeXmdTW7+occuqnBOjMggbByx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bd021d-63f2-4dbf-9f1e-08deb69035d8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:52:43.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3pNJsfTm35QrQuwX8Sso9ILm7bT8wOGb19uMFb13SCZqTY2slwrfjjAe3XmAp91mv3/23J4azcz1AVAn7syjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11471
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250651-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3D4A9594DCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 05:43:07PM +0800, Carlos Song (OSS) wrote:

subject dmaengine_terminate_all() and dmaengine_terminate_sync(),

all function need add ()

> From: Carlos Song <carlos.song@nxp.com>
>
> The terminate API dmaengine_terminate_all() has been deprecated, improve
> driver with dmaengine_terminate_sync().

Nit: replace it with dmaengine_terminate_sync()

Frank
>
> Fixes: 09c04466ce7e ("spi: lpspi: add dma mode support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> ---
> Change for V2:
>   - No change in v2.
> ---
>  drivers/spi/spi-fsl-lpspi.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> index e201309f8aae..1a94a42fac31 100644
> --- a/drivers/spi/spi-fsl-lpspi.c
> +++ b/drivers/spi/spi-fsl-lpspi.c
> @@ -647,7 +647,7 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
>  				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  	if (!desc_tx) {
> -		dmaengine_terminate_all(controller->dma_tx);
> +		dmaengine_terminate_sync(controller->dma_tx);
>  		return -EINVAL;
>  	}
>
> @@ -668,8 +668,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  							transfer_timeout);
>  		if (!time_left) {
>  			dev_err(fsl_lpspi->dev, "I/O Error in DMA TX\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			fsl_lpspi_reset(fsl_lpspi);
>  			return -ETIMEDOUT;
>  		}
> @@ -678,8 +678,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  							transfer_timeout);
>  		if (!time_left) {
>  			dev_err(fsl_lpspi->dev, "I/O Error in DMA RX\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			fsl_lpspi_reset(fsl_lpspi);
>  			return -ETIMEDOUT;
>  		}
> @@ -688,8 +688,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  			fsl_lpspi->target_aborted) {
>  			dev_dbg(fsl_lpspi->dev,
>  				"I/O Error in DMA TX interrupted\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			fsl_lpspi_reset(fsl_lpspi);
>  			return -EINTR;
>  		}
> @@ -698,8 +698,8 @@ static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
>  			fsl_lpspi->target_aborted) {
>  			dev_dbg(fsl_lpspi->dev,
>  				"I/O Error in DMA RX interrupted\n");
> -			dmaengine_terminate_all(controller->dma_tx);
> -			dmaengine_terminate_all(controller->dma_rx);
> +			dmaengine_terminate_sync(controller->dma_tx);
> +			dmaengine_terminate_sync(controller->dma_rx);
>  			fsl_lpspi_reset(fsl_lpspi);
>  			return -EINTR;
>  		}
> --
> 2.43.0
>

