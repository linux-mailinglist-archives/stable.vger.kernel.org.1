Return-Path: <stable+bounces-166889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF18B1F09A
	for <lists+stable@lfdr.de>; Sat,  9 Aug 2025 00:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0227626243
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 22:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363820FA9C;
	Fri,  8 Aug 2025 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHXAfBn+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC392E370A;
	Fri,  8 Aug 2025 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690898; cv=none; b=BLnT3PZbNX3WeOJpHLKrIv5trY3yJrg7kKRIZZWpp9boDkGJvKIlzec6l6NZLTh/nsrQZ/Q1MfthC6tWAkWX5LAGnJj23/yGMllweExYsjJcuE9RAtvJm9WOT8BSgmHqJs6QPPhs3irt1leukSB0quH62cZzTV3UvVA4KiT57rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690898; c=relaxed/simple;
	bh=6Gi9ECCH0DmeSLy+hgk+Ey5g/XPhWoX3r/eqv+fWQ14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iH/nE9Scy0Qzd5xKOCx3Ahcc/vkeujQfApg9S2RaRxDugiK/apmAa6wrkXkH6WjiIWcqbmt8p35bOgTJ0vTHDCm9hxgLURpU9stl9v8LcGJOfkzT7kMSddslTfygVjon2R+2uU/5cjwAmU47BuQ78GrqGEaGuWDFc16K4tnjD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHXAfBn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F30C4CEED;
	Fri,  8 Aug 2025 22:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754690897;
	bh=6Gi9ECCH0DmeSLy+hgk+Ey5g/XPhWoX3r/eqv+fWQ14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHXAfBn+SBvPXsJDqFR6y7+g4HvU88NcOCxfzlmwqAvEqR1EofJnwqy61IfbY/9k5
	 c/+7CGF2JJHAsFben8vMdoXxvy52yjtbtwaHzNdxajD8Pwu9EUX7QQ5K7jWo6hXK9v
	 7WOpGziY1OGNO2VPLhbis0RuCocmkpLSah7JUiIrJgcd+I9SPjIxAkoUwLU9vF+iFv
	 USZYg2YxDrxffttm7rZ7CQ+x1ExsGvt1Vcnmzt4gpNJL5El/mkSQL4/+a8kgJUQBFs
	 AptKprNhuKaFfG5ACY6FBjiwhVh7klHSRMG1FAlkwzVSKmukeMACvwTVqENLSLmcVI
	 8PapuQ0dnnipw==
From: SeongJae Park <sj@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	honggyu.kim@sk.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/damon/core : fix commit_ops_filters by using correct nth function
Date: Fri,  8 Aug 2025 15:08:15 -0700
Message-Id: <20250808220815.49644-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250808195518.563053-3-ekffu200098@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  9 Aug 2025 04:55:18 +0900 Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> damos_commit_ops_filters() incorrectly uses damos_nth_filter() which
> iterates core_filters. As a result, performing a commit unintentionally
> corrupts ops_filters.
> 
> Add damos_nth_ops_filter() which iterates ops_filters. Use this function
> to fix issues caused by wrong iteration.

Thank you for finding and fixing this bug!  Since this bug is better to be
fixed as soon as possible, could you please send the next version of this patch
as an individual one, rather than as a part of this patchset?

> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Let's add below for stable kernel maintainers[1].

Fixes: 3607cc590f18 ("mm/damon/core: support committing ops_filters") # 6.15.x
Cc: stable@vger.kernel.org

And the fix looks good to me, so

Reviewed-by: SeongJae Park <sj@kernel.org>

[...]

[1] https://docs.kernel.org/process/stable-kernel-rules.html


Thanks,
SJ

