Return-Path: <stable+bounces-77053-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF8984CDD
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 23:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0BDB236D7
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 21:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA80146A93;
	Tue, 24 Sep 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye3C+TBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D039146A87
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213043; cv=none; b=MyaY2SMIimn8M0ChjaPNm1cJg2208HV4aZjYNZlcGTuchbK8Oltky4ypA1DjTg9J1P6/BhzCgbS+Wg88R31uhV4umNQ489VatmP3a7sylfH4paG8ngCcUFc/L9WukCpzeZiiWwHXXr/anhqv/QT2VmyaxXKBwWm6rPTwdOPux/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213043; c=relaxed/simple;
	bh=VpaCwH0tvpXrXrqkogXmPmUbk2lTJRh3kdaMbA97Y8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr/qzK9eKaUpJwtFLW+jGkuNELBRv3SX/hHzoggxZOGYd6jTlUXAULKuAa5k8shz9tDeiD7NhVX5qPTwzsxwIUr1jg5a9DY27a6uoyr6RBMzX35mLQTx05XVEIbBDehJqsFOgMq2etiMXlpDeb+A0GoZ+nDpZA5fe509B3sn0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye3C+TBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C7AC4CEC6
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 21:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727213042;
	bh=VpaCwH0tvpXrXrqkogXmPmUbk2lTJRh3kdaMbA97Y8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ye3C+TBqO2z28f9G+01yXiwDWDNezz/i3gR0S7qXDKT+HUckDoPLS7QkWOp3Kg+vA
	 LbK6pb7/cJYtC5R45U6KsDj8Rwu07zkYYxMEl+3sYj4ZOHTHKDlLmwXfcL850OJ1JM
	 XUE4ROHnfCSOChjWjcYGp3wb8p6y9rene/s8tthh+fIdqUv8YyWpNgKX0yn2NAvYfg
	 0yA9w1AlvrcbG8l84opfdWTQmgalYQxQ0NarhAMIwHkm61UWQe+xvuf4M53iuN10JM
	 5Ih831YA7bIApjTiB1YglwVbZbl6JTs+4rckrCGfE6K+fiTlmPsVX9kBkWJoCS0lQJ
	 PRmPV20boLRNQ==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ddceaaa9ddso52057957b3.1
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 14:24:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdtFGlbCW3YynHMYOfiFn1A3WzqsIPQqUIy68mj5lfiiNqCMemv83cAbuaJ+1YSD/v5w7iEBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBrpRKAUQHlOdO4C95VfD/CP3ut/LevRzhcuPT7NOs7CeCpTUw
	fwZoR/4/SF1zBIiQarVxkxhtHia/TwlvzW2ooNnseTwmzrcoJyV/RRmksuo821h/tPIhF+d944X
	tbqaaWVS4CVHjCF3yhesjcJ7JDdHeKFMudYXeCQ==
X-Google-Smtp-Source: AGHT+IG+4wSBU/xx18St6qUUR5v1Snuoo4O4LMphOaTpEffHhcTiiuv0BSr6OU9e4wyoFlnXXYJtKNh0D27cNf0+7/k=
X-Received: by 2002:a05:690c:f8f:b0:6dd:f9ea:895f with SMTP id
 00721157ae682-6e21d70072amr8708607b3.12.1727213042128; Tue, 24 Sep 2024
 14:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-lru-flag-v2-1-8a2d9046c594@kernel.org>
In-Reply-To: <20240905-lru-flag-v2-1-8a2d9046c594@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 24 Sep 2024 14:23:51 -0700
X-Gmail-Original-Message-ID: <CACePvbV6mqi7A0AhCYP1umejz6QBR91ueTSH_enJZoLe=N_pWw@mail.gmail.com>
Message-ID: <CACePvbV6mqi7A0AhCYP1umejz6QBR91ueTSH_enJZoLe=N_pWw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: vmscan.c: fix OOM on swap stress test
To: Andrew Morton <akpm@linux-foundation.org>, yangge <yangge1116@126.com>
Cc: Yu Zhao <yuzhao@google.com>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	baolin.wang@linux.alibaba.com, Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I forgot to CC stable on this fix.

Chris

On Thu, Sep 5, 2024 at 1:08=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> I found a regression on mm-unstable during my swap stress test,
> using tmpfs to compile linux. The test OOM very soon after
> the make spawns many cc processes.
>
> It bisects down to this change: 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9
> (mm/gup: clear the LRU flag of a page before adding to LRU batch)
>
> Yu Zhao propose the fix: "I think this is one of the potential side
> effects -- Huge mentioned earlier about isolate_lru_folios():"
>
> I test that with it the swap stress test no longer OOM.
>
> Link: https://lore.kernel.org/r/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8S6N-MZU=
mErNAXoXmw@mail.gmail.com/
> Fixes: 33dfe9204f29 ("mm/gup: clear the LRU flag of a page before adding =
to LRU batch")
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Suggested-by: Hugh Dickins <hughd@google.com>
> Tested-by: Chris Li <chrisl@kernel.org>
> Closes: https://lore.kernel.org/all/CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q=
5-3BN9JiD9W_KA@mail.gmail.com/
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Changes in v2:
> - Add Closes tag suggested by Yu and Thorsten.
> - Link to v1: https://lore.kernel.org/r/20240904-lru-flag-v1-1-36638d6a52=
4c@kernel.org
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a9b6a8196f95..96abf4a52382 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4323,7 +4323,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         }
>
>         /* ineligible */
> -       if (zone > sc->reclaim_idx) {
> +       if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
>                 gen =3D folio_inc_gen(lruvec, folio, false);
>                 list_move_tail(&folio->lru, &lrugen->folios[gen][type][zo=
ne]);
>                 return true;
>
> ---
> base-commit: 756ca36d643324d028b325a170e73e392b9590cd
> change-id: 20240904-lru-flag-2af2f955740e
>
> Best regards,
> --
> Chris Li <chrisl@kernel.org>
>

