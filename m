Return-Path: <stable+bounces-67391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4895F94F96B
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 00:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1641C22338
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 22:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6239194AE7;
	Mon, 12 Aug 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vzgd/zIy"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B37454759
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723500785; cv=none; b=NaFnk8rvFTcyjKf5IgWcEs0JLWPQJFuJ+6E6jIsWIom4i8QmIK6I89RJuZ9qmsaw/NLia6+gUIvJe9nv8/nX6XrdjVEqkx5sHqlidiNy0T4zsxrxXDcMLsnOWOADmyyOQU0QVXFXiqq3Usvn982oJrR7G+CgAYqZI/2MKC2OA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723500785; c=relaxed/simple;
	bh=LyFKsDEgjnxNEVYqxUkhyYjIwPC3euwsxGOU2i6sWGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8SIsPnF88dMT2wAXTFwvZXn7sArJc9NkXpoFfM6R1yi6GOEQhW7UkkiBJKmM/2CB9Ma2Yu1da/rohXu5jOw5WzAjRvW7pneCJ9HFzGrDvLcjoyZ98KJUmA+thpBTl9+LYY0om/BNuByieXit77CB/zwncTA06sxhdK5oI3vWnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vzgd/zIy; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bb96ef0e96so26969486d6.2
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723500783; x=1724105583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyFKsDEgjnxNEVYqxUkhyYjIwPC3euwsxGOU2i6sWGk=;
        b=vzgd/zIy/a8CtrKn+aMa6+W6QV9pflfnj1q3DWNiRj50Ln/3Yzj5mYSiu+5crxGChr
         vo2Gp/GbQFllVDbaaiJ3+TcGCjQ1c+vFPcPRod+9qK1vCM05C62H4PlPu9LpDggB1bkS
         qaPpBwf2N/nllYKnWJFUHKR+4DPb5Jz0EflzpxvzAKZSnOQ4bOPj01efO+VW8i0OIiQB
         7LpgID7pv/XnQxFrh5a2htHHAUcrom4dr4CrXjdwqiaGKOQipsdU303WLLe28ssigvrP
         MzDi4oCWXNLGYZOjYxGzYITusEh/9fplhLt4iHeAVp0GCrU3Snx6Nxp5Iew5UCWfaXel
         k8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723500783; x=1724105583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyFKsDEgjnxNEVYqxUkhyYjIwPC3euwsxGOU2i6sWGk=;
        b=JnAa/fieE9pj6gObTQJxQ4i12+SYDauZNThHb1uj14VQF5JmykGsgbmTnNOmuxEDvH
         A6koqySjb03cOkTrwSo5nxIlD1B7c9XoZxC0wqa0TZGvu8OhYCsW9UJEzPEzIfyJdD05
         RorMtnSFe8Bwk4DgxsRvXAXH8+Yj0UbaAE6AzM6I1sbHCITdZS0HeH73MVJgH2exLNcH
         4x5qNh4ihCT/yLnOBZIq00O/d5RBBNfLoytzwVAyJSnK6clifb8MBJIn7t/PyP8hfAC5
         wgKxo1afIex8OM+YVxyP9DXc6WARhoaUAr3vIO4CBgxM1HS6cncbUFz9gW2l7Wo3P5ZM
         H9mw==
X-Forwarded-Encrypted: i=1; AJvYcCUWpp5lhDwsRRn5i5MRrq3i4hLUHqvbyE68QZVHzRnFUEAk3e/JGwqv/FQPPLb+Imozy5qrVk5F7fRIPI2p227GQZdNYNSu
X-Gm-Message-State: AOJu0YwcWHqPCFgcqOVDJPs5TDCyE/HE5PJF//7jx3BNP7uGLeGqQMkI
	jkIfBrwlr69guq31+p6tI2frQdTj7r3NNeuln0U/52lQvrDFy0hW8Bp9OX1nblCVTm7F/vmwn0E
	nAgkRWOsmeMW/Xc39ZsHDXMX/IMcp2knbquCE
X-Google-Smtp-Source: AGHT+IEoO+b9pY7C5DoqMaKmNrfWrx3T3pQDUYneGHRDOHmrDXK+WYRUv2ZXVfLXYFWMQ9tgg2yWFX1PctT326bWJv4=
X-Received: by 2002:a05:6214:3a03:b0:6b9:5cf1:65a3 with SMTP id
 6a1803df08f44-6bf4f84c149mr17036116d6.43.1723500782966; Mon, 12 Aug 2024
 15:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809114854.3745464-1-kirill.shutemov@linux.intel.com> <20240809114854.3745464-2-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240809114854.3745464-2-kirill.shutemov@linux.intel.com>
From: Jianxiong Gao <jxgao@google.com>
Date: Mon, 12 Aug 2024 15:12:50 -0700
Message-ID: <CAMGD6P0ckHzobW1j2GvqqZ3mNUHCBfP9xM-15s8B6yOfdv8MPg@mail.gmail.com>
Subject: Re: [PATCHv2 1/8] mm: Fix endless reclaim on machines with unaccepted memory
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 4:49=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Unaccepted memory is considered unusable free memory, which is not
> counted as free on the zone watermark check. This causes
> get_page_from_freelist() to accept more memory to hit the high
> watermark, but it creates problems in the reclaim path.
>
> The reclaim path encounters a failed zone watermark check and attempts
> to reclaim memory. This is usually successful, but if there is little or
> no reclaimable memory, it can result in endless reclaim with little to
> no progress. This can occur early in the boot process, just after start
> of the init process when the only reclaimable memory is the page cache
> of the init executable and its libraries.
>
> Make unaccepted memory free from watermark check point of view. This way
> unaccepted memory will never be the trigger of memory reclaim.
> Accept more memory in the get_page_from_freelist() if needed.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Jianxiong Gao <jxgao@google.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> Cc: stable@vger.kernel.org # v6.5+

Tested-by: Jianxiong Gao <jxgao@google.com>
I have verified that the patch fixes the systemd issue reported.

