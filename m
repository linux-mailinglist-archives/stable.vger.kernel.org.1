Return-Path: <stable+bounces-93622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4109CFBF4
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 02:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67EB5B243E5
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 01:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8AF18E756;
	Sat, 16 Nov 2024 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="og9I91Di"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F1364D6
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 01:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731719734; cv=none; b=gAuq4htpFJNw1jFvAXJ6ZDYyiid5V/cmQhcyqLP28zEwfV83akPOZwNUnGJBlcl2kR7KQkaI9thKLXsC6dCGB0udkQgnjJDVbXDwG9wWaXLvjvr9VpIuOKwrom0YCGaljR1wc9OQV7ZowbNobetGyQJyLa9Eue/vcjWSaJGNG2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731719734; c=relaxed/simple;
	bh=zMUQZOCpZMQ/dKSc6ZVQ1W83Gl82z5d9JySnnvZROUk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=szxRTXdPyuTblgtinlvuEYzs22dr8IQICpcLAZkNAwDxZBCoGowfho1+KjDr5R1BE0v60E8QlStYQFjv6v4M8SjhgIPk1CEnEoQqDRLxzg63rIS9uqLbnp6utnrEqjx3Y7WUzgqMuoMd87eWZ+82WCuOW/TzUkJ4+SnJf7e81Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=og9I91Di; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2962feec93bso755762fac.1
        for <stable@vger.kernel.org>; Fri, 15 Nov 2024 17:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731719732; x=1732324532; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3QI0B5maEg+/aEXJBItWHclgyMXYLApaat8l+0kJnA=;
        b=og9I91Dir62eotvvSzP8D81HEy2X+v0B/wN/pF1J8N2UjjUOuU8yfCE/UcuRfIVuFp
         4dOeGp4tqK3zzk4bssAs+AE+5t0ZeXAoUaiDhjBYZZVNygm/OV7cNukguADtNUS7KN4+
         j39rzdHDDSFNWOq2oeisZ9vP6QxjO34I7fTkgvol6vhBDrmgoaTUolYIFUiX1ZmV/2u0
         ilJvxM+QaO8upeYwR83Dl2jXJ/2ATdO0NqoDeBO75/OLaK3O2dgDC4zUe1NFfO51ILrh
         PJQxRQnrokNImoBVuD4YBp4nqW5gBPxP1Dj8QkBlPL27jW+DKwT2xHboVr/sVXre2f0g
         ZNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731719732; x=1732324532;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3QI0B5maEg+/aEXJBItWHclgyMXYLApaat8l+0kJnA=;
        b=em78wV4qW5s47Yymytqem4Vmje2QHky5zG5ok3SnidUgeY9Gc4o/0yRJaWDFuSiubl
         MfEOH4R35uGe2hqafVOgiMquRJPwRTj5DJ5XBGcC4iL4RYXE4/GkfygjgCGF1Uz34HhW
         vP6CeBXJ2Kpg7gY38Ks5ZM5fRXQAFkZQM54s6hWzJveHMILlSo3X9eipzbPxZEbYsy2E
         R9QaLxsNvhevrheiXle6wWZdWd4ShZ4E5omVHoZRbLTxUpYJ/G7y12RypOl2aKJi3Osl
         Lr+E0uLE9bzXCx/Q+uRxIRBRTZKu+YxFgZpIKV0bVPZ/tkA7F2GQtoDfVsvLPihjuv4d
         1dfg==
X-Forwarded-Encrypted: i=1; AJvYcCW68/oU57xIQAwQnh1mnMl8vxiMCEPsPaZF0elDjIepK28Ja/2+B8ngCKmL8hOPYzHSEwNIx3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSEJawo2FMpk1+PSk1lz2pV7qtJaj57+cxTfq+hBpDN1xy6/my
	5RvsmuTXysNqga8AE+FTLc5eMx41icsBtnLwGlsmV2xuHSaqmKxOvmZ84XCp3Q==
X-Google-Smtp-Source: AGHT+IFeCD8ZVgWdH34gSgJYIxjLsEKdeBaXUMar4RlXXY3UJD97gcwnL5d0iQyeGaj7c8TVzztT4w==
X-Received: by 2002:a05:6870:50c:b0:288:6644:9c1c with SMTP id 586e51a60fabf-2962dc7dbe7mr4863024fac.6.1731719731855;
        Fri, 15 Nov 2024 17:15:31 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a781a1b5csm980115a34.48.2024.11.15.17.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 17:15:30 -0800 (PST)
Date: Fri, 15 Nov 2024 17:14:43 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: mm-commits@vger.kernel.org, yuzhao@google.com, stable@vger.kernel.org, 
    hughd@google.com, chuck.lever@oracle.com, aha310510@gmail.com
Subject: Re: + mm-revert-mm-shmem-fix-data-race-in-shmem_getattr.patch added
 to mm-hotfixes-unstable branch
In-Reply-To: <20241116010055.48A67C4CECF@smtp.kernel.org>
Message-ID: <313876af-1755-7a86-60a2-678ffcf34bea@google.com>
References: <20241116010055.48A67C4CECF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Nov 2024, Andrew Morton wrote:
> 
> The patch titled
>      Subject: mm: revert "mm: shmem: fix data-race in shmem_getattr()"
> has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
>      mm-revert-mm-shmem-fix-data-race-in-shmem_getattr.patch
> 
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-revert-mm-shmem-fix-data-race-in-shmem_getattr.patch
> 
> This patch will later appear in the mm-hotfixes-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
> 
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
> 
> ------------------------------------------------------
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm: revert "mm: shmem: fix data-race in shmem_getattr()"
> Date: Fri Nov 15 04:57:24 PM PST 2024
> 
> Revert d949d1d14fa2 ("mm: shmem: fix data-race in shmem_getattr()") as
> suggested by Chuck [1].  It is causing deadlocks when accessing tmpfs over
> NFS.
> 
> Link: https://lkml.kernel.org/r/ZzdxKF39VEmXSSyN@tissot.1015granger.net [1]
> Fixes: https://lkml.kernel.org/r/ZzdxKF39VEmXSSyN@tissot.1015granger.net
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Hugh Dickins <hughd@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks Andrew, I was just in the course of preparing the same
to rush to Linus: I'll leave that to you now.

> Cc: Jeongjun Park <aha310510@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/shmem.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- a/mm/shmem.c~mm-revert-mm-shmem-fix-data-race-in-shmem_getattr
> +++ a/mm/shmem.c
> @@ -1166,9 +1166,7 @@ static int shmem_getattr(struct mnt_idma
>  	stat->attributes_mask |= (STATX_ATTR_APPEND |
>  			STATX_ATTR_IMMUTABLE |
>  			STATX_ATTR_NODUMP);
> -	inode_lock_shared(inode);
>  	generic_fillattr(idmap, request_mask, inode, stat);
> -	inode_unlock_shared(inode);
>  
>  	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
>  		stat->blksize = HPAGE_PMD_SIZE;
> _
> 
> Patches currently in -mm which might be from akpm@linux-foundation.org are
> 
> fs-proc-vmcorec-fix-warning-when-config_mmu=n.patch
> mm-revert-mm-shmem-fix-data-race-in-shmem_getattr.patch

