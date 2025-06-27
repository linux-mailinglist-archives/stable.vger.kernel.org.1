Return-Path: <stable+bounces-158812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F2EAEC2B4
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 00:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DCE6E5A38
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 22:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD11E28FFCF;
	Fri, 27 Jun 2025 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD1LCWi9"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D81928852D;
	Fri, 27 Jun 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064183; cv=none; b=Pik71dt4KWImCbZrKDOPuRhtuENks4sWTPK+y6/ID6YmpGTu2v/QhCI+0WzpD2EXnFbbl44VpQ20+J5m5LoZIaHND5agKsScY0KDbqgZF7xgKFpoeFUhGCnuFQoQ6W3znHJKcBL2yfEl/TaltXIGRQrZT3KWHLgN6ecoateqk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064183; c=relaxed/simple;
	bh=u4NjeapwgPl7o9j68s8R5yPMQayON7gZ7uf9DS/utGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inIsH/FizEMLBy4HvdKn1511TtWNgY0OxN2mWxyMcEg8tD0fypHyrEbanONpiRl+kGem+WO5iliqZVdA9PyQ5OSfitRUPHYQhdMX68ZIKbLscU4xJBX7OAjlpINl8kBezLzRoI1gQykUIiiEM795DaLBZJnE8xZAL33luIZWp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD1LCWi9; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-53159d11cecso1608112e0c.2;
        Fri, 27 Jun 2025 15:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751064180; x=1751668980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4NjeapwgPl7o9j68s8R5yPMQayON7gZ7uf9DS/utGE=;
        b=jD1LCWi9ZyCeit63StjulvTvvP8JUNnUoiZalPQ0qXcnDtmnTwnN0iydBl74hgB7mx
         9BpDOPHiNoZ7065O8hT3YLsggHwdlNZ4NgX0ehM3qmjx2LulWlQrbb1oJmV27qnbudXp
         M6IMhxlDSx2EQJBsC+Qb+kUoaLOtYgboiU9EYzCiQ2y7Lo5BuER0fV07gN+ks7sLaxt6
         kKschJZdCO5zJjLmrcCzrSFz56l2pakTkkJPMOI12JEwG2Q3nAVIBE0lbAQQO+ZOfeqk
         zjy/+agfmQcEstCCz7kQnjmrxE+rPLIGQ9kwXJGQ2QLj/91Hmt3f/UoPq4skOMG56fGp
         dq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751064180; x=1751668980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4NjeapwgPl7o9j68s8R5yPMQayON7gZ7uf9DS/utGE=;
        b=BPxKIgyHe4K3Km20UKcuaq2gfD7iPRH+UEVabn30AwOFENVD4UGwjlX97RA9eNsVfT
         cnLfPNTfMVQbi+1dG5jjNxlbj7FFccZo2z0NpFVmJU8zOnjicTg1tBnkiElS2dugqHAI
         SL4/9+d7rRD65T/bGijfmvN8NbNf3uB/A7pghbjq+9WSRWqqneqngeqtlMXi6qfPS258
         8YXaGA8R+kD1/Ogn8pSBzjCbOy7VRMMGOT4XJ1YrunKy3Agg+Yfks8LdKT2ria5ALN1Z
         sZAqu9IDuWuUdXTc0GGtN4tWBjmZcP+F+a7GUxxJWVhamaAORupMcE8dL46fh0SrVKRQ
         1GaA==
X-Forwarded-Encrypted: i=1; AJvYcCULNhTKOJ3MiKR9IHmyNH7MRI28UO594oidERyvs2bZhzwF516ecrJUU9IXrDCi0vK1hNlyXa6q@vger.kernel.org, AJvYcCXKUX7yTzOr4nkO44KDPTzZ9OO96im38huM6kS1MF7JWO9D/+8ZiN035dN1R4zN1Rt3EWOXO3GnCnNYVzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbHsGkFIXTlfABLlHakD+Ka6wSjXaJKEdm8Yt9AnXJ1Mc60U7e
	T8OaoRy3uFgPEEYNPu1mtD5Vabh3qLbw0cd/bNi2YGFC+5BervhJnRLrZCsvO16blF9f97YPrm0
	WW0kXRQzD6BeOe6s3Th8RPfN1KGT/SvI=
X-Gm-Gg: ASbGncs2DPeT5cfxnR3fL83NNzBi9S1jPbmWcuDpB7UYZTb3Xzioli8eGeMMjgbo7RJ
	GOsIIoi8wse+Eg1FN2Q+SPul4v8MMTGXEGpxsDpksJayhuoSq4eSy6Hw3wYjHWH+zsLoICMW9Tq
	OpHMpRc3WIYOnM80GyIKY0ryaHxP790vTVtSEEVSxuivY=
X-Google-Smtp-Source: AGHT+IFk0Ei4GgmAkHyX5mZ9ZCWUvEwxuRN77hDGrq2whD37UOPWeYi0DQsxO0na667fxWtBBPxMAXvU8evvWeuNBWE=
X-Received: by 2002:a05:6122:660a:b0:523:dd87:fe95 with SMTP id
 71dfb90a1353d-5330c0c680emr4562995e0c.9.1751064180351; Fri, 27 Jun 2025
 15:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627062319.84936-1-lance.yang@linux.dev> <CAGsJ_4xQW3O=-VoC7aTCiwU4NZnK0tNsG1faAUgLvf4aZSm8Eg@mail.gmail.com>
 <CAGsJ_4z+DU-FhNk9vkS-epdxgUMjrCvh31ZBwoAs98uWnbTK-A@mail.gmail.com>
 <1d39b66e-4009-4143-a8fa-5d876bc1f7e7@linux.dev> <CAGsJ_4xX+kW1msaXpEPqX7aQ-GYG9QVMo+JYBc18BfLCs8eFyA@mail.gmail.com>
 <609409c7-91a8-4898-ab29-fa00eb36df02@redhat.com> <530101b3-34d2-49bb-9a12-c7036b0c0a69@linux.dev>
In-Reply-To: <530101b3-34d2-49bb-9a12-c7036b0c0a69@linux.dev>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 28 Jun 2025 10:42:49 +1200
X-Gm-Features: Ac12FXxGFmLgQUm1TzQ4GRXvYtSFtMDf_ZQxI7m__F1iEVPCgA6gaIbZBp5ogkM
Message-ID: <CAGsJ_4whENJnq+XBu9VnRWMTh9HouQdULO5u1G=+d3JVmdRpeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
To: Lance Yang <lance.yang@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
	lorenzo.stoakes@oracle.com, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	x86@kernel.org, huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, 
	riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	harry.yoo@oracle.com, mingzhe.yang@ly.com, stable@vger.kernel.org, 
	Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 3:29=E2=80=AFAM Lance Yang <lance.yang@linux.dev> w=
rote:

[...]
>
> Based on that, I think we're on the same page now. I'd like to post
> the following commit message for the next version:
>
> ```
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> may read past the end of a PTE table when a large folio's PTE mappings
> are not fully contained within a single page table.
>
> While this scenario might be rare, an issue triggerable from userspace mu=
st
> be fixed regardless of its likelihood. This patch fixes the out-of-bounds
> access by refactoring the logic into a new helper, folio_unmap_pte_batch(=
).
>
> The new helper correctly calculates the safe batch size by capping the
> scan at both the VMA and PMD boundaries. To simplify the code, it also
> supports partial batching (i.e., any number of pages from 1 up to the
> calculated safe maximum), as there is no strong reason to special-case
> for fully mapped folios.
> ```
>
> So, wdyt?
>

Acked-by: Barry Song <baohua@kernel.org>

Thanks
Barry

