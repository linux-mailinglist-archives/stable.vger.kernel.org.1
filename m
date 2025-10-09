Return-Path: <stable+bounces-183711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA019BC9AFD
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 17:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6673A1CC9
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B22EBBAD;
	Thu,  9 Oct 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tT5m/GGB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA322E8DF0
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760022320; cv=none; b=pB1A6g2eASecW57q43oBC2l3ho7N/aM3bT8p+Yh6aM5AfQF6kHjfGYnbst8whg7WLT2XbpCNsf61yMjR74R8ey8t6Q+Jt6+TTEoW7Pc8tp0nA0+8oijy9qjQguXnA6sb7JIGMf3QGC3Pb3P6uJJAvyBIa/iWwuSAtEgD3+b9Vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760022320; c=relaxed/simple;
	bh=+PfzU55CzMRWuC5DZTzFvraslKE+s/HjnZAQ9HgA+hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSl0qYvQN72pGBcsnOcuHlCmxrjlXDNOl93scrh6B99lEINVKcYQMbY9sH+ezlmcjIAIJ2Rq8LnC/bTAntL9UYhZLbbwrJDmREMyw/SZsBa4xTuGpbubeDgVm2syOdptvogmIdy32JK0e2+NuHLQRpEY6DTH7fVqS+njA8BC4hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tT5m/GGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF4BC4CEE7;
	Thu,  9 Oct 2025 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760022319;
	bh=+PfzU55CzMRWuC5DZTzFvraslKE+s/HjnZAQ9HgA+hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tT5m/GGBcj8AI5oW3x3/YD+0FQK25YLW4Hn3evhC8Xsbwo95t2oX5j6sP/7x09B5K
	 KQ/UcYlsRVJfCqf7HZaxtNEYGpkCGYxvtlUfcwF8r+fRQ8qKTWpYeK9Kj6ShSSSyDb
	 Q1JDzS/9KxmdBLHb1JJ8aSrYuqqWpig8tK9VcvvEoBVuHOyK1fDanWe51Q2Pi+BuZM
	 q0GoWa/PGujm+8SRRv/KyQ8qrB7jXQlR5w2MRwSFS7EtE6UfZNCmDdp4d8sNd+boBB
	 RxRLJsmDbw9L+EfyXEd2v9s5SGPhwDmUa33XmTvVdp0udaRxxO1E8cspPhz0s/8181
	 fIIbmZg3tE8qg==
Date: Thu, 9 Oct 2025 09:05:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: pci-epf: Move DMA initialization to EPC init
 callback
Message-ID: <aOfPLXJlQwu5cas0@kbusch-mbp>
References: <20250909112121.682086-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909112121.682086-2-cassel@kernel.org>

On Tue, Sep 09, 2025 at 01:21:22PM +0200, Niklas Cassel wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> For DMA initialization to work across all EPC drivers, the DMA
> initialization has to be done in the .init() callback.
> 
> This is because not all EPC drivers will have a refclock (which is often
> needed to access registers of a DMA controller embedded in a PCIe
> controller) at the time the .bind() callback is called.
> 
> However, all EPC drivers are guaranteed to have a refclock by the time
> the .init() callback is called.
> 
> Thus, move the DMA initialization to the .init() callback.
> 
> This change was already done for other EPF drivers in
> commit 60bd3e039aa2 ("PCI: endpoint: pci-epf-{mhi/test}: Move DMA
> initialization to EPC init callback").

Thanks, applied to nvme-6.19.

