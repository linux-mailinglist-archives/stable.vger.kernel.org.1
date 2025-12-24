Return-Path: <stable+bounces-203385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF58CDCFD4
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 19:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C3943038287
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3A333B6E0;
	Wed, 24 Dec 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IBKrHv6H"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AFA329381
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766599322; cv=none; b=aEfY/6PoLr7QDhdRRDyUl6bQQgiyS2oc0xCYwHLUxltAiKxrESyedzrwV3y+ycjM8mfl47XKcd8D3CHJVbqQEzc84OH2RIYegtj1RY09lxaEtA9wBs+kYaCl7tkNE3xDqgaPWspon1c99KTWxUl6Kmv3cNZz+LUU9hacjxq+B9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766599322; c=relaxed/simple;
	bh=ffr8BuiqR1HXDARhf4WRKjYaZRBbwe/ETGa9BNLzfkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGe08uY58rwJv+06yM2rvBbXyl5Sxj/h3I/ujwQosr/AuVCtyv0yC3zVuBvgdosLKX7aU7+EO+gEazuCvKR8aSISdWpZY1eANGaLb1bBmQdYpfUnYHV8xa3crJ3ZrDxKTfzWVzCRsudXrMtly6YlvFFeiSR7uQ5MvZRJau6qzp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IBKrHv6H; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c75b829eb6so3822272a34.1
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766599318; x=1767204118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31Zv6z83wAMfU9zE8KFoguUGkPYnxjQorySjBsQWmUo=;
        b=IBKrHv6HrW2iA/iq3RIbQOS3QFkpkOIwhAtdCEdcMwpL5tkf9XNfhu/jGZJ5+A2jDM
         3dzBNJI0bnbIq3ghv3WNUOkwTRPnieTWTGmH15E2lSsD41NK3reD8DmfknQzZ29whT9v
         xUchTkByUW57AniMOcZKJtQCg5SUY8v7ETMyy57YJgUEIXrYl/qKYp8MTaW6gyBOeE5S
         Y0ccCTPRus7SeeN+xw9iyXlbNOYQP1c9w6gORDBqwGTguIMFr7m6Dr2boEChFR2N8P3n
         eJFV6kjDCWv1/AqKeeXd+CvvfQGzHGn1/6VHLLVSezC1O8OsbHSCoTT/TDiItGAylB/l
         H9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766599318; x=1767204118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31Zv6z83wAMfU9zE8KFoguUGkPYnxjQorySjBsQWmUo=;
        b=nCNqoX/7DDKMtOHfyg7VaS/CK9Zq+UVQ8pvPfuto2FBQPXVwUF5TBRPg9CzCMHbnOW
         HHAwET7/ecs7MgfuqzHU1mZcrAc7tUMiFDywSmc89mVoUkdBnhjNnTstAj5bUQ6Kr2DD
         hGSDMdqXXIUiTdFgxaLHk1dfc8No0pRyts9IGyiuR7IXbasKomjxZSoEB6iNk7MEfELU
         1m6bruAPp6feL1WiD/+2lIiukMKs7nQuX4nkgUW9jwkcLGXpKOb/FwwLdC7svUdeBsog
         xZegbFYwX8lF4C66uAJZQQb01tJ2CJeZEv+MPWanSWJ8C5u2bnU/TYhVt/6mAytHYt7p
         3rPg==
X-Forwarded-Encrypted: i=1; AJvYcCVI7EyH0BfFCSqim8VjlubrN+J6W0Orr46ZwfFrhpCMKNXu1ypD3wNF3F3We1Hna9aJEgqXBbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvGI6dQ0G/n7AJrNr5YGgYynEjzwiOLHb71fm+9tyIU24fAi4v
	iP9BC/GXUy5rI/D1nj0XsCzA8xvjtk0kujU+/PRf+5K7VBRUZ5QrEA9g3OkB+oAVctA=
X-Gm-Gg: AY/fxX41tZSCoss8Bm9V+xaCXMxU3pcW+Qp2VOLcHShSZy7bDueRy204VyLU5RG7kNJ
	t/aF9mwReld0SmPe2GsChMPU+3wQZHuCTA8Tyi0vm884CdrBjw75Tz+UJs6j21HEnRudwbhMBTP
	AINpfVeJQ4y3R19qsPKATlJwKHt03IbNGS3sJmLUJcH5wU73jo8ShsW3EnUh/lz0m7qCSlv/2U+
	EUVIAe965LPKqkB7W5YIROaaEWZuwUZkNSopeVvb0g7hWBPPjSxuQ39IqLH20CuS0SnV2/VzWWD
	iXF7CRVsJFQWbM9tnCdW3eh1q93Cxbi07RfCeT3RGyiywnjHl5hC5T6ouZ0ovmvtbsSMs2X91v9
	2lerEWOvDJYVUqCQkAXnAamW4B6XXtLCKCiF/vOsl8u1NB5wfix63gFSoTmgJEihkYj/GBsabMB
	0pwUe3JHwf
X-Google-Smtp-Source: AGHT+IGfEWIgxDSU+uANNE79e+2413xwqBZuFut4L1sp7glYjUDAwIPMADbg+343p4Lu36fqv0j2bg==
X-Received: by 2002:a05:6830:2546:b0:7ca:ee2d:fd8d with SMTP id 46e09a7af769-7cc668bb2abmr9050695a34.9.1766599318375;
        Wed, 24 Dec 2025 10:01:58 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66645494sm11921405a34.0.2025.12.24.10.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Dec 2025 10:01:57 -0800 (PST)
Message-ID: <dc51a709-e404-4515-8023-3597c376aff5@kernel.dk>
Date: Wed, 24 Dec 2025 11:01:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: fix filename leak in __io_openat_prep()
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org,
 syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20251224164247.103336-1-activprithvi@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251224164247.103336-1-activprithvi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/24/25 9:42 AM, Prithvi Tambewagh wrote:
> __io_openat_prep() allocates a struct filename using getname(), but
> it isn't freed in case the present file is installed in the fixed file
> table and simultaneously, it has the flag O_CLOEXEC set in the
> open->how.flags field.
> 
> This is an erroneous condition, since for a file installed in the fixed
> file table, it won't be installed in the normal file table, due to which
> the file cannot support close on exec. Earlier, the code just returned
> -EINVAL error code for this condition, however, the memory allocated for
> that struct filename wasn't freed, resulting in a memory leak.
> 
> Hence, the case of file being installed in the fixed file table as well
> as having O_CLOEXEC flag in open->how.flags set, is adressed by using
> putname() to release the memory allocated to the struct filename, then
> setting the field open->filename to NULL, and after that, returning
> -EINVAL.
> 
> Reported-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=00e61c43eb5e4740438f
> Tested-by: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
> ---
>  io_uring/openclose.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/io_uring/openclose.c b/io_uring/openclose.c
> index bfeb91b31bba..fc190a3d8112 100644
> --- a/io_uring/openclose.c
> +++ b/io_uring/openclose.c
> @@ -75,8 +75,11 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
>  	}
>  
>  	open->file_slot = READ_ONCE(sqe->file_index);
> -	if (open->file_slot && (open->how.flags & O_CLOEXEC))
> +	if (open->file_slot && (open->how.flags & O_CLOEXEC)) {
> +		putname(open->filename);
> +		open->filename = NULL;
>  		return -EINVAL;
> +	}
>  
>  	open->nofile = rlimit(RLIMIT_NOFILE);
>  	req->flags |= REQ_F_NEED_CLEANUP;

You can probably fix it similarly by just having REQ_F_NEED_CLEANUP set
earlier in the process, then everything that needs undoing will get
undone as part of ending the request.

-- 
Jens Axboe

