Return-Path: <stable+bounces-132768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8720A8A505
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 19:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5103C190219D
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34992185A8;
	Tue, 15 Apr 2025 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIaZ6HVE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F502144A5;
	Tue, 15 Apr 2025 17:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744736968; cv=none; b=PZlOWVZUs3kjAO47ekKuxqjBuU/GHP8XY2mRpNXty/Ptx+jsZHbYfTDmRykGcEEG5WDsLGf1eHyDJI30H5gfWj41ymm/gJeRd5/YbZlOquoYzpbrOwng2eD+/fixgndnv7xTHtGhSNPaMHjC8jeWFRfJKwtCeQhh1gzFOoc1hpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744736968; c=relaxed/simple;
	bh=SgrGKMJjm2J5IVtjuuv5R9BE+MBPc6XwFUmwfGdQHko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kmg37uA68gTv8A+dIJzBUWe5VVMKEtuyeqpgtSIfM/T+VgDDgd3YUhN6ggAqHbqePmqKe/+THZP7r99bcyuS3BL5Kz6uT2IkUll441keMozc/2C1dTd6BOv2bv/X0nZ6pmL9JkGcmUpb6N8AOg08mScV/VHujZnSqXbPHoprvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIaZ6HVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFA0C4CEE9;
	Tue, 15 Apr 2025 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744736967;
	bh=SgrGKMJjm2J5IVtjuuv5R9BE+MBPc6XwFUmwfGdQHko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIaZ6HVElbltfloi/NUssZLPipBW0GiYmem6zftx6ii18xmFVX/NaBwu2D4yl4tdR
	 UQJnXoNdFv2CYt23hJes5AtilCPebal4puc0KDdT7yG47E/BP9dCisRAbqvjfPOr+n
	 0Yc4c+CMdp4Kz8neYA+aaR9064xF8NnzuQwr3yJo2125sC2YIp0J9WQPSqYg87QF+k
	 K63F7iI/mmPR8pkf4FT4AsvWbh4G3XMueSPnZ0M5GkiG2BofdhLb1g1IZOhh97hqU+
	 ZvZY/SgEXqwpNEbBbJoCPr8rriT3hjfVDQ4cCIvytuHCInyreYtb4LpR9banB+RBLR
	 CDIgceZ1bA/5A==
Date: Tue, 15 Apr 2025 10:09:24 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org,
	ryabinin.a.a@gmail.com, elver@google.com, andreyknvl@gmail.com,
	smostafa@google.com
Subject: Re: + lib-test_ubsanc-fix-panic-from-test_ubsan_out_of_bounds.patch
 added to mm-hotfixes-unstable branch
Message-ID: <202504151009.C1C7343CC@keescook>
References: <20250415001108.79E0BC4CEE2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415001108.79E0BC4CEE2@smtp.kernel.org>

On Mon, Apr 14, 2025 at 05:11:07PM -0700, Andrew Morton wrote:
> 
> The patch titled
>      Subject: lib/test_ubsan.c: fix panic from test_ubsan_out_of_bounds
> has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
>      lib-test_ubsanc-fix-panic-from-test_ubsan_out_of_bounds.patch

Let's get the v2 instead of this version...

-- 
Kees Cook

