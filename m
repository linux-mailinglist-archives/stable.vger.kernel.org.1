Return-Path: <stable+bounces-238077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AILSCoBd32ndSAAAu9opvQ
	(envelope-from <stable+bounces-238077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:42:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99180402BDD
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A929C3008743
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D233C33A9DA;
	Wed, 15 Apr 2026 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iOdZEXsF"
X-Original-To: stable@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013038.outbound.protection.outlook.com [52.101.83.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226C1EB5E3;
	Wed, 15 Apr 2026 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245918; cv=fail; b=JG0/GKt8a+HVOth/7WTvfqOrK3Cg8DqvAM0KahIVdj3HizmPwSgzEI11z+iO2Y4qeVUM8G0pqa8XdE+Hi9KznLnUJceDJqR1axpW4H3ve0WmNrVv6U5Ve8FBfdULUuVdyTXS6XWlZ20x2sLsQSatkqMmr2fjvhg4vsoRVXq8oB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245918; c=relaxed/simple;
	bh=WHaheWQKogovpAHy1GRJnNtFbLYX51jdEncB4Q6IAdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mxoUsi8k6fbUxKDJkgOBHKFa/mfqb7WtYlcy66cdr1Ww8z9r6y1jyfiMkPz2nmHSbVbh3ng1zVP+M9QMq61MGGS83BFa8bZIgkDfG8XFk7h5/GKbXxgIAu0G9CXfXRObt87QGzo0Paifajd0MWCIzM3g5CtMGDb63+un2KA3YOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iOdZEXsF; arc=fail smtp.client-ip=52.101.83.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTVLmXZaGzntrwRYUA19xPmlMWhUP+HCHX9VmfuooX8UIZWxvIYg+RLuvOxZEN3VqdqA7mqOJEUOCzjOQ2gRj3LUMk+4DAgk5M6Nj+HWzcamixQw0h7Ngsny/xXwt88pCy9if8UOj+fQdzwjs1aVt+1fERMtWk2Z5is7U14kjoylWMxvWSwJ4sMvTv9RTlcA5XKJR9dMsRcnNZt50fiOVQ13VzkrD8ziffk2UKjHLPj4QwrUlk3Pio4ZoeCizbYoYXKFb2qmACzFYOd4sTicU7AbO3mVdqf0ObbYvnAO4aEQIfiE+3WP0hVjiYGiL1X5W9htU842vUOhDUrkIlFEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IaXVMdfy1aeMdV068wD7+q2JUwFFXYx7S3bdpT8DhM=;
 b=ByVjQyt0TcrtwGAmTeaFMqIvbe9y/WZoCXrRIXNCz2KfQCp8Fj0TCjY8O1nH9ldyXb+jekbz8bx6P+0jXsXcQ3K8GAgkTGozdFduEHaPup+7eaFdbhlSPamaUweg5hEt7ylviECY93i91v98IE+q0oxg7djKQ/WhZpotuJTIiLBGJBgFeVFFPPH+epVW3orMzOr0nCK5TPipFX1zOVRWtpJfH3y2F4JiWXEty40Cs/WF9f6cm3KjLc2lP6hiOi0DX8KW8IybthZ3vF30Gpawbqbue0+A/qmRALiQDP+9VYz+95MhxF6s1AojUQX2HfxkW6IVuBCxy/Yp59As42JMlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IaXVMdfy1aeMdV068wD7+q2JUwFFXYx7S3bdpT8DhM=;
 b=iOdZEXsFe4xHl4XBmMy/aaZGQGIFJLLOtinvk79GhvUUgm2/3T3nOO++KMaCaYrxe8Ikeu6JJMn/0JaBuW+FYe1mVPwYqmYFFESQDpVJVRStHgo04eAvoP2iKOzAm/fuxrNpugTlPG5Rq0NVxfleyGutYMDqdJ/qKe35N6yWy1zdfJSwbJRtEWL1IlczK0PaPtfwDT19URjhvna2Xj15pW0Tk7hbIwDjoTuImIdV6wJ8L9FiHy1ow67xIGHv1sET7Waj3duykGd32SYr/h7e00J+AlsNaa4Hbn284oGBzVserB4R48hwMbDT41CuQ0eXU0bpZGHQxXI8FS4TMg6cTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16) by AM8PR04MB7300.eurprd04.prod.outlook.com
 (2603:10a6:20b:1c7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 09:38:33 +0000
Received: from VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f]) by VI0PR04MB11503.eurprd04.prod.outlook.com
 ([fe80::cbe9:4c03:71b6:359f%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 09:38:32 +0000
Date: Wed, 15 Apr 2026 12:38:28 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Stuart Yoder <stuart.yoder@freescale.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Graf <agraf@suse.de>, 
	"J. German Rivera" <German.Rivera@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] bus: fsl-mc: Fix refcount leak in fsl_mc_device_add()
 error path
Message-ID: <4yzeebhaojygexo2ori5xpwyjpldag66vkoywnnrcs2ncjoght@bjiaqfz6koeo>
References: <20260413134345.2855417-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413134345.2855417-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: AS4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::11) To VI0PR04MB11503.eurprd04.prod.outlook.com
 (2603:10a6:800:2c7::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11503:EE_|AM8PR04MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af04951-fac2-4540-d49e-08de9ad2c245
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 gvA5mhk0OWpmVrTTXub1B6GxeeYW2YgW2w74FoKQfWyGmm8rRvtugSWwQQyWjINTebEBAmOuFdPCHrLXDfvmY4nt2NzdFpL0M2k0dIWVPq30IKG3IhkN0GuMTGy9Pmccl0RzelmkcUC16OpCwKohQWzvbOUI6e7Q1VhnQklxtcEto5s+bKXbqTnLfQE0g3da0dbO9DmTEqQwesdqxY3ImV4UaK543AzwCMGMbWOdSP52BySk71AHGbuLjxbd5oGicGvq/Bb5a8NqgMTCA8W9/sUNt8Lm988vG1vOq4J//LNHUl5WVB6lyv6IxKq5z1+JJUl+GWF4fAJnmrdTOWZ2Al7BY/oVr9+a5gYyQWggBd8i5NNA9jT8X0kBc/Bhkqh0m3z2ducoi5yq0ziTSDrGeNPgGM9A/zBAXEHt//44WlYAVnEA9atxV+cLt2Lq5vtMi7LsG/+/j92f+L0GXJdBDJB01AN2O+p0iwoJGPlvnO0Dry0stN0gquyH1vET+H31fCswVmA1JyvIkU/e+tBC+CpDld34DQPoI+UEalrIR/bezZ+cBNs+4h0BpR/2wttW1jHURqXyUX1RQPL8DM07IHXhyJIB6LHFdXYeonFYogXutK16K+xJnwGX4B8PF2JNq97P269GVxa5L6NrrwmKQDvJSR7SI5awfU8y+J03mVwbuWTS5h+DkudiAl48NOFiVkJz6ZvAqYQMuiTpJtN+D0AHGAVX9TfqzLiktQg1R0ycfyDe48c4kHQf3ofTCmNb
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB11503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?5zddRclJLM+lrN3mkVMxfuztVXdn5XPbCE/b6rgCpRL405MGynAvgvqMChGN?=
 =?us-ascii?Q?s9DY5Tev+AOUecYkzbyBlctOY2pg79Px7+g4U9QlodvN4UUuiFs7JKQuk5Cq?=
 =?us-ascii?Q?aakeKH/bfGRfutmyr2ajpoa7zxgqdFoyPuPRHUjaf/ll9o3IpJ0yt4drZEX3?=
 =?us-ascii?Q?hYKuK4HcOOQheD8fL2mLFNHBExPgc0OglZlvST/etrQn/7k6XYTTMQh7gaYJ?=
 =?us-ascii?Q?moRS5LUnUdOrfGOM3j3qXYZIrTgjTaKtd/gGMGjuWfFdhY480j3uonHrAKW9?=
 =?us-ascii?Q?k+TnOuJfv2nIRQrT9FjJzcUhQtjqdrdW5U8Wq+j748DM6j1VcXWkc1ZZfDnP?=
 =?us-ascii?Q?ea0pYAz3x6Sb/gX0MtTv87vSpp+NPT7EvzJvRjlI4wOvmbN3ICxGmAcNCAxR?=
 =?us-ascii?Q?e3cQ1ybruYTN1VtBnjs84VCY+Q0aTcoAGoSBPKThCUp0fimX9pjg2lZwVqd1?=
 =?us-ascii?Q?+nVDi2C/BO3OEM1Ju7p7oXUBEY+Mik+SxY1m0nmoq7FkApZHkT74pyKSCXaU?=
 =?us-ascii?Q?yLHUzD2ZGVXGLgro6CXRBDRgZxbTip2TyTSpqrC9rrQOb8VMIOhjYIkWx0Uf?=
 =?us-ascii?Q?tEu7BvQNw+ytf3czwEkzxhlKDIjlktCHK9ifZdsfuChVXTodRAe7WtegRlF2?=
 =?us-ascii?Q?IYXUODEUMhlUH9bbIerm6I4wqETSWQBSNy0Bqe9IQZzMZyWa75HZwqW1tATv?=
 =?us-ascii?Q?P2yHpe/H1UHJEbooBigqPIMH3iwW58OSQSpnvLPxZEzqVE4xE2/LR5GOSnqM?=
 =?us-ascii?Q?E5QiEDeQeezZwrPYpxMgEpXguJ01cSDAL9xV7/znOFZ6u8VMLFGA6a9HaGU0?=
 =?us-ascii?Q?kLTSkPtSdyfQdh+eO1/ubSRiOc2US3y1vCFjPs5VWuLsZZlzthtHBBhMb5nW?=
 =?us-ascii?Q?7l0BAUNjCHflVLNXr9ADtp/zwtZalzMeRY70u5N/SJzgM0mDJQEJQO67nyKF?=
 =?us-ascii?Q?fZoLS94NDG1rHjrMitKKsCq7XQeDw3v+6EwpP19o6sa3KSeQg3Xaowz66lNJ?=
 =?us-ascii?Q?k367Z7zb/aMXF+n7KIvESG8hRKEg5QE5gyk5v8LCNkodVa6Gf3TeV3MsmtqI?=
 =?us-ascii?Q?bKhWyiNukcxGwclyrqpDnpDiKmpikc3orPrXQkKIYX7ARnk7yXCTnjqSrrcI?=
 =?us-ascii?Q?6/GwzKPsuXw8suoStVNEFt9Y9qokE/otp/Am43wh9ZJwfWoRCAwcUW0m6qpT?=
 =?us-ascii?Q?EtHMf/PUGvnDXC7B3BzAavndPdrjIU3Gw/+53aapk4EVY4GVLHn9jGzByabg?=
 =?us-ascii?Q?Z+CWTbqU9t1ScloAQbGphm9PtEAlNHmwMDsM4+nRbyPcqYLdSBfDYU1tcGAS?=
 =?us-ascii?Q?y8kgeYpYhiXZon/ZD8TmJ/xl4L5dqETypABPjbm8qc2Bbj9birvgMwwhCG5A?=
 =?us-ascii?Q?d6XBl9vzxlE9Nd3JXO2wzhPiI+EbP3mhBLpA3ICK4b3nBAELjC9GX4/N9z2i?=
 =?us-ascii?Q?hcHwsC1VEW3TVij1V5z4xhxOGeeo2uVlgM+Lmu/x4twCqle6zjL4A8o5NcIs?=
 =?us-ascii?Q?QV+vf1+elTICwL1cFvYp2CHjuSEFbeAZ/eleXFNBbR7ZOIr9aM2WDkDcOfcH?=
 =?us-ascii?Q?hdpbQBoU/o1c6Si9B7BrbbQOZLU19ZtAFgmGL4pa5QgnNEL+6zHQCu5nmUcA?=
 =?us-ascii?Q?NiQNvvNFB3mcq5XRSR+gDToovT6Y4Lcq94l5UxhKxXm5unxE3OgWIQQwx+r8?=
 =?us-ascii?Q?nG9NZBULxrW39h10zAJi6oCSETUJJfDhvWQPx7389i8fExgNINa94q4nSira?=
 =?us-ascii?Q?Eyr/xtjzpw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af04951-fac2-4540-d49e-08de9ad2c245
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:38:32.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSwKRaBcsZGNjfKis6DsW1MLu6KySOlp+/5/gPtD+Ds2p149XPvZjD7k0PM/cQCPF80EEmymFAGW415n48HzGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7300
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238077-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,nxp.com:dkim,nxp.com:email,linaro.org:email,nfschina.com:email]
X-Rspamd-Queue-Id: 99180402BDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 09:43:44PM +0800, Guangshuo Li wrote:
> After device_initialize(), the lifetime of the embedded struct device
> is expected to be managed through the device core reference counting.
> 
> In fsl_mc_device_add(), all failures after device_initialize() jump to
> error_cleanup_dev, where mc_dev and its associated resources are freed
> directly instead of releasing the device reference with
> put_device(&mc_dev->dev). This bypasses the normal device lifetime
> rules and may leave the reference count of the embedded struct device
> unbalanced, resulting in a refcount leak.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fix this by using put_device(&mc_dev->dev) in the error path and let
> fsl_mc_device_release() handle the final cleanup.
> 
> Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - note that the issue was identified by my static analysis tool
>   - and confirmed by manual review
> 
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 25845c04e562..6d132144ce25 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -905,11 +905,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  	return 0;
>  
>  error_cleanup_dev:
> -	kfree(mc_dev->regions);
> -	if (mc_bus)
> -		kfree(mc_bus);
> -	else
> -		kfree(mc_dev);
> +	put_device(&mc_dev->dev);
>  
>  	return error;
>  }
> -- 
> 2.43.0
>

Wasn't this issue already fixed by the following commit?

 commit 52f527d0916bcdd7621a0c9e7e599b133294d495 (tag: soc_fsl-6.20-1)
 Author: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
 Date:   Sat Jan 24 18:20:54 2026 +0800

     bus: fsl-mc: fix an error handling in fsl_mc_device_add()

     In fsl_mc_device_add(), device_initialize() is called first.
     put_device() should be called to drop the reference if error
     occurs. And other resources would be released via put_device
     -> fsl_mc_device_release. So remove redundant kfree() in
     error handling path.

     Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
     Cc: stable@vger.kernel.org
     Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
     Closes: https://lore.kernel.org/all/b767348e-d89c-416e-acea-1ebbff3bea20@stanley.mountain/
     Signed-off-by: Su Hui <suhui@nfschina.com>
     Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
     Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
     Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
     Link: https://lore.kernel.org/r/20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn
     Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>


What tree are you using?

Ioana

