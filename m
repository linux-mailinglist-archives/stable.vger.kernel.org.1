Return-Path: <stable+bounces-46026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60A18CE02F
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 06:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BD9B20B12
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 04:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FC3364CD;
	Fri, 24 May 2024 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IZWSf/BQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235992231F
	for <stable@vger.kernel.org>; Fri, 24 May 2024 04:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523796; cv=none; b=UMUmOKRw7YucYX3u/boYOkcR2FomDLBQgXkhkMbgfaMLUJqNvJBo6K/NFPnzzoDq1Eg/4zWBqCfJhIwA3+UvHJuPxxuhqNyhisfw9/AAj38mG7+UuQWldDm2mUGjmXoG3KegffBp9uKxFYr7g1wkX38UaN0/J7V10fcicL2LH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523796; c=relaxed/simple;
	bh=ujSy0ghq53Rar15M1r7t6otLcq9oSO/xzo0cfyTbcGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpHpD9GWDBjqeYsrpXga+Ou2iUYydvpKgbV+SFW2beMueC9S3Ggxhfiw8uaZz61POPyOiiTn6bsLOQPB9wfXuvMp/jgSUzny9+MgCWNKRkMFjzzNPCEE2hma0doM1RspGMJlx3EDl45E+vzI/Sh5wfWRjBj+NQBCRGRx/2JP02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IZWSf/BQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31866C2BBFC;
	Fri, 24 May 2024 04:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716523795;
	bh=ujSy0ghq53Rar15M1r7t6otLcq9oSO/xzo0cfyTbcGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IZWSf/BQX5xtERkIjcFKlIkdHzQJeO0C2HDN/F8gVyQCYvB1qAszb/D2W/6kQdu2Q
	 9FgHH95IEdHZ1EC1MOD2LhxR9sR1HHrNcbFn/FUNPrmHMAZLIdmLKGZpVaYbbIfCwm
	 BCQhrxBn6Uu3ik9x65rWQ8iK3mlEEoS9O14fJPis=
Date: Fri, 24 May 2024 06:09:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: akpm@linux-foundation.org, fleischermarius@gmail.com,
	sidhartha.kumar@oracle.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] maple_tree: fix mas_empty_area_rev() null
 pointer dereference" failed to apply to 6.1-stable tree
Message-ID: <2024052401-scrimmage-camera-8cfa@gregkh>
References: <2024051347-uncross-jockstrap-5ce0@gregkh>
 <tqyvr6nenpho7fg5p5byipkmlhrv7oqdw6qi3mzbq54nofeohf@4m4fe7xcxoyr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tqyvr6nenpho7fg5p5byipkmlhrv7oqdw6qi3mzbq54nofeohf@4m4fe7xcxoyr>

On Thu, May 23, 2024 at 03:45:22PM -0400, Liam R. Howlett wrote:
> * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [240513 09:30]:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 955a923d2809803980ff574270f81510112be9cf
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051347-uncross-jockstrap-5ce0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 955a923d2809 ("maple_tree: fix mas_empty_area_rev() null pointer dereference")
> > 29ad6bb31348 ("maple_tree: fix allocation in mas_sparse_area()")
>    ^- This patch is needed, and has a fixes tag.  I'm not entirely sure
>    why it wasn't included in 6.1 already, but it applies cleanly and
>    fixes the issue with 955a923d2809.

"Fixes:" tags does not mean "will always end up in stable".  Please
read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

> > fad8e4291da5 ("maple_tree: make maple state reusable after mas_empty_area_rev()")

So you want us to take all of these?  Or just the one?

thanks,

greg k-h

