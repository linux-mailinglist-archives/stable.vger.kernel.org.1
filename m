Return-Path: <stable+bounces-111097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47984A219BA
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70E8B3A500D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60121990AB;
	Wed, 29 Jan 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="unK5P0yL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C2E1DA4E
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738142177; cv=none; b=d+bJU4pIsktRofLXJZ7D+lpFoovE6J0JjIBMROlqYggH6aAgB1va0SbaTYlv6oAQDn/ytRGpIy+zvo50qyiTEszulgmeLW+SBeHCdZbFjPtJQiCSiizYlW9dG/CGOwv3/Ki0huJBDIP0vb+KyZSSDL385BigMt+7756aTOF9wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738142177; c=relaxed/simple;
	bh=uV+tYCZu0NPCLP+r9ok3upiwQmD/R5DpIksDXa7WUkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaJoxX32GSKdftjSIsA3kAdRRwPXCg63Y7mquRV53v/hzv8Yr0PaAUlbJr7gy6zdqNfsZBLrWY7/IJbaQZvXAeyvQPgktoG8dZ7Q6uICUhYq+YJ7p28pJfoj3KMbKa4ab8xKYNo1RqFsd1lg29j2IsNdyNfAeQmQNAdo7qmpzTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=unK5P0yL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7589C4CED3;
	Wed, 29 Jan 2025 09:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738142176;
	bh=uV+tYCZu0NPCLP+r9ok3upiwQmD/R5DpIksDXa7WUkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unK5P0yLa0BPh1pdmRZhk1GhPTBSvvam3e0CXjWLDDor6uIKcZym+iTklBlORuFnM
	 5yD13FHjOO4Ub4rjBBlk0aqvOmeeAaFmU7Y4yzlAZYm/9RogwBlSxDlw//p1K7FQ04
	 PsInbuaZKZxmdGR7kwVbNg9clet1WOt5ntHiz2cE=
Date: Wed, 29 Jan 2025 10:14:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: stable@vger.kernel.org, bartosz.golaszewski@linaro.org
Subject: Re: [PATCH 6.1.y v2] gpio: xilinx: Convert gpio_lock to raw spinlock
Message-ID: <2025012905-oasis-babied-261b@gregkh>
References: <20250121184148.3378693-1-sean.anderson@linux.dev>
 <20250121193205.3386351-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250121193205.3386351-1-sean.anderson@linux.dev>

On Tue, Jan 21, 2025 at 02:32:06PM -0500, Sean Anderson wrote:
> [ Upstream commit 9860370c2172704b6b4f0075a0c2a29fd84af96a ]

For obvious reasons we can't take patches just for older trees because
if you update to a newer stable/lts version, you will have a regression.
Please submit backports for all relevant versions and then we will be
glad to queue them up.

thanks,

greg k-h

