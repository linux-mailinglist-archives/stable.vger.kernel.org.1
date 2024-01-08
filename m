Return-Path: <stable+bounces-10334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE4827692
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 18:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578731C21775
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816415576A;
	Mon,  8 Jan 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KBY1/4jy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4858654750
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 17:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD72C433C7;
	Mon,  8 Jan 2024 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704735749;
	bh=cPvLCOg7OHZ7m+2KYf5Bs7zV+MCJg8JewufEcFeXlU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KBY1/4jyv4EWi8NUPDa1xS5xPR6bybAzbmPHl27ZBAD5sG5FnBcrYILYBPi3nisDs
	 oKw6pahDF7vUEXCtaT2jQJrN6qWDiUuC1iAdYq2EnAJoerLLS2R8NrMJgqHa8csthM
	 ZcZ2I+vRd0uWHl6lziau/3aKrNMCFUvM3kc8s5Gw=
Date: Mon, 8 Jan 2024 18:42:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rakesh Pillai <pillair@codeaurora.org>,
	Yongqin Liu <yongqin.liu@linaro.org>,
	Stable <stable@vger.kernel.org>
Subject: Re: [PATCH for-5.4.y 0/4] db845c(sdm845) ath10k fixes
Message-ID: <2024010811-unfocused-backlight-d8a1@gregkh>
References: <20240108153737.3538218-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108153737.3538218-1-amit.pundir@linaro.org>

On Mon, Jan 08, 2024 at 09:07:33PM +0530, Amit Pundir wrote:
> Hi,
> 
> v5.4.y commit 3cf391e4174a ("wifi: ath10k: Don't touch the CE
> interrupt registers after power up"), which is commit 170c75d43a77
> upstream, unleashed multiple DB845c(sdm845) regressions ranging
> from random RCU stalls to UFS crashes as also reported here
> https://lore.kernel.org/lkml/20230630151842.1.If764ede23c4e09a43a842771c2ddf99608f25f8e@changeid/
> 
> Taking a cue from the commit message of 170c75d43a77, I tried
> backporting upstream commit d66d24ac300c ("ath10k: Keep track of
> which interrupts fired, don't poll them") and other relevant fixes
> and that seem to have done the trick.
> 
> We no longer see any of the above reported regressions with the
> following patchset. This upstream patchset is just an educated
> guess and there may be one or more fixes in this series which are
> not needed at all but I have not tested them individually and
> marked all of them as Stable-dep-of: 170c75d43a77 ("ath10k: Don't
> touch the CE interrupt registers after power up") instead.

All now queued up, thanks.

greg k-h

