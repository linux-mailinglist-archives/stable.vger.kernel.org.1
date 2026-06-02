Return-Path: <stable+bounces-259829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oIKfCrbcHmoXWgAAu9opvQ
	(envelope-from <stable+bounces-259829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:37:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E434662E8FB
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 15:37:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=swemel.ru header.s=mail header.b=cbpbLoTz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259829-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-259829-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=swemel.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A77B83039B5A
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 13:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6173E92A5;
	Tue,  2 Jun 2026 13:31:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA03E7171;
	Tue,  2 Jun 2026 13:31:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407069; cv=none; b=SUtTlEQ4Nw2NrtilMox9YeiKwxiBllOp5grKKyCDVoJ4Q2UQQU+ggjuATQgy+1KzjgwCttwQOHQqEHbud+CJO1qpxNdXmLofp++/AcVelfJ6rw8qqZteaYCwnE5qOWXiI5NzM9f0/M42bBglT2K6i3BXnZ9XFExreZjmqK+WKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407069; c=relaxed/simple;
	bh=+tVLcVlWVP8sqA7lcmKWAuZAAP00CuiC8QnEgRnHuvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhSGmmm+3qUdXCbK+jmUoK8P78Lj/pua6haGdD7mAUup1PmG/cxVuebz/W6Jevv7/w9EEEc+cOv/sccsmtbntzdjD5prIHAvDbFofTgVa13V36qBsdhZTasGOJOJ+eGpViKgcOCU0c3vhV7RWbllGc7aX4wxLLnU1ZYfNjis+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=cbpbLoTz; arc=none smtp.client-ip=95.143.211.150
Message-ID: <b106ed26-e6ec-4254-b337-1d2e8e2adc58@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1780406602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh8OAXfhHS+6UAIB+GXE6Q+p6KA2mvrNI8Yp5MV9FiA=;
	b=cbpbLoTz3fhAq6WM7lXrYdZGeB7naQwe5N0UC5QK7+PEtHI5Cq9ayNOvBytoW6sN+/zn73
	crabGRwY/QRAYO5E0NwlDADTj2rID14S3oyJXtrMIXIs5H8z8VIG6G6DT2LSFHTfl81Bbf
	6Hy/QXYvreiBx5qNmHJ9W77Js5Ig9l4=
Date: Tue, 2 Jun 2026 16:23:21 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] make new mount API honour SB_NOUSER (was Re: [PATCH]
 block: Avoid mounting the bdev pseudo-filesystem in userspace)
To: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
References: <20260521072857.5078-1-arefev@swemel.ru>
 <20260602011907.GM2636677@ZenIV> <20260602013526.GO2636677@ZenIV>
 <20260602020444.GP2636677@ZenIV>
 <eevyuiiqt5b4n7kws2lc24jk2njdllanojl76t5cftx6he6hba@y46tiknbebj4>
Content-Language: en-US
From: Arefev <arefev@swemel.ru>
In-Reply-To: <eevyuiiqt5b4n7kws2lc24jk2njdllanojl76t5cftx6he6hba@y46tiknbebj4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[swemel.ru,quarantine];
	R_DKIM_ALLOW(-0.20)[swemel.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259829-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[arefev@swemel.ru,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,m:axboe@kernel.dk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[swemel.ru:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arefev@swemel.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,swemel.ru:mid,swemel.ru:dkim,swemel.ru:from_mime,swemel.ru:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E434662E8FB


02.06.2026 12:11, Jan Kara пишет:
> On Tue 02-06-26 03:04:44, Al Viro wrote:
>> one should *not* be allowed to mount one of those, new API or not.
>>
>> Reported-by: Denis Arefev <arefev@swemel.ru>
>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Won't it make sense to actually check fc->sb_flags before we call
> vfs_create_mount()? Otherwise it looks good to me.
>
> 								Honza

Hi all.

The sequence of system calls before the crash could be as follows:

fsopen("bdev", ...)
fsconfig(fd_fs, FSCONFIG_CMD_CREATE, 0,0,0)
fsmount(fd_fs, 0,0)
move_mount(fd_mnt, "", AT_FDCWD, "./file1", 0x46ul)

The system call executed at the time of the cras:

open("/dev/media0", ...);

Simplified stacktrace:

path_openat
|-> link_path_walk
    |-> walk_component
       |-> __lookup_slow
          |-> ld = inode->i_op->lookup(inode, dentry, flags);   <- Oops


Searching for possible solutions in the commit history yielded the 
following result:

commit fd3e007f6c6a0f677e4ee8aca4b9bab8ad6cab9a
commit 1a6e9e76b713d9632783efe78295ed3507fdad64
commit d6f2589ad561aa5fa39f347eca6942668b7560a1

Checking the fc->sb_flags flag before calling vfs_create_mount() is a 
great idea,
if it helps prevent crashes in two more file systems, 'sockfs' and 'pipefs'.

Best regards, Denis.
>
>> ---
>> [[ I still want to see the rest of the reproducer - report smells like a missing
>> d_can_lookup() somewhere, on top of fsmount(2) bug]]
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index fe919abd2f01..17777c837683 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -4499,6 +4499,10 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
>>   	new_mnt = vfs_create_mount(fc);
>>   	if (IS_ERR(new_mnt))
>>   		return PTR_ERR(new_mnt);
>> +	if (new_mnt->mnt_sb->s_flags & SB_NOUSER) {
>> +		mntput(new_mnt);
>> +		return -EINVAL;
>> +	}
>>   	new_mnt->mnt_flags = mnt_flags;
>>   
>>   	new_path.dentry = dget(fc->root);

