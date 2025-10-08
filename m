Return-Path: <stable+bounces-183611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AE5BC566E
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 16:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC823B9D4F
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 14:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC1296BBB;
	Wed,  8 Oct 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0hjAakc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098201E489;
	Wed,  8 Oct 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932786; cv=none; b=AFmQHSTMoDu/0rPPg+YHTg0k6yXv4fipuGuLilV4xAa/CDj99XfW9j2zfpDKY1rB8sJ6Ulqusr8QeCEd4KAYei3nWem6e6rgNU8x5XB2IeIjhCCiIDHntzcCIAQ/efKjKqbCVmjgPWXXh18s2os4KN9Zm8pNHA8paMs2yHCnneI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932786; c=relaxed/simple;
	bh=stGsj5doSwa36q4qId9DDb9VpuUG7ho0bcOOpHJCbFo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nIHwjxj55N4SQ3HOYts9QG2cdO8C/Z3OOmJ8GRG+/Hn3zWDSia6A/gSDWBlBEciEO6AGBwNc6AtOuKRs9JoxhyoNAldRTiCiSlj+vfq9TUI8gH0ffhg+chtsIfT3MX10AIvXmaL2l1MSv0dSEC/jDsyow7intcvgmCKti4v6nAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0hjAakc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A41DC4CEE7;
	Wed,  8 Oct 2025 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759932785;
	bh=stGsj5doSwa36q4qId9DDb9VpuUG7ho0bcOOpHJCbFo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=f0hjAakclgkVI1ZFZABzBA49wOdZcHHypirZLmjZg8if1kcykHVNZaUcwd6y5ZXBF
	 PWJwoIJ4zs02UNFkbl1BPQ/Kr0gkP6EOKaZAousajEjiceawywx7VAQsvVDxGY79Ly
	 ILRjBIDjYkR+GXzxJrT9KST2KcnNt5mVxK9mLZW4sd2o45v7iWIxYLyF5HcpeCb0Ta
	 Tr6pHW5SHjh+nkRLpYm8HOmlOTX2GE9A2AuL9PtQgCo++9zv3Hgx9/4TnYc7V/wLdH
	 xlxyJxeMKELkiQdG1rMWHU+64P4thwWTCFzs1e6G8jsUaEOEaspmzRX7bG/BctP89V
	 h+0PSGbj4Cu4w==
Message-ID: <d5d399be-f1a0-44f8-a1f3-49373ae1f861@kernel.org>
Date: Wed, 8 Oct 2025 10:13:03 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] nfsd: fix refcount leak in nfsd_set_fh_dentry()
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, tianshuo han <hantianshuo233@gmail.com>,
 stable@vger.kernel.org
References: <20251008135230.2629-1-cel@kernel.org>
 <20251008135230.2629-2-cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <20251008135230.2629-2-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 9:52 AM, Chuck Lever wrote:
> From: NeilBrown <neil@brown.name>
> 
> nfsd exports a "pseudo root filesystem" which is used by NFSv4 to find
> the various exported filesystems using LOOKUP requests from a known root
> filehandle.  NFSv3 uses the MOUNT protocol to find those exported
> filesystems and so is not given access to the pseudo root filesystem.

Hrm. This one got included by mistake.

-- 
Chuck Lever


