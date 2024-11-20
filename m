Return-Path: <stable+bounces-94086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767869D3253
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 03:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB2528423B
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 02:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85D04D8CE;
	Wed, 20 Nov 2024 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A57xcPX9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A009E41C62;
	Wed, 20 Nov 2024 02:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732071471; cv=none; b=FRYoQzB6+nvm0lr/ZRQywUblyNJvg0KfXuXCTUuTnM55O7P/hvW+FILicH9CO+eBU3DY+YfRpj584D0/gNNaMJQF9sBF+l5to806b9cHfAlbCZgvIoZCave8XIMoEkiqQ1dHJQg9X0alL2P1q0XP5WcImdR7Jphw0Ld93YbK2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732071471; c=relaxed/simple;
	bh=Aw7IdFuEXLbMBlkSZdde3kG/DSC1Uw8cU93GCXPXfHk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cpAV1u6Z7edx2TiNKPV0R5UhnuXj/jeyLtxDgZZsVzwglGhPv1wcOhKRdhJJxe/vmbvVBZ3kRHWDcb1A7deL6rVXbGTP/n63U4FIKvXbQ7w8picmOW7cH73jx6mJIC7F5GvIrq6t2/vWiqmIsD46sdERE7kN2ehVYby4MgGkL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A57xcPX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC20AC4CECF;
	Wed, 20 Nov 2024 02:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732071471;
	bh=Aw7IdFuEXLbMBlkSZdde3kG/DSC1Uw8cU93GCXPXfHk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=A57xcPX9gXaqjn05XIM4WCCKqcjtCldfwyCIwHK+xgJxoppX/tQR+HBnHHtzaR61N
	 i6QiHuP+5ZvvYnePtA8f9TEcnd1zwnAKMN5kaLaq5WTTCshOlAY5sWFGM6hcNd7OxT
	 33aFqJZ3px6iaeOON1APHXPlBX+8RlhUPbx+FMtMDmWIF4Ld80iuGEpEeq1rmnS4+P
	 0wO81ajmDp9gNRis4uinLF1ZRZwyMQNbeq30Cv1PUJAz3kv9PlXPfpcZqrw7VLFYD0
	 l/pD14XNcGTGv9NE8orh7ihiQeQWI7j4U/XoglqNjLvOMx9iI30DbuO5lA91VU/NXA
	 5QCrUmgOUj1ZA==
Message-ID: <35c20e47-9124-45df-8067-67c5ef29600e@kernel.org>
Date: Wed, 20 Nov 2024 10:57:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Eric Sandeen <sandeen@redhat.com>,
 Daniel Rosenberg <drosen@google.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: remove unreachable lazytime
 mount option parsing"
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
 <ZzPLELITeOeBsYdi@google.com>
 <2d26eeee-01f7-445b-a1d2-bc2de65b5599@kernel.org>
 <Zzz5ocjKK_naOnMq@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zzz5ocjKK_naOnMq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/20 4:48, Jaegeuk Kim wrote:
> On 11/19, Chao Yu wrote:
>> On 2024/11/13 5:39, Jaegeuk Kim via Linux-f2fs-devel wrote:
>>> Hi Eric,
>>>
>>> Could you please check this revert as it breaks the mount()?
>>> It seems F2FS needs to implement new mount support.
>>
>> Hi all,
>>
>> Actually, if we want to enable lazytime option, we can use mount
>> syscall as:
>>
>> mount("/dev/vdb", "/mnt/test", "f2fs", MS_LAZYTIME, NULL);
>>
>> or use shell script as:
>>
>> mount -t f2fs -o lazytime /dev/vdb /mnt/test
>>
>> IIUC, the reason why mount command can handle lazytime is, after
>> 8c7f073aaeaa ("libmount: add support for MS_LAZYTIME"), mount command
>> supports to map "lazytime" to MS_LAZYTIME, and use MS_LAZYTIME in
>> parameter @mountflags of mount(2).
>>
>> So, it looks we have alternative way to enable/disable lazytime feature
>> after removing Opt_{no,}lazytime parsing in f2fs, do we really need this
>> revert patch?
> 
> This is a regression of the below command. I don't think offering others are
> feasible.
> 
> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");

Alright, there are other options were removed along w/ removal of
related feature. e.g.

1. io_bits=%u by commit 87161a2b0aed ("f2fs: deprecate io_bits")
2. whint_mode=%s by commit 930e2607638d ("f2fs: remove obsolete whint_mode")

Do we need to add these options handling back, and print "xxx options were
deprecated" as we did in ("f2fs: kill heap-based allocation"), in order to
avoid mount(......, "io_bits=%u" or "whint_mode=%s") command regression?

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 867b147eb957..329f317e6f09 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -733,10 +733,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
  			clear_opt(sbi, DISCARD);
  			break;
  		case Opt_noheap:
-			set_opt(sbi, NOHEAP);
-			break;
  		case Opt_heap:
-			clear_opt(sbi, NOHEAP);
+			f2fs_warn(sbi, "heap/no_heap options were deprecated");
  			break;

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Thanks,
>>>
>>> On 11/12, Jaegeuk Kim wrote:
>>>> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
>>>>
>>>> The above commit broke the lazytime mount, given
>>>>
>>>> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
>>>>
>>>> CC: stable@vger.kernel.org # 6.11+
>>>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> ---
>>>>    fs/f2fs/super.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>>> index 49519439b770..35c4394e4fc6 100644
>>>> --- a/fs/f2fs/super.c
>>>> +++ b/fs/f2fs/super.c
>>>> @@ -150,6 +150,8 @@ enum {
>>>>    	Opt_mode,
>>>>    	Opt_fault_injection,
>>>>    	Opt_fault_type,
>>>> +	Opt_lazytime,
>>>> +	Opt_nolazytime,
>>>>    	Opt_quota,
>>>>    	Opt_noquota,
>>>>    	Opt_usrquota,
>>>> @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
>>>>    	{Opt_mode, "mode=%s"},
>>>>    	{Opt_fault_injection, "fault_injection=%u"},
>>>>    	{Opt_fault_type, "fault_type=%u"},
>>>> +	{Opt_lazytime, "lazytime"},
>>>> +	{Opt_nolazytime, "nolazytime"},
>>>>    	{Opt_quota, "quota"},
>>>>    	{Opt_noquota, "noquota"},
>>>>    	{Opt_usrquota, "usrquota"},
>>>> @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>>>    			f2fs_info(sbi, "fault_type options not supported");
>>>>    			break;
>>>>    #endif
>>>> +		case Opt_lazytime:
>>>> +			sb->s_flags |= SB_LAZYTIME;
>>>> +			break;
>>>> +		case Opt_nolazytime:
>>>> +			sb->s_flags &= ~SB_LAZYTIME;
>>>> +			break;
>>>>    #ifdef CONFIG_QUOTA
>>>>    		case Opt_quota:
>>>>    		case Opt_usrquota:
>>>> -- 
>>>> 2.47.0.277.g8800431eea-goog
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


