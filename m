Return-Path: <stable+bounces-188026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5EABF0463
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C30CF4F4010
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FFA2FBE16;
	Mon, 20 Oct 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cMqIWr5j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A43F2FBDFE;
	Mon, 20 Oct 2025 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953202; cv=none; b=NoqptYKuacPCSsP6bOfplpWnyNgD6GkJSkiHJXYSo3xaKgua5CMi5vLRfyAiHvNU0YVUjrAwTWhRkCBM2B43287tx70hNgaDMjU1a3A74PiUXxE/UEWZ8Af08EcmLpeClsd+xz2fvmyB6c2rdcm6RPE4fFgwjZ1WId9JEfwY8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953202; c=relaxed/simple;
	bh=O7rBJlaTVqZbStxi1qt2jJ35Zv7NyJlQUwoudTX+mPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBjsuGzR+L3FFoaKgfFFeRefPRY4utvdtiu0bQQMSybKqQVhSy6dGc9DlcCBlB32nWuRRXjEFN0tmlN6gJQU0Hw2K3ur9mCSn3bI0wsvVOi1nzQ7wI9tAzK44OcGxVu3GvUtyYdGJrdcenuqcexNq/lC3RLUieNVy1A8CmsL0ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cMqIWr5j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD04C4CEF9;
	Mon, 20 Oct 2025 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760953201;
	bh=O7rBJlaTVqZbStxi1qt2jJ35Zv7NyJlQUwoudTX+mPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMqIWr5jNjbIwh1xF4SvQbvqoz++4rZdq00rNLtcY0uEi9MlsrBmjYh5miQWUuy1V
	 7uG62TRUpVZ9/0cuR/7jfA4p2InBEIqCWj/lbWjRsrTa0ODqI1euKIc6fComIC9YOB
	 cPbRAZkYod1JrIQC6UeWS0XRzII468QJzXfxoRps=
Date: Mon, 20 Oct 2025 11:39:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
Message-ID: <2025102047-clock-utopia-323b@gregkh>
References: <20251017054943.7195-1-johan@kernel.org>
 <aPYBtV2gK9YMH-dT@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPYBtV2gK9YMH-dT@hovoldconsulting.com>

On Mon, Oct 20, 2025 at 11:32:37AM +0200, Johan Hovold wrote:
> On Fri, Oct 17, 2025 at 07:49:43AM +0200, Johan Hovold wrote:
> > Platform drivers can be probed after their init sections have been
> > discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> > probe function must not live in init. Device managed resource actions
> > similarly cannot be discarded.
> > 
> > The "_probe" suffix of the driver structure name prevents modpost from
> > warning about this so replace it to catch any similar future issues.
> > 
> > Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
> > Cc: stable@vger.kernel.org	# 6.16
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Addressing this apparently depends on commit 84b1a903aed8
> ("time/sched_clock: Export symbol for sched_clock register function")
> which was merged for 6.18-rc1. 
> 
> So the stable tag should be dropped (e.g. unless it's possible to
> backport also the dependency to 6.17).

Quite easy to do so, just ask us!  :)

