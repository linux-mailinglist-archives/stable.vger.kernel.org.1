Return-Path: <stable+bounces-127447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD9A797A5
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 23:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1A6166626
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 21:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C1919D897;
	Wed,  2 Apr 2025 21:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBBSSkjS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11892288DA
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629135; cv=none; b=teZvQ+3PBZYKkxxrOYWozRsyqi7v+9hZIV2uqeGLiefnCATh387SvUYPoqp452DPL+VZw0IKJva/LeyO+XCgY4EVVqVIKQMBHLm3xBJ4WYitJgUbjLnEWXCu4QJFnAuUzB8c3mBIQMfBoHeYpVObU3BaiOyH22q8TLbVSs3jwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629135; c=relaxed/simple;
	bh=UMqAu8LJK6hf6q/u1NsfkjVzUngMYeGfNgnrtOyQnE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlmUxkjW2WBGYDVQZH7CvYzsKOHuECNM12ASF7f8heFWPQzZeLoOv2lfbtqUraRUfH4xi0MN0K0nyhGCmO8BfcUvIrIGTm4PEZ+u4DywEb9owkFc3M5ldIlFsMsubQD2nSkBj4HYks8ZFHQqFDKZPEAWtvkmWGrKJBJ+Tqzjf9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBBSSkjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2189AC4CEE8;
	Wed,  2 Apr 2025 21:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629134;
	bh=UMqAu8LJK6hf6q/u1NsfkjVzUngMYeGfNgnrtOyQnE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBBSSkjSJptm86Hgt+MK6b6Mn06puZxI7ZJRIX8/Dcj41+oH6K/eQjcvyKV5Oi8yC
	 /iIj+loPQp/Qdh55JIODrQeyFzP3NAmdt7PRh+voNUIBVjwYrCH4iTorRYwwUBwgPy
	 iK9zVNaLD+iK6wJ8gNgJQd9dULZqxfvOn6NIW9qNRtu3WpJcscEplDoqeYsHdsbrlM
	 mCUkxcciVJb2HnTwUoL4LmXY5oVRCl6l8dVA6fEgtRAAgKcXILh87rFmXlRMiZ3HKe
	 3wGqgTPL6pG6uBsocokycXUAnTwr/1+znxEmvOOqLFT8m3TYobyHO4Im+rc0kElK/E
	 XNxrumRgt8G0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kang Wenlin <wenlin.kang@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 1/6] binfmt_elf: Support segments with 0 filesz and misaligned starts
Date: Wed,  2 Apr 2025 17:25:30 -0400
Message-Id: <20250402131208-df6f6a2c654234d4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250402082656.4177277-2-wenlin.kang@windriver.com>
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

The upstream commit SHA1 provided is correct: 585a018627b4d7ed37387211f667916840b5c5ea

WARNING: Author mismatch between patch and upstream commit:
Backport author: Kang Wenlin<wenlin.kang@windriver.com>
Commit author: Eric W. Biederman<ebiederm@xmission.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  585a018627b4d ! 1:  bb3401d71e115 binfmt_elf: Support segments with 0 filesz and misaligned starts
    @@ Metadata
      ## Commit message ##
         binfmt_elf: Support segments with 0 filesz and misaligned starts
     
    +    commit 585a018627b4d7ed37387211f667916840b5c5ea upstream
    +
         Implement a helper elf_load() that wraps elf_map() and performs all
         of the necessary work to ensure that when "memsz > filesz" the bytes
         described by "memsz > filesz" are zeroed.
    @@ Commit message
         Signed-off-by: Sebastian Ott <sebott@redhat.com>
         Link: https://lore.kernel.org/r/20230929032435.2391507-1-keescook@chromium.org
         Signed-off-by: Kees Cook <keescook@chromium.org>
    +    Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
     
      ## fs/binfmt_elf.c ##
     @@ fs/binfmt_elf.c: static struct linux_binfmt elf_format = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

