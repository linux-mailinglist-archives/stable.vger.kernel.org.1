Return-Path: <stable+bounces-125654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D08A6A719
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 14:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E1C169923
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 13:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AEC2135DE;
	Thu, 20 Mar 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nbbBjoUX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A11E5B6A
	for <stable@vger.kernel.org>; Thu, 20 Mar 2025 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477125; cv=none; b=ZUI+RkuajpN/X4M2MYR6d1qIsAuzviqV91D1q3ApR6iZEcvBT9T8m+ffSQWcx2ZoS2ljG9gGrnWwMTcgWhLhRy2F+8TUdVPwlz7YDmvSgEa3jFiw0prqgznnV9PnJdFrwJBbyt72mSsWBwdVjJcNpWZCqYsVGkjQgt7XEFE/uGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477125; c=relaxed/simple;
	bh=LtLZJJvlUUExVcRO0BJKyU07VBUlODPen4MSYt/T16c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+Yaj4JgIcwqmJMUwF0gpzeRlpygHeLPBaMAAYMiiAWwJNrqUK6sY8anmvrETYgztOJtE1uQqK6zL+pXM3u3gl6yuVMQ8o2KViG+pb3o1xeRhzza+sVuebQLJCo6Mu1otsw3EKSX6uxRgu+1B6n6sYjLDgW8b82G11fQWMR/CvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nbbBjoUX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE54C4CEE3;
	Thu, 20 Mar 2025 13:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742477125;
	bh=LtLZJJvlUUExVcRO0BJKyU07VBUlODPen4MSYt/T16c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbbBjoUX92sll+y6/1ihlrsDGKO+T8yMHYKx27DrcVKSsvdvr/4rknBPl/hMYI67i
	 rumtwiwR9lH65PUwaJI+ZCVZG7rD8EyURowF/Bt2bocve/KabdCPKYMpvgA5zDcWxM
	 QQ0wna3gsHBineJOFdp0YtlWWD2YM06+o4PpMBo4=
Date: Thu, 20 Mar 2025 06:24:05 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: 6.1 io_uring mmap backport
Message-ID: <2025032059-bagel-hardened-0698@gregkh>
References: <9a29cdcc-c470-400a-a98c-8262a5210763@kernel.dk>
 <e83f6e92-4beb-4477-ab02-ceed052d839c@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e83f6e92-4beb-4477-ab02-ceed052d839c@kernel.dk>

On Thu, Mar 20, 2025 at 07:04:43AM -0600, Jens Axboe wrote:
> On 3/15/25 6:59 AM, Jens Axboe wrote:
> > Hi,
> > 
> > I prepared this series about 6 months ago, but never got around to
> > sending it in. In mainline, we got rid of remap_pfn_range() on the
> > io_uring side, and this just backports it to 6.1-stable as well.
> > This eliminates issues with fragmented memory, and hence it'd
> > be nice to have it in 6.1 stable as well.
> 
> Just in case 6.1 runs into the same missing include issue as 6.6-stable,
> here's a replacement patch 4 for that series as well that adds the
> include.

Now replaced, thanks!

