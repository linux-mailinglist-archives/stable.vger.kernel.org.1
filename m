Return-Path: <stable+bounces-23864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A4868BBA
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B221F26EBB
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9903134CD5;
	Tue, 27 Feb 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dexp+i3H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C704135A5A
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024949; cv=none; b=kgkcHx736pOz+zEearTEx13KjCuUC30U/kqNAsXKbqjtqjJ1QPQrsKJ4XXFi8tZ4L3+5+NOOwNzcsw0V/7KPlauGO7DCpceCVE9A+BHuAJ0ci2fRJuBDS2urxST0O8ivfhhDBBT74Nb9DE5AFOgqzBqpGorApx1kp1BVqXxGpvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024949; c=relaxed/simple;
	bh=tpqPKhQvqUP3+B3s8eFWcCyVdq9Hh5IqcMFhrBril+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd2rUSi4cfrhs0MafViEsvO3gP7ebZzOsZazVc3YMw4bXqI8p/3wSTj2jL6K60/CGzguzIbpNlKO9EKkf6ErRpwql4HqgMK1DH5hJNyZA4CS87ngEE/rkFuHi5nUAdm4ugTgQcE1AgMiG9OA6qgZL8vS6aa8R0OnvXb02zpn3wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dexp+i3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878E9C43390;
	Tue, 27 Feb 2024 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024949;
	bh=tpqPKhQvqUP3+B3s8eFWcCyVdq9Hh5IqcMFhrBril+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dexp+i3HyJJT9sDo5jIosRxEUZe9vfIHPgLtX7tTmX9OPdfS6kqHdYmB3Z8Rer7MN
	 dz29ETr9MwpVxARX8f2CYj4fr7v1HCo/UvGfsFoPYDCFfMT5c4v+e32R5Js2ZEAj/1
	 9yp/oH15wljrZheM9XdFe3+pzsSBlDd6X5uECY+4=
Date: Tue, 27 Feb 2024 10:09:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alyssa Milburn <alyssa.milburn@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 6.1.y 0/6] Delay VERW - 6.1.y backport
Message-ID: <2024022716-undiluted-donor-17cb@gregkh>
References: <20240226-delay-verw-backport-6-1-y-v1-0-b3a2c5b9b0cb@linux.intel.com>
 <7f75bfa1-03a1-4802-bf5d-3d7dfff281c2@kernel.org>
 <20240227085638.plb5gvunrjqgj7yp@desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227085638.plb5gvunrjqgj7yp@desk>

On Tue, Feb 27, 2024 at 12:56:38AM -0800, Pawan Gupta wrote:
> On Tue, Feb 27, 2024 at 09:21:33AM +0100, Jiri Slaby wrote:
> > On 27. 02. 24, 9:00, Pawan Gupta wrote:
> > > This is the backport of recently upstreamed series that moves VERW
> > > execution to a later point in exit-to-user path. This is needed because
> > > in some cases it may be possible for data accessed after VERW executions
> > > may end into MDS affected CPU buffers. Moving VERW closer to ring
> > > transition reduces the attack surface.
> > > 
> > > Patch 1/6 includes a minor fix that is queued for upstream:
> > > https://lore.kernel.org/lkml/170899674562.398.6398007479766564897.tip-bot2@tip-bot2/
> > 
> > Ah, you note it here.
> > 
> > But you should include this patch on its own instead of merging it to 1/6.
> 
> Thats exactly what I would have done ideally, but the backports to
> stable kernels < 6.6 wont work without this patch. And this patch is
> going to take some time before it can be merged upstream.

It's in the tip-urgent branch, doesn't that mean it will go to Linus
this week?  If it's in linux-next, and you _KNOW_ it will go to Linus
this week, and the git id is stable, then we can consider the
application of it to the stable tree now.

But if it's not working for anyone without this change (i.e. in Linus's
branch), why would you want these changes in a stable tree?

thanks,

greg k-h

