Return-Path: <stable+bounces-164478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCFDB0F75B
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 17:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 937DE1AA4E7A
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A2F469D;
	Wed, 23 Jul 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fZIHQ9QD"
X-Original-To: stable@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5961FDA
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285548; cv=fail; b=HW6q00CEL6gIszQPgSf5wWerdy7d8UqAWneBw/uuhqKky2j70e/2RCQXeTLJMYGMjS+kXbdoAsN1DCLFY3I6ni16J4FESH3de2YHm9jIcS/vSk2hWMm6TzLRBqT3oA/n3sGHTcIBKpSlmbOj6nwcwn59P5ay0/WqrDI94+IKeho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285548; c=relaxed/simple;
	bh=epI8uohk/kxTnhwOGZAi06O818nDc+g1lAsOdnglX30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p39lXYuDU+B3GAkfs5+AJfoLd83vghaqMoqsL2xSrMlQA2e6OMUxFhji4Se8sU/b2dUH/ujtP2Z8uRd6Xl9nI2PxX9f2HVuoBYG3B++KOthc7ZbTVzuWp62JZBnMbMrQ5TznwVHKeWZfzP3kndi+c15/nlPjiafUDktM/ac/Da4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fZIHQ9QD; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W/Wg0Lx92csNpjmtQcA7eHiIbnqjVoC3V5ziGvZh5BJhmMpIHmRSuNZcRzaRAral6oHLgha7ABvjuXBEzPYTVnXvpNYlQ1ePtyozrwMVjD6oHETzoMHmSmN7KX160XUddbILJPBj2M0ZrRYs2Bxu7hfdbWglSF6bnpWwgTtqeEO19FixXi9PoZqeoobx/gzIo5jhPGUaqeyrMIPAvJRC2oP3G1imC5RadXNblb8lzojipzdAGje55IDs7KPhMhuXp/y0vQKkAxQwOwc/Nlft+5ThMBfqUfeWQDoeTB2cdFKWmfLMtCfVAKmH6vNx3RqFp/ZzLX0KOr1H364oE5dN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTlufsqjf/lyUq19Rvts9oPWOzSUqJFiwK3c2kcRJmM=;
 b=RODjgkcLRoyFGjuCJrlu0HsTSufUor7ofUFZCRUoawqNsCsnzY/Vccvz1FdYD16qPGPDUJ/Yqo5sPkZx9p4QVMDgTHe24HL0WeRHSh1rDqZ4VTsZ5I/q+/HcuySoPMg3a/5gEco62i9gJYZwyACpJPRw/ii2g5JfxHs6Udg24dH9ZnnvA5uM+jvYBxIEuGJVogsYkc1pna/XjcyWxZgAsUFV9lyKO8vc1tFA/97vsicJAsUaEfSa2DPvfO8dKXKW/DSQkh5p3aN1U8r0UKYtYYTXqI/BLkHeS7O9ZkVC2RoAWdVtlYNfrYRPYDQ0NSykGnwgaQwut/duDIS9qy+1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTlufsqjf/lyUq19Rvts9oPWOzSUqJFiwK3c2kcRJmM=;
 b=fZIHQ9QDiixcVNrNDXw2mQq2DrLGal7i50r2fc/nypBHHUvEIk45K4v2uY24Kw0xzq2v/nN+ptDsElws7XcBwoUsUHMcMd1edwjPgsuZ+TQfFAddcs1k8+VOmbp09YMP8Gb1/Rsz1gJsnRdaIb5wDzPvjymwgU1TEjLgTlWlBN2I8Jk2buH4Wd5nnC3HKpNHoaqB2uhZoGFr5K+sCrezwHlIL8TtH2VPrlkap68TcZykbrJ+L74h8ytywue722aJyEDhZ2MNfVdOIdNQa7lzY7uqGaFdCQnBIHi8RjaARQ7K7xIsDYWBMbvii8We7G71NS+nbEU4EIXoW4HshJHpgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 15:45:43 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 15:45:43 +0000
Date: Wed, 23 Jul 2025 10:45:40 -0500
From: Daniel Dadap <ddadap@nvidia.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 6.12.y 2/2] ALSA: hda: Add missing NVIDIA HDA codec IDs
Message-ID: <aIEDpKEMI0zvDuhv@ddadap-lakeline.nvidia.com>
References: <2025071243-other-defy-2a7d@gregkh>
 <20250723135925.1089403-1-sashal@kernel.org>
 <20250723135925.1089403-2-sashal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723135925.1089403-2-sashal@kernel.org>
X-ClientProxiedBy: BL0PR1501CA0019.namprd15.prod.outlook.com
 (2603:10b6:207:17::32) To IA0PR12MB8422.namprd12.prod.outlook.com
 (2603:10b6:208:3de::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8422:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: 1523ab73-4bd5-4909-a791-08ddc9fffb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a+qjGsHhu8rT3gPQY7RH4WVv65XHHHEofvkg0KcV75hqaLQfoPEvgg1GQZhD?=
 =?us-ascii?Q?v7qSDdzopMbSkusr422tyMoADKFXWNNw2FQT7DqMAXyVoqpTraavIiwlZDj7?=
 =?us-ascii?Q?iH4sx5jvO8SpY1RS4p7PtyOa8NsCRmp4rAlK+evwSIzpuTXmlTtzMJbV/4EL?=
 =?us-ascii?Q?77R687ooeP6aSDIQiGx6Bq1PvmQpGIna/l/eAgaIv5+S3WY5aQS2MKiYDc2n?=
 =?us-ascii?Q?swmjUxhD20xorU/cSKIrAd1VP0mt9ssR96avFuYF+cOdVse/Q2P9QTMIe2EJ?=
 =?us-ascii?Q?UAjqdGqVl55ZZQFRVXTFsZUykrXJEcwo/mSo7TfdLglwGCUIdjU3n6CE0+iq?=
 =?us-ascii?Q?AySoSC50VoYbxESPdp3jJ0JSY/qOFIzxDe8NiFjQ+J138EQi99JX+NgZAEhs?=
 =?us-ascii?Q?RfPZXL16siG8YRnpp1+UsEoeH+BeTBRvKuRTuxte/SND0p/0QVv+SSn1orj1?=
 =?us-ascii?Q?PFWBj07m5+XazhzQg1qNYZ0MBfgxypYHmSTf6DKshfP0pkylWbhh3LLoVA5F?=
 =?us-ascii?Q?EfLUUc/1eaE+1gRQSdBRpygoHBGgf7JfNkSeCJn99DaB1jdIUtJYbHcazNB0?=
 =?us-ascii?Q?Dea2tkRqKRLbBoa1zwx9LyXN1hhgzDyqrLBwDsbpHZ/RggS94Old/k1gFSs7?=
 =?us-ascii?Q?mYQITuqMv36ehusxx2DZ8pBEj10DeiCtl3CfT/jJVNyQoYdBz2Y0hitBKLuF?=
 =?us-ascii?Q?embUJIR5O3zTbJCbyqnk9RPMNj7OaCekCLZsG8k1guw7LT2pzcyv9gIujjR7?=
 =?us-ascii?Q?X1XCA6ZnOKfvEqOBMGgncoj+w0od18IPy9bvFJu/depfMlYG/Mx5nBQyyb/4?=
 =?us-ascii?Q?7yefx9RYMSzonpJixLOBFZD5KeyxF83lOi0Fz+yyg7RLGVbgqhw5ODUa4SX+?=
 =?us-ascii?Q?nVjKduKaAT9AApmRGg+8hnQG5KmExtsoWQ1YrerVtme54ecXXVjMH6pTYjM9?=
 =?us-ascii?Q?7tlkAGxBQRLgcQjudhsKy7NLfTDgMkAZNU51ufJGqAy317PZ9X+2AoLFCBc2?=
 =?us-ascii?Q?ibR0TCNUKCQ82wAqnyTuGDO+VtvzL5m4XU8LJZx+G7Jvc8IDZjgH6GI7Buac?=
 =?us-ascii?Q?42Mh7ai4RNcf41oe/gKB7zS8STK6qzS2J5xfLT05hTGvX1WYjbGYqrXOC7c8?=
 =?us-ascii?Q?so/3wq9kLIlFZU7wcUmADBRy8/wHIB/jcAbsaaYObbna792T7PHLKm0WLh8f?=
 =?us-ascii?Q?8aJc0MYqTuFeYThs2uwkrMHR5FjWRVqMv2xm90SfFL3Ncg9hGy1udb4N+gTI?=
 =?us-ascii?Q?gjueI1PG7RaHRstbdL5FPwlea5T4Vu+v1uG5fNOnhGHPF3VZt573KbhXlSga?=
 =?us-ascii?Q?TB09jnZ5EAnuNTitoueJZGBxaNmVY3SobEjS8FUU1fXdNckbdLeX020I1aKa?=
 =?us-ascii?Q?ckXGx0zGJ6Yz/xnFV3LFYhCP2/PWfIJH5WepJLWv2Ko3Ts1guJW/WrrOU2gJ?=
 =?us-ascii?Q?A7Mf7pagV7E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2ZAAo1Vm7qzKwNjZPgVAGiRLlx+x9Vp3StYi5kWzjz8L9dxHAK3slYwQ9ZV?=
 =?us-ascii?Q?w8WlT3Jh9m/181nW9khPIQ5UwrAAnIwejtIzhSn8S9yWsKJ9WIG1bJvzH8Gt?=
 =?us-ascii?Q?++bzjpP7MTuAhG8GaXBeJnKjX6Vi0Kzw4l0b2PtCTYpspMaTRqczQw7Y+Hdp?=
 =?us-ascii?Q?q4v8dvr2lBAogOLVauuOAsChkYzgC1+Y9gMNiPM86Z5JZ2LQxbU3Rnn/CcpQ?=
 =?us-ascii?Q?A+hTzupmDj7yCEpNvucPhLztH09ZzQPElWMWZgqcrbjvvI6mHS5zxkDNyOyx?=
 =?us-ascii?Q?NBDwKOTYqi10FU/m9zxOMw8JoPn7SFEijjsrPN/Cdg23isUBQR6eU/UMJ6f0?=
 =?us-ascii?Q?AFHsgPZFk7T9QggVfeKSMhM5XBIg6yqAhI8IGnIL4lAZ5ArlvNnvObpykhDy?=
 =?us-ascii?Q?4+FkyRH9mhsEibMN31IAuJB6DNYieWXjPHHrLY5tsgWx6d87ut4VlNqC9ffO?=
 =?us-ascii?Q?9ADHslS4Iws1KT6TKED1bzknj99W0hEBdQzPi4Gj99FqqWqPCEt7j4LXSvdu?=
 =?us-ascii?Q?URcVSZ/dfxpgjFbjtu+AXDwPcFsHScUGB1Sv02Z/aO5Tq26W0it9uo4iwuiN?=
 =?us-ascii?Q?e3mdDwU1hcsQegXRChWb74Wc/JpjTq1O86Li6vqf1yaaxtdELS1ejtmTRx4c?=
 =?us-ascii?Q?h76lN9BE4gOdXwNriWOsAt/NT1ISG39+YA+K/436CjVCLHmxLlSRRlpRQyXI?=
 =?us-ascii?Q?JSoHvhz5GGawlwUd3DqW9bgCngu4yqUWN6CNNTa/bM1YpT6973EAvK3z9vNI?=
 =?us-ascii?Q?y6Le8Bg0j/L3GliQzd2ZAMZJHEV7diIwt9i73K+cBom7452Kbhs29ndBT4sG?=
 =?us-ascii?Q?RFFqInXXYAv0Cea+7ycvP7eQlFdJQ1uQw9A9wh0cHHxIj7KxcwUt6sNW6mfO?=
 =?us-ascii?Q?Rws/vypeaxz5l6J2ehtwlYOMuoOcauFN3LrH+j0WSNSvhTS+mqDsXv1sQ5XF?=
 =?us-ascii?Q?7d/I11fKEkbkf8e+SF1+KlOzt9KCpdcsmxshOpUvEnT7Z/vea8k6eTwM3nwN?=
 =?us-ascii?Q?raW4Q3an+uc/VIUISZfLvNJDlxd+bez5TiMtgyZ/pfoN0gs49FOwQgOEoCHC?=
 =?us-ascii?Q?9Ub/uCntRMLaxgTOlEJP7HhnBGuWy+4uys5EUYskDeKo6Z6kIQLjLcdTXxom?=
 =?us-ascii?Q?pnG/akq/ia2o1SSaT4UYutldf0SasNorVuicBfepIxKaMmz7josY4losTOE4?=
 =?us-ascii?Q?Uf0AqEBj9UH3i6vduqoK8jVR3/U3AR2nAmtl1OXJIr3B1zuQi9LukwMK/waf?=
 =?us-ascii?Q?VTwFbWzXr+rwAuIUTxFn/fmEaEMf4bXQBSM6WsqVRJHtfeuSdlOViQWzcUW4?=
 =?us-ascii?Q?HqWXwvuW/Dlye3MkbR6s8MMz8OuAXToPzOgEJKc+Nvw1CWwQ2nzRT1XHAMV4?=
 =?us-ascii?Q?+kLGR+D0DkiGn5cC5vRjdJJhQzVIdUpWAcTxM9oPxIWEEYDQcDFQpr+H3VKP?=
 =?us-ascii?Q?kmU87r/kv3PV3HxnfjdakuPpQ3+A+3L21GmrkbY/aND1hCQoPCSgDDHgJSZA?=
 =?us-ascii?Q?0SgvfJLTeJ4RgT0O6qkMmy4k6UZ5GnoE46s/fKCNGJrmNE+G1lrQNOI/4VJX?=
 =?us-ascii?Q?iwRBpKojR8oWEfyoHBW/QhEv7sFrdCImUxJ/s4/c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1523ab73-4bd5-4909-a791-08ddc9fffb7b
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 15:45:43.1129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwLWOIEbs+ddTwJv6UnnJ711edfwFWyvqanwy/Au7e8Aqx0sW+hiw6eb+k9FyDnoJl5lcqukuD8Eiv4F4GdJBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

Thanks, Sasha - I had gotten a bot message about this patch having merge
conflicts when backporting to the stable branches, but promptly forgot
about it. The "SoC 33" and "SoC 35" codecs are on devices that need the
new snd-hda-acpi driver, so if that driver isn't also getting backported
those entries aren't needed. And the platforms that those HDA devices are
on would also need many more backports for hardware enablement beyond the
HDA ACPI driver, so it seems unlikely that you'd ever be booting one of
these stable branch kernels on those platforms.

Then again, it is probably harmless enough to have the codec entries in
there even if they can't be used, their respective records don't take up
that much space, and it's one less thing to worry about if somebody does
want to backport all of the required hardware enablement changes to the
stable branch kernels.

I noticed that you used patch_tegra_hdmi instead of patch_tegra234_hdmi
in the kernels that were too old to have the tegra234 patch function. I
will do a quick test to make sure that the device still works with the
patch_tegra_hdmi entry (on a newer kernel; I'm not particularly inclined
to try to get an older kernel working well enough to test this there). I
expect that it should still work, but if it doesn't, it's probably worth
dropping the "SoC 3*" entries from those branches regardless of whether
they've been dropped more generally. I'll reply to the patch for one of
the older branches with the results of my experiment.

On Wed, Jul 23, 2025 at 09:59:25AM -0400, Sasha Levin wrote:
> From: Daniel Dadap <ddadap@nvidia.com>
> 
> [ Upstream commit e0a911ac86857a73182edde9e50d9b4b949b7f01 ]
> 
> Add codec IDs for several NVIDIA products with HDA controllers to the
> snd_hda_id_hdmi[] patch table.
> 
> Signed-off-by: Daniel Dadap <ddadap@nvidia.com>
> Cc: <stable@vger.kernel.org>
> Link: https://patch.msgid.link/aF24rqwMKFWoHu12@ddadap-lakeline.nvidia.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/pci/hda/patch_hdmi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 7272197a860e7..b05ef4bec6609 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -4551,7 +4551,9 @@ HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
>  HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
>  HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
>  HDA_CODEC_ENTRY(0x10de0031, "Tegra234 HDMI/DP", patch_tegra234_hdmi),
> +HDA_CODEC_ENTRY(0x10de0033, "SoC 33 HDMI/DP",	patch_tegra234_hdmi),
>  HDA_CODEC_ENTRY(0x10de0034, "Tegra264 HDMI/DP",	patch_tegra234_hdmi),
> +HDA_CODEC_ENTRY(0x10de0035, "SoC 35 HDMI/DP",	patch_tegra234_hdmi),
>  HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
> @@ -4590,15 +4592,32 @@ HDA_CODEC_ENTRY(0x10de0097, "GPU 97 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de0098, "GPU 98 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de0099, "GPU 99 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de009a, "GPU 9a HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de009b, "GPU 9b HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de009c, "GPU 9c HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de009e, "GPU 9e HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00a1, "GPU a1 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de00a3, "GPU a3 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de00a4, "GPU a4 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de00a5, "GPU a5 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de00a6, "GPU a6 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de00a7, "GPU a7 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00a8, "GPU a8 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00a9, "GPU a9 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00aa, "GPU aa HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00ab, "GPU ab HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00ad, "GPU ad HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00ae, "GPU ae HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00af, "GPU af HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00b0, "GPU b0 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00b1, "GPU b1 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00c0, "GPU c0 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00c1, "GPU c1 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00c3, "GPU c3 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00c4, "GPU c4 HDMI/DP",	patch_nvhdmi),
> +HDA_CODEC_ENTRY(0x10de00c5, "GPU c5 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
>  HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
>  HDA_CODEC_ENTRY(0x67663d82, "Arise 82 HDMI/DP",	patch_gf_hdmi),
> -- 
> 2.39.5
> 

