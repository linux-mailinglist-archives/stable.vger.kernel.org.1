Return-Path: <stable+bounces-32157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D8888A359
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 14:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC621F3C6B7
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566201791E9;
	Mon, 25 Mar 2024 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="vb5HdJF0"
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FCC180B99;
	Mon, 25 Mar 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359086; cv=none; b=EgRQaspg7qPTjTGqsT0eY9fgu3/hFJ9IkaUUtFG+hUJAtkSg6YvnUnKyrsmjonXcMqKad7vM1vTio2cIKlOn4xnSksMsg2ywCxknV+fdKCWPdgXXBcexoRNXCxah9y6NF3Y0DzUI17etKSNx3AomDSp/O6n1vvZuNRFUynnh8ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359086; c=relaxed/simple;
	bh=KQGRm43bE3L3xwmGGbOrt02HPI+IV/E4JEYCnarpe/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKCECPFPtq29O+HVdJu6inw2b23PFKQSBQupTMTcqBEiBk1eG8O6N5vU4iimzaEUlSdrXvpJFa9ZhA9gzpZYV+yIC4w7KGJvti8vp5wvUnYFXlzUTOmPFTiI0hTWpl1LG6iAKuZ5/KvdirIDZVCfCqyQqlGUJ0LXTdwl3rEISSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=vb5HdJF0; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9E9CC20313;
	Mon, 25 Mar 2024 10:31:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711359081;
	bh=RqCHlux3BXSBH8WfjK7YiZFQfbZIsOiaTbXVVkYin8A=; h=From:To:Subject;
	b=vb5HdJF0Keio6EXkMphx6ZUlYOqwaQp79GhqO9t382nXW6Pu61rmvoFa21dI0bXun
	 TvVQ83rdV9mUIqOIUU31X7Qx01/Ci710cjKjU0pZ93+6+LP+cZNmxvbaiwrql01rka
	 COvCxQaPtWFwuIkTbCNhtRaCo4+yPp6S8Sp0/Ef8qPqXtqo600spRa0AUP8+SAwHqh
	 5zqnUq8KIbQ+ILF7GIx0baVu8u9HZg2ue6THDusTrci9suuwtjLRAxDWMoqESuN2at
	 zm2PkwAXh0UI+8jyNtouHRdUc2fVjpT+POpY0tzKg3FBQK6daIIn/h3Onyh99eHDd8
	 NnJjz1ADP1VUg==
Date: Mon, 25 Mar 2024 10:31:20 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: mikko.rapeli@linaro.org
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc core block.c: avoid negative index with array
 access
Message-ID: <20240325093120.GB136833@francesco-nb>
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
 <20240313133744.2405325-2-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313133744.2405325-2-mikko.rapeli@linaro.org>

On Wed, Mar 13, 2024 at 03:37:44PM +0200, mikko.rapeli@linaro.org wrote:
> From: Mikko Rapeli <mikko.rapeli@linaro.org>
> 
> Commit "mmc: core: Use mrq.sbc in close-ended ffu" assigns
> prev_idata = idatas[i - 1] but doesn't check that int iterator
> i is greater than zero. Add the check.
> 
> Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
> 
No empty new line here.

> Link: https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/
> 
No empty new line here.

> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco


