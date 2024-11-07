Return-Path: <stable+bounces-91759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BD9BFE85
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 07:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A707B2836C6
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 06:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E618E762;
	Thu,  7 Nov 2024 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m5PtJax/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4A1426C
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961353; cv=none; b=DKLeXwcgbDG1aiu7YIcytd9E2L2w2N7gxiiZ1VLhrWYee42L1q3l1xCE6f1mKiGZJ7lRHD7hEoOj/KteoY7MUgUUn1evJ54aB3ULmCuvYIg70J+fdG0Mlh8ZtHsoMisxxit+M5EoW+RW3WlKie/1szMLoeUOOW1XOXfwxaYH0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961353; c=relaxed/simple;
	bh=BVm5VeByFaDDVeYK5MYQLd1E5dIfWp+N9ad/3n19vZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kco/5BSnde537bITiHI5QvbZbQv5/y5HnaK4vD/rlszm1ZtI31musfU4ZQAtyYbM4VyW03VoTASvksJ66rVdrlWKoRnhg9+YP9gLc6SXDlAElnwhqlbsWYGBzJrzNm63G8jcmpp2+fEcqo6WrP5h54v3IdyJKsdWYW3CEliob6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m5PtJax/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20E9C4CECC;
	Thu,  7 Nov 2024 06:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730961353;
	bh=BVm5VeByFaDDVeYK5MYQLd1E5dIfWp+N9ad/3n19vZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5PtJax/osC2JUpX3KoS/uhLi8zLFMwnIcwckAOfQdmRpunLbmAZEPUlLUtW6UCW9
	 26sVN7wuIB6qvULo+jabRYG+qeVYVAhDAZVrC+gqf6kXdi4Qx8jkuuBRtcDDlrR2/U
	 0qaoTA6xT4s8tMTXpjgEwBtyGtSwPINwMG7+32as=
Date: Thu, 7 Nov 2024 07:35:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Conor Dooley <conor@kernel.org>
Cc: stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	Jason Montleon <jmontleo@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [for 6.11 PATCH] RISC-V: disallow gcc + rust builds
Message-ID: <2024110724-sleek-emptiness-24b3@gregkh>
References: <20241106-happily-unknotted-9984b07a414e@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106-happily-unknotted-9984b07a414e@spud>

On Wed, Nov 06, 2024 at 01:11:29PM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> commit 33549fcf37ec461f398f0a41e1c9948be2e5aca4 upstream

Thanks for the backport, now queued up.

greg k-h


