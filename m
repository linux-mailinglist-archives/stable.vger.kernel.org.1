Return-Path: <stable+bounces-183492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE02BBF33F
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 22:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E40189BBB0
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603652DCC17;
	Mon,  6 Oct 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZBtdUVa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A08244685;
	Mon,  6 Oct 2025 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759782882; cv=none; b=tPlPf6JzuCjHakVw5JF4AUt0xX/MnHn1CuiAjo1STUl17pSZ3iNduwTC+KCCPMJHsdEd283aRSHR6fjZQ4JeRH21XJEjZH4IgsLy6HH13omRXxvBCPP+g/ADCdWlyKq8pyoUlaoHIhE2ZgSCde6Y48Ab+R+Wr5UM6rC86qis3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759782882; c=relaxed/simple;
	bh=c3t15lOefwVAAOuvSSShpCGZ3VoHfG+ZXf5muYks8Ao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kjV1aa+M9K068s28BPWaFyWsuDyPfNVFhAHRqrRKe/I0eblTOBYlXG7Si3V/cAEj6pZK04f/v4raWlQyfPL7hOaP4gmMvYuhj2MZuVqQMRqmify03Cj8U0ieuDC/sBpawUhEQyu/fEWkbFQByc6iv4O9f6SOUK561/5yir/9tdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZBtdUVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBB5C4CEFE;
	Mon,  6 Oct 2025 20:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759782881;
	bh=c3t15lOefwVAAOuvSSShpCGZ3VoHfG+ZXf5muYks8Ao=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QZBtdUVaB/vr8yjrPFPdFk/BaAjok3QsdyhQOTFxmddT51D5FqoqKlQHNwJQeoPo8
	 Uxo+h2WQS32HlsrrxedD/xaNoFFHq8tPMT8O27UWeZIRKlydjm/mNR6ooRuZOKjVc0
	 idYxTx5Ofo7bXJ1h3Qf4+6jf6TkgbHGB9FQHGx43kGV0FpuDU4SIlkR6s5cnmEglYn
	 O5g0TbG6DJ3XecHcx/44NQO+8nk3gtFwA2elL1Gu9pIa+DYQ3Wv8H6+4K6aItrOBQs
	 4C4a1kvpqssXWGwUbrF56Dk5Oo6AXOFnBkOyKcWOjJ1iXIshqempi9MG36WDvJ5Co9
	 /iku2fzIT/wLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA039D0C1A;
	Mon,  6 Oct 2025 20:34:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] page_pool: Fix PP_MAGIC_MASK to avoid crashing on
 some
 32-bit arches
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175978287125.1522677.13468458175773865166.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 20:34:31 +0000
References: <20250930114331.675412-1-toke@redhat.com>
In-Reply-To: <20250930114331.675412-1-toke@redhat.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHJlZGhhdC5jb20+?=@codeaurora.org
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, hawk@kernel.org, ilias.apalodimas@linaro.org,
 kuba@kernel.org, almasrymina@google.com, stable@vger.kernel.org,
 deller@gmx.de, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Sep 2025 13:43:29 +0200 you wrote:
> Helge reported that the introduction of PP_MAGIC_MASK let to crashes on
> boot on his 32-bit parisc machine. The cause of this is the mask is set
> too wide, so the page_pool_page_is_pp() incurs false positives which
> crashes the machine.
> 
> Just disabling the check in page_pool_is_pp() will lead to the page_pool
> code itself malfunctioning; so instead of doing this, this patch changes
> the define for PP_DMA_INDEX_BITS to avoid mistaking arbitrary kernel
> pointers for page_pool-tagged pages.
> 
> [...]

Here is the summary with links:
  - [net,v2] page_pool: Fix PP_MAGIC_MASK to avoid crashing on some 32-bit arches
    https://git.kernel.org/netdev/net/c/95920c2ed02b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



