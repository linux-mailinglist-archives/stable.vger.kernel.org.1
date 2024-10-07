Return-Path: <stable+bounces-81308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A4B992DFF
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D9E1C2274B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51FF1D47C3;
	Mon,  7 Oct 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/2gSe1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DF61D4618
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309400; cv=none; b=FE/xkQoyb+ImDIpOzqceesbBxv5yJd2Vtj+74baVllLpJNQD0X/6KEmKf0+QewfOFbykXm+u9OqOnDAFLbzQwWOqN3gU/khBYneKdrYqPtrDLC14M44oHg3aCz6TAq5LWNYWYf86HWFys59CcI8cyl8IGZ3PIYW+V8uqrBSKj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309400; c=relaxed/simple;
	bh=q/8tTG/RP/qumRTpNQvPo9J6nGQ/V/noectcg/Vxkpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feygDDY198CXx0sIMwoOMWmkh3/hagrZUfJt7WscLHHBJv6ut86ilaUNiGkZr3pip8bAC7B0jkYQR3G6Nyw/1tH2bpicMjdykJ2fSXVPkBnoYviod+W7KsmbA2WOq1J/lZR2oSPqree9LaDWNVvOk3nh4wBt0n1caJWqYGOfCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/2gSe1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D70C4CEC6;
	Mon,  7 Oct 2024 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728309400;
	bh=q/8tTG/RP/qumRTpNQvPo9J6nGQ/V/noectcg/Vxkpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/2gSe1B99aMZjp55qHxSGk0V02LRHLh2q353Z0t28VzJerL7DbpSGRv+k/D5/vkK
	 bNqiUM8i0ddF+BGKIZyqjugbmrA1aDaa2J1Qb7jlJ/EUQikT2bbG3dom2DWQW9lftI
	 Y4R48r+DtKQOrg8i7j82kJ30TGvng9fqu0Rqm9Cjq+O8uua6TTmK1moJlAZKB1gLM0
	 ja3XWcit8SIN5HRM0vUylQOYgcfLjMl/zXmglRL17NH2cNqUZt9Aeg5ujANsz9PFTF
	 1FP6zc9zyu2PG8q9ztTPP3x8/6duqiqC8EjayCqrKDzQfpxdIwPaKCjICsQOkZCcc+
	 QunRuTJnhpY2A==
Date: Mon, 7 Oct 2024 09:56:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Subject: Re: Wrong tag for queue/6.1 = v6.11.2
Message-ID: <ZwPolgvq4ZhB7zDw@sashalap>
References: <CA+icZUWN_mZ8w+5ZMdNR=YsZTFZ+hRYVr31PHqKc+8tfb2uxUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+icZUWN_mZ8w+5ZMdNR=YsZTFZ+hRYVr31PHqKc+8tfb2uxUQ@mail.gmail.com>

On Mon, Oct 07, 2024 at 02:58:51PM +0200, Sedat Dilek wrote:
>Hi,
>
>can you check the tag for queue/6.1?
>
>Link: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/log/?h=queue/6.1

Woops, fixed, thanks!

-- 
Thanks,
Sasha

