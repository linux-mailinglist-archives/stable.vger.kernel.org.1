Return-Path: <stable+bounces-108015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1BFA06060
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E3D16179B
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB011FECB9;
	Wed,  8 Jan 2025 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2/qce+s"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6AD1FECC0;
	Wed,  8 Jan 2025 15:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350632; cv=none; b=Vv2QJvI/DLMSi1uXOrEzFEck/VXj+WdmHPyNmXy6KR4jr1KUtRjxmLzTjUSbEgRdgOAUtOrzKpVQakdWW+eBt49AX2NBYuJoEF+97UHA6xRtfY5miXFTzptr/BP51/XUR58yG7TGPWbWP+Isg+vByafa1HtnVLPj28BNE3u+zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350632; c=relaxed/simple;
	bh=y8t0nUswEKUQa5FIqCjmM3v3R31MQI4BLiaMOGwNrEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+9jeWaMNW7GW2FqfOvD+pE0uRRAnjFQ3jfVp7OH2xvqaq2WFmvC4BAhOsNdPAEY65ar9O50m6pxNu6dPdv7x2iMBhQvjQAvjpjkHmLjPSLQdfN0uCzClrF56x1zQBA3VOQzbkG3Fanc5FqH5H9Z9QCfC+zYrqXwrXDQHQm/cT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2/qce+s; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467bc28277eso140153211cf.1;
        Wed, 08 Jan 2025 07:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736350629; x=1736955429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8t0nUswEKUQa5FIqCjmM3v3R31MQI4BLiaMOGwNrEM=;
        b=H2/qce+sWRp4+3ZTwZ2uznLcVflDy+upFm7RhQ9BeBShGew0CqOz7MhaPSFOrrwQFA
         Cn1jYGeOxjJ4v06GNSriuI8J+NffnmrG2pxd7dW1TziQ5psPQONyDmnO2oeV4FWun9VD
         bPsU/4adxf4Qvyd/xu1iXmj2ybT0BLnZMT+FHXmF0WzIB4RbI2NDUQMARsJRY6MMhJ5q
         s1lREIXH3LBdgDnK2OVX30aQ+ByvSL7mZ6H2ny1i5AWUpfuUf/qiwfQ3etFMnYOtwBzl
         ZEFtZNwgCAHxCgJDK7uGjTlXzSjylLD8wG49SEhRhPRjtaqFFuE+hhWCLI7Sdb+WRUci
         m47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736350629; x=1736955429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8t0nUswEKUQa5FIqCjmM3v3R31MQI4BLiaMOGwNrEM=;
        b=FsbwV8YHzVfu9HFIp4GJlwnJ+uQ6O/wCSsSEAAJ7nfg7iSxICffyjG9cM58p05835l
         H2TGsX5Qa7Be0Gnv2X+gRDzoisA3ChNYQqoFeDsAkPfaDmgNPDC0p0d2fqy73bpebTDj
         YYf5bAo8Px0qOaY/ANL6UcwqOfq5Wm4MszomI0qQV6K+g26Azqcl4/xeSlZ/JuP5Lwxz
         X6U9Zkk5sHqGqtKwVTAhN+r92qdXsIQWJRcrqHcQkU8nNoMlyCFm46FBrEwSzP0W+/wt
         PoS+1LQyL8gy+nUgEd03ReKaRMhD6wOCiilCLag6RcPZLQ9P59L++hE/C0f6I8E86iul
         xN+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYfntrhVwoP81ElEnEDTCRVH0BFTRWpLoTlAcRPZxdiQ4DPts2OYfG8bTvrVUAJNVc93q/icNu@vger.kernel.org, AJvYcCWaDPKpznoogrSCI/NwUOTJnXsbhQobBqq3cmco8XKX1iZjnARmKc2TBkO9SQm7ZyjALTpizxCRAg6xelI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+dnBJ6+g480s2IHgRUpXA5nzipxs+GsLwXm3Yy89ozN+PJL7I
	gkIfsiiy/ntq83JO0Zsi/COK1R5tKWoYIFZZ+80AOzEWBFcmr6YPK6PVecdwGit29StU6sd5S86
	MSGAQEeQSUmz8/7ddLdRYyUPWvH8=
X-Gm-Gg: ASbGncs2auFUicaayVUTi0SrQ4dDZNRZPARje6ebWB7501u6nvlrizlsyUjKhtmSiVN
	hUYkjNgZ2iSnTAVjgnh6MUeA+aoOE8FO1gMMHg/0=
X-Google-Smtp-Source: AGHT+IF+dzISC56w3I8H6HkJER+DxC3dM2D82Yc0qvMHFTLPWwx2X7P2Iqd0AEfswyAbd/ImrNwE1sYIGQ80c1oS30k=
X-Received: by 2002:a05:6214:4015:b0:6d8:8f14:2f5c with SMTP id
 6a1803df08f44-6df9b227e98mr59691006d6.23.1736350629410; Wed, 08 Jan 2025
 07:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107222236.2715883-1-yosryahmed@google.com>
 <20250107222236.2715883-2-yosryahmed@google.com> <DM8PR11MB567100328F56886B9F179271C9122@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkYqv9oA4V_Ga8KZ_uV1kUnaRYBzHwwd72iEQPO2PKnSiw@mail.gmail.com>
 <SJ0PR11MB5678847E829448EF36A3961FC9122@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYV_pFGCwpzMD_WiBd+46oVHu946M_ARA8tP79zqkJsDA@mail.gmail.com>
 <CAJD7tkYpNNsbTZZqFoRh-FkXDgxONZEUPKk1YQv7-TFMWWQRzQ@mail.gmail.com>
 <CAKEwX=OHcZB8Uy5zj8Dhq-ieiwpJFcqRXN_7=mbM1FD_h_uOOA@mail.gmail.com>
 <857acdc4-c4b7-44ea-a67d-2df83ca245ed@linux.dev> <CAJD7tkZ+UeXXvFc+M9JssooW_0rW-GVgUMo3GVcSMCxQhndZuA@mail.gmail.com>
In-Reply-To: <CAJD7tkZ+UeXXvFc+M9JssooW_0rW-GVgUMo3GVcSMCxQhndZuA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 8 Jan 2025 22:36:57 +0700
X-Gm-Features: AbW1kvY7ocBpDIRFD87MJScWjoKSRdGbbU3BNMTyiEV1JvS_hR6bngjD5A_O1hA
Message-ID: <CAKEwX=NHP7G1KJ1A0c+ciWme8iU6NKddgQfmcqscHrVQnbQyrQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: zswap: disable migration while using per-CPU acomp_ctx
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Vitaly Wool <vitalywool@gmail.com>, 
	Barry Song <baohua@kernel.org>, Sam Sun <samsun1006219@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 12:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jan 7, 2025 at 9:00=E2=80=AFPM Chengming Zhou <chengming.zhou@lin=
ux.dev> wrote:
> Please correct me if I am wrong, but my understanding is that memory
> allocated with alloc_percpu() is allocated for each *possible* CPU,
> and does not go away when CPUs are offlined. We allocate the per-CPU
> crypto_acomp_ctx structs with alloc_percpu() (including the mutex), so
> they should not go away with CPU offlining.
>
> OTOH, we allocate the crypto_acomp_ctx.acompx, crypto_acomp_ctx.req,
> and crypto_acomp_ctx.buffer only for online CPUs through the CPU
> hotplug notifiers (i.e. zswap_cpu_comp_prepare() and
> zswap_cpu_comp_dead()). These are the resources that can go away with
> CPU offlining, and what we need to protect about.
>
> The approach I am taking here is to hold the per-CPU mutex in the CPU
> offlining code while we free these resources, and set
> crypto_acomp_ctx.req to NULL. In acomp_ctx_get_cpu_locked(), we hold
> the mutex of the current CPU, and check if crypto_acomp_ctx.req is
> NULL.
>
> If it is NULL, then the CPU is offlined between raw_cpu_ptr() and
> acquiring the mutex, and we retry on the new CPU that we end up on. If
> it is not NULL, then we are guaranteed that the resources will not be
> freed by CPU offlining until acomp_ctx_put_unlock() is called and the
> mutex is unlocked.
>

Ah you're right, that makes a lot of sense now :)

