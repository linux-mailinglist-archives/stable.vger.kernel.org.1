Return-Path: <stable+bounces-66735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB1D94F139
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFB51C218D9
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5D9178370;
	Mon, 12 Aug 2024 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dJx912jy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F4A1E504
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475029; cv=none; b=VcWJKL8QlVEYslBNt0BE7F+DcQTkb4/BPFS1iEWLU2uWljJL3B1eI6elPEImJuNYtor/bbHm20Hy7rwihh1hbYHjtgJM2aNFSd9uUs84jdDmiLdbGMgXMvzl3PPbn5gczTnINGk2eNIWW02LRw/0spXMsT4SKw2sargMSLWTTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475029; c=relaxed/simple;
	bh=BpRsYPDP3VoYUOYNLXNkbFUiRd9/bf4wTybjrb5yvL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ81sL8ZvYEhTa06AJoIS68NW6W6sz/gtzl6hSIhs053ZsWV0+LsNUBB4hOduZ5EoTVlUnVZVjkc2awBGxoOtCrSfG7ovRur5lDeekhehoUxT0QW0uE3WsEEhvGk4jhaG80AXBzSaRvezZkDq9ycVZjp+Ntux5OkZTvtYHTeYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dJx912jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED37CC32782;
	Mon, 12 Aug 2024 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723475028;
	bh=BpRsYPDP3VoYUOYNLXNkbFUiRd9/bf4wTybjrb5yvL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJx912jypyWuTss9GqIvIvk+qJIesv65v0EyCrN6o2xz9qgi+367Nu4F2BiHoNwEe
	 lR6kZZwhJu0puK/MXA0suDz8Qp8r3uu2ANgS6O3XFi3gnUbrxpbgCFtRgnt5be3I4C
	 cO85ooweV2JgPTUEn5ZeqlAZWk9DNvCEDC3lPkh4=
Date: Mon, 12 Aug 2024 17:03:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org, anshuman.khandual@arm.com,
	bwicaksono@nvidia.com, catalin.marinas@arm.com, james.clark@arm.com,
	james.morse@arm.com, will@kernel.org
Subject: Re: [PATCH 6.6.y 13/13] arm64: errata: Expand speculative SSBS
 workaround (again)
Message-ID: <2024081211-props-gimmick-e3f5@gregkh>
References: <20240809095745.3476191-1-mark.rutland@arm.com>
 <20240809095745.3476191-14-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809095745.3476191-14-mark.rutland@arm.com>

On Fri, Aug 09, 2024 at 10:57:45AM +0100, Mark Rutland wrote:
> [ Upstream commit b0672bbe133ebb6f7be21fce1d742d52f25bcdc7 ]

Now I figured it out, this is the wrong git id, and is not in any tree
anywhere.  It should be adeec61a4723fd3e39da68db4cc4d924e6d7f641.

I'll go hand-edit it now...

greg k-h

