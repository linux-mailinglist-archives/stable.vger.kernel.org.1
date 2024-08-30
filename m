Return-Path: <stable+bounces-71643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495B966224
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 14:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76D11C231C3
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 12:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65B1A4AAF;
	Fri, 30 Aug 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PHuhUt0P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A71A4AAB
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022677; cv=none; b=AouV50mWXqLXw5/ZPc9XlpyD7B64rdPlkkjQ6UvywpLJLfNJ6DUb4WzLLwez/rqgNi2w4zntu0uVQr47EgVFwnYYZBkVhqiYmc6PiiTUpkSIleoqC29eIEyjguMY2CRhzJT8t8xuo/KQFt1cunPr1uFGccAeKVuQQEy8qSQ7pOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022677; c=relaxed/simple;
	bh=hzYUKPnQpeOsiMqZsdUmep7w0hKLktC/oDRe3ZuQDb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRX0aUIDCaHE+q7kxqcWemZIm7FeOxAvJ32sG+nyNvgXiRI+IKrqgGo6ws8IgvWoBV/De/vpw8IMrRHjN2UiPWIaTL2VYfuN4Z0ZKvGX5hilzLVOap4PRxEshC/L1YdNhIFc9DjP+ph7ZfjANaRHomoxoM5uYVx11pfivtmoh1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PHuhUt0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6A0C4CEC7;
	Fri, 30 Aug 2024 12:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725022676;
	bh=hzYUKPnQpeOsiMqZsdUmep7w0hKLktC/oDRe3ZuQDb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHuhUt0PTH5ACfBdB9lqjkLXy4pQ5JhjsxaUftCaNdjStzvKxP0HnJoNiwGTyhNv4
	 HZxgHbSh0L8IuULW04yTFANBry43ajsbKbeBfGeMGUgvMxjONlwP5YvS36MdgxtPok
	 Xji+TJrcQWNRmIXo8P/0jS/Xg0mmgTRUu8PRSe/Q=
Date: Fri, 30 Aug 2024 14:57:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
	Shakeel Butt <shakeelb@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Andrei Vagin <avagin@gmail.com>, Borislav Petkov <bp@alien8.de>,
	Borislav Petkov <bp@suse.de>,
	Christian Brauner <christian.brauner@ubuntu.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Michal Hocko <mhocko@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Roman Gushchin <guro@fb.com>, Serge Hallyn <serge@hallyn.com>,
	Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vladimir Davydov <vdavydov.dev@gmail.com>,
	Yutian Yang <nglaive@gmail.com>, Zefan Li <lizefan.x@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 1/1] memcg: enable accounting of ipc resources
Message-ID: <2024083045-ecologist-shrank-c2c9@gregkh>
References: <20240830082045.24405-1-hsimeliere.opensource@witekio.com>
 <20240830082045.24405-2-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830082045.24405-2-hsimeliere.opensource@witekio.com>

On Fri, Aug 30, 2024 at 10:20:28AM +0200, hsimeliere.opensource@witekio.com wrote:
> From: Vasily Averin <vvs@virtuozzo.com>
> 
> commit 18319498fdd4cdf8c1c2c48cd432863b1f915d6f upstream.
> 
> When user creates IPC objects it forces kernel to allocate memory for
> these long-living objects.
> 
> It makes sense to account them to restrict the host's memory consumption
> from inside the memcg-limited container.
> 
> This patch enables accounting for IPC shared memory segments, messages
> semaphores and semaphore's undo lists.
> 
> Link: https://lkml.kernel.org/r/d6507b06-4df6-78f8-6c54-3ae86e3b5339@virtuozzo.com
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Andrei Vagin <avagin@gmail.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "J. Bruce Fields" <bfields@fieldses.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Yutian Yang <nglaive@gmail.com>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
> ---
>  ipc/msg.c |  2 +-
>  ipc/sem.c | 10 ++++++----
>  ipc/shm.c |  2 +-
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 

Now queued up, thanks.

greg k-h

