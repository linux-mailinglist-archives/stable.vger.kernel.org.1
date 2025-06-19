Return-Path: <stable+bounces-154775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C6FAE016F
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0C91897971
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2022921C186;
	Thu, 19 Jun 2025 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Plp3ENdZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4037202F7B
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323864; cv=none; b=AZQoV/kTXl92/VBa8kYeAbESzdkjaUei2gN8HF3rX9k4iUkQzaLbYQlMIoF09PmlrA7LK81PSwlHJIETL/jyarX/osw9CZ4rKWE0aXoPTg4NJEAEOX2gqIP29SwpxfWEUrm9GlcbzmjjGAgQYzA99Th34D8IxWIyUY0FXCan9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323864; c=relaxed/simple;
	bh=3wUcSn0UI31h4WRRFFhEHCpwC9ZdXTjUtfRkoKmC9GY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eNV1QVRitTmsKfNBkeR+kGCX8v6C7Cl2e9t/H1YNS/7uHt9d+aihRHN+I5O6x/DZMwghh0oyHtBJryUOF/S644IY2LAjSV33NOl3oAQYM8xJD7Hju9zUgAdqvcxcatFrzP6SRuuMuVvbeKnFRW/4rHwdCqt3OZGJkTVeoCGP39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Plp3ENdZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F7AC4CEED;
	Thu, 19 Jun 2025 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323864;
	bh=3wUcSn0UI31h4WRRFFhEHCpwC9ZdXTjUtfRkoKmC9GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Plp3ENdZ0S+4Xej2mDHn04XAVJTcuZONgRaiUFURgcM9JDtNklhevUycJRnjmF57H
	 QGalz9l+RlbPibDkpGtRI6HnMroB+9gi9tg93OJxeEv9/MZNSOKHOhpb6I68hAGHRU
	 qJvwEmqyBUZiZNFOa3ODcaXsitVKEJoOyafLLPfhc3Yqw2zW9/f6bWBtKzyhljhs60
	 3YnQUfKHM9xxChO8dDYGGUScIDF2e3vnGaPsz25gDaMZZ+IWKfokyGjnrizxfISWLe
	 B8npJkE1Kd2aY7xzM5C8+UEHJ8gggsdr8dKh2UnyW8AZ7KXp0fHF1cUd2gW40DSnIy
	 f40LprYM8tagQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 07/16] x86/alternative: Optimize returns patching
Date: Thu, 19 Jun 2025 05:04:22 -0400
Message-Id: <20250618174213-ea78bf1980924e73@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-7-3e925a1512a1@linux.intel.com>
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
ℹ️ This is part 7/16 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: d2408e043e7296017420aa5929b3bba4d5e61013

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Borislav Petkov (AMD)<bp@alien8.de>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 7e00c01ff80f)
5.15.y | Present (different SHA1: a70424c61d5e)

Found fixes commits:
4ba89dd6ddec x86/alternatives: Remove faulty optimization

Note: The patch differs from the upstream commit:
---
1:  d2408e043e729 ! 1:  65a8ca8c4840f x86/alternative: Optimize returns patching
    @@ Metadata
      ## Commit message ##
         x86/alternative: Optimize returns patching
     
    +    commit d2408e043e7296017420aa5929b3bba4d5e61013 upstream.
    +
         Instead of decoding each instruction in the return sites range only to
         realize that that return site is a jump to the default return thunk
         which is needed - X86_FEATURE_RETHUNK is enabled - lift that check
    @@ Commit message
         Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
         Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Link: https://lore.kernel.org/r/20230512120952.7924-1-bp@alien8.de
    +    Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
     
      ## arch/x86/kernel/alternative.c ##
     @@ arch/x86/kernel/alternative.c: static int patch_return(void *addr, struct insn *insn, u8 *bytes)
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

