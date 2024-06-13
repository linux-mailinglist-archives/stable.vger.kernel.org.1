Return-Path: <stable+bounces-50415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A7906593
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B771C1F22DB8
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126F213C8EE;
	Thu, 13 Jun 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="adOEAd6b"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5413C827;
	Thu, 13 Jun 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718264928; cv=none; b=qUbIojJgibrRo6Hl89I7tFQDIsYvR0gUsc5XI4rL/jklAdVVhbm8zArNyw10SI/q7ip3MJUbrQm6+73TiPe//G8LWhiJfJ79Zixv1Kcm7EbxKuQtwdlSzokHwR9QaO/GOoMcv/T0Vsf+QJ9Cd/YzRLFdXLmB4OHNITMfFvO2vRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718264928; c=relaxed/simple;
	bh=/5EG8VMd7LliSml0B5DgPKmGWzFXy5kJxof/+4sXrGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP2+I/V4ItF4TH5cOLhpxBfMrQS/ZPCWQp7jVYQoF21J/vvvPayAHSJu86STzzGywieWRT34YpB7OJXQgl7BS3z9HzqdxJ7/QZXrkqZo9bQdhBc5fuw8i39eQExIW4195Wzj9xIPW5+BSAeuR82wer0kGYbdAr9eJV+LXQJX14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=adOEAd6b; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Zjr+VSpN2YOV8SzNhgW0HxlJxurFf1+bVKCUe+pa/6g=;
	t=1718264926; x=1718696926; b=adOEAd6bDO6WKtWHJJi5tI9lzcYLhC471j1AST0wa6gVTKx
	OKHtZYCuNQ7vPSTgj5XU8PDSe/fI69n9lfVP1tcf4T93yoPzMEsgaG9mLMrxdJRn3SagALtFgrlCB
	d6qAaOO/Mfi+2b07aWUciVxo15Ok5q5kxp3+o5EY6R+FrFUVMjwu7NdCsXH2jVX/HTb9nc5NyMaNp
	m8ECo0Nbk7MqRLSB8xjCAF+a0TM8u94QzLIdNUPGaOzosQsou5Z4TZTinQRFigXcnWK+A6/DHpVjX
	HGertUroJY3FxP5J3S2oL8fpZR+pIMT1TcvE1D0F3+eta0XShJ+JXGWeWIgkkKsw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sHfCL-0007aF-Hm; Thu, 13 Jun 2024 09:48:41 +0200
Message-ID: <d1a2072c-e558-418c-a3b0-280d9be0e8f3@leemhuis.info>
Date: Thu, 13 Jun 2024 09:48:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug in Kernel 6.8.x, 6.9.x Causing Trace/Panic During
 Shutdown/Reboot
To: =?UTF-8?Q?Ilkka_Naulap=C3=A4=C3=A4?= <digirigawa@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <CAE4VaREzY+a2PvQJYJbfh8DwB4OP7kucZG-e28H22xyWob1w_A@mail.gmail.com>
 <5b79732b-087c-411f-a477-9b837566673e@leemhuis.info>
 <20240527183139.42b6123c@rorschach.local.home>
 <CAE4VaRHaijpV1CC9Jo_Lg4tNQb_+=LTHwygOp5Bm2z5ErVzeow@mail.gmail.com>
 <20240528144743.149e351b@rorschach.local.home>
 <CAE4VaRE3_MYVt+=BGs+WVCmKUiQv0VSKE2NT+JmUPKG0UF+Juw@mail.gmail.com>
 <20240529144757.79d09eeb@rorschach.local.home>
 <20240529154824.2db8133a@rorschach.local.home>
 <CAE4VaRGRwsp+KuEWtsUCxjEtgv1FO+_Ey1-A9xr-o+chaUeteg@mail.gmail.com>
 <20240530095953.0020dff9@rorschach.local.home>
 <CAE4VaRGYoa_CAtttifVzmkdm4vW05WtoCwOrcH7=rSUVeD6n5g@mail.gmail.com>
 <ceb24cb7-dbb0-48b0-9de2-9557f3e310b5@leemhuis.info>
 <20240612115612.2e5f4b34@rorschach.local.home>
 <CAE4VaRFwdxNuUWb=S+itDLZf1rOZx9px+xoLWCi+hdUaWJwj6Q@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAE4VaRFwdxNuUWb=S+itDLZf1rOZx9px+xoLWCi+hdUaWJwj6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718264926;2021880b;
X-HE-SMSGID: 1sHfCL-0007aF-Hm

On 13.06.24 09:32, Ilkka Naulapää wrote:
> On Wed, Jun 12, 2024 at 6:56 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>> On Wed, 12 Jun 2024 15:36:22 +0200
>> "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info> wrote:
>>>
>>> Ilkka or Steven, what happened to this? This thread looks stalled. I
>>> also was unsuccessful when looking for other threads related to this
>>> report or the culprit. Did it fall through the cracks or am I missing
>>> something here?
>
>> Honesty, I have no idea where the bug is. I can't reproduce it. [...]

Steven, thx for the update! And yeah, that's how it sometimes is. Given
that we haven't seen similar reports (at least afaics) it's nothing I
worry much about.

> ok, so if you don't have any idea where this bug is after those debug
> patches, I'll try to find some time to bisect it as a last resort.
> Stay tuned.

Yeah, that would be great help. Thank you, too!

Ciao, Thorsten

>>> On 02.06.24 09:32, Ilkka Naulapää wrote:
>>>> sorry longer delay, been a bit busy but here is the result from that
>>>> new patch. Only applied this patch so if the previous one is needed
>>>> also, let me know and I'll rerun it.
>>>>
>>>> --Ilkka
>>>>
>>>> On Thu, May 30, 2024 at 5:00 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>>>>
>>>>> On Thu, 30 May 2024 16:02:37 +0300
>>>>> Ilkka Naulapää <digirigawa@gmail.com> wrote:
>>>>>
>>>>>> applied your patch and here's the output.
>>>>>>
>>>>>
>>>>> Unfortunately, it doesn't give me any new information. I added one more
>>>>> BUG on, want to try this? Otherwise, I'm pretty much at a lost. :-/
>>>>>
>>>>> -- Steve
>>>>>
>>>>> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
>>>>> index de5b72216b1a..a090495e78c9 100644
>>>>> --- a/fs/tracefs/inode.c
>>>>> +++ b/fs/tracefs/inode.c
>>>>> @@ -39,13 +39,17 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
>>>>>                 return NULL;
>>>>>
>>>>>         ti->flags = 0;
>>>>> +       ti->magic = 20240823;
>>>>>
>>>>>         return &ti->vfs_inode;
>>>>>  }
>>>>>
>>>>>  static void tracefs_free_inode(struct inode *inode)
>>>>>  {
>>>>> -       kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
>>>>> +       struct tracefs_inode *ti = get_tracefs(inode);
>>>>> +
>>>>> +       BUG_ON(ti->magic != 20240823);
>>>>> +       kmem_cache_free(tracefs_inode_cachep, ti);
>>>>>  }
>>>>>
>>>>>  static ssize_t default_read_file(struct file *file, char __user *buf,
>>>>> @@ -147,16 +151,6 @@ static const struct inode_operations tracefs_dir_inode_operations = {
>>>>>         .rmdir          = tracefs_syscall_rmdir,
>>>>>  };
>>>>>
>>>>> -struct inode *tracefs_get_inode(struct super_block *sb)
>>>>> -{
>>>>> -       struct inode *inode = new_inode(sb);
>>>>> -       if (inode) {
>>>>> -               inode->i_ino = get_next_ino();
>>>>> -               inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>>>>> -       }
>>>>> -       return inode;
>>>>> -}
>>>>> -
>>>>>  struct tracefs_mount_opts {
>>>>>         kuid_t uid;
>>>>>         kgid_t gid;
>>>>> @@ -384,6 +378,7 @@ static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
>>>>>                 return;
>>>>>
>>>>>         ti = get_tracefs(inode);
>>>>> +       BUG_ON(ti->magic != 20240823);
>>>>>         if (ti && ti->flags & TRACEFS_EVENT_INODE)
>>>>>                 eventfs_set_ef_status_free(dentry);
>>>>>         iput(inode);
>>>>> @@ -568,6 +563,18 @@ struct dentry *eventfs_end_creating(struct dentry *dentry)
>>>>>         return dentry;
>>>>>  }
>>>>>
>>>>> +struct inode *tracefs_get_inode(struct super_block *sb)
>>>>> +{
>>>>> +       struct inode *inode = new_inode(sb);
>>>>> +
>>>>> +       BUG_ON(sb->s_op != &tracefs_super_operations);
>>>>> +       if (inode) {
>>>>> +               inode->i_ino = get_next_ino();
>>>>> +               inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>>>>> +       }
>>>>> +       return inode;
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * tracefs_create_file - create a file in the tracefs filesystem
>>>>>   * @name: a pointer to a string containing the name of the file to create.
>>>>> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
>>>>> index 69c2b1d87c46..9059b8b11bb6 100644
>>>>> --- a/fs/tracefs/internal.h
>>>>> +++ b/fs/tracefs/internal.h
>>>>> @@ -9,12 +9,15 @@ enum {
>>>>>  struct tracefs_inode {
>>>>>         unsigned long           flags;
>>>>>         void                    *private;
>>>>> +       unsigned long           magic;
>>>>>         struct inode            vfs_inode;
>>>>>  };
>>>>>
>>>>>  static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
>>>>>  {
>>>>> -       return container_of(inode, struct tracefs_inode, vfs_inode);
>>>>> +       struct tracefs_inode *ti = container_of(inode, struct tracefs_inode, vfs_inode);
>>>>> +       BUG_ON(ti->magic != 20240823);
>>>>> +       return ti;
>>>>>  }
>>>>>
>>>>>  struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);
>>
> 
> 

