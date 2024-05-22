Return-Path: <stable+bounces-45577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A53048CC3E0
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D67281A95
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFAE24B2A;
	Wed, 22 May 2024 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qYAjHC2n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D926723768;
	Wed, 22 May 2024 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390700; cv=none; b=KEEzTUZeW6BAY4jh45nMhBH5FHjHoogLENLAPPER2Dr0mVn/SwYBG8xag+5PpXtbn7zcv1DHzOt5Y0NsBGkYXzyf+nd9IAaxSe3LR1KzyTO8rojHeFZT/QuZOFO5K2z5qqFn7xfT9A2aZpMNfGVa6HkFb/pVdFaguWYBoCD7y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390700; c=relaxed/simple;
	bh=YAatkQd5KOCKjwiMuA+OejetVgIWxGP0pr3ZlQGJDnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE7gcoX7Mv6jc4ZTI8CgA130NR/IIAFTdtY9CxrzuEx0jkjTk9xmUd6t63arjEhh5eHF361CENN9UNx5M3OH7yyoD6JzT3REn2zAwIV9aVnASWc/vr0JDsKp+4pxc17wht1BCQZlXfszWb7big7cKwkl4lQupXeHcVgc6snLEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qYAjHC2n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B16BC2BBFC;
	Wed, 22 May 2024 15:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716390699;
	bh=YAatkQd5KOCKjwiMuA+OejetVgIWxGP0pr3ZlQGJDnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qYAjHC2nXoMYQ1Ry99raJDCzBZRrHVooMAFTDMpkvAJYggmDNMyDVwq9gMo/nj5Od
	 LvIyGGOW6YcsZXnQTtyRLn3I86XyocrbgGCBEf8dboXvZFqp6+F8lciqfWYV01ovro
	 CRVuFVD0JHXc3wbrle+A88mTkTHyO7YIaoJLZw1s=
Date: Wed, 22 May 2024 17:11:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: CAK2bqVJoT3yy2m0OmTnqH9EAKkj6O1iTk42EyyMtvvxKh6YDKg@mail.gmail.com
Cc: rankincj@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [BUG] Linux 6.8.10 NPE
Message-ID: <2024052222-refutable-magenta-94da@gregkh>
References: <A8DQDS.ZXN0FMYZ3DIM1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A8DQDS.ZXN0FMYZ3DIM1@gmail.com>

On Sun, May 19, 2024 at 01:28:58PM +0200, Paul Grandperrin wrote:
> > I am using vanilla Linux 6.8.10, and I've just noticed this BUG in my
> dmesg log. I have no idea what triggered it, and especially since I
> have not even mounted any NFS filesystems?!
> 
> Hi all,
> I have the exact same bug. I'm using the NixOS kernel but as soon as it was
> updated to 6.8.10 my server has gone in a crash-reboot-loop.
> 
> The server is hosting an NFS deamon and it crashes about 10 seconds after
> the tty login prompt is displayed.
> 
> Dowgrading to 6.8.9 fixes the issue.

Any chance you all can use 'git bisect' to find the offending commit?

thanks,

greg k-h

