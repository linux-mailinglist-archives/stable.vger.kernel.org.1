Return-Path: <stable+bounces-240070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Pt+F3Iq52mo4wEAu9opvQ
	(envelope-from <stable+bounces-240070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:42:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BB9437C59
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1BE830451F7
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FD4384236;
	Tue, 21 Apr 2026 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sNl7Ekjz"
X-Original-To: stable@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B32D97B9;
	Tue, 21 Apr 2026 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757147; cv=none; b=X9YWKOg+BtDk4UxyvmD64prIcBXOFAfDm2BGsXWCKUJsdZGDcKiaoRCnk4ay5eOGYW4f9RIcRhNuHqLsW2EWj4fkG7x3vqDR0aF/vQBSn0roVJwlaS9sixR0C7iDDq5k7ju4CTnNjwiYPkCsW44KDUzC9JmuXTovpXcinvBOZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757147; c=relaxed/simple;
	bh=TAh2SSn8HR4LiXY7T0ZM3gunZfpEVZsC431nR139Gaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cte/NQxNqxz1awjVjwbEiDYMY/BvoNueBsKZR7MvOL9VgRN5vhuQdc/ixGzr7pA9EXf1gPZ8g3CpVjjdLOk0IWBrKEDnFjKWnruHoUi7sGpmR4NePdZefLP9sFU1+FXjan6+lBwiyhc2cP0ruLwssG+n5/aGHyTyirkuwth58sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sNl7Ekjz; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776757136; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bBR+x8/rFj/yPCNM4srOeJsm+pZYnjkZyx2mrSw3Ooc=;
	b=sNl7Ekjz4XaeEI2G5MZXWT4zcQ3aWmuestUG0HBFB3V+Pd5+nqwG6xZKEV04wiwc/jSmjVeIV+yuBFNj7F2U8zcxNbIs7gKa0AM/5YK9p4DgYl7hQu54i/5nfqHbKuel5rz/ynQc3mqrdRttZfKry7Xd+Uv4mQWvwNY6nxyi5FA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X1S7tuK_1776757134;
Received: from 30.221.132.26(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X1S7tuK_1776757134 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Apr 2026 15:38:55 +0800
Message-ID: <d1fe814b-9527-4dc7-b79a-9952b4199242@linux.alibaba.com>
Date: Tue, 21 Apr 2026 15:38:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] erofs: fix the out-of-bounds nameoff handling for
 trailing dirents
To: Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>, Yuhao Jiang <danisjiang@gmail.com>,
 Junrui Luo <moonafterrain@outlook.com>, stable@vger.kernel.org
References: <20260416063511.3173774-1-hsiangkao@linux.alibaba.com>
 <20260416094408.3466613-1-hsiangkao@linux.alibaba.com>
 <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <b9d787ce-9020-4140-8d13-23a20809976d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240070-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,outlook.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid,outlook.com:email,alibaba.com:email,sashiko.dev:url]
X-Rspamd-Queue-Id: C2BB9437C59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/21 15:26, Chao Yu wrote:
> On 4/16/2026 5:44 PM, Gao Xiang wrote:
>> Currently we already have boundary-checks for nameoffs, but the trailing
>> dirents are special since the namelens are calculated with strnlen()
>> with unchecked nameoffs.
>>
>> If a crafted EROFS has a trailing dirent with nameoff >= maxsize,
>> maxsize - nameoff can underflow, causing strnlen() to read past the
>> directory block.
>>
>> nameoff0 should also be verified to be a multiple of
>> `sizeof(struct erofs_dirent)` as well [1].
>>
>> [1] https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com
>> Fixes: 3aa8ec716e52 ("staging: erofs: add directory operations")
>> Fixes: 33bac912840f ("staging: erofs: keep corrupted fs from crashing kernel in erofs_readdir()")
>> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
>> Reported-by: Junrui Luo <moonafterrain@outlook.com>
>> Closes: https://lore.kernel.org/r/A0FD7E0F-7558-49B0-8BC8-EB1ECDB2479A@outlook.com
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> v3:
>>   - Disallow unaligned nameoff0 to avoid petential oob reads as well.
>>
>>   fs/erofs/dir.c | 29 ++++++++++++++++-------------
>>   1 file changed, 16 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
>> index e5132575b9d3..d074fded1577 100644
>> --- a/fs/erofs/dir.c
>> +++ b/fs/erofs/dir.c
>> @@ -19,20 +19,18 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>>           const char *de_name = (char *)dentry_blk + nameoff;
>>           unsigned int de_namelen;
>> -        /* the last dirent in the block? */
>> -        if (de + 1 >= end)
>> -            de_namelen = strnlen(de_name, maxsize - nameoff);
>> -        else
>> +        /* non-trailing dirent in the directory block? */
>> +        if (de + 1 < end)
>>               de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
>> +        else if (maxsize <= nameoff)
>> +            goto err_bogus;
>> +        else
>> +            de_namelen = strnlen(de_name, maxsize - nameoff);
>> -        /* a corrupted entry is found */
>> -        if (nameoff + de_namelen > maxsize ||
>> -            de_namelen > EROFS_NAME_LEN) {
>> -            erofs_err(dir->i_sb, "bogus dirent @ nid %llu",
>> -                  EROFS_I(dir)->nid);
>> -            DBG_BUGON(1);
>> -            return -EFSCORRUPTED;
>> -        }
>> +        /* a corrupted entry is found (including negative namelen) */
>> +        if (!in_range32(de_namelen, 1, EROFS_NAME_LEN) ||
>> +            nameoff + de_namelen > maxsize)
>> +            goto err_bogus;
>>           if (!dir_emit(ctx, de_name, de_namelen,
>>                     erofs_nid_to_ino64(EROFS_SB(dir->i_sb),
>> @@ -42,6 +40,10 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
>>           ctx->pos += sizeof(struct erofs_dirent);
>>       }
>>       return 0;
>> +err_bogus:
>> +    erofs_err(dir->i_sb, "bogus dirent @ nid %llu", EROFS_I(dir)->nid);
>> +    DBG_BUGON(1);
>> +    return -EFSCORRUPTED;
>>   }
>>   static int erofs_readdir(struct file *f, struct dir_context *ctx)
>> @@ -88,7 +90,8 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
>>           }
>>           nameoff = le16_to_cpu(de->nameoff);
>> -        if (nameoff < sizeof(struct erofs_dirent) || nameoff >= bsz) {
> 
> You mean?
> 
> if (!nameoff || nameoff >= bsz || nameoff % sizeof(struct erofs_dirent))

The explanation can be seen as:
https://sashiko.dev/#/patchset/20260416063511.3173774-1-hsiangkao%40linux.alibaba.com

But I think `nameoff < sizeof(struct erofs_dirent)` is also fine?
I could also switch to your suggested version.

Thanks,
Gao Xiang


