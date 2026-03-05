Return-Path: <stable+bounces-223263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jtoyEu7LqWl+FQEAu9opvQ
	(envelope-from <stable+bounces-223263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 19:31:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9119E216F7B
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 19:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3962E304D97D
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B44523BCFD;
	Thu,  5 Mar 2026 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHkfxVd2"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B01F3FED
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735467; cv=pass; b=qasyq12MvOyRhZD1oG9vEUA/KtTfdX8By59ytvXkUvwTf+tKMh2WYXLLUYqi9u8bbE6S9c8TF3evtw+CgoZM9pp5YXieW0VHe3B3vxIWEDcLRmeqs9SdKcNuvkxpVUglgE6Pj1ZyyqDNg5botY/GIJBSUld8CAMtcHVOGj4FUBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735467; c=relaxed/simple;
	bh=louF0VYT3jVATcdfkHl6P9eqPKqMc0Xl0Ev8Gw/VyXM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKGFzRaDlpaXRvIdboCVKHqhdYciilD54GsqyGtPUs1LJaTvw9PBSYWvW5P38WVyLh/cEZK3lEYJWZvpBzL2qqINidwGhmEQnPvKGLP6RdJztZ/VzMtIw6+habVcKj5v5JoJtdRQ/tX+BciOTur9PmEXIoB3IXiNC1L7+/8wD0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHkfxVd2; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-797d6bde07fso5048357b3.2
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 10:31:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772735465; cv=none;
        d=google.com; s=arc-20240605;
        b=Y1qJIV2gOUTT/pipcomfUNPB59STkJ0VWoOK1POtQ2BBle1Ky2OuseOl5PbTFM7AS1
         Em2d5LfQfk6tYNsf+OOedIEAsAEzpLcUrc63iE6+K3bXOvMr2hljsTxoGsJKTD43GklS
         WCZOwsbabbwdmo+6A+wTS9y3SfeqtA78MHMmqE8UuJH4DpS1MmMHz3vv6n75oJzoxr1R
         GS0kpw8TKiCfmAz7Ub+YLPo1ouXBUA9oQsKYxzVONb7VjTztRPY7JhNm5THq4ZTyGsVf
         Fd5dB+Jwq673BvDtFy1i50Q6NtSWyiKqYXRkLQKCj1914Uc8H03HZqlmkG/KG5/4KksK
         eQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=louF0VYT3jVATcdfkHl6P9eqPKqMc0Xl0Ev8Gw/VyXM=;
        fh=3qWVkmHSoYeza8dqg75ijzI4fGR21Jm9X4TP8Z7mn4I=;
        b=XcRsjD+XYOxF1RkSOHRWRY9ZEl1I6Rtdj8wUAACEwA0e9bbXw2FJtu6y2MymDpXMTH
         2Qi3KHjrvDe9GdDoKlI82dz8kQnhlVLGWr3lHMqctrQtxuzzLS7PcHaGP3ifspHjAK6j
         RJfgE6v67dCS4u8HAVUYeHM6GkjEpe4JemnvkBkfINc5ab9c9dNK2GhQjBCUCLL05XEi
         6rvBcSS9IzjJBvUThVrXSI6yV7GJJ7me91lURvqY1Vmd/KieJfeAlapTslDAbuIr8roH
         yu/h90dX0pnkb3uPqZPXoyZYvKou7cyCxH2bo/lTKDsW4LgsMe/AysIxNPb8ciwDeOFw
         sLqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772735465; x=1773340265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=louF0VYT3jVATcdfkHl6P9eqPKqMc0Xl0Ev8Gw/VyXM=;
        b=PHkfxVd2hcZFLgrOT1R5x2ymJMB5hpXI0IhlLDsEKI+z/tqrdACN31MbOIG1FY2RKZ
         g10usS15kypRf2nTdBl7or1B8DI6bRU6LCUMqfTeWpXIJGmnu9WyhXVfgseVYka2IMln
         JIIXA5YxMcRtp8GtSnwwwWVM5vRMkc8SOKCG21eAFgTPU+iXjzJIxAqDSib7lbQKhHzc
         bYCTrTIrXgmWSMuVKBNNukk82uNEPTS2QDE+nqhUstMEdEr1NE4G7YoaJqkauWrzWeaD
         WYZ8P6VauR0pkSm5OeIuMo/htg+PoaQscHtLkSKPMj9SdB0Sy8klkbwnUNL/KL6J6l/R
         oRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735465; x=1773340265;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=louF0VYT3jVATcdfkHl6P9eqPKqMc0Xl0Ev8Gw/VyXM=;
        b=kPEbxFykquq1MOB6oUpX6P2NVE/pXIbPEyRQWVq77vwjv10VkAiymw4n0mUkK6dLo+
         WntxzdTE7AhAKMINHb5pomFLUP1+u5h5jc78X+sXEBSe3hUTwsRQH1EB7nsGYxaNNcaz
         o0dRqqwXnGZ+1J0IquYKyItRlOAlFst24RfO/gT72Jzrf70H+Md6bvfk/eYkwgigM7Qy
         I6uEjp1XUnaSLnEuP1247ATwx7NU2MOCFOmVT7chykcz+jL1c9K9W9d/kc1o/TgeEFmo
         lV8fI/rtUcA1Khm2/diB3ZzGapCUGu2fKkNcZnB9uwjpirCADuDP/wCdq+0eCwIm5b2q
         q6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwz/zMEM6qiiUjwU4a9fM3g6TQu3zhSYgnNNe+zYNUEVMEDwnhAVsjeoO73lV7LVuFxQ8+J5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwsq6M+CdMg+q7b56Qpu3EX0hjHPvjDdJk0Leh3Es56jYlrLeh
	gViz8jnNwx4WlNIe6V3rS3FhuvvP1YVfKqliOZY+tt5Gv4uIEPyMcxzWcjs4AKAL0D3RV0R+uQS
	P+6LNbbtqYg7odpdEvSI0E91+UagDmcA=
X-Gm-Gg: ATEYQzyJHILe4YslDiXfG4O8n1FooocU7ZLIhax5jXa26bz3Q0ZyoD1AwAHPtx+enyk
	FmHF+KgsSL8yy2Yd2fGrk8IZBFlSDJxRdb5OAGFDRRNWplqH2Ty2yJKAm/fOQhy2Liw+mMvVdqa
	UnzbdYk69uqi1uFbYIMm2cT377MstI9mg7D91+AahNBWRtKaADaQaft2Zse0NbaZJ8q3nD2PaT6
	XVPq+96l63Q65pa6pdnNTSPSDl1eEJNbVzzfXfg6pDCH0eJHSd4eCBW8yBMQ/ECqX/fd1llTQol
	isjROg==
X-Received: by 2002:a05:690c:113:b0:794:ce39:c63a with SMTP id
 00721157ae682-798c6b7f74bmr47076567b3.2.1772735464762; Thu, 05 Mar 2026
 10:31:04 -0800 (PST)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Mar 2026 12:31:04 -0600
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Mar 2026 12:31:03 -0600
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <2f9135c7866c6e0d06e960993b8a5674a9ebc7ec.1771938394.git.ritesh.list@gmail.com>
References: <2f9135c7866c6e0d06e960993b8a5674a9ebc7ec.1771938394.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Mar 2026 12:31:03 -0600
X-Gm-Features: AaiRm52GZ13axMWytXPAWQiFZUnqLmaKbYqKRkeisNV1Nap28ZH-9coEHa7p224
Message-ID: <CAPAsAGxB6RGSYzMq=tjQQmEDu3QP+v_AqmkbWTRyqkk+K35o-w@mail.gmail.com>
Subject: Re: [PATCH v2] mm/kasan: Fix double free for kasan pXds
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linuxppc-dev@lists.ozlabs.org, 
	stable@vger.kernel.org, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9119E216F7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kvack.org,google.com,gmail.com,arm.com,lists.ozlabs.org,vger.kernel.org,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-223263-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryabininaa@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.954];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> kasan_free_pxd() assumes the page table is always struct page aligned.
> But that's not always the case for all architectures. E.g. In case of
> powerpc with 64K pagesize, PUD table (of size 4096) comes from slab
> cache named pgtable-2^9. Hence instead of page_to_virt(pxd_page()) let's
> just directly pass the start of the pxd table which is passed as the 1st
> argument.
>
> This fixes the below double free kasan issue seen with PMEM:
>
> radix-mmu: Mapped 0x0000047d10000000-0x0000047f90000000 with 2.00 MiB pages
> ==================================================================
> BUG: KASAN: double-free in kasan_remove_zero_shadow+0x9c4/0xa20
...
>
> Fixes: 0207df4fa1a8 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
> Cc: stable@vger.kernel.org
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>

Reviewed-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>

