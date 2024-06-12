Return-Path: <stable+bounces-50258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8799053CD
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C6F1F23040
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 13:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FC617B511;
	Wed, 12 Jun 2024 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="YYyHDS22"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F06F176ACD;
	Wed, 12 Jun 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198891; cv=none; b=G24kteH+x8PDpV25AgyPW6k7cISilaLiIZZKPJ4Pq6YVxTiSyQrYEDfD2HSdlKRM7wqgzF5eXxTsz70NNcnZArB+E70EG34sEb++As4NgzvwVMmYo1NmD4py/KbYFbrJW6Pn/bKnhgt1fT4l3HL0dFO+AEB3SVafVitnWzmgER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198891; c=relaxed/simple;
	bh=gB2qcYBlp6AUro7UgWKhRGLkwMDMrcuWA2Fwl19jD0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foD9B34QctGK4HKP09URoEkVKYLlLosG6eNoThMxH2dFRZNasHG85V90oV6xJ+NyzaS4aeDyv95dDvh66PZym462hL8Eq1Mqzd2X6DcYMr3Lfjy+CnP5XhJ4oNnbDwatWuzfN/+GcFv0R+7uq2XmX3v6WUUPVTcNYKF7+z8Hwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=YYyHDS22; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=mLhQQIGQlskOYaBcJkFs0QBTdU7FLcK/wqX92dmx0i0=;
	t=1718198889; x=1718630889; b=YYyHDS22kNlzhzFoeSSrFmLqpiE95Hxy+6P95jU51fj5/5s
	JUy3JAy04H54tQZc/WMQ69VkZS3dVFQRaL/pSMlInnZ1axPSX59ROFB9jNsmCYWp7D6JJffyMCjyD
	hVoX4v6My++nMziS/VwpFFY0RVJ9t2+5wUsFnBaKxc2X7RsP8owhzSt/32XdNe3DGqrxgGj33LpHO
	SsAmysDR1SxmMvw8Eps1zrK85FVeTysjsIQLuKhlcUTNmv42hn9D82vtLtxUxhIurDweEPVP2mZ9h
	BmHBjuiW7muq3SWlKisx5nJkFSYuN6XxqEskuEhXRk61NISl/PI4WRxx/+MKQUKQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sHO1C-0007Ep-V0; Wed, 12 Jun 2024 15:28:03 +0200
Message-ID: <8be80682-067a-4685-9830-cfed0287e617@leemhuis.info>
Date: Wed, 12 Jun 2024 15:28:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v4 1/5] clk: sunxi-ng: common: Support minimum and maximum
 rate
To: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
 Frank Oltmanns <frank@oltmanns.dev>, stable@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, =?UTF-8?Q?Guido_G=C3=BCnther?=
 <agx@sigxcpu.org>, Purism Kernel Team <kernel@puri.sm>,
 Ondrej Jirman <megi@xff.cz>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
 <20240310-pinephone-pll-fixes-v4-1-46fc80c83637@oltmanns.dev>
 <yw1xo78z8ez0.fsf@mansr.com>
 <c4c1229c-1ed3-4b6e-a53a-e1ace2502ded@oltmanns.dev>
 <yw1x4jap90va.fsf@mansr.com> <yw1xo78w73uv.fsf@mansr.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <yw1xo78w73uv.fsf@mansr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718198889;f7fcbcb9;
X-HE-SMSGID: 1sHO1C-0007Ep-V0

On 23.05.24 20:58, Måns Rullgård wrote:
> Måns Rullgård <mans@mansr.com> writes:
>> Frank Oltmanns <frank@oltmanns.dev> writes:
>>> 21.05.2024 15:43:10 Måns Rullgård <mans@mansr.com>:
>>>> Frank Oltmanns <frank@oltmanns.dev> writes:
>>>>
>>>>> The Allwinner SoC's typically have an upper and lower limit for their
>>>>> clocks' rates. Up until now, support for that has been implemented
>>>>> separately for each clock type.
>>>>>
>>>>> Implement that functionality in the sunxi-ng's common part making use of
>>>>> the CCF rate liming capabilities, so that it is available for all clock
>>>>> types.
>>>>>
>>>>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>>>>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>>>>> Cc: stable@vger.kernel.org
>>>>> ---
>>>>> drivers/clk/sunxi-ng/ccu_common.c | 19 +++++++++++++++++++
>>>>> drivers/clk/sunxi-ng/ccu_common.h |  3 +++
>>>>> 2 files changed, 22 insertions(+)
>>>>
>>>> This just landed in 6.6 stable, and it broke HDMI output on an A20 based
>>>> device, the clocks ending up all wrong as seen in this diff of
>>>> /sys/kernel/debug/clk/clk_summary:
> [...]
> 
>>>> Reverting this commit makes it work again.
>>> Thank you for your detailed report!
> [...]
> It turns out HDMI output is broken in v6.9 for a different reason.
> However, this commit (b914ec33b391 clk: sunxi-ng: common: Support
> minimum and maximum rate) requires two others as well in order not
> to break things on the A20:
> 
> cedb7dd193f6 drm/sun4i: hdmi: Convert encoder to atomic
> 9ca6bc246035 drm/sun4i: hdmi: Move mode_set into enable
> 
> With those two (the second depends on the first) cherry-picked on top of
> v6.6.31, the HDMI output is working again.  Likewise on v6.8.10.

They from what I can see are not yet in 6.6.y or on their way there (6.8
is EOL now). Did anyone ask Greg to pick this up? If not: Månsm could
you maybe do that? CCing him on a reply and asking is likely enough if
both changes apply cleanly.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot introduced: 547263745e15a0
#regzbot fix: drm/sun4i: hdmi: Move mode_set into enable
#regzbot poke

