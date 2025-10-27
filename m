Return-Path: <stable+bounces-189913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D0C0BF73
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 07:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB8F1896B1A
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 06:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A04207A22;
	Mon, 27 Oct 2025 06:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V5vhYDJo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11E23EA93
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761546730; cv=none; b=DJpVucLKO7jN11kd6aoMLfs7lha5LmtmApIq1WFcDC5xmMrsFeibeuUt/J98CdcDIFT0VFeOxY0yvBUMpfn4t/N/vkDwArqwiXg0EIGgCyTNl5W/r+gvsMKaDND099rEuAglW746YWeCUnk0T6lGjvVWTNkkl/7gXM1qS1h3w3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761546730; c=relaxed/simple;
	bh=/HV0NecHqAWEvKXXCjEQNuZdHMsXK37YbYnEF7+K6RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULCoJqm1ZFN7TdDg/oPjjucdm2a7FnFr/k/bXVWFvBEDkQWgNwgAeNI7zdcGQ25FeIInIhJC6OMdD7EtEzSgo6Qs6uL5H82kPzw9IKaVDqVsdsFhdh7CpMdKXHS95RX31OAFZ3rHfwfluY1HVvVm1swVoQklYz86l02EP7BwevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V5vhYDJo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4323AC4CEF1;
	Mon, 27 Oct 2025 06:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761546726;
	bh=/HV0NecHqAWEvKXXCjEQNuZdHMsXK37YbYnEF7+K6RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V5vhYDJoEgycxt/t7YQIZQ0HLCm3YpV7KrZ4hk0srs1Au0vKDWAK798UMMdFt5JzT
	 0lfOTuibVDovgQ9/PC9ML4WyEuRft0Gue92eTrOc3epQcVCXddGLTR3B9zVB4I4oum
	 8m4N+4ni033bXURelvay84bHH4XXElW41tmWYxHo=
Date: Mon, 27 Oct 2025 07:32:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: stable@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
	Michael Walle <mwalle@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 6.6.y] gpio: idio-16: Define fixed direction of the GPIO
 lines
Message-ID: <2025102747-harmonics-dollop-f225@gregkh>
References: <2025102619-plaster-sitting-ed2e@gregkh>
 <N8Hj-zRacZQc6SSWrj2lLT1upcInj9PrAH81Xc2M4mozVsSUj92ofp9fJOsPqS22yl_CdmdkM1Phj5z86hNpdg==@protonmail.internalid>
 <20251026152950.44505-1-wbg@kernel.org>
 <aP5BSHnMw3Bn10vD@emerald>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP5BSHnMw3Bn10vD@emerald>

On Mon, Oct 27, 2025 at 12:42:00AM +0900, William Breathitt Gray wrote:
> On Mon, Oct 27, 2025 at 12:29:43AM +0900, William Breathitt Gray wrote:
> > The direction of the IDIO-16 GPIO lines is fixed with the first 16 lines
> > as output and the remaining 16 lines as input. Set the gpio_config
> > fixed_direction_output member to represent the fixed direction of the
> > GPIO lines.
> > 
> > Fixes: db02247827ef ("gpio: idio-16: Migrate to the regmap API")
> > Reported-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> > Closes: https://lore.kernel.org/r/9b0375fd-235f-4ee1-a7fa-daca296ef6bf@nutanix.com
> > Suggested-by: Michael Walle <mwalle@kernel.org>
> > Cc: stable@vger.kernel.org # ae495810cffe: gpio: regmap: add the .fixed_direction_output configuration parameter
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Link: https://lore.kernel.org/r/20251020-fix-gpio-idio-16-regmap-v2-3-ebeb50e93c33@kernel.org
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > (cherry picked from commit 2ba5772e530f73eb847fb96ce6c4017894869552)
> > Signed-off-by: William Breathitt Gray <wbg@kernel.org>
> 
> Sorry, I didn't mean to send this. I don't think this will compile
> without backporting the dependencies.

No it will not, and the sha1 given for the dependency is not correct :(

