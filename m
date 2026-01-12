Return-Path: <stable+bounces-208108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B233D121E5
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 12:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1A9B3029C22
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0772352FA2;
	Mon, 12 Jan 2026 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="b+ngRUEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VgG5uNrj"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EDD352C30
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768215615; cv=none; b=F3FrjZh6ad8C0wbwJPsFqSrYvdsnMXUlARQOWbgRK3HgWWkvB4IMBvJHjMQwFe03+N9c9IKcnSpSlhz5eYxMZzc+wcATycux42Nk12KT9cw4yldec/YO2RQvTB1+Iseph61SHeR6jrrLAjJwKr2967i0s92Uj8lvokEm9FjUk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768215615; c=relaxed/simple;
	bh=1sxgby6Fmr9lX1k88kXdk7F3TbhEZJEipJzXMOClV1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMeSa1oHHGoWnBSpBThMq+XWSRjnQz7Njb3jMZGr3/srABQS4eDI/w3Rptxa5CXKVga9VpaLP65R66DE6w+YCPIrAgRDDdk6OqOVe1DLlFUjXvXD7TsHVijsuwJ4BD3LaM2jo8jxrz10ViCm3/uZcMAuVWSJYQhRPRzGr/oJduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=b+ngRUEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VgG5uNrj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 564D5EC010D;
	Mon, 12 Jan 2026 06:00:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 06:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768215612; x=1768302012; bh=0cuQOG4zwO
	z7bQ/0Ub6gjE+UuyhCDICcfTRQX69OVHA=; b=b+ngRUEuy6viB9MEQiZQzZqHBn
	zynudxPWn/AkL0OPs1ff56fdc/2W7/X//cp7URPwqOiv5BpLTEc598ydZfBiUSCl
	iKjPXZmpbjSCxrnkPmMIY2D1xTGm12NboR6SH04dvdHSkdXHFjU4KmR66Jfmie8f
	XG2Fs5HMkToBZm4Lj6mvuggCciVaFE+CbkbcVBDbVP8ic0wBgXBrdK6K7ENc68zq
	33QBTEwKHa+VV9yROzKieH/fFyM3S2qeef8pnfri3FmGJzMYAXPzMaeywevbQQZi
	DMDOY7Tt6B1zXf0jsDhbwj9glcDGrlCbKkxh+K4ebeHcNSf7Bdm+BChIENtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768215612; x=1768302012; bh=0cuQOG4zwOz7bQ/0Ub6gjE+UuyhCDICcfTR
	QX69OVHA=; b=VgG5uNrjIyoDw4a/ELoG9MGIAWzn8MCcY00WKlivDmz9Sp2qzPp
	vyy0iPIwbP1NygHkXH3etmu37Z7GUafNONX8Ck1qZzwEhrsfBoxSPQxCCHKIyV3R
	sIevdWrYEdKDt2uvm+TPiMsSEu/B5oSX2tpBJCKGGM580Nke/CZL2rf6pJ9NUvsn
	iKX68E4ShFwwfgioDOdTtwKpSjxUtX9EAfHhglkGievmRYLu/7qq4jNGdG9eypfJ
	s78HOHsO44VPQvTby5Ca86vbD+3FjpRNl538O4UPoPAcA4OUuIu7Dy9lqm79j2k2
	tlMtjTFDbu5XV6qSIweXtFwwBwL+JUHk/cQ==
X-ME-Sender: <xms:O9Rkaawm4CjZT16QfYPAqxtqI3ENjSY3PVLcxcD2ANwxL_kNoXHGwg>
    <xme:O9RkaVsjJrTegk8n_0S-D2jPS0m6c3rsh8vtj5nA1tcII8DZMlb8UtmJhiKuDnSUU
    afAPZKgIX9aaFz9V8E6EaKeznU_UuWitwRAzsxXNY8DcdjPLQ>
X-ME-Received: <xmr:O9RkadbUDw7TrkvWOtpTMBGdRCZi0x8Bi3cvMvwnuzTQL7yGSMWwvPjQCSdCko2rjMI71xBj9FwJwB5X2uDiE6y4BqJMA7c0Nsn67w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehueehgf
    dtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsrghrthhoshiirdhgohhlrghsii
    gvfihskhhisehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphhtthhopehsthgrsghl
    vgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvrghlsehprggtkhgvth
    htrdgtohholhdprhgtphhtthhopegsrghrthhoshiirdhgohhlrghsiigvfihskhhisehl
    ihhnrghrohdrohhrghdprhgtphhtthhopegumhhithhrhidrsggrrhihshhhkhhovhesoh
    hsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtoheprghnuggvrhhsshhonheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushifsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:O9RkaU1W6DIRg4lJ8bdzeI9e7bk_bG0lTgb7FQ8hf2tISLBSowpqBQ>
    <xmx:O9RkaftcVSABfmizxpbMJL4Gj3gaPFUVCpdOZIjXiTed4QC-Jp55ZQ>
    <xmx:O9RkaYDo1y0N8loz7nzBWRHcxy0CEpTLruxA2zQKBPpq0QP6SQdKxg>
    <xmx:O9RkaSYJfPBeeU-NB0XJxFgqZe-As3vxTeVnLad7W60m5jGhmuLEbw>
    <xmx:PNRkaVhD3S5tFhgg1bDbl__5F3CdWQG4D64PucjdAbKSlN2VbzUaHVf7>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 06:00:11 -0500 (EST)
Date: Mon, 12 Jan 2026 12:00:08 +0100
From: Greg KH <greg@kroah.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: stable@vger.kernel.org, Val Packett <val@packett.cool>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 6.1.y 5.15.y] pinctrl: qcom: lpass-lpi: mark the GPIO
 controller as sleeping
Message-ID: <2026011259-oyster-grating-7f2a@gregkh>
References: <2026011236-imaginary-sweep-d796@gregkh>
 <20260112105051.16763-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112105051.16763-1-bartosz.golaszewski@oss.qualcomm.com>

On Mon, Jan 12, 2026 at 11:50:51AM +0100, Bartosz Golaszewski wrote:
> The gpio_chip settings in this driver say the controller can't sleep
> but it actually uses a mutex for synchronization. This triggers the
> following BUG():
> 
> [    9.233659] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:281
> [    9.233665] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 554, name: (udev-worker)
> [    9.233669] preempt_count: 1, expected: 0
> [    9.233673] RCU nest depth: 0, expected: 0
> [    9.233688] Tainted: [W]=WARN
> [    9.233690] Hardware name: Dell Inc. Latitude 7455/0FK7MX, BIOS 2.10.1 05/20/2025
> [    9.233694] Call trace:
> [    9.233696]  show_stack+0x24/0x38 (C)
> [    9.233709]  dump_stack_lvl+0x40/0x88
> [    9.233716]  dump_stack+0x18/0x24
> [    9.233722]  __might_resched+0x148/0x160
> [    9.233731]  __might_sleep+0x38/0x98
> [    9.233736]  mutex_lock+0x30/0xd8
> [    9.233749]  lpi_config_set+0x2e8/0x3c8 [pinctrl_lpass_lpi]
> [    9.233757]  lpi_gpio_direction_output+0x58/0x90 [pinctrl_lpass_lpi]
> [    9.233761]  gpiod_direction_output_raw_commit+0x110/0x428
> [    9.233772]  gpiod_direction_output_nonotify+0x234/0x358
> [    9.233779]  gpiod_direction_output+0x38/0xd0
> [    9.233786]  gpio_shared_proxy_direction_output+0xb8/0x2a8 [gpio_shared_proxy]
> [    9.233792]  gpiod_direction_output_raw_commit+0x110/0x428
> [    9.233799]  gpiod_direction_output_nonotify+0x234/0x358
> [    9.233806]  gpiod_configure_flags+0x2c0/0x580
> [    9.233812]  gpiod_find_and_request+0x358/0x4f8
> [    9.233819]  gpiod_get_index+0x7c/0x98
> [    9.233826]  devm_gpiod_get+0x34/0xb0
> [    9.233829]  reset_gpio_probe+0x58/0x128 [reset_gpio]
> [    9.233836]  auxiliary_bus_probe+0xb0/0xf0
> [    9.233845]  really_probe+0x14c/0x450
> [    9.233853]  __driver_probe_device+0xb0/0x188
> [    9.233858]  driver_probe_device+0x4c/0x250
> [    9.233863]  __driver_attach+0xf8/0x2a0
> [    9.233868]  bus_for_each_dev+0xf8/0x158
> [    9.233872]  driver_attach+0x30/0x48
> [    9.233876]  bus_add_driver+0x158/0x2b8
> [    9.233880]  driver_register+0x74/0x118
> [    9.233886]  __auxiliary_driver_register+0x94/0xe8
> [    9.233893]  init_module+0x34/0xfd0 [reset_gpio]
> [    9.233898]  do_one_initcall+0xec/0x300
> [    9.233903]  do_init_module+0x64/0x260
> [    9.233910]  load_module+0x16c4/0x1900
> [    9.233915]  __arm64_sys_finit_module+0x24c/0x378
> [    9.233919]  invoke_syscall+0x4c/0xe8
> [    9.233925]  el0_svc_common+0x8c/0xf0
> [    9.233929]  do_el0_svc+0x28/0x40
> [    9.233934]  el0_svc+0x38/0x100
> [    9.233938]  el0t_64_sync_handler+0x84/0x130
> [    9.233943]  el0t_64_sync+0x17c/0x180
> 
> Mark the controller as sleeping.
> 
> Fixes: 6e261d1090d6 ("pinctrl: qcom: Add sm8250 lpass lpi pinctrl driver")
> Cc: stable@vger.kernel.org
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://lore.kernel.org/all/98c0f185-b0e0-49ea-896c-f3972dd011ca@packett.cool/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> index bfcc5c45b8fa..35f46ca4cf9f 100644
> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
> @@ -435,7 +435,7 @@ int lpi_pinctrl_probe(struct platform_device *pdev)
>  	pctrl->chip.ngpio = data->npins;
>  	pctrl->chip.label = dev_name(dev);
>  	pctrl->chip.of_gpio_n_cells = 2;
> -	pctrl->chip.can_sleep = false;
> +	pctrl->chip.can_sleep = true;
>  
>  	mutex_init(&pctrl->lock);
>  
> -- 
> 2.47.3
> 
> 

What is the git id of this commit in Linus's tree?

thanks,

greg k-h

