Return-Path: <stable+bounces-100258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C8B9EA0B8
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACAF165125
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4BA19AA72;
	Mon,  9 Dec 2024 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rkvp+zmT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871291E515;
	Mon,  9 Dec 2024 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777775; cv=none; b=P+5RsBz02VxPgKcgjCZIJdhoXFCHlyIJ5AjHk9Y4xIpVVbYuGmlj3Om6SSgOC10bhZST2cnQCmpDxa6P8ADVBecTSDf5CWe8epeixp6EBT/93/Jl93gtIPAJipYFwMASD5FW86fUGNbj1sDOGt+kF2czLLFFrhat/XsJWLA5qxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777775; c=relaxed/simple;
	bh=6dnZ68J8B3M1iQ9BeBytoXdubFp4ONsa9Id6lOSZ8J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOKr7ytx+LKjN7x82opXSRT5uwBJlK6UR7YTQHYkfro8G9+TBVLSS4rDNHbsK39ybWPKQSkBOJcuz7XajurmbKiBWovxIWSBWTo3/+03HyGcFUd+Wbu1yJbf8rCoIj3UBKm9AhQseP+mNU4K7zboTyWBTaMHP6vd3uNx62a/+uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rkvp+zmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A96C4CED1;
	Mon,  9 Dec 2024 20:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733777775;
	bh=6dnZ68J8B3M1iQ9BeBytoXdubFp4ONsa9Id6lOSZ8J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkvp+zmTSkdei60gApkIyV8FPWAcnuDnlcmUJ3SGYEjY6tCfs4qHKPnV/KlgA7Pmo
	 RdSt0KKErJD3gj3xV9hwXGvGm2jOrySdCeBaLsOoKPU1YIqE9Cqa+Ulybjtek8jnim
	 86z+MJmxVRIWVPVCm8VjPMQ2OUTdRiFc0Ba9k7GznbCjIqBROC4TX3VvgMZVipe4wC
	 72YpW/g8QuU/9lp+F2a2jnl1jBE5FRA3EV9vZv0ugHK2q3+3ZUwm+MNf9mGKpzwsYI
	 VV5PoTsRC0Ch1f0RLU5mOlINVEEW+n0bYXL1szqpzAjKvOeIV0BrFDSTmbI40frFJy
	 SuKx1F9xlXCYQ==
Date: Mon, 9 Dec 2024 14:56:13 -0600
From: Rob Herring <robh@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Stefan Wiehler <stefan.wiehler@nokia.com>,
	Grant Likely <grant.likely@linaro.org>,
	Tony Lindgren <tony@atomide.com>, Kumar Gala <galak@codeaurora.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Jamie Iles <jamie@jamieiles.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <rob.herring@calxeda.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] of/irq: Fix wrong value of variable @len in
 of_irq_parse_imap_parent()
Message-ID: <20241209205613.GB938291-robh@kernel.org>
References: <20241209-of_irq_fix-v1-0-782f1419c8a1@quicinc.com>
 <20241209-of_irq_fix-v1-1-782f1419c8a1@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209-of_irq_fix-v1-1-782f1419c8a1@quicinc.com>

On Mon, Dec 09, 2024 at 09:24:59PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Fix wrong @len value by 'len--' after 'imap++'
> in of_irq_parse_imap_parent().
> 
> Fixes: 935df1bd40d4 ("of/irq: Factor out parsing of interrupt-map parent phandle+args from of_irq_parse_raw()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, but rewrote the commit message:

of/irq: Fix interrupt-map cell length check in of_irq_parse_imap_parent()

On a malformed interrupt-map property which is shorter than expected by 
1 cell, we may read bogus data past the end of the property instead of
returning an error in of_irq_parse_imap_parent().

Decrement the remaining length when skipping over the interrupt parent  
phandle cell.


