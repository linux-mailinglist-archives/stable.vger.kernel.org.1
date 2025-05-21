Return-Path: <stable+bounces-145767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBF6ABEBBF
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 08:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B971BA601E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 06:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1271023185E;
	Wed, 21 May 2025 06:09:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C8635;
	Wed, 21 May 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.200.0.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747807790; cv=none; b=vB3k7M0wMCTxA8i7LcxMgbE40yNMukTTfCDVC/rTSMk3fWexjECoQgGRRfo1FY4mDxcYE8oyJt2bCLFWHVfgCj4P4A+zoKBRDFIvJi7YPEYSKUy4VU6126qLjTN8hNNe74iNMyOgHQjmQ9K3LdaYMwt8oIaghFb6jeaCVI6it8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747807790; c=relaxed/simple;
	bh=mnNRJkZi6gF9GPc+4DEd9yX4jfVkL1nTvpti+jEwQQg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=VwhU75omCyIFdtPa1YkJIbrvW+Kb/wAA6IIRnUSYgF5j+AXzRf4ih85DIHWeEjrT4FRDt7YOGAZROeUlzB/jwol/7f5rSk7KMTCjwTlmgzLXaO+bVv4CSOSsObqr+gCl9wXQV1BazXlo0IO9EruL5oTRocFq3RGHE+vniPxzb7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=fail smtp.mailfrom=themaw.net; arc=none smtp.client-ip=121.200.0.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=themaw.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 97FCF10046A;
	Wed, 21 May 2025 16:09:45 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R9Be8wtoUa3F; Wed, 21 May 2025 16:09:45 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 6A8AD10046C; Wed, 21 May 2025 16:09:45 +1000 (AEST)
X-Spam-Level: 
Received: from [192.168.68.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id 9EA4E10046A;
	Wed, 21 May 2025 16:09:43 +1000 (AEST)
Message-ID: <97895fbb-21ae-40c4-9af4-3fa7a1b11729@themaw.net>
Date: Wed, 21 May 2025 14:09:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 0/5] kernfs: backport locking and concurrency
 improvement
From: Ian Kent <raven@themaw.net>
To: Qingfang Deng <dqfext@gmail.com>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20250521015336.3450911-1-dqfext@gmail.com>
 <c36cb32c-9434-4978-af75-ff6f04468c44@themaw.net>
Content-Language: en-US
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <c36cb32c-9434-4978-af75-ff6f04468c44@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/5/25 13:35, Ian Kent wrote:
> On 21/5/25 09:53, Qingfang Deng wrote:
>> KCSAN reports concurrent accesses to inode->i_mode:
>>
>> ==================================================================
>> BUG: KCSAN: data-race in generic_permission / kernfs_iop_permission
>>
>> write to 0xffffffe001129590 of 2 bytes by task 2477 on cpu 1:
>>   kernfs_iop_permission+0x72/0x1a0
>>   link_path_walk.part.0.constprop.0+0x348/0x420
>>   path_openat+0xee/0x10f0
>>   do_filp_open+0xaa/0x160
>>   do_sys_openat2+0x252/0x380
>>   sys_openat+0x4c/0xa0
>>   ret_from_syscall+0x0/0x2
>>
>> read to 0xffffffe001129590 of 2 bytes by task 3902 on cpu 3:
>>   generic_permission+0x26/0x120
>>   kernfs_iop_permission+0x150/0x1a0
>>   link_path_walk.part.0.constprop.0+0x348/0x420
>>   path_lookupat+0x58/0x280
>>   filename_lookup+0xae/0x1f0
>>   user_path_at_empty+0x3a/0x70
>>   vfs_statx+0x82/0x170
>>   __do_sys_newfstatat+0x36/0x70
>>   sys_newfstatat+0x2e/0x50
>>   ret_from_syscall+0x0/0x2
>>
>> Reported by Kernel Concurrency Sanitizer on:
>> CPU: 3 PID: 3902 Comm: ls Not tainted 5.10.104+ #0
>> ==================================================================
>
> It's been soo long since this was merged.
>
> I seem to vaguely remember something along these lines and after 
> analyzing it
>
> came to the conclusion it was a false positive.
>
> Let me think about it for a while and see if I can remember the reasoning.

Ok, IIRC, so my thinking was that mode is actually stored in the node 
->mode and is

always updated while holding the write lock and copying the same value 
from ->mode

in multiple concurrent threads wouldn't lead to corruption of inode->mode.


>
>
>
> Ian
>
>>
>> kernfs_iop_permission+0x72/0x1a0:
>>
>> kernfs_refresh_inode at fs/kernfs/inode.c:174
>>   169
>>   170     static void kernfs_refresh_inode(struct kernfs_node *kn, 
>> struct inode *inode)
>>   171     {
>>   172         struct kernfs_iattrs *attrs = kn->iattr;
>>   173
>>> 174<        inode->i_mode = kn->mode;
>>   175         if (attrs)
>>   176             /*
>>   177              * kernfs_node has non-default attributes get them 
>> from
>>   178              * persistent copy in kernfs_node.
>>   179              */
>>
>> (inlined by) kernfs_iop_permission at fs/kernfs/inode.c:285
>>   280             return -ECHILD;
>>   281
>>   282         kn = inode->i_private;
>>   283
>>   284         mutex_lock(&kernfs_mutex);
>>> 285<        kernfs_refresh_inode(kn, inode);
>>   286         mutex_unlock(&kernfs_mutex);
>>   287
>>   288         return generic_permission(inode, mask);
>>   289     }
>>   290
>>
>> generic_permission+0x26/0x120:
>>
>> acl_permission_check at fs/namei.c:298
>>   293      * Note that the POSIX ACL check cares about the 
>> MAY_NOT_BLOCK bit,
>>   294      * for RCU walking.
>>   295      */
>>   296     static int acl_permission_check(struct inode *inode, int mask)
>>   297     {
>>> 298<        unsigned int mode = inode->i_mode;
>>   299
>>   300         /* Are we the owner? If so, ACL's don't matter */
>>   301         if (likely(uid_eq(current_fsuid(), inode->i_uid))) {
>>   302             mask &= 7;
>>   303             mode >>= 6;
>>
>> (inlined by) generic_permission at fs/namei.c:353
>>   348         int ret;
>>   349
>>   350         /*
>>   351          * Do the basic permission checks.
>>   352          */
>>> 353<        ret = acl_permission_check(inode, mask);
>>   354         if (ret != -EACCES)
>>   355             return ret;
>>   356
>>   357         if (S_ISDIR(inode->i_mode)) {
>>   358             /* DACs are overridable for directories */
>>
>> Backport the series from 5.15 to fix the concurrency bug.
>> https://lore.kernel.org/all/162642752894.63632.5596341704463755308.stgit@web.messagingengine.com 
>>
>>
>> Ian Kent (5):
>>    kernfs: add a revision to identify directory node changes
>>    kernfs: use VFS negative dentry caching
>>    kernfs: switch kernfs to use an rwsem
>>    kernfs: use i_lock to protect concurrent inode updates
>>    kernfs: dont call d_splice_alias() under kernfs node lock
>>
>>   fs/kernfs/dir.c             | 153 ++++++++++++++++++++----------------
>>   fs/kernfs/file.c            |   4 +-
>>   fs/kernfs/inode.c           |  26 +++---
>>   fs/kernfs/kernfs-internal.h |  24 +++++-
>>   fs/kernfs/mount.c           |  12 +--
>>   fs/kernfs/symlink.c         |   4 +-
>>   include/linux/kernfs.h      |   7 +-
>>   7 files changed, 138 insertions(+), 92 deletions(-)
>>
>

