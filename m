Return-Path: <stable+bounces-116445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE468A365CF
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 19:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796EC168454
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681D18B482;
	Fri, 14 Feb 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="qqrDSigE"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66FC18F2DF;
	Fri, 14 Feb 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558355; cv=none; b=V4vAgmXEr1AOtOayqrxvA5uZ+6AwNzafpaDSSda2wPYdTjmEFySUTK8pZ8VfWIXPPQKF+IVTb+2KTUiIJnTO6i9nQEFeXHEBiHOCmJtFO2i4BFw2GYjbc1UQCZQK6fQgBWOkxKuGw0KGi36CqvTMy1dRmPIECcIWf+qM8N47pBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558355; c=relaxed/simple;
	bh=HFBUipoXXLCrg3VNIwedSsJk8Y1ZZ0IT1W10hWh8S8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sukQXVlCLaQiJP+xjbxO3zE4AaGgeJe3tayJk5N8JtFxjYtkn60uRmVeJ9Fu6dw1PUAVvOocywT543ImFjL4pi/sdO/n/41Tt1N1elMHBL60AWUmxdw5BlHW0ojD+xJkysU2hhgWKqEXZQQ23p4qe50fszZvJ8q2scWpj+2xrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=qqrDSigE; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id C6F2A4226E24;
	Fri, 14 Feb 2025 18:39:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C6F2A4226E24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1739558349;
	bh=NuvJ1f6IlNzpiJHbMztSBYQKkHQn4r7Jn0U2zxp25Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqrDSigEAywui/2olT7dcNP2jyrwVxun7XSY/SRSkD2P1mn9jMimO3ansKmgZzbau
	 jOL9NCbVRfygTSyaHovEb/uivXFxFITYmt3XD/soGtPpG5w16ermZTGbjB5rw9CtQX
	 oGAvplI5DpT7jGvtuDIiMyX0Qqx2+S+AVC6En18k=
Date: Fri, 14 Feb 2025 21:39:09 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Vitalii Mordan <mordan@ispras.ru>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Amit Singh Tomar <amittomer25@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org, 
	Alexey Khoroshilov <khoroshilov@ispras.ru>, Vadim Mutilin <mutilin@ispras.ru>, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: owl-uart: fix call balance of owl_port->clk
 handling routines
Message-ID: <ci23nalbgrgi5o7zbze4adc54mupn6nymu25konthvtbhyjb7u@z4bteiubsiy6>
References: <20250213112416.1610678-1-mordan@ispras.ru>
 <20250214171405.kvyyespxtfqxhapc@thinkpad>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214171405.kvyyespxtfqxhapc@thinkpad>

On Fri, 14. Feb 22:44, Manivannan Sadhasivam wrote:
> On Thu, Feb 13, 2025 at 02:24:16PM +0300, Vitalii Mordan wrote:
> > If owl_port->clk was enabled in owl_uart_probe(), it must be disabled in
> > all error paths to ensure proper cleanup. However, if uart_add_one_port()
> > returns an error in owl_uart_probe(), the owl_port->clk clock will not be
> > disabled.
> > 
> > Use the devm_clk_get_enabled() helper function to ensure proper call
> > balance for owl_port->clk.
> > 
> 
> Do not use newly introduced APIs to fix old bugs. The bug should be fixed
> separately to allow backporting and the conversion should be done on top.

These relatively new helpers are already available in all currently
supported stable kernels including 5.4.y.

Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared and
enabled clocks") was conveniently backported there as a dependency for
the similar bug fixes.

