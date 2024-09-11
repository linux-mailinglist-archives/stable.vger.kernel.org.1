Return-Path: <stable+bounces-75804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE375974DC2
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 11:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D96B24BDE
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E84A15445B;
	Wed, 11 Sep 2024 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZPoOROt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E833086;
	Wed, 11 Sep 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045194; cv=none; b=n/I7Mi0cQzz8F7VW/wGJD1X6IPRN4xLwqeX/hrjnEy4qF7qJPgdrvvnTAyuHA8JvPQV1wn8mwGYTQkPuqV4XblJNPT+CwgC59PM9mZY3Mvlj3zebMwcKgrdxeysW2jQ8x5/oVf4YHv4hxVUItcuv05hp4PoPv9AN53yGIZMOcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045194; c=relaxed/simple;
	bh=ZNG517+nfdpR6QYSXvEOMvJ07+81ZOmK48XOp3AZ8Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avWVBYch0Egn9AdPO7wp3vcWhrcwxMGwcvGX6fLCTTxvyyAHSapeqXzfdl6G4rDZOJ/UxVfGgeiivr2qB1Et9XghgZ1VaKGE3xx/SStluv5vQFKlU+j2gzcmPBeXsRKD7E7UVRNOkcvGIhV5Pnguzr4fzop5UVbqRlxaOeuqY8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZPoOROt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BC7C4CEC5;
	Wed, 11 Sep 2024 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726045193;
	bh=ZNG517+nfdpR6QYSXvEOMvJ07+81ZOmK48XOp3AZ8Os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZPoOROteQrOXvdwCLc+n3gZvpAyGRstUFzITbRWxvj839HkVdSiUoRoxq4l3/0jV
	 9aW14tpSMVwlk/Fc4UUGxjN1ZbwZB3R6P2VgqYGG0ZeWI+OoV064fQ+GwRypWl9e12
	 K0kE22s/Hx43Iz/4JmW1WRG8QGJwDEeb7/e1UX68/DEZWbnQy5HCadsGPaHfaORkuz
	 KONYPLzfc83UT9InG0s1PHSBTdIlYOgmWw9rB1bmVN+QO9lGhZTidj9SDRbDysq92l
	 /f/FUkmYi8E55BQ40aCqGbQTTY9XOiHq+26ZdEKsk8kJL18Stt+XogGpfSJ7TM+qo+
	 ujjJ1UFeBfYbg==
Date: Wed, 11 Sep 2024 14:29:49 +0530
From: Vinod Koul <vkoul@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] soundwire: stream: Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <ZuFcBcJztAgicjNt@vaman>
References: <20240909164746.136629-1-krzysztof.kozlowski@linaro.org>
 <568137f5-4e4f-4df7-8054-011977077098@linux.intel.com>
 <a7a4bb04-de90-4637-b9e4-81c3138347d3@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7a4bb04-de90-4637-b9e4-81c3138347d3@linux.intel.com>

On 10-09-24, 16:49, Péter Ujfalusi wrote:
> 
> 
> On 10/09/2024 16:05, Péter Ujfalusi wrote:
> > 
> > 
> > On 09/09/2024 19:47, Krzysztof Kozlowski wrote:
> >> This reverts commit ab8d66d132bc8f1992d3eb6cab8d32dda6733c84 because it
> >> breaks codecs using non-continuous masks in source and sink ports.  The
> >> commit missed the point that port numbers are not used as indices for
> >> iterating over prop.sink_ports or prop.source_ports.
> >>
> >> Soundwire core and existing codecs expect that the array passed as
> >> prop.sink_ports and prop.source_ports is continuous.  The port mask still
> >> might be non-continuous, but that's unrelated.
> >>
> >> Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> >> Closes: https://lore.kernel.org/all/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/
> >> Fixes: ab8d66d132bc ("soundwire: stream: fix programming slave ports for non-continous port maps")
> >> Acked-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> >> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > Tested-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> 
> Vinod: can you pick this patch for 6.11 if there is still time since
> upstream is also broken since 6.11-rc6

Done, should be sent to Linus tomorrow...

-- 
~Vinod

