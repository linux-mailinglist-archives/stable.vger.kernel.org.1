Return-Path: <stable+bounces-164490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF9DB0F857
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 18:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9D83A8BCC
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 16:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96381E1DFC;
	Wed, 23 Jul 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nLY4f//s"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E01FC3
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289188; cv=fail; b=aHFsA8jBuQTTnA30PIs4j4F6we/b4Kyids9lTDhGuKyTIxaH1Jqm/eOrQkBvQZc5mhAgy4BQiu6mdEu0jl4FzYD6syVdgcEkxqw43eoHjNPp+vxvtuWwEUzKR6lMSV3riyFMbW99y734OlTwHxWfTalby+OBa/VmiJY0wb4gv60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289188; c=relaxed/simple;
	bh=lDTtCK2YZflndVVKmp2zQY96TvfWxsxF+F4wUC4q+Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r9OKNaBprMvSQdTsQZzGrXEJIJ0UL7kyHFv8k3o50wmQHf5KrCSET9/uemujFdbpPUrCSuBn38C/PLHnct2AVFkHPfc9hTIZ/d+2s/YWt3JhILAT8ztzqhbTYFqdqbYekdOvvMNo9bIJrD5AqJrtHrzX5AS/UawnUSkEz1gx0zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nLY4f//s; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8zALOEX12Q9eAPuDJlJKvN12Vv8HT7jCoDo+jFVxXU0RL5jdK22XCZWeKSMdPCSIW/2Qjo/nWBztrYg0ThDBjVZ7cN+Buh/W772qvd9CTJLfxI9iVZpGmN+z3mc7qsOaYX/+to15GcCR+MEgkDz0lEZ3G5VvRQdIz8a8z/IXJlOuJwoID3OF88XdL4kSE0vyRv/PYOLQqgFUPLCB2quI5bnumW0LTP69zBI07uMMKoGOjgcHu9T+/RpCCOCJTx8UA/HEf1ju8zJ5960ZinBfl4XycGqrA/7Gbvc+gG8TYnfcX04IuAcuh/NK6PGghG1+MPtIp40FHg1xG0UZvdkig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=103JgFtu90s8BJiytbyNhad7TNl6zdNuYovngETFNBE=;
 b=MBUOTPbw0sjI9+RhsG7WpVVzqX/6OLXqzD3dmmvNLJA/Y6FjJtKzzCqbFfWqr76ly0yi20ugKuv1jld0HF2Vzu67CoqgPuhV/I41Z8jR5X0aZZHQqCt4uPdEq9P338IuGzy52SUe6lkQemgTF7YHvKjyOwnQS65kQBWIFhZZJf4S0xKXiZfgRrEgIb/yqnDa3hvuWGtw1yW3koXAQtFp/YK6JbpvqtJQ0MNu53Ch8MSLUo+GecKn208al/QsaNdASThQHh5AjL4LI0Rsi363F0rsJ8oBADupk+C8ga6I+OzRiNVYyxql0oRG4z8M41/oqGnDOcEpx9rb5Afk0hr6FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=103JgFtu90s8BJiytbyNhad7TNl6zdNuYovngETFNBE=;
 b=nLY4f//s1XIBekfjPjDX7kpFNx9BezodEkvC+Cx1OLbvN2Tg5g8n+jI4GP3bB0pkEWx3NgtAXCXRDu+o/SYsvMd1QSVnIc0qfP8cTi0Exh6/PQGKfi1qvEkJTQ7Gz20i+imGOGJweA+R6NcYEv8B3kmjLw434c6iZJamTWRSaOXcE0TP6Acxp0C0hwfrVZreRcRWLqUjrnOr6unoSCDq79DsLsKoTYd3QwJCHXiijCeDxTC549EZbwY3p9CgMZvdV8M5ntBarwTx7b3odfr7Kdrzm+8KoCwF1Dt1F9njE7K/lqQx7W7E7UmpHRNaF0h/nkfBxqb9OujX4ZagXQzfQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 by DS7PR12MB6047.namprd12.prod.outlook.com (2603:10b6:8:84::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 16:46:23 +0000
Received: from IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650]) by IA0PR12MB8422.namprd12.prod.outlook.com
 ([fe80::50d8:c62d:5338:5650%6]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 16:46:23 +0000
Date: Wed, 23 Jul 2025 11:46:21 -0500
From: Daniel Dadap <ddadap@nvidia.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.15.y] ALSA: hda: Add missing NVIDIA HDA codec IDs
Message-ID: <aIER3X-61j_VVKkr@ddadap-lakeline.nvidia.com>
References: <2025071244-canon-whacky-600c@gregkh>
 <20250723141042.1090223-1-sashal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723141042.1090223-1-sashal@kernel.org>
X-ClientProxiedBy: SN1PR12CA0072.namprd12.prod.outlook.com
 (2603:10b6:802:20::43) To IA0PR12MB8422.namprd12.prod.outlook.com
 (2603:10b6:208:3de::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8422:EE_|DS7PR12MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: e728a6b9-22f5-41c6-cd92-08ddca08754f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WdCChC2HNtlWtfVcQ34HRoISR27mRkAJhIvfRnnYXSyRYMahy2XmmRBlWloT?=
 =?us-ascii?Q?MjmxXGplB203D7FDg2I6VjfMryi7LQwUU/cI64LPf3l94rGdAcgtKHQdArFi?=
 =?us-ascii?Q?ghwmVT4pWg+IOxxJl4RCkoYZFvcTO/jt1DJ037mW2xW5pE+htALQVL04JjoI?=
 =?us-ascii?Q?iN8jFVtb3CPJQmxDBmWQjdW7DqfNeDXppm5S0mbQXARaAgzhm6snC+b3fq5i?=
 =?us-ascii?Q?Fv8s8TpMD7wntOpTB4+W2VwHR3xNI+o8ujJnJF0o+My+38fkjhbmQBqV114r?=
 =?us-ascii?Q?Po6RxxjGQBLRp7Mti5kKAC1AQW/0C1qlxIRfOp6NLQuhQgropXKua8mG5i5J?=
 =?us-ascii?Q?mQTln/17M5NAGmQBwRxRw6i3gIs9EWW5mxjQt+/s/uJ8DjM+VtdIYC6B0QRU?=
 =?us-ascii?Q?NgYl5a2lSmPsgz6ii0xZOgWC7FuxwJ3rROjDKcozdUSfo/tz7FBUHmkRwAoe?=
 =?us-ascii?Q?1EW4y/KcN6vTlmtHSvS6z9bfCkczEoxwhIyQ1E804qw5EgEmbmJux03NZ09B?=
 =?us-ascii?Q?JAdaT1NM5l9m0KhBm47lsA29uezf8hve1F9U43ShGrDhht2mGQYzxTbBjf+M?=
 =?us-ascii?Q?bjF8Ac0OZ3v/qa1UZAV0dsh3QyJ9t9VSyLDPIkM0lYEpkdRNYFFbw46tPdyU?=
 =?us-ascii?Q?tBq40JbzrS2sN+/CfnkzPwnAjChDnQAIlUzS0n7DPxsyoVdzWJA6KRSjLX/y?=
 =?us-ascii?Q?fV88pvD4WtkdkLi8A2xaJVqBb6IB0g+8rgis6e9TvUr0KxWbw8bBFcOtRkth?=
 =?us-ascii?Q?2O91nofxHb0VJsrrbdu5aA5PTZLbtYys8wdK+xIUU5Ee0GmEhSwk29ofVBfc?=
 =?us-ascii?Q?SyVVQT+6ced4OpZqilfrHigzZnAWXp4SnFg11U+7X0/5D5nNxIr4TWKOGgY8?=
 =?us-ascii?Q?Ou2DW3eiD9xSa7d+7bXumSszYisL90K9assXin+WqZyZa53AAnZl/VBmQc0P?=
 =?us-ascii?Q?goC8SKhRZwhzQKzzfYjXiW6E4RKpESSmp6yJk6Z5IY36yxcT28LF5sfBLJzh?=
 =?us-ascii?Q?qAB9bwW2GRnx3c1XeVHpcH1ux73J7s6oxf7evrY5KoNkb6Z6FO7ODaDWwnd8?=
 =?us-ascii?Q?I3aBPobFNKHRRmyRWyhfjQOdGQTqDJiicBqfCRLlXmQG7x2JE2/BMiMEOtmh?=
 =?us-ascii?Q?5GecS8l9s7/jaBk++YUOnPodXeqLW/v+fuMmZO2m4bUBYr6XGhMgihp7qmh5?=
 =?us-ascii?Q?fT0OPNGyQG1O6+uSeusEOyiEBFMYa8leVdpP6HyDJd5gcXLgf5v31rV6+IlX?=
 =?us-ascii?Q?7uyH0o1JdTppEKjlfxSRlocZzf7f/32HjmI7TyUQ60Idb4JqTv8QiShFp9Im?=
 =?us-ascii?Q?misuKYi2eBhTYOf5Icv7acbruzXdIhIPS1vsShsVNoRd555+6p7dRgw9TkKP?=
 =?us-ascii?Q?5fBXRSekK3nrkSx6bL0ZVJ3nNLZPNX3jPpf9TdduPuVHoOv0MA90w9U9wGaM?=
 =?us-ascii?Q?wvycxbiKjQo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xIiDJpV4z1fbARNkPfxlsjNL6/+e2+xON5/yK1uWeY7n7tpF0lRajNLQQzxj?=
 =?us-ascii?Q?F33J3u1v7gsvN9WLsAWix8UslX1VKpmCfbIcoAH0k2BJmFc+QA6q6L2eGDGw?=
 =?us-ascii?Q?9MMYGNqS9bMQoGeDIJsJcfdSZd+Z/8MN510QRPJqYeLhfKt2ptogbu6it/Zd?=
 =?us-ascii?Q?9pQPsTKNUYBewm+HA5ZcnosTu5ztxXDSvL6wPj1hE2AHbrfZYbM8VNg8wr3t?=
 =?us-ascii?Q?GQThtTJ92uEK6s89+wndbnBFnLYcK0D5bONEZbJI2Jeox87IHhXrQauIG3pY?=
 =?us-ascii?Q?QRNhU8cR4Vhrrx2oVlpKg0M/S2+jm68szAkjQmF8NNwrrpU+LXnOMDnYLb0a?=
 =?us-ascii?Q?Qf7oYs6VC3lrAnhffzCLTH/uSMkmw4nU2hzjrA/qM8Wk0JgqFk24/62ABCZm?=
 =?us-ascii?Q?G/Ny1VvG6wMyrKkXCEulF/Yn1zhc6ONCRinHxstKspHCGeTZauxjrGorBohv?=
 =?us-ascii?Q?O1RgPpqldJ3PBnCiQOSrM73wAcNA4zV3K0gnhqFDBf29hVp0E6C5sdQd+BcT?=
 =?us-ascii?Q?UalZuZMZ1/KtqAa5kgSzEOUWqpOXqoo8JQ1t2OderrC+40W/XvTwXNqtvKx8?=
 =?us-ascii?Q?IjUuNR+uqkCefDEqe10McfAFlLtGXTqSAFL+NbvCJQGzitfhN1y/UDjzHw55?=
 =?us-ascii?Q?YtJvSxF0xEhc+KEZGEXbDsWZyAaIrRbSuE7zqVdhRW6GtgSwyqR1Ctm5kl7w?=
 =?us-ascii?Q?+kfky1V+9ea7rtd635WVw8f41s+Lbt6tWf7tU8YKx8Df9vyZC2mymhyXQQz+?=
 =?us-ascii?Q?1XP/8z9TLcFsIHVF2UEtxdDckCGccnHBQEudzgjU9HEgwWHDnS1XtW0m6lwX?=
 =?us-ascii?Q?5gi2tiy7almxAPX7jUkQKQG6OYnLCtlfoOetrWqZ5sgsEZkvu6mltg1RY88i?=
 =?us-ascii?Q?BxlHwbkn6CxpvUtdRrDd4hWZDA+ILLW5oVODjap2PQlEjbyOciSIcucHneq5?=
 =?us-ascii?Q?SOQU0r+RlyGlRI8U7Pg/BKSbQdujThUdqbn+NX8JKUINOZAT93gWszuz1y0S?=
 =?us-ascii?Q?T5g8pZItmjy6QvzYMEWaQCg5a4/oduFl8AHLWdAHgWrLSDZPuDHFOLRBgZ4y?=
 =?us-ascii?Q?3DscqPKp9B7JwOBZOYupJupiDaL18w2AlpeMudC8L0CGGhdATNZZ4kr9OVFZ?=
 =?us-ascii?Q?kMe4L1ZI2gJGsD0QFOqwkYSq6eyCk8fbRwp2h+JjjMuhrSA9jv9RUHBHx75M?=
 =?us-ascii?Q?OCCHZrWaQFHN/wdilNZpU8smWco7ESpzk+cYYKt2/WTbWN3I5rUUPqaqBJi6?=
 =?us-ascii?Q?dDUleW9hSZszrJVTALUkhbXNxDmZn8wNGbH8XH3fxGLJOhUklJeO/DwIlkTo?=
 =?us-ascii?Q?b9t5wAAEvEdIRBhwjP33E/qaLDr88JvtMj/3PzFL2TOjTQ36nRQAo73z7nSk?=
 =?us-ascii?Q?oRSQDhZXmvtcyjuFqnVxdwfH0HGauLhWealpUFabmM6WuRzH/mdkugMBtOnP?=
 =?us-ascii?Q?96EtDxtjKuxL2blnkK/qkYgL4HHbW7Oo3ngG38kXgC/3osgm90J5T8S32JAB?=
 =?us-ascii?Q?sYw4Q/AkotfO+0nesYGS9/9uP2oqMB3OO7HtYMVkrcVIlG8WSgvswwzO9GbG?=
 =?us-ascii?Q?mxtWwUC9fTfV6kcHU5v/A7RkEh2x4DIl58ZOi1HN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e728a6b9-22f5-41c6-cd92-08ddca08754f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8422.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 16:46:23.4912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 68OD9FNVtYaxp7CJrbncF0YfjVx6mpegr65APytceUPhYC6eS931qq5H1WIF4ERl4uEqqx819uYKJ+qnpV1L5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6047

On Wed, Jul 23, 2025 at 10:10:42AM -0400, Sasha Levin wrote:
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
> [ change patch_tegra234_hdmi function calls to patch_tegra_hdmi ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/pci/hda/patch_hdmi.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 81025d45306d3..fcd7d94afc5d5 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -4364,6 +4364,8 @@ HDA_CODEC_ENTRY(0x10de002d, "Tegra186 HDMI/DP0", patch_tegra_hdmi),
>  HDA_CODEC_ENTRY(0x10de002e, "Tegra186 HDMI/DP1", patch_tegra_hdmi),
>  HDA_CODEC_ENTRY(0x10de002f, "Tegra194 HDMI/DP2", patch_tegra_hdmi),
>  HDA_CODEC_ENTRY(0x10de0030, "Tegra194 HDMI/DP3", patch_tegra_hdmi),
> +HDA_CODEC_ENTRY(0x10de0033, "SoC 33 HDMI/DP",	patch_tegra_hdmi),
> +HDA_CODEC_ENTRY(0x10de0035, "SoC 35 HDMI/DP",	patch_tegra_hdmi),

I tested a modified snd-hda-codec-hdmi.ko which patched one of these to
patch_tegra_hdmi instead of patch_tegra234_hdmi, and it still worked
correctly as far as I could tell with a few brief checks. However, it
seems like patch_nvhdmi might be a better match, at least based on how
it seems to behave with DP MST, so if we don't decide to drop the codec
entries for 0x10de0033 and 0x10de0035 in the older branches it might be
good to use patch_nvhdmi.

It probably does make more sense to drop the SoC codec entries for the
backports, the more I think about it. It makes sense to backport dGPU
codec entries since somebody could put an add-in-board into an existing
system running an LTS kernel, but for new SoCs you'd want the kernel to
be recent enough to support all of the hardware on the system. Notably,
we don't seem to have backported HDA codec entries for other SoCs like
the T234 that patch_tegra234_hdmi was added for in the first place.

>  HDA_CODEC_ENTRY(0x10de0040, "GPU 40 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de0041, "GPU 41 HDMI/DP",	patch_nvhdmi),
>  HDA_CODEC_ENTRY(0x10de0042, "GPU 42 HDMI/DP",	patch_nvhdmi),
> @@ -4402,15 +4404,32 @@ HDA_CODEC_ENTRY(0x10de0097, "GPU 97 HDMI/DP",	patch_nvhdmi),
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

