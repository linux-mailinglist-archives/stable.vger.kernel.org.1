Return-Path: <stable+bounces-50232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E5F90521E
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB7B7B232FE
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5316F0FD;
	Wed, 12 Jun 2024 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QWf5wDf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1C152DF1
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194224; cv=none; b=YQtKCzybcF9DyjAfR807yDHGYmIudNPKZVLZ2mf43Ug0Ce72In3sLUZRfJCGtLYxNDzzB4DE8NVQ6sA/13lcKN9VZrxsci8Fo0a6Dp2ec0RPDQWamEk3/Ctez0XFx7EniBAmJS8V/3lD8Gxv9JUNhMQ638OkTKeFUyRpZ2h3/jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194224; c=relaxed/simple;
	bh=xZYkyvu+fSB5B5gNLQnY0SByePfu50QyKpWbEOUm1Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PipCQHL33MeCtBqRmv5V92PGFNJogOM02vn9FlinLSpVJfX3s9QU9gEYEewW7J7UiTj/7nFzyTfY3kWAdRCnbglT/QMf0Neyn98cmsPmJzMtK2DjnK9D4Qoz9j/MPc5HwI0L5Rm9L9GBlo7jEwNUvc0KwxZN+xEtc/lOs/rZyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QWf5wDf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F90C3277B;
	Wed, 12 Jun 2024 12:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718194223;
	bh=xZYkyvu+fSB5B5gNLQnY0SByePfu50QyKpWbEOUm1Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWf5wDf7gzWdCwtPDKCe4+Ie3sTP9LXEXhnZqmm5ImIBzB0yerqNmJlBy3K3xELLS
	 bnXLQC38ePMwDXdQo+wWqkaL6ky3fBzpnVWT9SZdoNUTAIJ6YduAS8oi1sKsIFzB9w
	 mc5Hi8tyySHpoQ9Kv1vhke77LHWLqs4m2dxaWQi0=
Date: Wed, 12 Jun 2024 14:10:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: akpm@linux-foundation.org, fleischermarius@gmail.com,
	sidhartha.kumar@oracle.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] maple_tree: fix mas_empty_area_rev() null
 pointer dereference" failed to apply to 6.1-stable tree
Message-ID: <2024061215-footage-goldsmith-bd92@gregkh>
References: <2024051347-uncross-jockstrap-5ce0@gregkh>
 <tqyvr6nenpho7fg5p5byipkmlhrv7oqdw6qi3mzbq54nofeohf@4m4fe7xcxoyr>
 <2024052401-scrimmage-camera-8cfa@gregkh>
 <w6easm2a7svb4rxc5lfhnfsruceudsqhdjlerblwtczln7uoub@yfma32amjpwn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w6easm2a7svb4rxc5lfhnfsruceudsqhdjlerblwtczln7uoub@yfma32amjpwn>

On Fri, May 24, 2024 at 09:03:15AM -0400, Liam R. Howlett wrote:
> * Greg KH <gregkh@linuxfoundation.org> [240524 00:10]:
> > On Thu, May 23, 2024 at 03:45:22PM -0400, Liam R. Howlett wrote:
> > > * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [240513 09:30]:
> > > > 
> > > > The patch below does not apply to the 6.1-stable tree.
> > > > If someone wants it applied there, or to any other stable or longterm
> > > > tree, then please email the backport, including the original git commit
> > > > id to <stable@vger.kernel.org>.
> > > > 
> > > > To reproduce the conflict and resubmit, you may use the following commands:
> > > > 
> > > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > > > git checkout FETCH_HEAD
> > > > git cherry-pick -x 955a923d2809803980ff574270f81510112be9cf
> > > > # <resolve conflicts, build, test, etc.>
> > > > git commit -s
> > > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051347-uncross-jockstrap-5ce0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > > > 
> > > > Possible dependencies:
> > > > 
> > > > 955a923d2809 ("maple_tree: fix mas_empty_area_rev() null pointer dereference")
> > > > 29ad6bb31348 ("maple_tree: fix allocation in mas_sparse_area()")
> > >    ^- This patch is needed, and has a fixes tag.  I'm not entirely sure
> > >    why it wasn't included in 6.1 already, but it applies cleanly and
> > >    fixes the issue with 955a923d2809.
> > 
> > "Fixes:" tags does not mean "will always end up in stable".  Please
> > read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> 
> Thank you.  The Cc of stable was missing but wasn't required at the
> time, so this patch was not taken and wasn't necessary.  It's better to
> take it now.
> 
> > 
> > > > fad8e4291da5 ("maple_tree: make maple state reusable after mas_empty_area_rev()")
> > 
> > So you want us to take all of these?  Or just the one?
> 
> Apologies for not being clear.
> 
> The last patch in the list (fad8e4291da5) is reported to be an empty
> cherry-pick and stable was Cc'ed on that fix.
> 
> Please apply:
> 29ad6bb31348 ("maple_tree: fix allocation in mas_sparse_area()")
> then
> 955a923d2809 ("maple_tree: fix mas_empty_area_rev() null pointer dereference")

Now done, thanks.

greg k-h

