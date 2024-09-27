Return-Path: <stable+bounces-77849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09156987C40
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 02:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870B91F23DFE
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 00:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525761A716;
	Fri, 27 Sep 2024 00:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNahcbm1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFBEAF9
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 00:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727398370; cv=none; b=iIdeYhuRb7tyvwgcfbaGldnk1Jel09GkC8nsnw5GygRbm0eSNN9XmtZR2TepGnjH4hmp7ORg2u+vrvhASoplkJLJNDOWBk8gxq2aQvikFLdrT5deiL2s3BmR8M/9XNB3pbjUMcXrxUhT7uo4M2BZHQIEMtlWEOEypVCdiN/4COA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727398370; c=relaxed/simple;
	bh=ABo6k289jNNsFJ9xMIfIFq87pYa3BabTVf65BdTRlAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FFiVUPQV/TfM2P6bIV5NPIfK3vUSRLi5EZpuXXdboi+dtPFbe4c4xT6QU5+iyMHC43+zIS0lVDq/vWQvRWVsv5rkHvLwhNp7W5/GrOM/+soRr4l7lGh4zn2YI37mq/dsng7qEMHAGURooS6TLnvw4j5gUVVeAcwM9MbjM+AJNp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CNahcbm1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2055a3f80a4so10365965ad.2
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 17:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727398368; x=1728003168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2BFYarhgRf0zu2BuaAdlMSqHmTWWtiMCN3pwrNhzMs=;
        b=CNahcbm1aQP/Mdlw4gJaMPHiDg9E3lEmIe7qiMPlUIP/eRvyA+DbR7N29xV6GP940C
         Lz8qZ04ue//636VyH+P+1cXGQXT11pcmpvCwWSWwF0px9zUf1J54HKkd0Z/00lWS0yqR
         yxaEaxZ3o+U8kgJ4bnzXXKBtWVUxP2K61bBl43QtXL/wQIDKmVvJN+dZlguj4PXidXxi
         TX/iZoCKpKUt6f/xr5kGbodepooBiTVgxneaMkiutQMvxbPAEHgeSYC1CQNV2+tjOkjT
         IhVFHAEJrkeSNSI1DjwPCk7c0z30AVkDMulUL9xV99Q+7BxushIjYQx31u1dyvJyaoUd
         mIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727398368; x=1728003168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2BFYarhgRf0zu2BuaAdlMSqHmTWWtiMCN3pwrNhzMs=;
        b=nimvJHKEomca075+Hr6A73GFxAt9ouHUP9eEmU4l6LI538YvJRAvhylmhzTCfbGuyg
         +yXUHAMhVEpHdqRE2oyFucXF1whRxfx3gbk2XD+C4ofSazUcmg8hp5mqSch7T6BgajOR
         g6aLZ6Rie4z8ylVd7dm/yaOuggrOcSGf/Uw5D8r+b1wvnP3lAgaJUdiH1aifOYlUmEP7
         xs8iVli5MAW3nW5F/oIZRRdIIFWmkZT7ZkL2HHA57SQ7uhlPFVkfleYm6pkUu1YmAC2A
         H5ygSfZ0T8KDUiBsqpRl5qtwx7gg7xQmUdMsx0x9f2PGXfARDEGeixNsmDtfIiuvWoz8
         QorQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOgLg1g5vLZt5MY1Lp28NnIc4U5RhKFGY6ODSchMOS+L/bXI1JoZGp2wRKMoZrYG51b38nCFo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4+uZJvqPaxuwcmLvCVdQoLda2XudaHNcQzkeEU/oCBVFTlFkt
	wNh5Q7/wlgvip0kCv4JCGO595PF3hkVw2SBMPm5mC45TpzKMtuxr4ioFBFkBK1+CDbKzy1Y03fz
	aTqwVo3wa1s7uxvWpiijSaA10Zqj8nwCFofuP
X-Google-Smtp-Source: AGHT+IEnXLT0Lk7Z0ep5XjORp0FoL1PI+DPCwgW5N4VuPF9o2dzrs/ywINaKzRuQT5yJi1q8kLc82N8Axx16oxHUGbo=
X-Received: by 2002:a17:90b:216:b0:2e0:7a1e:1434 with SMTP id
 98e67ed59e1d1-2e0b89eb53emr1921746a91.13.1727398367432; Thu, 26 Sep 2024
 17:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com> <20240926233632.821189-8-cmllamas@google.com>
In-Reply-To: <20240926233632.821189-8-cmllamas@google.com>
From: Todd Kjos <tkjos@google.com>
Date: Thu, 26 Sep 2024 17:52:33 -0700
Message-ID: <CAHRSSExu+e-2-fSPCeza7ePCNrRO68HMXO2xREFNqesqLf3E9w@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] binder: fix memleak of proc->delivered_freeze
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yu-Ting Tseng <yutingtseng@google.com>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:37=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> If a freeze notification is cleared with BC_CLEAR_FREEZE_NOTIFICATION
> before calling binder_freeze_notification_done(), then it is detached
> from its reference (e.g. ref->freeze) but the work remains queued in
> proc->delivered_freeze. This leads to a memory leak when the process
> exits as any pending entries in proc->delivered_freeze are not freed:
>
>   unreferenced object 0xffff38e8cfa36180 (size 64):
>     comm "binder-util", pid 655, jiffies 4294936641
>     hex dump (first 32 bytes):
>       b8 e9 9e c8 e8 38 ff ff b8 e9 9e c8 e8 38 ff ff  .....8.......8..
>       0b 00 00 00 00 00 00 00 3c 1f 4b 00 00 00 00 00  ........<.K.....
>     backtrace (crc 95983b32):
>       [<000000000d0582cf>] kmemleak_alloc+0x34/0x40
>       [<000000009c99a513>] __kmalloc_cache_noprof+0x208/0x280
>       [<00000000313b1704>] binder_thread_write+0xdec/0x439c
>       [<000000000cbd33bb>] binder_ioctl+0x1b68/0x22cc
>       [<000000002bbedeeb>] __arm64_sys_ioctl+0x124/0x190
>       [<00000000b439adee>] invoke_syscall+0x6c/0x254
>       [<00000000173558fc>] el0_svc_common.constprop.0+0xac/0x230
>       [<0000000084f72311>] do_el0_svc+0x40/0x58
>       [<000000008b872457>] el0_svc+0x38/0x78
>       [<00000000ee778653>] el0t_64_sync_handler+0x120/0x12c
>       [<00000000a8ec61bf>] el0t_64_sync+0x190/0x194
>
> This patch fixes the leak by ensuring that any pending entries in
> proc->delivered_freeze are freed during binder_deferred_release().
>
> Fixes: d579b04a52a1 ("binder: frozen notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 415fc9759249..7c09b5e38e32 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5155,6 +5155,16 @@ static void binder_release_work(struct binder_proc=
 *proc,
>                 } break;
>                 case BINDER_WORK_NODE:
>                         break;
> +               case BINDER_WORK_CLEAR_FREEZE_NOTIFICATION: {
> +                       struct binder_ref_freeze *freeze;
> +
> +                       freeze =3D container_of(w, struct binder_ref_free=
ze, work);
> +                       binder_debug(BINDER_DEBUG_DEAD_TRANSACTION,
> +                                    "undelivered freeze notification, %0=
16llx\n",
> +                                    (u64)freeze->cookie);
> +                       kfree(freeze);
> +                       binder_stats_deleted(BINDER_STAT_FREEZE);
> +               } break;
>                 default:
>                         pr_err("unexpected work type, %d, not freed\n",
>                                wtype);
> @@ -6273,6 +6283,7 @@ static void binder_deferred_release(struct binder_p=
roc *proc)
>
>         binder_release_work(proc, &proc->todo);
>         binder_release_work(proc, &proc->delivered_death);
> +       binder_release_work(proc, &proc->delivered_freeze);
>
>         binder_debug(BINDER_DEBUG_OPEN_CLOSE,
>                      "%s: %d threads %d, nodes %d (ref %d), refs %d, acti=
ve transactions %d\n",
> --
> 2.46.1.824.gd892dcdcdd-goog
>

