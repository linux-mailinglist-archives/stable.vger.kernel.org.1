Return-Path: <stable+bounces-119879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF86A48EAF
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 03:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADCE3A7CED
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 02:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8418C70814;
	Fri, 28 Feb 2025 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmMjitD8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A5276D38;
	Fri, 28 Feb 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710148; cv=none; b=pHphiUm79qf18wOLIf5Ju5WY7+X8SVQJrvZUloplLQRfTv8Qe6YdoMGRNdgRuLfv7terjOEJrWUUtmd5iyWdQnrinEvtadv0YRpJtph7C7IHuoCTnZLqCJbckLOb1bgg8ay1cb8p9tTp9E3ia1fjBZNuLBta48HgnX7jsh4Os+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710148; c=relaxed/simple;
	bh=mPYw4QtWI6b6bDDohPnfGl05s5iuP5VCTsCxQaqOyug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ay+k2MWQN5ApsvCrx5CE/RAY/CJdoWKRbMyHeh0RNyM7kAQbVK+QD0pfRCFimQYL2RJ6rRmgT6HcK/mdJLF/9Fs4IvbptYsXS67/g+TJVjm4vndjPC/OPnUOlB/CF4Hr4Ejylt6vkYAIfXZz9gyfyYjmDfdvylWb8T4MRO8DHb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmMjitD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E87C4CEDD;
	Fri, 28 Feb 2025 02:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740710147;
	bh=mPYw4QtWI6b6bDDohPnfGl05s5iuP5VCTsCxQaqOyug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jmMjitD8MqAkQdJCrpH+yb2ZxSj8PoHtWyuVi+skqgrhC6ZsN3oeGtzNuCPWU8qav
	 zEl4D/HDfuzf+Sa98HT0ZvZzBapAJt2XI0Kqxep7tI59wF4hCrT7LlJjTDr5AaN4aw
	 E5ayk3NKMZfmjmREG+tHx+wqGFazG79fThpFTs4N1wdakDR+MUr/1G+A6GWdVDUbQV
	 AdRBoZxSdGnIA9/FMnmbWDQEQkfBy8Wj5zOKDrTIp1kngbmor7OnZkbVsCi9n21JCU
	 b5p8lEHBQ/yGgVTBkh08Zp9YGlNbDhOfVihj2w2yoNQaQ1b6Fleu1hj4yu5MEMAVJT
	 EyQEwxqBVUQmw==
Date: Thu, 27 Feb 2025 18:35:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Huacai Chen <chenhuacai@kernel.org>,
 Yanteng Si <si.yanteng@linux.dev>, Yinggang Gu <guyinggang@loongson.cn>,
 Feiyang Chen <chenfeiyang@loongson.cn>, Philipp Stanner
 <pstanner@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Qing Zhang
 <zhangqing@loongson.cn>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Henry Chen
 <chenx97@aosc.io>
Subject: Re: [PATCH net-next v4 1/4] stmmac: loongson: Pass correct arg to
 PCI function
Message-ID: <20250227183545.0848dd61@kernel.org>
In-Reply-To: <20250226085208.97891-2-phasta@kernel.org>
References: <20250226085208.97891-1-phasta@kernel.org>
	<20250226085208.97891-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 09:52:05 +0100 Philipp Stanner wrote:
> pcim_iomap_regions() should receive the driver's name as its third
> parameter, not the PCI device's name.
> 
> Define the driver name with a macro and use it at the appropriate
> places, including pcim_iomap_regions().
> 
> Cc: stable@vger.kernel.org # v5.14+
> Fixes: 30bba69d7db4 ("stmmac: pci: Add dwmac support for Loongson")

Since you sent this as a fix (which.. yea.. I guess.. why not..)
I'll apply it to the fixes tree. But then the other patches have 
to wait and be reposted next Thu. The fixes are merged with net-next
every Thu, but since this series was tagged as net-next I missed
it in today's cross merge :(

