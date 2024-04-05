Return-Path: <stable+bounces-36078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D057899AA6
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 12:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C14CBB21CF0
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 10:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E3161B6E;
	Fri,  5 Apr 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PoJna78u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78835161902
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312584; cv=none; b=OwgZm0pbbgehBSPYDO4MKqzUBzVS5bqWL5GkVDi4WfzjzEO3F4j+w4c1ngXklhEsHUoNa1BZu/NzLnpV3/zs27UTNa5D5uu7tzmFTgmpHBOgMkSIWdvq18a1Ao/XwgDdTof70/X7YO5wL/WRJLzE9+6YD36YzLKEBfyrNBBXg1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312584; c=relaxed/simple;
	bh=TKSOaRaOOfFgRNHx+D8IhH1KhDx0s5EaZZMEi0lOKgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muVK+j8Hrghnn8xjeKELOZvTsiE7GzjR78OUdG+dmPL8eojw1V7xPoSgjeQzop6q71jWg7TUTzYbNBgG0g7J6UklPdsTn1aRwq8vvqqGZ9Bi1CbrtLmdLYMUQBrX5iMfO9LG1r4pS9uijJeOQIap4jVnaOFukamYm+unHhvw0TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PoJna78u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA8BC433F1;
	Fri,  5 Apr 2024 10:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712312584;
	bh=TKSOaRaOOfFgRNHx+D8IhH1KhDx0s5EaZZMEi0lOKgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PoJna78uVV+HG4UZWMPb160irz0FkdzSbTO/N7h+Rgqs5t/ZQ7GgGEaP/anCq808U
	 Ga9ZQKgzKsP0/BQmeYRHIPD5yCn0i3SUrgPQIPbNmNzWFonwyxl4KGgzPj9R3LJtoK
	 Gog4e93utr21RwtiUtqD6VAVYDhBZF9R6fUBmbYg=
Date: Fri, 5 Apr 2024 12:23:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/bugs: Fix the SRSO mitigation on
 Zen3/4" failed to apply to 6.1-stable tree
Message-ID: <2024040554-commotion-playing-62c3@gregkh>
References: <2024033030-steam-implosion-5c12@gregkh>
 <20240405100930.GAZg_N2ti--cDJCCKk@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405100930.GAZg_N2ti--cDJCCKk@fat_crate.local>

On Fri, Apr 05, 2024 at 12:09:30PM +0200, Borislav Petkov wrote:
> On Sat, Mar 30, 2024 at 10:46:30AM +0100, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> 6.1 is easier, actually. 2 patches as a reply to this message.

Both now queued up, thanks.

greg k-h

