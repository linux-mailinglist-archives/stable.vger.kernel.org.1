Return-Path: <stable+bounces-124051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B501AA5CB72
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 17:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 553583A8F29
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FD6261368;
	Tue, 11 Mar 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c80JGyfj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DE260A20
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712338; cv=none; b=udMeyQru8wJuA18OTM2hqC5JfBSTnHGhMKmFKm6078En2Bw3VNhrMkfPdKp5Z+V1ADF9fkM0AGVOJNakwTgOydeyq6iJ0MDTJwoWZtlT0tLa2Gb0YLQi7l1/vxdGvhchbyIhPeRIcoCOBAnGqRNKRUiaWOT0+ec5jtbD4xputAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712338; c=relaxed/simple;
	bh=bqa4Zo5G3EvpwSCUBlVCZ/hQ7UKYLe4xSoHICsRADqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ye+jsQpBvGAGsUUShsQ1J/7C3r0dVFyJ37zCHCuQTC1iH71nZgw4c4hfgqWbc+t6l+B0wv+GsHRjIdYhFwEkmhK99YDYQw1xi5DQ+SY6hJPa8F5M8WbzXsjJ7CPZ/DaMLXgFEJ3GxLT//AlI7ftxJq/A4IRrNNbb5knQHKvDkOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c80JGyfj; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c0a159ded2so611315085a.0
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741712335; x=1742317135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA4x+zsdoa1/Ttu5kIO7FqzRTujqnaAXXb7vBTWVWBw=;
        b=c80JGyfj5X+61ZpH4baWjodKLunRd4jl6Ki5DHfBdpfkqAX3zVGHofWpx+Lb905tQq
         8AHnsvQa3vFWfTV2yzcvuMJ4IbMA3woYh222xNjcXJrJgem+hI8mSj9/SObYlUMTEc+C
         fPC8ul4xqEIgJIJAAWCH7cjOdkskfwKTIg78btMIM5piH0VoxKphXDVirY4e+LRp1dZs
         zuEkRCIHKR2Fuv09IirbdL4Aj8Hkv5mIZpf9GopV2OQOS+/7C6DxN/jyqwky8FuDKti0
         kz7C+N4AdNe7yUwFOUbYJPEpGZdLkeIBN6a5aKusETd4uPfUqIMqz//4aIo6MQHin1zT
         eueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741712335; x=1742317135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA4x+zsdoa1/Ttu5kIO7FqzRTujqnaAXXb7vBTWVWBw=;
        b=n4+OB3poE7RyEicrogrUwGrpRqslIHwoAflL5RTlgFwvLfaCwoOZhryKGAtv0tN+la
         V+pLNZlDDyZcw+jvJ9GaUSLVVScHzdWmbPWX6yF/oKa45lxMEFkPVdW69HDvqxagF08u
         OVv1/1q8lakVTF6w3JS0oN6OCPhfFHviUOf5xm9EZdeAH47mD5MV8WnkCXu6YXXdG23z
         rTeAVjIbp5skO+ZKV6dsFwJf5+LNftaceYAPS+k25NtrGCzN0zR4UAL8edaYdfFO+m7+
         Q7XrOKceRdpIAPnv4YHpi0/CflHnwtlGMtnyMEvby/aX3w0ADDwu56QmTPsEcyy28m4b
         7lrw==
X-Forwarded-Encrypted: i=1; AJvYcCUTqSYspNlsxxpsYib4o43F5JoSLb+oSEpsXYoYnh2hldjrauYCTQFk8ZVULqBiDyBh4wVm9C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHwMdUo8nX1cMsV/SqMABCWyZsHuDwMmsy9kS2S7WN85lCMY6D
	QlnU7wN59AddONm+Z+xfhZ9SkpL+e+JoB8uO6IZ3wP2WhxnVg8JGMzDNJxNxul7bkJy9blwvjhC
	pH9PDTH+6Gq8d2EuTys4uy6ijzq768wm++8KS
X-Gm-Gg: ASbGncsJTIflDNZ8IKtxB+PtwDkuyNQRyJmMNpZ9uzImZc9aBmmoKYjx9tufBaiiJ79
	SYQMVhhyIZobBAP9MavK5Ga5WiZ8VaVyZgIK921UFvVT+N9ArJbUZL3zC2TcMHlXKuJPtI+Darx
	NlTrk73wWRxCwp1wV2+3j2USmK4tD749afRIQh3GEeX+o64phsT31nGaw=
X-Google-Smtp-Source: AGHT+IGXTV6jt8zy0b/a5jQLG+eKvtaOTrGi6iFpSH7vWvwWk2XXzc4vkIrgDbePZzBUnokoYaBHhAtlF7Osr8wlR60=
X-Received: by 2002:a05:620a:838c:b0:7c0:a0ba:2029 with SMTP id
 af79cd13be357-7c4e6178ce4mr2882337785a.40.1741712335418; Tue, 11 Mar 2025
 09:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306053724.9DF85C4CEE4@smtp.kernel.org>
In-Reply-To: <20250306053724.9DF85C4CEE4@smtp.kernel.org>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 11 Mar 2025 12:58:17 -0400
X-Gm-Features: AQ5f1Jo0wKRvS-Sw6eU2fJMQMU5J89-Jhq8EBJNyzSQhqhPzSEtZkom-oS0Ybcw
Message-ID: <CAG_fn=W0KFnHq0=M1FovTHPTnve=W2Hqvq1Hny4TQuU+rL2fiQ@mail.gmail.com>
Subject: Re: [merged mm-hotfixes-stable] dma-kmsan-export-kmsan_handle_dma-for-modules.patch
 removed from -mm tree
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, tglx@linutronix.de, stable@vger.kernel.org, 
	peterz@infradead.org, lkp@intel.com, elver@google.com, dvyukov@google.com, 
	bigeasy@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 12:37=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
>
> The quilt patch titled
>      Subject: dma: kmsan: export kmsan_handle_dma() for modules
> has been removed from the -mm tree.  Its filename was
>      dma-kmsan-export-kmsan_handle_dma-for-modules.patch
>
> This patch was dropped because it was merged into the mm-hotfixes-stable =
branch
> of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> ------------------------------------------------------
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Subject: dma: kmsan: export kmsan_handle_dma() for modules
> Date: Tue, 18 Feb 2025 10:14:11 +0100
>
> kmsan_handle_dma() is used by virtio_ring() which can be built as a
> module.  kmsan_handle_dma() needs to be exported otherwise building the
> virtio_ring fails.
>
> Export kmsan_handle_dma for modules.
>
> Link: https://lkml.kernel.org/r/20250218091411.MMS3wBN9@linutronix.de
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502150634.qjxwSeJR-lkp@i=
ntel.com/
> Fixes: 7ade4f10779c ("dma: kmsan: unpoison DMA mappings")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitriy Vyukov <dvyukov@google.com>
> Cc: Macro Elver <elver@google.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Note: I think the Reviewed-by: I left on the patch is missing here,
but I don't mind (no need to respin)

