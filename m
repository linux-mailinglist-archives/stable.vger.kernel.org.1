Return-Path: <stable+bounces-87787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50B9ABAF4
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 03:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B8B2309E
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D21DFE1;
	Wed, 23 Oct 2024 01:22:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3119BA48;
	Wed, 23 Oct 2024 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729646563; cv=none; b=M/kiH++UyYjsaMOynq6wN8pBHgA6EV/3Hk4rYPN0SfGPHcqUR3kvYulBt7e8wVMAOAcV7eYXbVOwzK9sblrtHVuHKKQAVhlPkyndzwnbIb4i0/3TOf8LxbZanOvpFLvYA8PBga8igHbrialMrebo1hbrGUnQoDR0uK4Lq4hsWsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729646563; c=relaxed/simple;
	bh=YEUKkmPzFGCy3wY70iefUpQnRR6Eciph03ecy+2fDQs=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tbla+4IrnpuUAZPjmQR+Fp2/tXmGIRdHb4/XDEAqHIwlUXkmjbSW/XBy3QTiyHi2+hOomALtndcXxP/H7yEw78YxuY9NFEzHgJ9rY/iqZ4KhBJUDwRCN+NmyqkGki1Vdzm3n8ctklnlPIdGHtHwkjrFEsE2Skyzpp8gHQ27FGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XYB8B3ZVnz2FbGs;
	Wed, 23 Oct 2024 09:21:14 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B63B1A0188;
	Wed, 23 Oct 2024 09:22:37 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 09:22:36 +0800
Subject: Re: Patch "selftests: mm: fix the incorrect usage() info of
 khugepaged" has been added to the 6.11-stable tree
To: <stable@vger.kernel.org>, <stable-commits@vger.kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
References: <20241022174426.2836479-1-sashal@kernel.org>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <9a81f472-22ab-c921-ae2e-ec5843be4490@huawei.com>
Date: Wed, 23 Oct 2024 09:22:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241022174426.2836479-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)

On 2024/10/23 1:44, Sasha Levin wrote:

> This is a note to let you know that I've just added the patch titled
>
>      selftests: mm: fix the incorrect usage() info of khugepaged
>
> to the 6.11-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>       selftests-mm-fix-the-incorrect-usage-info-of-khugepa.patch
> and it can be found in the queue-6.11 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
Hi，
   I don't think this patch needs to be added to the stable tree because 
this just fixes usage
information, as Andrew had previously said：
https://lore.kernel.org/lkml/20241017001441.2db5adaaa63dc3faa0934204@linux-foundation.org/ 

>
>
>
> commit ad8b93ffe0a86e3b6be297826cd34b12080fc877
> Author: Nanyong Sun <sunnanyong@huawei.com>
> Date:   Tue Oct 15 10:02:57 2024 +0800
>
>      selftests: mm: fix the incorrect usage() info of khugepaged
>      
>      [ Upstream commit 3e822bed2fbd1527d88f483342b1d2a468520a9a ]
>      
>      The mount option of tmpfs should be huge=advise, not madvise which is not
>      supported and may mislead the users.
>      
>      Link: https://lkml.kernel.org/r/20241015020257.139235-1-sunnanyong@huawei.com
>      Fixes: 1b03d0d558a2 ("selftests/vm: add thp collapse file and tmpfs testing")
>      Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
>      Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>      Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
>      Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
>      Cc: Shuah Khan <shuah@kernel.org>
>      Cc: Zach O'Keefe <zokeefe@google.com>
>      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 829320a519e72..89dec42986825 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -1091,7 +1091,7 @@ static void usage(void)
>   	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
>   	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
>   	fprintf(stderr, "\n\tif [dir] is a (sub)directory of a tmpfs mount, tmpfs must be\n");
> -	fprintf(stderr,	"\tmounted with huge=madvise option for khugepaged tests to work\n");
> +	fprintf(stderr,	"\tmounted with huge=advise option for khugepaged tests to work\n");
>   	fprintf(stderr,	"\n\tSupported Options:\n");
>   	fprintf(stderr,	"\t\t-h: This help message.\n");
>   	fprintf(stderr,	"\t\t-s: mTHP size, expressed as page order.\n");
> .

