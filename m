Return-Path: <stable+bounces-215663-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOH8Bug2i2neRgAAu9opvQ
	(envelope-from <stable+bounces-215663-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:47:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E83911B62B
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 14:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBC77306FF6E
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4FD32AAAD;
	Tue, 10 Feb 2026 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L07Th7f5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6232A3CC;
	Tue, 10 Feb 2026 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770731106; cv=none; b=mxOtdBN6d5d7FcJxSE+79ai59yxolohvG0+sjStslWWhGvqhN3LRVkkucqCfV7SS49JI4OJFeZ2rSZGyIPA7/EHQVXCEIODVmTblbRQOgHkSeqv78Tbz8ZKHKjCJJVA5faN9xkDKk7KEFMFLkO6Tn1Dnpcxh4z+RT5obouXdUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770731106; c=relaxed/simple;
	bh=26+FDCEQwNmok8Zy9VH7xG1rfoNpFpyh5Os30EkIFhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=baCU5krcCt9rr7cASgS73Jf8tqA0/UTmaTViTzR6wekMkc3IuIBZe4rKqgtfINZH7Lg2XnKeyrsYeL3UMHv05uygl4M86o3jegDnGO77odC63LQHwx8cIclKqrsjzE9dQSIuuSNok7zpbvVZqqCrmRh5EnoDTmxZdKHzlGNo5As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L07Th7f5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09900C16AAE;
	Tue, 10 Feb 2026 13:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770731105;
	bh=26+FDCEQwNmok8Zy9VH7xG1rfoNpFpyh5Os30EkIFhg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L07Th7f5XZMNL4DPZNp7iGhK/MkggMhPQd+6GnpSRO9uacbIChCGIArP3Bk65MT7e
	 VeVhJoldE25cfN6Mnr0ssXWFinpEq7DyU+kTPVT3Dc+/RfRDh73hcocq+JHplE/xcp
	 3VkH4D/F4PW7wkpFZ2SZavF9ycU+9UyN6+yOMQDxqR25sjr5HE780HZXaBRIWigGsC
	 yMD6SG8159daR0BsYEMUsVHf5un/W1geMNRnsc2zn6jvopbYhfOlo0UVT/hFzpgTss
	 NOMM9bNJb1/HL4Z0+KU6IUMExl2XBc7G3ZylQHhhvXzwED9dPJIWZFC3JUNd5/IyZq
	 nmCXB/3rkO+eA==
From: Pratyush Yadav <pratyush@kernel.org>
To: ranxiaokai627@163.com
Cc: graf@amazon.com,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  akpm@linux-foundation.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  ran.xiaokai@zte.com.cn,
  stable@vger.kernel.org
Subject: Re: [PATCH -next 1/2] kho: fix missing early_memunmap() call in
 kho_populate()
In-Reply-To: <20260206043121.197564-2-ranxiaokai627@163.com> (ranxiaokai's
	message of "Fri, 6 Feb 2026 04:31:20 +0000")
References: <20260206043121.197564-1-ranxiaokai627@163.com>
	<20260206043121.197564-2-ranxiaokai627@163.com>
Date: Tue, 10 Feb 2026 14:45:02 +0100
Message-ID: <2vxzv7g4sof5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215663-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E83911B62B
X-Rspamd-Action: no action

Hi Ran,

Thanks for the fix.

On Fri, Feb 06 2026, ranxiaokai627@163.com wrote:

> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> kho_populate() returns without calling early_memunmap() on success
> path, this will cause early ioremap virtual address space leak.
>
> Fixes: b50634c5e84a ("kho: cleanup error handling in kho_populate()")
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>
> b50634c5e84a ("kho: cleanup error handling in kho_populate()")
> has not landed in upstream, so
> Cc: <stable@vger.kernel.org> is unnecessary?
>
>  kernel/liveupdate/kexec_handover.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index fb3a7b67676e..76b714db175d 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1463,6 +1463,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	struct kho_scratch *scratch = NULL;
>  	phys_addr_t mem_map_phys;
>  	void *fdt = NULL;
> +	int populated = 0;

Nit: Please use a bool and true/false. I think it reads much nicer.

>  	int err;
>  
>  	/* Validate the input FDT */
> @@ -1529,16 +1530,17 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>  	kho_in.scratch_phys = scratch_phys;
>  	kho_in.mem_map_phys = mem_map_phys;
>  	kho_scratch_cnt = scratch_cnt;
> -	pr_info("found kexec handover data.\n");
>  
> -	return;
> +	populated = 1;
> +	pr_info("found kexec handover data.\n");
>  
>  err_unmap_scratch:
>  	early_memunmap(scratch, scratch_len);
>  err_unmap_fdt:
>  	early_memunmap(fdt, fdt_len);
>  err_report:

Nit: now that this code can be reached by non-error paths, we should
re-name the labels. I think dropping the "err_" prefix should be enough.

With these fixed,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

> -	pr_warn("disabling KHO revival\n");
> +	if (!populated)
> +		pr_warn("disabling KHO revival\n");
>  }
>  
>  /* Helper functions for kexec_file_load */

-- 
Regards,
Pratyush Yadav

