Return-Path: <stable+bounces-50259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD59053E1
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABA6285E34
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A817B513;
	Wed, 12 Jun 2024 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="geAkIrEP"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C2A1EF1A;
	Wed, 12 Jun 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199387; cv=none; b=lDob8xtllIv0BHRJa4UatSko/OqMv9SmAhcEirafC56QfC6aCAkPS/oq+XPUlFPbL1aMO3SiO7XYocN3X9+pFTtGyaZrhrLAZuHKjNez2PbjbVhQ0mQsO+uc47ktYW89juef1Uhdv10dX46n/s+a5M7yFOW7w3n0AzIMQKyT5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199387; c=relaxed/simple;
	bh=G+/YbTPUzPFhAhef2S5fdJZcq7ly7ZnYe5drKnp8NJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGYvJ4MU+CaITs/ykEfTj8fW/bydKhPiNBU8dMF3aLpy4I30/bVsogPZEBe/TvfeeYC3p/UORpNGCiMEneD31Nm9tjRF7xeNPwk3+bSQgirVeyRwGJFcipuQ5vXRBUliQlKYklB5OslpPcPUCvcQOnqO+FC3CV2muxAD3fO246Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=geAkIrEP; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=1FGAP7qOnb/lT4NAs00dzeuWltKxm4nGQ3NRIx3zrWo=;
	t=1718199385; x=1718631385; b=geAkIrEPeG9uihICxa23FsHbytc3aJFsaI0xfdpUn0dB+9K
	ZwI9FqWUERtckF9bkkaCDInGl3p53eaSFAvPa2+poyx50fu25MVDB7r1MkqmVj0WlD0uCpUKfO9Sb
	gxAnvpYwqqDSPJAqIJaRrPHtYxTdy75dP6m+oFexXDG5aswTdhHMQcVTYF9K7OMhTG1KyWESAxAsx
	muCQ0DOA76ltuBYsatzai1fCIr/zVQ69EksahJTJz9ZnIQBjpDyp1OsrXBiSD61bnL3bLtej2XPGC
	6JLYP0jF7znx6yjBzRESeAKlSRkx0CrR4QnHKTY2BAkaBinenqGKcq6rx2HnaziA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sHO9G-0000rc-MQ; Wed, 12 Jun 2024 15:36:22 +0200
Message-ID: <ceb24cb7-dbb0-48b0-9de2-9557f3e310b5@leemhuis.info>
Date: Wed, 12 Jun 2024 15:36:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
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
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <CAE4VaRGYoa_CAtttifVzmkdm4vW05WtoCwOrcH7=rSUVeD6n5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718199385;0b49ec19;
X-HE-SMSGID: 1sHO9G-0000rc-MQ

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Ilkka or Steven, what happened to this? This thread looks stalled. I
also was unsuccessful when looking for other threads related to this
report or the culprit. Did it fall through the cracks or am I missing
something here?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 02.06.24 09:32, Ilkka Naulapää wrote:
> sorry longer delay, been a bit busy but here is the result from that
> new patch. Only applied this patch so if the previous one is needed
> also, let me know and I'll rerun it.
> 
> --Ilkka
> 
> On Thu, May 30, 2024 at 5:00 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> On Thu, 30 May 2024 16:02:37 +0300
>> Ilkka Naulapää <digirigawa@gmail.com> wrote:
>>
>>> applied your patch and here's the output.
>>>
>>
>> Unfortunately, it doesn't give me any new information. I added one more
>> BUG on, want to try this? Otherwise, I'm pretty much at a lost. :-/
>>
>> -- Steve
>>
>> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
>> index de5b72216b1a..a090495e78c9 100644
>> --- a/fs/tracefs/inode.c
>> +++ b/fs/tracefs/inode.c
>> @@ -39,13 +39,17 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
>>                 return NULL;
>>
>>         ti->flags = 0;
>> +       ti->magic = 20240823;
>>
>>         return &ti->vfs_inode;
>>  }
>>
>>  static void tracefs_free_inode(struct inode *inode)
>>  {
>> -       kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
>> +       struct tracefs_inode *ti = get_tracefs(inode);
>> +
>> +       BUG_ON(ti->magic != 20240823);
>> +       kmem_cache_free(tracefs_inode_cachep, ti);
>>  }
>>
>>  static ssize_t default_read_file(struct file *file, char __user *buf,
>> @@ -147,16 +151,6 @@ static const struct inode_operations tracefs_dir_inode_operations = {
>>         .rmdir          = tracefs_syscall_rmdir,
>>  };
>>
>> -struct inode *tracefs_get_inode(struct super_block *sb)
>> -{
>> -       struct inode *inode = new_inode(sb);
>> -       if (inode) {
>> -               inode->i_ino = get_next_ino();
>> -               inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>> -       }
>> -       return inode;
>> -}
>> -
>>  struct tracefs_mount_opts {
>>         kuid_t uid;
>>         kgid_t gid;
>> @@ -384,6 +378,7 @@ static void tracefs_dentry_iput(struct dentry *dentry, struct inode *inode)
>>                 return;
>>
>>         ti = get_tracefs(inode);
>> +       BUG_ON(ti->magic != 20240823);
>>         if (ti && ti->flags & TRACEFS_EVENT_INODE)
>>                 eventfs_set_ef_status_free(dentry);
>>         iput(inode);
>> @@ -568,6 +563,18 @@ struct dentry *eventfs_end_creating(struct dentry *dentry)
>>         return dentry;
>>  }
>>
>> +struct inode *tracefs_get_inode(struct super_block *sb)
>> +{
>> +       struct inode *inode = new_inode(sb);
>> +
>> +       BUG_ON(sb->s_op != &tracefs_super_operations);
>> +       if (inode) {
>> +               inode->i_ino = get_next_ino();
>> +               inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>> +       }
>> +       return inode;
>> +}
>> +
>>  /**
>>   * tracefs_create_file - create a file in the tracefs filesystem
>>   * @name: a pointer to a string containing the name of the file to create.
>> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
>> index 69c2b1d87c46..9059b8b11bb6 100644
>> --- a/fs/tracefs/internal.h
>> +++ b/fs/tracefs/internal.h
>> @@ -9,12 +9,15 @@ enum {
>>  struct tracefs_inode {
>>         unsigned long           flags;
>>         void                    *private;
>> +       unsigned long           magic;
>>         struct inode            vfs_inode;
>>  };
>>
>>  static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
>>  {
>> -       return container_of(inode, struct tracefs_inode, vfs_inode);
>> +       struct tracefs_inode *ti = container_of(inode, struct tracefs_inode, vfs_inode);
>> +       BUG_ON(ti->magic != 20240823);
>> +       return ti;
>>  }
>>
>>  struct dentry *tracefs_start_creating(const char *name, struct dentry *parent);

