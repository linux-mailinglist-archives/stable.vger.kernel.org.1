Return-Path: <stable+bounces-151457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531BBACE4D6
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 21:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC653A9005
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 19:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05420CCE3;
	Wed,  4 Jun 2025 19:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXdPS1SJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89882211C;
	Wed,  4 Jun 2025 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749065675; cv=none; b=b0PmBLpyRCyDilTqvk/T7JX0ax4Qm7CjUpfRqX2PDameFOKkUXCr9N7jXS4/ElN14BRXak5u06RzSxNZ0j/X1MF05m3/Kl5mXvoPfATLJGO9u3bx+UfCKMA7K5oQIGqfi+dmjrpYTgmRdYobc/wdgSEMnkKwIhTXLGNn0Ztyg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749065675; c=relaxed/simple;
	bh=W4orrOyMiTadSUR5NnoL0sMwYLdP2pIVTQQ+ZGq+5b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5UYKBvKZx1+tkC449l2LXtcMb4lZ3uVkhcapCD1z/ajsPe249aa/6r18SpD8SRr0pv2GQ/pmZnTkN+Yxmkb/XyDgfwKUwdNyk5hhhLcP3zQJprb7uTiGXt1+5ie4ZjVMhYM9plej1kgJ2YqSP0aZF0rXkfWPtvnEnjWAUo/1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXdPS1SJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-311f6be42f1so32759a91.0;
        Wed, 04 Jun 2025 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749065673; x=1749670473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPBd84LrS9cSOHyLnSC1TFUVA8656z2E4qXxfvYJEXU=;
        b=UXdPS1SJTGshMLEObHVTAsudNfCIST7H8bWMQDvwslwIOffwwS3TfnfujAmFcGxGKv
         3oXGn5cNknhBbVRbY5ljZUgIm9ublqd8O4Mb5ba6Y6hfFb/7BxvVC0ix9t9d8WEg3ktm
         47/ncx3L/4tLXfRZ0FHxuT8d3xUIjZ2QUQva6PeRHl8aMAEqp+CjD/dy3zSYmUpuN1MY
         BIv9fS65s3oXRLlq2Wt47HL5DelRrtEeXmMaALqBzFdJbufdu4E7fZAJ7kAF6VB9j5Be
         nLQydEO7X4ru1GqJJOuJJzyIB2uDs7Uqf/2ZECh0PdEeo5vpJBHUjg4Sg+lwF1XBl0Cj
         tsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749065673; x=1749670473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPBd84LrS9cSOHyLnSC1TFUVA8656z2E4qXxfvYJEXU=;
        b=e7Uvx5735cdJN44ad32BPZ+COhJarTTTkBuQv3AHTTs7+HpGTQfwQEB9mHff7/itpC
         Bf8r2hEjak7VERNv9+nTRhpehaa0FMPctRXqf0HcMkGvxI8e9dPdcgGKyRbzehDa3cvi
         eJOyjljyh21lLze6QMJ9DPdasAE1Hb3IK0pXqtmme0xgxZR/FfTLshIrHu0ikn9Wc9L/
         TFdl5VFeZKMQds7XaJKgYS94UzcJHjVuAynzB+qe+eXVENaO4Cind7kALjHSHhpqGUOM
         uYNHdiPsmunlL6wNZsgjNBAk9s9cdGM3o1FuikzKtXS+mWVEKeXq47rRdPhxe3ynzJ5O
         wpjA==
X-Forwarded-Encrypted: i=1; AJvYcCU3+ny2UnBL016TBSV3P0/00lML6q2DOT8BN+kLU19bEEAEzA+TOeH8Fhr60oIa0dB3dSbX0l6b@vger.kernel.org, AJvYcCUYe0HBLHrprx0vYWZdpACK2v//Ym+2pJOmFw09taRZZtUhPipmIPlJB2QiDlUmgUXl160h+nc5iBRFdME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzm/wqp6CTUj2ltj4lVYgbUZp1SCJUaGdZySJIq9Sr05putKx
	4H2ijNpuC7dOxmk9LiHyW4yNDO1l/FiJYHhfZHZZ6wZpTxmO1IS+c8GuJ2/Xdc8KaiqwnyB5CsF
	suh86T8DYdvkPOJhJ/RJlIUKy35DxMww=
X-Gm-Gg: ASbGnctZxhiXPZTW3mpDpc3FCBeIXkSWIbc4nxGDp46SDJOUtZq5x0wYhkWcn3STK4J
	doHT6/6RzHh5TmV1+FjbSYnjcZ92yPfaSViZ7qqZ/zvuwY8clsjbIIMuTj/DMyZ1x3/ICfxSMlB
	eGO/Isp+oJiwiqUA84QFbjdde53pzs85G4ag==
X-Google-Smtp-Source: AGHT+IFN+KwGSw/GBFnrkHH8eKCuRlKYuIQM6biFeRyaeQWEXfpgRodSPrJcuJPA1CyPGvOWxGac+vuNl0YL06MHrDQ=
X-Received: by 2002:a17:90b:38c7:b0:312:e76f:520f with SMTP id
 98e67ed59e1d1-3130cd862eamr2170101a91.8.1749065672724; Wed, 04 Jun 2025
 12:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524055546.1001268-1-sdl@nppct.ru> <CADnq5_MyV_C-XJCQEiXKLQhhEGErq7SnvhqFE1AauQPJvt5aYw@mail.gmail.com>
 <bee381b3-305b-46e5-ae59-d816c491fce5@nppct.ru>
In-Reply-To: <bee381b3-305b-46e5-ae59-d816c491fce5@nppct.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Jun 2025 15:34:21 -0400
X-Gm-Features: AX0GCFub-bzEnLI8mXirUWoNvHzDhPws1qxQCINmsU6eXeWdNUBSVW7dtrkmElc
Message-ID: <CADnq5_P-1xGEjJpe--HFFQUaz9A=AO7mQwTXNCZJ693UgdaW0w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL dereference in gfx_v9_0_kcq() and kiq_init_queue()
To: SDL <sdl@nppct.ru>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri <sunil.khatri@amd.com>, 
	Vitaly Prosyak <vitaly.prosyak@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>, 
	Yang Wang <kevinyang.wang@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 3:30=E2=80=AFPM SDL <sdl@nppct.ru> wrote:
>
>
> > On Sat, May 24, 2025 at 2:14=E2=80=AFAM Alexey Nepomnyashih <sdl@nppct.=
ru> wrote:
> >> A potential NULL pointer dereference may occur when accessing
> >> tmp_mqd->cp_hqd_pq_control without verifying that tmp_mqd is non-NULL.
> >> This may happen if mqd_backup[mqd_idx] is unexpectedly NULL.
> >>
> >> Although a NULL check for mqd_backup[mqd_idx] existed previously, it w=
as
> >> moved to a position after the dereference in a recent commit, which
> >> renders it ineffective.
> > I don't think it's possible for mqd_backup to be NULL at this point.
> > We would have failed earlier in init if the mqd backup allocation
> > failed.
> >
> > Alex
> In scenarios such as GPU reset or power management resume, there is no
> strict
> guarantee that amdgpu_gfx_mqd_sw_init() (via ->sw_init()) is invoked befo=
re
> gfx_v9_0_kiq_init_queue(). As a result, mqd_backup[] may remain
> uninitialized,
> and dereferencing it without a NULL check can lead to a crash.
>
> Most other uses of mqd_backup[] in the driver explicitly check for NULL,
> indicating that uninitialized entries are an expected condition and
> should be handled
> accordingly.

sw_init() is only called once at driver load time.  everything is
allocated at that point.  If that fails, the driver would not have
loaded in the first place.  I don't think it's possible for it to be
NULL.

Alex

>
> Alexey

