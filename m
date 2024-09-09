Return-Path: <stable+bounces-74054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D07971F03
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820EAB225EA
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9F13CFBB;
	Mon,  9 Sep 2024 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BGd443is"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C88528F;
	Mon,  9 Sep 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899013; cv=none; b=Ed7yAxZTp1JVfFkWn4XB/o02aFwU++d+A5WrqvKlbcaup1Wl1yH8r7DAzjt46hAgF99sLOVux30YbuzYaRzvSjEpR6Uwq16d67CTR9n831PVBPSbbT4cePbOVDeQrcdpzna2kzFjiD8UkAjhe8Os110oYpSua9EDKnJFJ8tqpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899013; c=relaxed/simple;
	bh=WRwiIPHmTeJtjKiM0uEFDyOO1OuvjK+ZW7u4+BlRtL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVUrHhzms+/d8acD9T7lveb7/4d0PcPxYHGSDLTZFMtw/urxnV6AJE1mBSJs/Qb+4/jCCiy0HKbsqCZdAD75lOWPXL3+HPF8aUCrrB2mo/WlK+HT0frbJDjZSFhPLaS+HhXFm+EeHgZMGoDdTqwsnpV0W5xdoZIHWan1uuYD8kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BGd443is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C65C4CEC7;
	Mon,  9 Sep 2024 16:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725899012;
	bh=WRwiIPHmTeJtjKiM0uEFDyOO1OuvjK+ZW7u4+BlRtL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGd443is2ZWEkDiDKn/Cu0D8OJTtiCl8vRfF8REtAROexcxqmZZ/bwuz3AcVcnwwL
	 xU2YvsX7V/xRi9GrYQDmd/Bh2aLGKg4irR00Jt7MUt7GNUxClmt/cMrjwG5R8tson0
	 giyrOqVMWMaN7y4j1lzV3o0Chbxj9d4fXYkVqhQs=
Date: Mon, 9 Sep 2024 18:23:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] soundwire: stream: Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <2024090943-retiree-print-14ba@gregkh>
References: <20240904145228.289891-1-krzysztof.kozlowski@linaro.org>
 <Zt8H530FkqBMiYX+@opensource.cirrus.com>
 <8462d322-a40a-4d6c-99c5-3374d7f3f3a0@linux.intel.com>
 <adb3d03f-0cd2-47a7-9696-bc2e28d0e587@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb3d03f-0cd2-47a7-9696-bc2e28d0e587@linaro.org>

On Mon, Sep 09, 2024 at 06:08:14PM +0200, Krzysztof Kozlowski wrote:
> On 09/09/2024 17:45, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 9/9/24 16:36, Charles Keepax wrote:
> >> On Wed, Sep 04, 2024 at 04:52:28PM +0200, Krzysztof Kozlowski wrote:
> >>> This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
> >>> breaks codecs using non-continuous masks in source and sink ports.  The
> >>> commit missed the point that port numbers are not used as indices for
> >>> iterating over prop.sink_ports or prop.source_ports.
> >>>
> >>> Soundwire core and existing codecs expect that the array passed as
> >>> prop.sink_ports and prop.source_ports is continuous.  The port mask still
> >>> might be non-continuous, but that's unrelated.
> >>>
> >>> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> >>> Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
> >>> Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
> >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>
> >>> ---
> >>
> >> Would be good to merge this as soon as we can, this is causing
> >> soundwire regressions from rc6 onwards.
> > 
> > the revert also needs to happen in -stable. 6.10.8 is broken as well.
> 
> It will happen. You do not need to Cc-stable (and it will not help, will
> not be picked), because this is marked as fix for existing commit.

No, "Fixes:" tags only do not guarantee anything going to stable, you
have to explicitly tag it Cc: stable to do so, as per the documentation.

Yes, we often pick up "Fixes:" only tags, when we have the time, but
again, never guaranteed at all.

thanks,

greg k-h

