Return-Path: <stable+bounces-181726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E6B9FD89
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 16:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DF917D7F1
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7FD2882CC;
	Thu, 25 Sep 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="G0g+GmM1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mjizZzLJ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF828851C
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758808892; cv=none; b=IirH0CWvg1Oc9nux9YEQTddpKdYl/gFErVUYCB8cLwg5u3uEUQtdtHW+vT3bYM5BTRTXWB588kmJ8X5ZTh5xLS0JDg09i1r2vjXeXRkorFA9XgusMosyiAWCHRzF78GVnN0fCzq5wXqSxTyp1Cm/pR5hH2d7GkvmrUZV/fIRpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758808892; c=relaxed/simple;
	bh=RPimaMQzlQ/F3ICbKIlRP0Ix9LYXJB21zQs9ChvSFCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwHhUbSJyu4/sDZIujKvhm/1hTj0M082wpUUGC/D7Droa1DzvIz7xeTqiYxucuLh6hRwsuNp+WaPFqOs5IwnN4upQclPUTb0iHqIFhLcPQ6b42rMjGDc0xLCz4i8A4JNPz/US//QyeC1m2XK1e/l2GIJ0t7sck5LB4AoMsuXivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=G0g+GmM1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mjizZzLJ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DD3B14000C9;
	Thu, 25 Sep 2025 10:01:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 25 Sep 2025 10:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1758808889; x=
	1758895289; bh=WX2fdSBj+kCn6NIr/ZgsH6nJPsaExBK6me5rJsxnIIk=; b=G
	0g+GmM1CQIqICeZ/VOLaTYdDj+qYtLjanVDoNBKnoQ642ZiCilYeXVczEs/Pj2Kg
	+ttMWg+qGB5utFduprlLBqgX2OPtep/rUwDAjD3cJkjBzqwQgQ5A2OnViqrjoku+
	tr9ZsgcYUk3gsij3zpIDY2Ldj1DMOvluzy4eiQHpDW22+0rBIr64+oll2y4ZntyJ
	WSKljqZgtdaqz1K9xXzANVRS8Ys5YOkwDp2pPvftr+Pb7tcXDfqjrm/2hbPsG+S0
	qsIKMlMPCTbsS/ZxDLWnlBAh2nUP0IELAoz6JIckZkHKCuOVVa9+6i2TKoN+rBMC
	yI8zrBbgxnzgBk7YbQ/9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758808889; x=1758895289; bh=WX2fdSBj+kCn6NIr/ZgsH6nJPsaExBK6me5
	rJsxnIIk=; b=mjizZzLJLGopkIjFjWHdCQWsIiz2mlq2LnhJqq3if95I8M4VmKt
	jPWLp0fhu05YVc5IOAB8b41Gv3Y6x8D+ZNBZtI2kSoH7FulXEb605F3y5tO4Vgcy
	iN4K6OWA3kmNZj0yvk0BFtkHmwQqpnRExrIEeYVyPQD17UWvjMpEdqx8lJI74EWa
	irXK8FmhbGph/iLVboav3nIaajd5OskKbyco77GnQPslCs5iDLN2HXZk4q6wDxPX
	uwQVXlnJRRIqH3O+aaM59Ocx4kIWBnBpYZCUqDiIa4NkmySHWgtQgcP4HeNijljR
	3IkB8D706j2fAly0NHXYmS+LTZVyGQvflPg==
X-ME-Sender: <xms:OEvVaBTGx95QctfAA44fqTAsHIcjgES9CzXOMCfa2X07mQMLjLbxtQ>
    <xme:OEvVaAzuCCJj2j1SgbT81H7d4xjnR_VWd6OW0HFLOl4QD70Gd6ZtyHi9TO3AmFnd_
    sfWf2TO1XTOlc377qAsSxTOKgmSBMP9vu6JgR9LVYe_WkfV6jEoQDpH>
X-ME-Received: <xmr:OEvVaEcZBZMg1oIbwPIKZibx92Lnba1FU0F2QHvbPo-C_kUluOzvf3ejIebpXZKvU7e1dacIGozL_2_hdn0ZoV0D7DGCyq-KvF8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhudekff
    ehkeffudduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:OEvVaELWLzWUGLGW53vL6qjF5HyFQetV_IQ_FPqOJS1ndT2tcFRIRQ>
    <xmx:OEvVaNEDfEpn-kWQ7CaHW3Q-Vt_NzmCBDxdYqjGS7E7ZS_SuQhY4Aw>
    <xmx:OEvVaGpRf4KdAZpmonzVf4Y6kg124EZtr2HGt5hhP3a_F-xN21OEOA>
    <xmx:OEvVaOSYp8g35huNgXlCYWJMdyjtDRa12zXz0xUly2WY5QnxMqZvsA>
    <xmx:OUvVaAFId8kS6Bh1VTIrVVqL_4S7mREODCgYssQalToiXgva5sXDaMsI>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 10:01:27 -0400 (EDT)
Date: Thu, 25 Sep 2025 23:01:26 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: stable@vger.kernel.org
Cc: sashal@kernel.org
Subject: Re: Patch "firewire: core: fix overlooked update of subsystem ABI
 version" has been added to the 6.1/5.15/5.10/5.4-stable tree
Message-ID: <20250925140126.GA330521@workstation.local>
References: <20250925113324.365642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925113324.365642-1-sashal@kernel.org>

Hi Sasha,

As the commit message notice, this patch should not be applied to kernel
v6.4 or before. I would like you to exclude this from your queue for the
following versions:

* Patch "firewire: core: fix overlooked update of subsystem ABI version" has been added to the 5.4-stable tree
* Patch "firewire: core: fix overlooked update of subsystem ABI version" has been added to the 5.10-stable tree
* Patch "firewire: core: fix overlooked update of subsystem ABI version" has been added to the 5.15-stable tree
* Patch "firewire: core: fix overlooked update of subsystem ABI version" has been added to the 6.1-stable tree


Thankss

Takashi Sakamoto

On Thu, Sep 25, 2025 at 07:33:23AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     firewire: core: fix overlooked update of subsystem ABI version
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      firewire-core-fix-overlooked-update-of-subsystem-abi.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit bbb4ab1d7b1ad7fff7a85aa9144d0edc5a70bacc
> Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date:   Sat Sep 20 11:51:48 2025 +0900
> 
>     firewire: core: fix overlooked update of subsystem ABI version
>     
>     [ Upstream commit 853a57ba263adfecf4430b936d6862bc475b4bb5 ]
>     
>     In kernel v6.5, several functions were added to the cdev layer. This
>     required updating the default version of subsystem ABI up to 6, but
>     this requirement was overlooked.
>     
>     This commit updates the version accordingly.
>     
>     Fixes: 6add87e9764d ("firewire: cdev: add new version of ABI to notify time stamp at request/response subaction of transaction#")
>     Link: https://lore.kernel.org/r/20250920025148.163402-1-o-takashi@sakamocchi.jp
>     Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> index 958aa4662ccb0..5cb0059f57e6b 100644
> --- a/drivers/firewire/core-cdev.c
> +++ b/drivers/firewire/core-cdev.c
> @@ -39,7 +39,7 @@
>  /*
>   * ABI version history is documented in linux/firewire-cdev.h.
>   */
> -#define FW_CDEV_KERNEL_VERSION			5
> +#define FW_CDEV_KERNEL_VERSION			6
>  #define FW_CDEV_VERSION_EVENT_REQUEST2		4
>  #define FW_CDEV_VERSION_ALLOCATE_REGION_END	4
>  #define FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW	5

