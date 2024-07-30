Return-Path: <stable+bounces-62729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41E940E4C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270781F24448
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44324196DA4;
	Tue, 30 Jul 2024 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="orh6NyBo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF74196C9C;
	Tue, 30 Jul 2024 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333110; cv=none; b=jGICuiy7/H1Sgw2SzbdqSIxyyXs5h4WGdlD2Q2fovjsGZEqRX3mGjtn7O/J5MuBoEAdeRYD/ZGdODOB0rih66pTCKlh2YinjWGAoe6bneCTi0bn2z5p1A+SduyRa0efiTdX+FjQz/YjaFBUVw7oNXDgcj9/MGS9QDvfJuRt1cTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333110; c=relaxed/simple;
	bh=SnF19pvKLoYPy4IqzuGyrn7K0fDIxfITLHSn4a9BnXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXDJ94EGmr+ntI14Mrhnx5GYAnxj/jrBtzX4AM4i4jwWhVrJy8acFP6h9vnfHT4Tmmq7RDaA+O0LOPZBb5VATyXX29fL01LjditMhRIlF/0+F2HsfOEiaklFg0HiurgI+lwVNpqinK1P3SIBH67b3edjWkTpVZT/o56KXb8+7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=orh6NyBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F764C32782;
	Tue, 30 Jul 2024 09:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722333109;
	bh=SnF19pvKLoYPy4IqzuGyrn7K0fDIxfITLHSn4a9BnXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orh6NyBoG63k+4jodAp1LEDHkhwn3e9eWpbjp6E5jL5d2DcSnn78qdlVjPec6KPic
	 7jM/UAaHpqpp5gWkTQvQu6a+/ZZ1HR5CploH784OgIFmh4BhSSc48eGGt4j2aMieDm
	 pnPEG+PSer/sLC+ONGUlcdmhemFwYjQCG8SYE9QE=
Date: Tue, 30 Jul 2024 11:51:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wujing <realwujing@qq.com>
Cc: dongml2@chinatelecom.cn, linux-kernel@vger.kernel.org,
	menglong8.dong@gmail.com, mingo@redhat.com, peterz@infradead.org,
	stable@vger.kernel.org, yuanql9@chinatelecom.cn
Subject: Re: Re: [PATCH] sched/fair: Correct CPU selection from isolated
 domain
Message-ID: <2024073011-operating-pointless-7ab9@gregkh>
References: <2024073032-ferret-obtrusive-3ce4@gregkh>
 <tencent_02C238CCB4CAA1D0C58AF9A89E8263AE740A@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_02C238CCB4CAA1D0C58AF9A89E8263AE740A@qq.com>

On Tue, Jul 30, 2024 at 05:40:17PM +0800, wujing wrote:
> > What "current patch"?
> >
> > confused,
> >
> > greg k-h
> 
> The current patch is in my first email.

What message exactly?  I don't see any such message on the stable list.

> Please ignore the previous two emails.
> The "current patch" mentioned in the earlier emails refers to the upstream
> status, but the latest upstream patch can no longer be applied to linux-4.19.y.

Again, please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h

