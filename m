Return-Path: <stable+bounces-188027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BEEBF04D8
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05BD3E0190
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F752F6567;
	Mon, 20 Oct 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9bAZ6XT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9252A1CF;
	Mon, 20 Oct 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953449; cv=none; b=T2oLUD5KkPw14aycI9y1pzEoecaQYPYNY4XZX+NeYcWzRUM8j5vn3g937dg/FiVcq1/6DlK+LvArprYVrRgRel+vgtbrlcx9RRra/bpmGz4/wlQilcg8yubirRx7FJnAxQmknWvqOIZc+Kdkg2XRG6FLzI8PcwuEpzH0UQRHtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953449; c=relaxed/simple;
	bh=PXWxOjXn0EpTpNHksrcp/ij8FOsWQSWF4jwIBCzeEJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6B6f1t228HGzzjqgiDXHWApik2AOpZZOhqZgMQAceETbUJFJ5mU5rQDS7pWj1Ok/ylt7W61PFr6mPj4PHd3MiyLdyBhJvuOxJ+0rDTkJyNMKPNLFqCZCHngAgCAzaLnMk+8e3S0iXS3w12GMwZpiPNnIQQ4J/yzwcNJoxcpcto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9bAZ6XT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5111BC4CEF9;
	Mon, 20 Oct 2025 09:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760953444;
	bh=PXWxOjXn0EpTpNHksrcp/ij8FOsWQSWF4jwIBCzeEJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9bAZ6XTXGUWuOW4jgXE4zLTzq986GRS14lQk2REvPYOuof4BSqcGUf2yMredYBR9
	 EUBhteZyEfmFfVLf7TGpsv82wAkcRdg0JxsQwThd2V0E4yToiKgMqDibOeUOikzS9p
	 rWGv20DWOr56MtIX9tc3pL+n8Vpm5R/tOK6lyTa5pq1Qaphu8TQTA+SMdNVszl+CAi
	 WmUlVL11xoN2jP2Jn9KtVEkk5x3UXLpeftiMIBpBg52+fFyaLrpDnVoN+iKxmvIIRH
	 xzDsBFQScGU2j/F/oe5cGleZMJJ0GpZig23TJ06+LbGY9/ovBvcp7crF0pzvvCXzrn
	 ebDrLdtBDdYvA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAmQy-000000006fO-3mEE;
	Mon, 20 Oct 2025 11:44:08 +0200
Date: Mon, 20 Oct 2025 11:44:08 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
Message-ID: <aPYEaNIom6BnFgP0@hovoldconsulting.com>
References: <20251017054943.7195-1-johan@kernel.org>
 <aPYBtV2gK9YMH-dT@hovoldconsulting.com>
 <2025102047-clock-utopia-323b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025102047-clock-utopia-323b@gregkh>

On Mon, Oct 20, 2025 at 11:39:59AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Oct 20, 2025 at 11:32:37AM +0200, Johan Hovold wrote:
> > On Fri, Oct 17, 2025 at 07:49:43AM +0200, Johan Hovold wrote:
> > > Platform drivers can be probed after their init sections have been
> > > discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> > > probe function must not live in init. Device managed resource actions
> > > similarly cannot be discarded.
> > > 
> > > The "_probe" suffix of the driver structure name prevents modpost from
> > > warning about this so replace it to catch any similar future issues.
> > > 
> > > Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
> > > Cc: stable@vger.kernel.org	# 6.16
> > > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > 
> > Addressing this apparently depends on commit 84b1a903aed8
> > ("time/sched_clock: Export symbol for sched_clock register function")
> > which was merged for 6.18-rc1. 
> > 
> > So the stable tag should be dropped (e.g. unless it's possible to
> > backport also the dependency to 6.17).
> 
> Quite easy to do so, just ask us!  :)

Heh. I meant that there may be something preventing the dependency from
being backported (even if I didn't see anything obvious based on a quick
look at the series adding it).

Johan

