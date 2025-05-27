Return-Path: <stable+bounces-146454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291E5AC51D3
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E7D3B9C23
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC32797B4;
	Tue, 27 May 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yoMWs0dS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1EE15624D;
	Tue, 27 May 2025 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358952; cv=none; b=f36GZJuTMdOM4Q5OqtWEcBh9rjIW8YriPdvJUrg0YnQX9SDueMeam64HjD+CQ4l/2nQpkJAX+OY0an/TXpdgFfJekadStP85sqht0iDTKMSGMxjJrmHtngn33Amm88xHKb+TfiGw5ZrU6Yrjyu6K2EAqIW4Kywqa92d3fPdRhq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358952; c=relaxed/simple;
	bh=HnhYiwaFWncjMG+5JQPd02BI9taaq+UPC39LcAOJvRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJjE8tSLp3QUeDPg4JTuxonr0uZWvarZ4/ixiBa/RdKVmOg+0vY9TNDANxkOyPBaEYXCVj2lCf5i+wfvRr1oncchCfDc4YysP/P913PPpWYdYvEJ4F5ijcmLJ8pK+aSZYrsUAv0sToQZ0nRdMyI1v/I6qfC6dl9FN1ZGDqQP4Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yoMWs0dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58266C4CEE9;
	Tue, 27 May 2025 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748358952;
	bh=HnhYiwaFWncjMG+5JQPd02BI9taaq+UPC39LcAOJvRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yoMWs0dSfi6NN+D/4rGdRDhNrULgue+K8Nf5C3ev21jUWmUP0N3h6Z1v9ya+zdPPr
	 AnUwh3AmoIqcELpQqdTJ2yDTL6Lt9dgaJvbiuzhwYEQhdMk6Q3pHNdt33VvEsTFBRL
	 WUiM/q+zPHzQIz4EA2dgWEFAU8WSxjQGvXhejdGM=
Date: Tue, 27 May 2025 17:15:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Series for -Wunterminated-string-initialization in 6.14 and 6.12
Message-ID: <2025052741-storable-wrinkly-a588@gregkh>
References: <20250523205408.GA863786@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523205408.GA863786@ax162>

On Fri, May 23, 2025 at 01:54:08PM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please find attatched backports for 6.14 and 6.12 (which have -Wextra
> enabled by default) to turn off a new warning from -Wextra in GCC 15 and
> Clang 21, -Wunterminated-string-initialization, which is fatal when
> CONFIG_WERROR is enabled. Please let me know if there are any issues or
> questions.

All applied, thanks.

greg k-h

