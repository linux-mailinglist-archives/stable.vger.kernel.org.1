Return-Path: <stable+bounces-155177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75039AE21AE
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C35B13A55D5
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB8428DF50;
	Fri, 20 Jun 2025 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSbX0zMN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6F1DC075
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442218; cv=none; b=udFucBYILlxIxz7j+RxAszWTEB05M6vBGZvOLBP7Be5owwO1iJ83U0kK9CIROn/vNM3W2PCewH1ZNKBhABF66AhLFH4IIZPHOKHng7anEguAoVpATApVmlFPMAua1oKuVXmsiyoy+8uH0bZgb7G3IQ1LXoqj61tMh7fQkjbXQt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442218; c=relaxed/simple;
	bh=uaZS2lY1wWH8ULN8cdwBfE0456jtB1TGjkviypHcMF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWlCx+0hAxEyc34P5QKH45c/lsYd32gWxYQVYvsKI/t+Z1jCThgw8wj7dkHkJDt0S4ygys+hl1+nF5ywozDZGwN+HxA6PTQIi83KPhRSeTslzXadPwkbPl6CeJSpn/n6zrk2hiM2NahMtRgsw7FJvxxBAtbEFZgxUvXAkjp4B2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSbX0zMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC247C4CEED;
	Fri, 20 Jun 2025 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750442217;
	bh=uaZS2lY1wWH8ULN8cdwBfE0456jtB1TGjkviypHcMF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSbX0zMNd00JcRAoZMaWXD9Mx6MydhBmnzPT8MD8M+OfW6lWeg4Pf/VwE7ZOIfNLY
	 aAMLT7UYlLdo70qfwocedYlFE7pXbXajl6YI6lOSig7KoxXslZHVzwiFQ7kdBGOBFJ
	 S2wVHjVY1a0j8hZmXZC7p3j+AKuOZhmgEI0+Zk9NpfzLWKztHUSmVY1MCH6MmJC3xx
	 scMEUo8A+se/LZtYdalL9BUmPQY3sK5TCWoiDR7/dQWl0vBaL6gpbjqYfYu8AUmX4w
	 F4BYwsjEfS74JypQyPTrv3iDZF+snOiGPcPFGOIrHCZd9VlAZJpz2BIOvDJ6MEs/KK
	 /C5fY6ac8eF2g==
Date: Fri, 20 Jun 2025 10:56:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org
Cc: kees@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] net: qede: Initialize qede_ll_ops with
 designated initializer" failed to apply to 6.15-stable tree
Message-ID: <20250620175653.GA648595@ax162>
References: <2025062020-pumice-wad-3173@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025062020-pumice-wad-3173@gregkh>

On Fri, Jun 20, 2025 at 09:34:21AM +0200, gregkh@linuxfoundation.org wrote:
> From 960013ec5b5e86c2c096e79ce6e08bce970650b3 Mon Sep 17 00:00:00 2001
> From: Nathan Chancellor <nathan@kernel.org>
> Date: Wed, 7 May 2025 21:47:45 +0100
> Subject: [PATCH] net: qede: Initialize qede_ll_ops with designated initializer

This is one of those unfortunate situations where a patch went into
mainline twice via separate trees

  6b3ab7f2cbfa ("net: qede: Initialize qede_ll_ops with designated initializer")
  960013ec5b5e ("net: qede: Initialize qede_ll_ops with designated initializer")

and it is already in the stable trees from the first SHA, so nothing to do
here.

Cheers,
Nathan

