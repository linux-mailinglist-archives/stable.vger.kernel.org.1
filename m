Return-Path: <stable+bounces-23882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B798868D26
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB0D1F2726F
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3746913849E;
	Tue, 27 Feb 2024 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VsShARyD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ECF137C54
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029075; cv=none; b=d3qJa90yvttiU+vlalv8mTSgvkO60JwYYKFycuUhwiKfo2jVKIYldui84GgmwsVZRxMXBgl6msJ4/JOeKlJuj+5T00xjY/WfYmf4qNtItUV938Bs+CZhWrV0FxZfpOVWXN/vzKC/uX1sfx5ZJ4D5luET+40mj9cdIjl2PF1egdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029075; c=relaxed/simple;
	bh=Pj9fQqXNgLOTZPgjbJu5jq+uDsHzDZ1/ibx6CdSZ1dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9Qia4QWubT2Y29fJ3W02HjNhT29STSOZQHEsBr9jkc5r9YrmGagwxenXilVWR5TMEG6B9AqBX9K6KzziK74Nyr7F6xPMEQtBfaACHs2C3d5uG+GY4BQJBM0yBPKn0jNMolSRh9F1rzU8kMM+texDUM0ycIzJPvuB5nz4ZDFGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VsShARyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133FDC433F1;
	Tue, 27 Feb 2024 10:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709029074;
	bh=Pj9fQqXNgLOTZPgjbJu5jq+uDsHzDZ1/ibx6CdSZ1dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VsShARyDWAg8zTydT4cbMF7UMVRHZhows9fcjw0Fc6oI1MPTH5sLE9dIhDeD9lS7F
	 iEvjnmEOEv4/vmOlgTf+9Fu2EyG+DpNovPv+fxSqsc0VbbaNvITN8AT9oh9vYbBWLE
	 F12yqAiuZJIHf4Lt2+UhbQ1zZhYICsWIEZKH86q8=
Date: Tue, 27 Feb 2024 11:17:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: stable@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: zswap: fix missing folio cleanup in writeback race
 path
Message-ID: <2024022730-passenger-moonlike-62f3@gregkh>
References: <2024022611-tropics-deferred-2483@gregkh>
 <20240226221017.1332778-1-yosryahmed@google.com>
 <2024022755-amplify-vocation-854e@gregkh>
 <CAJD7tkYYWPWA-3fGAjMOqVy+8Mcwq++6yw0R6odeOsByugre+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYYWPWA-3fGAjMOqVy+8Mcwq++6yw0R6odeOsByugre+Q@mail.gmail.com>

On Tue, Feb 27, 2024 at 12:58:27AM -0800, Yosry Ahmed wrote:
> On Tue, Feb 27, 2024 at 12:55 AM Greg KH <greg@kroah.com> wrote:
> >
> > On Mon, Feb 26, 2024 at 10:10:17PM +0000, Yosry Ahmed wrote:
> > > In zswap_writeback_entry(), after we get a folio from
> > > __read_swap_cache_async(), we grab the tree lock again to check that the
> > > swap entry was not invalidated and recycled.  If it was, we delete the
> > > folio we just added to the swap cache and exit.
> > >
> > > However, __read_swap_cache_async() returns the folio locked when it is
> > > newly allocated, which is always true for this path, and the folio is
> > > ref'd.  Make sure to unlock and put the folio before returning.
> > >
> > > This was discovered by code inspection, probably because this path handles
> > > a race condition that should not happen often, and the bug would not crash
> > > the system, it will only strand the folio indefinitely.
> > >
> > > Link: https://lkml.kernel.org/r/20240125085127.1327013-1-yosryahmed@google.com
> > > Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > > Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > > (cherry picked from commit e3b63e966cac0bf78aaa1efede1827a252815a1d)
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > What tree is this for?
> 
> This is for 6.6.y, sorry I messed up the subject prefix. Do I need to resend?

Ah, here is the 6.6.y version, missed it, sorry for the noise.  I'll go
queue this and the 6.1.y version up now.

thanks,

greg k-h

