Return-Path: <stable+bounces-118315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A085A3C6A3
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 18:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3277A864E
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C231DE8A8;
	Wed, 19 Feb 2025 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjDNY0TI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B83519CC33;
	Wed, 19 Feb 2025 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987336; cv=none; b=lvHHI0GhkURBEPt0ftqRGJZMercS+28pDsJk9r+zjwim+W5IahSz7K+Ev652dbmk8TwiHO66FpIK+KuLcSo2k3bzwjrnmpQ8ggk+vOdoGzlMaCS8zNJt0+fOut6fG96P3PKLJB6/EuzPUYAhaf9ZFyiCLBmxsWahCQsC8Q1tbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987336; c=relaxed/simple;
	bh=eABSkrzx4Qs0AYJ01eC/IAUU8ScLgyuVvlLJERhWrVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I80z9ka2gvs7bzZcwIPs1hGioSZ8JSC4/D+RjxGf0cDL6U1V8EbAKFY0hRLD/iY98OZ+YI4XZDWrlIFBP2edMZY0oSZw2wwUmKdHDCFp7aeDH6x9RySoRge0YdOdnT76eoj+/CL4AtYMEYNtCmIok67aEXpcrunTJUPprunIcm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjDNY0TI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3AFC4CED1;
	Wed, 19 Feb 2025 17:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739987336;
	bh=eABSkrzx4Qs0AYJ01eC/IAUU8ScLgyuVvlLJERhWrVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjDNY0TIYWHEiZIkbTaVwR2M8ShomTU1tjkcIn1hYaGEdtYRTpRKDxMomni2QWkzz
	 8OJwJRAYCzeo4UUM36sn0sl+IGWojCEgpML9/1/HB2MmUGYkq/EbtgL97U+zKbb1Aa
	 4wIsa4JPKOIXIvstsKJlL4pjNqL72XWB21dK834dnXOnJ6FVyvPr6EPmXf7Eh5U2v5
	 hDIFHeAh25GRX2nUIf3N2u1SDBqoAwHd9oGYxOXp0B7o0O0KFt1cjRn1E8QIFE35Cq
	 tvPIc7f0PFXIJ2P2iglN25iBxn7l/KdgaY+qT+rAnKbocfeghW5pgJiHoCFqGByO98
	 YpySU+UUiqgYQ==
Date: Wed, 19 Feb 2025 23:18:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Vitalii Mordan <mordan@ispras.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Amit Singh Tomar <amittomer25@gmail.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>, lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tty: owl-uart: fix call balance of owl_port->clk
 handling routines
Message-ID: <20250219174846.t4eso3o2aug6rb47@thinkpad>
References: <20250213112416.1610678-1-mordan@ispras.ru>
 <20250214171405.kvyyespxtfqxhapc@thinkpad>
 <ci23nalbgrgi5o7zbze4adc54mupn6nymu25konthvtbhyjb7u@z4bteiubsiy6>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ci23nalbgrgi5o7zbze4adc54mupn6nymu25konthvtbhyjb7u@z4bteiubsiy6>

On Fri, Feb 14, 2025 at 09:39:09PM +0300, Fedor Pchelkin wrote:
> On Fri, 14. Feb 22:44, Manivannan Sadhasivam wrote:
> > On Thu, Feb 13, 2025 at 02:24:16PM +0300, Vitalii Mordan wrote:
> > > If owl_port->clk was enabled in owl_uart_probe(), it must be disabled in
> > > all error paths to ensure proper cleanup. However, if uart_add_one_port()
> > > returns an error in owl_uart_probe(), the owl_port->clk clock will not be
> > > disabled.
> > > 
> > > Use the devm_clk_get_enabled() helper function to ensure proper call
> > > balance for owl_port->clk.
> > > 
> > 
> > Do not use newly introduced APIs to fix old bugs. The bug should be fixed
> > separately to allow backporting and the conversion should be done on top.
> 
> These relatively new helpers are already available in all currently
> supported stable kernels including 5.4.y.
> 
> Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared and
> enabled clocks") was conveniently backported there as a dependency for
> the similar bug fixes.

Ah, then fine with me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

