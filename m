Return-Path: <stable+bounces-198060-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0F4C9AD0E
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 10:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F6F94E24C4
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23730B51F;
	Tue,  2 Dec 2025 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVx8dxys"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D0429BDB0
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667004; cv=none; b=aOIJNzXk6nKDpRL9EtJpQjen9AlAFTUI4v7dqukmOz48ZFbYFNROzxpPThVbMboVjfDmT7VfWuYRA/mAZMCmNCLtqN5nsBbEMBfp+jJTgdMCIX9n5vqilCYzWB4Y1Ewfm3HRDaa1Y0q33AEEaZe3qHQSI4fnEtLVjq+0tiLNjJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667004; c=relaxed/simple;
	bh=jG84e4jf1/Y6KoSuOJESompZU0Ht8HkOAu+fl79mqOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9xNHe89uNSmNncHRUhakx7aKNi23x7YC/v8qCVS1pr9lN6a3X2N/e7ACzQ++vBMNW6wyEr0sa6qBbg7t8h+B191r6UetHqcJdozAFuIEQPlohv+1Rw1jTXqL9ABZJBVteRvgob5UXbqSKenHqp2V/gdfMMYR7uJSDMTCA2SIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVx8dxys; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6415fc4093bso938522a12.1
        for <stable@vger.kernel.org>; Tue, 02 Dec 2025 01:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764667000; x=1765271800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOeyoFeE9ptuDprFUEesktlVJrLNkcXMrb/XLaSLirY=;
        b=eVx8dxysV722Vhz1iow/DluKDGeix17tr1twDhhw9qNEdp8ApKfgUqSZM3URhmZAi3
         eRxNq1oR/aEqdf/4dBEwTEtH6Og3gHLhFuga4XwDLa6GVR3RAkOPhA/pHJP6vsIG+Lsj
         cqv4wQBgW4GD0KyPrd97ekMeAhyHJHuueRKVjOgAKqQ9nzf8+38chWDz6UgTt7oqGFzt
         Yu/37oYGO+qTuz51V3S36VVdjcc1UdLL/6Qa+2MsEODV4tsxCWWv0BcZjixmjwLBzI7y
         nAT/Ryzy/0C8bSth8S9Yt2/gSkGdpyelASOxepKeLQNv8smWcZFRY4Rm4wnuMW0BKAEQ
         TCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764667000; x=1765271800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOeyoFeE9ptuDprFUEesktlVJrLNkcXMrb/XLaSLirY=;
        b=p8V8gkRWVgpQhoZY5uOui0DPnwt3RODv/MsJzCyUzrADLEtK4MaTYLaIJEsCMCf4Ef
         zxxRTvSbIVuezHgy07jOHuzqmrCcxdeSHKlcfesQG4oaUjgf5A1IKepbdCCVnJiyskUd
         zIKWsOU6W+73ruvk980S4dtRFHQwysXMlpvdd+2ejjqFRdtTB3gbfWO+0078Ey3kHsO3
         4b6wjTNS0jK/QabKcgHrAReDqEc2N4jvSHI8y5m+1SBvnG6dhuHYoKHd6QwSPBaKo1vC
         gKmRsyDoSCThelzqTCgEd552DQLFaQpNYZshTXXimTKX6vIAp3paebaSaArMFAQh6xBP
         KX2w==
X-Forwarded-Encrypted: i=1; AJvYcCVg6Kf3Zb1fvxHLDw09uyNgfsPVEkYx59kIVnACsWSbDI/9gfcpphi/Zcm+wpZf3ZUjduWUjZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylz41CnfriMwJ8JknO8je1JuSSnjHHG2+8vzw3QSHwgGC+6RnS
	7r5XQpnxRTghlFRa5ryqg7vMMPLFkrI+PCB4+423bnVu76NYBXUNTzC4
X-Gm-Gg: ASbGncvvm1zlt9Mg/zITzOUI2zgHPpNDgykD6WixS2G35bYMgxAo0Fv/FLjNfGTSW7e
	JcvxI6wyFxFvpAC+DBbSwrcBEN1BEFJSlOZ8w0WNCyqA63BfYWrwXI2eBhFSH+G5+K0ZsbkKPl2
	cPUH/PwVxm1IESfoXKHfjUDM55UpHLJf/71XHehK3NUVD8FMaQGgZdCGuHdUCM4YGW+KWsE4A0N
	q7hBr9GoV8aKdKdFlWhQvIYL3+nW4GgY8xGj2RxvBhCfxkiqPBIFlMLL4BpAeLjC/i/nNgtL1qh
	2IqQxwlW97XGRH8GpfM+/fdQfADLzQ3LVE3GH2fxWdkl3yJ5TqJwDLp6BJwF4jLdqE01D6Jp2IH
	gbQOEZBvnzQl9i7heoEZk7sKI012axqG9SSxibAQX8xkIg87tgyT8Yp//M0qr+Y/SeEW16CpWAk
	uiSq3dltBHmsO8Rw7YjQsvtXK1OIp47g==
X-Google-Smtp-Source: AGHT+IEUe65+h0njLaQw7LZAgYv9XS5wgeItFteBQfHReQmxiMj+syDNXX3N8J3uPp8A5wQTWy5Kow==
X-Received: by 2002:a05:6402:2755:b0:645:b2dc:9fd with SMTP id 4fb4d7f45d1cf-645b2dc0a91mr20550708a12.2.1764667000012;
        Tue, 02 Dec 2025 01:16:40 -0800 (PST)
Received: from [192.168.1.105] ([165.50.23.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a90e44sm14775151a12.14.2025.12.02.01.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 01:16:39 -0800 (PST)
Message-ID: <4047dad6-d7f8-4630-896a-68d4b224f6c6@gmail.com>
Date: Tue, 2 Dec 2025 11:16:34 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hfs: ensure sb->s_fs_info is always cleaned up
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
 "frank.li@vivo.com" <frank.li@vivo.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>, "jack@suse.cz" <jack@suse.cz>,
 "sandeen@redhat.com" <sandeen@redhat.com>
Cc: "khalid@kernel.org" <khalid@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "david.hunter.linux@gmail.com" <david.hunter.linux@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
 "syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com"
 <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
References: <20251201222843.82310-1-mehdi.benhadjkhelifa@gmail.com>
 <20251201222843.82310-2-mehdi.benhadjkhelifa@gmail.com>
 <4b620e91b43f86dceed88ed2f73b1ff1e72bff6c.camel@ibm.com>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <4b620e91b43f86dceed88ed2f73b1ff1e72bff6c.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/25 12:04 AM, Viacheslav Dubeyko wrote:
> On Mon, 2025-12-01 at 23:23 +0100, Mehdi Ben Hadj Khelifa wrote:
>> When hfs was converted to the new mount api a bug was introduced by
>> changing the allocation pattern of sb->s_fs_info. If setup_bdev_super()
>> fails after a new superblock has been allocated by sget_fc(), but before
>> hfs_fill_super() takes ownership of the filesystem-specific s_fs_info
>> data it was leaked.
>>
>> Fix this by freeing sb->s_fs_info in hfs_kill_super().
>>
>> Cc: stable@vger.kernel.org
>> Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
>> Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
>> Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>> ---
>>   fs/hfs/mdb.c   | 35 ++++++++++++++---------------------
>>   fs/hfs/super.c | 10 +++++++++-
>>   2 files changed, 23 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
>> index 53f3fae60217..f28cd24dee84 100644
>> --- a/fs/hfs/mdb.c
>> +++ b/fs/hfs/mdb.c
>> @@ -92,7 +92,7 @@ int hfs_mdb_get(struct super_block *sb)
>>   		/* See if this is an HFS filesystem */
>>   		bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
>>   		if (!bh)
>> -			goto out;
>> +			return -EIO;
> 
> Frankly speaking, I don't see the point to rework the hfs_mdb_get() method so
> intensively. We had pretty good pattern before:
> 
> int hfs_mdb_get(struct super_block *sb) {
>          if (something_happens)
>               goto out;
> 
>          if (something_happens_and_we_need_free_buffer)
>              goto out_bh;
> 
>   	return 0;
> 
> out_bh:
> 	brelse(bh);
> out:
> 	return -EIO;
>   }
> 
> The point here that we have error management logic in one place. Now you have
> spread this logic through the whole function. It makes function more difficult
> to manage and we can introduce new bugs. Could you please localize your change
> without reworking this pattern of error situation management? Also, it will make
> the patch more compact. Could you please rework the patch?
> 
This change in particular is made by christian. As he mentionned in one 
of his emails to my patches[1], his logic was that hfs_mdb_put() should 
only be called in fill_super() which cleans everything up and that the 
cleanup labels don't make sense here which is why he spread the logic of 
cleanup across the function. Maybe he can give us more input on this 
since it wasn't my code.

[1]:https://lore.kernel.org/all/20251119-delfin-bioladen-6bf291941d4f@brauner/
> Thanks,
> Slava.
Best Regards,
Mehdi Ben Hadj Khelifa
> 
>>   
>>   		if (mdb->drSigWord == cpu_to_be16(HFS_SUPER_MAGIC))
>>   			break;
>> @@ -102,13 +102,14 @@ int hfs_mdb_get(struct super_block *sb)
>>   		 * (should do this only for cdrom/loop though)
>>   		 */
>>   		if (hfs_part_find(sb, &part_start, &part_size))
>> -			goto out;
>> +			return -EIO;
>>   	}
>>   
>>   	HFS_SB(sb)->alloc_blksz = size = be32_to_cpu(mdb->drAlBlkSiz);
>>   	if (!size || (size & (HFS_SECTOR_SIZE - 1))) {
>>   		pr_err("bad allocation block size %d\n", size);
>> -		goto out_bh;
>> +		brelse(bh);
>> +		return -EIO;
>>   	}
>>   
>>   	size = min(HFS_SB(sb)->alloc_blksz, (u32)PAGE_SIZE);
>> @@ -125,14 +126,16 @@ int hfs_mdb_get(struct super_block *sb)
>>   	brelse(bh);
>>   	if (!sb_set_blocksize(sb, size)) {
>>   		pr_err("unable to set blocksize to %u\n", size);
>> -		goto out;
>> +		return -EIO;
>>   	}
>>   
>>   	bh = sb_bread512(sb, part_start + HFS_MDB_BLK, mdb);
>>   	if (!bh)
>> -		goto out;
>> -	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC))
>> -		goto out_bh;
>> +		return -EIO;
>> +	if (mdb->drSigWord != cpu_to_be16(HFS_SUPER_MAGIC)) {
>> +		brelse(bh);
>> +		return -EIO;
>> +	}
>>   
>>   	HFS_SB(sb)->mdb_bh = bh;
>>   	HFS_SB(sb)->mdb = mdb;
>> @@ -174,7 +177,7 @@ int hfs_mdb_get(struct super_block *sb)
>>   
>>   	HFS_SB(sb)->bitmap = kzalloc(8192, GFP_KERNEL);
>>   	if (!HFS_SB(sb)->bitmap)
>> -		goto out;
>> +		return -EIO;
>>   
>>   	/* read in the bitmap */
>>   	block = be16_to_cpu(mdb->drVBMSt) + part_start;
>> @@ -185,7 +188,7 @@ int hfs_mdb_get(struct super_block *sb)
>>   		bh = sb_bread(sb, off >> sb->s_blocksize_bits);
>>   		if (!bh) {
>>   			pr_err("unable to read volume bitmap\n");
>> -			goto out;
>> +			return -EIO;
>>   		}
>>   		off2 = off & (sb->s_blocksize - 1);
>>   		len = min((int)sb->s_blocksize - off2, size);
>> @@ -199,12 +202,12 @@ int hfs_mdb_get(struct super_block *sb)
>>   	HFS_SB(sb)->ext_tree = hfs_btree_open(sb, HFS_EXT_CNID, hfs_ext_keycmp);
>>   	if (!HFS_SB(sb)->ext_tree) {
>>   		pr_err("unable to open extent tree\n");
>> -		goto out;
>> +		return -EIO;
>>   	}
>>   	HFS_SB(sb)->cat_tree = hfs_btree_open(sb, HFS_CAT_CNID, hfs_cat_keycmp);
>>   	if (!HFS_SB(sb)->cat_tree) {
>>   		pr_err("unable to open catalog tree\n");
>> -		goto out;
>> +		return -EIO;
>>   	}
>>   
>>   	attrib = mdb->drAtrb;
>> @@ -229,12 +232,6 @@ int hfs_mdb_get(struct super_block *sb)
>>   	}
>>   
>>   	return 0;
>> -
>> -out_bh:
>> -	brelse(bh);
>> -out:
>> -	hfs_mdb_put(sb);
>> -	return -EIO;
>>   }
>>   
>>   /*
>> @@ -359,8 +356,6 @@ void hfs_mdb_close(struct super_block *sb)
>>    * Release the resources associated with the in-core MDB.  */
>>   void hfs_mdb_put(struct super_block *sb)
>>   {
>> -	if (!HFS_SB(sb))
>> -		return;
>>   	/* free the B-trees */
>>   	hfs_btree_close(HFS_SB(sb)->ext_tree);
>>   	hfs_btree_close(HFS_SB(sb)->cat_tree);
>> @@ -373,6 +368,4 @@ void hfs_mdb_put(struct super_block *sb)
>>   	unload_nls(HFS_SB(sb)->nls_disk);
>>   
>>   	kfree(HFS_SB(sb)->bitmap);
>> -	kfree(HFS_SB(sb));
>> -	sb->s_fs_info = NULL;
>>   }
>> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
>> index 47f50fa555a4..df289cbdd4e8 100644
>> --- a/fs/hfs/super.c
>> +++ b/fs/hfs/super.c
>> @@ -431,10 +431,18 @@ static int hfs_init_fs_context(struct fs_context *fc)
>>   	return 0;
>>   }
>>   
>> +static void hfs_kill_super(struct super_block *sb)
>> +{
>> +	struct hfs_sb_info *hsb = HFS_SB(sb);
>> +
>> +	kill_block_super(sb);
>> +	kfree(hsb);
>> +}
>> +
>>   static struct file_system_type hfs_fs_type = {
>>   	.owner		= THIS_MODULE,
>>   	.name		= "hfs",
>> -	.kill_sb	= kill_block_super,
>> +	.kill_sb	= hfs_kill_super,
>>   	.fs_flags	= FS_REQUIRES_DEV,
>>   	.init_fs_context = hfs_init_fs_context,
>>   };


