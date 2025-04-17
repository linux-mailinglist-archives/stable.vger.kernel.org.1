Return-Path: <stable+bounces-133027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B204A91A77
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD4A462546
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 11:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB349239597;
	Thu, 17 Apr 2025 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1+Zt5km"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1C7239595
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888699; cv=none; b=TP6CImZxsyDWroAvOvQv9ovvqHNUu+bqymRF4QAyKEqNAqAnlsLd1FYqTp2wWejUWHtxxAMORpiNdfdCbQxs/leGr7B9ktax1YGcQfE57JrV9tIlFZhsJ3lMhnmrAhZ9BYNenDH2+hPsoYSVwZmfTQxZoFS/muNtKb53JoSs9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888699; c=relaxed/simple;
	bh=W73QhjPJp97HuGVCKiT6ONt+AmUOO7DxHiZh5k/bZbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGO3IuhFCpYk13vbdwQSQlmJ5FC45OHygSJYNPPShWPqgNZ9IMDtu9POct6/rwkVctL1hxeFHLJhaZwFaOGh2fyQcqfx1GOqktiyiRaUm2yKSiDdPGc85aF9WS7ici8KqOyHkMWpBJCqoynLrz2kEuGKTjeMv0TeqyJ0wvbF4QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1+Zt5km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF3DC4CEE4;
	Thu, 17 Apr 2025 11:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744888699;
	bh=W73QhjPJp97HuGVCKiT6ONt+AmUOO7DxHiZh5k/bZbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i1+Zt5kmsd0AY1Fec0T0VkQGc1WaHxgQPI/pbJikhrh15d16v3FnQNOVj1IQcGOdl
	 yeTxXdTctroLSZPsE/3KJmIMKEYLMDoVJyie9Z+qVXyJU86yXAYm+x4YGcyj0428yw
	 mLe9nLbXA3A5Wr1i20UY1Sj91k1kEO0xjzcsAMWYPvz6ZtbexE8l3dybd9mbUOZClD
	 tqoGqmVXt1EFfJGdvtti8ftzDu1ugWo/wVCgP+sb4F3cc1LBIOylOgKtM4JyPb25WA
	 KgjoCakLpuPn4SvBptBbf9Pkglb5QXb8M7L/xu60fK82j8Hh6ORVYVwnF1ntcE5yls
	 pKj4WhthQFfFw==
Date: Thu, 17 Apr 2025 12:18:13 +0100
From: Will Deacon <will@kernel.org>
To: gregkh@linuxfoundation.org
Cc: pjaroszynski@nvidia.com, apopple@nvidia.com, catalin.marinas@arm.com,
	jgg@nvidia.com, jhubbard@nvidia.com, nicolinc@nvidia.com,
	rananta@google.com, robin.murphy@arm.com, sj@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] Fix mmu notifiers for range-based
 invalidates" failed to apply to 6.6-stable tree
Message-ID: <20250417111812.GA12231@willie-the-truck>
References: <2025031650-yarn-arrogant-2584@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031650-yarn-arrogant-2584@gregkh>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Mar 16, 2025 at 08:23:50AM +0100, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I sent a backport here:

https://lore.kernel.org/r/20250411172804.6014-1-will@kernel.org

Will

