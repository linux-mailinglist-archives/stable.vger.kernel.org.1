Return-Path: <stable+bounces-203047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D928CCEA23
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 07:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F78630184FF
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB9283FC8;
	Fri, 19 Dec 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ysgt2Rh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A515746E;
	Fri, 19 Dec 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766125258; cv=none; b=uEG+DOPW67gJXlqHP1slW3FhS9yn65ARgEgKp8JSRRABmgbdz1k/gtWvpVWkBqIv+Qjnmhf2O7dGZIjvkzPaWwk8/JrioVxTZ6Rg55vqwD73CJvgMrb/L11nUX8FLWFetYC12MUnetM1pod9ubFK62s6/fFxCfl3S2OUp1eUAH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766125258; c=relaxed/simple;
	bh=CFffmxEAlIDNCbiW2RnxGade/KI8oIITcwBqKbPxO98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHkLUP6FSDT5rkhoc1zK7szwEuvGkhqN4vF3odHg4dhLseimfZWJb2/c8QwAsrxk0UCZOUIoI6b0FcOOvJANHH+4z11Bb80HKXGNxxtl/Fem+8n7rkVUFP55yBzJkm1P/c3E45ifDZqnp33f5sfFAoQB32pnf6ph3/kL0ISdFT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ysgt2Rh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCEFC4CEF1;
	Fri, 19 Dec 2025 06:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766125257;
	bh=CFffmxEAlIDNCbiW2RnxGade/KI8oIITcwBqKbPxO98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ysgt2Rh7JdK0aX43AueDcmgI7/CrD+uG/873ohvSZc5tuhbc1T7d0FdVMtPqi4+DX
	 xNAI4Q8iZGDXUB/+tx0U0kNu1XpDiWwJ6rvVilWEjwK2NaJZnWKOq916fDDJV1KZIy
	 tJtVXT9WnwgBqZGfUAJqvCJs2dkGAhtbE3VT1NIhDJ8aB0zubynjFJ4eQ9oq3aIXyq
	 bS4cUFbb+2xtEQWvfbIWaXU76Qbtryd/QmgYbzaFNO/Ol/WRSRLEuKYoWAiQs95iyN
	 6+bNmOtQDCc3Z2Y/Sa+9uBKCUqW9R666daRtnn+zqB+tA5fli3e4Gb1aPFOOkoUVz4
	 MosVPb56u7fgg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vWTrC-000000001YG-3wkr;
	Fri, 19 Dec 2025 07:20:55 +0100
Date: Fri, 19 Dec 2025 07:20:54 +0100
From: Johan Hovold <johan@kernel.org>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Alan Stern <stern@rowland.harvard.edu>, Ma Ke <make24@iscas.ac.cn>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/5] usb: phy: isp1301: fix non-OF device reference
 imbalance
Message-ID: <aUTuxjyqh3EE_wJd@hovoldconsulting.com>
References: <20251218153519.19453-1-johan@kernel.org>
 <20251218153519.19453-3-johan@kernel.org>
 <71adaa7f-808a-47df-85ed-55ec12da4561@mleia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71adaa7f-808a-47df-85ed-55ec12da4561@mleia.com>

On Fri, Dec 19, 2025 at 02:15:12AM +0200, Vladimir Zapolskiy wrote:
> On 12/18/25 17:35, Johan Hovold wrote:
> > A recent change fixing a device reference leak in a UDC driver
> > introduced a potential use-after-free in the non-OF case as the
> > isp1301_get_client() helper only increases the reference count for the
> > returned I2C device in the OF case.
> 
> Fortunatly there is no non-OF users of this driver, it's been discussed
> recently.

Yeah, I saw the discussion, but figured it was best to just fix up the
existing code before you guys get on with ripping out the legacy
support.

> > Increment the reference count also for non-OF so that the caller can
> > decrement it unconditionally.
> > 
> > Note that this is inherently racy just as using the returned I2C device
> > is since nothing is preventing the PHY driver from being unbound while
> > in use.
> > 
> > Fixes: c84117912bdd ("USB: lpc32xx_udc: Fix error handling in probe")
> > Cc: stable@vger.kernel.org
> > Cc: Ma Ke <make24@iscas.ac.cn>
> > Signed-off-by: Johan Hovold <johan@kernel.org>

> > @@ -149,7 +149,12 @@ struct i2c_client *isp1301_get_client(struct device_node *node)
> >   		return client;
> >   
> >   	/* non-DT: only one ISP1301 chip supported */
> > -	return isp1301_i2c_client;
> > +	if (isp1301_i2c_client) {
> > +		get_device(&isp1301_i2c_client->dev);
> > +		return isp1301_i2c_client;
> > +	}
> > +
> > +	return NULL;
> >   }
> >   EXPORT_SYMBOL_GPL(isp1301_get_client);
> >   
> 
> Okay, let's go the way of fixing the broken commit instead of its reversal.
> 
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

Thanks for reviewing.

Johan

