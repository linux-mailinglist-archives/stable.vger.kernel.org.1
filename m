Return-Path: <stable+bounces-81457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53924993523
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BFD1C221BC
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90551DD9C8;
	Mon,  7 Oct 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B/VjrMdh"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17101DD9A9;
	Mon,  7 Oct 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322619; cv=none; b=eacgtpT3kSmb9aB1FvhEhyDcU6/pTCGnLxtNCRR8j3/pG4uyuWV+O7wf/9Qi9eFdV8MjBjh0N8ZNIw3Ee0rtXe2fm8fpFhhDVueACz8/4GpYdD5HK7CAZSBVW+Qt5giX5WYc9STlgWaKZ8ZaR53sW4Y63gNeeWUTYPk/t1o9aqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322619; c=relaxed/simple;
	bh=u+30JXUHcP/AG61dYIfwAaebgWm+p7qItAE2HfL9gr8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UM8ign9FY2+ZxHC273x8xeAbqIR/KTdkWD2AOy7B32mhobRBBGzzcCk2vXtvI/HTP+NhG8A+qCZlkulEX6M4WXKyb6vr0fgL+2g8B+puG5J8/pBL53E7uVILXjTp08qvnEOHxZXgnS3LvTRTDoKgXLCyVT+mCLfa+2RuVn0RayI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B/VjrMdh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.126] (unknown [131.107.159.254])
	by linux.microsoft.com (Postfix) with ESMTPSA id 71D4920DBA08;
	Mon,  7 Oct 2024 10:36:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 71D4920DBA08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1728322617;
	bh=YhvwUmoZKvzeFtXdLf9AkV0KSoQ16a9yJuWwNCSNLaw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=B/VjrMdhYWfnsAehlwBdCPZLLhb26vO7ReT3jivdWFvRj6q9NQmaSMwCAwu4kxHcD
	 7Bs3YMOMQ2Nh68zRQkEQfAjB0PLucruAloVlC5thH2eJgE+0iBhF0DumfvZjx6BFCn
	 y+l2nHI123UbF+CTb1kpkT11DAWWXZstsYnRhLqM=
Message-ID: <6144d8b5-8b3d-42d9-bf28-b88327f29124@linux.microsoft.com>
Date: Mon, 7 Oct 2024 10:36:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "coredump: Standartize and fix logging" has been added to
 the 6.10-stable tree
From: Roman Kisel <romank@linux.microsoft.com>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 sashal@kernel.org, Kees Cook <kees@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
References: <20241006152737.10366-1-sashal@kernel.org>
 <b11f4672-6c68-41f2-92c3-e7a15555a6ac@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <b11f4672-6c68-41f2-92c3-e7a15555a6ac@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Adding also Oleg as it was my impression from working with Oleg,
this area might be of interest for Oleg. I've crossed paths with
very few people who contribute to the "./kernel", and don't know
who to ask for another look if this is safe for the stable kernel.

Let us err on the side of caution perhaps unless folks are sure
all is going to be well with the stable kernel and get_task_comm().
Another datapoint would be that Linus reverted this change from
6.12-rc1.

Roman

On 10/7/2024 10:26 AM, Roman Kisel wrote:
> Sasha,
> 
> Thank you very much for taking this to the stable kernel!
> With the 6.12-rc1, folks saw unkillable processes, and the suspicion was
> that get_task_comm() takes a lock on the task_struct.
> 
> Kees was kind enough to look into that and sent out
> https://lore.kernel.org/all/20240928210830.work.307-kees@kernel.org/.
> 
> As much as I'd love to see these logs produced by the kernel to help
> with core dump diagnostics, I am really worried that lock might cause
> more harm than the patches bring value, let alone this is a stable
> kernel, and as I understand, folks might run very important workloads
> trusting the stable kernel.
> 
> If you see why these patches are good for the stable kernel (e.g. there
> is no lock as in 6.12), I trust your judgement. Added Kees and Eric
> in hopes they have time to help if this is a good change for
> the stable kernel.
> 
> Thank you all for your help!
> 
> On 10/6/2024 8:27 AM, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>      coredump: Standartize and fix logging
>>
>> to the 6.10-stable tree which can be found at:
>>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable- 
>> queue.git;a=summary
>>
>> The filename of the patch is:
>>       coredump-standartize-and-fix-logging.patch
>> and it can be found in the queue-6.10 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
>>
>>
>> commit f0a5649db30d6ff2509281ace680db9cc08ce258
>> Author: Roman Kisel <romank@linux.microsoft.com>
>> Date:   Thu Jul 18 11:27:24 2024 -0700
>>
>>      coredump: Standartize and fix logging
>>      [ Upstream commit c114e9948c2b6a0b400266e59cc656b59e795bca ]
>>      The coredump code does not log the process ID and the comm
>>      consistently, logs unescaped comm when it does log it, and
>>      does not always use the ratelimited logging. That makes it
>>      harder to analyze logs and puts the system at the risk of
>>      spamming the system log incase something crashes many times
>>      over and over again.
>>      Fix that by logging TGID and comm (escaped) consistently and
>>      using the ratelimited logging always.
>>      Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>      Tested-by: Allen Pais <apais@linux.microsoft.com>
>>      Link: https://lore.kernel.org/r/20240718182743.1959160-2- 
>> romank@linux.microsoft.com
>>      Signed-off-by: Kees Cook <kees@kernel.org>
>>      Signed-off-by: Sasha Levin <sashal@kernel.org>
>>
>> diff --git a/fs/coredump.c b/fs/coredump.c
>> index a57a06b80f571..19d3343b93c6b 100644
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -586,8 +586,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>           struct subprocess_info *sub_info;
>>           if (ispipe < 0) {
>> -            printk(KERN_WARNING "format_corename failed\n");
>> -            printk(KERN_WARNING "Aborting core\n");
>> +            coredump_report_failure("format_corename failed, aborting 
>> core");
>>               goto fail_unlock;
>>           }
>> @@ -607,27 +606,21 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>                * right pid if a thread in a multi-threaded
>>                * core_pattern process dies.
>>                */
>> -            printk(KERN_WARNING
>> -                "Process %d(%s) has RLIMIT_CORE set to 1\n",
>> -                task_tgid_vnr(current), current->comm);
>> -            printk(KERN_WARNING "Aborting core\n");
>> +            coredump_report_failure("RLIMIT_CORE is set to 1, 
>> aborting core");
>>               goto fail_unlock;
>>           }
>>           cprm.limit = RLIM_INFINITY;
>>           dump_count = atomic_inc_return(&core_dump_count);
>>           if (core_pipe_limit && (core_pipe_limit < dump_count)) {
>> -            printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
>> -                   task_tgid_vnr(current), current->comm);
>> -            printk(KERN_WARNING "Skipping core dump\n");
>> +            coredump_report_failure("over core_pipe_limit, skipping 
>> core dump");
>>               goto fail_dropcount;
>>           }
>>           helper_argv = kmalloc_array(argc + 1, sizeof(*helper_argv),
>>                           GFP_KERNEL);
>>           if (!helper_argv) {
>> -            printk(KERN_WARNING "%s failed to allocate memory\n",
>> -                   __func__);
>> +            coredump_report_failure("%s failed to allocate memory", 
>> __func__);
>>               goto fail_dropcount;
>>           }
>>           for (argi = 0; argi < argc; argi++)
>> @@ -644,8 +637,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>           kfree(helper_argv);
>>           if (retval) {
>> -            printk(KERN_INFO "Core dump to |%s pipe failed\n",
>> -                   cn.corename);
>> +            coredump_report_failure("|%s pipe failed", cn.corename);
>>               goto close_fail;
>>           }
>>       } else {
>> @@ -658,10 +650,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>               goto fail_unlock;
>>           if (need_suid_safe && cn.corename[0] != '/') {
>> -            printk(KERN_WARNING "Pid %d(%s) can only dump core "\
>> -                "to fully qualified path!\n",
>> -                task_tgid_vnr(current), current->comm);
>> -            printk(KERN_WARNING "Skipping core dump\n");
>> +            coredump_report_failure(
>> +                "this process can only dump core to a fully qualified 
>> path, skipping core dump");
>>               goto fail_unlock;
>>           }
>> @@ -730,13 +720,13 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>           idmap = file_mnt_idmap(cprm.file);
>>           if (!vfsuid_eq_kuid(i_uid_into_vfsuid(idmap, inode),
>>                       current_fsuid())) {
>> -            pr_info_ratelimited("Core dump to %s aborted: cannot 
>> preserve file owner\n",
>> -                        cn.corename);
>> +            coredump_report_failure("Core dump to %s aborted: "
>> +                "cannot preserve file owner", cn.corename);
>>               goto close_fail;
>>           }
>>           if ((inode->i_mode & 0677) != 0600) {
>> -            pr_info_ratelimited("Core dump to %s aborted: cannot 
>> preserve file permissions\n",
>> -                        cn.corename);
>> +            coredump_report_failure("Core dump to %s aborted: "
>> +                "cannot preserve file permissions", cn.corename);
>>               goto close_fail;
>>           }
>>           if (!(cprm.file->f_mode & FMODE_CAN_WRITE))
>> @@ -757,7 +747,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>            * have this set to NULL.
>>            */
>>           if (!cprm.file) {
>> -            pr_info("Core dump to |%s disabled\n", cn.corename);
>> +            coredump_report_failure("Core dump to |%s disabled", 
>> cn.corename);
>>               goto close_fail;
>>           }
>>           if (!dump_vma_snapshot(&cprm))
>> @@ -983,11 +973,10 @@ void validate_coredump_safety(void)
>>   {
>>       if (suid_dumpable == SUID_DUMP_ROOT &&
>>           core_pattern[0] != '/' && core_pattern[0] != '|') {
>> -        pr_warn(
>> -"Unsafe core_pattern used with fs.suid_dumpable=2.\n"
>> -"Pipe handler or fully qualified core dump path required.\n"
>> -"Set kernel.core_pattern before fs.suid_dumpable.\n"
>> -        );
>> +
>> +        coredump_report_failure("Unsafe core_pattern used with 
>> fs.suid_dumpable=2: "
>> +            "pipe handler or fully qualified core dump path required. "
>> +            "Set kernel.core_pattern before fs.suid_dumpable.");
>>       }
>>   }
>> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
>> index 0904ba010341a..45e598fe34766 100644
>> --- a/include/linux/coredump.h
>> +++ b/include/linux/coredump.h
>> @@ -43,8 +43,30 @@ extern int dump_align(struct coredump_params *cprm, 
>> int align);
>>   int dump_user_range(struct coredump_params *cprm, unsigned long start,
>>               unsigned long len);
>>   extern void do_coredump(const kernel_siginfo_t *siginfo);
>> +
>> +/*
>> + * Logging for the coredump code, ratelimited.
>> + * The TGID and comm fields are added to the message.
>> + */
>> +
>> +#define __COREDUMP_PRINTK(Level, Format, ...) \
>> +    do {    \
>> +        char comm[TASK_COMM_LEN];    \
>> +    \
>> +        get_task_comm(comm, current);    \
>> +        printk_ratelimited(Level "coredump: %d(%*pE): " Format 
>> "\n",    \
>> +            task_tgid_vnr(current), (int)strlen(comm), comm, 
>> ##__VA_ARGS__);    \
>> +    } while (0)    \
>> +
>> +#define coredump_report(fmt, ...) __COREDUMP_PRINTK(KERN_INFO, fmt, 
>> ##__VA_ARGS__)
>> +#define coredump_report_failure(fmt, ...) 
>> __COREDUMP_PRINTK(KERN_WARNING, fmt, ##__VA_ARGS__)
>> +
>>   #else
>>   static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
>> +
>> +#define coredump_report(...)
>> +#define coredump_report_failure(...)
>> +
>>   #endif
>>   #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
> 

-- 
Thank you,
Roman


