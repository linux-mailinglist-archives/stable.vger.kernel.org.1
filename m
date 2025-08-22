Return-Path: <stable+bounces-172451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8DBB31CD8
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 16:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0BE1D26341
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5676311595;
	Fri, 22 Aug 2025 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rPmECy62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388B305E0D
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874211; cv=none; b=Q5viE4DXF9K/rHfnzKgo3rha5nuADTbs+02Ge4cMyKvHOevpRZd1KdqyHsveOZghp2+d7imjdM50V+VZHq0+FLxtQ/dSBobmTE2YpMyYkGiYfD15iokOczwGZSDQZWFLXQKI3qDHFwFN5I9gdWpp4pmFupqDJ6fqwPg/8PBkbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874211; c=relaxed/simple;
	bh=BIeSo3KdA2BMS7Zcz8ebGH/h4wYfbO5Wn7hXWRf1k2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz+bhZHG/MiYYRpyEHf2UOapTVtMAX/eWFttKN7LuAZ6S42eXBQ/iAPMgfr1b/ZeVqHyi1urrct53R23Z6ETKdNbQ3fZrx8tTgS/d0R12MF9+li+/QxANENOGGbIGWK2TxC2w+xcxzaE+gyOOvLiHyIRfkssW3Br66xXhHCE85Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rPmECy62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6510C4CEED;
	Fri, 22 Aug 2025 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755874211;
	bh=BIeSo3KdA2BMS7Zcz8ebGH/h4wYfbO5Wn7hXWRf1k2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPmECy62iJMMxromwm3QYOrYUov3fVZdM05cFlhkuElQG+OewQn39z3KiW9MQNob2
	 J/FuuQfCERFoOZGAHkajkhWHuAmcrNd39wQzpdBAmDTMb5NElZMXutS3gYansXOMUs
	 /SWL9kEmx2y/Ze2joQGLUSnCyZQISqfbRmEHtkp4=
Date: Fri, 22 Aug 2025 16:50:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: kuba@kernel.org, martineau@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: pm: check flush doesn't
 reset limits" failed to apply to 5.10-stable tree
Message-ID: <2025082249-strangle-thriving-6bf2@gregkh>
References: <2025082203-populate-sublease-ef51@gregkh>
 <017c0cd3-7391-4d53-9e3e-ebdea5fa26da@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017c0cd3-7391-4d53-9e3e-ebdea5fa26da@kernel.org>

On Fri, Aug 22, 2025 at 04:43:13PM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 22/08/2025 08:05, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.10-stable tree.
> 
> Thank you for the notification!
> 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > From 452690be7de2f91cc0de68cb9e95252875b33503 Mon Sep 17 00:00:00 2001
> > From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
> > Date: Fri, 15 Aug 2025 19:28:21 +0200
> > Subject: [PATCH] selftests: mptcp: pm: check flush doesn't reset limits
> > 
> > This modification is linked to the parent commit where the received
> > ADD_ADDR limit was accidentally reset when the endpoints were flushed.
> > 
> > To validate that, the test is now flushing endpoints after having set
> > new limits, and before checking them.
> > 
> > The 'Fixes' tag here below is the same as the one from the previous
> > commit: this patch here is not fixing anything wrong in the selftests,
> > but it validates the previous fix for an issue introduced by this commit
> > ID.
> 
> The upstream's parent patch has not been queued in v5.10 yet, but I
> already got this FAILED notification for this patch here. I guess some
> conflicts on your side prevent you to send the last batch of fixes for
> v5.10, but they will come at some points. I'm going to send a resolution
> for this backport here, because I have it: I hope that's OK.
> 
> (Worst case if this patch is applied and not the parent one: the
> selftests will complain the parent patch is missing, which would serve
> as a reminder somehow, so that's probably OK :) )

Yes, sorry, I haven't caught up on pending 5.10.y patches yet, thanks
for the backport.

greg k-h

