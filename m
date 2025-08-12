Return-Path: <stable+bounces-169285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3A4B23A52
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF4C3AA989
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533952D063C;
	Tue, 12 Aug 2025 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl2gobbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066128C02D;
	Tue, 12 Aug 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032236; cv=none; b=YKNdx+oM/0CtNWs3NjS/nTvIUxSenmZiInIrvHakZO8IynxL9BKNKvFPWVLk1Y4fe5xgmWfmaBg8JLUcSqC2C+XJXrxbGHAqs/xvurcyrzlYyjY6KASF66NwkEuiC/tal6HKi/QnEtxfZT7usJwMkT0Hm1iF8I/Jlyts+0M71KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032236; c=relaxed/simple;
	bh=LgWTKMMSUHAbzZLyp/LkRilxvvmP0YcvpZK3k+u1yfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDFyeRQEx0XLISPOAk6zF+rAFTGgyThYqDMZ32vw+RPPjALb8fveVXmi+N6rqcA81WnXO3mida4SHh8jvtihahdW5sU+VgXe+S1oD+9oFq+octicKbYf6jGB5DnXM5xXoZENMMF/Cuf/zOgzFJSHDVgj2XAQ9vXrlAeu1x7l4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl2gobbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C30C4CEF0;
	Tue, 12 Aug 2025 20:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755032235;
	bh=LgWTKMMSUHAbzZLyp/LkRilxvvmP0YcvpZK3k+u1yfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yl2gobbNrue0nOUHZvQwKuB3wXGqab5YZ5mYn0tjT6ljrhZVg88xPAmI5LBcOSjWA
	 ht6aFSwEKxTnJlyhpAPuUZzHX4jnBB3wDAnBKPiAzBmubJx3sCqdsYEh0v524dwkMz
	 7uk03s8Dwg3TQfTTH2JMLPPPNgSJNAr5r+wqs1RaDw5NxVFaIeKcVwzCgTgzOf00rx
	 ajLzz4lkDSdvKdAcfuLRStPj0MEIs6HVMjCm9+pGOp2LzMKb2tqYtYd+VOAqr/tw4E
	 Br5SFsLZnXKiu28Jsivt8LXJZc30olyAS9vSzoXe+PzQLUTApgAhRDSb9dUDhK5z9i
	 vCvYAjVPNUN1A==
Date: Tue, 12 Aug 2025 13:57:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, Kuniyuki Iwashima
 <kuniyu@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 00/12] ice: split ice_virtchnl.c git-blame friendly way
Message-ID: <20250812135714.0e1a7ee0@kernel.org>
In-Reply-To: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
References: <20250812132910.99626-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 15:28:58 +0200 Przemek Kitszel wrote:
> Summary:
> Split ice_virtchnl.c into two more files (+headers), in a way
> that git-blame works better.
> Then move virtchnl files into a new subdir.
> No logic changes.
> 
> I have developed (or discovered ;)) how to split a file in a way that
> both old and new are nice in terms of git-blame
> There were no much disscussion on [RFC], so I would like to propose
> to go forward with this approach.
> 
> There is more commits needed to have it nice, so it forms a git-log vs
> git-blame tradeoff, but (after the brief moment that this is on the top)
> we spend orders of magnitude more time looking at the blame output (and
> commit messages linked from that) - so I find it much better to see
> actual logic changes instead of "move xx to yy" stuff (typical for
> "squashed/single-commit splits").
> 
> Cherry-picks/rebases work the same with this method as with simple
> "squashed/single-commit" approach (literally all commits squashed into
> one (to have better git-log, but shitty git-blame output).
> 
> Rationale for the split itself is, as usual, "file is big and we want to
> extend it".
> 
> This series is available on my github (just rebased from any
> earlier mentions):
> https://github.com/pkitszel/linux/tree/virtchnl-split-Aug12
> (the simple git-email view flattens this series, removing two
> merges from the view).
> 
> 
> [RFC]:
> https://lore.kernel.org/netdev/5b94d14e-a0e7-47bd-82fc-c85171cbf26e@intel.com/T/#u
> 
> (I would really look at my fork via your preferred git interaction tool
> instead of looking at the patches below).

UI tools aside I wish you didn't cut off the diffstat from the cover
letter :/ It'd make it much easier to understand what you're splitting.

Greg, Sasha, I suspect stable will suffer the most from any file split /
movement. Do you have any recommendation on what should be allowed?

