Return-Path: <stable+bounces-36050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14390899975
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 11:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2798282264
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E9815FD0D;
	Fri,  5 Apr 2024 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Cf8XpTiJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QCa/R4Em"
X-Original-To: stable@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEAA15FD14
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712309424; cv=none; b=PWEbEguO+NDjTE4ji9KxmnIWF6MihlzIWwLtcMHnjFYDIAWjgyhCeTF/kaqOJBHIF4Nmc6UJjdMouBSpGoMrUMgs4zTGxLyP/OEox+btDAoPqkZCbogLjEuwYUYoHHjVABtFNRt0hWeH/8h9ObMM4hWY9rbKzVMF7NMQaHzdPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712309424; c=relaxed/simple;
	bh=Hgp/guGjXQ5xS317tBfpnNJMX1QWDmlR+ASbhd7WCC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfZv8tAPUsiM8DP2XdQp/f79RSrpshcKpKdWPqizBLvrqcWXirfAzIdTnp9u2+wdvwv+UbssK1rh0dy5nDSQ/PyFuy7AOwfrVtSkda73X7gnyR9DI0QQCR9BAXTXvVTwCv0Ukxps0K7qasAbMdDX/algJFgL6sQbAlOs40v6skI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=Cf8XpTiJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QCa/R4Em; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1677D11400B1;
	Fri,  5 Apr 2024 05:30:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 05 Apr 2024 05:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712309422; x=1712395822; bh=6K8uUGGzLM
	GxG+0aqNXuFc2GFTOaqL/V0jEVNlaxr4I=; b=Cf8XpTiJsSLpEo4nnWZOov9LN7
	u8++x0aOGCWyDL364vwh93Xe7FxF3cHAVnVC5/jrzGv34ouZFdRwLbgKq/65H3sM
	uYugm9vii3T9Iu+dikflBJd+7oVj8RsvSGSLwsgpojZ6WOQ++yWI/37kjcDSAPGg
	ELvkiYT1a7m3aU9jQtHLqM9aPhe0OQv+mUNjmpIOdZKaB27gj8xOJ5I2PbD9AnSd
	QVkG9Mp41+QDlU/8dW2Yt9WoYjEgnJM+oxIHHxVOqoA1bnHZkR2x1SR7fXvnlFpz
	624vQdSgbmQMsIYCoKhqpA8scO4eZesWixjhkIe0waNl/KxY+/Ivi/Iv+ZZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712309422; x=1712395822; bh=6K8uUGGzLMGxG+0aqNXuFc2GFTOa
	qL/V0jEVNlaxr4I=; b=QCa/R4EmvfNGSlzEAjjKPxuDR60Bg+OoWdzxcfhdIGBi
	ouLRE9/r9A8kyhHZ7ewOuKQNcVz1Kw1Av+8nF/YvpIrdxo/lfBe2jYE54UY1/A38
	ocjWwhZ7/1MVZngKwrd1xivg8Sqb5GWkuj07MW6VgknNKMnFCj7YX56jjPdWbRpH
	3uYt+o4YYwnzslV56m8W/5mwrvEF93S4m5kCKHpcjIcoQWoerVDC/XF2FCMnEr/u
	/ULx9Cr3FRW0ScF0Zyn3gZNnH195CcVT//37xPiNEyHW6hcVHOdlUAmzsG613mzI
	Yu+wNiawLXQLYJgioRUDiRPgtzeVEpYzWkjpMBpi4A==
X-ME-Sender: <xms:rcQPZu4wjMSIrgL-4EsgbRg5PVIzKgbH4Ed29yNbOp2BKFunKsAdBg>
    <xme:rcQPZn7FBGunqi8yl2sWcJnmLFQRLC3SG05qyL85R0OSGmGP_Z68NQGpqYFIRnfgP
    RI_W3adseYl3A>
X-ME-Received: <xmr:rcQPZtei_yXUF8fUTIDnYHyQDugwDgavPSZtEFV07VP_zDDDw_c1adcI2R721g13FL3AuYH36ibp0KU57SVv0H1aBt7fIyQRySawEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegtddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeduve
    evhfffheelhfeikedvjeehvdevhfevgfeuheekveevhffgvdffkeekgeefnecuffhomhgr
    ihhnpehqvghmuhdrohhrghdpuddtqdhrtgdurdhsohenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:rcQPZrLrPK-5Hlu-MOIJxPO4wTh3Tw2eusAFFsvFBXA2fw_C4PfJIA>
    <xmx:rcQPZiILDjnEqOhLqqLRu9AuaGDRYe35EwiKa2Fckksjpi_BugQHrQ>
    <xmx:rcQPZszlOSmRQin-B1jlLjf1urEWFjWFnzMaa9CiiOn2Gmo64d5zkw>
    <xmx:rcQPZmKxycQIDusGorkj-PCu4rTD2-KibkPrYUoWQvsDm1hr6TflPg>
    <xmx:rsQPZtbMQhWhAj2lABzbaetG0z8e3y7vxusIYrZxBmjiqmhZ9p5xguHB>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Apr 2024 05:30:21 -0400 (EDT)
Date: Fri, 5 Apr 2024 11:30:19 +0200
From: Greg KH <greg@kroah.com>
To: Guo Mengqi <guomengqi3@huawei.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org, xuqiang36@huawei.com,
	zhangchangzhong@huawei.com
Subject: Re: [PATCH 4.19.y] drm/vkms: call drm_atomic_helper_shutdown before
 drm_dev_put()
Message-ID: <2024040549-pushover-applied-4948@gregkh>
References: <20240403094716.80313-1-guomengqi3@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403094716.80313-1-guomengqi3@huawei.com>

On Wed, Apr 03, 2024 at 05:47:16PM +0800, Guo Mengqi wrote:
> commit 73a82b22963d ("drm/atomic: Fix potential use-after-free
> in nonblocking commits") introduced drm_dev_get/put() to
> drm_atomic_helper_shutdown(). And this cause problem in vkms driver exit
> process.
> 
> vkms_exit()
>   drm_dev_put()
>     vkms_release()
>       drm_atomic_helper_shutdown()
>         drm_dev_get()
>         drm_dev_put()
>           vkms_release()    ------ null pointer access
> 
> Using 4.19 stable x86 image on qemu, below stacktrace can be triggered by
> load and unload vkms.ko.
> 
> root:~ # insmod vkms.ko
> [  142.135449] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [  142.138713] [drm] Driver supports precise vblank timestamp query.
> [  142.142390] [drm] Initialized vkms 1.0.0 20180514 for virtual device on minor 0
> root:~ # rmmod vkms.ko
> [  144.093710] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a0
> [  144.097491] PGD 800000023624e067 P4D 800000023624e067 PUD 22ab59067 PMD 0
> [  144.100802] Oops: 0000 [#1] SMP PTI
> [  144.102502] CPU: 0 PID: 3615 Comm: rmmod Not tainted 4.19.310 #1
> [  144.104452] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [  144.107238] RIP: 0010:device_del+0x34/0x3a0
> ...
> [  144.131323] Call Trace:
> [  144.131962]  ? __die+0x7d/0xc0
> [  144.132711]  ? no_context+0x152/0x3b0
> [  144.133605]  ? wake_up_q+0x70/0x70
> [  144.134436]  ? __do_page_fault+0x342/0x4b0
> [  144.135445]  ? __switch_to_asm+0x41/0x70
> [  144.136416]  ? __switch_to_asm+0x35/0x70
> [  144.137366]  ? page_fault+0x1e/0x30
> [  144.138214]  ? __drm_atomic_state_free+0x51/0x60
> [  144.139331]  ? device_del+0x34/0x3a0
> [  144.140197]  platform_device_del.part.14+0x19/0x70
> [  144.141348]  platform_device_unregister+0xe/0x20
> [  144.142458]  vkms_release+0x10/0x30 [vkms]
> [  144.143449]  __drm_atomic_helper_disable_all.constprop.31+0x13b/0x150
> [  144.144980]  drm_atomic_helper_shutdown+0x4b/0x90
> [  144.146102]  vkms_release+0x18/0x30 [vkms]
> [  144.147107]  vkms_exit+0x29/0x8ec [vkms]
> [  144.148053]  __x64_sys_delete_module+0x155/0x220
> [  144.149168]  do_syscall_64+0x43/0x100
> [  144.150056]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
> 
> It seems that the proper unload sequence is:
> 	drm_atomic_helper_shutdown();
> 	drm_dev_put();
> 
> Just put drm_atomic_helper_shutdown() before drm_dev_put()
> should solve the problem.
> 
> Note that vkms exit code is refactored by 53d77aaa3f76 ("drm/vkms: Use
> devm_drm_dev_alloc") in tags/v5.10-rc1.
> 
> So this bug only exists on 4.19 and 5.4.

Do we also need this for 5.4?  If so, can you send a version for that
tree with the correct Fixes: information, and I will be glad to queue
both of these up.

thanks,

greg k-h

