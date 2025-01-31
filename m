Return-Path: <stable+bounces-111856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C25EA24531
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 23:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859DE3A65D4
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 22:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AE1192D7E;
	Fri, 31 Jan 2025 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wGgC/Haw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43217B402
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738362202; cv=none; b=EGrfJMmmlsSmNuM3P/1XR36837Y7ztGXMLb6XeWdWPYhTIvOiMQmlgA5bWLBmCrXMHuz6QQPnqh8m7ISNMkPIB7op9tiQDF3ijWzfDxsDvUxaVUSrWxG+Quknw9vtIF+j5g7H1eLuS1O91+FZaoFj3Ac+l5vs0lyrJyrwVDxvNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738362202; c=relaxed/simple;
	bh=nwVyP9nU/ce1tJmLE7dt7p5zzWeMULcBJL+nkofQ2cQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Tp7GwO7FfoMRbmEIV/ma38/ijquAKPRCBQOoVemmrWXI1lF9FJxbVl2W8JuqSW99288y3EJGRCcTQvob+7s110P4lCpyKoIhNLDc1ZB5FSlyWPUTQjZUOxwfSRsFzmnL8JPFeJgoj3Fhdo3O2MiHXQ2uDWvIT7l8DzzXcOoMMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wGgC/Haw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DBDC4CED1;
	Fri, 31 Jan 2025 22:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738362202;
	bh=nwVyP9nU/ce1tJmLE7dt7p5zzWeMULcBJL+nkofQ2cQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wGgC/Hawd4WptjG9VZ4SzzazWExRopVK70tnpkWsIOPy3TfzMIqVX6OpDYjVbnN5K
	 fHgU4BzcwA7ElEyyORyuA3WSsSt7usDd1R6nrn3GWkaSAPZxK1orp3DhBfJ94Q3qbk
	 1LU/7de324XWVLCkllzSDdIzioLdcNOWUMu8bYks=
Date: Fri, 31 Jan 2025 14:23:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ricardo =?ISO-8859-1?Q?Ca=F1uelo?= Navarro <rcn@igalia.com>
Cc: riel@surriel.com, linux-mm@kvack.org, stable@vger.kernel.org,
 kernel-dev@igalia.com, revest@google.com
Subject: Re: [PATCH] mm,madvise,hugetlb: check for 0-length range after end
 address adjustment
Message-Id: <20250131142321.632a9468529d3267abe641af@linux-foundation.org>
In-Reply-To: <20250131143749.1435006-1-rcn@igalia.com>
References: <20250131143749.1435006-1-rcn@igalia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Jan 2025 15:37:49 +0100 Ricardo Ca=F1uelo Navarro <rcn@igalia.co=
m> wrote:

> Add a sanity check to madvise_dontneed_free() to address a corner case
> in madvise where a race condition causes the current vma being processed
> to be backed by a different page size.
>=20
> During a madvise(MADV_DONTNEED) call on a memory region registered with
> a userfaultfd, there's a period of time where the process mm lock is
> temporarily released in order to send a UFFD_EVENT_REMOVE and let
> userspace handle the event. During this time, the vma covering the
> current address range may change due to an explicit mmap done
> concurrently by another thread.
>=20
> If, after that change, the memory region, which was originally backed by
> 4KB pages, is now backed by hugepages, the end address is rounded down
> to a hugepage boundary to avoid data loss (see "Fixes" below). This
> rounding may cause the end address to be truncated to the same address
> as the start.
>=20
> Make this corner case follow the same semantics as in other similar
> cases where the requested region has zero length (ie. return 0).
>=20
> This will make madvise_walk_vmas() continue to the next vma in the
> range (this time holding the process mm lock) which, due to the prev
> pointer becoming stale because of the vma change, will be the same
> hugepage-backed vma that was just checked before. The next time
> madvise_dontneed_free() runs for this vma, if the start address isn't
> aligned to a hugepage boundary, it'll return -EINVAL, which is also in
> line with the madvise api.
>=20
> >From userspace perspective, madvise() will return EINVAL because the
> start address isn't aligned according to the new vma alignment
> requirements (hugepage), even though it was correctly page-aligned when
> the call was issued.
>=20
> ...
>
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -933,7 +933,9 @@ static long madvise_dontneed_free(struct vm_area_stru=
ct *vma,
>  			 */
>  			end =3D vma->vm_end;
>  		}
> -		VM_WARN_ON(start >=3D end);
> +		if (start =3D=3D end)
> +			return 0;
> +		VM_WARN_ON(start > end);
>  	}

Perhaps add a comment telling the user how this situation can come about?

