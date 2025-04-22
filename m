Return-Path: <stable+bounces-135153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7E2A97252
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 18:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0C1400771
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5061A314F;
	Tue, 22 Apr 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y3MO6bv7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9F828E608
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338543; cv=none; b=TqGHX1vhA/CAHN8fXMPHBk8wybDJ9/VIUCnvQWAZpDw9khzGs7uWZf6u9waPHH9MGMrtgByWcMQhdBEhfY9FG9NPQXuQ2gMqNVIDifrGflydTucLcPoxk7ACwAL22RLsWtqLwO9NXEORHm6rHZUGFcOsxHjUZorpF+x/xgpiy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338543; c=relaxed/simple;
	bh=x7p3DyVTRIdaE9Ar+9bECToshlmw84RzlP5RNLORr/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+1J3BG56LZjmzNOE0osM9P0xrDN5JOAIKkYnvhn4PfQwMDru1iJ21OCiv3FkVSOFeijR5YwWvYPjFFzWtdEquPZtAp9E/DN39l60jYHdXdn2Dwi+dluDKYUcHR+7+4odncobLDyue7FdnW7H2ojJ7lHNrO0D9gSlMRStKtJ3qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y3MO6bv7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC867C4CEE9;
	Tue, 22 Apr 2025 16:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745338543;
	bh=x7p3DyVTRIdaE9Ar+9bECToshlmw84RzlP5RNLORr/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y3MO6bv7PnBtkJg3sWeSx7arAW/MlP0adBJGHQcBnr3eqD24ggTjNJy6OJZ36biWp
	 BBk2j13ZMcuOUHL1+ibqGdH/G7VS+ov0vSNL4FblUrPpjKNkQNaenRSvPr2C0bqbpK
	 7yZ9M9dunVhC/2fuaqXFBfG3KhkXD1iYmm0lULFU=
Date: Tue, 22 Apr 2025 18:15:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org, peter.ujfalusi@ti.com, vkoul@kernel.org,
	Kunwu Chan <chentao@kylinos.cn>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3/3 v5.4.y] dmaengine: ti: edma: Add some null pointer
 checks to the edma_probe
Message-ID: <2025042204-scrambler-dropkick-e453@gregkh>
References: <2025042230-equation-mule-2f3d@gregkh>
 <20250422151709.26646-1-hgohil@mvista.com>
 <20250422151709.26646-2-hgohil@mvista.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422151709.26646-2-hgohil@mvista.com>

On Tue, Apr 22, 2025 at 03:17:09PM +0000, Hardik Gohil wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> [ Upstream commit 6e2276203ac9ff10fc76917ec9813c660f627369 ]
> 
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Link: https://lore.kernel.org/r/20240118031929.192192-1-chentao@kylinos.cn
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sasha did not sign off on the original commit here.

And you didn't either.  Please read the documentation for what this
means, and what you are doing when you add it.

thanks,

greg k-h

