Return-Path: <stable+bounces-86886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73229A48FE
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 23:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F36DB23726
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 21:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E892B18E34E;
	Fri, 18 Oct 2024 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sx3P6vRe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5B418D640
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287426; cv=none; b=JKzRLchxIXzWzLK0DH3e4ImjHwiPVm4pWqsDvfZTWe491RwNOdxixREssasXy2cZX8aWTxqykWqq8Odlyz2e7bXiEK8i5ebGyiBp+PdEe67C9B8VwlT3qlyqHoKJS78hwnXawNwZkQsF37Zxp0eTrazoGxazbQpk2NZrBHWo6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287426; c=relaxed/simple;
	bh=7uArWuu662YLX+5+NeTQNX9c5XCJkAt5M9yXKh/syS0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tasoJEsWmoJLev5u6Y1KSQXj1Hk/zdN3MkRsKm/hHYsI+c060KLqy2Yyb7Aj1La16vg6yAp0nZej1VjJhbVj30fZEDcnVuQQf8lAo/lN3ijoMR1hq7MxLvRYLN59s72pupoowmyG2MoihjNJZORFmFOkDDyXN/a38kvwCYDQUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Sx3P6vRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4D6C4CEC3;
	Fri, 18 Oct 2024 21:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729287426;
	bh=7uArWuu662YLX+5+NeTQNX9c5XCJkAt5M9yXKh/syS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sx3P6vRexMD2esFE4t2cmPdc+tNf9CM9mZJlAZ+f/B6m7XHaRca4M4+6M3lN8pIfx
	 miII3ONy1cr05vj4HJqa9hiYZjzNF4yKF09pdSDuvWfbGoVymPXd0VoBl2pAwUrDSr
	 3+5LvZ0m1SE1gntrmHDY8/EU2ue8taPeSb1Kpj7I=
Date: Fri, 18 Oct 2024 14:37:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Chris Li <chrisl@kernel.org>, stable@vger.kernel.org, yangge
 <yangge1116@126.com>, Yu Zhao <yuzhao@google.com>, David Hildenbrand
 <david@redhat.com>, Hugh Dickins <hughd@google.com>,
 baolin.wang@linux.alibaba.com, Kairui Song <ryncsn@gmail.com>
Subject: Re: [PATCH 6.11.y] mm: vmscan.c: fix OOM on swap stress test
Message-Id: <20241018143705.73954d6c3451770240a5da09@linux-foundation.org>
In-Reply-To: <2024101800-resurface-edginess-1fcf@gregkh>
References: <20241016-stable-oom-fix-v1-1-ca604a36a2b6@kernel.org>
	<2024101800-resurface-edginess-1fcf@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 10:51:30 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Oct 16, 2024 at 09:49:49AM -0700, Chris Li wrote:
> > [ Upstream commit 0885ef4705607936fc36a38fd74356e1c465b023 ]
> > 
> > I found a regression on mm-unstable during my swap stress test, using
> > tmpfs to compile linux.  The test OOM very soon after the make spawns many
> > cc processes.
> > 
> > It bisects down to this change: 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
> > (mm/gup: clear the LRU flag of a page before adding to LRU batch)
> > 
> > Yu Zhao propose the fix: "I think this is one of the potential side
> > effects -- Huge mentioned earlier about isolate_lru_folios():"
> > 
> > I test that with it the swap stress test no longer OOM.
> > 
> > Link: https://lore.kernel.org/r/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZUmErNAXoXmw@mail.gmail.com/
> > Link: https://lkml.kernel.org/r/20240905-lru-flag-v2-1-8a2d9046c594@kernel.org
> > Fixes: 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding to LRU batch")
> > Signed-off-by: Chris Li <chrisl@kernel.org>
> > Suggested-by: Yu Zhao <yuzhao@google.com>
> > Suggested-by: Hugh Dickins <hughd@google.com>
> > Closes: https://lore.kernel.org/all/CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com/
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  mm/vmscan.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Again, for mm changes, we need an explicit ack from the mm maintainers
> before we can take them.  I'll wait for that.

Yes, please proceed with the backport.  It looks like the cc:stable got
lost because it wasn't in the original commit.

btw Chris, that was a quite poor changelog.  It didn't explain the code
change at all!


