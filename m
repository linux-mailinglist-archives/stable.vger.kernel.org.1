Return-Path: <stable+bounces-192366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02655C30BE6
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 12:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E234E9A4F
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 11:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BDE2DEA8C;
	Tue,  4 Nov 2025 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPdGemG0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001922E92A2
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255936; cv=none; b=Lc5JvuZHVyXQFzHgQ94HSb59dY8KLyEx7aYib7U84iI+LVza8LbvBfv/3lQ0sFmC01j1GaWINDPbonvYiSIKEgDo1UMtO0mxALA8vkBoy5+PIsKtNPCdzelaKVMCpNSYoMEX2h4bB0LZ3DkMYzhMXrXFBW3oaeXaaPo1LGpXzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255936; c=relaxed/simple;
	bh=Sw7bSqlGqr5IT9Xat5i0E71Exlf9sKUY61iDbp4a4t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2iPavC3hlrT+u0lYFSGZ6fhaqeJ/rTy2QYhb6vOOzBUCWZAJ/0KzGq9O9h7nFweTSYdpZc7l0xqgCxTSvGbc2KGbcpfQ2B8BvN+aLvQh5ESKqcJTDFgL0kgs32rY9nQUur0JRpk+syZdcBDVeD2agb3U/TgnBAy562lRlxjKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPdGemG0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so3507458a12.0
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 03:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762255934; x=1762860734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aoSxDhxS90f6BeCfm1xZZ+x6pE+INoKbsN0wsldLLGc=;
        b=kPdGemG0DCN+yk6LnPqF6SDXZwGjacksJbxEPAQ6EyolxXjOUZpfBzAn/Pl7k+Q4TT
         jKVEBkLxw0PAc81bkRAnFi7ee4QAsf067QCz8f4AcbEorBk2zLOwDQS/8dwQU0Geg6pr
         ZjL74Jy2o36rugOgpMQCs06r3+pDmoD0haJCSdRVtFNQnJgwSWivGxp/ojPt+9lo9+Po
         8HgJJPsnLuQVKAzQReWRwAWcOfa64v9ZQqY24Ow1BfmfHgW0kDuAyNbF+DpehP0D0Gda
         bArD5/LML6RZnxojefkB1q2i6FFih35tYVKmZYVfC6OOp5h4MgwabhkVxfOGHagJIMHS
         zUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255934; x=1762860734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aoSxDhxS90f6BeCfm1xZZ+x6pE+INoKbsN0wsldLLGc=;
        b=UeEUN6cUJ0MJFumLlPVYF4NfipfeVuWLEK0hbuMqoyZd3t00o0qdPfZnc0lpWZcOit
         5+lnqBC2RReQUZ8HEtrRyihZ1xs7s+AxsYs+vDSswYQcTTAkbYHJfJaXbn+u2n0h55bU
         CAiDaN70VI5sLTGG2zqfq7Xcrfker65B08ZNLOH0ht9/ygfysBOFNgFJYZq9FyJA4CWt
         XloV7m9oO/0fKl6xkC+wI5ydsIKT29NQnk8w0aWPUDZmv4TjHf8pXNXuFlJlBdhFB+Ou
         UGT5pdA6ds942hU4+S/StwT8KGrMNLNgPuVjBPHamYq8oeDLv5euR7tmXTW4nk3eCuus
         PqAw==
X-Forwarded-Encrypted: i=1; AJvYcCVOuH7p024xsd9Nx5HDLAt4YSajPLijdjRlgFMD/EDOR/CniRdjcLaS85tZ/9amzZ4bW5K0FsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEbtD01IESQOwm4ZL/wjhOFmRnOqem6UQUfYWaKIOixdpKH5r
	C2fBUJEkJ2S2AWB4zMvV8YYI8Kz4IdZhqOQk+NNz0WL853ETrX4NGPw4
X-Gm-Gg: ASbGncvfwlQHoQI8gqgjYKMU+orTJc24+dlj1O3TfK6GfjqK6hADBelqvixoYPxjyHs
	6msAGdpMYoL+KNZto5OoFhlBfelLLHxz3gVXHBEe8dNd6InccL7aSM+scju1lK0mVzJweAja+b2
	bZq0ee4J5NTcfyVI7eTNwp9Z1voXQ/w5AqNRmY8Piicb3XB9GlREEq6Os2CrJd0ytv/Iq73nJ2n
	4rVO+x1vSs3JZyqyYhI+r0ghBiyohGIBtX5Jx8xL5GQbKfLXnOBpUADfaa7Za3PP582rVDJ8nLL
	zVm2KDzeGiN8k7Eb9arkfYEPcUT/jeGWqLf8Yjklm0zwscLUH5aDBH426jKlQsXaPC0Clp1ddh9
	kJc0uEGhMeskldxsmC+cXCY+PNMKA7iBxcHfEZDXHSSjaFR1fUUuqUi0AeWskX4WuV6os70lB2C
	NMxKFJYxXL2pY9MEzACzY=
X-Google-Smtp-Source: AGHT+IFQi4sy7Pt+iNRc3yBEyf08yF9LpgtHzOpvhx7vFHjqpeB38ssLGuLoFfNxgUkcZVwLEr9mCA==
X-Received: by 2002:a05:6300:8a03:b0:34e:865e:8a65 with SMTP id adf61e73a8af0-34e866de6cbmr2005737637.52.1762255934090;
        Tue, 04 Nov 2025 03:32:14 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6919401sm2618951b3a.65.2025.11.04.03.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:32:13 -0800 (PST)
Message-ID: <8031227a-8a27-4aa0-8ca2-c44f494e9ad2@gmail.com>
Date: Tue, 4 Nov 2025 19:32:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] isofs: check the return value of
 sb_min_blocksize() in isofs_fill_super
To: Christoph Hellwig <hch@infradead.org>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-4-yangyongpeng.storage@gmail.com>
 <aQndM_Bq1HPRNyds@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQndM_Bq1HPRNyds@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 19:02, Christoph Hellwig wrote:
> On Tue, Nov 04, 2025 at 12:47:21AM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> sb_min_blocksize() may return 0. Check its return value to avoid
>> opt->blocksize and sb->s_blocksize is 0.
>>
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: 1b17a46c9243e9 ("isofs: convert isofs to use the new mount API")
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>> ---
>>   fs/isofs/inode.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
>> index 6f0e6b19383c..ad3143d4066b 100644
>> --- a/fs/isofs/inode.c
>> +++ b/fs/isofs/inode.c
>> @@ -610,6 +610,11 @@ static int isofs_fill_super(struct super_block *s, struct fs_context *fc)
>>   		goto out_freesbi;
>>   	}
>>   	opt->blocksize = sb_min_blocksize(s, opt->blocksize);
>> +	if (!opt->blocksize) {
>> +		printk(KERN_ERR
> 
> This should probably use pr_err instead.
> 

Thanks for the review. The other functions in fs/isofs/inode.c use 
"printk(KERN_ERR|KERN_DEBUG|KERN_WARNING ...)", so I used 
"printk(KERN_ERR ...)" for consistency.

Yongpeng,

