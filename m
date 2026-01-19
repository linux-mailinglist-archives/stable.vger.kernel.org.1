Return-Path: <stable+bounces-210248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D943FD39BA5
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 01:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA75430078A1
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 00:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CB1B81D3;
	Mon, 19 Jan 2026 00:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GBHlbexQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7618859B;
	Mon, 19 Jan 2026 00:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768783253; cv=none; b=FUPhT2xQBjBlRlrJNeCPbgnbO1dJ20USdj+JdIoNX3Th2QJgFNEv7GHcflt6UiXdecHOgclFZ3Ws1t+1LeC+tynGCRcqalXpngBdArRF1icI45ADQER4SMfdsHmV5XbRiPHvNjnQVCGBEhuEuVVfz7/w6sb5hDSiPWNlJymS3cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768783253; c=relaxed/simple;
	bh=o5d1cIK9KCyPp4LwqwZ0dTGeui5QFRzjlMGckHWgW90=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rWux8OY1+pSNAZOlvcB2JRi9pR1IVwOWG47wrn15Mdfl3kJgUPc2c5YhTvDhvvLNo4oSgL6UIcp2htYlrEwJkpvKv0nrksCvyW0deUs6nuJp8k1SknlJmcsVHVmw6vgtR27xK1Jec53hDAoFIGvKc6Nmq8+qCPX7kjOrMYC43DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GBHlbexQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EC6C19421;
	Mon, 19 Jan 2026 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768783252;
	bh=o5d1cIK9KCyPp4LwqwZ0dTGeui5QFRzjlMGckHWgW90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GBHlbexQ6+CtEWF2lGBRULaWx/fWd0Sj7qc41OJ/qYSvXnJTDYkZ/s45tQ8m3amMh
	 9aYfDkBJT2IHKL7s7OuKB3Y8OU+S6TgSQjrViPmqUTQ9pCkMId2d8xMA9n66A4kFFx
	 KFVtvESlzZa+VWAKajmajm2KqBiXUDRjBAadoWPk=
Date: Sun, 18 Jan 2026 16:40:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Joanne
 Koong <joannelkoong@gmail.com>, linux-mm@kvack.org,
 athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, carnil@debian.org,
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
Message-Id: <20260118164051.521de8ad2758376c3e1d2d81@linux-foundation.org>
In-Reply-To: <01ebe0c6-6135-4937-a758-93a5fc78d7fe@kernel.org>
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
	<20251215030043.1431306-2-joannelkoong@gmail.com>
	<ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
	<616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org>
	<CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
	<238ef4ab-7ea3-442a-a344-a683dd64f818@kernel.org>
	<CAJfpegvUP5MK-xB2=djmGo4iYzmsn9LLWV3ZJXFbyyft_LsA_Q@mail.gmail.com>
	<c39232ea-8cf0-45e6-9a5a-e2abae60134c@kernel.org>
	<CAJfpegt0Bp5qNFPS0KsAZeU62vw4CqHv+1d53CmEOV45r-Rj0Q@mail.gmail.com>
	<01ebe0c6-6135-4937-a758-93a5fc78d7fe@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 18:54:47 +0100 "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:

> On 1/6/26 17:05, Miklos Szeredi wrote:
> > On Tue, 6 Jan 2026 at 16:41, David Hildenbrand (Red Hat)
> > <david@kernel.org> wrote:
> > 
> >> I assume the usual suspects, including mm/memory-failure.c.
> >>
> >> memory_failure() not only contains a folio_wait_writeback() but also a
> >> folio_lock(), so twice the fun :)
> > 
> > As long as it's run from a workqueue it shouldn't affect the rest of
> > the system, right?  The wq thread will consume a nontrivial amount of
> > resources, I suppose, so it would be better to implement those waits
> > asynchronously.
> 
> Good question. I know that memory_failure() can be triggered out of 
> various context, but I never traced it back to its origin.

I'm seeing unhappy okays from David and Jan, so I'll upstream this
patch later in the week, unless someone stops me.


