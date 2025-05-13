Return-Path: <stable+bounces-144228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C71AB5CB4
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2A0164C6F
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4555B2BF979;
	Tue, 13 May 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdnRiQm7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B332BF3FD
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162137; cv=none; b=djDtfoJaAzNz4SEF90D5mh0TqLcPNcKjwz27aUozkYqwxxU1UNZw0J3B+3rrRDLAaEf4LKkB4KXViPVIarHRbqR8Gg4ZH43Dd7qC2LYVMUZ7iUKONqi5+zyChi3LC79mmylKgtAAOFK/RDRCU8+BMT7If95ojbCNwyHNbPZtQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162137; c=relaxed/simple;
	bh=TlPP1GFa+AlDnlFe64TCg5L2fk2QRrm6P6S+0z2IL3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnOozi2slltKOA8p/PgwXQZ0sblp0MaAWth4GPo3v5v4zymJ2DMTIrGuBdN/bWfkVr5pItqQcu0q/DAeSIo+05E3eqIBzjhQSkVD73YvLk15J61AW1b312MP6/fIzrWN8T7pJ9Ac3uvvwNkKi/2HrK6b3C0Tkn3vo40Gl7+9Gc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdnRiQm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A615C4CEE4;
	Tue, 13 May 2025 18:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162136;
	bh=TlPP1GFa+AlDnlFe64TCg5L2fk2QRrm6P6S+0z2IL3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdnRiQm7j2h5ge4TEg9LgemCKh8TdPts457Qw/ujKSzHN/KfBDRtKWav3SNQxJNQA
	 8P0cUanM1POd6zIOg7HCvQLcvkjj6NNIjor4qVsJ0etOCYLcspmXmmHvUu6sDapPOL
	 sPerZrdMOVbkYDeRCh/EwYj5L1Fr/02e6kacrj3dUX93a/8hOGPloX5qrf31sl5Idz
	 to7eNidcDeoCJqqcDKoKaT0cVIKVa5MOplMvhYKpWMm3cZTzqMNmGsTWEV5zFcVbDV
	 lTy1UzjqCHhPvGmiIWN2sRwycmLgPM8DokEtv8PqEcEoaUAkT7sX2NUtN2Pe3eY61o
	 +uHhQPtxjQFLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH V2 for 6.6] mm/migrate: correct nr_failed in migrate_pages_sync()
Date: Tue, 13 May 2025 14:48:53 -0400
Message-Id: <20250513105809-aaba5731e040f208@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513081647.252911-1-chenhuacai@loongson.cn>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: a259945efe6ada94087ef666e9b38f8e34ea34ba

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Zi Yan<ziy@nvidia.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  a259945efe6ad ! 1:  b80fbf97fca7b mm/migrate: correct nr_failed in migrate_pages_sync()
    @@ Metadata
      ## Commit message ##
         mm/migrate: correct nr_failed in migrate_pages_sync()
     
    +    commit a259945efe6ada94087ef666e9b38f8e34ea34ba upstream.
    +
         nr_failed was missing the large folio splits from migrate_pages_batch()
         and can cause a mismatch between migrate_pages() return value and the
         number of not migrated pages, i.e., when the return value of
    @@ Commit message
         Cc: David Hildenbrand <david@redhat.com>
         Cc: Matthew Wilcox <willy@infradead.org>
         Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## mm/migrate.c ##
     @@ mm/migrate.c: struct migrate_pages_stats {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

