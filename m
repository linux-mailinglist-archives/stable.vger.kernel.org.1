Return-Path: <stable+bounces-188899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F99BFA257
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 08:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EAE188C7CA
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 06:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE7A2EC0BB;
	Wed, 22 Oct 2025 06:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZGVsJof6"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6326139D;
	Wed, 22 Oct 2025 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112899; cv=none; b=kzDTeke6twcprLgIirwLP4hsSNdsjuhY9eupb24ZcGtz43DRbKusW8V8V4UpvX8RAc1qvmH0rhYs/f+KvgsZ6Xx74JvtKwFqdJ/TFInsMmoTYvOLdcx7JGRgKroz3l9oSH7trjdtTUOyVTzDNKsp8iKkcPfj0d+BB4NU9V8CBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112899; c=relaxed/simple;
	bh=+hL0miMu2efF/q8FanVfxv6B9+KLc5IphfM8WVdYgq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utRLYazPcgnnXsWoBxOl3lOrQ6BNsfpMKPFCEnNUqEuzSFTwoAjypzuGvl+gkb5u0VBDrLYDcGjlMyQjPByodu9cCAhvAtvQWLAvuZ7r899nLFFWuoKBMKg/ZipoGMdFHT0sLahqDL2qW0Axj3oupcZG0s76pIifgp1/0bRG5BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZGVsJof6; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49bfd367-bb7e-4680-a859-d6ac500d1334@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761112894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaKTtydp6I4aIQxhn86P3BAwgNQxEfqBxIOSSlgkBPM=;
	b=ZGVsJof6iMjWSHuR5ov4Or/qdDwPisoId8W2V45U1a+S7XD/tZMzr6/JEbVKREB0SP8Puz
	79Y4HFxLemsNK6x1F5k5kdHbjZ/fSUsYBPmDWxA4wWDyZ+pYDs0llCAtpiWe+hgx4HEWKP
	5qEzcEh0okJCRunHxGYLZJbLwuYY1xQ=
Date: Wed, 22 Oct 2025 14:01:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
Content-Language: en-US
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 shuah@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Leon Hwang <leon.hwang@linux.dev>
References: <20251022055138.375042-1-leon.hwang@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251022055138.375042-1-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

+Cc: Greg

On 2025/10/22 13:51, Leon Hwang wrote:
> Fix the build error:
> 
> map_hugetlb.c: In function 'main':
> map_hugetlb.c:79:25: warning: implicit declaration of function 'default_huge_page_size' [-Wimplicit-function-declaration]
>     79 |         hugepage_size = default_huge_page_size();
>        |                         ^~~~~~~~~~~~~~~~~~~~~~
> /usr/bin/ld: /tmp/ccYOogvJ.o: in function 'main':
> map_hugetlb.c:(.text+0x114): undefined reference to 'default_huge_page_size'
> 
> According to the latest selftests, 'default_huge_page_size' has been
> moved to 'vm_util.c'. So fix the error by the same way.
> 
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>   tools/testing/selftests/vm/Makefile      |  1 +
>   tools/testing/selftests/vm/userfaultfd.c | 24 ------------------------
>   tools/testing/selftests/vm/vm_util.c     | 21 +++++++++++++++++++++
>   tools/testing/selftests/vm/vm_util.h     |  1 +
>   4 files changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
> index 192ea3725c5c..ed90deebef0d 100644
> --- a/tools/testing/selftests/vm/Makefile
> +++ b/tools/testing/selftests/vm/Makefile
> @@ -100,6 +100,7 @@ $(OUTPUT)/madv_populate: vm_util.c
>   $(OUTPUT)/soft-dirty: vm_util.c
>   $(OUTPUT)/split_huge_page_test: vm_util.c
>   $(OUTPUT)/userfaultfd: vm_util.c
> +$(OUTPUT)/map_hugetlb: vm_util.c
>   
>   ifeq ($(MACHINE),x86_64)
>   BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 297f250c1d95..4751b28eba18 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -1674,30 +1674,6 @@ static int userfaultfd_stress(void)
>   		|| userfaultfd_events_test() || userfaultfd_minor_test();
>   }
>   
> -/*
> - * Copied from mlock2-tests.c
> - */
> -unsigned long default_huge_page_size(void)
> -{
> -	unsigned long hps = 0;
> -	char *line = NULL;
> -	size_t linelen = 0;
> -	FILE *f = fopen("/proc/meminfo", "r");
> -
> -	if (!f)
> -		return 0;
> -	while (getline(&line, &linelen, f) > 0) {
> -		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
> -			hps <<= 10;
> -			break;
> -		}
> -	}
> -
> -	free(line);
> -	fclose(f);
> -	return hps;
> -}
> -
>   static void set_test_type(const char *type)
>   {
>   	if (!strcmp(type, "anon")) {
> diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
> index fc5743bc1283..613cc61602c9 100644
> --- a/tools/testing/selftests/vm/vm_util.c
> +++ b/tools/testing/selftests/vm/vm_util.c
> @@ -161,6 +161,27 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size)
>   	return __check_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_size);
>   }
>   
> +unsigned long default_huge_page_size(void)
> +{
> +	unsigned long hps = 0;
> +	char *line = NULL;
> +	size_t linelen = 0;
> +	FILE *f = fopen("/proc/meminfo", "r");
> +
> +	if (!f)
> +		return 0;
> +	while (getline(&line, &linelen, f) > 0) {
> +		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
> +			hps <<= 10;
> +			break;
> +		}
> +	}
> +
> +	free(line);
> +	fclose(f);
> +	return hps;
> +}
> +
>   static bool check_vmflag(void *addr, const char *flag)
>   {
>   	char buffer[MAX_LINE_LENGTH];
> diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
> index 470f85fe9594..a4439db0d6f8 100644
> --- a/tools/testing/selftests/vm/vm_util.h
> +++ b/tools/testing/selftests/vm/vm_util.h
> @@ -11,4 +11,5 @@ uint64_t read_pmd_pagesize(void);
>   bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
>   bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
>   bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
> +unsigned long default_huge_page_size(void);
>   bool softdirty_supported(void);


