Return-Path: <stable+bounces-19773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D066E8535F5
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 17:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECDA1C22654
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618895F540;
	Tue, 13 Feb 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eiJJ0xBU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BE55FDA1
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841636; cv=none; b=XqvkQcOBA3IRBcG0CubzftXSPznHBZ5eaoA34wnN1pVXCaecLGBxAiRIYQwmcHYbx8gzEZLpPQ+MZnFfdqgYmxqeuKDe0PjorbGpEz0zt2EqqeZRv+lnZBvtE48lVrhEQ0I190tRVvibEIJC5h5R2mrfvtTVVBpjXy2RmjGnIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841636; c=relaxed/simple;
	bh=y4Q4RiDvzl2SQYIlQdSLf6AfrUuqZyiD3TJTZzOT8/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJP8guWBnxTjBHnPTIH9fOAaNtnz+M4wSM8l4Hy2yj7ZiyD9MrhYbvpXy458aSbr7FO6pNw5QhCT7zJY3+BoZiNOkUNLVPmu2bOBx4FNe2J5+SXX09iWUvbo7ZHAPEHINJz08w3LPakpyILlSpcDUgZXsjaHwB7pgi4K8hs+EVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eiJJ0xBU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F83EC43390;
	Tue, 13 Feb 2024 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707841635;
	bh=y4Q4RiDvzl2SQYIlQdSLf6AfrUuqZyiD3TJTZzOT8/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eiJJ0xBUl1/NA7IZsIFu0Wbq/6eXYERmTvLfCboU7tkgzoeJUzx4HPY/cPRqrUj8h
	 cHtK/MpQ6jkfH/ImSNOX0oslqgssAtMCfUjNvk+cIS/hfhhk/F4yP4NthEY5tamvya
	 CYEOOYE0Nfz6G1/77vu89GOD+Qlpb0ne/X3vuWWA=
Date: Tue, 13 Feb 2024 17:27:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/net: limit inline multishot
 retries" failed to apply to 6.6-stable tree
Message-ID: <2024021349-doable-glandular-934b@gregkh>
References: <2024021330-twice-pacify-2be5@gregkh>
 <57ad4fde-f1f4-405b-a1cb-8a1af9471da4@kernel.dk>
 <2024021304-flypaper-oat-7707@gregkh>
 <7181edf5-864d-48e3-98dd-93e4726c16f6@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7181edf5-864d-48e3-98dd-93e4726c16f6@kernel.dk>

On Tue, Feb 13, 2024 at 09:18:43AM -0700, Jens Axboe wrote:
> > This first patch fails to apply to the 6.6.y tree, are you sure you made
> > it against the correct one?  These functions do not look like this to
> > me.
> 
> Sorry my bad, refreshing them for 6.1-stable and I guess I did that
> before I sent them out. Hence the mua used the new copy...
> 
> Here are the ones I have in my local tree, from testing.

Now queued up, but to confirm, 6.1.y did NOT need these, right?

thanks,

greg k-h

