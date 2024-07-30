Return-Path: <stable+bounces-64670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F17659421CE
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0851F257D6
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA418DF93;
	Tue, 30 Jul 2024 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkS/MZ3J"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE81E18B479
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372254; cv=none; b=HbBj4ODmy78YL292Mux+0tCgjP/zAUq+xIHqFlQ+Q/XqJ4paS01iIjn8ltpXhti3Z43831+jo2XR4YPg2N5Rf6waRDkuTLqgbUKWHz7xsBX6x5RiKaa7/yAIep7nhgp5YGM5D2EfZpDO3YAulzjPcLttYqlyLq95+61HHnXD2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372254; c=relaxed/simple;
	bh=7pd2BloxENxQ1inDVjgsIyQVOWegD+25F3x1EEf0zK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPuEc49tSr9fZe8+JbBNknaktBhi2c0ucqESKKLKcX6E9QvUdrPYVFdmgHWapKXNakMPwE4FjJUWzkE57LEabHSKx54sA3g06w2E3zeehCWLYMtRGZ9dqTDw0t3FrUfs9vTCAphv5Z36QCRobgfXwNHSF1tYrjwjUz8oEqWzCHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkS/MZ3J; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44fe76fa0b8so78411cf.0
        for <stable@vger.kernel.org>; Tue, 30 Jul 2024 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722372252; x=1722977052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgyj+j3dt5UcJ0UQYMBi50Wse5pVU30lmwqJLm3OCeU=;
        b=GkS/MZ3JTlePjN72oxeNL9SXxhglYUdUhhkU305jyM0gsEEK3hCq5tIBvKjxwKUkcd
         ZWx09BEQFeEL2Tq6iRelxKHI7e5KtBWmD5dzGvGa1NMocQwCYSy2AX4EBhFLX3YN9SsH
         KEfCqXj4cID73gGAgVzznHeg99XnsvniDjz2PpwuDobeWBN1BnLWyCUweC9xCNDGsNr9
         gFthWKbh9yCKjvmSGYgKwtE67gre6pFReEyCXWqxLyLMV3ndq2F6Tn/8WIcRJfn+r31f
         4JfsB9tKE+6B9xudGUNnUY3NTfndxmCMwEvn9+CDR0LgFbteM5oO/BND2uVH9vlP3WFd
         SwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722372252; x=1722977052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgyj+j3dt5UcJ0UQYMBi50Wse5pVU30lmwqJLm3OCeU=;
        b=EcZMr6iqbZrYWd5L4b/7b77EHhZFrYsEU+sfEwFlPZBo6PgLCe+cx+rrHHnMlH+g1+
         Lfomoye+uuA8x4WSdjCnI85ixb/5HQQgqvM8xKrVgwGG3MMPCZQfHh5cs4E/BJXaCCvm
         bDveL1WWAKexakkvz4aEI07v6FsRnNyvY3kk5Wf6CJd9PmuWUj35gLVjjHwOzauMexNW
         c9dyLLxKry7MxiV4L92tvmgMqb2CE/697lQJnJx8c2xpOnKsRW+9ytyTE/nbqLQsZTMx
         /qjGbMk9JlFNbnRzh174MjUsAkluFiRq29hiVggzej5vTkZK8uLMYYDvkO0+iysND+Mp
         BxWA==
X-Forwarded-Encrypted: i=1; AJvYcCXMGW66ML7c8eJ6qNfvtz+wLVeAyODV90VHqC/wUCh5yrjCa4DWOwR735AvaVxjLi+96VENwRFhmRATDQv1AJourgygAdIS
X-Gm-Message-State: AOJu0YyrBkyxgenFKPcyRrRkzhazoHPJI6UOkhqMjqc93LwzNlhZL13f
	W6egWNg/SZDrKOKo1HWtNHC0R7LHC1YDMbP68X9SSsb2tCjwsbkYCC2EVbFHRJ4XLaGK4TJBCs5
	A37Xeu1Y8jFYhYUVuoYSpevUtUzGnXsDlhNr0
X-Google-Smtp-Source: AGHT+IGvHbr1exiYovMGLFSNWCtRnM+rnR0yYlx5wBYqZh6HIfByABr4k+MHsjm8/Eawp/JhwWBxyUFSDMDWvkd48Ng=
X-Received: by 2002:a05:622a:1306:b0:447:e6c6:bd3 with SMTP id
 d75a77b69052e-4504317924emr99991cf.21.1722372251688; Tue, 30 Jul 2024
 13:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730200341.1642904-1-david@redhat.com>
In-Reply-To: <20240730200341.1642904-1-david@redhat.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 30 Jul 2024 13:43:35 -0700
Message-ID: <CADrL8HXRCNFzmg67p=j0_0Y_NAFo5rUDmvnr40F5HGAsQMvbnw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/hugetlb: fix hugetlb vs. core-mm PT locking
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Oscar Salvador <osalvador@suse.de>, 
	Muchun Song <muchun.song@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 1:03=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b100df8cb5857..1b1f40ff00b7d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2926,6 +2926,12 @@ static inline spinlock_t *pte_lockptr(struct mm_st=
ruct *mm, pmd_t *pmd)
>         return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>  }
>
> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> +{
> +       BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
> +       return ptlock_ptr(virt_to_ptdesc(pte));

Hi David,

Small question: ptep_lockptr() does not handle the case where the size
of the PTE table is larger than PAGE_SIZE, but pmd_lockptr() does.
IIUC, for pte_lockptr() and ptep_lockptr() to return the same result
in this case, ptep_lockptr() should be doing the masking that
pmd_lockptr() is doing. Are you sure that you don't need to be doing
it? (Or maybe I am misunderstanding something.)

Thanks for the fix!

> +}
> +
>  static inline bool ptlock_init(struct ptdesc *ptdesc)
>  {
>         /*
> @@ -2950,6 +2956,10 @@ static inline spinlock_t *pte_lockptr(struct mm_st=
ruct *mm, pmd_t *pmd)
>  {
>         return &mm->page_table_lock;
>  }
> +static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
> +{
> +       return &mm->page_table_lock;
> +}
>  static inline void ptlock_cache_init(void) {}
>  static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
> --
> 2.45.2
>
>

