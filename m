Return-Path: <stable+bounces-92983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 006099C86B9
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 11:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CEE282EDD
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4591F80BA;
	Thu, 14 Nov 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLDtWjW+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467C1F80BD;
	Thu, 14 Nov 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578405; cv=none; b=in5ehDZujdhv/sYJTc0ePsZR5bWcOL1t3OBzYXqltvhlQwojilwshEgL3J9NsdSD4/AdUs8ifKV2imSmzTjMvTikqI1/Z21YnPQOkdYQKs0F9elnzb94U3GiXyNsABoS6PrJfEorasm2jfsfisphKSngVoE4neaZ+jnNj6CdoZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578405; c=relaxed/simple;
	bh=p4PwUaQX9xPS7DX7xJqkjYPk43uSlAXQyomQh9aFQJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSOkAMqU0AppBKUsTlQ6sBry4yhDdkyilA09A6/JEC7hZJEQN3z7DS1+5HATrSfi6znF+j5QS5TzsK4jgDzLqVAF4lyAyAf07e3vLa5pgnygxVXkq/jU/MbAfmijnLeSGIemBiphi6xXMipmS4TD7VnSHQGf8NnoDyDfcAPQ2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLDtWjW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13668C4CECD;
	Thu, 14 Nov 2024 10:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731578404;
	bh=p4PwUaQX9xPS7DX7xJqkjYPk43uSlAXQyomQh9aFQJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLDtWjW++p4wrmcNrJ0h+UpBSWEl5s+UuOTwkPsIasZqWJvghZGxdYJTlYUy2TrSg
	 PXQ2iuQYVnR1dko5P0p49A6KzP7+y6kK47dS828XDKlvw884N9qZUVNkGVT23FF1Lp
	 +ERmxokQKo3GGZN5CCctmtNx9mnVRJ9rxVT3V7tAw/m3GPLzoTFUgZ4nAcY5RaPXKC
	 qhHgTvLfACYnlHEttf40q01iewpI08loEFlU4JAA1FE9V+tlQpzeThlXH/SjtdODSC
	 yRPhi5kJMQn3euLAvhxEJMYIp0Rxeiq/eRvt3MCDeRstLUtfM3HD9D8Yy4gZvDvQe7
	 gzuf717LG3Jcw==
Date: Thu, 14 Nov 2024 09:59:59 +0000
From: Simon Horman <horms@kernel.org>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, stable@vger.kernel.org, pabeni@redhat.com,
	pkaligineedi@google.com, shailend@google.com, andrew+netdev@lunn.ch,
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com
Subject: Re: [PATCH net V2] gve: Flow steering trigger reset only for timeout
 error
Message-ID: <20241114095959.GA1062410@kernel.org>
References: <20241113175930.2585680-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113175930.2585680-1-jeroendb@google.com>

On Wed, Nov 13, 2024 at 09:59:30AM -0800, Jeroen de Borst wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> When configuring flow steering rules, the driver is currently going
> through a reset for all errors from the device. Instead, the driver
> should only reset when there's a timeout error from the device.
> 
> Fixes: 57718b60df9b ("gve: Add flow steering adminq commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> v2: Added missing Signed-off-by

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


