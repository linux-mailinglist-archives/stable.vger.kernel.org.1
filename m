Return-Path: <stable+bounces-158741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC81AEB033
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 09:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1520A7B415F
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68F721ADC9;
	Fri, 27 Jun 2025 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGSGJ0Mp"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26421638D;
	Fri, 27 Jun 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751009831; cv=none; b=nMHF66hKjqGJeMBOtRelUBxTRt7rHyxK81bjwEY/FpX1T7GpqodQYV6ttbi0P9iG3FSSxgtj0CuqpmbYD8YEfN3mfZZgIcPfdsKyOyhHoZ+SFFytys0kfBzNBur01wnO7wJNcu7d0S4WiCxgMnBFDK3+vwPaMO72v1CjUVlW4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751009831; c=relaxed/simple;
	bh=h04dW7cvq5MsrTLRcy+l7A8vi+WnZaRzq7TXJn2e26A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sp80k8SMpd6qZFys5LMH7lMsOf3I5Z99f/qd4iXLxWVdos3kgibPKlJL44q62AuM15l8s7K/kE8IVA7ZUGcKJQAXhtLTCxtYWA2mFVgg3b99fNG7a1Bh6y38BxU9FTOthYtA6dRiQvCY1JuEXqSFpyYuN9TvOPT+FUEjK1OMElw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGSGJ0Mp; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-53185535ed9so1785495e0c.0;
        Fri, 27 Jun 2025 00:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751009829; x=1751614629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h04dW7cvq5MsrTLRcy+l7A8vi+WnZaRzq7TXJn2e26A=;
        b=FGSGJ0MpSUM6ByQ+kGPNxA2KQfs2ywZAh2i0RlHhzx4kgiPqySR5+Z8ylsC/+is0pU
         D2+xd6ZSHCRLwPWhq5xTrUoOSW7/if16K/zIqgmQdGJ0i5K8Q8xTfX35hiZi52K7JQUO
         7/Qzko+3rJqJ7peJEiz/fPYL7uEtH0US8KcdQrQSpQmcheTEupFMC+zJHn5Ovv4aCAQ2
         RJDEsiyFwMsmK3vECounrhtTmoyDOmtAXlodHFNorZkyr3Cj+BWoen+ZaHCML1ilePmH
         413J7VCSl8gTPc5RNgb17ck87iHv/nC6PLEjt+y2k8tWci0efglasOSTsU0fEnO4URvn
         VCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751009829; x=1751614629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h04dW7cvq5MsrTLRcy+l7A8vi+WnZaRzq7TXJn2e26A=;
        b=ZqSbOJSZyJichBsF6vGNQWYNLnDhMgiipmPsLx4TC76e/DJy8xXWZSEV4Col5rCtmF
         yucVXBH4wUzmveMVz6ODinw4EIjC2onCC0BV+LM17od7zeDad+/5XUcBMnvSYiNQ316s
         VjLyOjMoFQJFfTCEngbam/9a9xMZhsBJ1L3Y60MVRSHYPo6UP1rs94FqJZ/coUn+3PnN
         1l0dpuoD6gtac7TeCaStfGTEQtlx6/XuPG0GgqUv0BJCoQQgmoVhUi7aZf/BB+1hAeL8
         Svrb8pO5EUPDwZRrxrWUuxXt2SHy1mLSXDUY1Zn1UV0mD1686t8zEAWTyYhhAdwBUd4d
         Wk2A==
X-Forwarded-Encrypted: i=1; AJvYcCVPV5vzxc6ukVToyj16OnD+FlwrWMgd6y9IZtVY5EurdYVkIr2O2GTE9f/n75LISz3gS8WF6Z0j@vger.kernel.org, AJvYcCVyPcs83VnRAzDEQiAnYHzBgvpIlgyXmhqz7EfQs0SY5J2zpJY8w3qFlOcIRIQASsrjCKzM64Oo7PfRWgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnDPUFCIpPJDR051EoAS8IYgwcK2SP22hsXA5Rj+qkZB13WPfl
	/ujs5k2lG9T2ctoIgf2gjUXJhYFoxaqOtlhOamcPTyEs64V7lsd1+KXNE5jiNqsPlPxjP2P2fiH
	T3BmltSr06bf6pxUaZ0I128xquk/wfys=
X-Gm-Gg: ASbGncuekx93YSPNxOFLHCa2AR75O8KQzDGF/J54/oYfPJ6EDA/LpgHJxGx0vaEiFuC
	EG5wFuq+ZFa4CtjKn5+muC7WJL4HXt8qstUTA+KDBkdCGdnGJ/J/MQGQnk2ZZoL/TJeEF9opW89
	HzouSRIfeAjLZ3V4hHHgOS+ffLe6l5rnph/cn4Gu4p7/0=
X-Google-Smtp-Source: AGHT+IHo8FRikknOYfNn2v3zzQQPaCulI/LItL1n+PBYdAHqbmLkfddAtgEKwDf2Q40GboOB26M3NfwuovgELxUJcjQ=
X-Received: by 2002:a05:6122:a05:b0:531:1314:618d with SMTP id
 71dfb90a1353d-5330c227301mr1950474e0c.0.1751009828926; Fri, 27 Jun 2025
 00:37:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627062319.84936-1-lance.yang@linux.dev> <CAGsJ_4xQW3O=-VoC7aTCiwU4NZnK0tNsG1faAUgLvf4aZSm8Eg@mail.gmail.com>
 <CAGsJ_4z+DU-FhNk9vkS-epdxgUMjrCvh31ZBwoAs98uWnbTK-A@mail.gmail.com> <1d39b66e-4009-4143-a8fa-5d876bc1f7e7@linux.dev>
In-Reply-To: <1d39b66e-4009-4143-a8fa-5d876bc1f7e7@linux.dev>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 27 Jun 2025 19:36:57 +1200
X-Gm-Features: Ac12FXz5tlMnNgK9S5wGn1B_aw1xub8A6xmoNvbFnezBsQjuxTcX4VyZtOeiAwc
Message-ID: <CAGsJ_4xX+kW1msaXpEPqX7aQ-GYG9QVMo+JYBc18BfLCs8eFyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/rmap: fix potential out-of-bounds page table
 access during batched unmap
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@redhat.com, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, lorenzo.stoakes@oracle.com, 
	ryan.roberts@arm.com, v-songbaohua@oppo.com, x86@kernel.org, 
	huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, riel@surriel.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com, 
	mingzhe.yang@ly.com, stable@vger.kernel.org, Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 7:15=E2=80=AFPM Lance Yang <lance.yang@linux.dev> w=
rote:
>
>
>
> On 2025/6/27 14:55, Barry Song wrote:
> > On Fri, Jun 27, 2025 at 6:52=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Fri, Jun 27, 2025 at 6:23=E2=80=AFPM Lance Yang <ioworker0@gmail.co=
m> wrote:
> >>>
> >>> From: Lance Yang <lance.yang@linux.dev>
> >>>
> >>> As pointed out by David[1], the batched unmap logic in try_to_unmap_o=
ne()
> >>> can read past the end of a PTE table if a large folio is mapped start=
ing at
> >>> the last entry of that table. It would be quite rare in practice, as
> >>> MADV_FREE typically splits the large folio ;)
> >>>
> >>> So let's fix the potential out-of-bounds read by refactoring the logi=
c into
> >>> a new helper, folio_unmap_pte_batch().
> >>>
> >>> The new helper now correctly calculates the safe number of pages to s=
can by
> >>> limiting the operation to the boundaries of the current VMA and the P=
TE
> >>> table.
> >>>
> >>> In addition, the "all-or-nothing" batching restriction is removed to
> >>> support partial batches. The reference counting is also cleaned up to=
 use
> >>> folio_put_refs().
> >>>
> >>> [1] https://lore.kernel.org/linux-mm/a694398c-9f03-4737-81b9-7e49c857=
fcbe@redhat.com
> >>>
> >>
> >> What about ?
> >>
> >> As pointed out by David[1], the batched unmap logic in try_to_unmap_on=
e()
> >> may read past the end of a PTE table when a large folio spans across t=
wo PMDs,
> >> particularly after being remapped with mremap(). This patch fixes the
> >> potential out-of-bounds access by capping the batch at vm_end and the =
PMD
> >> boundary.
> >>
> >> It also refactors the logic into a new helper, folio_unmap_pte_batch()=
,
> >> which supports batching between 1 and folio_nr_pages. This improves co=
de
> >> clarity. Note that such cases are rare in practice, as MADV_FREE typic=
ally
> >> splits large folios.
> >
> > Sorry, I meant that MADV_FREE typically splits large folios if the spec=
ified
> > range doesn't cover the entire folio.
>
> Hmm... I got it wrong as well :( It's the partial coverage that triggers
> the split.
>
> how about this revised version:
>
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> may read past the end of a PTE table when a large folio spans across two
> PMDs, particularly after being remapped with mremap(). This patch fixes
> the potential out-of-bounds access by capping the batch at vm_end and the
> PMD boundary.
>
> It also refactors the logic into a new helper, folio_unmap_pte_batch(),
> which supports batching between 1 and folio_nr_pages. This improves code
> clarity. Note that such boundary-straddling cases are rare in practice, a=
s
> MADV_FREE will typically split a large folio if the advice range does not
> cover the entire folio.

I assume the out-of-bounds access must be fixed, even though it is very
unlikely. It might occur after a large folio is marked with MADV_FREE and
then remapped to an unaligned address, potentially crossing two PTE tables.

A batch size between 2 and nr_pages - 1 is practically rare, as we typicall=
y
split large folios when MADV_FREE does not cover the entire folio range.
Cases where a batch of size 2 or nr_pages - 1 occurs may only happen if a
large folio is partially unmapped after being marked MADV_FREE, which is
quite an unusual pattern in userspace.

Let's wait for David's feedback before preparing a new version :-)

Thanks
Barry

