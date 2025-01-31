Return-Path: <stable+bounces-111858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9C6A245B2
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 00:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE4716789D
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 23:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E702B1ACECA;
	Fri, 31 Jan 2025 23:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8L0L/Ht"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3151487C1
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 23:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738367061; cv=none; b=LVpNnvMN7EmYdlmEQEqx0KK/RqMLG2wmhaanNXSc0MXMVSRfGnI4iFFtPlOMaJZ7R8hwcA1rya7QBJtdjzSxzpu0uLF5FiTK2mXg8Gm3zFtZCb49pt0wX0xFctyS+/9Z5s/Cf0GWmXddsrz8vEwYnMgMSQSRzQo/DKQM0sDhuKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738367061; c=relaxed/simple;
	bh=MNDBfRL/eKfFTV8ayMvmyywbi/RS9thhBfUfphrXElM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzEhfb6VeW3str4e/GEbq83C0kUhurAHsO0XeQ3fZ6aX1j3Ed7A4Ox6pkgCn8Lz5Xom29ICYQbVudj/zIS/wvJtFBUf7BQngYXtxek5W/mVZ4KR/ycv29X6WRsTElUycmReZpVmi0uEi/7PItx+m+v0RDM5bTbfYrv3mVIolXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c8L0L/Ht; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46785fbb949so30326551cf.3
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 15:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738367059; x=1738971859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hruV8r4KqKqlbIpKYAqOXKO+RL4w+uvzGoOm6KbgBNA=;
        b=c8L0L/Ht+/A1O2/ytA/32s7nOvWmP2WKLw9Inja7HaS/5gHjtcXr5RdOjyl0DfM8xA
         4OHIRuaX6hAKXex/hzr5ZNFeq7Vfxr4rhETneN/sC2crcUi0AvGuWSLjGU1RBDZr+aBi
         YwWpS397C821av3RkjVKcUjnBkr8WSnNIahB2WTLpeEtyzE/SMckVpU4HFf5KeMv+RwK
         2/eEFGlH5Kc9IjfbtXv5IiFubCZDV+I/E0Igyw0U+b0BQBya7b0xC2liy/J99eArJ5Hq
         A/NnXFAHVWXIdQJc+amebokPzfEEr5tGEvX8/UQ8koi8IgJOqvFvVNBpBoofHO7Eb3Fh
         Q2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738367059; x=1738971859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hruV8r4KqKqlbIpKYAqOXKO+RL4w+uvzGoOm6KbgBNA=;
        b=FkZbPi/uwPnEp/om5JcGEO4Nj0CIZ0vhYPYiOHsqTmG9YEEKR/++tRPDJbSMcnRdHp
         r8odfVLl9Sxjk79amktwm3IItdrWy7kr9QBzSfd6MY3F4X2riNMYd9YeRfkEYpPAvX5J
         h9AT4OIsKTbid95EoUwshg4eXY3ECHacy0cVcq15gJttQhX5uWxA2VEZ0SHBaZKaU7lZ
         eFF8YqNKzcpCEVUCUDoUES5I5DHwqtcVmuuYiVhPBuu51b52QqYT7ayGDVFDtf+BhRHX
         DY6Lj/RwPCT2y3/ZtJlvz8OkbDJ1iQZK5T2W43fhvhcjnC05VoY+XYcejXHfR8NNKY5Y
         4zlg==
X-Forwarded-Encrypted: i=1; AJvYcCUHsEG1Tzz87OKzTpUdmyI4ZyDFbRgS1xQtvbT6Bzbo05yRBG9/W7f2XkySiIcr9TQbPE1VKT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymum661GHGLddeOzDcreHWgZFGalmrLOxNt3YXA/Z1Rt6IIi7R
	y6Fmpkgl1gDTiIXvLEtLbKx8VpHSEiAOj0S4x2LGzV8a2JhrhWb4boisfG/lPbQu9hp1OdbV86U
	ij2edoLFt6VjEx+dqnkPUcJKHwF4=
X-Gm-Gg: ASbGncv7zc1H7Gxy3s3HvHh9rEx+SBgjL5OuVaG33F1wab36DIYm1zbIvvS4ycMCy29
	yEuhcS88uzmaoBi3hX0fxTcvJph23zVzYdY+RccrxCyceVtROfaH5GGEbLxzfFD10vt49uNsjO5
	2wEV8o+fyUZ6+Rv9sMMD7mRV5ipfM0
X-Google-Smtp-Source: AGHT+IGAsc0JN4VwF0r+ktDNCByNAHmG2hd8g7DaGhmeM6hxVH9AP7B8UW4A/jIbOLMp/ZclcnVBITkJWEVnMSDqd3c=
X-Received: by 2002:ad4:4ee4:0:b0:6d8:a258:68bb with SMTP id
 6a1803df08f44-6e243bef460mr164175976d6.6.1738367058780; Fri, 31 Jan 2025
 15:44:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129100844.2935-1-42.hyeyoo@gmail.com>
In-Reply-To: <20250129100844.2935-1-42.hyeyoo@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 31 Jan 2025 15:44:07 -0800
X-Gm-Features: AWEUYZlV2xA5T9P0sj9Qh_YGdaZpOrvnu3pLSl5adtsX0Te_61WaLLXLDqogQwU
Message-ID: <CAKEwX=MtF5SLx5kPhYOmjexgctV84iJUMFq2skbMHTdr1yOReg@mail.gmail.com>
Subject: Re: [PATCH v3 mm-hotfixes] mm/zswap: fix inconsistency when
 zswap_store_page() fails
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 2:08=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> skips charging any zswap entries when it failed to zswap the entire
> folio.
>
> However, when some base pages are zswapped but it failed to zswap
> the entire folio, the zswap operation is rolled back.
> When freeing zswap entries for those pages, zswap_entry_free() uncharges
> the zswap entries that were not previously charged, causing zswap chargin=
g
> to become inconsistent.
>
> This inconsistency triggers two warnings with following steps:
>   # On a machine with 64GiB of RAM and 36GiB of zswap
>   $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
>   $ sudo reboot
>
>   The two warnings are:
>     in mm/memcontrol.c:163, function obj_cgroup_release():
>       WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));
>
>     in mm/page_counter.c:60, function page_counter_cancel():
>       if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=3D%lu\=
n",
>           new, nr_pages))
>
> zswap_stored_pages also becomes inconsistent in the same way.

Nice catch haha.

>
> As suggested by Kanchana, increment zswap_stored_pages and charge zswap
> entries within zswap_store_page() when it succeeds. This way,
> zswap_entry_free() will decrement the counter and uncharge the entries
> when it failed to zswap the entire folio.
>
> While this could potentially be optimized by batching objcg charging
> and incrementing the counter, let's focus on fixing the bug this time
> and leave the optimization for later after some evaluation.
>
> After resolving the inconsistency, the warnings disappear.
>
> Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
> Cc: stable@vger.kernel.org
> Co-developed-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

With your fixlet applied:

Acked-by: Nhat Pham <nphamcs@gmail.com>

