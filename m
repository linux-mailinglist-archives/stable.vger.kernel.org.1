Return-Path: <stable+bounces-87934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FEE9ACF8E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69135B2407A
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 15:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A81C0DD6;
	Wed, 23 Oct 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYF1naHs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F279C4;
	Wed, 23 Oct 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699041; cv=none; b=cJjf9Cz/rqw9qPmDmSuFxo7AcGHCfCqn9vtceU/8mdWsDLsgYYpdx4UssMvq4BTIT5b1TEdGvqk6/AUFjh3EnKzy9BlVBgi8fTzRnidGAvhA4EkC/aliKdPU2xZsZxbG07g7TxKy8oMNZ0pWVAnGiVdjEz6PlLTK8dsiqFRt3ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699041; c=relaxed/simple;
	bh=9f+SvZb+fL91MnsgYWBmBdE4SJwezL8Zc+dk0NsZUDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MR9Vsgm3wfi56P+6oCVNC+iyVZZUETCgujbma5EA0Fpa0TNzrMO7rdBYZTQuePdn4zGqLPMAJAt06QRALFZfdPYMyaoV1D52qH9YrCJWA+6CrGWjZQLTRSdI9p/rzv67cxm6WIfBkOww4z3vcqcIZdnXzUrGO7t2wdkGqjmCOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYF1naHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74CEC4CEC6;
	Wed, 23 Oct 2024 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729699041;
	bh=9f+SvZb+fL91MnsgYWBmBdE4SJwezL8Zc+dk0NsZUDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pYF1naHsVf6ILIbEuHsIV4EYdTrjJaa3gW0vLjNwBbt0W88rNtjtZPBuHrUcnmMQD
	 L+OEHYQWCy8bWGTnUu/jqaREf/mZROg3Dm86TeJn7JE/7yENW6ed9ysZRgCMtVDc0z
	 iLj1TkpqWtky8Bhu2vMbRIX3R+iB0orbkxwe9o1pFM64BYggIieDwgxjHtA7v5bO7F
	 GmUP7gOZRbkHWzeI0b5YnGIXsavEqTJm26kLPVdNRbs0fcIQa9PnpxHk+KPVU1JiDF
	 8072IKpLCrGVl+MnbGhWxK3nuIhRLGj+l6iNp84pHY0j9CBTj3YpRMslIwZJY7Kxek
	 26hZImZc57f6g==
Date: Wed, 23 Oct 2024 11:57:18 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 7/7] lib/generic-radix-tree.c: Fix rare race
 in __genradix_ptr_alloc()
Message-ID: <Zxkc3iLkPxXr6pE0@sashalap>
References: <20241012112948.1764454-1-sashal@kernel.org>
 <20241012112948.1764454-7-sashal@kernel.org>
 <g7gqwenbskp5wi7yljoaqdadmkjddouu4sez5fzryo35pu353i@fhyang5gfv7e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <g7gqwenbskp5wi7yljoaqdadmkjddouu4sez5fzryo35pu353i@fhyang5gfv7e>

On Sat, Oct 12, 2024 at 02:54:01PM -0400, Kent Overstreet wrote:
>On Sat, Oct 12, 2024 at 07:29:42AM GMT, Sasha Levin wrote:
>> From: Kent Overstreet <kent.overstreet@linux.dev>
>>
>> [ Upstream commit b2f11c6f3e1fc60742673b8675c95b78447f3dae ]
>>
>> If we need to increase the tree depth, allocate a new node, and then
>> race with another thread that increased the tree depth before us, we'll
>> still have a preallocated node that might be used later.
>>
>> If we then use that node for a new non-root node, it'll still have a
>> pointer to the old root instead of being zeroed - fix this by zeroing it
>> in the cmpxchg failure path.
>>
>> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>there wasn't any need to backport this, bcachefs is the only thing that
>uses genradix in multithreaded mode

Will do, thanks!

-- 
Thanks,
Sasha

