Return-Path: <stable+bounces-46040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AEE8CE139
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 08:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484F82823C0
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 06:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E3F487BF;
	Fri, 24 May 2024 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KRPuDHBw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC33749C;
	Fri, 24 May 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533814; cv=none; b=jB7ItCyUCjbPrgrB1Flg7KYuSJa2KoA4WTEVtreFDD90IDqCY4Dps82+wrmMgpb9JVw+rabtF4Lu6YSvdP69Qe2FOsqea90HfzNfSnwD7DFZlE/dmVoifGyjytCpOY3fP/GxHXxqMdfSfpaM3wSkYR+ZWdxAzL3owcOv9T+ARhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533814; c=relaxed/simple;
	bh=5z848Ls1pEd41iTJdKJt2BFrLD45xDJ13Tui+Tq0r0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6WctktF+c4n3uUaMdU4RgkymdJilTNEWI+RU5yWRIGGsJBZjM7T0UZh07hGZ8LNk+RbMbZv33jAW4BXyMpiFeUVAkaV8HAj2wuWXfSrPXiZJ8J2cB5nBixPbTG8tTt9bzVaSvSCwByM8ininIVWy+MpBI+OL43Ffm+bYI/tssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KRPuDHBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEEBC2BBFC;
	Fri, 24 May 2024 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716533813;
	bh=5z848Ls1pEd41iTJdKJt2BFrLD45xDJ13Tui+Tq0r0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRPuDHBwXigech8eZoaw93f16KRu1OHf+cB4uIOJ1B3SvBkaiNOZmbIisGTuo0MLq
	 7mMpgfHwJpB745Jxx/MVYh9B6nmSi1GZp02xEA2JCu6b5FobVt2bz6WpY+btNIhId4
	 2/hMIGR/PuoLldzFTn+w877uMEXmsElUizwRDLrc=
Date: Fri, 24 May 2024 08:56:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kobject_uevent: Fix OOB access within zap_modalias_env()
Message-ID: <2024052458-unleash-atom-489b@gregkh>
References: <1716524403-5415-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024052418-casket-partition-c143@gregkh>
 <74465bf5-ca18-45f8-a881-e95561c59a02@quicinc.com>
 <2024052438-hesitate-chevron-dbd7@gregkh>
 <5acce173-0224-4a05-ae88-3eb1833fcb39@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5acce173-0224-4a05-ae88-3eb1833fcb39@quicinc.com>

On Fri, May 24, 2024 at 01:34:49PM +0800, quic_zijuhu wrote:
> On 5/24/2024 1:21 PM, Greg KH wrote:
> > On Fri, May 24, 2024 at 01:15:01PM +0800, quic_zijuhu wrote:
> >> On 5/24/2024 12:33 PM, Greg KH wrote:
> >>> On Fri, May 24, 2024 at 12:20:03PM +0800, Zijun Hu wrote:
> >>>> zap_modalias_env() wrongly calculates size of memory block
> >>>> to move, so maybe cause OOB memory access issue, fixed by
> >>>> correcting size to memmove.
> >>>
> >>> "maybe" or "does"?  That's a big difference :)
> >>>
> >> i found this issue by reading code instead of really meeting this issue.
> >> this issue should be prone to happen if there are more than 1 other
> >> environment vars.
> > 
> > But does it?  Given that we have loads of memory checkers, and I haven't
> > ever seen any report of any overrun, it would be nice to be sure.
> > 
> yes. if @env includes env vairable MODALIAS and  more than one other env
> vairables. then (env->buflen - len) must be greater that actual size of
> "target block" shown previously, so the OOB issue must happen.

Then why are none of the tools that we have for catching out-of-bound
issues triggered here?  Are the tools broken or is this really just not
ever happening?  It would be good to figure that out...

thanks,

greg k-h

