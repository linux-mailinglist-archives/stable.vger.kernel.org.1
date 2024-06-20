Return-Path: <stable+bounces-54730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C39109DB
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 17:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE691C20C05
	for <lists+stable@lfdr.de>; Thu, 20 Jun 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D356D1B0120;
	Thu, 20 Jun 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="jQDVSjGX"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D41AF696;
	Thu, 20 Jun 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897286; cv=none; b=fv2Cw5Pzfre5o20YHZVm6ZYq01MgYWN81f5wvGpqUVc75y+ayppHa4UkMjZZfS3x9xL4wjBX2pZ2hqNoOxzdKi5j6LoBOz0vXRiNu0Sls9MhPwPPKh9NFIJ72LLJXY0fGRimpDSf/I7ZktQ9TaSM1s2cQN5LT7EHna21V4H8lTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897286; c=relaxed/simple;
	bh=7s/GgozfT+ondKXUjUHdu0YJI5v0swUbkHAKaY+yJAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SZMDu+157nWY39uHHfp+PKzTTm7CplM/0aL/RfOqLbcUqGmMYFq1bnK85X68PQr7JgFfoVmWOsu2AqEtjHUNxl9jwKtkB6wAxXQWmq/MbP56HormkUNZ7eE4J9YrWRPKQGpA3RI0F/BXG2N1T1yJ2uvKXj29MVbfxurUz8SphmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=jQDVSjGX; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4W4krt39D1z9sjJ;
	Thu, 20 Jun 2024 17:27:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1718897278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8JdJmTYmrJxymjqofTE5vBKUb3MIfVPix60gmXCDLm0=;
	b=jQDVSjGXutf0qd0A0rEZcKmNV2QOCNYHYmjuTiN3ZQH6plr1OFAuMDoW66lHH2t/XXfEqX
	10K2nGEX0jlsyKrsoOC7HKBk4MdCWWBPhfjJAB1GmNzIleKRV4MdyXk//DBrxIkKDkJdmB
	j8LWzG+Q2opKoGG3TnAKREt/GOkf1kuujTdHYZWd44j0N3Mn0KLctLRPFl7ezu/yOJafDO
	zS7c6MEKTLIRQBcF24+HipYik5wocQQOc74tgu4CcxLXMIDFGst269hvEuSKKeqfptYi2K
	xizqFijlyuI2scDZkCq8phL1lQ5/LUl9RFJDjIK2hoXnz64FsdnB4+WhHF/ezw==
From: Frank Oltmanns <frank@oltmanns.dev>
To: "Pafford, Robert J." <pafford.9@buckeyemail.osu.edu>
Cc: Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Chen-Yu Tsai <wens@csie.org>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Samuel Holland <samuel@sholland.org>,  Guido
 =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,  Purism Kernel Team
 <kernel@puri.sm>,  Ondrej
 Jirman <megi@xff.cz>,  Neil Armstrong <neil.armstrong@linaro.org>,
  Jessica Zhang <quic_jesszhan@quicinc.com>,  Sam Ravnborg
 <sam@ravnborg.org>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>,  Rob Herring
 <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
  "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,  "linux-sunxi@lists.linux.dev"
 <linux-sunxi@lists.linux.dev>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>,  "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] clk: sunxi-ng: common: Support minimum and
 maximum rate
In-Reply-To: <DM6PR01MB58047C810DDD5D0AE397CADFF7C22@DM6PR01MB5804.prod.exchangelabs.com>
	(Robert J. Pafford's message of "Fri, 14 Jun 2024 23:52:08 +0000")
References: <20240310-pinephone-pll-fixes-v4-1-46fc80c83637@oltmanns.dev>
	<DM6PR01MB58047C810DDD5D0AE397CADFF7C22@DM6PR01MB5804.prod.exchangelabs.com>
Date: Thu, 20 Jun 2024 17:27:40 +0200
Message-ID: <87wmmjfxcj.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Robert,

I'm truly sorry for the trouble the patch has caused you and for my late
reply!

On 2024-06-14 at 23:52:08 +0000, "Pafford, Robert J." <pafford.9@buckeyemail.osu.edu> wrote:
>> The Allwinner SoC's typically have an upper and lower limit for their
>> clocks' rates. Up until now, support for that has been implemented
>> separately for each clock type.
>>
>> Implement that functionality in the sunxi-ng's common part making use of
>> the CCF rate liming capabilities, so that it is available for all clock
>> types.
>>
>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/clk/sunxi-ng/ccu_common.c | 19 +++++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu_common.h |  3 +++
>>  2 files changed, 22 insertions(+)
>
> This patch appears to cause a buffer under-read bug due to the call to 'hw_to_ccu_common', which assumes all entries
> in the desc->hw_clocks->hws array are contained in ccu_common structs.
>
> However, not all clocks in the array are contained in ccu_common structs. For example, as part
> of the "sun20i-d1-ccu" driver, the "pll-video0" clock holds the 'clk_hw' struct inside of a 'clk_fixed_factor' struct,
> as it is a fixed factor clock based on the "pll-video0-4x" clock, created with the CLK_FIXED_FACTOR_HWS macro.
> This results in undefined behavior as the hw_to_ccu_common returns an invalid pointer referencing memory before the
> 'clk_fixed_factor' struct.
>

Great catch! At first glance, it seems to me that calling
clk_hw_set_rate_range() in sunxi_ccu_probe() should not have happenend
in the loop that iterates over the hw_clks.

Instead we should add one more loop that iterates over the ccu_clks.
Note, that there is already one such loop but, unfortunately, we can't
use that as it happens before the hw_clks loop and we can only call
clk_hw_set_rate_range() after the hw_clk has been registered.

Hence, I propose to move the offending code to a new loop:
	for (i = 0; i < desc->num_ccu_clks; i++) {
		struct ccu_common *cclk = desc->ccu_clks[i];

		if (!cclk)
			continue;

		if (cclk->max_rate)
			clk_hw_set_rate_range(&cclk->hw, common->min_rate,
					      common->max_rate);
		else
			WARN(cclk->min_rate,
			     "No max_rate, ignoring min_rate of clock %d - %s\n",
			     i, cclk->hw.init->name);
	}

I haven't tested (or even compiled) the above, but I'll test and send a
patch within the next few days for you to test.

Thanks again,
  Frank

>
> I have attached kernel warnings from a system based on the "sun8i-t113s.dtsi" device tree, where the memory contains
> a non-zero value for the min-rate but a zero value for the max-rate, triggering the "No max_rate, ignoring min_rate"
> warning in the 'sunxi_ccu_probe' function.
>
>
> [    0.549013] ------------[ cut here ]------------
> [    0.553727] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.c:155 sunxi_ccu_probe+0x105/0x164
> [    0.563153] No max_rate, ignoring min_rate of clock 6 - pll-periph0-div3
> [    0.569846] Modules linked in:
> [    0.572913] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.32-winglet #7
> [    0.579540] Hardware name: Generic DT based system
> [    0.584350]  unwind_backtrace from show_stack+0xb/0xc
> [    0.589445]  show_stack from dump_stack_lvl+0x2b/0x34
> [    0.594531]  dump_stack_lvl from __warn+0x5d/0x92
> [    0.599275]  __warn from warn_slowpath_fmt+0xd7/0x12c
> [    0.604354]  warn_slowpath_fmt from sunxi_ccu_probe+0x105/0x164
> [    0.610299]  sunxi_ccu_probe from devm_sunxi_ccu_probe+0x3d/0x60
> [    0.616317]  devm_sunxi_ccu_probe from sun20i_d1_ccu_probe+0xbf/0xec
> [    0.622681]  sun20i_d1_ccu_probe from platform_probe+0x3d/0x78
> [    0.628542]  platform_probe from really_probe+0x81/0x1d0
> [    0.633862]  really_probe from __driver_probe_device+0x59/0x130
> [    0.639813]  __driver_probe_device from driver_probe_device+0x2d/0xc8
> [    0.646283]  driver_probe_device from __driver_attach+0x4d/0xf0
> [    0.652216]  __driver_attach from bus_for_each_dev+0x49/0x84
> [    0.657888]  bus_for_each_dev from bus_add_driver+0x91/0x13c
> [    0.663567]  bus_add_driver from driver_register+0x37/0xa4
> [    0.669066]  driver_register from do_one_initcall+0x41/0x1c4
> [    0.674740]  do_one_initcall from kernel_init_freeable+0x13d/0x180
> [    0.680937]  kernel_init_freeable from kernel_init+0x15/0xec
> [    0.686607]  kernel_init from ret_from_fork+0x11/0x1c
> [    0.691674] Exception stack(0xc8815fb0 to 0xc8815ff8)
> [    0.696739] 5fa0:                                     00000000 00000000 00000000 00000000
> [    0.704926] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.713111] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    0.719765] ---[ end trace 0000000000000000 ]---
> [    0.724452] ------------[ cut here ]------------
> [    0.729082] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.c:155 sunxi_ccu_probe+0x105/0x164
> [    0.738518] No max_rate, ignoring min_rate of clock 9 - pll-video0
> [    0.744730] Modules linked in:
> [    0.747801] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.6.32-winglet #7
> [    0.755911] Hardware name: Generic DT based system
> [    0.760696]  unwind_backtrace from show_stack+0xb/0xc
> [    0.765768]  show_stack from dump_stack_lvl+0x2b/0x34
> [    0.770859]  dump_stack_lvl from __warn+0x5d/0x92
> [    0.775600]  __warn from warn_slowpath_fmt+0xd7/0x12c
> [    0.780668]  warn_slowpath_fmt from sunxi_ccu_probe+0x105/0x164
> [    0.786620]  sunxi_ccu_probe from devm_sunxi_ccu_probe+0x3d/0x60
> [    0.792664]  devm_sunxi_ccu_probe from sun20i_d1_ccu_probe+0xbf/0xec
> [    0.799035]  sun20i_d1_ccu_probe from platform_probe+0x3d/0x78
> [    0.804901]  platform_probe from really_probe+0x81/0x1d0
> [    0.810229]  really_probe from __driver_probe_device+0x59/0x130
> [    0.816171]  __driver_probe_device from driver_probe_device+0x2d/0xc8
> [    0.822624]  driver_probe_device from __driver_attach+0x4d/0xf0
> [    0.828566]  __driver_attach from bus_for_each_dev+0x49/0x84
> [    0.834237]  bus_for_each_dev from bus_add_driver+0x91/0x13c
> [    0.839925]  bus_add_driver from driver_register+0x37/0xa4
> [    0.845441]  driver_register from do_one_initcall+0x41/0x1c4
> [    0.851123]  do_one_initcall from kernel_init_freeable+0x13d/0x180
> [    0.857335]  kernel_init_freeable from kernel_init+0x15/0xec
> [    0.863022]  kernel_init from ret_from_fork+0x11/0x1c
> [    0.868096] Exception stack(0xc8815fb0 to 0xc8815ff8)
> [    0.873145] 5fa0:                                     00000000 00000000 00000000 00000000
> [    0.881332] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.889525] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    0.896165] ---[ end trace 0000000000000000 ]---
> [    0.900821] ------------[ cut here ]------------
> [    0.905471] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.c:155 sunxi_ccu_probe+0x105/0x164
> [    0.914885] No max_rate, ignoring min_rate of clock 12 - pll-video1
> [    0.921143] Modules linked in:
> [    0.924208] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.6.32-winglet #7
> [    0.932308] Hardware name: Generic DT based system
> [    0.937102]  unwind_backtrace from show_stack+0xb/0xc
> [    0.942173]  show_stack from dump_stack_lvl+0x2b/0x34
> [    0.947254]  dump_stack_lvl from __warn+0x5d/0x92
> [    0.952004]  __warn from warn_slowpath_fmt+0xd7/0x12c
> [    0.957081]  warn_slowpath_fmt from sunxi_ccu_probe+0x105/0x164
> [    0.963034]  sunxi_ccu_probe from devm_sunxi_ccu_probe+0x3d/0x60
> [    0.969052]  devm_sunxi_ccu_probe from sun20i_d1_ccu_probe+0xbf/0xec
> [    0.975422]  sun20i_d1_ccu_probe from platform_probe+0x3d/0x78
> [    0.981288]  platform_probe from really_probe+0x81/0x1d0
> [    0.986607]  really_probe from __driver_probe_device+0x59/0x130
> [    0.992540]  __driver_probe_device from driver_probe_device+0x2d/0xc8
> [    0.999002]  driver_probe_device from __driver_attach+0x4d/0xf0
> [    1.004944]  __driver_attach from bus_for_each_dev+0x49/0x84
> [    1.010606]  bus_for_each_dev from bus_add_driver+0x91/0x13c
> [    1.016286]  bus_add_driver from driver_register+0x37/0xa4
> [    1.021785]  driver_register from do_one_initcall+0x41/0x1c4
> [    1.027467]  do_one_initcall from kernel_init_freeable+0x13d/0x180
> [    1.033679]  kernel_init_freeable from kernel_init+0x15/0xec
> [    1.039356]  kernel_init from ret_from_fork+0x11/0x1c
> [    1.044440] Exception stack(0xc8815fb0 to 0xc8815ff8)
> [    1.049496] 5fa0:                                     00000000 00000000 00000000 00000000
> [    1.057674] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.065850] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    1.072471] ---[ end trace 0000000000000000 ]---
> [    1.077106] ------------[ cut here ]------------
> [    1.081734] WARNING: CPU: 0 PID: 1 at drivers/clk/sunxi-ng/ccu_common.c:155 sunxi_ccu_probe+0x105/0x164
> [    1.091165] No max_rate, ignoring min_rate of clock 16 - pll-audio0
> [    1.097441] Modules linked in:
> [    1.100503] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.6.32-winglet #7
> [    1.108602] Hardware name: Generic DT based system
> [    1.113404]  unwind_backtrace from show_stack+0xb/0xc
> [    1.118474]  show_stack from dump_stack_lvl+0x2b/0x34
> [    1.123564]  dump_stack_lvl from __warn+0x5d/0x92
> [    1.128288]  __warn from warn_slowpath_fmt+0xd7/0x12c
> [    1.133356]  warn_slowpath_fmt from sunxi_ccu_probe+0x105/0x164
> [    1.139283]  sunxi_ccu_probe from devm_sunxi_ccu_probe+0x3d/0x60
> [    1.145318]  devm_sunxi_ccu_probe from sun20i_d1_ccu_probe+0xbf/0xec
> [    1.151680]  sun20i_d1_ccu_probe from platform_probe+0x3d/0x78
> [    1.157537]  platform_probe from really_probe+0x81/0x1d0
> [    1.162857]  really_probe from __driver_probe_device+0x59/0x130
> [    1.168816]  __driver_probe_device from driver_probe_device+0x2d/0xc8
> [    1.175278]  driver_probe_device from __driver_attach+0x4d/0xf0
> [    1.181219]  __driver_attach from bus_for_each_dev+0x49/0x84
> [    1.186908]  bus_for_each_dev from bus_add_driver+0x91/0x13c
> [    1.192595]  bus_add_driver from driver_register+0x37/0xa4
> [    1.198103]  driver_register from do_one_initcall+0x41/0x1c4
> [    1.203803]  do_one_initcall from kernel_init_freeable+0x13d/0x180
> [    1.210006]  kernel_init_freeable from kernel_init+0x15/0xec
> [    1.215684]  kernel_init from ret_from_fork+0x11/0x1c
> [    1.220759] Exception stack(0xc8815fb0 to 0xc8815ff8)
> [    1.225806] 5fa0:                                     00000000 00000000 00000000 00000000
> [    1.233984] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    1.242169] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    1.248818] ---[ end trace 0000000000000000 ]---

