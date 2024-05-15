Return-Path: <stable+bounces-45151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5627A8C6373
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4E91F22A97
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B260C56458;
	Wed, 15 May 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vwEZetGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A64CB55
	for <stable@vger.kernel.org>; Wed, 15 May 2024 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715764336; cv=none; b=GbVm9Y90Qsf4vMXBPqjZBWcgsUKqSFXVAEVXAnd8ZnOQKsv6Y1Y1Wz1cgiaqhssC4A0t1x3YJ8GhzNlLMY/8qmR0Ep6IvnW69NJEEzmW1o2goR7S9Yftv5Ww29U+MeWuZnggfXtkfZsrUSXLuMZWFRLwQg6yF+h4x+UPyKlnl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715764336; c=relaxed/simple;
	bh=SNDiAI8vW2S6RrWo+TTDB2rHiEsMBcO7AFOQS+KrVoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKy1cIb1VXcutREmcd9zrGaUnPSWoBDzL71LMJHm2JQ2ECxbtts++tw/AwbCk5Xx6N5FfJ6Ir6JqU3Fz0y6zYdPjTD/jAsphJhVMNLW8EmgUdgVROi2D/kId6bZy7hUSpwvzO+jF7VT1GWsbHOe9YoW27gL0HVJ3dY3/77qcZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vwEZetGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD19C4AF08;
	Wed, 15 May 2024 09:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715764336;
	bh=SNDiAI8vW2S6RrWo+TTDB2rHiEsMBcO7AFOQS+KrVoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vwEZetGNxtfhcq4yHJbVRX29o1QJsFkLNVtCiZt84bE27BDnrxNscILwKhOSMj139
	 m2dv3YwQ1VnYc2JTvZZypY/rYnaxl6BI/zw+tkrNjowv30K6IMsjERGETtB9eLIC7N
	 fCL3lmIL+4h0dXlzYUnEMumRo5kPJBntgv5/Ny9k=
Date: Wed, 15 May 2024 11:12:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: James Dutton <james.dutton@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Regression fix e100e: change usleep_range to udelay in PHY mdic
Message-ID: <2024051531-praising-john-b941@gregkh>
References: <CAAMvbhHra1jpjgR69_+91J2zTCayf_mzodD93XKGiLRGHoy2Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhHra1jpjgR69_+91J2zTCayf_mzodD93XKGiLRGHoy2Pw@mail.gmail.com>

On Wed, May 15, 2024 at 09:36:02AM +0100, James Dutton wrote:
> Hi,
> 
> Please can you add this regression fix to kernel 6.9.1.
> Feel free to add a:
> Tested-by: James Courtier-Dutton <james.dutton@gmail.com>
> 
> It has been tested by many others also, as listed in the commit, so
> don't feel the need to add my name if it delays adding it to kernel 6.9.1.
> Without this fix, the network card in my HP laptop does not work.
> 
> Here is the summary with links:
>   - [net] e1000e: change usleep_range to udelay in PHY mdic access
>     https://git.kernel.org/netdev/net/c/387f295cb215

This commit is already in the 6.9 release, how can we add it to 6.9.1?

confused,

greg k-h

