Return-Path: <stable+bounces-94691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1419D6B1A
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 20:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06B6B21640
	for <lists+stable@lfdr.de>; Sat, 23 Nov 2024 19:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774B619AD70;
	Sat, 23 Nov 2024 19:30:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B61991D9
	for <stable@vger.kernel.org>; Sat, 23 Nov 2024 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732390208; cv=none; b=u86YYRhGqLyRqg3CwYjOgLQmK+K4ei9S1in3phHVke0MlpTijn0f/F7jsn2HjRIVK+VibDw6evmTvO7FEMBUCMQGsqFsy86XukrYrlCGtZggxW3xiH86W0IO/OJCmQiHNOqvxFTUdAe1ORl0GXzGltWOkWaU63wAIPAWlTcZRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732390208; c=relaxed/simple;
	bh=JC17rw+Hom8wSugYzI6RuOxpLgvkttMfUDPyeAFCHIE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5OPNnmfnq86h3RnxmQTP1aP05/OeDupsAgG6gGIwR+yeLSyF12H/XtzMRAYd67lrE9H0hgjsgbomDdtvNgBgtF7d5e3YULo/O63ZSZ+1vwBIhq1ryj4jpGE7d+Ru8UyJBrwtvwgvWoNkQHNG9q3vgRfUwmbxRdfyLqBTJi5e1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-143.elisa-laajakaista.fi [88.113.25.143])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 470d06ed-a9d1-11ef-9b92-005056bd6ce9;
	Sat, 23 Nov 2024 21:29:39 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 23 Nov 2024 21:29:37 +0200
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Gene Chen <gene_chen@richtek.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 00/18] leds: switch to device_for_each_child_node_scoped()
Message-ID: <Z0ItIQWHOGL-GTi8@surfacebook.localdomain>
References: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-leds_device_for_each_child_node_scoped-v1-0-95c0614b38c8@gmail.com>

Fri, Sep 27, 2024 at 01:20:51AM +0200, Javier Carrasco kirjoitti:
> This series switches from the device_for_each_child_node() macro to its
> scoped variant, which in general makes the code more robust if new early
> exits are added to the loops, because there is no need for explicit
> calls to fwnode_handle_put(). Depending on the complexity of the loop
> and its error handling, the code gets simplified and it gets easier to
> follow.
> 
> The non-scoped variant of the macro is error-prone, and it has been the
> source of multiple bugs where the child node refcount was not
> decremented accordingly in error paths within the loops. The first patch
> of this series is a good example, which fixes that kind of bug that is
> regularly found in node iterators.
> 
> The uses of device_for_each_child_node() with no early exits have been
> left untouched because their simpilicty justifies the non-scoped
> variant.
> 
> Note that the child node is now declared in the macro, and therefore the
> explicit declaration is no longer required.
> 
> The general functionality should not be affected by this modification.
> If functional changes are found, please report them back as errors.


Thank you for this series. It may now benefit from the next steps:

1) converting to return dev_err_probe() or dev_warn_probe() directly since
   the goto had been replaced by direct return, hence saving even more LoCs;

2) dropping or refactoring the complex conditions due to your nice series
   being applied.

I'll comment individually on some to show what I meant by the above.

-- 
With Best Regards,
Andy Shevchenko



