Return-Path: <stable+bounces-195421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FAEC76316
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 21:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F12464E26B8
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01B12FC892;
	Thu, 20 Nov 2025 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9UnyXZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6120E1E5B95
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670235; cv=none; b=pnpoI2tfBQyVB5GR4MJF27IRo25ZGGuIn1ZwxoC2taTb18iMh5tq7vFdO07GbMYOwtV1EFKKLrhzd4tDp4NLrVHE8VvQqAHcoTTxEaaGrEAZkYEAFt93DH3kL/Cu/lgG4w3bmU6rMpSOMSRCt/YQjmC51c00u36uvAX5xa3vsPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670235; c=relaxed/simple;
	bh=a2FEA625ANzLpjWkhlLtr1SxRvZigA90QEKhvulL0yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lIKSGyJfg8yjly7KBfEZOhPaS72qLa7COX8x/gnTc4e7Bx64t6NlfAdbtzCmjWqSIOWgdgySVSqq+qR1Rfz5JvvG8lEnIUN8h+wHm7pLh5nbESLvnOrJmZfCsuihgMNCoveta4RPMsOgKmEr9vTtnwHpH7Cq6cfPKL/XEpmW1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9UnyXZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A2EC4CEF1;
	Thu, 20 Nov 2025 20:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763670234;
	bh=a2FEA625ANzLpjWkhlLtr1SxRvZigA90QEKhvulL0yQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r9UnyXZIV7L8ZEOOeJT1nl62EE6F8j9PcBYhYDgjuXdqLWdOasVD1Vd2xaxL5PqfE
	 cHv1LnDQ9uXSc7KHeS91rdLs1uhyk0KakkBPQKfX1uspq/dM0doSGkbkcJxkqogn+b
	 PoEcIOSBZeHC8NGZAaCohSy30TRBPO6BLUrqCI+UnSI8GGfhz/c5NmV3iq3pYPDItR
	 F9FFuDHirpkbyfWCeUHIUy/iO5DbQvU6hFMlZQTQKemyHm76gGYOhO83Ek8lg7vWmH
	 JVxDDl6VYryFXKGDdGPRB7+r4Lue0oZ8GpEjDBZjtpZh0t2rHd0q+bIBNP+kvf53ii
	 V+6mOW30QW9kA==
Message-ID: <5c1630ac-d304-4854-9ba6-5c9cc1f78be5@kernel.org>
Date: Thu, 20 Nov 2025 21:23:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: Joanne Koong <joannelkoong@gmail.com>, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, shakeel.butt@linux.dev,
 athul.krishna.kr@protonmail.com, miklos@szeredi.hu, stable@vger.kernel.org
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
 <20251120184211.2379439-3-joannelkoong@gmail.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251120184211.2379439-3-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/25 19:42, Joanne Koong wrote:
> During superblock writeback waiting, skip inodes where writeback may
> take an indefinite amount of time or hang, as denoted by the
> AS_WRITEBACK_MAY_HANG mapping flag.
> 
> Currently, fuse is the only filesystem with this flag set. For a
> properly functioning fuse server, writeback requests are completed and
> there is no issue. However, if there is a bug in the fuse server and it
> hangs on writeback, then without this change, wait_sb_inodes() will wait
> forever.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal rb tree")
> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> ---
>   fs/fs-writeback.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 2b35e80037fe..eb246e9fbf3d 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2733,6 +2733,9 @@ static void wait_sb_inodes(struct super_block *sb)
>   		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
>   			continue;
>   
> +		if (mapping_writeback_may_hang(mapping))
> +			continue;

I think I raised it in the past, but simply because it could happen, why 
would we unconditionally want to do that for all fuse mounts? That just 
seems wrong :(

To phrase it in a different way, if any writeback could theoretically 
hang, why are we even waiting on writeback in the first place?

-- 
Cheers

David

