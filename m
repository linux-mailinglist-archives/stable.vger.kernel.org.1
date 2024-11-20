Return-Path: <stable+bounces-94428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BEC9D3E5E
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 16:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DC5284A45
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 15:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889741BC9FC;
	Wed, 20 Nov 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd7FAWho"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A1481B3
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 14:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732114364; cv=none; b=BRJ0MuG+T/2U0rqwQ9vc0qPcqS/huD6pVzVwlfj5M2Ovzkh1LaUlDJA6v0RCbc3yPHMs7kssB5iARSB84nCeWzDte3xYWxJSfkE5o20dJnxdo3i7IYvcB/9nnDg+kIjsXkx5z1JLwrTheRRs4JpLLH6xZToYPc4E9GatyFe2CVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732114364; c=relaxed/simple;
	bh=CdFL1YwMVDlLwZvvgmecb0jbpveRCf4dbNHZhRiHrEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=osnI/QD6ywYMNmXsWm7eDUMtYIGHIhxiWy60Jz9ZmTDh5UysNxK14QC+KUP+DNRhBQzVvQ7/9UKeHMFnS/4rRvAvI08KER8KORi2yoI7G90oqVrDjIc/OnPd+JS222hFkcqCsnF/AxfOu8ZbqNdzSR8ISF/6MweT9f4yI/ieMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nd7FAWho; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732114361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qL9st3Em/o0uzp1J/08ioRXilfsvjPzqscn6722CoY=;
	b=Nd7FAWhoSdfxukCKpt/Im91o5C9gDRq1PH6nVifepkqeqstMLb5TvjPSvy+MXR+erph48H
	AtBO3FmOSBzyk+0qntcBhjiSEj4SpmNIKaMjbyUmol1xY8DQx4I4dYPVIHNH6UuO/c4Q0n
	7PGrPrxdpHURfctNUY1OxWR9WIf7vck=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-Ns1ID_P7MOmUaoyoTl7h8g-1; Wed, 20 Nov 2024 09:52:40 -0500
X-MC-Unique: Ns1ID_P7MOmUaoyoTl7h8g-1
X-Mimecast-MFC-AGG-ID: Ns1ID_P7MOmUaoyoTl7h8g
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a768b62268so38136345ab.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 06:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732114359; x=1732719159;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1qL9st3Em/o0uzp1J/08ioRXilfsvjPzqscn6722CoY=;
        b=YUfTnv2FlQVUW4BRThdHgmgGtuMhBvk847udoLsa+Jef6MwCMZOOqCF4UQayU27Lwt
         jTeZRbV1yRGxR6qwEhDlbCMLI5Dbrf1WByGNKUSuFAtzRWkElebqXSZ+c4S1w2t1zUWG
         T3/7Sp1A5jIru1bkUSmpWSRxlnLvTW8aKGPN6h843rZRm55CdV3hdqgiark6CScGL954
         j0tmbDybH7wHhFpiFTkgGdQkfqpoeGHk6NdyuO/BFkxs5ZZb04AXof3FT7P6ic3++9iP
         VXXftFPs7TXd1aNx84uQphMdM7sMMGVi2W6JJNqHaKe/7gCzJQzN9+t3fZBs/zf8htR4
         aE3A==
X-Gm-Message-State: AOJu0YykgPpIBom4maDh1ZFsPHKwPrA3rVwcdonIFoF7bN5/zuFJX6gX
	zUe2U3bk1DSJaPwbvwsrGK3GSaZuDsZZZTlk9MwUVB1dj4AuywM9Ih5ZfX3NywSBGszO9PF9w7W
	auTcKpmD45e5vwWDXY+4Ex7bkpKUOGTwLM/bsS318/vWuhqg6iWjBWg==
X-Received: by 2002:a05:6e02:440f:10b0:3a7:8720:9e9e with SMTP id e9e14a558f8ab-3a78720a046mr19299875ab.2.1732114359658;
        Wed, 20 Nov 2024 06:52:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ52VRVgCzVkuEffiZjEVIizQx6hR1OkKvnv5NNB3HlM4DVmBCxX8KF+jG65WNFTUnYVAQbQ==
X-Received: by 2002:a05:6e02:440f:10b0:3a7:8720:9e9e with SMTP id e9e14a558f8ab-3a78720a046mr19299725ab.2.1732114359385;
        Wed, 20 Nov 2024 06:52:39 -0800 (PST)
Received: from [10.0.0.71] ([65.128.99.169])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a748134d0csm32051885ab.73.2024.11.20.06.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 06:52:39 -0800 (PST)
Message-ID: <ee341ea4-904c-4885-bf8d-8111f9e416b5@redhat.com>
Date: Wed, 20 Nov 2024 08:52:38 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "f2fs: remove unreachable lazytime mount option
 parsing"
From: Eric Sandeen <sandeen@redhat.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
 <ZzPLELITeOeBsYdi@google.com>
 <493ce255-efcd-48af-ad7f-6e421cc04f1c@redhat.com>
Content-Language: en-US
In-Reply-To: <493ce255-efcd-48af-ad7f-6e421cc04f1c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 8:27 AM, Eric Sandeen wrote:
> On 11/12/24 3:39 PM, Jaegeuk Kim wrote:
>> Hi Eric,
>>
>> Could you please check this revert as it breaks the mount()?
>> It seems F2FS needs to implement new mount support.
>>
>> Thanks,
> 
> I'm sorry, I missed this email. I will look into it more today.

Ok, I see that I had not considered a direct mount call passing
the lazytime option strings. :(

Using mount(8), "lazytime" is never passed as an option all the way to f2fs,
nor is "nolazytime" -

# mount -o loop,nolazytime f2fsfile.img mnt
# mount | grep lazytime
/root/f2fs-test/f2fsfile.img on /root/f2fs-test/mnt type f2fs (rw,relatime,lazytime,seclabel,background_gc=on,nogc_merge,discard,discard_unit=block,user_xattr,inline_xattr,acl,inline_data,inline_dentry,flush_merge,barrier,extent_cache,mode=adaptive,active_logs=6,alloc_mode=reuse,checkpoint_merge,fsync_mode=posix,memory=normal,errors=continue)

(note that lazytime is still set despite -o nolazytime)

when mount(8) is using the new mount API, it does do fsconfig for (no)lazytime:

fsconfig(3, FSCONFIG_SET_FLAG, "nolazytime", NULL, 0) = 0

but that is consumed by the VFS and never sent into f2fs for parsing.

And because default_options() does:

sbi->sb->s_flags |= SB_LAZYTIME;

by default, it overrides the "nolazytime" that the vfs had previously handled.

I'm fairly sure that when mount(8) was using the old mount API (long ago) it also
did not send in the lazytime option string - it sent it as a flag instead.

However - a direct call to mount(2) /will/ pass those options all the way
to f2fs, and parse_options() does need to handle them there or it will be rejected
as an invalid option.

(Note that f2fs is the only filesystem that attempts to handle lazytime within
the filesystem itself):

[linux]# grep -r \"lazytime\" fs/*/
fs/f2fs/super.c:	{Opt_lazytime, "lazytime"},
[linux]#

I'm not entirely sure how to untangle all this, but regressions are not acceptable,
so please revert my commit for now.

Thanks,
-Eric


> As for f2fs new mount API support, I have been struggling with it for a
> long time, f2fs has been uniquely complex. The assumption that the superblock
> and on-disk features are known at option parsing time makes it much more
> difficult than most other filesystems.
> 
> But if there's a problem/regression with this commit, I have no objection to
> reverting the commit for now, and I'm sorry for the error.
> 
> -Eric
> 
>> On 11/12, Jaegeuk Kim wrote:
>>> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
>>>
>>> The above commit broke the lazytime mount, given
>>>
>>> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
>>>
>>> CC: stable@vger.kernel.org # 6.11+
>>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/super.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index 49519439b770..35c4394e4fc6 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -150,6 +150,8 @@ enum {
>>>  	Opt_mode,
>>>  	Opt_fault_injection,
>>>  	Opt_fault_type,
>>> +	Opt_lazytime,
>>> +	Opt_nolazytime,
>>>  	Opt_quota,
>>>  	Opt_noquota,
>>>  	Opt_usrquota,
>>> @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
>>>  	{Opt_mode, "mode=%s"},
>>>  	{Opt_fault_injection, "fault_injection=%u"},
>>>  	{Opt_fault_type, "fault_type=%u"},
>>> +	{Opt_lazytime, "lazytime"},
>>> +	{Opt_nolazytime, "nolazytime"},
>>>  	{Opt_quota, "quota"},
>>>  	{Opt_noquota, "noquota"},
>>>  	{Opt_usrquota, "usrquota"},
>>> @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>>  			f2fs_info(sbi, "fault_type options not supported");
>>>  			break;
>>>  #endif
>>> +		case Opt_lazytime:
>>> +			sb->s_flags |= SB_LAZYTIME;
>>> +			break;
>>> +		case Opt_nolazytime:
>>> +			sb->s_flags &= ~SB_LAZYTIME;
>>> +			break;
>>>  #ifdef CONFIG_QUOTA
>>>  		case Opt_quota:
>>>  		case Opt_usrquota:
>>> -- 
>>> 2.47.0.277.g8800431eea-goog
>>
> 


