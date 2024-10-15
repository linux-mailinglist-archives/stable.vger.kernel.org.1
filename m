Return-Path: <stable+bounces-86359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604699EFF2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39F31F24206
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBBF16D4FF;
	Tue, 15 Oct 2024 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6vjcvjW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40071FC7C4;
	Tue, 15 Oct 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003541; cv=none; b=VMi59d+DGHERp5omRGzmDHTK+c/1tcOUM+lLhSR/ZRDv049dYtgJH3vpv6lDTMqQ68vmPQMgYykeNNOC+hrNqkzAZ5az7h8dJRr52N8buOP8452KQN6RUeoLLaA87iuusN+ocBgDVyVpLzVqXR2JSe5Sz8GtzmmG/KTN/16/Xus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003541; c=relaxed/simple;
	bh=c36HbQs0gJpyQFG4AYu2BErUBXyc17mTB5ULEPC4y3E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oZDt0IYxmgTDVEdz9cWPI1+NObo7609fuprwTSnAstlnk/R2rn3OAq2s0neLI5zzliJuOX/2XrClBLcokaaWud20hV6XTmIPByk7OENv8fvRIKtbG1IdUD0o/RwXTc9jmdcQGn/YJ9zyWDb1vCVi+KugAnPLco9CfZ1bMLhtTOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6vjcvjW; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20c77459558so43154805ad.0;
        Tue, 15 Oct 2024 07:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729003539; x=1729608339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ofgu3iXnCYSQ3sJFxlEFNmaN7sQ5lnXtot0dUpXtI6g=;
        b=R6vjcvjWUPTOsFvw8T9GBv8TYGLY0UWwLyBdTeKV+mBtc5I+H8ecB5Fd1Lu58RjPIO
         Eo6rBCZ1osTHMO80mQuCqUz3J51tQcl4Q4KRtRRo++0HqKiR4+B1VUzBKfKtA5RTPmP+
         BH6Rq2e6VWvBTZUVLlUsnxS5dG50gdA0KovFKgkbEZ1QFwsVVrDb52dJWGJ9cstMVRhS
         o6QC+5BI8ckltWSrpRTyCHkXzkHZuyPpGorYKLE3bKhyV/RQp313bNfi84Ri8Nnn7y2q
         xEr10ugMTXJb4Ys+T8XdPiDZKCkX5ENpE7BdLDxihpRO9nD2BeoKNQi1/BhFXKgjBFDV
         gA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003539; x=1729608339;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ofgu3iXnCYSQ3sJFxlEFNmaN7sQ5lnXtot0dUpXtI6g=;
        b=K2Sa9tO3Wh1QCCOh7wCWIoHKGsVLXnZs466YvrSRUNUbGdbq4O9XyNfAyA9ahGMgRa
         w1/Vb1xclIk1MATvdqvsT3/6u0ZnXDmKZJOdfeJckIacOKq4r9w4ekWKhSWvsJgH+ag3
         +FNuhMwfmqlzDDJROjiFHuRIp7KQj/gL8NPwOWt9AUrAxR7Kox25oSHRF2j0/adCDR+5
         9KBb1NtMiyyctDV3ORhlSdLhhUwVYix/EjhyssKRg3IM6HvE6sO/zgsRrsXy5YLjGrhG
         8WsanhxiyaygmsOp/yzKS/pniYO//wbqmCcixLQ9lNJfwNo/yRq07tO4qsmrXG3vcZeK
         27sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw1QR2/W+UBX4Y1Ux+dof9HaQ/eY+GZ+yJtGPaSdwnsDJWzopQ2n62dpPWFvRd6iK/pzQ4Tf2bumaGAfdx@vger.kernel.org, AJvYcCWUwy0AiSP57Q06EVEM0XXZ4kImHStuqhLEdfDJ/nt5vprJowHxSOvG5Za4oywaDVDIOHzJFj0U+mSt2DoKWuc=@vger.kernel.org, AJvYcCXaBARHSOmiwVOSDFApLo9CRAoBRpmY7pt7C3+LeVmu093OljcwV5yN4U0zrpNXUrN8vguDRMQB@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVx324dg9EEM3hY8TeFmnmhaviA0Pq3Rnbf9DtZ5uNWY6Pnvl
	aLreD3TYgPBALaDZlOESXWEuhvvHv99AcrEhz3Yo2QgzL3OJO0Ig
X-Google-Smtp-Source: AGHT+IG8W36j/qtZDwW2WA2jb0i/BTgkc8ZJA0sEHueOn6qFxt+Kh7GFqBij7XyJqwymRVZNuB/RlQ==
X-Received: by 2002:a17:902:da84:b0:20b:6458:ec83 with SMTP id d9443c01a7336-20ca144ea0fmr212260065ad.4.1729003538995;
        Tue, 15 Oct 2024 07:45:38 -0700 (PDT)
Received: from [198.18.0.1] (n220246094186.netvigator.com. [220.246.94.186])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c6bc015sm1412742a12.19.2024.10.15.07.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:45:38 -0700 (PDT)
Message-ID: <b7b9fba3-819a-411f-9e67-d5eec9e63eaa@gmail.com>
Date: Tue, 15 Oct 2024 22:45:34 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pstore: Fix uaf when backend is unregistered
From: Zach Wade <zachwade.k@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: tony.luck@intel.com, gpiccoli@igalia.com,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, lixingyang1@qq.com
References: <2bf30957-ad04-473a-a72e-8baab648fb56@gmail.com>
 <202410081019.0E9DE76A@keescook>
 <6077c924-f975-49a0-8ee4-4e481664ac38@gmail.com>
In-Reply-To: <6077c924-f975-49a0-8ee4-4e481664ac38@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/10/9 21:36, Zach Wade wrote:
> 
> 
> On 2024/10/9 1:23, Kees Cook wrote:
>> On Wed, Oct 09, 2024 at 01:10:14AM +0800, Zach Wade wrote:
>>> when unload pstore_blk, we will unlink the pstore file and
>>> set pos->dentry to NULL, but simple_unlink(d_inode(root), pos->dentry)
>>> may free inode of pos->dentry and free pos by free_pstore_private,
>>> this may trigger uaf. kasan report:
>>
>> Thanks for this! I need to double check what happening here a bit more
>> closely, as maybe some ordering changed after a43e0fc5e913 ("pstore:
>> inode: Only d_invalidate() is needed")
>>
>>> @@ -316,9 +316,10 @@ int pstore_put_backend_records(struct 
>>> pstore_info *psi)
>>>           list_for_each_entry_safe(pos, tmp, &records_list, list) {
>>>               if (pos->record->psi == psi) {
>>>                   list_del_init(&pos->list);
>>> -                d_invalidate(pos->dentry);
>>> -                simple_unlink(d_inode(root), pos->dentry);
>>> +                unlink_dentry = pos->dentry;
>>>                   pos->dentry = NULL;
>>> +                d_invalidate(unlink_dentry);
>>> +                simple_unlink(d_inode(root), unlink_dentry);
>>
>> But on the face of it, this does solve the UAF. I'll double-check that
>> this isn't a result of the mentioned commit.
> 
> Hi Cook,
> 
> However, I think a more appropriate solution to the problem here is to
> check the reference count when uninstalling the mount point.
> 
> At the same time, the test script is attached:
> #!/bin/bash
> modprobe pstore_blk
> blkdev=/dev/sda2
> best_effort=on
> mount -t pstore pstore /sys/fs/pstore
> sleep 2
> umount /sys/fs/pstore
> modprobe -r pstore_blk
> 
> Thanks,
> Zach
> 
>>
> 
>> -Kees
>>
> 

friendly ping.

Hi Cook,

How are you doing? I really hope we can solve this problem.

Thanks,
Zach

