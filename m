Return-Path: <stable+bounces-116803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140AA3A1EF
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 17:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B796618956EA
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DF126E166;
	Tue, 18 Feb 2025 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jPAEgRRb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7926B2CA
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894401; cv=none; b=uFwQKjIb99F04XFfxuqtDNVw9WpIJMDko+q9YCDYLRJGAfjqYw3gjSbnzz+IkAZAzEhFlZ2rQvs/wyXZFgg0qvnozFL38YFX+3vpE5r54mIw98uL2dNHt8oz0a3Z9LQWLLRIIlbH09BB4w73ZHseSDjy8710JZ8eZ+7Rb0dmLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894401; c=relaxed/simple;
	bh=Mvl7ic5dPpSRE8noQA3vk5gO41+lpdjD2i1WOU8u4S8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/yGGw7rocB0fNfBJift2rVqZzdzZubITHLqimg6Ul8kAagHogGmkUmaFhL/wIJ97kXPj0TBrrjuXVDKBv+xHg0b6HNqsT0OA6mfgbzoKZy13hjTRNz1MUXPumVmkcKVj+DOjNFfl6Kp2NjpHn1JfJeUz5nYBSUTgy7ac41MF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jPAEgRRb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739894399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdK+/rE3JwumocpP/mzS1PNgFFKgHQR3OqAuIDrsFUQ=;
	b=jPAEgRRbHc5OnDjOTILtv9HbdpsZ638R7zjDN4anMrQZoU9BwbewxP86YHjDTJctrLK/Ne
	LvhwjiImhQWne+ev/4TmIBUTiZ1tfypG8IXwWg4mbShJ+avMW35ZeBBDVkxxvH9ckTT9PH
	WWQC/PVJGLu7MLUtyzXA6LAYDCrs0EY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-F9mN0DpxPtWJasQKs7Vlsg-1; Tue, 18 Feb 2025 10:59:57 -0500
X-MC-Unique: F9mN0DpxPtWJasQKs7Vlsg-1
X-Mimecast-MFC-AGG-ID: F9mN0DpxPtWJasQKs7Vlsg_1739894396
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5428d385b93so4506048e87.3
        for <stable@vger.kernel.org>; Tue, 18 Feb 2025 07:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894394; x=1740499194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdK+/rE3JwumocpP/mzS1PNgFFKgHQR3OqAuIDrsFUQ=;
        b=kpT/5jMGEwwKn3md2H4nrJfxg17H3g313ZMi9v5moSvjGct9hX/+LcsxGFTW5S/Xrf
         9tGj4tO5Xy1GvHxLb6FsNbC5iFS5p3dv3h2vguGw4TGTNqzDkYAflHBZzFUAaqjg5PQs
         92T5tn2MOAj+7K0bIrUUKFKzG8BTInwLs8/FccUE0X6UhY3C/BgesIh2c/YgsosSKqht
         0bZ+keNdZW9kxWcXkVovbCdBrRX6F2xH7xVlMgYJgPMqTRiZLKx7VSOzvzre59bwSPnz
         uReZbUjcugTo5JizkVvcYxExysuTMbZxKzbS5pkRtBqp19dajwg8Om6ZItfp7eWHqzMs
         oHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2lolauO2YHB68xl83u8HUSnhvlcXqwl3voCZkj38dB7wVe+08Ojcyj8tcmhG3FxgQf/MWcuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/cbJynuQ1IJZThr8zI3+6eUwCNHzdFnF3dpG7NHTZ9u0Zzodk
	gScQt9qRqsIuXcS4g15Ayv9oLpp5rytNuMa6AjnmyHt+FB+OaQdkS7VdAcDsYkVVoQObd38G7Az
	om2gmBJLELdA8APn9iyf89Cshpr+Dl7MVv9Oa3l4Zc0wifCM/WKZ9PvEOvIY3/tvOOV4vHVgb8X
	RpkavJ4s5J2P3YaQtwe6zts96bveT7f3n89T7UF10=
X-Gm-Gg: ASbGncuXgC7Cd0Rh2ONMgvh/hzYl5EqnIMLiY8MZeHzCzPmd6X5QQxlV1Iwq9+THhYt
	C9kZDRcBY4uypYYl29jIU6ocM38iuepPxtAQ7YsAShN+0eMto1kvh1Ugr3J7qQWZRwS9c9FzRXR
	Qji3v3kAd6EI2WzNLuk+gm
X-Received: by 2002:a05:6512:3b0b:b0:542:29b6:9c26 with SMTP id 2adb3069b0e04-5452fe95c7emr4606393e87.47.1739894394404;
        Tue, 18 Feb 2025 07:59:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBb0yq+4f6s5Sjr2aV/KNL83K+YN+sQCk29CCpaTPWAPEY56fYN18mEC7HDlcDPxujSbCLAzTElagpq1FzCDA=
X-Received: by 2002:a05:6512:3b0b:b0:542:29b6:9c26 with SMTP id
 2adb3069b0e04-5452fe95c7emr4606375e87.47.1739894393947; Tue, 18 Feb 2025
 07:59:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6h+hfg4RcwuNUDspMrEt+5Gk5hBhE-pfLTF29M9qJLiYtoAQ@mail.gmail.com>
In-Reply-To: <CAH6h+hfg4RcwuNUDspMrEt+5Gk5hBhE-pfLTF29M9qJLiYtoAQ@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 18 Feb 2025 10:59:42 -0500
X-Gm-Features: AWEUYZm-SDkJSuPB0C5J5-VjqoPv0BqzgQ2Z1uuB38lA4PNrFVJTDn8z1jFhx3Y
Message-ID: <CAK-6q+j9QcZmJuJ+5igge8-Y2_1-JPuA6dvqkzJ5Lt+9=P=ndQ@mail.gmail.com>
Subject: Re: Linux 5.4.x DLM Regression
To: Marc Smith <msmith626@gmail.com>
Cc: jakobkoschel@gmail.com, stable@vger.kernel.org, teigland@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 17, 2025 at 2:24=E2=80=AFPM Marc Smith <msmith626@gmail.com> wr=
ote:
>
> Hi,
>
> I noticed there appears to be a regression in DLM (fs/dlm/) when
> moving from Linux 5.4.229 to 5.4.288; I get a kernel panic when using
> dlm_ls_lockx() (DLM user) with a timeout >0, and the panic occurs when
> the timeout is reached (eg, attempting to take a lock on a resource
> that is already locked); the host where the timeout occurs is the one
> that panics:
> ...
> [  187.976007]
>                DLM:  Assertion failed on line 1239 of file fs/dlm/lock.c
>                DLM:  assertion:  "!lkb->lkb_status"
>                DLM:  time =3D 4294853632
> [  187.976009] lkb: nodeid 2 id 1 remid 2 exflags 40000 flags 800001
> sts 1 rq 5 gr -1 wait_type 4 wait_nodeid 2 seq 0
> [  187.976009]
> [  187.976010] Kernel panic - not syncing: DLM:  Record message above
> and reboot.
> [  187.976099] CPU: 9 PID: 7409 Comm: dlm_scand Kdump: loaded Tainted:
> P           OE     5.4.288-esos.prod #1
> [  187.976195] Hardware name: Quantum H2012/H12SSW-NT, BIOS
> T20201009143356 10/09/2020
> [  187.976282] Call Trace:
> [  187.976356]  dump_stack+0x50/0x63
> [  187.976429]  panic+0x10c/0x2e3
> [  187.976501]  kill_lkb+0x51/0x52
> [  187.976570]  kref_put+0x16/0x2f
> [  187.976638]  __put_lkb+0x2f/0x95
> [  187.976707]  dlm_scan_timeout+0x18b/0x19c
> [  187.976779]  ? dlm_uevent+0x19/0x19
> [  187.976848]  dlm_scand+0x94/0xd1
> [  187.976920]  kthread+0xe4/0xe9
> [  187.976988]  ? kthread_flush_worker+0x70/0x70
> [  187.977062]  ret_from_fork+0x35/0x40
> ...
>
> I examined the commits for fs/dlm/ between 5.4.229 and 5.4.288 and
> this is the offender:
> dlm: replace usage of found with dedicated list iterator variable
> [ Upstream commit dc1acd5c94699389a9ed023e94dd860c846ea1f6 ]
>
> Specifically, the change highlighted below in this hunk for
> dlm_scan_timeout() in fs/dlm/lock.c:
> @@ -1867,27 +1867,28 @@ void dlm_scan_timeout(struct dlm_ls *ls)
>                 do_cancel =3D 0;
>                 do_warn =3D 0;
>                 mutex_lock(&ls->ls_timeout_mutex);
> -               list_for_each_entry(lkb, &ls->ls_timeout, lkb_time_list) =
{
> +               list_for_each_entry(iter, &ls->ls_timeout, lkb_time_list)=
 {
>
>                         wait_us =3D ktime_to_us(ktime_sub(ktime_get(),
> -                                                       lkb->lkb_timestam=
p));
> +                                                       iter->lkb_timesta=
mp));
>
> -                       if ((lkb->lkb_exflags & DLM_LKF_TIMEOUT) &&
> -                           wait_us >=3D (lkb->lkb_timeout_cs * 10000))
> +                       if ((iter->lkb_exflags & DLM_LKF_TIMEOUT) &&
> +                           wait_us >=3D (iter->lkb_timeout_cs * 10000))
>                                 do_cancel =3D 1;
>
> -                       if ((lkb->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
> +                       if ((iter->lkb_flags & DLM_IFL_WATCH_TIMEWARN) &&
>                             wait_us >=3D dlm_config.ci_timewarn_cs * 1000=
0)
>                                 do_warn =3D 1;
>
>                         if (!do_cancel && !do_warn)
>                                 continue;
> -                       hold_lkb(lkb);
> +                       hold_lkb(iter);
> +                       lkb =3D iter;
>                         break;
>                 }
>                 mutex_unlock(&ls->ls_timeout_mutex);
>
> -               if (!do_cancel && !do_warn)
> +               if (!lkb)
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                         break;
>
>                 r =3D lkb->lkb_resource;
>
> Reverting this single line change resolves the kernel panic:
> $ diff -Naur fs/dlm/lock.c{.orig,}
> --- fs/dlm/lock.c.orig  2024-12-19 12:05:05.000000000 -0500
> +++ fs/dlm/lock.c       2025-02-16 21:21:42.544181390 -0500
> @@ -1888,7 +1888,7 @@
>                 }
>                 mutex_unlock(&ls->ls_timeout_mutex);
>
> -               if (!lkb)
> +               if (!do_cancel && !do_warn)
>                         break;
>
>                 r =3D lkb->lkb_resource;
>
> It appears this same "dlm: replace usage of found with dedicated list
> iterator variable" commit was pulled into other stable branches as
> well, and I don't see any fix in the latest 5.4.x patch release
> (5.4.290).
>

This works, or just init the lkb back to NULL there:

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 1899bb266e2e..7e02e5b55965 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1893,6 +1893,7 @@ void dlm_scan_timeout(struct dlm_ls *ls)
                if (dlm_locking_stopped(ls))
                        break;

+               lkb =3D NULL;
                do_cancel =3D 0;
                do_warn =3D 0;
                mutex_lock(&ls->ls_timeout_mutex);

Can you provide more details about the use case of timeout? Are you
using DLM in user space or kernel?

- Alex


