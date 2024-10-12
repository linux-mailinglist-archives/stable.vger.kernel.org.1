Return-Path: <stable+bounces-83599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D983F99B6A7
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 20:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0E12827E0
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2A84D2C;
	Sat, 12 Oct 2024 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UJZKliDT"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257640879
	for <stable@vger.kernel.org>; Sat, 12 Oct 2024 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728759253; cv=none; b=fxs6ZJJIN7M126+iXDzx7mf4NL68CNedjtmG8XkSO0TmM9ynkzC1q/FCXqbf4Q+foedGzwJeAqcmJxeAAe/vn0kk1aSRnINf6xetdWS0rXilLFABaANkVHeXJI0j1mdqIh59jqY1hN1NDZi6JMAv6jh2FCUgkR715VOCg3J79HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728759253; c=relaxed/simple;
	bh=P0mWJTbEkMS5OvpfRwI409xqpig7kOi24bUBnGhw/NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qGNr0ZavFzm5LK//JjDDcohztVJEaFm/kiJutT9q/+FpBNHEDQQow1XNzwmp4oAgCQ5piSvnfG6tI8WSdDmys6l8+j/uNxiiMmYn+UoDiDPElFUlAQBtH+LbRVsLOtbqBHZQqUSAXqwzmV69GBrIiYIYNRI5C7ey56QLcXJzXC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UJZKliDT; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 12 Oct 2024 14:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728759249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xfj3dGXVa+VE/Yo9UHk0Jt+MCxwR5SaN+nAcSq52thE=;
	b=UJZKliDTosWZmQEepq7SMAGSicATuMopt8fP2TmbtlITPZE3TqYHKrdHd84oOkyNaocWrz
	NP32FqTNzCRSRCACWQ+Mk+piChKIO4NV8SvjyeRO53DQj6k9r6eeO3bGyUEQSy+UBzOskz
	qqTOiW8GYsh6vaPyJFHW5Q/eId6AiEA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 7/7] lib/generic-radix-tree.c: Fix rare race
 in __genradix_ptr_alloc()
Message-ID: <g7gqwenbskp5wi7yljoaqdadmkjddouu4sez5fzryo35pu353i@fhyang5gfv7e>
References: <20241012112948.1764454-1-sashal@kernel.org>
 <20241012112948.1764454-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012112948.1764454-7-sashal@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 12, 2024 at 07:29:42AM GMT, Sasha Levin wrote:
> From: Kent Overstreet <kent.overstreet@linux.dev>
> 
> [ Upstream commit b2f11c6f3e1fc60742673b8675c95b78447f3dae ]
> 
> If we need to increase the tree depth, allocate a new node, and then
> race with another thread that increased the tree depth before us, we'll
> still have a preallocated node that might be used later.
> 
> If we then use that node for a new non-root node, it'll still have a
> pointer to the old root instead of being zeroed - fix this by zeroing it
> in the cmpxchg failure path.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

there wasn't any need to backport this, bcachefs is the only thing that
uses genradix in multithreaded mode

