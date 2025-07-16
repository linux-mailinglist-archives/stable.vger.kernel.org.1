Return-Path: <stable+bounces-163168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB0EB079BA
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 17:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1315A1AA0D22
	for <lists+stable@lfdr.de>; Wed, 16 Jul 2025 15:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1F92F50B8;
	Wed, 16 Jul 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXNZqmiM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31A2F50B1;
	Wed, 16 Jul 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752679285; cv=none; b=KxcMoCZgCUGEL+KR6LnQr9yShUWWpRR7DKZaV/ivEVnBpQgjcBrEmA+6rxAzczgHmPhezGrjjWg2DUm9QPoFDKhkeejqC57WEmTuj+1/7hA8WKdgo+jN2YVuPEsVtWOfi1f6xw7oJbe9kOKk5dFvYt+190rPntwlcTAiMLdP9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752679285; c=relaxed/simple;
	bh=p2u05dLVtqQJ3foGrWJXooMdrDiQBdBaUfjuYdOfRI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VEToshdnukzeWazEVazZkVybY8YKnOi/PqTCR2fW8aV6+20nHygim318F3YmK8sS6HqUKU+zGw7Hi+lhXH0QJBFl0SxnFah+D+DACjffPdLec+G/fCM4aTZfG4w0x0S/d3UziOFBmLRbu/F5H/pP7aQ9KXo9HxPKx+HH0SoSSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXNZqmiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D866C4CEF0;
	Wed, 16 Jul 2025 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752679284;
	bh=p2u05dLVtqQJ3foGrWJXooMdrDiQBdBaUfjuYdOfRI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GXNZqmiM3oopAWeII/q3vlE8pvrAug8t7A6wOb+mZy/DJcXF/RELXBzf30puyUdIf
	 PEw3d7vZ5vmLIX2Xq09I4ZyXuSbI+5Pb8N8RV42b//+EXK/W3DbyLLQ0pOHTYanHAY
	 JX92xf8rrx7lZTC1MHYEAbzX2ArWb5myVqPJ8Y5D5R4cukMaQcrRysKjKUP32iu5Et
	 0ia8x2NEVTIQyrzRq0MEJ91tTnQFlcvFQ0p79hJ/naQEIGYFF6FVO33VJmuPXKLqVn
	 Dk+2KGtpQmzs4PjxM/G+VrGjhCvYY+0TvMLLvdNb0bqZPI1fta3xN4Eas7KfSsVOMd
	 atDjSa1cvJyqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2B757383BA33;
	Wed, 16 Jul 2025 15:21:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/1] mm/rmap: fix potential out-of-bounds page table
 access
 during batched unmap
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175267930477.1224517.13373842337541537594.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 15:21:44 +0000
References: <20250701143100.6970-1-lance.yang@linux.dev>
In-Reply-To: <20250701143100.6970-1-lance.yang@linux.dev>
To: Lance Yang <ioworker0@gmail.com>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 david@redhat.com, 21cnbao@gmail.com, baolin.wang@linux.alibaba.com,
 chrisl@kernel.org, kasong@tencent.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com,
 ryan.roberts@arm.com, v-songbaohua@oppo.com, x86@kernel.org,
 huang.ying.caritas@gmail.com, zhengtangquan@oppo.com, riel@surriel.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
 mingzhe.yang@ly.com, stable@vger.kernel.org, baohua@kernel.org,
 lance.yang@linux.dev

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue,  1 Jul 2025 22:31:00 +0800 you wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> As pointed out by David[1], the batched unmap logic in try_to_unmap_one()
> may read past the end of a PTE table when a large folio's PTE mappings
> are not fully contained within a single page table.
> 
> While this scenario might be rare, an issue triggerable from userspace must
> be fixed regardless of its likelihood. This patch fixes the out-of-bounds
> access by refactoring the logic into a new helper, folio_unmap_pte_batch().
> 
> [...]

Here is the summary with links:
  - [v4,1/1] mm/rmap: fix potential out-of-bounds page table access during batched unmap
    https://git.kernel.org/riscv/c/ddd05742b45b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



