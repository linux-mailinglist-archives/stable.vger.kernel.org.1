Return-Path: <stable+bounces-192582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC52C397E9
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 09:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA0E1892956
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3372E2FFF97;
	Thu,  6 Nov 2025 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5WE/Y+B"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB612FFF83
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416104; cv=none; b=eiivv/2t5JUozhhyB+OtaGdjkjgucd+tTN+5J1vgd8J5ZbiF1dcEvUeB7koxLHvk6AVeXSSxL1cgaxyejvBKLLF56HIPWSr+jpm9tcdHMPPfON3sO2T79PB+6qNgJqZXslKr1tPIBLH1wyPo34vHpSXLxmyYBKWbBZBKNu/h3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416104; c=relaxed/simple;
	bh=O85Egr1mJZvNlhKo39WgVfPyqLr0DktDocrbfNSbOZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSgPwjN8DsXyom3O3ptOJn5yQ8kE+cfFmkIh6tBRO/CnHuMH4/vkJE7qMpwvpbFDOiEvxL1A4bRKBOujAzw7SXSGH5koJas+yunUz2eWIZLNZ9/vgnRPN7S8CZGptYFgmh3FBsNyR8GHLWvoIzR4+ayu+Lu5vcjXE3C2uN5+MDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5WE/Y+B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762416101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gq8OqVz4qr//bD4X0q0XpwbVxL8+9n9NL/5MFInAjSM=;
	b=c5WE/Y+BQyznmhzQaN2qj0OzOumCnOQ+bD9cRygbZTkSDTceadGGEb8g33WHGPzVM9+u4H
	6IUmpt9JhtEAglRcUyPbAwO/bcFmhL4It8jnxvZShRdLPomUwMwUp9BptcOEM7NfBcZZcx
	7o/vpb+TxcteK0UfjXRfjDNYtFEM44U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-5qD3198KNDifl4Mnks6ZAA-1; Thu,
 06 Nov 2025 03:01:38 -0500
X-MC-Unique: 5qD3198KNDifl4Mnks6ZAA-1
X-Mimecast-MFC-AGG-ID: 5qD3198KNDifl4Mnks6ZAA_1762416096
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E80611954225;
	Thu,  6 Nov 2025 08:01:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8049530044DC;
	Thu,  6 Nov 2025 08:01:33 +0000 (UTC)
Date: Thu, 6 Nov 2025 16:01:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-ID: <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106065904.10772-2-piliu@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> When I tested kexec with the latest kernel, I ran into the following warning:
> 
> [   40.712410] ------------[ cut here ]------------
> [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> [...]
> [   40.816047] Call trace:
> [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> [   40.823221]  ima_kexec_post_load+0x58/0xc0
> [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> [...]
> [   40.855423] ---[ end trace 0000000000000000 ]---
> 
> This is caused by the fact that kexec allocates the destination directly
> in the CMA area. In that case, the CMA kernel address should be exported
> directly to the IMA component, instead of using the vmalloc'd address.

Well, you didn't update the log accordingly.

Do you know why cma area can't be mapped into vmalloc?

> 
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> To: kexec@lists.infradead.org
> ---
> v1 -> v2:
> return page_address(page) instead of *page
> 
>  kernel/kexec_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9a1966207041..332204204e53 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, int idx)
>  	kimage_entry_t *ptr, entry;
>  	struct page **src_pages;
>  	unsigned int npages;
> +	struct page *cma;
>  	void *vaddr = NULL;
>  	int i;
>  
> @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, int idx)
>  	size = image->segment[idx].memsz;
>  	eaddr = addr + size;
>  
> +	cma = image->segment_cma[idx];
> +	if (cma)
> +		return page_address(cma);
>  	/*
>  	 * Collect the source pages and map them in a contiguous VA range.
>  	 */
> @@ -1014,7 +1018,8 @@ void *kimage_map_segment(struct kimage *image, int idx)
>  
>  void kimage_unmap_segment(void *segment_buffer)
>  {
> -	vunmap(segment_buffer);
> +	if (is_vmalloc_addr(segment_buffer))
> +		vunmap(segment_buffer);
>  }
>  
>  struct kexec_load_limit {
> -- 
> 2.49.0
> 


