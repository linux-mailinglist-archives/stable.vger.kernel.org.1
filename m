Return-Path: <stable+bounces-93892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D29D1E0A
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 03:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47F51F22119
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFC21369BC;
	Tue, 19 Nov 2024 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeGKogOT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CFFC2C9;
	Tue, 19 Nov 2024 02:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982734; cv=none; b=S1SoyNXOErffL7TZOV1jhrlJ/MGzQUjXnxd5EsPnXNgCyoWYNQpbFmVyc1P+VGiBzW4q0S0TGFeKi8dwn5wW47WkaU4WNVhUq0VqccVmaTy59CaGF/xqzmTqmX1YoXzdczZIUWg5X6EZYWsvJeUfSm8tDOonyeEbax4z3VqTRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982734; c=relaxed/simple;
	bh=v5VMew2qGtig/6ECVnvo9mQpQhRggvGkbsg6KajwpFs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OdWjC0Zu+bAvPYo3FwHFUpDL7uexEmRuhGHPIWRtE7dfWwckNpqtGVnwzo03DwYeCD3CzHZjEMoYEYTHSnXOUkltRYezM1W7mDyf7EzuN5wp1mA0UnP6h5snsHk1JWj15b4tAh3bpKU3CGipcZ1YV41Drc3WFtimwRhIktnhvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeGKogOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78951C4CECC;
	Tue, 19 Nov 2024 02:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731982734;
	bh=v5VMew2qGtig/6ECVnvo9mQpQhRggvGkbsg6KajwpFs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=CeGKogOTaUYoeWfg7QGvH0GBbkFufN7EfenGNl83dus5KO4aauIJAnNzRNILSZwKH
	 Hzljl4Lu21lNjy6ujgJEbWrWJLDXlkK5B9CEvd6mYZOwBRybyUffCZn8gf6KQJL42C
	 R+zKId5UlnzTFCZoNkl/c8LZa9tasYMpeaTlbtNflzj+j/JevflOIaf2Wzb5Kjvi15
	 NltG6VXTLF98Szz1XefbYTmHe/HDiXTvmeuWcZQEDQrJ66XfYiXHl/ZYtGJhRGCdl3
	 gEFoKtl7LcDyAyAtqIBioC7sO9SZxvw+Ds7s4Vg3TAlREJc0nGvq71tmMjHwNhkvHg
	 JQJjYVqAGer1g==
Message-ID: <2d26eeee-01f7-445b-a1d2-bc2de65b5599@kernel.org>
Date: Tue, 19 Nov 2024 10:18:50 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daniel Rosenberg <drosen@google.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: remove unreachable lazytime
 mount option parsing"
To: Jaegeuk Kim <jaegeuk@kernel.org>, Eric Sandeen <sandeen@redhat.com>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
 <ZzPLELITeOeBsYdi@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZzPLELITeOeBsYdi@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/13 5:39, Jaegeuk Kim via Linux-f2fs-devel wrote:
> Hi Eric,
> 
> Could you please check this revert as it breaks the mount()?
> It seems F2FS needs to implement new mount support.

Hi all,

Actually, if we want to enable lazytime option, we can use mount
syscall as:

mount("/dev/vdb", "/mnt/test", "f2fs", MS_LAZYTIME, NULL);

or use shell script as:

mount -t f2fs -o lazytime /dev/vdb /mnt/test

IIUC, the reason why mount command can handle lazytime is, after
8c7f073aaeaa ("libmount: add support for MS_LAZYTIME"), mount command
supports to map "lazytime" to MS_LAZYTIME, and use MS_LAZYTIME in
parameter @mountflags of mount(2).

So, it looks we have alternative way to enable/disable lazytime feature
after removing Opt_{no,}lazytime parsing in f2fs, do we really need this
revert patch?

Thanks,

> 
> Thanks,
> 
> On 11/12, Jaegeuk Kim wrote:
>> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
>>
>> The above commit broke the lazytime mount, given
>>
>> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
>>
>> CC: stable@vger.kernel.org # 6.11+
>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>   fs/f2fs/super.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index 49519439b770..35c4394e4fc6 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -150,6 +150,8 @@ enum {
>>   	Opt_mode,
>>   	Opt_fault_injection,
>>   	Opt_fault_type,
>> +	Opt_lazytime,
>> +	Opt_nolazytime,
>>   	Opt_quota,
>>   	Opt_noquota,
>>   	Opt_usrquota,
>> @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
>>   	{Opt_mode, "mode=%s"},
>>   	{Opt_fault_injection, "fault_injection=%u"},
>>   	{Opt_fault_type, "fault_type=%u"},
>> +	{Opt_lazytime, "lazytime"},
>> +	{Opt_nolazytime, "nolazytime"},
>>   	{Opt_quota, "quota"},
>>   	{Opt_noquota, "noquota"},
>>   	{Opt_usrquota, "usrquota"},
>> @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>>   			f2fs_info(sbi, "fault_type options not supported");
>>   			break;
>>   #endif
>> +		case Opt_lazytime:
>> +			sb->s_flags |= SB_LAZYTIME;
>> +			break;
>> +		case Opt_nolazytime:
>> +			sb->s_flags &= ~SB_LAZYTIME;
>> +			break;
>>   #ifdef CONFIG_QUOTA
>>   		case Opt_quota:
>>   		case Opt_usrquota:
>> -- 
>> 2.47.0.277.g8800431eea-goog
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


