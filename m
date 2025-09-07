Return-Path: <stable+bounces-178030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E3B47987
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 10:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1F43C621B
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228AD2192EA;
	Sun,  7 Sep 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="teOBFkz3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4214AD2D
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757232774; cv=none; b=eGdmHXFpXNzMPNB/UFHAKda7GlYgf525KC6WhI33cphLiPQ+c9291qE9epTkA6HSW26WlDsJg04Dw+xetfwUCehb5WGoB8kIYr4/MHeBA0paDmq13eAorZH6mXJH5vwtgfvgJMV/p+Pp1bnlEq1tFqRX/d13C9p2tqS0KkQ/0Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757232774; c=relaxed/simple;
	bh=wBKPKcwtkzzmuR3FoGSVY+/1acL1qGjq4VC/fZqqSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7HjPJvFHz8uc6wz3iooOtMdT1YFeRszyavxhDCMztgaJ7WXGyEPmJfMb0ms4oF4gFMWlYN0kvsNaPzpWczLaob4Tv6xBKVVXvT06OZMS6z/t6gBUP6YBy9BnuQW8wDBSRh74BPpuQ5goEhI+J8IaPsD8TFhpv//TcFBoBWipzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=teOBFkz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BA2C4CEF0;
	Sun,  7 Sep 2025 08:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757232774;
	bh=wBKPKcwtkzzmuR3FoGSVY+/1acL1qGjq4VC/fZqqSPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=teOBFkz3hZb82pHymbY39W4xBatHACsnBkSwjTkoQscWlCRd6YvpWkXG8LyzMOACQ
	 Jc4/DF6NMI31e7f2va9TpeuFe3CkiCgT5Q5JYeJrpmf4VqPx2YGIb0S0vWQe4QSRNk
	 kjy6WQnR3gP8CUaUDD9SiVtiJJeFOi0Bcy+zJBKI=
Date: Sun, 7 Sep 2025 10:12:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: stable@vger.kernel.org, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Keita Aihara <keita.aihara@sony.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 0/1] mmc: core: apply SD quirks earlier during probe
 on 5.15 stable kernel
Message-ID: <2025090729-canned-unbent-1f91@gregkh>
References: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905111431.1914549-1-ghidoliemanuele@gmail.com>

On Fri, Sep 05, 2025 at 01:14:28PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Hello,
> 
> I noticed that commit 1728e17762b9 ("mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier") 
> introduces a regression because since it depends on the backport of 
> commit 5c4f3e1f0a2a ("mmc: core: apply SD quirks earlier during probe").
> Without this patch the quirk is not applied at all.

That commit id is not a valid one in any tree I can find :(

confused,

greg k-h

