Return-Path: <stable+bounces-107774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB37FA0339F
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 00:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4AA1645FA
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 23:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A271A1E1A17;
	Mon,  6 Jan 2025 23:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ULLEVS3G"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADC1DFE00
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 23:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207698; cv=none; b=rpu7ZVqGE654sQsy3Ozt9VcL2Vc8k8WTuNgpSsIyJatvb/kbQmzFnhbND4zN1tZMwQFQg5W8jskBAaMgbJklwQR6zWuUcWtgA1NeaMKXhN3zs96/A6LE5Sph0AglB9omp0JXkqIbOJ+dlF3hYR7f+QtXpKndvZXFPOl8cKNATQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207698; c=relaxed/simple;
	bh=lYtw4e3oxHoPH0Z8dSFP/LJXRhBJ8mN15kdc7Gvm6kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rh3sjxetHCgBzttCLsL0XXPSF0I9c2bVDIyUOXA0xgIfgZk2D0T4jS/sPNq+RMbsyOK7rRc7HFXFx5BHoZY0qQRqqkuRg5/sDeUMdOh1xMdKHsYVAMbsqoexjYPa+CYlbJ2J/+h7yyqniO+uIuz8P81yvDPBt7T+vI4nkSsOdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ULLEVS3G; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6df83fd01cbso7347246d6.2
        for <stable@vger.kernel.org>; Mon, 06 Jan 2025 15:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736207696; x=1736812496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYtw4e3oxHoPH0Z8dSFP/LJXRhBJ8mN15kdc7Gvm6kM=;
        b=ULLEVS3GuU4w5VuElo4w48OiU8UzXupsRMb46grw2WxCn1nfAWnLdUQ/OL4kDLXhyr
         7oXUkvLGUWqzJM5CFaFbtlntXaLounNrbr8bbiIkpKH5vUrqwOA1Sr4rUzJQW1aXFnd8
         z6Tlq5tMjPCiuQu/UToz51YlFnP+/3mHksYYisMDseF/lIg96rFkkDvISAq8+ousb/T0
         gS7lMoSSuTxjgSEdPGtVi1BYoPYA54vSCEdOf8/juV6YBwaSoe0kVTgFNki25ltElCts
         cAdIRVykRGcVCe01JDRmSfFM3QCwo8aEUWNggtJk9NGxmRq5mVnfoU1rBPItQF7OIcnb
         c+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736207696; x=1736812496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYtw4e3oxHoPH0Z8dSFP/LJXRhBJ8mN15kdc7Gvm6kM=;
        b=O6juOnFQrMwj2KkrzQPdVDMXtLuaq0qBX64uOTvBDF9rKMfJz2LkyDkcocVvZug5lp
         0JdYCN4ULH7wBKJn7HZPE+l4hBnPX951s+kjGxCqp7CkVO3/UV0Gzeqarn4RTHF7i43x
         PrKtqDVG9IaSWrt+zeiA210ngv+lE42hwMbHGy4++Gp8QTzO29pi3UO+UZcgWYIPwZpU
         ELxmJsjLjlgTv3bAhEctzn1F0jU/nlcTTtskVr0us9/4MKJ0HVMP6lEnPDsGgnucm6PF
         KYdXy1BrjG6AKJ2VA/3az/6DOpDFFft2Qy+jk6Voc5l4ewafYGXWC03NQDxV0HPTAmDO
         iJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWmeYj/xKPp9Vk9QNIACwmPpppkVTNE1CXWvfZDgz87WdPL4kLZmLBNjAxCZR6xOE/GtfgfHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFg1yroNX/kvjKF6KJCjsznHzb96GptS9aQBtV88JWT8jomQsY
	h5eTbK1DxKECvgvvYHcpAq5jIvk/6x/5JmSE3xzVvtDliTdjmui1n4vlHF/9buKL+2P/Ux0S8A7
	qAP8/HQIVFY9GJ/r9Bg9PVfOSWHzhwEq4QTq8
X-Gm-Gg: ASbGncs52yiBowrd9JiQ3/qIQb74wcwwPT5q8dbIOSicgY/3kAlvFS1bfew1GTgWHbx
	aT3maT9PF9CUTqBtibT2K54mCSjOuK07QcIU=
X-Google-Smtp-Source: AGHT+IH9OXJXVERGLy76PvOv8RawCzz76EhtU9S/RviMSJSTen6h1jrO7F+9EzljZJzL+BcoAqzat7r2nJADucFuS4Q=
X-Received: by 2002:a05:6214:509e:b0:6d8:9815:92e2 with SMTP id
 6a1803df08f44-6dd2332c084mr886951456d6.15.1736207695619; Mon, 06 Jan 2025
 15:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106235248.1501064-1-yosryahmed@google.com>
In-Reply-To: <20250106235248.1501064-1-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 6 Jan 2025 15:54:19 -0800
X-Gm-Features: AbW1kvblckIr7Dc_6HIgtQvzHnRRe1pEWEzG3zESYzeCBOWvVh0z-meS4iZM5Lo
Message-ID: <CAJD7tkaeLYWENDqt0UQWNNgbi7qf-tBkfJFUY-ofC4-q1wvrxg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix race between [de]compression and CPU hotunplug
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 3:52=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> In zswap_compress() and zswap_decompress(), the per-CPU acomp_ctx of the
> current CPU at the beginning of the operation is retrieved and used
> throughout. However, since neither preemption nor migration are
> disabled, it is possible that the operation continues on a different
> CPU.
>
> If the original CPU is hotunplugged while the acomp_ctx is still in use,
> we run into a UAF bug as the resources attached to the acomp_ctx are
> freed during hotunplug in zswap_cpu_comp_dead().
>
> The problem was introduced in commit 1ec3b5fe6eec ("mm/zswap: move to
> use crypto_acomp API for hardware acceleration") when the switch to the
> crypto_acomp API was made. Prior to that, the per-CPU crypto_comp was
> retrieved using get_cpu_ptr() which disables preemption and makes sure
> the CPU cannot go away from under us. Preemption cannot be disabled with
> the crypto_acomp API as a sleepable context is needed.
>
> Commit 8ba2f844f050 ("mm/zswap: change per-cpu mutex and buffer to
> per-acomp_ctx") increased the UAF surface area by making the per-CPU
> buffers dynamic, adding yet another resource that can be freed from
> under zswap compression/decompression by CPU hotunplug.
>
> There are a few ways to fix this:
> (a) Add a refcount for acomp_ctx.
> (b) Disable migration while using the per-CPU acomp_ctx.
> (c) Disable CPU hotunplug while using the per-CPU acomp_ctx by holding
> the CPUs read lock.
>
> Implement (c) since it's simpler than (a), and (b) involves using
> migrate_disable() which is apparently undesired (see huge comment in
> include/linux/preempt.h).
>
> Fixes: 1ec3b5fe6eec ("mm/zswap: move to use crypto_acomp API for hardware=
 acceleration")
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Closes: https://lore.kernel.org/lkml/20241113213007.GB1564047@cmpxchg.org=
/
> Reported-by: Sam Sun <samsun1006219@gmail.com>
> Closes: https://lore.kernel.org/lkml/CAEkJfYMtSdM5HceNsXUDf5haghD5+o2e7Qv=
4OcuruL4tPg6OaQ@mail.gmail.com/
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

This email was sent out by mistake, this patch is already merged,
please ignore it.

