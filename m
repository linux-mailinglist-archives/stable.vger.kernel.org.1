Return-Path: <stable+bounces-197908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01678C972FA
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 13:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC593A33D4
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236D33093C8;
	Mon,  1 Dec 2025 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl4UMKPI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF582F6913;
	Mon,  1 Dec 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591092; cv=none; b=KhNq6KMzlTaHGqXDh9FlxR5aCleJ8/XNrCyod5zGsbdvEYLcW7mta36dfuxupjfFhyMSVrKclG1LlqoQIwRjhba2qa3wyk/VibiHpJuQQCrJMxGwtykrJ+cDb0hRwTftSCLHqRIzNi4xibTR6BAvZ2RsOnlvq3TvxJpYlj4bD+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591092; c=relaxed/simple;
	bh=r7+DYtqqBfukw9TqiWbqW9JxhoADJ7iu+VRT0HCZDyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtIbxJIwIEt11r9MMAeugbG8K9qlmy3GEJeOOabzuPKhgWh7yGSS2/xIKmytzzvxu4LKxCWCw9xUFvaDu3mSsrr1aYz6jl+NGERvlhInF3li+OUFrghCHHsvA++yLK41xW99V5UKmxCuDzFZf47wLWZSQxGK4nz4SJyj564mtHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl4UMKPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F44C4CEF1;
	Mon,  1 Dec 2025 12:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764591092;
	bh=r7+DYtqqBfukw9TqiWbqW9JxhoADJ7iu+VRT0HCZDyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nl4UMKPIHGWUMlmmF44CiagGEXDQPhbCogdwcvYc+lTpPNGC7kGRqGAk2Z02AM7aK
	 iEkm7d9zV6uS8J1dozJlp1B1V6eMt0K93s+l8pcOz1fxCReuKgeglQMD8+g8aKdxlU
	 pCe0a2ky2e4ZNf2yRlzMhTCx+C9Xcv+yHCZ7G1RUPRntv24lLm7JMIOT6/euamrKZB
	 zMLlOYUm+dMZgpX8ChbDYKy243bEks8xSEekcTeXyrw8pEbr/uYAos39ZKygr0Zh5Y
	 /U+QkssbvlctlcTMSjcw2MUthhoUDAJZor2Hk2QEmnz0CYprhE+XXFRELDxQUdMtSv
	 dRGEbxGbUiYkg==
Date: Mon, 1 Dec 2025 12:11:27 +0000
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tony Nguyen <tony.nguyen@intel.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2] e1000: fix OOB in e1000_tbi_should_accept()
Message-ID: <aS2F70YK_89QrsOL@horms.kernel.org>
References: <20251201034058.263839-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201034058.263839-1-lgs201920130244@gmail.com>

+ Aleksandr

On Mon, Dec 01, 2025 at 11:40:58AM +0800, Guangshuo Li wrote:
> In e1000_tbi_should_accept() we read the last byte of the frame via
> 'data[length - 1]' to evaluate the TBI workaround. If the descriptor-
> reported length is zero or larger than the actual RX buffer size, this
> read goes out of bounds and can hit unrelated slab objects. The issue
> is observed from the NAPI receive path (e1000_clean_rx_irq):

...

> Fixes: 2037110c96d5 ("e1000: move tbi workaround code into helper function")
> Cc: stable@vger.kernel.org
> Suggested-by: Tony Nguyen <tony.nguyen@intel.com>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

> ---
> changelog:
> v2:
> - Keep declarations at the beginning of e1000_tbi_should_accept().
> - Move the last_byte assignment after the length bounds checks (suggested by Tony Nguyen)

I'm not sure that Tony's suggestions warrant a Suggested-by tag.
And perhaps Aleksandr's Reviewed-by tag should have been carried
over from v1: IMHO, I don't think the changes between v1 and v2
materially effect the review. But overall this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

