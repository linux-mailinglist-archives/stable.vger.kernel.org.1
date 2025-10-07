Return-Path: <stable+bounces-183570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6CBC302E
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 01:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 228954EFFB6
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 23:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0056F2777E1;
	Tue,  7 Oct 2025 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjprLjm3"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C89E276052
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881178; cv=none; b=CCSxnF4WXkSmtuRQFGL3MTzEGvTBHTLuru973+MkvT9OdFsMI99q190g8zadM2gzpNK2xzD8ufZ1NldawJRVdJLJXo0IfuREuO+E9phSDjNErBrBfLGPVF4GeSNBsi+iQNLNv2f8+SchJR9mQw2Poie2MJWsElWYpjEPl2cEgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881178; c=relaxed/simple;
	bh=kS74sY1O+BpSAvJrceTnPc0y9keMpb6Ghrsoi+xe+ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNeN5AMKQ3fuFiJHfu9rVBrZIEeqlxv76zG+dRm3Z6bvCJByklnItl5h1ARUqIh/mr3kfuMDu0iE1MmUyHT7iItgZxUaXN4moTkW5j6NslcmOzKgT63nuf8+iCc5wvgQPbCGwsJAtL7/wnjxxFo9V3RDBYJYE9YuMpufpeh4pCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjprLjm3; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-92b92e4b078so286297239f.0
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 16:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759881176; x=1760485976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS74sY1O+BpSAvJrceTnPc0y9keMpb6Ghrsoi+xe+ks=;
        b=WjprLjm3ohppBH7urHjLb2jMKSvMRXR+15+Xtpw3XwXu3dUp/BjZSYP1z4oRP88Nhv
         za9MrJ2BlJK/NvuI617+FeSOijD/oiXtxFlaqstbMy+QD9qxLVeAooGg60ceFQUV2/RQ
         laZT5hKgu8eoTyQsQAEJwDkTCF42nKCK8YcY/kww5Rf1r07gJgsjhUma0suxYS14R2ts
         Sf05/hAFxmDpwPWe34CGqH4Vl/mIJnScqvKJQe5IWbx2SxGzCIAkccTopFnf134L5ykf
         X2QviKJIH4g/zThpADR2a/ZHnQrNDr+ojTJR1BlC2IUkjktE6buhda8iSxaX04mqBB4p
         FHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881176; x=1760485976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS74sY1O+BpSAvJrceTnPc0y9keMpb6Ghrsoi+xe+ks=;
        b=tGWB36ETgG5isH7hUNWDp//YpNTIF2InikcF6TtxeSC+dyIBf90bG3NAOGjgfLWmaQ
         Yiw4ygQH7voLBAu+OmnA3DPeHxmWIpFlcnRmkl4oWLcBRDttxjIe4WwTdW2NFm3mtQUY
         sV2wJqsVDjM7iJ90Q0HnRZtBStrMWyi/7NostNg1Yk0z71l3zUI5576HaNFAOnveRI6Q
         7lvbcqDhCe5z97hewGAnHvmX3psYZ6e0+UuJiclp0vJ+SS/ZhuJYOpgTbQXlfOJqg1zW
         APAsjMG+dQx7AMTXXMQ/KKzPeb+YFd3xKXJ8eTDQApP0Z5xMBV4csBcY4g3KjCc8fFVA
         kTxw==
X-Forwarded-Encrypted: i=1; AJvYcCUaSb1Ut38AhBI00PFYVdctK7O5LyE28tc4G6wssqlcnjBWnAw9J2KudRvi/uVuFtIjMtKZrVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGpJ7BhVgH8rP9Aj0CFU5Tad935Hc197vwlHjwRtn5LXVqbL8z
	cphyAzF4+j5/od6UxvihtiwLae8VnHqalu8M5c1LPC//Kax7mGfbTTkahkhjaoH6TspOZnVOytq
	8l18WrvraFkN0YZAtwPV8zk1+gEKLNBU=
X-Gm-Gg: ASbGncvUpbHKiXyND9V6mIWOmsN3r1J59dDAPiHbNU2xBX7ZzvvcCStjbX2/+cUB1ur
	2Uj5joBBR6iqdwUSX4qkL2XmxRRZWBZbHU77s8gl2UTwUvvxcRaGxoM9VG+0AzQWAzNRIN8dmN6
	nBtYp5t8ScM8V0nHH702I0FcjVjqcvHgdnWbf2NXs0sMpyYg168tvKiors4SJvp6L7pa3v9sVl7
	Z2uReiu5dfsLOVUc/wT0poU0atu+Glhc3Wmg8KvnvmoYGY=
X-Google-Smtp-Source: AGHT+IGhorzk2+W/xTGL2848aOlY3Nx+slQICiBj8FIH8pICQTD8gFOQKQ61znfWdK6mZ45eCBiZxnfzCGeIUtkRXco=
X-Received: by 2002:a05:6e02:1a8f:b0:427:b642:235 with SMTP id
 e9e14a558f8ab-42f87374f3bmr12991435ab.10.1759881176249; Tue, 07 Oct 2025
 16:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-1-74860ef8ba74@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 7 Oct 2025 16:52:43 -0700
X-Gm-Features: AS18NWAzI3OkoEtAtDpIuyhsnz4mBz4te4CIYqMQaeNGgBOGQrrb52ocbOBCeHw
Message-ID: <CAKEwX=PisWyb-Gt=n7ZBPNTNjbRNM5F5j4LE4NoRgTUB+2ZV-w@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm, swap: do not perform synchronous discard during allocation
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> Since commit 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation
> fast path"), swap allocation is protected by a local lock, which means
> we can't do any sleeping calls during allocation.
>
> However, the discard routine is not taken well care of. When the swap
> allocator failed to find any usable cluster, it would look at the
> pending discard cluster and try to issue some blocking discards. It may
> not necessarily sleep, but the cond_resched at the bio layer indicates
> this is wrong when combined with a local lock. And the bio GFP flag used
> for discard bio is also wrong (not atomic).
>
> It's arguable whether this synchronous discard is helpful at all. In
> most cases, the async discard is good enough. And the swap allocator is
> doing very differently at organizing the clusters since the recent
> change, so it is very rare to see discard clusters piling up.
>
> So far, no issues have been observed or reported with typical SSD setups
> under months of high pressure. This issue was found during my code
> review. But by hacking the kernel a bit: adding a mdelay(100) in the
> async discard path, this issue will be observable with WARNING triggered
> by the wrong GFP and cond_resched in the bio layer.
>
> So let's fix this issue in a safe way: remove the synchronous discard in
> the swap allocation path. And when order 0 is failing with all cluster
> list drained on all swap devices, try to do a discard following the swap
> device priority list. If any discards released some cluster, try the
> allocation again. This way, we can still avoid OOM due to swap failure
> if the hardware is very slow and memory pressure is extremely high.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 1b7e90020eb77 ("mm, swap: use percpu cluster as allocation fast pa=
th")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Seems reasonable to me.

Acked-by: Nhat Pham <nphamcs@gmail.com>

