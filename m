Return-Path: <stable+bounces-120439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794EEA50152
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B93816D228
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B2D24A07A;
	Wed,  5 Mar 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sT9KKDR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5924BBEF;
	Wed,  5 Mar 2025 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183527; cv=none; b=iYkIr/ky1kTTnq+vB4+KgvpD2GdAO7RCa8wNxEkCFdMKXQf4s50KFjaaVDNIfiORiFya09hrsFJbP2cAb9HCHAfVhcWFOh+5M9zBCU6lRsnnkD2YV7/nw2HQyiBYIb16tH8SOHcZfZh5NSaDR75slOfruaINEL6A01Vmtqgu23U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183527; c=relaxed/simple;
	bh=zchE8X1whQmVeJlnC5PHmN3S7uQYT0//TVAMFvdxM2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baVlxnqTnj8Pz5Krhey70v6TfDeHtmqo5cc7163yvfU8B8lgWKauWsuwFizcM5vTFETxcdRVuF2wznpK0ovMjIVnZF+z/tSV1k/hqdyvOMKVc6qOwagJVDokfTlG+XSMdtH1AVaHkz/UTG5Uji6AMCqaZyEXJFpsKN6+bnpOhaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sT9KKDR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974A1C4CEEB;
	Wed,  5 Mar 2025 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741183527;
	bh=zchE8X1whQmVeJlnC5PHmN3S7uQYT0//TVAMFvdxM2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sT9KKDR2UBDMpYJgVvBAO/yHY6oPoB1TushDFUDty4G3j8GZW1jrDIxnFmlLNd5lA
	 C5TLYO28YzsPP4nZEUrlaD/TzoZJNEeCgrFteEhAkqjwI05S7cZgVwc1jPP3bVIgEP
	 xXbrdu4rGmr/LYN10wuUF+7afYIgV3riodXFK0kE=
Date: Wed, 5 Mar 2025 15:05:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Simon <simon@swine.de>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, jolsa@kernel.org
Subject: Re: [6.1.y][6.6.y] uprobes: Fix race in uprobe_free_utask
Message-ID: <2025030550-last-fit-9d20@gregkh>
References: <f32da38f-d313-48ed-9ca6-7da210b08f8b@swine.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f32da38f-d313-48ed-9ca6-7da210b08f8b@swine.de>

On Tue, Mar 04, 2025 at 10:33:24AM +0000, Christian Simon wrote:
> Dear stable team,
> 
> I noticed that cfa7f3d2c526 ("perf,x86: avoid missing caller address in stack traces captured in uprobe"), got backported into 6.1.113 and 6.6.55, but it contains a race condition which Jiri Olsa has fixed in mainline b583ef82b671 ("uprobes: Fix race in uprobe_free_utask"). I think this should be backported into those stable branches.
> 
> #regzbot title: uprobes: Fix race in uprobe_free_utask
> #regzbot introduced: cfa7f3d2c526
> #regzbot link: https://lore.kernel.org/all/20250109141440.2692173-1-jolsa@kernel.org/
> 
> Link: https://lore.kernel.org/all/20250109141440.2692173-1-jolsa@kernel.org/
> 
> Note: Sorry if I am using the wrong process/form/format, I tried to follow "Option 2" from the stable-kernel-rules.html.

As the patch does not apply cleanly to those kernels, how did you test
this?

Can you provide some working, and tested, patches for this?  We'll be
glad to queue them up if so.

thanks,

greg k-h

