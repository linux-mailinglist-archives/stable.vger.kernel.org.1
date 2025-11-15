Return-Path: <stable+bounces-194839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA34C608EB
	for <lists+stable@lfdr.de>; Sat, 15 Nov 2025 18:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BD53B3D24
	for <lists+stable@lfdr.de>; Sat, 15 Nov 2025 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9EB262A6;
	Sat, 15 Nov 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxlJbrVM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC420E030
	for <stable@vger.kernel.org>; Sat, 15 Nov 2025 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763226180; cv=none; b=FjKwudIIahKgSQ3qAC3hoZbYtfLwOHY6JY39ZoLNsMojM7m2BCZQ/iCe1zI6L8DRq3xclLBCH3mt1s0tBpAZqyDE2zSHhJ1BjcMJYZeNVnrgfgwvGaJADiUZz225GKglNqG3vTvLqhupNO1YgTQ7odeX7bXK4GZZ8t6HckQ0KLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763226180; c=relaxed/simple;
	bh=Ynsp4AGIiFvIUjzx33S0RcH+iZzWSG7GvDrxPYpl5y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGC08MdzWIXMWW4XX890Fi8Hx6ndflD3f6AIueKMPRJ24RL5k0MdHGDcwLFRamEWnVBAoxKUasGNASp9J4YKH1qELA39mHyHJZACYQZnDsQkhOVDqzlQma67SA4ukM8tLqDFcR3APBM/R9jWDopXpAf1YI6nMvewEIEuxo7XaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxlJbrVM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775ae77516so32888995e9.1
        for <stable@vger.kernel.org>; Sat, 15 Nov 2025 09:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763226178; x=1763830978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhZf0daDzyc4x+cTxD8gsx/UNr12/kXrHW7QrRdshYk=;
        b=UxlJbrVMoJ7bnxVGwt8oiDKH6qqyQjMInsErS/GhB4nPtiODa8tfUKPgiFhp71B8BO
         40g/sbzfpIfFe07FXzjIfp8EmjzjoBOZ4VkKbzM7lkTqVJwCiYI7+1OVFOfLJVQz6i4K
         UEiOh46zFz9Fcp6Y8kM5600faujRYJwiXYuNaVEBOnQhEFpzPtXOWJ4i0KonEm6dyK7n
         LpJ8HIMDhi3FA+NcC0lfypmSVGY5vONUs5RAiONHmTiHmZPEiUM1J9IjLojtLjnbuR0r
         0ZhME8ekeafa/azI4xQwhX58uxfHeW8wqJcHqiSwvX4VPGxNvj1qHX5Nu06xS+J1aw4I
         uesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763226178; x=1763830978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fhZf0daDzyc4x+cTxD8gsx/UNr12/kXrHW7QrRdshYk=;
        b=eBHQ0PVE1uUG3LBIlbkgX6hLGAFjjIgWlqVryt4AbuKbKxX53Ghm56ZCqhPKfYCTBN
         w9uAEaYDrRt0R00kC9wJ146D0PQfRsTe/hJP0fufZIG99ZYLtXMzMv8uQILYRNjeZK8R
         1ab8YiT48RrnrXABQT4BE+Whn6s1m/rKYcCD7MB/GXK/BozTgK8tOmjpKt4HUkY0Gq1V
         GEX5/ZqJE/5acJxwImOguig4E+GnFJvVzv8l6VvbXjn4r+yLymKVWWMZtM34gmui9t1R
         H7W7ws/hJ5N0ve42bEahECYyOLRhhrgeuNHVyr8qfMaLp4uLVx/gkZ9/uhINE4EJ+yd0
         dM4w==
X-Forwarded-Encrypted: i=1; AJvYcCXbV1Y0HNBSW9n8nvEoY9bwh/H/Gbf2f3ewkGCLLhCUkee43hK9t1WtbxV5Cbz2hnStdr/L0EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNbHjk6OjagjXYKXbfKDFJT++tVX6/fpOmOspgUwYRdEoqxPn
	2nYys6CILghn3/ZGkZ6sigowrfh9X/NC6Hi/E9gaW49v2GbFK3R9fY8d
X-Gm-Gg: ASbGncvqCn8BNKcnVq6DLY8spnHplRK9UmJBukPet7j+A5k2dYAfsmcT1v2UoKEbI3b
	Zg9tMA37uUOm+1HHVeqd9zkcfzF4XmYKSX0GD0Qi38ceEOaQpnhKA9lPYqdBU/RXvLnJUVxo36g
	WybjecEsMn1Ge1OQK8n/qgkQeKDLPWsrhLxUVdtjgPF/zxBOFSzjKHDs1bcNdSqikP96lyOirIZ
	B4pDC8iVfQvtY5vgm52B7Ctpr+5cev7rPnbvW/qdH/o6LHG6KMrNCXt4yUHrF/B3TSD6LDG4mMw
	j9slzGwnQyiEf5OPELpYa3yUpOkCoCvl1atYiA8Fvu+cvW1Yxr0lrr/vzUH0WpvkjdhQeYvCVXj
	5VNhlT7TGDlZKR3mvnVOgTUZTs8+pNC7eDdczkSwRbY+95pEXssGP5zTpoWKs88TgjVHXVaOOC/
	BX0nuGN2QsSa7uz7nj6ICK/HTI6remxlEvwqtLw9datmA+n6bBCJvdDVq7woYmet8=
X-Google-Smtp-Source: AGHT+IGvA6Cf0hX6CHFmLOv2ERiNOSbof9VojTgyNbFZ08X3ubaL0BT4MHWHB1qRipjBox5egLNWRg==
X-Received: by 2002:a05:600c:4513:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-4778fe5de1amr68131925e9.11.1763226177303;
        Sat, 15 Nov 2025 09:02:57 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb34cc1sm71532425e9.3.2025.11.15.09.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 09:02:57 -0800 (PST)
Date: Sat, 15 Nov 2025 17:02:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Qianchang Zhao <pioooooooooip@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>,
 gregkh@linuxfoundation.org, linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zhitong Liu <liuzhitong1993@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] ksmbd: vfs_cache: avoid integer overflow in
 inode_hash()
Message-ID: <20251115170253.64ee8828@pumpkin>
In-Reply-To: <20251115144836.555128-1-pioooooooooip@gmail.com>
References: <CAKYAXd-_S184kK0NUyuCgOTvCvq382c3Fxt=ytes-ekydwGLuQ@mail.gmail.com>
	<20251115144836.555128-1-pioooooooooip@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Nov 2025 23:48:36 +0900
Qianchang Zhao <pioooooooooip@gmail.com> wrote:

> inode_hash() currently mixes a hash value with the super_block pointer
> using an unbounded multiplication:
> 
>     tmp = (hashval * (unsigned long)sb) ^
>           (GOLDEN_RATIO_PRIME + hashval) / L1_CACHE_BYTES;
> 
> On 64-bit kernels this multiplication can overflow and wrap in unsigned
> long arithmetic.

The same happens on 32bits.

> While this is not a memory-safety issue, it is an
> unbounded integer operation and weakens the mixing properties of the
> hash.

Are you sure, I'd have thought all the 'carry' operations in the multiply
would make it better.

> Replace the pointer*hash multiply with hash_long() over a mixed value
> (hashval ^ (unsigned long)sb) and keep the existing shift/mask. This
> removes the overflow source and reuses the standard hash helper already
> used in other kernel code.
> 
> This is an integer wraparound / robustness issue (CWE-190/CWE-407),
> not a memory-safety bug.

It isn't really an integer wraparound bug either.
The fact that only the low bits of the product are used shouldn't matter
at all.

OTOH it might be worth sifting 'sb' right some bits - quite a few of
its low bits are zero and they end up as zeros in the product.

	David

> 
> Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
> Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
> ---
>  fs/smb/server/vfs_cache.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
> index dfed6fce8..a62ea5aae 100644
> --- a/fs/smb/server/vfs_cache.c
> +++ b/fs/smb/server/vfs_cache.c
> @@ -10,6 +10,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> +#include <linux/hash.h>
>  
>  #include "glob.h"
>  #include "vfs_cache.h"
> @@ -65,12 +66,8 @@ static void fd_limit_close(void)
>  
>  static unsigned long inode_hash(struct super_block *sb, unsigned long hashval)
>  {
> -	unsigned long tmp;
> -
> -	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
> -		L1_CACHE_BYTES;
> -	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> inode_hash_shift);
> -	return tmp & inode_hash_mask;
> +	unsigned long mixed = hashval ^ (unsigned long)sb;
> +	return hash_long(mixed, inode_hash_shift) & inode_hash_mask;
>  }
>  
>  static struct ksmbd_inode *__ksmbd_inode_lookup(struct dentry *de)


