Return-Path: <stable+bounces-124608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D1A64309
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5DA1883171
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE8221506D;
	Mon, 17 Mar 2025 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OseOk79L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87A18A6B5
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195560; cv=none; b=A1LJfoutx/qzYzBLqpU4CEh3sG8lTk7sxWBMBQ7XrHdN78PejEtjhorrRvOW/s2jBODOWSoVsA/59dd+lmoIht2A1NAqqyfGR1iWWh9cHe7OB+DR5AgEaN3dCwFg0RK+0mZejiTd6VPvg5oTnSAaZrMxondVzivdwRB5gElX3wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195560; c=relaxed/simple;
	bh=MVj9MpSpgPypIeRJgKb5V/qf4sOrX5WYXJuWLwICIF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SV6hlmrmSgAqdopb7uvQbxdjDb/vq0bNWhT/Hdz50F5d2ljWyZZJ1Ojle+ArE/4KTKDNLjzFKuHqMQcppY3P0fw27tpWXMmC+G3KqHayiz247hLW7+C3TA64Ha9OZEcdYqRD/uZyt//fy1T4dd4xlK1JK7QU+WoenTEGp8ndAX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OseOk79L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9DFC4CEEC;
	Mon, 17 Mar 2025 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742195559;
	bh=MVj9MpSpgPypIeRJgKb5V/qf4sOrX5WYXJuWLwICIF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OseOk79LImYASezwORGSRwlFo1HkfJyiB5ctot9oEU3Od9UcX5LEKh6UBYtoQn+QM
	 V26KsBkeOirE1s/9Sfb/x9q1kOcUyPNo3D7DajF6J335aGc1LVZIEx25+x45FXJMB7
	 j3LFVWqWPHNeHtoi5mg9t+KXlASqHww6KL5V+Xhg=
Date: Mon, 17 Mar 2025 08:11:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: mqaio@linux.alibaba.com, mhiramat@kernel.org, stable@vger.kernel.org,
	zhe.he@windriver.com
Subject: Re: [RFC PATCH 5.15/5.10] uprobe: avoid out-of-bounds memory access
 of fetching args
Message-ID: <2025031710-mandarin-upbeat-22ff@gregkh>
References: <20250317065429.490373-1-xiangyu.chen@eng.windriver.com>
 <2025031710-plexiglas-siding-d0e8@gregkh>
 <3fd37132-0162-43a3-9543-f26ecec9a7c0@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fd37132-0162-43a3-9543-f26ecec9a7c0@eng.windriver.com>

On Mon, Mar 17, 2025 at 03:09:50PM +0800, Xiangyu Chen wrote:
> 
> On 3/17/25 14:57, Greg KH wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Mon, Mar 17, 2025 at 02:54:29PM +0800, Xiangyu Chen wrote:
> > > From: Qiao Ma <mqaio@linux.alibaba.com>
> > > 
> > > [ Upstream commit 373b9338c9722a368925d83bc622c596896b328e ]
> Hi Greg,
> > <snip>
> > 
> > Why is this an RFC?  What needs to be done to make it "real" and ready
> > for you to submit it for actual inclusion?
> 
> We try to backport the fix to 5.15/5.10, but some logic functions are
> different, the prepare_uprobe_buffer() in original
> 
> commit is not exists on 5.15/5.10,  we moved the fix to uprobe_dispatcher()
> and uretprobe_dispatcher().
> 
> It has been tested in our local environment, the issue was fixed, but due to
> it different from original commit,
> 
> this might still need to author help to review, so I added a RFC label.

If you want people to do reviews / work / etc, then you explicitly need
to ask for that.  Otherwise we all have no idea what problems you have
with this change, nor what you expect for anyone else to do.

First off, why do you think this needs to be backported here at all?  Do
that research and work first, and figure it out with your own testing
and evaluation before asking others to do any work for you.

good luck!

greg k-h

