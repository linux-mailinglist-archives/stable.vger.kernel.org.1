Return-Path: <stable+bounces-111260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5DBA229CC
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 09:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859E9166B1A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 08:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F77D1A8F71;
	Thu, 30 Jan 2025 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IhmMAeYm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51518FDC5
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738226805; cv=none; b=nljDoq47Iwo9zFfygWRfHuKpl64wbUHAnNSuOdXjFDPMztKsnSfrenzIohWhhoMcr/XRPv+d+qAhzr7u6UliYUCwvja5oqiJoXiBbO0vuo5kZpxs3/eUMr7z+cCvHSE3FGKDYLZvca4MYhYBmyerizeKZYRZF9XoQmze7Uxx+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738226805; c=relaxed/simple;
	bh=i+0pEH8vdZdLgLkMfo0WnFgWkHqPKZZsVB7xLr3PPsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcNuhDVVVdfpwjqHN/VuC1z0YH9itqEdGrZrbXoSgaglnLXyV6dZmj7Jw6mOSzlBhwOhxASWXKBpTGV73Ca+jxM0v+6LaI5iwc2q2pMxemuNbLk3S8jTU2ZWnAnDQtTW7Mzm4kOsNz8SiS/VEdAa57DJQqTnLDlimlR1mtLu9FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IhmMAeYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67900C4CED3;
	Thu, 30 Jan 2025 08:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738226803;
	bh=i+0pEH8vdZdLgLkMfo0WnFgWkHqPKZZsVB7xLr3PPsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhmMAeYmy20LbrET0v6oTOZHs1y3bwj/uH+090zLCVlRiklNgSVzESmWjc1lx2oKJ
	 WSlKDHH7pyHDTE3LUdNODfBZUn+ttmBh5LMS3RzzwrW4m3hd+Oklh1rCby/U7YKGYZ
	 vLej688RHTxM4bMTPel4gq7VFXYLkkJRxaYiwL9U=
Date: Thu, 30 Jan 2025 09:46:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrea Ciprietti <ciprietti@google.com>
Cc: stable@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCH 1/1] blk-cgroup: Fix UAF in blkcg_unpin_online()
Message-ID: <2025013020-carefully-jailbird-640d@gregkh>
References: <20250129163637.3420954-2-ciprietti@google.com>
 <20250129164325.3424666-1-ciprietti@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129164325.3424666-1-ciprietti@google.com>

On Wed, Jan 29, 2025 at 04:43:25PM +0000, Andrea Ciprietti wrote:
> Hi, this is a version of commit 86e6ca55b83c ("blk-cgroup: Fix UAF in
> blkcg_unpin_online()") adapted for porting to the 5.10 LTS tree.
> 
> The patch fixes CVE-2024-56672.
> 
> Changes with respect to the original commit:
>   - blkcg_unpin_online() is implemented in linux/blk-cgroup.h.

This is already in the 5.10.y queue, but NOT in the 5.15.y queue at all.
Can you do this for 5.15.y instead?

thanks,

greg k-h

