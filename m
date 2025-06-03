Return-Path: <stable+bounces-150654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70246ACC11C
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 09:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0522518885CA
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 07:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C051B2690F6;
	Tue,  3 Jun 2025 07:17:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3682690CB;
	Tue,  3 Jun 2025 07:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935075; cv=none; b=jNCNtcpFHhyR/gOXo0KOu9HeJUfKw1UU0sizQdSFMta3yV0uU3P68iACg/PEIqvc85Ig1SpTs94pZtq7PNhQeqtN75lipDd98BJOlv8YhIGFHSQVvbXK2Edo8UvBlCs/JHB+DNPIu/Js4K65GcYvn7GYzyuwHWvGLeqBRs2FqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935075; c=relaxed/simple;
	bh=m9WLxSzqX0TIhCseZ5xTwQ4lFZRmass9XCQLs0ObvpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5NN4WMloAdzjCvY9tGO0Q7l8ReUBSsGt+y0WgxRjCLaozKHHG3Gd6PTwOKpqoeMiCzYfrry9RCB/5evQvjFTRrY9ehjzmdPTu6BK9h8/wmg6/ALDdQVLykYSucTTuOIXTjlZVdnPnCeg7WludgcsRq3t3gTZ9WQyi4fmxXMk84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bBMVl0mgPzYQvYh;
	Tue,  3 Jun 2025 15:17:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 240F41A1921;
	Tue,  3 Jun 2025 15:17:50 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgD3pVqdoT5oHSlwOQ--.55901S2;
	Tue, 03 Jun 2025 15:17:49 +0800 (CST)
Message-ID: <8ea3ec70-dbe7-424f-b07f-add7c1cb1852@huaweicloud.com>
Date: Tue, 3 Jun 2025 15:17:49 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] selftests/mm: Extract read_sysfs and write_sysfs
 into vm_util
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
 Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com, pfalcato@suse.de,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 pulehui@huawei.com
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
 <20250529155650.4017699-4-pulehui@huaweicloud.com>
 <f1dfdffa-23b3-4d4a-8912-3a35e65963e4@lucifer.local>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <f1dfdffa-23b3-4d4a-8912-3a35e65963e4@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgD3pVqdoT5oHSlwOQ--.55901S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyxWrWUWr47Cr13ZFWfuFg_yoW3Grykp3
	Z3Ja4jgw4xKry7Gr12qFn8WryFyrs7tayjy397J34Ivr1Utr9agrWIka4UGw1kurZagr4f
	AayfXFs3Cr1UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/5/30 19:48, Lorenzo Stoakes wrote:
> On Thu, May 29, 2025 at 03:56:49PM +0000, Pu Lehui wrote:
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Extract read_sysfs and write_sysfs into vm_util. Meanwhile, rename
>> the function in thuge-gen that has the same name as read_sysfs.
> 
> Nice!
> 
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
>> ---
>>   tools/testing/selftests/mm/ksm_tests.c | 32 ++--------------------
>>   tools/testing/selftests/mm/thuge-gen.c |  6 ++--
>>   tools/testing/selftests/mm/vm_util.c   | 38 ++++++++++++++++++++++++++
>>   tools/testing/selftests/mm/vm_util.h   |  2 ++
>>   4 files changed, 45 insertions(+), 33 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
>> index dcdd5bb20f3d..e80deac1436b 100644
>> --- a/tools/testing/selftests/mm/ksm_tests.c
>> +++ b/tools/testing/selftests/mm/ksm_tests.c
>> @@ -58,40 +58,12 @@ int debug;
>>
>>   static int ksm_write_sysfs(const char *file_path, unsigned long val)
>>   {
>> -	FILE *f = fopen(file_path, "w");
>> -
>> -	if (!f) {
>> -		fprintf(stderr, "f %s\n", file_path);
>> -		perror("fopen");
>> -		return 1;
>> -	}
>> -	if (fprintf(f, "%lu", val) < 0) {
>> -		perror("fprintf");
>> -		fclose(f);
>> -		return 1;
>> -	}
>> -	fclose(f);
>> -
>> -	return 0;
>> +	return write_sysfs(file_path, val);
>>   }
>>
>>   static int ksm_read_sysfs(const char *file_path, unsigned long *val)
>>   {
>> -	FILE *f = fopen(file_path, "r");
>> -
>> -	if (!f) {
>> -		fprintf(stderr, "f %s\n", file_path);
>> -		perror("fopen");
>> -		return 1;
>> -	}
>> -	if (fscanf(f, "%lu", val) != 1) {
>> -		perror("fscanf");
>> -		fclose(f);
>> -		return 1;
>> -	}
>> -	fclose(f);
>> -
>> -	return 0;
>> +	return read_sysfs(file_path, val);
>>   }
>>
>>   static void ksm_print_sysfs(void)
>> diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
>> index a41bc1234b37..95b6f043a3cb 100644
>> --- a/tools/testing/selftests/mm/thuge-gen.c
>> +++ b/tools/testing/selftests/mm/thuge-gen.c
>> @@ -77,7 +77,7 @@ void show(unsigned long ps)
>>   	system(buf);
>>   }
>>
>> -unsigned long read_sysfs(int warn, char *fmt, ...)
>> +unsigned long thuge_read_sysfs(int warn, char *fmt, ...)
>>   {
> 
> I wonder if we could update these to use the newly shared functions?
> 
> Not a big deal though, perhaps a bit out of scope here, more of a nice-to-have.

Hi Lorenzo, Andrew,

Yep, we can do it more. But, actually, I am not sure about the merge 
process of mm module. Do I need to resend the whole series or just the 
diff below?


 From 13ecf9d66a0068d520be955e3ca8d9c0dc9d8393 Mon Sep 17 00:00:00 2001
From: Pu Lehui <pulehui@huawei.com>
Date: Tue, 3 Jun 2025 06:50:43 +0000
Subject: [PATCH] selftests/mm: Use generic read_sysfs in thuge-gen test

Use generic read_sysfs in thuge-gen test.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
  tools/testing/selftests/mm/thuge-gen.c | 37 +++++++-------------------
  1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c 
b/tools/testing/selftests/mm/thuge-gen.c
index 95b6f043a3cb..5a32ed0ba26c 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -77,40 +77,19 @@ void show(unsigned long ps)
  	system(buf);
  }

-unsigned long thuge_read_sysfs(int warn, char *fmt, ...)
+unsigned long read_free(unsigned long ps)
  {
-	char *line = NULL;
-	size_t linelen = 0;
-	char buf[100];
-	FILE *f;
-	va_list ap;
  	unsigned long val = 0;
+	char buf[100];

-	va_start(ap, fmt);
-	vsnprintf(buf, sizeof buf, fmt, ap);
-	va_end(ap);
+	snprintf(buf, sizeof buf,
+		 "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
+		 ps >> 10);
+	read_sysfs(buf, &val);

-	f = fopen(buf, "r");
-	if (!f) {
-		if (warn)
-			ksft_print_msg("missing %s\n", buf);
-		return 0;
-	}
-	if (getline(&line, &linelen, f) > 0) {
-		sscanf(line, "%lu", &val);
-	}
-	fclose(f);
-	free(line);
  	return val;
  }

-unsigned long read_free(unsigned long ps)
-{
-	return thuge_read_sysfs(ps != getpagesize(),
-			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
-			  ps >> 10);
-}
-
  void test_mmap(unsigned long size, unsigned flags)
  {
  	char *map;
@@ -173,6 +152,7 @@ void test_shmget(unsigned long size, unsigned flags)
  void find_pagesizes(void)
  {
  	unsigned long largest = getpagesize();
+	unsigned long shmmax_val = 0;
  	int i;
  	glob_t g;

@@ -195,7 +175,8 @@ void find_pagesizes(void)
  	}
  	globfree(&g);

-	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
+	read_sysfs("/proc/sys/kernel/shmmax", &shmmax_val);
+	if (shmmax_val < NUM_PAGES * largest)
  		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
  				   largest * NUM_PAGES);

-- 
2.34.1

> 
>>   	char *line = NULL;
>>   	size_t linelen = 0;
>> @@ -106,7 +106,7 @@ unsigned long read_sysfs(int warn, char *fmt, ...)
>>
>>   unsigned long read_free(unsigned long ps)
>>   {
>> -	return read_sysfs(ps != getpagesize(),
>> +	return thuge_read_sysfs(ps != getpagesize(),
>>   			  "/sys/kernel/mm/hugepages/hugepages-%lukB/free_hugepages",
>>   			  ps >> 10);
>>   }
>> @@ -195,7 +195,7 @@ void find_pagesizes(void)
>>   	}
>>   	globfree(&g);
>>
>> -	if (read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
>> +	if (thuge_read_sysfs(0, "/proc/sys/kernel/shmmax") < NUM_PAGES * largest)
>>   		ksft_exit_fail_msg("Please do echo %lu > /proc/sys/kernel/shmmax",
>>   				   largest * NUM_PAGES);
>>
>> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
>> index 1357e2d6a7b6..d899c272e0ee 100644
>> --- a/tools/testing/selftests/mm/vm_util.c
>> +++ b/tools/testing/selftests/mm/vm_util.c
>> @@ -486,3 +486,41 @@ int close_procmap(struct procmap_fd *procmap)
>>   {
>>   	return close(procmap->fd);
>>   }
>> +
>> +int write_sysfs(const char *file_path, unsigned long val)
>> +{
>> +	FILE *f = fopen(file_path, "w");
>> +
>> +	if (!f) {
>> +		fprintf(stderr, "f %s\n", file_path);
>> +		perror("fopen");
>> +		return 1;
>> +	}
>> +	if (fprintf(f, "%lu", val) < 0) {
>> +		perror("fprintf");
>> +		fclose(f);
>> +		return 1;
>> +	}
>> +	fclose(f);
>> +
>> +	return 0;
>> +}
>> +
>> +int read_sysfs(const char *file_path, unsigned long *val)
>> +{
>> +	FILE *f = fopen(file_path, "r");
>> +
>> +	if (!f) {
>> +		fprintf(stderr, "f %s\n", file_path);
>> +		perror("fopen");
>> +		return 1;
>> +	}
>> +	if (fscanf(f, "%lu", val) != 1) {
>> +		perror("fscanf");
>> +		fclose(f);
>> +		return 1;
>> +	}
>> +	fclose(f);
>> +
>> +	return 0;
>> +}
>> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
>> index 9211ba640d9c..f84c7c4680ea 100644
>> --- a/tools/testing/selftests/mm/vm_util.h
>> +++ b/tools/testing/selftests/mm/vm_util.h
>> @@ -87,6 +87,8 @@ int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
>>   int query_procmap(struct procmap_fd *procmap);
>>   bool find_vma_procmap(struct procmap_fd *procmap, void *address);
>>   int close_procmap(struct procmap_fd *procmap);
>> +int write_sysfs(const char *file_path, unsigned long val);
>> +int read_sysfs(const char *file_path, unsigned long *val);
>>
>>   static inline int open_self_procmap(struct procmap_fd *procmap_out)
>>   {
>> --
>> 2.34.1
>>


