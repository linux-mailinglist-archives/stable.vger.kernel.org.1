Return-Path: <stable+bounces-125977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8061A6E4BA
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 21:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531051888B64
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 20:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940CC1DDA33;
	Mon, 24 Mar 2025 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sB8OybSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D351DDA0C
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 20:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742849600; cv=none; b=h3Gn6ZYL/uSxdxZJTnPfnLo1K1y0RoPBnCdZLC99a5UFW+vot3/x9iOyFBlwO9HsAT+fu+6gHx6M6XhS+K/exWVdp5vAsfc/AzzCxkm2bPDyOQLPwLdy2mo2JtEqDAYdvqyEl0YbNOBO8ovshFgrmIPfE/DJfSRCIfJwbvhziCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742849600; c=relaxed/simple;
	bh=1V66Ife3mWO0+i+lNYEhnvtKC1P+DNRe7XCZjKeJMaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGBC3hPlZ1c6jSz7rjwkHX2B5N4u5bHYXSquM0ehdCiMl4F2q2wlrSsxTHVTrJwWLNiJfv7YDr5pieUlpMPQvRzAJytDkVo2UAusixAikyOTuOCAOGVneNFFq4Auq161LEH+OImzTGcTnphPxhWJDBoypupaFI9gVR5lRLo6G2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sB8OybSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92085C4CEDD;
	Mon, 24 Mar 2025 20:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742849599;
	bh=1V66Ife3mWO0+i+lNYEhnvtKC1P+DNRe7XCZjKeJMaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sB8OybSKKhZhURk0reaBhGdxv+SapcmS4dZmLzZOTj0QmyWNdzBTKENUMnC/Hd8/5
	 ZlRvxWyUbGmT2wCvLzgVoW/iUoxb0CW3YdzhzX5n2z8yhHYxGyM+Ew2mlkeOCi5rB6
	 ZYQ8jGuxxkbUbankmaBl1vezmHlPqkz7AbP2mh2s=
Date: Mon, 24 Mar 2025 16:51:57 -0400
From: Greg KH <gregkh@linuxfoundation.org>
To: Hagar Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6.12] Revert "sched/core: Reduce cost of sched_move_task
 when config autogroup"
Message-ID: <2025032435-recharger-passcode-0b2d@gregkh>
References: <20250324114156.31212-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324114156.31212-1-hagarhem@amazon.com>

On Mon, Mar 24, 2025 at 11:41:47AM +0000, Hagar Hemdan wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> commit 76f970ce51c80f625eb6ddbb24e9cb51b977b598 upstream.

You forgot 6.13 :(

Also, it doesn't apply to 6.6.y, want to provide a backport for that?

thanks,

greg k-h

