Return-Path: <stable+bounces-71324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E101196139F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6172822A7
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C781C6896;
	Tue, 27 Aug 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N0NTtfa+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0664A;
	Tue, 27 Aug 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774796; cv=none; b=AQNugwwhalE5bPSGe8dMq/bu1nyUFClHRagug+vexkarHbqU+ys3KMi92VAsmfjWjlC7Xf1YWwXX4vMTPyNh5c9Il+YbAf5mY/ZgEN/4r5TY2l8VXFZAwuYI6L7MpZqkfh1H5+ho+G1wVFkFEXNET/3pQw4kA7VhZa4tCTZzr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774796; c=relaxed/simple;
	bh=JW7JOo58wN9tCu7+RvlOCcsQ0sT32Uaxjwj6pWPrCv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH4djPJYUiDQVltmMsHKn95O/ARXslE4/3SlJiy5q0RmnkhhoRXby1xSz5yxmu9SVOU0y+Bp0pcOc1iAATiq005iOhrZE0a2Yu72lLy2meXkAz8vDSuj1CtPAKlJjYiwnUmZHLZQ2yqrKZYirkziZ1kyuYwPNJM+vq8yfhEdKNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N0NTtfa+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B701FC581B0;
	Tue, 27 Aug 2024 16:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724774796;
	bh=JW7JOo58wN9tCu7+RvlOCcsQ0sT32Uaxjwj6pWPrCv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0NTtfa+WUEBc65GdCwsVj9wGCVJbF7WVi/aHECav0CN2oQk9fA6P8O0IP+R7fh2o
	 15Hbm8Ci3ZrjgU+WL9HQFZjXK6XBjaWlubYJIO8BXyYIIakKxSGMBybA5zPPdzaqej
	 3197hCHw1Fm1L+B5hVpcJiqwCZiNfFzHCzrjK9xw=
Date: Tue, 27 Aug 2024 18:06:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 110/341] usb: gadget: uvc: cleanup request when not
 in correct state
Message-ID: <2024082701-ivory-antibody-af9d@gregkh>
References: <20240827143843.399359062@linuxfoundation.org>
 <20240827143847.597379131@linuxfoundation.org>
 <Zs3q7KGX_i99-B4_@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs3q7KGX_i99-B4_@pengutronix.de>

On Tue, Aug 27, 2024 at 05:04:12PM +0200, Michael Grzeschik wrote:
> On Tue, Aug 27, 2024 at 04:35:41PM +0200, Greg Kroah-Hartman wrote:
> > 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> Since this change is not actually in Mainline anymore as you reverted it
> immediatly afterwards, it probably make no sense to pick it up.
> 
> I saw this patch and its revert past me the last week while being
> applied on some other stable trees.

I took the revert as well.  That way our scripts don't try to pick it up
again in the future as they would go "hey, here's a patch you missed!"

thanks,

greg k-h

