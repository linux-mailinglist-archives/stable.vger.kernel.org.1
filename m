Return-Path: <stable+bounces-92041-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5D9C3197
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0530281858
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444731534FB;
	Sun, 10 Nov 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="br8mmspl"
X-Original-To: stable@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489A2563;
	Sun, 10 Nov 2024 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731234406; cv=none; b=kEa15K7Ght64ik/0UspEdc4Z/7kFOMb/D6IyE2JlOpJUZy30LQy+YiztDVD9CJ3hEJxZ6SMpqQT3jCbAwKHITxpgt2gmDPv9oJ9JBOmNC36M7YnEXs1oUPSDQKnmlt+7g5zpCW3quXhAz60B+yE4NXhd/q2xBf08o7FmULiIUeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731234406; c=relaxed/simple;
	bh=wQOv0aeFJkP0HQGoyJPbQy8QR3cjiVEYaq96KdGGOFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxKTXAq3BYZq2zM2ekBw+DnzHZa4mxeqRLXNH8XWJbIWUptoe7xcXYECcpfPbYiujFhj4ix5AUtkXtfLbXnK/tpB5ETlZs36TQ91t/B1cM8xYBZ+GoTDaG3hXzOZbBA5RMoi7jV6Eif6o/31FROn1u9VSNHGwzlE7DOmEEdUeac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=br8mmspl; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731234394; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Hh5TIo8Adsd0UnRdLeMY3JjG1/I6mNeYfACCJ18JKXg=;
	b=br8mmsplOsHQZnSi1WaaM3RjnXExdjW1vwjz2j35HhSKCOW8XpzYc1KpdWjaBX1Bz6QYt5EUBTrXy6gGKolVWgXx7IRDBGFJLUHNQMDMykXag13JmuvUFYXkcod/BCCnZ7Hs2PObWX50vBWPRiEAbQG6kkndmrXHmzm+AKeNcKw=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJ2WP0m_1731234391 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 10 Nov 2024 18:26:32 +0800
Message-ID: <7a0fc6f4-f185-4d5e-b532-c9e04b0a48c4@linux.alibaba.com>
Date: Sun, 10 Nov 2024 18:26:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 0/2] Fixed perf abort when taken branch stack
 sampling enabled
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, irogers@google.com,
 mark.rutland@arm.com, namhyung@kernel.org, peterz@infradead.org,
 acme@redhat.com, kprateek.nayak@amd.com, ravi.bangoria@amd.com,
 sandipan.das@amd.com, anshuman.khandual@arm.com, german.gomez@arm.com,
 james.clark@arm.com, terrelln@fb.com, seanjc@google.com,
 changbin.du@huawei.com, liuwenyu7@huawei.com, yangjihong1@huawei.com,
 mhiramat@kernel.org, ojeda@kernel.org, song@kernel.org, leo.yan@linaro.org,
 kjain@linux.ibm.com, ak@linux.intel.com, kan.liang@linux.intel.com,
 atrajeev@linux.vnet.ibm.com, siyanteng@loongson.cn, liam.howlett@oracle.com,
 pbonzini@redhat.com, jolsa@kernel.org
References: <20241104112736.28554-1-xueshuai@linux.alibaba.com>
 <2024111029-gorged-humiliate-f0bb@gregkh>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <2024111029-gorged-humiliate-f0bb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/10 13:12, Greg KH 写道:
> On Mon, Nov 04, 2024 at 07:27:34PM +0800, Shuai Xue wrote:
>> On x86 platform, kernel v5.10.228, perf-report command aborts due to "free():
>> invalid pointer" when perf-record command is run with taken branch stack
>> sampling enabled. This regression can be reproduced with the following steps:
>>
>> 	- sudo perf record -b
>> 	- sudo perf report
>>
>> The root cause is that bi[i].to.ms.maps does not always point to thread->maps,
>> which is a buffer dynamically allocated by maps_new(). Instead, it may point to
>> &machine->kmaps, while kmaps is not a pointer but a variable. The original
>> upstream commit c1149037f65b ("perf hist: Add missing puts to
>> hist__account_cycles") worked well because machine->kmaps had been refactored to
>> a pointer by the previous commit 1a97cee604dc ("perf maps: Use a pointer for
>> kmaps").
>>
>> The memory leak issue, which the reverted patch intended to fix, has been solved
>> by commit cf96b8e45a9b ("perf session: Add missing evlist__delete when deleting
>> a session"). The root cause is that the evlist is not being deleted on exit in
>> perf-report, perf-script, and perf-data. Consequently, the reference count of
>> the thread increased by thread__get() in hist_entry__init() is not decremented
>> in hist_entry__delete(). As a result, thread->maps is not properly freed.
>>
>> To this end,
>>
>> - PATCH 1/2 reverts commit a83fc293acd5c5050a4828eced4a71d2b2fffdd3 to fix the
>>    abort regression.
>> - PATCH 2/2 backports cf96b8e45a9b ("perf session: Add missing evlist__delete
>>    when deleting a session") to fix memory leak issue.
>>
>> Riccardo Mancini (1):
>>    perf session: Add missing evlist__delete when deleting a session
>>
>> Shuai Xue (1):
>>    Revert "perf hist: Add missing puts to hist__account_cycles"
>>
>>   tools/perf/util/hist.c    | 10 +++-------
>>   tools/perf/util/session.c |  5 ++++-
>>   2 files changed, 7 insertions(+), 8 deletions(-)
> 
> perf actually works and builds on this kernel tree?  That's news to me,
> but hey, I'll take these now as obviously someone is still trying to run
> it.


Yes, it does. Commit cf96b8e45a9b ("perf session: Add missing evlist__delete
when deleting a session") addresses a memory leak issue but is not applicable
for the 5.10-stable tree.


> But why not just use the latest version of perf instead?

Yes, the lastest verison of perf works well. There are many distribution are
based on the upstream 5.10-stable tree, and this issue breaks the perf usage.
So IMHO, it could be fixed in upstream.

Best Regards,
Shuai

