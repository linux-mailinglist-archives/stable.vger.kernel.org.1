Return-Path: <stable+bounces-47758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E45928D58B8
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 04:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895231F24BE9
	for <lists+stable@lfdr.de>; Fri, 31 May 2024 02:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C757711F;
	Fri, 31 May 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2UmkRY1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64166256D;
	Fri, 31 May 2024 02:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717123830; cv=none; b=H++iOnTel2tZ2hNVhpMUvO5ywfjGHRHsME1unIN/rlwockDvkC22y7dudKlDzoY0EOL22AFhXaLAd2Mx2dHSPHJsWYFfDgd2/JytqbCt5kf1c1lTwmdWZe2nt3oFj1SUlhZdoNRirSHTVSyEEY3ibp7lHTcCzkvuDeZL6563mkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717123830; c=relaxed/simple;
	bh=QDJ8YbhmGXMyUNUrXuBhbp93iWFoaOop/TTLaiT4ujg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IVDg2Oyo/xnD+70dFJTCsRcPbLcaa2Kl/SRKRPB5IJIck7+aybHQFu/9K52laeUla22BALEzTTwevgLjC56BuYURPjGDbvzE20VnQo5S0CBpMYCPt6IRwN0wXqSmA9fUT5KU1dWCfq+WNeWafwZIu0mjk4r7XBvztEmVocT7uvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2UmkRY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D46B0C3277B;
	Fri, 31 May 2024 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717123829;
	bh=QDJ8YbhmGXMyUNUrXuBhbp93iWFoaOop/TTLaiT4ujg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L2UmkRY1VKj10+fBWn8mmDVwJa/VkgYi2L08LDauF08mSq5fbqxw0PZxDkbJu2X66
	 GZQK3tfftj4WJCggWnJnPDmQ55G3beoXwktsliEmMCNMqMBZ+t+S7xwZjbP7qYOvte
	 swQJIvIksQi6vqS23sPWZlZ9o2bXWHPzA01XCT0FM30+wApHo4jQ0DYODTv6lC0BC8
	 DFWS+9Kxv+sDnf6dMeRnbtw/LyyFyrBJgBVtJzTaAGs8nKVtsdDERMqzTV/8jcdP1U
	 BYhbmkuSXvn2MYxk1gvXFtSgELY2LW4ZD0OzR+nadXu2JDaVManabNOO4Cu0Hu3dCs
	 qsUjSOY7mlswA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2F19CF21F2;
	Fri, 31 May 2024 02:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: fix overlap of allocated page and PTR_ERR
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171712382979.22953.17135876483679871225.git-patchwork-notify@kernel.org>
Date: Fri, 31 May 2024 02:50:29 +0000
References: <20240425115201.3044202-1-namcao@linutronix.de>
In-Reply-To: <20240425115201.3044202-1-namcao@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 akpm@linux-foundation.org, bhe@redhat.com, samitolvanen@google.com,
 chenjiahao16@huawei.com, bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
 rppt@kernel.org, bjorn@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 25 Apr 2024 13:52:01 +0200 you wrote:
> On riscv32, it is possible for the last page in virtual address space
> (0xfffff000) to be allocated. This page overlaps with PTR_ERR, so that
> shouldn't happen.
> 
> There is already some code to ensure memblock won't allocate the last page.
> However, buddy allocator is left unchecked.
> 
> [...]

Here is the summary with links:
  - riscv: fix overlap of allocated page and PTR_ERR
    https://git.kernel.org/riscv/c/a5e8a5b08a48

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



