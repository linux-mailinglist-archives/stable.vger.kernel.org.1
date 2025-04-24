Return-Path: <stable+bounces-136558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2BDA9AACE
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133871943322
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62554221FBB;
	Thu, 24 Apr 2025 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NdFHFc+W"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1BD221FD0
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491241; cv=none; b=D9UVQgaygkSQ21HJUJWjld4dcS+86YJloAqEmh5EhAXKFlcZvQRQBmh/vE+FglbIucIlSPgc2BKX4jDCUP0PnUMxDKgbiAGst80HH4rZsMiNTT3hRyydJVtEiiFy/KSyGqR8OwsaLXqLcUhphd5IbHR1JORRVXtkNIl9ziL+jJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491241; c=relaxed/simple;
	bh=pAlgozLVj6Myei8Kkibp1HU5El0KCrQyq6gAjyZNuWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuwYriphgpF7SEJODajEBLcunz6aCuH2hp1vb1tZn0PPMElLuwbGQWKQ8L8qaDAa1LJp4s8emwE105FtYpJiLZKi3thiGfGuP9EC0DyXDRBAJMKnLLTJ4fvFtJjdE//71gPkL3jCURB81SOkhsxCq0yMthq21QOCJFs4iSytzp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NdFHFc+W; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so158792066b.1
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745491236; x=1746096036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GtfRT99MTlUkFXgmbyHLMUIeOG8k7u98XVfnCs0CWE4=;
        b=NdFHFc+WuhipXSAbfRz+LMwomWX2oktI26PfA4JFj+SZlqHpseEtJeINoMJ74+XuOz
         40MQPv8S1yvmdRraHjU2RcNJKZkSDABWLXmVNOtVlzRgiRJwBTawFEQjNf8Dc/QVT3jH
         HNQv+qF/Bt35tnqu0CyJt54O4MC3McpeqF5fgO0vDJkaJmNzt4i1cDVk3DNuyQsd563F
         dbIE+VA/o16JHl47rj1jkPhVBPjw9djG9qWr1Ot2DCN/1+H7hlVAwbJW24sdz5p0CgYO
         fcfVeceP0WGb+vBVc/Ng0INLkpe3z7hvqrCvqUTAeLCGmV/JSlC5YYZBW3/Ji7/rORti
         JUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745491236; x=1746096036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtfRT99MTlUkFXgmbyHLMUIeOG8k7u98XVfnCs0CWE4=;
        b=XitOFToWb1S/un1C+ABH7LuikQVbztAI41Paixk3XtKAK3InltmOC5S3mdKL31DGDe
         iSPU2b/yZxApzBk8hLQwIWoNQGvsZApD6qvo47hOe2aAqj1NGk/4iRJmnsWURWDuzLq0
         6iSEKDc6kl2rDcKGS7IDkYgrlN42+EUXqYZiLa9XcPhmSe1NB0d/pJ+cQuHknF1IhS7u
         KMhWO3LfWlB1Af7rkmTopb3nhqndJrgyzlGw6HUTwPyMKwg67Z/jtGuo7SIowJBzSSUl
         giZOqHLEDcJj3bzHy/8P8Glm59nzEavUebHlC6dj5njV5EzyipQgagxu+rPoe/AN2iPh
         ezdA==
X-Forwarded-Encrypted: i=1; AJvYcCU8xFPmziVuiYvUNoLIYssp+Z0AoJdMwnpLLLyyH+Bh/MnLQWwT5010h7KFjK2KPUvS3zxHvLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4iPS9srb2wsnOiNRsaT7hGoRAYAotknOzBGQbyaacgv21B825
	HRBaItiGr9B+LUOmtfiR2HwG9Xq+NipCKNPON2CZhRTxnFHv/qnEp9lPeckp400X3lEyPJWJnVH
	Oo/b0DOUx0jPjSGEHnJwP+l2rpHNzyO4BbSN5jg==
X-Gm-Gg: ASbGncsgcoaFtAYY0J4BR3sSE00vp4UdU8J8qKNZj2FaqLWKgqY2WZgXw1xAIUEJaKg
	s5I5GIRwFJzvQ8qI4LhXLAG64Uzgwod097BtnGz/c33JtXwL/v649xrIFAkFV8c/cEEUz8iPUdo
	um6xBKyDwYVUq84xprtr8Y3fu1d8H5pB8=
X-Google-Smtp-Source: AGHT+IGQ46sX8xauDnXo0DcNLct12CrIFuB+EZzRlms3VBgmCIXtMB8vs1GEYfS3XPpU3UZSTymf6ArwqyURDINoY3s=
X-Received: by 2002:a17:906:7305:b0:acb:b1be:4873 with SMTP id
 a640c23a62f3a-ace570cd13amr227381966b.2.1745491236194; Thu, 24 Apr 2025
 03:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1745242535.git.josef@toxicpanda.com>
In-Reply-To: <0914bad6138d2cfafc9cfe762bd06c1883ceb9d2.1745242535.git.josef@toxicpanda.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 24 Apr 2025 12:40:25 +0200
X-Gm-Features: ATxdqUEjZ2OtdOwusg_iqCORuGSxanaCD_qTTKbtFtNFaB02bCCrUYFmLreEIsQ
Message-ID: <CAPjX3FeSOJVo=4hyPaHp3svLorWXp2SGhMEB17+Qm3OLmireSw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: adjust subpage bit start based on sectorsize
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, stable@vger.kernel.org, 
	Boris Burkov <boris@bur.io>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Apr 2025 at 15:38, Josef Bacik <josef@toxicpanda.com> wrote:
>
> When running machines with 64k page size and a 16k nodesize we started
> seeing tree log corruption in production.  This turned out to be because
> we were not writing out dirty blocks sometimes, so this in fact affects
> all metadata writes.
>
> When writing out a subpage EB we scan the subpage bitmap for a dirty
> range.  If the range isn't dirty we do
>
> bit_start++;
>
> to move onto the next bit.  The problem is the bitmap is based on the
> number of sectors that an EB has.  So in this case, we have a 64k
> pagesize, 16k nodesize, but a 4k sectorsize.  This means our bitmap is 4
> bits for every node.  With a 64k page size we end up with 4 nodes per
> page.
>
> To make this easier this is how everything looks
>
> [0         16k       32k       48k     ] logical address
> [0         4         8         12      ] radix tree offset
> [               64k page               ] folio
> [ 16k eb ][ 16k eb ][ 16k eb ][ 16k eb ] extent buffers
> [ | | | |  | | | |   | | | |   | | | | ] bitmap
>
> Now we use all of our addressing based on fs_info->sectorsize_bits, so
> as you can see the above our 16k eb->start turns into radix entry 4.

Btw, unrelated to this patch - but this way we're using at best only
25% of the tree slots. Or in other words we're wasting 75% of the
memory here. We should rather use eb->start / fs_info->nodesize for
the tree index.

And by the other way - why do we need a copy of nodesize in eb->len?
We can always eb->fs_info->nodesize if needed.

> When we find a dirty range for our eb, we correctly do bit_start +=
> sectors_per_node, because if we start at bit 0, the next bit for the
> next eb is 4, to correspond to eb->start 16k.
>
> However if our range is clean, we will do bit_start++, which will now
> put us offset from our radix tree entries.
>
> In our case, assume that the first time we check the bitmap the block is
> not dirty, we increment bit_start so now it == 1, and then we loop
> around and check again.  This time it is dirty, and we go to find that
> start using the following equation
>
> start = folio_start + bit_start * fs_info->sectorsize;
>
> so in the case above, eb->start 0 is now dirty, and we calculate start
> as
>
> 0 + 1 * fs_info->sectorsize = 4096
> 4096 >> 12 = 1
>
> Now we're looking up the radix tree for 1, and we won't find an eb.
> What's worse is now we're using bit_start == 1, so we do bit_start +=
> sectors_per_node, which is now 5.  If that eb is dirty we will run into
> the same thing, we will look at an offset that is not populated in the
> radix tree, and now we're skipping the writeout of dirty extent buffers.
>
> The best fix for this is to not use sectorsize_bits to address nodes,
> but that's a larger change.  Since this is a fs corruption problem fix
> it simply by always using sectors_per_node to increment the start bit.
>
> cc: stable@vger.kernel.org
> Fixes: c4aec299fa8f ("btrfs: introduce submit_eb_subpage() to submit a subpage metadata page")
> Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
> - Further testing indicated that the page tagging theoretical race isn't getting
>   hit in practice, so we're going to limit the "hotfix" to this specific patch,
>   and then send subsequent patches to address the other issues we're hitting. My
>   simplify metadata writebback patches are the more wholistic fix.
>
>  fs/btrfs/extent_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 5f08615b334f..6cfd286b8bbc 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2034,7 +2034,7 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
>                               subpage->bitmaps)) {
>                         spin_unlock_irqrestore(&subpage->lock, flags);
>                         spin_unlock(&folio->mapping->i_private_lock);
> -                       bit_start++;
> +                       bit_start += sectors_per_node;
>                         continue;
>                 }
>
> --
> 2.48.1
>
>

