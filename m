Return-Path: <stable+bounces-81498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100C993C3F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 03:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C3D1F23ED4
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 01:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6FBE4E;
	Tue,  8 Oct 2024 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tq9lB4qK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C5EC4;
	Tue,  8 Oct 2024 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728350747; cv=none; b=I7A4XHFZJ15onzlaTIkZy6yvT+MS1vnyPoMAlmKIdgLgBRjKECTo47ShXQR6kii9gLJzyPboP2NZPDEUj4sCZKwfcux9THxlYR7uNeCIgfbNc+8ZPw8pIiJoek2UdgZhzbhDw9ib4gL/rTO3IADXyzdM43beB8NC4OzlK/7Ty+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728350747; c=relaxed/simple;
	bh=Jcaw7n1n45MRlRFybUVcR90vvhEXAsjWZ5csI8emrWI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lSae79/yIRGuXtjVOCV05dNhp3Fjl9/kbIBNh1NA+p0Pgp5aKzzPwrkqxLdavz9FMBNH4PfM9lo/QyS4SVMFhJrHOdf+jN7QCIJxbXwQdkG8A9JN7xx12+6qWt0Vo3rn2uXQJYKEirjdqygEPaZBsRt+m2X1wnhLtJ8csoYpGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tq9lB4qK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6D7C4CECD;
	Tue,  8 Oct 2024 01:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728350747;
	bh=Jcaw7n1n45MRlRFybUVcR90vvhEXAsjWZ5csI8emrWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tq9lB4qKWsQWHQaf+mwVFtvWivq62jTqy3UWXf9/WASKXvKbw0dDMT/VU7gd8wbic
	 q9lJwNm69aS/sKIcrC9ZKzGNfJkn0XMCcY9sPyzlBhqU8cLIGZQmv8F+rqqF5/Y2S4
	 KsM/KSEBtnhcaScoCsgqv3lm5Te5WcJFh3h1lEy4=
Date: Mon, 7 Oct 2024 18:25:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, usama.anjum@collabora.com,
 peterx@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm: remove the newlines, which are added for unknown
 reasons and interfere with bug analysis
Message-Id: <20241007182546.7f3ac958c7a3bc408420549a@linux-foundation.org>
In-Reply-To: <CAO9qdTGSaJZ0oTmWqRouU45ur3drQVxRaH8aaBB99DXAoA40_A@mail.gmail.com>
References: <20241007065307.4158-1-aha310510@gmail.com>
	<2024100748-exhume-overgrown-bf0d@gregkh>
	<CAO9qdTFwaK36EKV1c8gLCgBG+BR5JmC6=PGk2a6YdHVrH9NukQ@mail.gmail.com>
	<2024100700-animal-upriver-fb7c@gregkh>
	<CAO9qdTGSaJZ0oTmWqRouU45ur3drQVxRaH8aaBB99DXAoA40_A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 20:24:57 +0900 Jeongjun Park <aha310510@gmail.com> wrote:

> > > Since I cannot modify the source code printing function of the git.kernel.org
> > > site, the best solution I can suggest is to remove the unnecessary line break
> > > character that exists in all versions.
> >
> > I would recommend fixing the git.kernel.org code, it is all open source
> > and can be fixed up, as odds are other projects/repos would like to have
> > it fixed as well.
> >
> 
> Oh, I just realized that this website is open source and written in C.
> 
> This seems to be the correct git repository, so I'll commit here.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/cgit.git

Still, we don't want that newline in there.  I did this as a little
cleanup.  Please send a new (similar) patch if you're prefer.


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm/memory.c: remove stray newline at top of file
Date: Mon Oct  7 06:20:09 PM PDT 2024

Fixes: d61ea1cb0095 ("userfaultfd: UFFD_FEATURE_WP_ASYNC")
Reported-by: Jeongjun Park <aha310510@gmail.com>
Closes: https://lkml.kernel.org/r/20241007065307.4158-1-aha310510@gmail.com
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/memory.c |    1 -
 1 file changed, 1 deletion(-)

--- a/mm/memory.c~mm-memoryc-remove-stray-newline-at-top-of-file
+++ a/mm/memory.c
@@ -1,4 +1,3 @@
-
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  *  linux/mm/memory.c
_


