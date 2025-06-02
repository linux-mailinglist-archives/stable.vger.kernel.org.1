Return-Path: <stable+bounces-148947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCECACAE13
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD1616FE4F
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 12:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DCF21CC40;
	Mon,  2 Jun 2025 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nDi4TE1R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE44218EA2
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748867221; cv=none; b=CrVk988gnhIpxGRmGja3iTbv1lrc1VpZp7FBg/MEqemmzbcaamRXGnxx1B6EqPSWPOit2GQBa1gBxtH9yfviwJmkBzaXGR4RyyTE8J6AQ1bPVcgwcz9Gb5GOIYFxkPvuQTSIKKnUzbiRDtsLuWoyRidkfLPZsz0TLw7Qxxgg2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748867221; c=relaxed/simple;
	bh=73nVV1uF7cB5053wJyot0kawQ4HC3GQ8ZCe4vsUqRy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qX6G+XBNYOZp3cdZ8gnNfEYG1DGDVpcVfOZcyQivch2qKtKpx61BgjCukZ4uZKEWsZ4ReGZmL+S/lg0CdOzzKu+sc9bi02knGYu9LgRJR4rcC0pfxOUn17274Qud+xUQoWPlJnSW4CjbXNLB87OcPCpDR47hdCCLjUG640GSspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nDi4TE1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB61C4CEF2;
	Mon,  2 Jun 2025 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748867220;
	bh=73nVV1uF7cB5053wJyot0kawQ4HC3GQ8ZCe4vsUqRy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDi4TE1RYEA6dE4irbQaM6UB5Aiv4MG1Q02LIEbTRtxkCOg+iWnz28T20FtASbJeA
	 ieeOYHWOKjg3wUEsyf92Ejs/O2JPrrvUKQg+V7mPXDpj3E2JoB9wy7ydwBLKhjAE1b
	 B0gATDZ+5NAYTwPbawXi+rgMJdz4q+PFGHE+LSLI=
Date: Mon, 2 Jun 2025 14:26:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: Please pick 0c8e9c148e29 and da33e87bd2bf for linux-6.15.y
Message-ID: <2025060228-implant-rupture-481a@gregkh>
References: <1b4c75ab-4e3b-44ff-9737-5d175b95af5b@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b4c75ab-4e3b-44ff-9737-5d175b95af5b@arm.com>

On Mon, Jun 02, 2025 at 01:15:14PM +0100, Robin Murphy wrote:
> Hi Greg, Sasha,
> 
> Please could you pick these commits for linux-6.15.y:
> 
>  0c8e9c148e29 ("iommu: Avoid introducing more races")
>  da33e87bd2bf ("iommu: Handle yet another race around registration")
> 
> which in hindsight should ideally have been merged as fixes during the
> cycle, but for various reasons were queued as 6.16 material at the time.

Now queued up.  It also looks like the last one above should go to older
trees?  If so, can you send a backported version, it would only apply to
6.14.y.

thanks,

greg k-h

