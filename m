Return-Path: <stable+bounces-188021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958F4BF0307
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B8D401DA6
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CCF2EA755;
	Mon, 20 Oct 2025 09:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3c/fBQ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7E02BE032;
	Mon, 20 Oct 2025 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952754; cv=none; b=VPcJxRuEFZXlml5hblvW48kCW37rylYVV1hFPXNvZnEYmEdK5uPpwXP/R5sieJajZM99ADxyW22oyVK4gnnJGfVghaGS7fO6Z0Fd4kdMWvdz1NxAW6xpz0X6LuwmIB4matVKWF01Z9HGuJU4UzKD15Mi3wsuZs2WwikSCZ6n2kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952754; c=relaxed/simple;
	bh=wC1q+yAyAataWSW9TWgk3zcrtUNWDLFZG28ISfAi9k8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gh5C8F0Df5uHYLtgzc934BUE0CsTUUjymNBRJOMkBd5mUSQnsbaKGz8XGDhiovsT23zshWeYAiZPDCl53JNJ3bDh5BJwb+cuXof7H3mAGJwpldPLu1QViFRnA0WaaQduryBzxt80wLfJ+dVD7ABDYPubOk9YBkadyhPUi27orqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3c/fBQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBB2C4CEF9;
	Mon, 20 Oct 2025 09:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760952752;
	bh=wC1q+yAyAataWSW9TWgk3zcrtUNWDLFZG28ISfAi9k8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J3c/fBQ0c6zdSGNKdQpz4LvfcV71pZ5YPZZ+EWPvFLQL2QYLrX98gJRh0gFZV6pnA
	 iPrC/QZoZGM7UVQ29YzKj1jUBb6i6YM9Q4pAKzyuAOqfTGmTCb7YsUg2bc4Mx9ZNRO
	 CIRjejQvMgU7vV2OtNTRrz9xHsKde7LHhJA0igH91E/HTj0Ul1GGvu03a/LCZjsi7U
	 2gb/gaZBOfFtcPe9GHawIJheTS28kvHYD49Nw3zr1W0iQZEMDh3i0gvsehTD/1B9D7
	 c1fmJ7EIrUpZC8VaVWkvSEkziqHqJzRQ4Zm3JQKJlvWYGuz0s7r97ZKsPMjyMQKHd8
	 EIS08M8EeW16g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAmFp-000000006Uy-0YBw;
	Mon, 20 Oct 2025 11:32:37 +0200
Date: Mon, 20 Oct 2025 11:32:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/stm: Fix section mismatches
Message-ID: <aPYBtV2gK9YMH-dT@hovoldconsulting.com>
References: <20251017054943.7195-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017054943.7195-1-johan@kernel.org>

On Fri, Oct 17, 2025 at 07:49:43AM +0200, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> probe function must not live in init. Device managed resource actions
> similarly cannot be discarded.
> 
> The "_probe" suffix of the driver structure name prevents modpost from
> warning about this so replace it to catch any similar future issues.
> 
> Fixes: cec32ac75827 ("clocksource/drivers/nxp-timer: Add the System Timer Module for the s32gx platforms")
> Cc: stable@vger.kernel.org	# 6.16
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Addressing this apparently depends on commit 84b1a903aed8
("time/sched_clock: Export symbol for sched_clock register function")
which was merged for 6.18-rc1. 

So the stable tag should be dropped (e.g. unless it's possible to
backport also the dependency to 6.17).

Johan

