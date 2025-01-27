Return-Path: <stable+bounces-110873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D63A1D7DC
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 15:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD24A18875B7
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 14:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295F11FF1DF;
	Mon, 27 Jan 2025 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XazM7rLm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D0B4A1D;
	Mon, 27 Jan 2025 14:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987146; cv=none; b=F/AmEMLjrnn3BKEmmS2JE7x9APZs4rgKG+Kk3A2R8mg/gb5C9SSQ7ZMYuWMRzUGTDEYTJwU11XkCYXShztDEUm60+qFTlrshriMAK28DRj4u4cx8HARaznAqrkr+tIOOldtNln6DzwhQuYhKrOvAgrbLfYXF4P1janmvLKiA20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987146; c=relaxed/simple;
	bh=SJQ+G0TU5BIxya1bZ/IXkDXPD3Jmv/wC12bMpA0sCGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJPaXsMgSKJCoaC3WUqE4yF5hyR+IB/f6IOy1LGyI5tIDoIrU0cyVKl4Qvbd8EPngz28hYJUsdKWMDM5cBjfDmfJBxhX0udtNyq4m2lSLSS24Md9t07S9ChTo/94/Y6GfXYc59SCUI0U91Ay8rCPFRp51MsNmodCPa6RT2AeB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XazM7rLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC4BC4CED2;
	Mon, 27 Jan 2025 14:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737987146;
	bh=SJQ+G0TU5BIxya1bZ/IXkDXPD3Jmv/wC12bMpA0sCGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XazM7rLmD6sGAWkbuYHRFzIWiNLKpnSC9jbyjAB7wN/sDbyPBCDKkpn6r2Gg/UIYp
	 O16mooU0mbWdY1TAbb22Po+AS3M6uhFmJMBk85EbTdGtj9PPEVEJyt4uKuvH2uSOeL
	 K7jfVL5isB8dLYr94EToWiwC3aMYu0PabYQkpq3c=
Date: Mon, 27 Jan 2025 15:12:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rabeeh@solid-run.com,
	jon@solid-run.com, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "mmc: sdhci_am654: Add
 sdhci_am654_start_signal_voltage_switch"
Message-ID: <2025012756-dividers-goon-8c9b@gregkh>
References: <20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com>

On Mon, Jan 27, 2025 at 02:35:29PM +0100, Josua Mayer wrote:
> This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.
> 
> This commit uses presence of device-tree properties vmmc-supply and
> vqmmc-supply for deciding whether to enable a quirk affecting timing of
> clock and data.
> The intention was to address issues observed with eMMC and SD on AM62
> platforms.
> 
> This new quirk is however also enabled for AM64 breaking microSD access
> on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
> causing a regression. During boot microSD initialization now fails with
> the error below:
> 
> [    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
> [    2.115348] mmc1: error -110 whilst initialising SD card
> 
> The heuristics for enabling the quirk are clearly not correct as they
> break at least one but potentially many existing boards.
> 
> Revert the change and restore original behaviour until a more
> appropriate method of selecting the quirk is derived.
> 
> Fixes: <941a7abd4666> ("mtd: spi-nor: core: replace dummy buswidth from addr to data")

Please don't use "<>" in the Fixes: line, that's not how the
documentation asks to use it.

thanks,

greg k-h

