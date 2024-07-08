Return-Path: <stable+bounces-58190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55750929A98
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 03:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D92B20B55
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 01:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB342EDC;
	Mon,  8 Jul 2024 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAKrdx/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A91EC7
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 01:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720403379; cv=none; b=kaMVGAZsUsYl8qBEF2LoZCTatlHaWmP48gbVrtmyOk+8wTcG87ZQxARAlk8pVNteTvv/gEVKwCtwEnxGclXyZ5S9NcVJ0OWR4yVTWsMdhRzD0Qw73LULw7+jGMd0qGOxknV5UMzLopzm7RosUsxwFDcp5b21b4+jahkB5JkNiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720403379; c=relaxed/simple;
	bh=FHtvJ9Ggpgn/fomoax1AtKWIQLssIUBxdD0VguZaEuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZo+DQ/z3uQo8twi+WDxsGNoa83SB7SU6EPj1UIN4NkcTBA8xk4IQVNoLByGOg4Zb3ccH+fRzJt/AKCbwHn0M6kx7ktHvqUQd1BNo+tTwc4evRFaHyQgFWiNAurRX0svMApJKoi0UOGHczoUUzMpRK0aczL/4zVsScLbB/Ez7J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAKrdx/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF1BC3277B;
	Mon,  8 Jul 2024 01:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720403379;
	bh=FHtvJ9Ggpgn/fomoax1AtKWIQLssIUBxdD0VguZaEuk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAKrdx/MRHk59KhuzVItjjjxN2hko8iGXVI0DEdEbFgr2wZykIIUSw4vZkfr6uHGz
	 Z77X6iJ4isUMAXhTBrwC4Q1tQUnvP2B6sR3P9rs914hl0oVYo6jc8/LyJ/kg6FGCjU
	 OKZsG5Rr2PAY5P0UXdbETzPlIVGF+RXY9IngFAmpMw2ejuT5CvOduXUkVqvlhg29fM
	 R/UAkgkb7NNNdJhmWKszIiiVTPddct1CcWn1DVTWMoX2wVZy2RBU4nUgjSYKy/eeSD
	 QCAh5FB7h2cWP1jfYf9XwrXQ6sscH+MqgKsDVBOM609aFDgW37PXhGOmhDqN0vpbjs
	 BRs+ZIXa4UYFg==
Message-ID: <3f72cbd3-c2f1-4c76-b2a5-db91bdbc3e00@kernel.org>
Date: Mon, 8 Jul 2024 09:49:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] f2fs: use meta inode for GC of COW file
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org
Cc: daehojeong@google.com, linux-f2fs-devel@lists.sourceforge.net,
 stable@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yeongjin Gil <youngjin.gil@samsung.com>
References: <CGME20240705082511epcas1p24b7b63d5e714a25213dbe07affa52f69@epcas1p2.samsung.com>
 <20240705082503.805358-1-s_min.jeong@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240705082503.805358-1-s_min.jeong@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/5 16:25, Sunmin Jeong wrote:
> In case of the COW file, new updates and GC writes are already
> separated to page caches of the atomic file and COW file. As some cases
> that use the meta inode for GC, there are some race issues between a
> foreground thread and GC thread.
> 
> To handle them, we need to take care when to invalidate and wait
> writeback of GC pages in COW files as the case of using the meta inode.
> Also, a pointer from the COW inode to the original inode is required to
> check the state of original pages.
> 
> For the former, we can solve the problem by using the meta inode for GC
> of COW files. Then let's get a page from the original inode in
> move_data_block when GCing the COW file to avoid race condition.
> 
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Cc: stable@vger.kernel.org #v5.19+
> Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
> Reviewed-by: Yeongjin Gil <youngjin.gil@samsung.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

