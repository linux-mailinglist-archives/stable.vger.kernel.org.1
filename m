Return-Path: <stable+bounces-52166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425FB908715
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAF9E282B94
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5B91922C5;
	Fri, 14 Jun 2024 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I3bzg0R3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E519149D
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718356118; cv=none; b=HTTnFlQR2wzYqVeWo22VH7HXxC4lzKlV7mEk3DXgTWwumAzZlYya5riegBYpgtNXy3VcNc/sdJ8dUzkCUGTpMKx0/f4JubJ78VH61GyU8maLHe3VIrbLmWIFnmo8w5KQHzc7u8tWl3BtNnwzzVGG2xrrAXZLdVH2MHwzz1AFOTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718356118; c=relaxed/simple;
	bh=Gb9lP8NM4uThzg3KmHrxCcKBFg/YOAKW4h1FH/oNPDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFt2Ofb7cYz06rrER0k7NMqT1KGJQrXYLx4035gzALAK0wWvlV9TJr9Krnu+LDoHtEDmQ/QI15+/cDVfFtzoTf1sMXB5N6PCJbF1A1Pqo48SglpkZjS67gxg6tk9jBuGyMAnFunlEmLy0RdUbA4VrJfkKMLNlYORN+j8lpL1qVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I3bzg0R3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F2FC2BD10;
	Fri, 14 Jun 2024 09:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718356117;
	bh=Gb9lP8NM4uThzg3KmHrxCcKBFg/YOAKW4h1FH/oNPDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I3bzg0R3hzD6KHghOX7X4c8t8ys6zeRd5EhiSBvy4q9RCFbcNWc/jjwoZ0L+9GegY
	 GdhqHL0Jzrn3FRcnRKqqrLj4y0S4ZZwvT2vxQn2btG7j8DIm6RSCoDopMRhVcomHAY
	 vRgTOmXTszMFtRoRZgiJzx4wK6hSuGFZoqOv7Hdw=
Date: Fri, 14 Jun 2024 11:08:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sam James <sam@gentoo.org>
Cc: leah.rumancik@gmail.com, stable@vger.kernel.org,
	Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 6.6] backport: fix 6.6 backport of changes to fork
Message-ID: <2024061411-jalapeno-avatar-5326@gregkh>
References: <CACzhbgRjDNkpaQOYsUN+v+jn3E2DVxX0Q4WuQWNjfwEx4Fps6g@mail.gmail.com>
 <87zfro3yy5.fsf@gentoo.org>
 <2024061400-squash-yodel-4f49@gregkh>
 <87tthv52ka.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tthv52ka.fsf@gentoo.org>

On Fri, Jun 14, 2024 at 09:52:21AM +0100, Sam James wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Fri, Jun 14, 2024 at 05:55:46AM +0100, Sam James wrote:
> >> Is it worth reverting the original bad backport for now, given it causes
> >> xfstests failures?
> >
> > Sounds like a good idea to me, anyone want to submit the revert so we
> > can queue it up?
> 
> Thanks for the nudge, I wasn't planning on but why not?
> 
> 6.1: https://lore.kernel.org/stable/20240614084038.3133260-1-sam@gentoo.org/T/#u
> 6.6: https://lore.kernel.org/stable/20240614085102.3198934-1-sam@gentoo.org/T/#u
> 
> Hope I've done it right. Cheers.

Looks good, I'll queue them up for the next round of releases after this
one is out, unless someone fixes this up before then.

thanks,

greg k-h

