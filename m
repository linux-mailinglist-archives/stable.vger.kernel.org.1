Return-Path: <stable+bounces-77884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A30E598801E
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 10:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FCD1C226D1
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622B176ABB;
	Fri, 27 Sep 2024 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z6+cIQz2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0413D638;
	Fri, 27 Sep 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727424927; cv=none; b=oqvtpXYV9slT3kssnCJhfosmpJC+ilfIESDXA1zd5VUf/7mQdQzqD/oC6/QB7i641LxmxsNQQbd0rAPCtiAPpDSxZ1ikJVRMvoDCaR95Ps5dwQPy5Vvcck/OhBOiLwkJ+fs3ODLtFFHLhVFd7XubfUpdy1jxxgRs9EjQMM3PpgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727424927; c=relaxed/simple;
	bh=VtmV+oRbi/ADW8lOcIDBwsaCaWYRi2Z97N7wphML/RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfEg+wEctZ5aqD6ZEvNxpIOwxm5ForI39dtC+9LqGU9P5GreMOEneaReqNtiA7+TfeA+OtO9329KmS4BjXDv73qW2cE5YKqfkS4Alc9FAGtCwgMuw6DJjGy3gmuuXVS3nFsEX1HJyO3+zKwLoNheBddkE5Q9g8rk9k83DxqpsD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z6+cIQz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC77AC4CEC4;
	Fri, 27 Sep 2024 08:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727424927;
	bh=VtmV+oRbi/ADW8lOcIDBwsaCaWYRi2Z97N7wphML/RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z6+cIQz2DFL9ntYFFBDgGsIM1waL7LgMUQjXN7pl0S1+aCKj80nbRx745cFdR8y1B
	 MPO6KaocL4FkSnlcad4Erb1P5RkoiaTaBXfLYB/w/A50BsRmLljhWPciKydZJlH0eA
	 Yd22okfvpmvcCYlvIB0Az5x1uXFY1WGCI/5MFgmA=
Date: Fri, 27 Sep 2024 10:15:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y 0/3] Backport of "mptcp: pm: Fix uaf in
 __timer_delete_sync"
Message-ID: <2024092714-startling-plausibly-3ddc@gregkh>
References: <2024091330-reps-craftsman-ab67@gregkh>
 <20240917072607.799536-5-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917072607.799536-5-matttbe@kernel.org>

On Tue, Sep 17, 2024 at 09:26:08AM +0200, Matthieu Baerts (NGI0) wrote:
> To ease the inclusion of commit b4cd80b03389 ("mptcp: pm: Fix uaf in 
> __timer_delete_sync"), commit d88c476f4a7d ("mptcp: export 
> lookup_anno_list_by_saddr") and commit d58300c3185b ("mptcp: validate 
> 'id' when stopping the ADD_ADDR retransmit timer") look safe to be 
> backported as well, even if there was one small conflict, but easy to 
> resolve. The first one is a refactoring, while the second one is a fix 
> that is helping to prevent the new issues being fixed here.
> 
> Davide Caratti (1):
>   mptcp: validate 'id' when stopping the ADD_ADDR retransmit timer
> 
> Edward Adam Davis (1):
>   mptcp: pm: Fix uaf in __timer_delete_sync
> 
> Geliang Tang (1):
>   mptcp: export lookup_anno_list_by_saddr
> 
>  net/mptcp/options.c    |  2 +-
>  net/mptcp/pm_netlink.c | 27 ++++++++++++++++-----------
>  net/mptcp/protocol.h   |  5 ++++-
>  3 files changed, 21 insertions(+), 13 deletions(-)
> 
> -- 
> 2.45.2
> 
> 

ALl now queued up, thanks!

greg k-h

