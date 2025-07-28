Return-Path: <stable+bounces-164986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2F2B13F59
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 18:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92C37A2479
	for <lists+stable@lfdr.de>; Mon, 28 Jul 2025 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F7412E1CD;
	Mon, 28 Jul 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvhszmSu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FD925771
	for <stable@vger.kernel.org>; Mon, 28 Jul 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718429; cv=none; b=X4I99zmN3oIiiA7XI+OOWNlI4pIuI+Cx33ykyL/jnDby/3VKdr6gxNB+NxUUyHynfweB5pSk50tEkDm8Za+tzrnXItZx9RcUkkH3WObTUpZqludzP6jVd8yaAs7Fc4YpPmtzD0LeXjB00QgHHh1ml8SeSCGWeG3y/IhDdVPVdjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718429; c=relaxed/simple;
	bh=4E3n+F893rQeB+FDD93fxTvPT5gasbz1kDXvV0yLLkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQKyr76epimKVVZbhc+2Q14KdHacjaQhHoDuFDCWJTBIk2V2mICUqjZlm1RCY6HYkVgLtzj3Y/y3jXD+NFyXTK5jXdcCQQSomgAyPAmH5e0L5ClyGA2dqq8WPh6c5HLNKhL0snAJn4uSSkx4PPcI8L2fn+7Bci2IagKukrIeBHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvhszmSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EA1C4CEE7;
	Mon, 28 Jul 2025 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753718429;
	bh=4E3n+F893rQeB+FDD93fxTvPT5gasbz1kDXvV0yLLkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvhszmSuVl1UmjQLo1TPYNQzO5J7OCk5KYCdye9J1hqSQcHWxUGABobQ7a0cohZSn
	 pqn/U/9I5qAvlvZyXV2OndrUcNYDBRBExKZkosEopbq+lvsPO/QfJ/WN/RQlt3P7Yg
	 uf2GtML0pvgvcXRami/UvkN1tpBkmxVivCknMYUY=
Date: Mon, 28 Jul 2025 18:00:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: f0915acd1fc6060a35e3f18673072671583ff0be for 6.12.y
Message-ID: <2025072820-satisfy-unroll-640a@gregkh>
References: <CANiq72koQ28Z+-gx5ZmAeGFMLSsN5PfFawRkbGvEsUskp==F2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72koQ28Z+-gx5ZmAeGFMLSsN5PfFawRkbGvEsUskp==F2w@mail.gmail.com>

On Fri, Jul 25, 2025 at 10:14:37PM +0200, Miguel Ojeda wrote:
> Hi Greg, Sasha,
> 
> Please consider commit f0915acd1fc6 ("rust: give Clippy the minimum
> supported Rust version") for 6.12.y. It should cherry-pick
> 
> It will clean a lint starting with Rust 1.90.0 (expected 2025-09-18)
> -- more details below [1]. Moreover, it also aligns us with 6.15.y and
> mainline in terms of Clippy behavior, which also helps.
> 
> It is pretty safe, since it is just a config option for Clippy. Even
> if a bug were to occur that somehow broke it only in stable, normal
> kernel builds do not use Clippy to begin with.

Now added, thanks.

greg k-h

