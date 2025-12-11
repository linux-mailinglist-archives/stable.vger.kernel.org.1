Return-Path: <stable+bounces-200817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57162CB6CC7
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 18:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46CE8302D5CC
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 17:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D44B31D72E;
	Thu, 11 Dec 2025 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRcfXGFQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58582D3A7B;
	Thu, 11 Dec 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765475371; cv=none; b=XTkij5WWw9O6+aHMvepSy4lLECsTtOKxfBIynkCG3ZQwdQKQXKLPia+GSr8xnBxqBObyUVDvOLD8cDZoB2sYffy03ZoNC8x4H5gc2yfgEVWpbWRKQ7dILACWNgym3aq7B1vY21gGreLrRVtGnxVPyJPzqikz+Lhwk1mKLqhtvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765475371; c=relaxed/simple;
	bh=16v724gC26TYQYKZOE1K5I2if4TmqAE9KRxPn9a9n8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rk4gpJ5XwlOARQeppLyw+E8cwiIc3vDiXzQhE34gHorcBpBzqv9gyUt0NIRDmWRhDvPf3vJnZDQS2pGIGg7qvrlAwhkztxqO2JXeFYlZ5SfSwSAVb+RUtgiFQ7MgkngO3+Pj76MRx6UJcyUXdh490MguOJdWVR2AdzOYtWgmW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRcfXGFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794CFC4CEF7;
	Thu, 11 Dec 2025 17:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765475370;
	bh=16v724gC26TYQYKZOE1K5I2if4TmqAE9KRxPn9a9n8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRcfXGFQVSq3TFbq30lhADW6IDJQfmh5xED7vtoWaUAOoQ0EWHe596dHq1HicLDiM
	 W1bAjM8jodzmrUxtVehTLYMdZwkztGQT0FNsOuj3KkasAkecg7iBWUilAC7nGwUum/
	 inkhptXRKGbdyN518yKst6u9cGBnmW4jN9Xa6jaCjSi2Q6QoZl036SMqF9isFR9Wwk
	 KhdU8YS5Zg6PGrDp86Q7fv4EQyNWEFzThLuefgrNr0BkiwWcw2gTyXEin2aipzw4ZH
	 utsZDNTYUxbZDwzFfTCpSXXtzUmGvOc9/9htON0d2sQyO/bPZj0Xzj39MvWl3+csYU
	 vhrNq9GoIrDzw==
Date: Thu, 11 Dec 2025 17:49:26 +0000
From: Simon Horman <horms@kernel.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, izumi.taku@jp.fujitsu.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fjes: Add missing iounmap in fjes_hw_init()
Message-ID: <aTsEJs8oqSS_QjcN@horms.kernel.org>
References: <20251211073756.101824-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211073756.101824-1-lihaoxiang@isrc.iscas.ac.cn>

On Thu, Dec 11, 2025 at 03:37:56PM +0800, Haoxiang Li wrote:
> In error paths, add fjes_hw_iounmap() to release the
> resource acquired by fjes_hw_iomap(). Add a goto label
> to do so.
> 
> Fixes: 8cdc3f6c5d22 ("fjes: Hardware initialization routine")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
> Changes in v2:
> - Use an idiomatic goto to do the error hanlding.
> - Thanks for pointing out the issues with the patch, Simon!

Likewise thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

