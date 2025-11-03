Return-Path: <stable+bounces-192207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C55C2C3DB
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 14:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EADF3B0725
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EF530C613;
	Mon,  3 Nov 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTPQC/TW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D53A26CE33
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 13:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177245; cv=none; b=WRtkIlFq+zNwA68JTmwUgyp9f1FOKMR2W4GF5bRM0eaEjxpTfSLjEX9gkhi2RYwLvTqfCrLndouFsTU3Qvxuip6IAFwn+r/XL7Ci6+ddF1iC1JTK2/zBLT2mPwFKgh4QkB33kJB4v3nz2c0nKDoB810R/u4QXnSj8xjTSnxfNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177245; c=relaxed/simple;
	bh=JZ0P1jUJT/JHdrkC2pQPX3089iJixp+OjT43MwzgNR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqIQY6uDdGRf+6pdZS296lwCZqknDVh+9JeGP2jAHYJzXfwA00xpJ/ojY1ZCgbykVMepx4aNStwZMOioQIvfcbvhTOeMbGti3gmqosDFOvKRhR546a+xwlSMBGpTB1T60N57uFc0wx1j6gLaSQSDlYhzi1vAWNqkRGFp5spFTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTPQC/TW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-340564186e0so3763573a91.0
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 05:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762177242; x=1762782042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+8IwqJtA/22JVDtVDWFjIJd2N2jNDTeHgnje61NBmJ8=;
        b=mTPQC/TW205WGM22q1YNn+ndPJrOc6Yjahm5rTeZ0CLzA0C3ZORehURZEkV/qyA4jx
         ML8RGQqdmf68ZoDpjlBVJCYZndBFghHjftPIIGsVBVIhFEPiqBldDefn56V/2kPo4lx6
         dyy3h1DmvC7TBbOYOEBsvwfGS0bfg7kYT8DL1LP/LtICizpMdmV7MAPWJ/7GzcBjgjXl
         og21ElomjErRG678nAYWFEEeWLSCD5FMX/IN7v2wZA+m+2fEDzfIql+2hh07LcqPZclH
         V1tpcDnYGkijZIllr90/FQ5OPQS9iujhJ0+Hm963Hftbsv1loMFjknr1HaPeBTbtIJI5
         ZGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762177242; x=1762782042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8IwqJtA/22JVDtVDWFjIJd2N2jNDTeHgnje61NBmJ8=;
        b=PqaycJd2+Rz/uF9xETOUkppOvyTA8T6rXadhssBdMMo8pJ8xQqGSepodZEiBGzCDWM
         LXiiDPa2rH84mQOfl/xLLmWOqLwlmu4/XmbsUj/7J3gSTVAccgixrtZTmsxPJno7Y7ap
         KwLSgfcnJzUEelZOWY2S20eZ/z7HgXlmLMcSvZd4+fFQgQgzEzFLjlZeuhSkDfugADrK
         eOYAPbNpaiVeAkhlrEM/h9AB9HAkZlSb+E96lpopN540dXr7J0ktxEPE1HRfRkLdpgMF
         U3zhqoaVxMQFwJYR+9KqRjomyRtd5L+kWXrQHBcn4SM7s3iqhYo4mmCZ8sXbmfYbjJE+
         vAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEz0tF+kojNx8tKlPTTndty8U9XHgiMgH9rtAClJ8aPrRJ0m98ff5aDAuUESD7zVqZCdo2Sdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqU/7zPHNWwW7ngVvyEAoIYdYpRyRhyaGRMAC1/7B/OKtEcplA
	NrMA8nAuHgbpBWByy7Jiyx+q+6sZG6RRZUxGkxdD5Y9PZsxOlNtC+tyF
X-Gm-Gg: ASbGncuQ7AV4o9pF+qr+qSGS+DssdwoJAOcQEsWzoXVb8ro7ht1IkNDbYAqz+emm7/p
	7EH64k0mj4UuXqLAt/8WsDYy8sWei97sJLbNMtjbWETL6jNvoG6mNbSUwl7GAU6wmkhZF6ZDbuF
	1g126/KR7hJ6XYcSR11hgtjKdH8zqDF2ISk1J9IlMyLDVcwHH8wmZ+9cl3SPR/q5FyRJ/KdXuF0
	wRwCdFVkKf1Juwj+g+hbXxj6q+Dsye4Ay69c/U8460rE1zb1D3G9n8YduhZL2j2cB1iDoL6TeMT
	vEAi7lPjY3Yg/BcFM6CCaaaW+HOwC0Tz1ACvsQ+qYF1JX3t2gZmFsJDgE87RaEDyjatwG4l74+D
	W2Ej751O4a16DfBynGsVGwQSGMWRvH2RmIHAgmWSgSq3e8C4dJprjhMB/jCOvYg349DYDtz9vLW
	Rf4TU2F+X0GYIkG1mln/H+6ZSLqXPjYfh3CVHiT8AaXKhLgBX5pcLJ9O4IXrk5qq3wqmOuWSQu
X-Google-Smtp-Source: AGHT+IGpJsA054j4ViTtI38jqwpBxx4LnXSeC5cZfa9rXdhBelszsgUGjl8r93/Fsuxn/l+FZEUG2g==
X-Received: by 2002:a17:90b:2f48:b0:330:bca5:13d9 with SMTP id 98e67ed59e1d1-3408309ae43mr14629306a91.32.1762177242379;
        Mon, 03 Nov 2025 05:40:42 -0800 (PST)
Received: from ?IPV6:2409:8a00:79b4:1a90:5d7b:82d2:2626:164a? ([2409:8a00:79b4:1a90:5d7b:82d2:2626:164a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ef4c263sm5374195a91.3.2025.11.03.05.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 05:40:42 -0800 (PST)
Message-ID: <07ab7f80-889e-4a28-adf9-12fc038bdc27@gmail.com>
Date: Mon, 3 Nov 2025 21:40:18 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fix missing sb_min_blocksize() return value checks in
 some filesystems
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, Jan Kara <jack@suse.cz>,
 Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251102163835.6533-2-yangyongpeng.storage@gmail.com>
 <87cy60idr2.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <87cy60idr2.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/2025 12:46 AM, OGAWA Hirofumi wrote:
> Yongpeng Yang <yangyongpeng.storage@gmail.com> writes:
> 
>> diff --git a/fs/fat/inode.c b/fs/fat/inode.c
>> index 9648ed097816..d22eec4f17b2 100644
>> --- a/fs/fat/inode.c
>> +++ b/fs/fat/inode.c
>> @@ -1535,7 +1535,7 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>>   		   void (*setup)(struct super_block *))
>>   {
>>   	struct fat_mount_options *opts = fc->fs_private;
>> -	int silent = fc->sb_flags & SB_SILENT;
>> +	int silent = fc->sb_flags & SB_SILENT, blocksize;
>>   	struct inode *root_inode = NULL, *fat_inode = NULL;
>>   	struct inode *fsinfo_inode = NULL;
>>   	struct buffer_head *bh;
>> @@ -1595,8 +1595,13 @@ int fat_fill_super(struct super_block *sb, struct fs_context *fc,
>>   
>>   	setup(sb); /* flavour-specific stuff that needs options */
>>   
>> +	error = -EINVAL;
>> +	blocksize = sb_min_blocksize(sb, 512);
>> +	if (!blocksize) {
> 
> 	if (!sb_min_blocksize(sb, 512)) {
> 
> Looks like this one is enough?
> 

Thanks for the review. Yes, blocksize doesn't serve any other purpose. 
I'll remove it in v2.

Yongpeng,

>> +		fat_msg(sb, KERN_ERR, "unable to set blocksize");
>> +		goto out_fail;
>> +	}


