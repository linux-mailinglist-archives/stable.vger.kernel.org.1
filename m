Return-Path: <stable+bounces-172531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E00B32637
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 03:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4551D22AC8
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 01:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B201D9A54;
	Sat, 23 Aug 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRRtUsef"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE023B0;
	Sat, 23 Aug 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755912772; cv=none; b=pXIJV+o25KBtUpf9mdbJCBSm/3X0rbdAwypF931o9VcChWGvOm5RR1HyDK6vq0zWKa2f+AfQ+XB8lqMh8QCZ9cdjhtkQioodktn+4lsTHua7QF8uIS+JopL18NZ2nYothXF5RNIhAszwMJhINe4FW1ZvTrYVeCYqqYpw4Gs6+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755912772; c=relaxed/simple;
	bh=2bJlQ73zMhkZi/w8Svsurn0QcFTsicZAyfdxSWwE4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsG1rvp5hX87SuwimFGEwYkKuBNhpxB8pBZm8HWZeZWz0MCkJV+GeqJBJ27aFzPyojR9cPELggUs8dTrbvAFGlEunWIP6L3CsQwJn7KotOiqScBPRHHexmZmqjdEYVgf/FPAilk0OGc2+yGPaSje1RDYZV6rtms+KSHfVTiq+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRRtUsef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8AEC4CEED;
	Sat, 23 Aug 2025 01:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755912771;
	bh=2bJlQ73zMhkZi/w8Svsurn0QcFTsicZAyfdxSWwE4Do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rRRtUsefvqRilZsk4SwuF02AFFr2GQfdOlwmdU4PwfZgBWq1FwoDpJ6mcf366dt6E
	 Hsa6JAKNkFk6n0Y49YlS1+4az7XQFUqYhrpDYWqyJDHIxFLtGRBCYo9ln/mWHSbpzf
	 CfmVfCGccIUucsacuAt5aVsBtpB4DGkrc/tqHVjqldbrZIll8mGS5Gu39y+Au1z4B8
	 zYh8zKMRhRpmkc37d02IYfsdXBggdC+5ZpzC7/CzPfFvBGZom6fApxJWy4ZT5ZVnKe
	 dCS5G7bMLgaHtIH8gkFBPy0b3KDnuqgzVQSdPVrLnS0xeAoLVlKl/7AA+VYL/tcgZW
	 MzE3K0hITHyGw==
Date: Fri, 22 Aug 2025 18:32:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: regressions@lists.linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 oscmaes92@gmail.com
Subject: Re: [REGRESSION][BISECTED][PATCH] net: ipv4: fix regression in
 broadcast routes
Message-ID: <20250822183250.2a9cb92c@kernel.org>
In-Reply-To: <20250822165231.4353-4-bacs@librecast.net>
References: <20250822165231.4353-4-bacs@librecast.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks for bisecting and fixing!

> The broadcast_pmtu.sh selftest provided with the original patch still
> passes with this patch applied.

Hm, yes, AFACT we're losing PMTU discovery but perhaps original commit
wasn't concerned with that. Hopefully Oscar can comment.

On Fri, 22 Aug 2025 16:50:51 +0000 Brett A C Sheffield wrote:
> +		if (type == RTN_BROADCAST) {
> +			/* ensure MTU value for broadcast routes is retained */
> +			ip_dst_init_metrics(&rth->dst, res->fi->fib_metrics);

You need to check if res->fi is actually set before using it

Could you add a selftest / test case for the scenario we broke?
selftests can be in C / bash / Python. If bash hopefully socat
can be used to repro, cause it looks like wakeonlan is not very
widely packaged.

