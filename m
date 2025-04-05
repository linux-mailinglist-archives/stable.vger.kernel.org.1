Return-Path: <stable+bounces-128374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97468A7C7FE
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 09:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD1F3B8406
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 07:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4953F1C84D3;
	Sat,  5 Apr 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCbfqK1U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7C191F89;
	Sat,  5 Apr 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743838633; cv=none; b=Ceink6J3t2KAj91HbjDwhqh3t1yRwW9fR34k33QaDn7GJ8qGAMyB75Gkn6k8fj3EK+vZXljXAf9IhjWjajIiWUsuWPAJthagoA9w9zd9GwPx2ohemRm0rkKWYLUw1J0QOGuQMyVAwPJa+1KWuN13CbUSXux3oxkOoV1XXzt9Bsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743838633; c=relaxed/simple;
	bh=SMWsKryjlEudisI7vSbfFoDtNgIR3H1MEF8h/a/GMKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM4jng0eAB07gYFv6sT1V3qeYeMszydZmY+ZpQgpRu8QNs8DQ0yu0kb4qTx8O8BtKiGY+LE4uyE+HdbOEIKidTqCQY4JICuVcQyq4+T70EGrXEyICUnUbcfkAREVljvK8LZHwqJmGpOBvNJFCGQaRa+hUqwJPy+ZOVjUfg8u2dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCbfqK1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B39C4CEE4;
	Sat,  5 Apr 2025 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743838632;
	bh=SMWsKryjlEudisI7vSbfFoDtNgIR3H1MEF8h/a/GMKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCbfqK1UEhEtBfJLZTRQOJcyActqHfTLGkzrpSYdkqkLLEG2U1qCgTNKJlJlxsej5
	 vDaCKOHPz5OWgjTqpxlsTxqlKfIEs5Swe4Wnphp7C8gMD9fl8YVOrqwVOjgPtXfIv8
	 9q0GRVYPDs2sE1CFy69gT+9x4VqFQ0wDRVue1egw=
Date: Sat, 5 Apr 2025 08:35:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryo Takakura <ryotkkr98@gmail.com>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, bigeasy@linutronix.de,
	conor.dooley@microchip.com, jirislaby@kernel.org,
	john.ogness@linutronix.de, palmer@dabbelt.com,
	paul.walmsley@sifive.com, pmladek@suse.com,
	samuel.holland@sifive.com, u.kleine-koenig@baylibre.com,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] serial: sifive: lock port in startup()/shutdown()
 callbacks
Message-ID: <2025040553-video-declared-7d54@gregkh>
References: <20250405043833.397020-1-ryotkkr98@gmail.com>
 <20250405044338.397237-1-ryotkkr98@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405044338.397237-1-ryotkkr98@gmail.com>

On Sat, Apr 05, 2025 at 01:43:38PM +0900, Ryo Takakura wrote:
> startup()/shutdown() callbacks access SIFIVE_SERIAL_IE_OFFS.
> The register is also accessed from write() callback.
> 
> If console were printing and startup()/shutdown() callback
> gets called, its access to the register could be overwritten.
> 
> Add port->lock to startup()/shutdown() callbacks to make sure
> their access to SIFIVE_SERIAL_IE_OFFS is synchronized against
> write() callback.
> 
> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
> Cc: stable@vger.kernel.org

What commit id does this fix?

Why does patch 1/2 need to go to stable, but patch 2/2 does not?  Please
do not mix changes like this in the same series, otherwise we have to
split them up manually when we apply them to the different branches,
right?

thanks,

greg k-h

