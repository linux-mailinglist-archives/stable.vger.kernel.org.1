Return-Path: <stable+bounces-121716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64243A598C7
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA2718909CA
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ECA23A9BA;
	Mon, 10 Mar 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MsLXXhqp"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2086.outbound.protection.outlook.com [40.107.21.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43C239090;
	Mon, 10 Mar 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618405; cv=fail; b=asDIRfJ5uTkt711LpoadeY1eNGNwlwm6+r0lLrOA62RYP4ZZlJPx0Hm5K3kqFNoD9DqBo7MW+YSzk3yiY838GFkWC3P5r0Urkog3V+LbyLxbcZCw+eiByUnNh4/vHQwICeRdB/T9nTQiFZJTdt2LTZP50GfTh36ZVAT/R9708Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618405; c=relaxed/simple;
	bh=jbWpsz311vCnfyqIKiml9rEBgSrKmR6B/3gVSualEM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gdkjW2FOWdEnSSYqEsZwNDhK7I0ozDmq/kbhpgwltPbZcow2yuvDehZAIKga6QPjMOf+rn0oDWBLolxHgiKWHSoVIRah4/tEXF7As1DXdTSOS6p8t6NE8v6naX8bp6Pix6J5+rbnxflaqp5GVtmsIV9mFa5LrjhKdK6ROKfHWG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MsLXXhqp; arc=fail smtp.client-ip=40.107.21.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNt3CYD5HuFR6c4qhcM/RNi/+pRpCWVtTfHm+IE1uwuJiCf2cWew1CJTp+Zhx7VSrnrFCNCWbb3yom29WAHPzTcky2ejWNvsh/r1nIlKRLyKHn8Dvnv+ayD/nyaiaiYUz1utqvcfG3a4l/yBaG5ZRuITbS15vQLmZU95k2vEtFb7wRNzUUQwAmwZaKbwiqboAgObioF1iwY8OsPbRNgrR+Q7sBE9I+DoosytunLzqNA9WnZcR5Y/AIfD6OYyTY5P5EtHszdzGlGQIWlY884DFw3Um2igkHOqDAu+pepQ2WS+A5gPMshtDnpv+L1G9DdKl6C4eubskQx2MYBduZzevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mONm3OKHGiUo5JhzqC3SU+XpjZ5un4W5cAdbtl40oN8=;
 b=DPRF1aOVXkwLPqUX9rAy9A3+7wGRxbjj18/j2jIm+pBdzkbzMHrwIlyLRqkY0smqX5MZo+U5Lag00nBxqXfsbONe+JBaJK/q/nOSAOW6kqUO9EvjDoJ4aHbhESJn3IXbAttcmTW3ZLESeGHNg28EFiL+RHeXypHyzIywD81ZmNc4YUyqIwx9JLIffuvPBpNgokMP0r5AsuHAikwmVXBVVwuIQgBgLnAM4kyaWRAC2xLdmc3e0CvCuyuUc32ZEKXJUFX6IOqy4u4OgaQW+hpgFT8YX1FBFt3ia0qUrE/VSthJRyZGoFp/RRGQAADfycCzgBV5z9yn5FsVkp/vGXbEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mONm3OKHGiUo5JhzqC3SU+XpjZ5un4W5cAdbtl40oN8=;
 b=MsLXXhqpZ2fx7WwgNvOP9NCIJIkNuOlaC/EwWgvHfltPgoCa0enCUpAffwFJptljeKkmwb3iU9jU7IRXm9ScFt8A6U8q2gN9GBmk1GPnqGPv2OMg8GVIPmkukP078d0nM+XDb/NexI8mIrb+z26HyTUNbdT1aqlC+qlJjbCte5BE+nJl5CNFbP9B36YJZ3bGCB25PTnwxbMIW4WGgrPM0BW4Qxcmql3CEn48iq34XG16cZZORXVX8ZQGjTatfZlkfFsL/70U99XzueyhMokKcDkNu1mnpTV/xsxwDxtWNlolJAENRMrJSX8HJxU7W2JzzoUrfRvbNk4tUNcyjg/PAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 14:53:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 14:53:19 +0000
Date: Mon, 10 Mar 2025 10:53:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Sebastian Reichel <sre@kernel.org>,
	Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>,
	linux-usb@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: chipidea: ci_hdrc_imx: disable regulator on
 error path in probe
Message-ID: <Z8781hzSKJ5P0gBe@lizhi-Precision-Tower-5810>
References: <20250309175805.661684-1-pchelkin@ispras.ru>
 <20250309175805.661684-3-pchelkin@ispras.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309175805.661684-3-pchelkin@ispras.ru>
X-ClientProxiedBy: BYAPR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:a03:100::39) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 9102cb00-0784-47ca-76ae-08dd5fe34bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HUe3fDTDuKm5roWvHOfPH8Wc3IrMb39gvLAON/55bUGYScPOkCbbnVVE0w0/?=
 =?us-ascii?Q?lv/v/QVXuC/f+2+yZsUjSNzKJKcG+z3VDpHo1Qh4ii2Y2VBy65JMzl5/kheT?=
 =?us-ascii?Q?byPDEfydPsLJ12YCnYyknAlt6lFDIvVOvdiqdieRNQjDBiSFGXaoYUP+631T?=
 =?us-ascii?Q?0eExmWoOrpzmxGFnon63JMONi8PkI18Y01OflpPoPE1MlMCoj1qAHbGpy61D?=
 =?us-ascii?Q?Bz3ug8pF3Ta4SOWxUUHvgzIsqN5mW/RDYgIVXWJdbW/Y93IMR8uu3KwSlKC9?=
 =?us-ascii?Q?mp1c/MmJHFA62exFW7fj+/3IzS/ZEkX03GQKXDfD9MChQDMfHIVSb3zevJmc?=
 =?us-ascii?Q?FRNLxd/KOaeAIq6WEbtzjulLr5Hvr8EUMwzZMS7gHf0/OZyU+nIi/HSGF4g/?=
 =?us-ascii?Q?ng6209kIHPVZa57VZxPgkv2t0qDlwCaBaSacX4IfHmYTWK6E80DgDE/BlB25?=
 =?us-ascii?Q?T49TH1ucbzRomL4Pd+HF5gBG60uhaPIWOc7sy1tZ12Tlwfqku+5F0Ml0sOID?=
 =?us-ascii?Q?fgTfVSv530V5i2lQRfSqQj7XTuN6vCSmGY8PD54WuXfypQmznunpF0DPdETB?=
 =?us-ascii?Q?0U63Wn5ZJF1TCqGK/uq4r41sUHoKka5UKP4mhGv41YpWTmftDXL2rHX3doDM?=
 =?us-ascii?Q?kpLqdhnbxlep4F7pVtn86S/FqUa/PIMB8yUv//5Xq0JaMsmkuPJ4l6xqumpi?=
 =?us-ascii?Q?R6cQ93gwcLfBblKNrqZi1XmTGB+BiAux7MUHzIHrO3Un0UasNWjygzAAdQ/K?=
 =?us-ascii?Q?fSvvN/y64zs69IRpBwEk94J0Qz1F4370xO0H45nbBBS1+IKENG7rGFnOoKWF?=
 =?us-ascii?Q?WGKs6cWwkuW7doDIL9cbnaoktoQOvFgU1GE/Uhuupa3aFh7zWWlr+wPNiKSb?=
 =?us-ascii?Q?e6sUNwgM8aAfK4ul13TKLijzuEqXR2YZMnyu7VnV6497IW0Ml9Ych4tGaSd6?=
 =?us-ascii?Q?OcYmvAPH/En6v+3LYipUWTDcggC0REWcjLX59fdBDxdYeJ9jeH/643vOqwIj?=
 =?us-ascii?Q?FlfvrKDbTi0V4iKsq1UpiPEigwyZYSkHh+n0KBnz9xsEjwv2loTYjC1wgf/M?=
 =?us-ascii?Q?G4L8yfyVLtRJyid0CUyzyycgiWU9OpN9vbfWoQCdebOLLtOc9KZqNCaJLZ2Z?=
 =?us-ascii?Q?SHqYn5vK1Q4zcGn43eyYtbf3uhQtki/7RObzUkMlh0oX8i+DxvysLFHQ/ByK?=
 =?us-ascii?Q?9w1NLE2sqIyIrlUvxT/HGJsfevqWahqkKdnWlRhZCCKmgn0ncg7b/iRux8wc?=
 =?us-ascii?Q?azXfn9bXLtFL5X7mohPQeggOKwDk08YmYUxd72X83bkIDVl7hBUQI+w7+uvQ?=
 =?us-ascii?Q?RTghaUK2WfI7DhiKfE3CgZwxYhDXeAe/8t6T3lke+OW94cYlscI1truSkii+?=
 =?us-ascii?Q?c85BP5NFkfT45pr7V9fXSGDX/D37YkD3rrZxI0lmt2Z5gG9iH/361yd0MyIs?=
 =?us-ascii?Q?wohx398wRu8cDe5s+omdgXTiUHZ8SUhV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zkyJC60OPxha2v8DZPuQTGXJOrjz7BfbrljL7zinqvb3JExLnGMZYKL27Cys?=
 =?us-ascii?Q?iyDAkIok+wy+NR3dfjeTm201kgvhsha14BFVynHBU7LuoNu8F6WsMAOLAWQM?=
 =?us-ascii?Q?EzLmXijpUCzt6Nxl3eYHRCbQRyQd35jaV5+moGbKjO1UnKqBBWBUAqBNF26F?=
 =?us-ascii?Q?uOakjBaqpO1cvL1QIt1WmfnS7E0+367IKpGKpPK6uTUNUhhiRPGeKHH7d1zS?=
 =?us-ascii?Q?KDytqa6KJ9VwlTFUocr8N5K1paMbm5xEt4zU+ruNTGZt/r3kMLRTnr3DChXX?=
 =?us-ascii?Q?Ru5oiu0UU90TL/5gJSMwyIcVvdfN6AfijXUOUtF/KQAhNFdaWoJ3D3bbuO8z?=
 =?us-ascii?Q?EzYFCsxwRZwDT+5/7bzSc5pGzLQtP7e3ROAxFfHNaK9fy5wpwF5ErRX9OCsa?=
 =?us-ascii?Q?CzuJeeKKU/2EPx32t1zgCBavTQcceXFjhldOYVsMwWMQjtYW0R5wSZWnoQYT?=
 =?us-ascii?Q?QBmnPNWgG000asaNe3Qil+kC5AA0251zuCrdJHKCuMMY/RMYgbQnZEYPE1mS?=
 =?us-ascii?Q?cJs0anjFc4kSm4+q+3Z9oPQn6alztkf/5h5O0DjeUFbJOnAplIeVK8f7eKUP?=
 =?us-ascii?Q?9reK6XOUCchVNTddlERLm++xOJvau8teXPNUOfdXRby+Ic/SbeEwoz2VJ1dK?=
 =?us-ascii?Q?/JP/7ey2A57aAIKNUTB6zLVvyoBCh7Xy04IO1U6JgO37H5lnEOIog4igXCzN?=
 =?us-ascii?Q?EKUovu9Q0U1r3MbqDVzqtu/GkuDIeQEVpQ2RhjuLLEazhHeJe1TY06loN/IS?=
 =?us-ascii?Q?eIKJF7xiOKQs0hAo/HvRxQQEOBR9uLsyHlMPDBHp66G0udO5jt5rFdscJQ2U?=
 =?us-ascii?Q?ueov/WcCN7d5nG3xwTXmvnKYAFWfGr7XO0iJ3NwyImSp2kDBrjjjm+7FAm6X?=
 =?us-ascii?Q?WTszoIdfaA0tnzhsnHRCWLUPvGVbMFEqVUk8H145JodM9vusAj2apcg9Kvkp?=
 =?us-ascii?Q?nJ2ZJSeBNxYItKd76hiRtheZodZXLGUgCrAPKIHH6zDoPvRqc4GS8RpsAd5S?=
 =?us-ascii?Q?amkFYm8mRg0SOmQdcfhsbTFCIErw8b2pFgs4Zv5wnVvaRxgTGR37CHL2jKdW?=
 =?us-ascii?Q?4Ff5OB5UvfukcCHgMn8SI+ok6j2xdx5BcdiTzf6HghAQZ2me+o4njzI0Pf6C?=
 =?us-ascii?Q?qt/iLvJHKmiM3dCSWsi4oD3FXQRTOmVuN7fx2WyPgYoIrAQTv5/5eKFV9IqO?=
 =?us-ascii?Q?9UrRlZG5GQykDAg13R1lIdJpuWpFBWhNMw+J6lmtVmhyJBxCEL/mIq+VI4X0?=
 =?us-ascii?Q?XkRLZf9pnfyeBI7AurIh63HpxhrgHX9wJoLNVaeN3PVIYrIdOrry+dGqgWFA?=
 =?us-ascii?Q?b8kaL6nsk2n97picfRB+5CZ4OQTJxsRhn68HKLLiEKksoOlJfAY07mft8TqQ?=
 =?us-ascii?Q?msD01Bq+eUIBT16ZZMKkUxCylEp303JY+ksDNnnVcP9jEpASQCq4X+B3awUW?=
 =?us-ascii?Q?S83+nAC+mHr3/stpBj4AcLfqmuxX6gg2yq77ji8DFjBqsy50Fg3IyknPzUBQ?=
 =?us-ascii?Q?ksYMbu5jvqSs/o7j58L6Z0hTVoDQNytlSTFlmb1f7SrUYsAY4n3tJ9zurYPy?=
 =?us-ascii?Q?WvmrRZfQaB6aNwGbNBI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9102cb00-0784-47ca-76ae-08dd5fe34bf7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 14:53:19.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9Kwqb4QfYYn5B/iVtX67mwKK7ZzODCpe0MIjmoTqwZ3fk3BXx6QWdcCIUoSbxXYx5nU/zjiwiuA5rIf6FaY9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8603

On Sun, Mar 09, 2025 at 08:57:58PM +0300, Fedor Pchelkin wrote:
> Upon encountering errors during the HSIC pinctrl handling section the
> regulator should be disabled.
>
> After the above-stated changes it is possible to jump onto
> "disable_hsic_regulator" label without having added the CPU latency QoS
> request previously. This would result in cpu_latency_qos_remove_request()
> yielding a WARNING.
>
> So rearrange the error handling path to follow the reverse order of
> different probing phases.

Suggest use devm_add_action() to simple whole error handle code.

>
> Found by Linux Verification Center (linuxtesting.org).

I think this sentense have not provide valuable informaiton for reader.

Frank

>
> Fixes: 4d6141288c33 ("usb: chipidea: imx: pinctrl for HSIC is optional")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> index 619779eef333..3f11ae071c7f 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -407,13 +407,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  				"pinctrl_hsic_idle lookup failed, err=%ld\n",
>  					PTR_ERR(pinctrl_hsic_idle));
>  			ret = PTR_ERR(pinctrl_hsic_idle);
> -			goto err_put;
> +			goto disable_hsic_regulator;
>  		}
>
>  		ret = pinctrl_select_state(data->pinctrl, pinctrl_hsic_idle);
>  		if (ret) {
>  			dev_err(dev, "hsic_idle select failed, err=%d\n", ret);
> -			goto err_put;
> +			goto disable_hsic_regulator;
>  		}
>
>  		data->pinctrl_hsic_active = pinctrl_lookup_state(data->pinctrl,
> @@ -423,7 +423,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  				"pinctrl_hsic_active lookup failed, err=%ld\n",
>  					PTR_ERR(data->pinctrl_hsic_active));
>  			ret = PTR_ERR(data->pinctrl_hsic_active);
> -			goto err_put;
> +			goto disable_hsic_regulator;
>  		}
>  	}
>
> @@ -432,11 +432,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>
>  	ret = imx_get_clks(dev);
>  	if (ret)
> -		goto disable_hsic_regulator;
> +		goto qos_remove_request;
>
>  	ret = imx_prepare_enable_clks(dev);
>  	if (ret)
> -		goto disable_hsic_regulator;
> +		goto qos_remove_request;
>
>  	ret = clk_prepare_enable(data->clk_wakeup);
>  	if (ret)
> @@ -526,12 +526,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
>  	clk_disable_unprepare(data->clk_wakeup);
>  err_wakeup_clk:
>  	imx_disable_unprepare_clks(dev);
> +qos_remove_request:
> +	if (pdata.flags & CI_HDRC_PMQOS)
> +		cpu_latency_qos_remove_request(&data->pm_qos_req);
>  disable_hsic_regulator:
>  	if (data->hsic_pad_regulator)
>  		/* don't overwrite original ret (cf. EPROBE_DEFER) */
>  		regulator_disable(data->hsic_pad_regulator);
> -	if (pdata.flags & CI_HDRC_PMQOS)
> -		cpu_latency_qos_remove_request(&data->pm_qos_req);
>  	data->ci_pdev = NULL;
>  err_put:
>  	if (data->usbmisc_data)
> --
> 2.48.1
>

