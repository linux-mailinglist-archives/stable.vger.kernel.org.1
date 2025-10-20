Return-Path: <stable+bounces-188002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C05DBF0170
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 11:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1199B4EFC7A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 09:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856932EC0AE;
	Mon, 20 Oct 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jt6dgGfR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E39F2E4266;
	Mon, 20 Oct 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951228; cv=none; b=pQPmquWBqMgFn04N3BavWY2/GFots+HJ3qWzkJfEtXzH52cD+wVkjkGzyBykZI2PtgXLkuM5ag/PBYd3fixfQ+IdH2npAblSqUpDI9uvhdZzEVqy8baJKypNx2OT2oHtOScIuAuZfZbK/pHsAAxESt2+Uv4ADIK5ORxpWKJJRtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951228; c=relaxed/simple;
	bh=RLZH+QsKfg/Re8p+bgNMr6Kf+QCujFO3Ejh6Wav9t1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7HA2DthQOHbobBS0HVAKFAcCWJCM22SDcg3gZ4RfzVgQqDENMWQKnDef8mWO0n7mLpVIhKND4odV4lSfFGwRxaan0b/WXb36qA25RBJ3xXgeKvfiK+XhInl6N33TzAkhyA25YuanPL69OdmhAinVjL/tkvT04/Bh9HqiJMMhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jt6dgGfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451F4C4CEF9;
	Mon, 20 Oct 2025 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760951225;
	bh=RLZH+QsKfg/Re8p+bgNMr6Kf+QCujFO3Ejh6Wav9t1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jt6dgGfRZdJZj+bYa2ry0ftmLAiiyvP2Wpy+XFGsdr9XQiQF6gHpWdkSsZe3Vnmui
	 97E2q57REGbbngezeasEhg/5Jwbd7aJoBiQTCP72TnkgUPkvNjbSPD+ovKa21zt7DT
	 2hjQNI752Nlebd67uAklpA2pCMxu2DcLfhx+9CJA=
Date: Mon, 20 Oct 2025 11:07:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Adrian Yip <adrian.ytw@gmail.com>
Cc: stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org
Subject: Re: [PATCH 2/4 6.12.y] drm/amd: Check whether secure display TA
 loaded successfully
Message-ID: <2025102024-monetize-morphing-79a9@gregkh>
References: <20251018165653.1939869-1-adrian.ytw@gmail.com>
 <20251018165653.1939869-3-adrian.ytw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018165653.1939869-3-adrian.ytw@gmail.com>

On Sat, Oct 18, 2025 at 11:56:42AM -0500, Adrian Yip wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit c760bcda83571e07b72c10d9da175db5051ed971 upstream
> 
> [Why]
> Not all renoir hardware supports secure display.  If the TA is present
> but the feature isn't supported it will fail to load or send commands.
> This shows ERR messages to the user that make it seems like there is
> a problem.
> 
> [How]
> Check the resp_status of the context to see if there was an error
> before trying to send any secure display commands.
> 
> There were no code conflict when applying to 6.12.y.
> This backport gets rid of below error messages on AMD GPUs (per Shuah
> Khan's machine)
> 
>   kern  :err   :
>   amdgpu 0000:0b:00.0: amdgpu: Secure display: Generic Failure.
>   amdgpu 0000:0b:00.0: amdgpu: SECUREDISPLAY: query securedisplay TA
>     failed. ret 0x0
> 
> Compile test was done.

Also, you added text here in the changelog, which isn't generally good
as we want to keep the changelog text as close as possible, if not
identical, to the original so that it makes it easier to track patches
across branches.

thanks,

greg k-h

