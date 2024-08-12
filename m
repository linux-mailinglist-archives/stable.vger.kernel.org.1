Return-Path: <stable+bounces-66466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9A94EBC3
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE3DFB20943
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4394172BD6;
	Mon, 12 Aug 2024 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJ875fAc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74053171066
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462019; cv=none; b=Y5u2tlQOX5K9Tm5bnBd0/CkGJR6AgnjN8VIl0W6hFP9icSCz38cZCbMV2SFzD/9L22Fg5C/g9fe9Li2H0upD8iF1Omkx0EP9rjyRieorl/CSRCY9ak2g1tWRWHLJzgSxZ8KdaEQLbzBGU2Rp+C97KjiSyoTVX8+S39Blv3KyaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462019; c=relaxed/simple;
	bh=NEM+zhBE0Dv7Rsoe5IC0/9DdnAvUSWq6HEnNLXr8wrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVkpNZY1TdjJ+Ki8AVNHdv15BKyIx2FOPyt6l0TffaWLrTlUsmyiRgesF+PGlDQXZOtUzzO3NNlH9811U/3vcTURQJoIAjFTCtyaSYmzXVOX2P31Pv04iGnzvDwWhutzgQBDtPjAjteGPGXosKGZ37KhyxJ/YVX+4cksIa2XbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJ875fAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F81C32782;
	Mon, 12 Aug 2024 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723462019;
	bh=NEM+zhBE0Dv7Rsoe5IC0/9DdnAvUSWq6HEnNLXr8wrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJ875fAcatMOLLpLTrqq9f9kTpGDW+f31QBgjKnghEWWyX9tGfagEXbZ2dsmhNlL9
	 LgCpTlt1o6UzRWAOh+qN4oJ14ct48TJDDKYgp5XJvlUQRjP+F3kifWRyS9SpjW+gSz
	 /hciJPlhu1ELrKsoglRf3y0fk67jQY7eiy0j3BbTypR4mGoojGLmo1zISNv/RPcUYb
	 N2U7t25xINbSMLYnsjBVcqwoCB/6Ay9/7ZaFCRyIqS/kLB7AuyYvKivQ5+1t39ivTa
	 6c8el/nUTk/P9al/ACHy7l6g2OEgav3SBZeGEBenCYReGIkIVjxq+HWOUvZaKlMi0a
	 Fi4Un8qeacMkw==
Date: Mon, 12 Aug 2024 07:26:57 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org, anshuman.khandual@arm.com,
	catalin.marinas@arm.com, james.morse@arm.com, will@kernel.org
Subject: Re: [PATCH 6.10.y 0/8] arm64: errata: Speculative SSBS workaround
Message-ID: <ZrnxgS9RTDP4FDtK@sashalap>
References: <20240809095120.3475335-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240809095120.3475335-1-mark.rutland@arm.com>

On Fri, Aug 09, 2024 at 10:51:12AM +0100, Mark Rutland wrote:
>Hi,
>
>This series is a v6.10-only backport (based on v6.10.3) of the upstream
>workaround for SSBS errata on Arm Ltd CPUs, as affected parts are likely to be
>used with stable kernels. This does not apply to earlier stable trees, which
>will receive a separate backport.

I've queued up the backports for the various versions, thanks!

-- 
Thanks,
Sasha

