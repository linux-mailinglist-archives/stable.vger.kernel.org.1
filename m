Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CDF7E2280
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 13:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjKFM4d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 07:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKFM4d (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 07:56:33 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2081.outbound.protection.outlook.com [40.92.74.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0BCB8;
        Mon,  6 Nov 2023 04:56:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXTTIjLj7zkhZX8Suk3xWpjCw87LgEds1qVROQfrnnHEMkriVlCp75aRgdgNdzlrYL3CXkIXn73ivZJsKnkPbsoN9HMR2mulXEP6uAhpn3Kq0rOusb/os/GvJeZ2tPNavqf08YTm4FNRHLjiHvA22kBA9jDZAIz0WnB72JYKIN9zLBAkQ+e6g6dvsPiIUk1wfjo7zn3Mb2CGTzn5cE7BGR6+ZV4rOK3ihcGh41GcVmHQjMwRJEnSgG4D9fVStvOW9EGf8aMdrMwfHhZtgsPIMd3E2hH1anJComQ2cMrUY0k8YzvY4IF9Ne3waXfitruyhdneRsWH/WXYuw1Ja3IoKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM6csNtvyKeqwHPiU/kRYDjQEQV77L2hVXaWs0Dq/Fw=;
 b=iSWAvt3yAHrJM/uVN6MofBdaFHSBtzcYloSM0D02Uzi1XSn7Vtr9OQtXXBn+F+/BRAdMxe7gUtZ//aAqWMUmDh1nptWtQ8PrK2IVWccrCF0n/qpoSKegnUF5Ys/15HKT1xHSXMD27yGI/eTe7/QDHHxhvSs61pBaZxfNbd8RvFY3dYlyOmj7X2fsrXwymQvno1EaOTiqKk9y+UhHyVfStP93bmf5nzp5iRRxEKJhU8Ea2WIuG6JetRbyPGRwnnJ6zO1Q4gpYH08SsuL19ukQSH9MEukMtqErWF+KxWEA0l+kYtDTjDX7E9Zq5K+GVkBlrPqxkEd1th0Gp5DbXSDbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by DBAPR02MB6134.eurprd02.prod.outlook.com (2603:10a6:10:18c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 12:56:27 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::7399:e1c5:7269:8588]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::7399:e1c5:7269:8588%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 12:56:27 +0000
Date:   Mon, 6 Nov 2023 12:56:23 +0000
From:   Cameron Williams <cang1@live.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     stable-commits@vger.kernel.org, stable@vger.kernel.org
Subject: Re: Patch "tty: 8250: Add support for Intashield IX cards" has been
 added to the 5.10-stable tree
Message-ID: <DU0PR02MB7899088E4076359C07F436F0C4AAA@DU0PR02MB7899.eurprd02.prod.outlook.com>
References: <2023110636-sandfish-thickness-bdc1@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110636-sandfish-thickness-bdc1@gregkh>
X-TMN:  [mv/pwaOV0V5cV49dB0QPEsXLC+Ob5pZT]
X-ClientProxiedBy: LO2P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::22) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <ZUjidwiyDdqFn2Ml@archlinux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|DBAPR02MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d8103d-146b-4419-cacd-08dbdec7c9e8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4a17DepaJjlus4J6HKmGcWIH37sWAc1XgPRhXuhaXy+LBxOturE6831kBdrIAVgXESJHW/E52Q6ySfFGIXbx318WKunUiBc+ZPgjwlc0dRCK3Ikwvx5QUclpv8YF4GuCssVMclLUaN0wa6vl3mYl+Me7CAaCTMUsDv1SuM4l0HIWjtuR8o+iLXygyvkNU4wVocHQJJAr4Tji5VjblmluuPBPx+AhrGIZ+XUdNPY9JaFnJSyeoJYubViyh8EKWZpzHRDP/y1rSTey1gqGHgbVAal+bldiZDbxCr+qoBk+YlgA88WkelxuFQ5SJBnotp7gLuIy3eBvDPuTVcFcxCqbiOH/0Lj6y2xvjjwoWS7fbk9B0ymV79gGhFayZKMLjg5/UsyrU0ZDrwUYHXffgmcJ39D453CJzA2AYVHDw3XJUFWbt5mpJA00idgcR8i9EVI417Gga8D5c9AB0MGkIah1/VoUEYzQnrJsZSMyLxEDhiuYUvamgbFSX3lxgWMB8Vfa7eocInFaTwQ4dqJB4RpQwty6QUE8WiyQSuqh1gAocGnlI5J60ejukTEiW4ocnFjQ2UqMDaSBNoBJvusmdkY6zRd4Q5sZrLfYKa6SrQ4eSKM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MW5c5Or++oGPOFre05PKGU3zt7mKFiTvBthxQ/l7UNcK6ejsINmMqP0v4en?=
 =?us-ascii?Q?SdSooozLW5owhTOBgVFtnuz5I9gfanyKNmptAyZX0px5ACtPrjBfYKuFZ0nk?=
 =?us-ascii?Q?LNfRCl0yP3lSWdvWpweygcR3zRgYKsWwCtwsyvlOLutrYhUv+VgyojAhKmSY?=
 =?us-ascii?Q?is/rlPgrGOwGaGxn95cZS5Vk9Kf/A55W98TF5etLKFbGWxQYmAXiRhXHe49O?=
 =?us-ascii?Q?UltNfiWxis5IeVnN/DxJLR+rQFx5GjJUHyZ0lPukfaKfPfqo6yrHEdXMlwcz?=
 =?us-ascii?Q?cs/pgpH6r/kXRioEIhr1XUM/KY0uxGLBflpfKvEqoOtoRTFg4fjlH3C4uyKc?=
 =?us-ascii?Q?Lk59oMzmojKyiKxSu4PejEaOshZTveBi/OeNwPqgzXnP4EAPNZFJF5bWG9Z4?=
 =?us-ascii?Q?JgQHp0E7QSpCkxzF9xylZmZiRSW91rifxhYqxsUPfL1bwmlLu0IrNx7CI4bB?=
 =?us-ascii?Q?uT28pbsOp1Fr3NT7cScXSL4OU+JL+GYEq14a9igvj9Q0OLwRGoaPVciF/Qjc?=
 =?us-ascii?Q?8Vu26Ccr+19s6H3J/3lcIFKzHMj3ZfVQwpiESQFqlscWF1BdaM6uUfmzzzUt?=
 =?us-ascii?Q?MUqMHHjPSpa1mPxfZvn3UgBOEZoJlLjD38pycK+HztWzIAtSZ9XW8KdXHA3V?=
 =?us-ascii?Q?GRCib+KtyVzS7ZGU5QjSI72wdFrQkEeDhREIeYBzLypXIKNGM+iWAuskuCA3?=
 =?us-ascii?Q?PFpBjD46FsUtpH3CCK8FmIEuBBA3J1p9PIksWBqb7wsyIHt363Univ/xYiOV?=
 =?us-ascii?Q?IX8SYbyif0kHx47J3VarhlsT5/u9bSAF06QUIxiVM5jTZISYSV32fLTvyM8L?=
 =?us-ascii?Q?iOsAM+6YyY6BYZ6FaJGZjWTU5JlggQ0x3S7NuoGpFe7AB0WRGHBhJij219k7?=
 =?us-ascii?Q?Eo1zedfm76Zy4AgWqs9OQgHwPV0eCg5GJgD7NnzFaIWiVfmpryNJIz7C14Pn?=
 =?us-ascii?Q?2yVaX6UnHBmxG3NygHbLXog4uUO/EvUv/62c+D8vG8bqBn3M6Jwo66QACEgT?=
 =?us-ascii?Q?rSfeSZURthQMDOPMvDATmkYa0KZ51QkoMipQPW0h/lWg4KXlTbjaS3V+vA27?=
 =?us-ascii?Q?D5jwYLes4evzP64YbAQtk0cBvdve9ElaCAaQpif+iXKi7bMjpFxqg1TYgRBt?=
 =?us-ascii?Q?V4p12WjB7qMtbb4K6RQyh9ZV2byCXaMC1bo5SnXrAjvwJIam5+nKGbUyei+G?=
 =?us-ascii?Q?/6yuhD2SiKG53tpNz0ZvRNC6D/8C1dJ3e+W3GQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d8103d-146b-4419-cacd-08dbdec7c9e8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:56:27.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6134
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Nov 06, 2023 at 01:18:36PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     tty: 8250: Add support for Intashield IX cards
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      tty-8250-add-support-for-intashield-ix-cards.patch
> and it can be found in the queue-5.10 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
I don't think this patch should be in 5.10-stable. It's using the
pbn_oxsemi_x_15625000 configuration which isn't available in the version
of the driver (it's actually pbn_oxsemi_x_3906250 in this version).
The rest of the patches to be merged look OK for this branch (as they are
all using the generic configuration rather than Oxsemi).
> 
Thanks,
Cameron
> From 62d2ec2ded278c7512d91ca7bf8eb9bac46baf90 Mon Sep 17 00:00:00 2001
> From: Cameron Williams <cang1@live.co.uk>
> Date: Fri, 20 Oct 2023 17:03:16 +0100
> Subject: tty: 8250: Add support for Intashield IX cards
> 
> From: Cameron Williams <cang1@live.co.uk>
> 
> commit 62d2ec2ded278c7512d91ca7bf8eb9bac46baf90 upstream.
> 
> Add support for the IX-100, IX-200 and IX-400 serial cards.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Cameron Williams <cang1@live.co.uk>
> Link: https://lore.kernel.org/r/DU0PR02MB7899614E5837E82A03272A4BC4DBA@DU0PR02MB7899.eurprd02.prod.outlook.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/8250/8250_pci.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -5150,6 +5150,27 @@ static const struct pci_device_id serial
>  	{	PCI_VENDOR_ID_INTASHIELD, PCI_DEVICE_ID_INTASHIELD_IS400,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0,    /* 135a.0dc0 */
>  		pbn_b2_4_115200 },
> +	/*
> +	 * IntaShield IX-100
> +	 */
> +	{	PCI_VENDOR_ID_INTASHIELD, 0x4027,
> +		PCI_ANY_ID, PCI_ANY_ID,
> +		0, 0,
> +		pbn_oxsemi_1_15625000 },
> +	/*
> +	 * IntaShield IX-200
> +	 */
> +	{	PCI_VENDOR_ID_INTASHIELD, 0x4028,
> +		PCI_ANY_ID, PCI_ANY_ID,
> +		0, 0,
> +		pbn_oxsemi_2_15625000 },
> +	/*
> +	 * IntaShield IX-400
> +	 */
> +	{	PCI_VENDOR_ID_INTASHIELD, 0x4029,
> +		PCI_ANY_ID, PCI_ANY_ID,
> +		0, 0,
> +		pbn_oxsemi_4_15625000 },
>  	/* Brainboxes Devices */
>  	/*
>  	* Brainboxes UC-101
> 
> 
> Patches currently in stable-queue which might be from cang1@live.co.uk are
> 
> queue-5.10/tty-8250-add-support-for-additional-brainboxes-uc-cards.patch
> queue-5.10/tty-8250-add-support-for-intashield-ix-cards.patch
> queue-5.10/tty-8250-add-support-for-brainboxes-up-cards.patch
> queue-5.10/tty-8250-add-support-for-intashield-is-100.patch
> queue-5.10/tty-8250-remove-uc-257-and-uc-431.patch
