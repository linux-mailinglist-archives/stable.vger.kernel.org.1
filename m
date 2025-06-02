Return-Path: <stable+bounces-148904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 466A7ACAB63
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812391899ED6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4A1D516F;
	Mon,  2 Jun 2025 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DXQiGigt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115A3FB0E
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748856558; cv=none; b=HapKM7XLM/MufG2VSJgcNh1Ffc5CxThesGFANQUDmJgR3KCR+fFbmWJx1QU8KvZ5zfxIAXjGuY1cex77EaspdB4dz09x+fiExKgqwud2ShHBjGwOPQrsoHurAnl5E4uad+7wrpY3oPsMcxiBH2ReDDUWUljn5lOUTvZbH4ib26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748856558; c=relaxed/simple;
	bh=Z/OCRF9VVBoAlOYHmXELvtIMst0v2Bzs6zfBzgwMdZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKCvZa4Skrc/wfGwxHXzdWl6hgGQZwlZNX+FlC4DwUZ7NRW4unI4VpCGsexemZTL1fyFu0+75WzF2j6EFp+uXk0Sgui+zvHBHZVBSFkzZOSNcz9sj/aeCpPB2IDstY+zFTJySlM6Yz5mB01CoIWy/PIPHgnRYUcllKO48/pX59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DXQiGigt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20FBC4CEEB;
	Mon,  2 Jun 2025 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748856558;
	bh=Z/OCRF9VVBoAlOYHmXELvtIMst0v2Bzs6zfBzgwMdZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXQiGigt058cExPA2MpUpUyi0n4u0PwXH6IbsO/RXUfJyHRRKooMeH4ui62zRatsh
	 1fa0NuaOyA5sf6y2xAFZkmZTjey5BlyMevnttglFZvtsiEGiSbCed9yCtKCxUMnMqj
	 djapNmt0o6uVoZxBCn96XJ5bG+c02qD4QpWldzqQ=
Date: Mon, 2 Jun 2025 11:29:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guangming Wang <guangming.wang@windriver.com>
Cc: stable@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
	Zach O'Keefe <zokeefe@google.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y v2] selftests/vm: fix split huge page tests
Message-ID: <2025060247-sterility-drum-baae@gregkh>
References: <20250530045140.3838342-1-guangming.wang@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530045140.3838342-1-guangming.wang@windriver.com>

On Fri, May 30, 2025 at 12:51:40PM +0800, Guangming Wang wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> [ upstream commit dd63bd7df41a8f9393a2e3ff9157a441c08eb996  ]
> 
> Fix two inputs to check_anon_huge() and one if condition, so the tests
> work as expected.
> 
> Steps to reproduce the issue.
> make headers
> make -C tools/testing/selftests/vm
> 
> Before patching:test fails with a non-zero exit code
> 
> ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test \
> > /dev/null 2>&1;echo $?
> 1
> 
> ~/linux$ ./split_huge_page_test
> No THP is allocated
> 
> After patching:
> 
> ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test \
> > /dev/null 2>&1;echo $?
> 0
> 
> ~/linux$ sudo tools/testing/selftests/vm/split_huge_page_test
> Split huge pages successful
> ...
> 
> Link: https://lkml.kernel.org/r/20230306160907.16804-1-zi.yan@sent.com
> Fixes: c07c343cda8e ("selftests/vm: dedup THP helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Zach O'Keefe <zokeefe@google.com>
> Tested-by: Zach O'Keefe <zokeefe@google.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Guangming Wang <guangming.wang@windriver.com>
> ---
>  tools/testing/selftests/vm/split_huge_page_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
> index 76e1c36dd..b8558c7f1 100644
> --- a/tools/testing/selftests/vm/split_huge_page_test.c
> +++ b/tools/testing/selftests/vm/split_huge_page_test.c
> @@ -106,7 +106,7 @@ void split_pmd_thp(void)
>  	for (i = 0; i < len; i++)
>  		one_page[i] = (char)i;
>  
> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>  		printf("No THP is allocated\n");
>  		exit(EXIT_FAILURE);
>  	}
> @@ -122,7 +122,7 @@ void split_pmd_thp(void)
>  		}
>  
>  
> -	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
>  		printf("Still AnonHugePages not split\n");
>  		exit(EXIT_FAILURE);
>  	}
> @@ -169,7 +169,7 @@ void split_pte_mapped_thp(void)
>  	for (i = 0; i < len; i++)
>  		one_page[i] = (char)i;
>  
> -	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
>  		printf("No THP is allocated\n");
>  		exit(EXIT_FAILURE);
>  	}
> -- 
> 2.34.1
> 
> 

As previously stated, we can not take any backports for the stable trees
from your company until you have properly changed your development
processes.

greg k-h

