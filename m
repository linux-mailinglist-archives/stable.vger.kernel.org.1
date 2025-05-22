Return-Path: <stable+bounces-145995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C083BAC0234
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD8F1630FD
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5548C4D8D1;
	Thu, 22 May 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/x+Nm5f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137273F9FB
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879645; cv=none; b=ICquGAdhuH0s6V/AfcfFV1OHbgEtGS2x5nqjgmzRPRJdLxIldYqXv/cMi5CoZ7YgUOAyvN831BSBdmgqho42TEWZzsZXIiOVLH26EyQBTBWJyLp3FG/0Qc/MF5BWbtrRNZA4Z2dcelYpnZAtM1sH9Xr1McsUJj3OjxYKAnPmKhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879645; c=relaxed/simple;
	bh=3fVm6rTVjmeO47JPRdB6+vfd6n7v6CuFk0/mor+3q5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nsxa31FfeOSDScpxdxtP80P4zti7JQVY79ax98LgPATbclyglpWzrKPMhwJOOUGW8exDjU0cidek0hpdNbxw943ZVvJJFYnkw90jO5CLgsatQCaWsjnV7tRROGJpzIHIxVA9roawnZ0/O9YEplW4GGgccH0rphh7c3oGKqtcxXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/x+Nm5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19594C4CEE4;
	Thu, 22 May 2025 02:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879644;
	bh=3fVm6rTVjmeO47JPRdB6+vfd6n7v6CuFk0/mor+3q5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X/x+Nm5fUw4tXHfncwgWlRh8qaAlbSgA461cqSM2P4g2bTSwiUA6u0nkt76A0mhhA
	 R80mNg9LKRA9JJoxhOvzmBdE+Ob2gDdyYlX+7zcw/ZzW2ct28eS0B2HKkwBQzG3Yd0
	 JBxNYHS46BnBnnroa+zsVL74CqTBac3ylZN8AKaaAQqXuWAT5C2S68ggboUUbEqmjc
	 uDbIAVfcAk/X4wxtKtaQHBtypG2OI/VPoZ8TQZazNH4MhLmtD8hokJVrYHlZnV5yZL
	 xDTktHvjmKyxmUrc62v9RmQYzM8t/rj9j6m7p6iit85/T06U1NifgH704kmL8MteiU
	 KblONLG7nlRxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 25/27] af_unix: Add dead flag to struct scm_fp_list.
Date: Wed, 21 May 2025 22:07:20 -0400
Message-Id: <20250521215035-681f2c82e117d062@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-26-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 7172dc93d621d5dc302d007e95ddd1311ec64283

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  7172dc93d621d ! 1:  f8f884570679e af_unix: Add dead flag to struct scm_fp_list.
    @@ Metadata
      ## Commit message ##
         af_unix: Add dead flag to struct scm_fp_list.
     
    +    [ Upstream commit 7172dc93d621d5dc302d007e95ddd1311ec64283 ]
    +
         Commit 1af2dface5d2 ("af_unix: Don't access successor in unix_del_edges()
         during GC.") fixed use-after-free by avoid accessing edge->successor while
         GC is in progress.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240508171150.50601-1-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 7172dc93d621d5dc302d007e95ddd1311ec64283)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/scm.h ##
     @@ include/net/scm.h: struct scm_fp_list {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

