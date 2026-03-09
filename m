Return-Path: <stable+bounces-223716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKTPEvoPr2kYNQIAu9opvQ
	(envelope-from <stable+bounces-223716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 19:22:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0C323E905
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 19:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12AC1304669D
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C302DB78E;
	Mon,  9 Mar 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Itn79YwZ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39D72D592F;
	Mon,  9 Mar 2026 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773080452; cv=none; b=GR8WYIaG1kJFcujy20izYLMPpb1nmzja2dctsCy77FKVVU4N4qUeinJM3XnYsa2kVX/IQnI1G++iCVU4wEzbJZKSVnZShvFkb5IAr3lnBlt1qxjyQq/0CiOyYsLRgPndxyZNJjp1uMiAoMVXoXFzI+BMz9k6UcAjGRvqWWiZX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773080452; c=relaxed/simple;
	bh=lM2shcoMAala64LCpMR03FNR5T+jxvZ/Mev/s4KKeIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUc3rDoMO3pJGZ+3Wt5w9ALbN8DQxlznNy3dpRrDyxFrq8pgypfiqujGj20g53jfe45ETGL0WN9Vyza8txiLvWU64DqmVJZgugtP3HZCHyj1GTnTDB7vHpWh34BdeiN/ny5sWk6fTwblOJDkBKqIMNrbasOgdY82p/AX9tUWVHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Itn79YwZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.14.136.118] (unknown [131.107.1.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 16BBF20B710C;
	Mon,  9 Mar 2026 11:20:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16BBF20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773080450;
	bh=Fq/6K4sHG0Wal4SG7B+hSp6CYeAWTp8iMxw0NhkCjYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Itn79YwZ17IU3/OombfyUKgeZ42hDeGxmT0NDlrCCIgNKEfm/AAhlYwQ9Rh++9JkI
	 sSNSmX56bKjF6cHEBIgX/Fw+UEN1mMETPuLqRyLt9lYTKQlaLzI7weQtlGUEgz07Lr
	 0Ua/0Ybm/dcHaX/NFwK8cpYHF3OkA+bgKjx9Ra2g=
Message-ID: <dc1de7c4-4ff9-4c12-89ae-dee1e76017f2@linux.microsoft.com>
Date: Mon, 9 Mar 2026 11:20:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "kexec: define functions to map and unmap segments" has
 been added to the 6.12-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>
References: <20260308164105.18682-1-sashal@kernel.org>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <20260308164105.18682-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CE0C323E905
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223716-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xmission.com:email]
X-Rspamd-Action: no action

On 3/8/2026 9:41 AM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>      kexec: define functions to map and unmap segments
>
> to the 6.12-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>       kexec-define-functions-to-map-and-unmap-segments.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 51827bfcdc1c02aa4ea01b7aadcea8c2b8250666
> Author: Steven Chen <chenste@linux.microsoft.com>
> Date:   Mon Apr 21 15:25:09 2025 -0700
>
>      kexec: define functions to map and unmap segments
>      
>      [ Upstream commit 0091d9241ea24c5275be4a3e5a032862fd9de9ec ]
>      
>      Implement kimage_map_segment() to enable IMA to map the measurement log
>      list to the kimage structure during the kexec 'load' stage. This function
>      gathers the source pages within the specified address range, and maps them
>      to a contiguous virtual address range.
>      
>      This is a preparation for later usage.
>      
>      Implement kimage_unmap_segment() for unmapping segments using vunmap().
>      
>      Cc: Eric Biederman <ebiederm@xmission.com>
>      Cc: Baoquan He <bhe@redhat.com>
>      Cc: Vivek Goyal <vgoyal@redhat.com>
>      Cc: Dave Young <dyoung@redhat.com>
>      Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>      Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>      Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>      Acked-by: Baoquan He <bhe@redhat.com>
>      Tested-by: Stefan Berger <stefanb@linux.ibm.com> # ppc64/kvm
>      Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>      Stable-dep-of: 10d1c75ed438 ("ima: verify the previous kernel's IMA buffer lies in addressable RAM")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3c..7d6b12f8b8d05 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
>   #define kexec_dprintk(fmt, arg...) \
>           do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>   
> +extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> +extern void kimage_unmap_segment(void *buffer);
>   #else /* !CONFIG_KEXEC_CORE */
>   struct pt_regs;
>   struct task_struct;
> +struct kimage;
>   static inline void __crash_kexec(struct pt_regs *regs) { }
>   static inline void crash_kexec(struct pt_regs *regs) { }
>   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>   static inline int kexec_crash_loaded(void) { return 0; }
> +static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> +{ return NULL; }
> +static inline void kimage_unmap_segment(void *buffer) { }
>   #define kexec_in_progress false
>   #endif /* CONFIG_KEXEC_CORE */
>   
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c0caa14880c3b..6c15cd5b9cae5 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
>   	return result;
>   }
>   
> +void *kimage_map_segment(struct kimage *image,
> +			 unsigned long addr, unsigned long size)
> +{

please consider the following patch applicable or not:

[PATCH 1/2] kernel/kexec: Change the prototype of kimage_map_segment() - 
Pingfan Liu 
<https://lore.kernel.org/linux-integrity/20251105130922.13321-1-piliu@redhat.com/>

Steven

> +	unsigned long src_page_addr, dest_page_addr = 0;
> +	unsigned long eaddr = addr + size;
> +	kimage_entry_t *ptr, entry;
> +	struct page **src_pages;
> +	unsigned int npages;
> +	void *vaddr = NULL;
> +	int i;
> +
> +	/*
> +	 * Collect the source pages and map them in a contiguous VA range.
> +	 */
> +	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
> +	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
> +	if (!src_pages) {
> +		pr_err("Could not allocate ima pages array.\n");
> +		return NULL;
> +	}
> +
> +	i = 0;
> +	for_each_kimage_entry(image, ptr, entry) {
> +		if (entry & IND_DESTINATION) {
> +			dest_page_addr = entry & PAGE_MASK;
> +		} else if (entry & IND_SOURCE) {
> +			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
> +				src_page_addr = entry & PAGE_MASK;
> +				src_pages[i++] =
> +					virt_to_page(__va(src_page_addr));
> +				if (i == npages)
> +					break;
> +				dest_page_addr += PAGE_SIZE;
> +			}
> +		}
> +	}
> +
> +	/* Sanity check. */
> +	WARN_ON(i < npages);
> +
> +	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
> +	kfree(src_pages);
> +
> +	if (!vaddr)
> +		pr_err("Could not map ima buffer.\n");
> +
> +	return vaddr;
> +}
> +
> +void kimage_unmap_segment(void *segment_buffer)
> +{
> +	vunmap(segment_buffer);
> +}
> +
>   struct kexec_load_limit {
>   	/* Mutex protects the limit count. */
>   	struct mutex mutex;



