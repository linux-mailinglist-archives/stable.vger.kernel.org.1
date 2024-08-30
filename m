Return-Path: <stable+bounces-71648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058FA9662A1
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 15:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B766A284336
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B52188A33;
	Fri, 30 Aug 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iLXpcTHo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A583A152170
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023359; cv=none; b=j/HA6FHx3/kMLIeZAtUZPQvekrYd/RYMtircRxVFj4Z41DrQS9JrGU6txyZdZFJ4+aQWqapOfsydDyU7yO6/nwoVJiBoWbQdv0T9uRHUQOxS+sVGIY7Bh6LgsCgVv2ZoAxwdEyvdM+zibw867JyRNeZeOObDEx63rPFWovz5ZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023359; c=relaxed/simple;
	bh=ZUSDvxzsqzzLpYWkMpkcNuz1WOtMR25Rky+6A3mdk6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1ApEaZvzZnOsPQuZSbr4lbeGdADuM2BjHsadKCpKV4wuxASpYp2lzrq4xhugSC288vIwc0ZpJT2p8rKatWRRLlxyBqnaF2cIwQOlfek9WlWFinCGmQoJtsl7xTOAQzPAAapGLM8Jmu9E8hNXk5Ov6ebxg3AwYhuP3EWDnVNKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iLXpcTHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056BFC4CEC2;
	Fri, 30 Aug 2024 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725023359;
	bh=ZUSDvxzsqzzLpYWkMpkcNuz1WOtMR25Rky+6A3mdk6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLXpcTHoMGSSI0bXyvNvYmbz4hKT9r8tFjcunonH66yWcLmLK8IeFIsocUpMKVh3e
	 YFRXqvR3nujgcIyMq1IqU85r8PDxOMYKKeV5XQg+9bLZigRKbO5ETmz07Zzrf35YZP
	 fAqH8Dqu0A+N5yDS6Hvj6ze6ASx5J0DXN6HiasLA=
Date: Fri, 30 Aug 2024 15:09:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 5.10 1/1] ovl: do not fail because of O_NOATIME
Message-ID: <2024083001-obituary-handpick-c531@gregkh>
References: <20240830092806.28880-1-hsimeliere.opensource@witekio.com>
 <20240830092806.28880-2-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830092806.28880-2-hsimeliere.opensource@witekio.com>

On Fri, Aug 30, 2024 at 11:27:45AM +0200, hsimeliere.opensource@witekio.com wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> commit b6650dab404c701d7fe08a108b746542a934da84 upstream.
> 
> In case the file cannot be opened with O_NOATIME because of lack of
> capabilities, then clear O_NOATIME instead of failing.
> 
> Remove WARN_ON(), since it would now trigger if O_NOATIME was cleared.
> Noticed by Amir Goldstein.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  fs/overlayfs/file.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 

Now queued up, thanks.

greg k-h

