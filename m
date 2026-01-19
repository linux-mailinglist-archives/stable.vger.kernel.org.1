Return-Path: <stable+bounces-210264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93625D39EAD
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47010301473B
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 06:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187BE270EAB;
	Mon, 19 Jan 2026 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HIpr4uRG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA01339B1;
	Mon, 19 Jan 2026 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768804666; cv=none; b=cpRsowXjYXdmQk2D/1y8t+zq/S1GPrnWiH1koF9FubG5gwJGTZKVVYNGOptuJyVb3r+4IYldWiI9Jyw+QNeOSPwX6P+JKycnicwBKiM3jH6e/k5z1LqdUqtp3GpZuwhrNiAKEeqyyQi8yZqrmeoql/HvFnsgqDfjbXDjB4Weq24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768804666; c=relaxed/simple;
	bh=Pd/vKHX3eu7UNTbniHeTvD5yvMnwvjior9MXth6nQiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBLyFBCU4HhmUbvkth3Z5jBYPcChv5XABltRls9fcHRiFne0AJS34RXwUB5cy2mTdfAVA+R1+BSTtma9vbImy6vXbOQyDNgeDurWBdYJLdCAybtdabCC0sevnDQTbjscLg0zwRGTRx5r0X0lfk68YPb9k6qAgIhWW4lEuaPWJWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HIpr4uRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A9DC116C6;
	Mon, 19 Jan 2026 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768804666;
	bh=Pd/vKHX3eu7UNTbniHeTvD5yvMnwvjior9MXth6nQiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIpr4uRG42UdVdyCaTs7q5mgDXnawLcq0siz+m9KQoc5UwskmG3ghNG/h8LuFnVoE
	 m4YVvlsX/RofG4CdQ9Y0N++ov0QWFYVKTXLKnhYSTRHGHevbjqN1fS8K/t9ORQcV7i
	 uutfl9Bxvg/S2Iut/Ydn6fdu0Exn8z3Xw66kB9Zc=
Date: Mon, 19 Jan 2026 07:37:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: markus.elfring@web.de, almaz.alexandrovich@paragon-software.com,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fs/ntfs3: Fix infinite loop in hdr_find_split due to
 zero-sized entry
Message-ID: <2026011934-skyrocket-handwork-6ba9@gregkh>
References: <65bf90b1-8806-4f8c-b7e7-d90193d28e88@web.de>
 <20260118190145.41997-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118190145.41997-1-jiashengjiangcool@gmail.com>

On Sun, Jan 18, 2026 at 07:01:45PM +0000, Jiasheng Jiang wrote:
> The function hdr_find_split iterates over index entries to calculate a
> split point. The loop increments the offset 'o' by 'esize', which is
> derived directly from the on-disk 'e->size' field.
> 
> If a corrupted or malicious filesystem image contains an index entry
> with a size of 0, the variable 'o' will fail to advance. This results
> in an infinite loop if the condition 'o < used_2' remains true, causing
> a kernel hang (Denial of Service).
> 
> This patch adds a sanity check to ensure 'esize' is at least the size
> of the NTFS_DE structure, consistent with validation logic in sibling
> functions like hdr_find_e.
> 
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Add a Fixes tag.
> ---
>  fs/ntfs3/index.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 7157cfd70fdc..da6927e6d360 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -577,6 +577,9 @@ static const struct NTFS_DE *hdr_find_split(const struct INDEX_HDR *hdr)
>  			return p;
>  
>  		esize = le16_to_cpu(e->size);
> +
> +		if (esize < sizeof(struct NTFS_DE))
> +			return NULL;
>  	}
>  
>  	return e;
> -- 
> 2.25.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

