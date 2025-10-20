Return-Path: <stable+bounces-188001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0137BBF0161
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97C4C4EF20D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298E2E8B75;
	Mon, 20 Oct 2025 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i+WF4aDl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800621DF26E;
	Mon, 20 Oct 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951168; cv=none; b=UIC/WbTFBQQ645ZrmUzjlhi3l+p6vWdPctVe+A/5CWBq1e7ByEtKZlGRr41CEjkGs3iTrKI0mDh3rsd/68950OSKO7PSzLWg1geu1RMgE2qq/YTqb5ScIBsm5yl6v8MTtf8mG7S7nRY/t8oKTReA7iRy7JC1ySRmrDn152SU8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951168; c=relaxed/simple;
	bh=TU9uwRSbzzeMweEf2OFcb/1N+bcNjOSsbYNAdVOfxxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMyLGm9hxbaDg74nbFF4zUtfrWvl55N91+PMAIQiNSkHgHOcboTWxYhBBeh3T7OBLgOvzoDcUu4zuB5yd/ajuEZE1tf6gQpx3v6iqgwuQMWVXgdXYpE6Q2YxHo6px7vK/KTm58GxUwnMrukYEBWIzCJ6aupr+nLYy7aVGis8NLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i+WF4aDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A74C4CEF9;
	Mon, 20 Oct 2025 09:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760951166;
	bh=TU9uwRSbzzeMweEf2OFcb/1N+bcNjOSsbYNAdVOfxxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i+WF4aDlFp44dX9XDl3RNLiKDmUV8ETwHqQjoMUjLPbRHZGiQ/6u+LbF73yaqr9V9
	 pfnYEeH83R+Jm7DkJntf+g+/sMwpk2zwTXC9wbhATE3Ap90576n5jSR3IJ5Z+pSGg5
	 dEWTGGTAx0YulUWViS942BI51FeWvg5uoQK+ZAwM=
Date: Mon, 20 Oct 2025 11:06:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Yip <adrian.ytw@gmail.com>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org
Subject: Re: [PATCH 0/4] drm/amd: Check whether secure display TA loaded
 successfully
Message-ID: <2025102014-hummus-handgun-d228@gregkh>
References: <20251018165653.1939869-1-adrian.ytw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018165653.1939869-1-adrian.ytw@gmail.com>

On Sat, Oct 18, 2025 at 11:56:40AM -0500, Adrian Yip wrote:
> Hi everyone,
> 
> This is a patch series of backports from a upstream commit:
> 
>     c760bcda8357 ("drm/amd: Check whether secure display TA loaded successfully")
> 
> to the following stable kernel trees:
>   * 6.17.y
>   * 6.12.y
>   * 6.6.y
>   * 6.1.y
> 
> Each patch applied without conflicts. 
> 
> Compiling tests will be done for patches as I send them in.
> I have not tested backports personally, but Shuah khan has Kindly offered
>   to test them.
> 
> This is my first patch, please do let me know if there are any corrections
>   or criticisms, I will take them to heart.

Meta-comment, do not send a "patch series" that can not all be applied
to the same tree.  When applying a series of patches (1-4 as sent here),
that implies that all 4 go to the same place.  That's not the case here,
so I need to pick out the patches individually some how, and apply patch
1 to one tree, 2 to another, and so on.  It looks a bit odd to apply
patch 4/4 to only one tree, right?

I've picked these apart this time, but next time, just send 4 patches
separately, not as a series, as you can see others do on the stable
list, and all will be fine.

thanks,

greg k-h

