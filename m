Return-Path: <stable+bounces-74135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80090972B4A
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307C1283780
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877AE181328;
	Tue, 10 Sep 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tujWkzjw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4725A17F4F1
	for <stable@vger.kernel.org>; Tue, 10 Sep 2024 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725954982; cv=none; b=sM17zU2llT7JiCJOjqaFXsRbhIaOXCRNkkeG6u9e+DXCFCyzft9yd2vvQkjUiFF4CXGUJOgdeAVmn2y4CeEmwfqEaTU/s03Kq91ivlrCK1m980ZrysZZrT9DGDjCiiwMEd1WQAkIGnIZO+ZjB0/z/5WNLq1lA7X/fDtOZAoNXYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725954982; c=relaxed/simple;
	bh=9unrHopCJoDYZE4J/ko0b9PoAqFDqVWGTQwpkuMcF8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifA8/z6oRFYP5BU+PTguAf5YFGZ2yT0fStSkuRtjhdbFGf2AINgPYfo/OHFDjWQNofAThiHfLRpbhD1MP+nIquuqOZ/Wq77jNIlR99bX7QfyQWA+D9oMCFvWK6oLLRn8Xadz/D9nxUsacVlCU+4LHFunhcN3slgMA3S9tP9K+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tujWkzjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72519C4CEC3;
	Tue, 10 Sep 2024 07:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725954981;
	bh=9unrHopCJoDYZE4J/ko0b9PoAqFDqVWGTQwpkuMcF8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tujWkzjwQtj0K4IW8gA56V1EK1FrELk/S9zPuF/EapTQQn3Ii4P0NAIc9ecSjFBLy
	 XOWxMNTkap3F2ZfMDGv3iKvr1iTP6Wfq1wTOEBeUDx7583qB1qafwb4OnNlOtwbVXP
	 o1Q5yJD2TT9j7Duwo3G84dEf3W/wYLbyZCijKnQc=
Date: Tue, 10 Sep 2024 09:56:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tomas Krcka <tomas.krcka@gmail.com>
Cc: stable@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tomas Krcka <krckatom@amazon.de>
Subject: Re: [PATCH 5.10.y v2] memcg: protect concurrent access to
 mem_cgroup_idr
Message-ID: <2024091011-lavender-snowy-4e5d@gregkh>
References: <2024081218-demote-shakily-f31c@gregkh>
 <20240909145557.78179-1-krckatom@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909145557.78179-1-krckatom@amazon.de>

On Mon, Sep 09, 2024 at 02:55:57PM +0000, Tomas Krcka wrote:
> From: Shakeel Butt <shakeel.butt@linux.dev>
> 
> commit 9972605a238339b85bd16b084eed5f18414d22db upstream.
> 

Thanks, all now queued up.

greg k-h

