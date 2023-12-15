Return-Path: <stable+bounces-6790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D31814236
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 08:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357B22831DA
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 07:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7A86FA1;
	Fri, 15 Dec 2023 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="emzyONE1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F8101C3
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 07:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B807C433C7;
	Fri, 15 Dec 2023 07:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702624504;
	bh=yc8W7APrmhEaH8yW2IpJ5+zeGOt4Wona7eOL12d6udM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=emzyONE1OOzPHho7QoRX4m076h8SQZQNPnDqR1hPSoKhD0O7mHspHWtUjSvY0cyaB
	 QapWTjLxFRVAOGr5vdWdtAoPfS/yZ/od/SooGu24iiQ07Bjnt0ftlQttE/yoEp4LNR
	 7FzkV5esKLMZjbYkIcGYV++cIpYd+YZjx6L4V/Wc=
Date: Fri, 15 Dec 2023 08:15:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10 0/2] checkpatch: fix repeated word annoyance
Message-ID: <2023121506-cavity-snowstorm-c7a3@gregkh>
References: <20231214181505.2780546-1-cmllamas@google.com>
 <2023121442-cold-scraggly-f19b@gregkh>
 <ZXtLdyHSamRjH94u@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXtLdyHSamRjH94u@google.com>

On Thu, Dec 14, 2023 at 06:37:43PM +0000, Carlos Llamas wrote:
> On Thu, Dec 14, 2023 at 07:23:28PM +0100, Greg KH wrote:
> > On Thu, Dec 14, 2023 at 06:15:02PM +0000, Carlos Llamas wrote:
> > > The checkpatch.pl in v5.10.y still triggers lots of false positives for
> > > REPEATED_WORD warnings, particularly for commit logs. Can we please
> > > backport these two fixes?
> > 
> > Why is older versions of checkpatch being used?  Why not always use the
> > latest version, much like perf is handled?
> > 
> > No new code should be written against older kernels, so who is using
> > this old tool?
> 
> This is a minor annoyance when working directly with the v5.10 stable
> tree and doing e.g ./scripts/checkpatch.pl -g HEAD. I suppose it makes
> sense to always prefer the top-of-tree scripts. However, this could be
> inconvenient for some scenarios were master needs to be pulled
> separately.

It makes more sense to use the newer version of the tool, especially as
you are probably having it review backports of newer patches, which
obviously, should follow the newer checkpatch settings, not the older
ones :)

thanks,

greg k-h

