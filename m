Return-Path: <stable+bounces-94545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F339D50EA
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 17:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F222846FD
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 16:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C87198A3F;
	Thu, 21 Nov 2024 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ2rksye"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03890155CBF
	for <stable@vger.kernel.org>; Thu, 21 Nov 2024 16:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207676; cv=none; b=G1YMURV1Qurv5fy97sSXl0kqnnTXiqxC16AGbOXfyf/j1rzmLmLe1LEGnXEyonB8MnYH7tF7nKvlvkxl0XIGWJuwbObzpufba4kpKTG/SzZn+HpaVJPkEPSsG22Lp/g2gcoIrgh0wHB7n/ZWAgbuiDHNtSuSSMnWq6xGhycfBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207676; c=relaxed/simple;
	bh=tmF2ut/ddMZ0FxcgFr9ov8J1T7FY5MrqmwGmEyfDl7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPl//CwL7ysBbPfoLxY3Ri+RyxUB3+sa5cC1HMBtpenwpC9zXVylDUYOz6hKXTLFWAGNU9IHi51vCZgDtcNefXM3CTs3t8WP8Hc5FXm9yldy6ZiuMd4/przpmzqxtYFJpQ41Z32qUmQd8198RkOn9ME95/UhoghOYeFuZ3vQsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ2rksye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594E8C4CECC;
	Thu, 21 Nov 2024 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207675;
	bh=tmF2ut/ddMZ0FxcgFr9ov8J1T7FY5MrqmwGmEyfDl7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZ2rksyenXi3pD6ndMKqwLXwZcNZviZuh/R5j45xWFJzQiruVR20IYqJNbFFLH+Yv
	 38NjSupCIpXzflx3JumovhPg2UFrPN+DmIr8kOpzglvEnKeliSK5ip8sBWKfGURJ+O
	 oPOzqymZFzAPIQV8oyDDhQcxFtR8rl2bxYOQxzcBGpMzNztnNQag7Pfize/pvpXZKc
	 IR4BUaukTmNLW484A3pT1HMeX2sWDWu8VFFfb1D222Rp9MLaU/qKDZbSIUOlxCEu+n
	 h463oAuZ90DR8FbCibD8jF3zHu0trbQpxE7LM6tokp8IxRAxwLoNXGcDJnALZZSxON
	 99WARlF2sxHNg==
Date: Thu, 21 Nov 2024 11:47:53 -0500
From: Sasha Levin <sashal@kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: linux-stable-rc.git: queue/6.12 VS. linux-6.12.y
Message-ID: <Zz9kOd8XRS6nlh-c@sashalap>
References: <CA+icZUXkiFDgyR8qH4VC3K=zK2vkazr8cgYDT=TymD2F3LD=vQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+icZUXkiFDgyR8qH4VC3K=zK2vkazr8cgYDT=TymD2F3LD=vQ@mail.gmail.com>

On Thu, Nov 21, 2024 at 05:00:52PM +0100, Sedat Dilek wrote:
>Hi Greg and Sasha,
>
>Can you please check the queue/6.12 Git branch?
>
>Looks like it includes queue/6.11 material.

You're right. I'm not sure what changed, but I adjusted the script to
deal better with what we've hit here.

Thanks for the report!

-- 
Thanks,
Sasha

