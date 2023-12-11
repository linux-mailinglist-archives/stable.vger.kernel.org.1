Return-Path: <stable+bounces-5228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27080BEBF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 02:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93FF280C5A
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 01:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF6BE5D;
	Mon, 11 Dec 2023 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpNQkGUz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B3B7493
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 01:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77739C433C8;
	Mon, 11 Dec 2023 01:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702258099;
	bh=UBD2PS357JX2iWXWIzfDJXAOBCMl/VCKiHU+FzQmXn0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dpNQkGUzpZg52sOzpoHvHKviZ9z4h90fGXWQ/LUnnW5xgGWeojfkfE6ZmfYbDwOwV
	 hJMAwDyXZ/IogM+sPqR32r1OkY+VGTb86KnbHy4fcu+cs9fsJZrjIielsu/z+2dZeR
	 YuBpwoPnspWSfVkHwrSSKY2ZD7wVtnHNxkuridPuWqZ4KBwYT40Ip03ncf+y7Tqf0Y
	 LEjEZpZkZ1JCaHX0mgOtTw+p6i293S70QwlGLZXokvCrqwW46+0zyuCdw1931ijHJI
	 MFKd+WgqbfCWb6jXWeIhkn3yMfVmVAfgL8AIzBri/AEVhsEHsumDnNczyzAc6OfRbL
	 d3wXHWiNeRKMA==
Date: Mon, 11 Dec 2023 10:28:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, JP Kobryn <inwardvessel@gmail.com>
Subject: Re: [PATCH 6.6.y] kprobes: consistent rcu api usage for kretprobe
 holder
Message-Id: <20231211102815.2399cdf8bab5c3e705bd7de8@kernel.org>
In-Reply-To: <2023120932-follow-willow-32f3@gregkh>
References: <2023120316-seduce-vehicular-9e78@gregkh>
	<20231206015711.39492-1-mhiramat@kernel.org>
	<2023120932-follow-willow-32f3@gregkh>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 9 Dec 2023 13:20:09 +0100
Greg KH <greg@kroah.com> wrote:

> On Wed, Dec 06, 2023 at 10:57:11AM +0900, mhiramat@kernel.org wrote:
> > From: JP Kobryn <inwardvessel@gmail.com>
> > 
> > It seems that the pointer-to-kretprobe "rp" within the kretprobe_holder is
> > RCU-managed, based on the (non-rethook) implementation of get_kretprobe().
> > The thought behind this patch is to make use of the RCU API where possible
> > when accessing this pointer so that the needed barriers are always in place
> > and to self-document the code.
> > 
> > The __rcu annotation to "rp" allows for sparse RCU checking. Plain writes
> > done to the "rp" pointer are changed to make use of the RCU macro for
> > assignment. For the single read, the implementation of get_kretprobe()
> > is simplified by making use of an RCU macro which accomplishes the same,
> > but note that the log warning text will be more generic.
> > 
> > I did find that there is a difference in assembly generated between the
> > usage of the RCU macros vs without. For example, on arm64, when using
> > rcu_assign_pointer(), the corresponding store instruction is a
> > store-release (STLR) which has an implicit barrier. When normal assignment
> > is done, a regular store (STR) is found. In the macro case, this seems to
> > be a result of rcu_assign_pointer() using smp_store_release() when the
> > value to write is not NULL.
> > 
> > Link: https://lore.kernel.org/all/20231122132058.3359-1-inwardvessel@gmail.com/
> > 
> > Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > (cherry picked from commit d839a656d0f3caca9f96e9bf912fd394ac6a11bc)
> > ---
> >  include/linux/kprobes.h | 8 +++-----
> >  kernel/kprobes.c        | 4 ++--
> >  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> Did you build this?  It breaks the build in 6.6.y in horrible ways:
> 
> ./include/linux/kprobes.h:145:33: error: field ‘pool’ has incomplete type
>   145 |         struct objpool_head     pool;
>       |                                 ^~~~
> 
> 
> I'll drop this, can you please provide a working version?

Oops, sorry. I missed to patch this version.

Let me update it.

> 
> thanks,
> 
> greg k-h


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

