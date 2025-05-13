Return-Path: <stable+bounces-144232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF09AB5CB8
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526D216EB8E
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596AB2BE0FB;
	Tue, 13 May 2025 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIX3BSzK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7221E521A
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162154; cv=none; b=hmEMoX6nHgToh+/otT5cfLnuqq0OI8tFvxn3QD2sjPXElF/ZT+MJaat+Dklum6YMtEkfyWnpjrUeAh+UjoCVdmKWQpCrEFAFj4nGLbeyRoF7v++rZ0EAdZM2e3velwMgTZvZCQwBBLOtrOU5y3c6yQXSrsKeCZ5w6ZMh5cRxYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162154; c=relaxed/simple;
	bh=HXpQ+XhRTUzoizh8ninO87sQNl4Zns6oirDfGFeyqbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJQY1AecjoY96Ls8d040QbSa3hXRomgP91SFGb6+7QbO/92+Skgg7xVVwT4cpb71MXq2zIQRstjJbwS84uIOKYSs/38A0inVr5z1nf7eHQodd4FuBun6N8ImVire+ZBP95uHydSpQFLDN+LN0f7068bIws0f8PUUBmAbMQuihJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIX3BSzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E56BC4CEE4;
	Tue, 13 May 2025 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162153;
	bh=HXpQ+XhRTUzoizh8ninO87sQNl4Zns6oirDfGFeyqbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIX3BSzK41Ln8G9Ls+dZkStOk0KV1nXVqD0ktdBf5cCSoer0RunoiWgwc2wMsvska
	 Op2nMX3YU/PZyCoXiYjUN346d7arjyFR/nvPc3BPsMe8dRRtHV0lqL4zWBWsSpgiAO
	 jIxf8lNURFwWROcI7jw9XAVpeN1KDCurQSWKjdHOWODzWYdMaFsaGuh5Svq19M5UNV
	 gAR1xMrI7buNFDGKBv+v2BsQxfF1YpaXdpqgyU4QTAI2G1L7rEU7yDmrEnCTjO5rnK
	 3VsDxQivNhhefw0SdWgyzvH8JkXRrCkCl45Us5+/GTL6NcP4eSZTIrqqHOO+oCTKnO
	 XYa0a4NnyR3FA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	chenhuacai@loongson.cn
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH for 6.6] mm/migrate: correct nr_failed in migrate_pages_sync()
Date: Tue, 13 May 2025 14:49:09 -0400
Message-Id: <20250513100247-4397f54215e2532d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513080521.252543-1-chenhuacai@loongson.cn>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: a259945efe6ada94087ef666e9b38f8e34ea34ba

WARNING: Author mismatch between patch and found commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Zi Yan<ziy@nvidia.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  a259945efe6ad ! 1:  90d3b4a4b9916 mm/migrate: correct nr_failed in migrate_pages_sync()
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

