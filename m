Return-Path: <stable+bounces-90069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD5C9BDF28
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 08:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956C61F24777
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 07:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C442B198A29;
	Wed,  6 Nov 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pilsonyu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C766193084;
	Wed,  6 Nov 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730876965; cv=none; b=BjUHFxjisnWmCmOjekLIMgMO/iRExN4y6MDXHIIhk8SQ6JWY2V+wQWMJEZqTAlq0JORYs0q6PE8VSFmADfySk0UyHQoHfNSbtu13nbxv+byFkaaPREOFxvhb5LulXv7nUssRqQoCUyzCR420Zz8fMyuvbVJmzV8qL2nkh3CiBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730876965; c=relaxed/simple;
	bh=BaX33cEw4kB5c/aQBYKrh07u/obGduyi1uiRlTqdf8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkYd2WFtqxRZx27iA9lAZvEW0uTuqZ1tW/JM3fKiRjv+9caSmCadGz2wN2YF/bU+a+biOvxIxnFJjBcS5xrXOPBCXntHoi+XiTh/tQxzpjUh7FKbi7qJTQSBW9UeQ5pRb6y653yEQ8JM0ol03l3txJ083KYURHii2lFDhqJugj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pilsonyu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE6AC4CECD;
	Wed,  6 Nov 2024 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730876965;
	bh=BaX33cEw4kB5c/aQBYKrh07u/obGduyi1uiRlTqdf8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pilsonyubuNvvsHd3BaloyW7Vy/5HRsEZRCJz21BIi6MeEzKwwnAut9O7kZ+clecj
	 2gAX5lyIsXKtPw8tIktdq49Tb+Mqn1v34VoLpPi4dDDjkOuXgZmEHhrIRQYmv0v409
	 lb4TSHAdRcEzhbyARQJWSoUqF5wJLX0VAa/GzxEQ=
Date: Wed, 6 Nov 2024 08:09:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, fw@strlen.de, urezki@gmail.com,
	vbabka@suse.cz, greearb@candelatech.com, kent.overstreet@linux.dev,
	stable@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH 6.11.y 1/2] rcu/kvfree: Add kvfree_rcu_barrier() API
Message-ID: <2024110639-astute-smokiness-ea1d@gregkh>
References: <20241021171003.2907935-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021171003.2907935-1-surenb@google.com>

On Mon, Oct 21, 2024 at 10:10:02AM -0700, Suren Baghdasaryan wrote:
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> 
> From: Uladzislau Rezki <urezki@gmail.com>
> 
> commit 3c5d61ae919cc377c71118ccc76fa6e8518023f8 upstream.
> 
> Add a kvfree_rcu_barrier() function. It waits until all
> in-flight pointers are freed over RCU machinery. It does
> not wait any GP completion and it is within its right to
> return immediately if there are no outstanding pointers.
> 
> This function is useful when there is a need to guarantee
> that a memory is fully freed before destroying memory caches.
> For example, during unloading a kernel module.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/rcutiny.h |   5 ++
>  include/linux/rcutree.h |   1 +
>  kernel/rcu/tree.c       | 109 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 107 insertions(+), 8 deletions(-)

We need a signed-off-by line from you, as you did the backport here,
please fix that up and resend this series.

thanks,

greg k-h

