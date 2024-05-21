Return-Path: <stable+bounces-45475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB28CA812
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 08:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF9C1C20CCF
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 06:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477E745026;
	Tue, 21 May 2024 06:41:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0941C63
	for <stable@vger.kernel.org>; Tue, 21 May 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716273676; cv=none; b=DzYq9ntqvMCsadirRb6XtOzhoWMisNGHq4sbUP4jqlinBxiz0DBbk6eeJbC/WgzeFg59hWitmQWTomuMfIY+VDNKRcgfFOX7rRKl4OhHkkCIQ1u6iE5x4ehDpYdIcIQ//5Di2T3LJV9sUxVt6K26oH/dYz2yKFP6EhIhqSwZUYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716273676; c=relaxed/simple;
	bh=UsIPqo80hwDzYk/Qi4HoWjVphQwDjJwwZYeWIXY4ODE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=pSfzXWtjxW6ckkTujj/dlGFeZK6oXgNqJcF3qqEcXo+4lSGIeee4HmPB1MkPvg2az+qgl96awfFuTpMSHrKeXzEEh50QNv0gf0t0pOIcjDVlEBhTi6Dd2S4pkjYdctfqmkco4cb7B+0e+5iqGkbLPUUGqtEJ1jmTPXn4fxFpYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76ED7DA7;
	Mon, 20 May 2024 23:41:36 -0700 (PDT)
Received: from [10.162.42.16] (e116581.arm.com [10.162.42.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F12603F641;
	Mon, 20 May 2024 23:41:10 -0700 (PDT)
Message-ID: <aa271bf5-7b3f-477c-a2ca-3aa62f8a5b9e@arm.com>
Date: Tue, 21 May 2024 12:11:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/mm: compaction_test: Fix bogus test
 success on Aarch64
To: Dev Jain <dev.jain@arm.com>
References: <20240521063755.666388-1-dev.jain@arm.com>
 <20240521063755.666388-2-dev.jain@arm.com>
Content-Language: en-US
Cc: stable@vger.kernel.org
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240521063755.666388-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, I was just sending to myself for testing, git send-email picked

up stable@vger.kernel.org too. Please ignore this.

On 5/21/24 12:07, Dev Jain wrote:
> Currently, if at runtime we are not able to allocate a huge page, the
> test will trivially pass on Aarch64 due to no exception being raised on
> division by zero while computing compaction_index. Fix that by checking
> for nr_hugepages == 0. Anyways, in general, avoid a division by zero by
> exiting the program beforehand. While at it, fix a typo.
>
> Changes in v2:
> - Combine with this series, handle unsigned long number of hugepages
>
> Fixes: bd67d5c15cc1 ("Test compaction of mlocked memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   tools/testing/selftests/mm/compaction_test.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
> index 4f42eb7d7636..0b249a06a60b 100644
> --- a/tools/testing/selftests/mm/compaction_test.c
> +++ b/tools/testing/selftests/mm/compaction_test.c
> @@ -82,12 +82,13 @@ int prereq(void)
>   	return -1;
>   }
>   
> -int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
> +int check_compaction(unsigned long mem_free, unsigned long hugepage_size)
>   {
> +	unsigned long nr_hugepages_ul;
>   	int fd, ret = -1;
>   	int compaction_index = 0;
> -	char initial_nr_hugepages[10] = {0};
> -	char nr_hugepages[10] = {0};
> +	char initial_nr_hugepages[20] = {0};
> +	char nr_hugepages[20] = {0};
>   
>   	/* We want to test with 80% of available memory. Else, OOM killer comes
>   	   in to play */
> @@ -134,7 +135,12 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
>   
>   	/* We should have been able to request at least 1/3 rd of the memory in
>   	   huge pages */
> -	compaction_index = mem_free/(atoi(nr_hugepages) * hugepage_size);
> +	nr_hugepages_ul = strtoul(nr_hugepages, NULL, 10);
> +	if (!nr_hugepages_ul) {
> +		ksft_print_msg("ERROR: No memory is available as huge pages\n");
> +		goto close_fd;
> +	}
> +	compaction_index = mem_free/(nr_hugepages_ul * hugepage_size);
>   
>   	lseek(fd, 0, SEEK_SET);
>   
> @@ -145,11 +151,11 @@ int check_compaction(unsigned long mem_free, unsigned int hugepage_size)
>   		goto close_fd;
>   	}
>   
> -	ksft_print_msg("Number of huge pages allocated = %d\n",
> -		       atoi(nr_hugepages));
> +	ksft_print_msg("Number of huge pages allocated = %lu\n",
> +		       nr_hugepages_ul);
>   
>   	if (compaction_index > 3) {
> -		ksft_print_msg("ERROR: Less that 1/%d of memory is available\n"
> +		ksft_print_msg("ERROR: Less than 1/%d of memory is available\n"
>   			       "as huge pages\n", compaction_index);
>   		goto close_fd;
>   	}

