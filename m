Return-Path: <stable+bounces-179659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72789B587DC
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 00:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE48A1896D62
	for <lists+stable@lfdr.de>; Mon, 15 Sep 2025 22:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B02D47EB;
	Mon, 15 Sep 2025 22:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phSRlIB9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1D21A420
	for <stable@vger.kernel.org>; Mon, 15 Sep 2025 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976640; cv=none; b=sM74Y/iU2Ed40HK3RJ6hDrJpLnjqLA7uKHgJRcy/hmZ1WPuyur53iY7aJgB8yeD9YTck85ICEYwKeQ7eS2qWeO0x6ufovVwt0ty+PjzMf2eo54GCFhYwHCiCSHQ4Lnr1sK9eCDNc3OnLzx2lH1pmZkCamHMuTs71FaDel5h+NJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976640; c=relaxed/simple;
	bh=7XUcFdyi5pghNDqYShPZlZf5FW9PbMiBbI2R59AvwA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIHvpnRdvxsefP2ys+MClx2i3KRtInRyAg9SMUpG+Fdrezs9G2mdtrIojIDkW0Z0j+S0VsO36icVpyxXm1Q9ZA/O5KyvuxB3P3a5JbMAMIzjjTX6aA6YkFzqdOJcBgjCzifqQKY5reHkNB3hOc6B2+/KXqIplJHDeFArDUNIoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=phSRlIB9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f59889so48359395ad.0
        for <stable@vger.kernel.org>; Mon, 15 Sep 2025 15:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757976639; x=1758581439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHCYBGzmS+VHS2LiTQcupGZB9njnywXUSm+3JCgstqg=;
        b=phSRlIB9fD4gXp+Zy40KyrcyUiBev4gwgSUoJptNyN5W54FHoZ23Mz+d9Vu0OCsM3t
         uyQxPzacIub4ayA4Hwn0em4TKWiT61s9ZS6WaqT+SU1IVAbP2Gn+Ax6vkEeIaoeBKlmx
         fYDqrhrZ4d2FdeHXhbuCYoDriH8jVi33KHeEpfd2APSj17Yl/pqI0N0e4cNRhkLOZSyG
         Wxy7b3jLenkTY4VnYfmwGXrJ4IThE8axVFewjklCAP9EEpKDfTBBALllHqMYUXaaNbD6
         0T9gE2PKSOhD/33g4cSxPVtaaGCrYTp1xMZ7e2RNDfmhRv2/VO4cFr8c4If8B0PdwbBb
         DHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757976639; x=1758581439;
        h=cc:to:from:subject:message-id:user-agent:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHCYBGzmS+VHS2LiTQcupGZB9njnywXUSm+3JCgstqg=;
        b=ohmsAiumrJiOD0Vqp8geN2NT81/dAoCfL7JQkGCNN0Umsi7Qne1PdAksaft5uFdIlV
         EhdZrueguhabAUg2WfqjFWDfcl+BV0qCDU7qT1OREMsKrmyjRL84RsNqpaBAxP0MNADF
         GKCIkKLUxgOXHHrAo86Wapc+zlq+0AKX9EFk0kstlt5FWzE19iPEFEejGguxlvesp+vV
         CvgkCVlmgq9CZ9vlwzCvsn2o5tP8wpsKLtLrMe+jg9m20P+VJKElZ8RzxRnRndNZ0ITv
         65efZkUC0IxRcSSy7QgY6h6Gs1XHSRIgAnmoeooVBpE6tFZN0bI+WB+I9tX0M9MVvRdv
         DiPw==
X-Forwarded-Encrypted: i=1; AJvYcCV8yB9Ev+Gas3g0cD51UkkdJfURZ1jPUoMpEARowNsGd7gBCZuVKzg430gQRL+Sf9BX14i5+6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dBq+OtB7X144TWHrC5so43xpVV2jr/8Q0lmp7mdVrzAnw+t6
	Ky8MSjr3xKKGA+QOeCJtHM65bA+lcJrU7uYXJFmp1szs29kGBfk7AnZLKkDkMVi5iQOMM3thUiE
	wKTPlJj9z1g==
X-Google-Smtp-Source: AGHT+IE6hbDx6V/jMsnsms/qKiIlFQPmNSNP/cWma2PRVBTnkAUf3QF90DV5CUSA3kwoSWRzABSKSW2f8m9J
X-Received: from pjbsz5.prod.google.com ([2002:a17:90b:2d45:b0:32b:6136:95b9])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c9:b0:267:bd8d:1a0
 with SMTP id d9443c01a7336-267bd8d09dfmr14585835ad.13.1757976638706; Mon, 15
 Sep 2025 15:50:38 -0700 (PDT)
Date: Mon, 15 Sep 2025 15:50:37 -0700
In-Reply-To: <20250915221248.3470154-1-cmllamas@google.com> (Carlos Llamas's
 message of "Mon, 15 Sep 2025 22:12:47 +0000")
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915221248.3470154-1-cmllamas@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8a52vuy82.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [PATCH] binder: fix double-free in dbitmap
From: Tiffany Yang <ynaffit@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?Q?Arve_Hj?= =?utf-8?Q?=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Alice Ryhl <aliceryhl@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Carlos Llamas <cmllamas@google.com> writes:

> A process might fail to allocate a new bitmap when trying to expand its
> proc->dmap. In that case, dbitmap_grow() fails and frees the old bitmap
> via dbitmap_free(). However, the driver calls dbitmap_free() again when
> the same process terminates, leading to a double-free error:

>    ==================================================================
>    BUG: KASAN: double-free in binder_proc_dec_tmpref+0x2e0/0x55c
>    Free of addr ffff00000b7c1420 by task kworker/9:1/209

>    CPU: 9 UID: 0 PID: 209 Comm: kworker/9:1 Not tainted 6.17.0-rc6-dirty  
> #5 PREEMPT
>    Hardware name: linux,dummy-virt (DT)
>    Workqueue: events binder_deferred_func
>    Call trace:
>     kfree+0x164/0x31c
>     binder_proc_dec_tmpref+0x2e0/0x55c
>     binder_deferred_func+0xc24/0x1120
>     process_one_work+0x520/0xba4
>    [...]

>    Allocated by task 448:
>     __kmalloc_noprof+0x178/0x3c0
>     bitmap_zalloc+0x24/0x30
>     binder_open+0x14c/0xc10
>    [...]

>    Freed by task 449:
>     kfree+0x184/0x31c
>     binder_inc_ref_for_node+0xb44/0xe44
>     binder_transaction+0x29b4/0x7fbc
>     binder_thread_write+0x1708/0x442c
>     binder_ioctl+0x1b50/0x2900
>    [...]
>    ==================================================================

> Fix this issue by marking proc->map NULL in dbitmap_free().

> Cc: stable@vger.kernel.org
> Fixes: 15d9da3f818c ("binder: use bitmap for faster descriptor lookup")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>   drivers/android/dbitmap.h | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/drivers/android/dbitmap.h b/drivers/android/dbitmap.h
> index 956f1bd087d1..c7299ce8b374 100644
> --- a/drivers/android/dbitmap.h
> +++ b/drivers/android/dbitmap.h
> @@ -37,6 +37,7 @@ static inline void dbitmap_free(struct dbitmap *dmap)
>   {
>   	dmap->nbits = 0;
>   	kfree(dmap->map);
> +	dmap->map = NULL;
>   }

>   /* Returns the nbits that a dbitmap can shrink to, 0 if not possible. */

Reviewed-by: Tiffany Yang <ynaffit@google.com>

-- 
Tiffany Y. Yang

