Return-Path: <stable+bounces-20640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5945A85AAA9
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BC4B20E74
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B52547F7E;
	Mon, 19 Feb 2024 18:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bbyIsset"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098046B9F
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366437; cv=none; b=Uq++DflZQWo1eZB4jg1sh7L10xzKRJ9HgAVluNPAZWq2v+BHDRyH9uS73k/q6Ew6GUzOMaqgnOpLeFo02JX7HcIjTaEwwt369qnx7ECrgRt6F1R+O7MAL8+U6DZ/snJbkLuezDvMfNGh1f3/rIrpS4i90AN/OOzImTnKvFgNmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366437; c=relaxed/simple;
	bh=LK4TsyiOZ3PD9ejX61w9F8BtRXhFzFX7se+tf+vXySY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4TpVgf9H+q6rhLxr+Alp1h0mjvowVjyYEUZSqDZaei3fhPHQFi0Y48u1dkPOUQE/lFjxhzqmeMng8P5TqZUm8BWtcJz6fTu1EoibP3D/Y43i99lVdBnTzc21fLlgoiS9FZbXeCsGN+7hS5do0L58Wt1Vr//KgEhzrxB6NHs27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bbyIsset; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57778C433F1;
	Mon, 19 Feb 2024 18:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366436;
	bh=LK4TsyiOZ3PD9ejX61w9F8BtRXhFzFX7se+tf+vXySY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbyIssetKwZieDNYlKSO+4taYfD2xtLu+LvoPZI3ZIf4Hrgbh3VCadkQxQHrHo0OQ
	 Cet1nHjQ1/xCIiBFxSB6LfdZ6vihSMAiE2l+05ltasY4fUpqcG1Fb9GDQjJgnKpTbc
	 zBrrn/CMPVNPz8yf1heFVtlaXgb3tviPc8wiIbCA=
Date: Mon, 19 Feb 2024 19:13:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sri Sakthi <srisakthi.s@gmail.com>
Cc: stable@vger.kernel.org, srisakthi.subramaniam@sophos.com
Subject: Re: xfrm: Remove inner/outer modes from input/output path
Message-ID: <2024021946-mooned-utensil-7b3b@gregkh>
References: <CA+t5pPnX+Rk2eOHO_hWeQmSP5yV6CRhBURuVEnfkqvtR9Rvopw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+t5pPnX+Rk2eOHO_hWeQmSP5yV6CRhBURuVEnfkqvtR9Rvopw@mail.gmail.com>

On Tue, Jan 30, 2024 at 01:13:29PM +0530, Sri Sakthi wrote:
> Hi,
> 
> Below 2 xfrm ipsec related commits have already been merged to
> mainline. From Herbert Xu.
> 
> 
> 
> Description: Remove inner/outer modes from input/output path. These
> are not needed anymore.
> 
> 
> 
>   xfrm: Remove inner/outer modes from output path (commit:
> f4796398f21b9844017a2dac883b1dd6ad6edd60)
> 
>   xfrm: Remove inner/outer modes from input path (commit:
> 5f24f41e8ea62a6a9095f9bbafb8b3aebe265c68)
> 
> 
> 
> Reason for backporting – We have transport mode interleaved with
> tunnel mode support as part of ipsec with compression offering. These
> commits in v6.1 LTS would help.
> 
> Requesting to apply these commits to Kernel LTS version 6.1.
> 

Now queud up, thanks.

greg k-h

