Return-Path: <stable+bounces-35891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA800898194
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 08:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6D11C21F89
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C644134CD8;
	Thu,  4 Apr 2024 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OVg3g7Ek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRfB0/i2"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059F2C870;
	Thu,  4 Apr 2024 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712213148; cv=none; b=UGIiG33vtAr9897VnarMkTVo3DQtGV/Xx3PAbCSP8BldlsAuZYGU/p56EPA6ScjowLrgoBm+/u5VgpXtx/u0AH7nefTif/yet+n1RAqeFsayZQc3TABj+gUW+PoyMQU/Gt03WL3l18FqhHTGNrddeQywjVn22wvUmnNT8/z9Zd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712213148; c=relaxed/simple;
	bh=cqCIapieKaahPGZv9n2wtbP/MLWn7K6sROc/9j8Wj3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAqG6AC4sC0BsgPoQQ6joMZ+bwzMxMvOm+QgGh8K8XMjWgwAE46fpQTOIMS264OoS9dWax7UbC95x2ojEDiGlLng8cMtuCDYKQYsVW6ITu+hFo0G0FacowmW1135NJCjy7b4lM2v74eo50BDQ5pZ1SuLP2qsiOEvQc5e5GlNi0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OVg3g7Ek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRfB0/i2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 304381380162;
	Thu,  4 Apr 2024 02:45:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 04 Apr 2024 02:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712213145; x=1712299545; bh=rpFBzpCgX5
	cop86A2LvdrMyjHDl9mpxP/LeLP33nmwI=; b=OVg3g7EkTF6euvODFqNp4a9mO1
	QWZIaO0RAu0R4jlZjT60XicqvA2RLSVVIdA0V/XfWIq38mQVzXN3pE2RUf8VJ5En
	/dhtQec7uh/mfSnMflsr2nE0YLsu7h8Y+UrOQpFixIdlt5kNfZDx3HEmpm5urfXb
	pdeNcf2cknpxUlfpCWWNCS6nbeIEsezMoBpz8hMX2X+AqOMsUxMl1J1qg/dIe8LO
	8JsL5FFtMvPH4z5IfvvNIaffqe6sNinRpJsbhLr5RRzqZkIxWQXHHeW4UqBbpiVb
	2bCzEH7/MfthZSCrwbqzueEmqRzjsnjyxRqMR+tDxo9OAyefXZS9ePV9WlRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712213145; x=1712299545; bh=rpFBzpCgX5cop86A2LvdrMyjHDl9
	mpxP/LeLP33nmwI=; b=CRfB0/i2H/5WPvhpxfG+xTjor8QXg8wVOmAJj/kI9kqh
	Mcx+qS8UO22OfC5rlyke78CSa8Zxq4UffJSD4lG2TogYpQOndxdmVcKy4jdRHAvV
	4XXim9YBCTPzjlZJBKb643ADtHLghrzPxavMQl6xzrTam6xItKD/GE6NbAMpWa60
	i5vcwOFMTUSQN59RZyz++fp8jCClRu78roGFeaJ7ookQWDprnPUGNM6C1a0+bKWL
	/OWYf+saE3x+UPSW70YhKqIeOBZ3+XwvSgf+KU7gfCcFDcMZw+27PILQd7NCW3/J
	zVMdcgfth2S+BfqrjV/sJZkHovD2mgxiFN3Xpjh54w==
X-ME-Sender: <xms:mEwOZpZEztxFfdIAv7fg3pX2Wx0REtEGgfQeh_m1_2vA3T-guh-a-A>
    <xme:mEwOZgYUsOt4xWunS1CP-nxlkFji8oYbL5uIpiAqocipjok_eZD7Cu4bMhvQTsjl3
    BDzIAWX2UoS_A>
X-ME-Received: <xmr:mEwOZr9C3izQehg4Cx56eAJYXKwqOAxlkfx4Uy-3bvjhNx1oZfBIU72Y8jcj7FgyCjHroEatBBy9O2TmAbl9D0vY4UU7LOW0QSK_vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeghe
    euhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:mEwOZnpxkTlWDUS3ByP6Exo6lb5hA-8CAUvgqwJ0qj72tXajqvLrhA>
    <xmx:mEwOZkqxnNPvU-siHwR__AstpOLZvJdZ4RsEtPWiApMI_MYV1pGT0w>
    <xmx:mEwOZtSUHv7epSg0o7ysRUhpwG9W8r8xyl2WgQ0Rprhr8zSYEuyepQ>
    <xmx:mEwOZspnySrd-EHPtmgaxdwGubts0DSuY0Yc3vZgv_rxqWeo8zDG6A>
    <xmx:mUwOZpSEk_FkSPCSvzRMEzwuhhx1zUZPowd3U259bsLccP3E9quGY47h>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 02:45:44 -0400 (EDT)
Date: Thu, 4 Apr 2024 08:45:41 +0200
From: Greg KH <greg@kroah.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: Patch "gpio: protect the list of GPIO devices with SRCU" has
 been added to the 6.8-stable tree
Message-ID: <2024040422-barista-expel-7757@gregkh>
References: <20240403160213.267317-1-sashal@kernel.org>
 <CACMJSesiDWonw83FfnneRLXu=ED27HHeqdsjUS0Xooba2fRZZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMJSesiDWonw83FfnneRLXu=ED27HHeqdsjUS0Xooba2fRZZA@mail.gmail.com>

On Wed, Apr 03, 2024 at 11:05:42PM +0200, Bartosz Golaszewski wrote:
> On Wed, 3 Apr 2024 at 18:02, Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     gpio: protect the list of GPIO devices with SRCU
> >
> > to the 6.8-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      gpio-protect-the-list-of-gpio-devices-with-srcu.patch
> > and it can be found in the queue-6.8 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> >
> >
> > commit 077106f97c7d113ebacb00725d83b817d0e89288
> > Author: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Date:   Fri Jan 19 16:43:13 2024 +0100
> >
> >     gpio: protect the list of GPIO devices with SRCU
> >
> >     [ Upstream commit e348544f7994d252427ed3ae637c7081cbb90f66 ]
> >
> >     We're working towards removing the "multi-function" GPIO spinlock that's
> >     implemented terribly wrong. We tried using an RW-semaphore to protect
> >     the list of GPIO devices but it turned out that we still have old code
> >     using legacy GPIO calls that need to translate the global GPIO number to
> >     the address of the associated descriptor and - to that end - traverse
> >     the list while holding the lock. If we change the spinlock to a sleeping
> >     lock then we'll end up with "scheduling while atomic" bugs.
> >
> >     Let's allow lockless traversal of the list using SRCU and only use the
> >     mutex when modyfing the list.
> >
> >     While at it: let's protect the period between when we start the lookup
> >     and when we finally request the descriptor (increasing the reference
> >     count of the GPIO device) with the SRCU read lock.
> >
> >     Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >     Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >     Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >     Stable-dep-of: 5c887b65bbd1 ("gpiolib: Fix debug messaging in gpiod_find_and_request()")
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> 
> I'm not sure what the reason for picking this up into stable was but I
> believe it's not a good idea. This is just the first patch in a big
> series[1] of 24 commits total on top of which we had several bug fixes
> during the stabilization phase in next. Without the rest of the
> rework, it doesn't really improve the situation a lot.
> 
> I suggest dropping this and not trying to backport any of the GPIOLIB
> locking rework to stable branches.

I've dropped this and fixed up the commit this was a dependency for now,
thanks for the review!

greg k-h

