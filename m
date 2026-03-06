Return-Path: <stable+bounces-223321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IynAi2nqmlTVAEAu9opvQ
	(envelope-from <stable+bounces-223321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 11:06:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC1221E6D0
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 11:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B8A23012BD2
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7F2DF134;
	Fri,  6 Mar 2026 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LhFGCS+W"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011006.outbound.protection.outlook.com [40.107.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526E123D28C;
	Fri,  6 Mar 2026 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791587; cv=fail; b=qFjFmprtMigsrNCGcD2KwP/2VKvKdwQ9bJK3Bd2BwguucO65b4iV55Qce0akEJdWYuVsnZu6+tVVtYnmPQtUki0BoA5DuxNVsH9/+DmaALQXFT+iMX6wKOZT6kcSTdH4ZX/ssd6NpGF8MgoE2QTraPcff4qaUv4sC2wS6o/sheg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791587; c=relaxed/simple;
	bh=4cI2vMFDDX+fyr/lQUIgd/TO3ao982EyJYxpyyFfIbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IvCoMfvQ4/PMTnFWgJg+VNrYyzXpED/BB6mfrCMG6cnBiB92bIM4C5Edva/7XG/62djm3SYmAq02SB1TWf1CpwVgZpVByxCKJCXAl5BU9KIQf6BvniBuVWMZ2DEQPMkDbER66xqggjIi+5VmTxGGT7UVIqQ11Wa7Du8TZWcqn48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LhFGCS+W; arc=fail smtp.client-ip=40.107.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MYD4DLcOV7q/IRw1XFgAXNYCANAowJ/wUnt9+WRx+K/kOnWQK0aF3q6VZCQsvbCZRRJY2vzoGqrpLicawMvu2BZwPtecLH3ctAkuCnVoWW1WpEME2AUDH17WWBvHWYx7GmREG9kIAmaEYRPeFLTRxL74/5CLhG74itzxir8o1SBqyEkTfY4wd9VB8UZTff2R/94pLCW3JBRza2BRjTnsQOsKrgu6bBthirCJZnKucCv54KfDQ6DUzfHng6ttTHNoogCv6pTFR5i+gtkgg1FsP5JVPFaXPVv8ut0KYmftHF3hfFpwlZMnsHojvbiYyUIzENTGBpywx0YAlsHAEbrcsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/3zgtuGuRzbmOXyup897bPqQdJDTdJjdKybRrO0iq0=;
 b=r9+e3CCwqk+ZWo/YPlKwhi698o4EkKUvRTFkagGzfEG9pHcDRruxB8eaX4tnq9/mTYagkJ2FSmvO5YWFZOzJOmNM6Wb6rD1AxcMZHyleECZx5CgW/JPeCdkXMRUnXJ44g2S8wdqY83u19EouF++Y8dt/ZLqEu7bWxO1boHH1T52mZt0LVYpR07wpkHmpotRCZyX8NqM+STTxw9BfVeKX6h+F8s2tCZM86FGOS8FYr7uhidcc5qJSfah+HDkwfg28HqoUZzunAoDDWY2KWp24xuqjCpdxrlxBokAGaKb8dr3Iq/1uv6RZkxLE/51PR5lXEig+RP0zLd75dypWFxCokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/3zgtuGuRzbmOXyup897bPqQdJDTdJjdKybRrO0iq0=;
 b=LhFGCS+WtuK2NRDRzzFgVqmNftHW6RSm2a1Wadw01ZPNzXrAoPhimCeNu38STWc9i3BFq7IZIRtTqkR79EGFJrjbQ7L0lnj3TKhDdmZLNoY6rLgsQ53ljN7qv5X8fiNxvCq41m017Ymnp/PJYv36Ig5Oxg9WNj5Eckrur1C4PGfGNU9wCnN43qJ2D1tPmIdQ1YqD4FwKXUEf1RTnvVuw3u4epP94ILANRErdPK94KtgW1j5PMCE3WBMBspjUqj25GJbNpBUoRfNCtGmtSjPXgTl9t0LAMdLlFO9tZpoWpWp790GccQQK7HJvTWvoTNV9dsUwx8/GNTwjVPxh0gcRKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 10:06:22 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::52de:f9c9:8c2e:7dd5%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 10:06:22 +0000
Date: Fri, 6 Mar 2026 17:58:44 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Junzhong Pan <panjunzhong@linux.spacemit.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Frank Li <Frank.Li@nxp.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: fix interval_duration calculation
Message-ID: <63xd4yre4ccgrweiaflobni6dzvfyox5ni73knilslqbcezrxm@4zxy3u344gbd>
References: <20260306-fix-uvc-interval-v1-1-9a2df6859859@linux.spacemit.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-fix-uvc-interval-v1-1-9a2df6859859@linux.spacemit.com>
X-ClientProxiedBy: AS4P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::11) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 7643acf1-ea62-4975-240d-08de7b6804e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	a8Hxm0u3S68IcbmeeoPcws634dJK4+iDsHFYwPUiLUodwypDaZjr1kA4LLAJHVimOJzpyWWitw9vovJfjoEny+SZkjCkNgpzISLWIJoOvJwwsx8cLmrR9l1tyrOAPJGp7TMJp4ypFtISvdRDyxZ8h/yo18LnQ9EKNwz8BWN1voh1Th5tYRTXMjLXxpS7rgmnq1my2rQxsnmPzCedLf1rOyp7AE9W0A54S5PJ66UGxPvosFjkKTM26y01Nj3sSgh1Q56BB0Ucrmr+bijconmvP533XoyrKbuw6GLE1c6UObpbw++2fNpIDmYkdN/W6o8qfAUymOjvcT78kTiQHMmVl8rD3CWxAcUtm8V1seLsqTB+i/BY1/+3IM3E2Zis66bZ+gzvp/uyHFDhib3Yub6tXRZLEavUCGplz4mvX5xaQijfCDfcxqbT1B/f3MFsOmkQeRzm1Tm6lFGSmSD0ewNy87i8EhFwwzPdOvk8mA4ueDZiHQDGWZeExB8PnPFde8KgwzDaUYHz/SmHnddB3OEOOA3JzUPMAcsvrV1kWhw5BiW0shwXQBnK03/gmo0WmSHL+LOeZNCJhHfocg6F2jny2Ncx1tTFdlSNOEfcZg4LCiN2gcAhJl2JIaIi/F8H+cj0KoKRf9cXW6LFy3+UBErq7zEO+XpbuxsEHQHCkiBpcSf8S+gHNfzRsql+KRXlO0+A+p7AcyQgafrdJqz8I2MhttqCIjT4mNGHdNaUb7bNCtVXEkCv+iTXvuBnGRX3aMhbb5oJNxpA8JdMlNUIHMfLaLRjVWRqm9Qi53V88PzYs7o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3CuPfSdYU7ngmgAzxB4i0eFyKE2lF9BozRrQAbocuorvnJtOWU8kePjtZWko?=
 =?us-ascii?Q?pC/3Dkg472M7ySnFNKsRfJYMZFRJyFku4dWwx6UfJGTGYR5rpwYoK3RKF/Ki?=
 =?us-ascii?Q?AG29vMPwaH4Pec1YKdJDWRsIuhRRPyh1qPq4rdZgpFdp6/eqDt7JNEv2OrtA?=
 =?us-ascii?Q?/9lw3N1cZiLzDsK15C1vnLl3mrCV2O4ZdKSFXNZExKy8JdriEV4zbmG9L7UT?=
 =?us-ascii?Q?F/tv2dGdIcV1pmeHkQbJCm+voMgRALZjowJaDq9uehh9jIduY2QZkWbBM8GO?=
 =?us-ascii?Q?3kB9L/Ki3+TFt58gzTfHXJ/NdGLzucjA7whs67gAXKpUc6IUn/B/OkyK/yQW?=
 =?us-ascii?Q?/hM8Ri+7JnWTvd67SEgHvs8An8yWY1w2EYpZN0iRg3JHRF0oFrf08r20p8MO?=
 =?us-ascii?Q?nB9fCFy2+9BpDJZen0W+KTqlkf1CTn8l6NBS7uZglIQimemzJLDAQMAvtqFd?=
 =?us-ascii?Q?O9oDbM4LCJJtpDKlXyrLH4rhGDSvKZA566MtvMIh+zwttsQf8nDCS23jgdgN?=
 =?us-ascii?Q?nyMA5Tr80NKVuu3bUqlnnU5ucAxzWJpy67vdazZiLEgRTuq23ww+MaSAOHFS?=
 =?us-ascii?Q?aaHUKQHNW7dyTAzopkN0nkOO7hlAbUqF49XhCPz8EX/HU+YRzUmX2YvmbIYL?=
 =?us-ascii?Q?s37ANetroH4lGiiSKEDMUxYdKW0lyiyqXYmRnkAEt58Or7ZDdBbAyz747GsH?=
 =?us-ascii?Q?+OG+a3sOoZCCcrKgTyObWTjAGKe3pj/478y9NR7UTfupDe6vtMS/A5ZAxtvt?=
 =?us-ascii?Q?VWUuGWNmoBNBSM1aoIkl6Fi3yDpD9H/L0I871iqW7vlGWkPqdJVN6H2+qUPD?=
 =?us-ascii?Q?Tidh9g/fRhLEQjDsRwoHCICajzrpKEnpkyOZzmQmk38UTill19c2sjYIiRdW?=
 =?us-ascii?Q?UjZwzySLb2s4m1FRGXSaJiCzvcjNjYkVN19qLfkWZ67I0e9Vu3OFk+WOjXmY?=
 =?us-ascii?Q?kRWWjKQOWTh5kvncaSxFvLSHzlC/GRVC9EduVagAIC/VumhEVUxaZe8QkYqk?=
 =?us-ascii?Q?koYv4IH0yFBkdvVLELuxCtio68c2li45KskSBB/l4m+vc3l+q/bG8yyeJBqY?=
 =?us-ascii?Q?bASm47tJuiu1mdR8WFtblIdTdrmzCSCsxhlcLbbhnj381RfxALR15b9mw+0d?=
 =?us-ascii?Q?bvdemXpHj9bmUUAJV36t3fk21IQCMKF0nizcTIThKkc4/7c+vQAbq7A7eTJI?=
 =?us-ascii?Q?6X4eHvae+BWBaKXa78UpcrCL3sD8fj9BQXDavIdMTmtAhe97Yjv9KsQ6Xram?=
 =?us-ascii?Q?r+NqfnX/NhuhuMAKQGOIgFyWZ7UQzgqKMRlV6h4x2h9611aolynk2czkO6+I?=
 =?us-ascii?Q?IPuJbyDNIBIUwmqwq0FX/bHfMKeyrniJcL+O7vxg6X/e/zOYG134915vNzAQ?=
 =?us-ascii?Q?4l3zIIUwjyXD7GVGbBkFMN33baJzagzPAIcxVs6DZYNqJB36r66UvuQ+ZXfG?=
 =?us-ascii?Q?JGABFnvkL+ZCAF+EEUY8bGgc4IyxlJ64ZJF+Q2C9BT6Vb7W5lN93Ba6VvHsW?=
 =?us-ascii?Q?Jvu4MTqEhuzEyi88gmXtnsawFFdlo1mMB8w8Mo/oefIw307DUAgZKDSod0uh?=
 =?us-ascii?Q?4Cz0nndCG5NfR21LHnSOPjO4EvY/r4GPibpZ+Om6GdPoWddedasSxyBkAj4Y?=
 =?us-ascii?Q?khjXqJHexV+A93gT7mVVEAlBFdt47jM9ZP5H0uw/eO4K1rWKMU/HPY77w7zJ?=
 =?us-ascii?Q?edpmvN2sgveWfcQCUc5FxVKGPUaTPxZk2zBcPih8Ge6LWC9yGbHqTr6i4g9B?=
 =?us-ascii?Q?4fHp/9lD4w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7643acf1-ea62-4975-240d-08de7b6804e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 10:06:22.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k765gV4Ex3+LO5qKA0lT6lcIBE8jHtYP6eUUdNzEwVQxJeAJXZxBYxJVon9Up2yg2EHAtrLhRLzsPBsmYZQx/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153
X-Rspamd-Queue-Id: 8DC1221E6D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223321-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xu.yang_2@nxp.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 11:30:09AM +0800, Junzhong Pan wrote:
> To correctly convert bInterval as interval_duration:
>   interval_duration = 2^(bInterval-1) * frame_interval
> 
> Current code uses a wrong left shift operand, computing 2^bInterval
> instead of 2^(bInterval-1).
> 
> Fixes: 010dc57cb516 ("usb: gadget: uvc: fix interval_duration calculation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junzhong Pan <panjunzhong@linux.spacemit.com>

Reviewed-by: Xu Yang <xu.yang_2@nxp.com>

Thanks,
Xu Yang

> ---
>  drivers/usb/gadget/function/uvc_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 7cea641b06b4..2f9700b3f1b6 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -513,7 +513,7 @@ uvc_video_prep_requests(struct uvc_video *video)
>  		return;
>  	}
>  
> -	interval_duration = 2 << (video->ep->desc->bInterval - 1);
> +	interval_duration = 1 << (video->ep->desc->bInterval - 1);
>  	if (cdev->gadget->speed < USB_SPEED_HIGH)
>  		interval_duration *= 10000;
>  	else
> 
> ---
> base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
> change-id: 20260306-fix-uvc-interval-0dc36dbde48e
> 
> Best regards,
> -- 
> Junzhong Pan <panjunzhong@linux.spacemit.com>
> 

