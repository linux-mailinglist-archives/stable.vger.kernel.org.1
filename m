Return-Path: <stable+bounces-111275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B8A22C60
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 12:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A419A3A1EB8
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 11:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F69E1C1F2F;
	Thu, 30 Jan 2025 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jPZENyAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312441C1F07
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738235710; cv=none; b=VjVFI4e0lVjyLnApc1nkOvReyfge7Mvkte8uEfo+/h7Q7j2j/nhQsxuWyY8xzMCp/yZ35/YkBVl3qBh+2GehhvMmzc88aKe4togjmfoYhIWYhftzLPfnnVo6qvIS3+E4bfbu1DKYyiF8UqlxFajbB60IMvVdQwObl454OhwSDJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738235710; c=relaxed/simple;
	bh=2gNalSi2Qz/Xfc80JM9iFyP6AZB1jL6LMGrK7xjXthU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHT5m7dtxwbM8L5BaWX9uYsd5MIxFl7NU/O4rsfzbbt+QevxONS97DyGLMdt/gGE6/ts9jH55mEJiHyO6LXwUJUP3UmPgkSKd/GX/Me4fsFZmRzruVzgK1ZDsvCuyjb9Tk/e4xiIFukw81ZHzH67KmDSPGDCFS+vcsyn/GrOQxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jPZENyAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB28C4CED2;
	Thu, 30 Jan 2025 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738235709;
	bh=2gNalSi2Qz/Xfc80JM9iFyP6AZB1jL6LMGrK7xjXthU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jPZENyAUWUJJafFzBATzWO4H0mHk6QlMOA3J3blTncn4/nUkF7T5ZTIm4mL2IOdUX
	 VViWPQrVRI0HBSO8IwB44xS+/sEiT3J6F+jj7OG1cOOv2HVv8rp7UyZkXiMQbZBwV3
	 r3ZceUBUHtqdGLE8dv++qfD4gDeUFPOwvSfPRL4I=
Date: Thu, 30 Jan 2025 12:15:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrea Ciprietti <ciprietti@google.com>
Cc: stable@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH 1/1] blk-cgroup: Fix UAF in blkcg_unpin_online()
Message-ID: <2025013044-resonant-makeshift-3347@gregkh>
References: <2025013020-carefully-jailbird-640d@gregkh>
 <20250130103812.3955746-1-ciprietti@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130103812.3955746-1-ciprietti@google.com>

On Thu, Jan 30, 2025 at 10:38:12AM +0000, Andrea Ciprietti wrote:
> Hi Greg,
> 
> My apologies, I didn't notice that the patch was already queued for 5.10.y. 
> As for 5.15.y, it should be already merged as commit 8a07350fe070 in the 
> stable repo: 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=8a07350fe070. 
> Same goes for the other LTS trees up to 6.13.y.

Oops, yes, I missed it in 5.15.y already, sorry.

lots of missing in this thread, we all need more coffee...

thanks!

greg k-h

