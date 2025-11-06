Return-Path: <stable+bounces-192645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E07FBC3D42E
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 20:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8455A4E208A
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 19:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0948133C532;
	Thu,  6 Nov 2025 19:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGyOK8Rq"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817033507F
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 19:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457914; cv=none; b=AaLa5DozUinbIUt84Nrnrc5JxJeebV2hh5I5T5lZUBoZNHCWHZPb+tjZGKCqmqyUsiZqoMhibKUGqUU++VfxciFD4Y0tuLfQHyGkK8YGw4grZAwbIwvsF1vSRjGUZIIUxAbXP7Y6SqarlMHWkZzS7X1NKEp+WhyTZ29gHf03f9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457914; c=relaxed/simple;
	bh=htCCclXRRTSfNtzxMezZq4IR7RmLZZSdOeEpdNANtiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXZWv8ebV2xukBLUYPK0lDllcy+axdW/7HqGHjdkRNDBtzI1oiVBqdtN//Bz31PgyOSBlmgYl/fSBt2AOddQfdFVKcQNWo3HqryBu/b6GLGSgG81J2+AMVpQZlEHloChGTDKV6rrxnI7TjFnYg3dnpAX/n0Rq+0wsKsvgfh289k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGyOK8Rq; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed83ad277fso49271cf.0
        for <stable@vger.kernel.org>; Thu, 06 Nov 2025 11:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457912; x=1763062712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au4yHmJ+eAAs4ru8qXuzKlpyKvxCeRwM44jREzgs70s=;
        b=DGyOK8Rq7w8VqwKtyMJOyfJP22L769UOwq0InqRtkyjv08hO3Gbl6iLxC9JteYWSUJ
         noNEAWYNKvtdy7/onk2fDsh/Up+y8AS95Bb/mpRBb6vgVZDEksCkn54E2gCRSIj1cqoG
         a9BwLpGmWQlrt9PaRclIDNAR217BIf+kFciUNiDPrtPECHmKXiU7SSv5V8++3BK3QplY
         NyyA09hdgkwOyPioRrEOsl6YU2fZlzEAzxkroT/aB5xyIyTwD7g8GLL6Y96R5pFHvb1V
         66lNmIbq6g6G4nTgXSKvwO0V78xC0UOuaMgWca9Cq6yP+PY0nK50OUCz8JeRCUwINIoY
         KIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457912; x=1763062712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=au4yHmJ+eAAs4ru8qXuzKlpyKvxCeRwM44jREzgs70s=;
        b=fqxUR6w2EVmSqgc1EXAqScf5GDIGntcgTN8hoSVGBTx0jtnSg4tBQRr+6zvvohcEHn
         kUAOhhJ0BoBL+Fp+0WUE3cvLg188lvyAIe9qETcCMo6wDv9sY+tu4lI2uyABLICsSGOe
         NRGB0qKmNBxnkB2QtbyTZtQm42Nz5XQgvwLfI+btjjrB9qDGYvmijwIFdsIITz9EF2EV
         ZmGgOqufWUSAwZyJGSfi/bLHJHiJ9RNsSll6n35xQxN3ZoQIAFH+vOYH3mEPGwY2/OG5
         MkFFOjhC+oJxAF5SxumsWOS9culWL+NcKvt4B/EK0C0EFNmhVeQ8gzP7MHNYoamqbgCq
         3F/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNgXHUrVc2ADuyDo6TxoquL7Mx9B8so1DF4SPEF81D+pGpNAiyEx2bEsH6H9iBwqLpgAjnNeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6UbXVFHfRNYuzsrkPdREcojj1dooeQfyG9YCDEqqIkQLr7PG
	tE6M3vgBpn1EPe+0iWCD1S3KzC0d0B1Gc3aGyPyaPHHcTrjbJAIlXCjLb2/WFZczF3RKLBWgW6H
	bHZjUNo1inTAARuLhInlcUGfzxN2LKL0=
X-Gm-Gg: ASbGncspvbDdhI47DrH9vyw+1goEOCW0MdhaPmkNLSW56+R11rqi0D9MqYPGLJbwAc1
	S6zhQiTF0wq+VZjR02ecsb/UkXoetH1rGi4RNvGwBdcSsl4SiRlxbsZTqEDYW5QEWvkQpkAm+Qs
	ZZlC6rng0UDizcHWGCmxxFUngubIgVl6M+Yno+ltB37p9NDN8HRbmtwW/yomeAaZsFZ4Wr262W8
	t3RZ2u4Qh5/TVOdKd0n9ROPtImr2QCdgE/6ah8rDtLWWOVUZLt5jIqy3mMY6WeKWP4l2roH2K15
	A81UWoy3Wy0/yUE=
X-Google-Smtp-Source: AGHT+IEWuUwRQbyqGylienh6BMzwpg/JB6xpNoZMrM6WzCCEIgb/HTUw4nCIOtdkN6F8fo+kCYqfX8RwaSIpr2XFfOg=
X-Received: by 2002:a05:622a:1187:b0:4e6:ee71:ee8f with SMTP id
 d75a77b69052e-4ed9497824fmr6087251cf.23.1762457912044; Thu, 06 Nov 2025
 11:38:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010220738.3674538-1-joannelkoong@gmail.com> <20251010220738.3674538-2-joannelkoong@gmail.com>
In-Reply-To: <20251010220738.3674538-2-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 6 Nov 2025 11:38:21 -0800
X-Gm-Features: AWmQ_bm5GPa9LFrjFiVAhIWylI3ld7gMo3TswYkPgcx-PpS_BfKG1fT-qAMdg0Y
Message-ID: <CAJnrk1YemmKkgTN4a-T7Kc1vtUSJi3GO8bY1BfXWZUKcx6NBtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fuse: fix readahead reclaim deadlock
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, osandov@fb.com, 
	hsiangkao@linux.alibaba.com, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 3:08=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Commit e26ee4efbc79 ("fuse: allocate ff->release_args only if release is
> needed") skips allocating ff->release_args if the server does not
> implement open. However in doing so, fuse_prepare_release() now skips
> grabbing the reference on the inode, which makes it possible for an
> inode to be evicted from the dcache while there are inflight readahead
> requests. This causes a deadlock if the server triggers reclaim while
> servicing the readahead request and reclaim attempts to evict the inode
> of the file being read ahead. Since the folio is locked during
> readahead, when reclaim evicts the fuse inode and fuse_evict_inode()
> attempts to remove all folios associated with the inode from the page
> cache (truncate_inode_pages_range()), reclaim will block forever waiting
> for the lock since readahead cannot relinquish the lock because it is
> itself blocked in reclaim:
>
> >>> stack_trace(1504735)
>  folio_wait_bit_common (mm/filemap.c:1308:4)
>  folio_lock (./include/linux/pagemap.h:1052:3)
>  truncate_inode_pages_range (mm/truncate.c:336:10)
>  fuse_evict_inode (fs/fuse/inode.c:161:2)
>  evict (fs/inode.c:704:3)
>  dentry_unlink_inode (fs/dcache.c:412:3)
>  __dentry_kill (fs/dcache.c:615:3)
>  shrink_kill (fs/dcache.c:1060:12)
>  shrink_dentry_list (fs/dcache.c:1087:3)
>  prune_dcache_sb (fs/dcache.c:1168:2)
>  super_cache_scan (fs/super.c:221:10)
>  do_shrink_slab (mm/shrinker.c:435:9)
>  shrink_slab (mm/shrinker.c:626:10)
>  shrink_node (mm/vmscan.c:5951:2)
>  shrink_zones (mm/vmscan.c:6195:3)
>  do_try_to_free_pages (mm/vmscan.c:6257:3)
>  do_swap_page (mm/memory.c:4136:11)
>  handle_pte_fault (mm/memory.c:5562:10)
>  handle_mm_fault (mm/memory.c:5870:9)
>  do_user_addr_fault (arch/x86/mm/fault.c:1338:10)
>  handle_page_fault (arch/x86/mm/fault.c:1481:3)
>  exc_page_fault (arch/x86/mm/fault.c:1539:2)
>  asm_exc_page_fault+0x22/0x27
>
> Fix this deadlock by allocating ff->release_args and grabbing the
> reference on the inode when preparing the file for release even if the
> server does not implement open. The inode reference will be dropped when
> the last reference on the fuse file is dropped (see fuse_file_put() ->
> fuse_release_end()).
>
> Fixes: e26ee4efbc79 ("fuse: allocate ff->release_args only if release is =
needed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reported-by: Omar Sandoval <osandov@fb.com>
> ---
>  fs/fuse/file.c | 40 ++++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 14 deletions(-)

Miklos, does this approach look okay to you?

Thanks,
Joanne

