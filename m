Return-Path: <stable+bounces-83215-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3EB996C42
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02B1EB21660
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4085197A97;
	Wed,  9 Oct 2024 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMCcRcVC"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1E1E4A4;
	Wed,  9 Oct 2024 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480999; cv=none; b=bOJAh5bThbwwSDSd94CdtpH0FVTFrlgmsAy2qy37DYrG7MjLLnvoqmAF8phz+CvnxyfCbh+0us7dY8CYfDbLr3hFMI7luPtPnAPga1gYT46hm9ILRUh1CuGpAxSA9nJX1kQAVoBDj57NSuKGtmfL15gJTvXLVqmA7jua+hYy8l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480999; c=relaxed/simple;
	bh=F4JINcttXjoVRn5HH5wMT/sa4Wz40gFGrwTMgVB2Avo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fb9ACU3fuCNrjG8UhyzJYes2HFPxY/XXM/c4zLSGBRNd8UhN3PKZEqT3JmjagPgiFp6ANI3RSALaDajx5gzl2qi/prKvXmIx49LaOuVrwU8j3fHR1XvUTC67tQ1MFtEUOdmdDkLXTVLTqlsWAmxmmoJPT+1hE11eHUah6hqb07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMCcRcVC; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20c593d6b1cso17166615ad.0;
        Wed, 09 Oct 2024 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728480997; x=1729085797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z1XFRx5WAa767478931DIH4cHF8X+E+L1pl0+bzJ/o=;
        b=lMCcRcVC1JJVqKen8VsAwwuuENlMJXRdlaGcUEV0WynvvTJ23U2wd8iGyZUzGEaGvl
         u6iZRBXR5gbF53uTNjq5d9DyGBShRvwYk1abb+B3PLGwdNaeRQ6/jwr0I6kcCxckmdq0
         1weF/9UeI3CZ46NB7Uz7Jf6yrBtdUPZHiqklFnV8bJPg8SFXCIDDy9b+M/4UiapRt3qe
         8/ibaJ1dxw+4PTBzbYXwHAPGeNXQWLyMpZnBumgWqLXc/diuINjH4X+CgUkU2j9upBwq
         AF4rjIuiu+IPlGcbvw7CrhoGdEE3Epf/Pte0Do7N0yJDzXAm8YRqVffEhICcJAsy4lYO
         8T0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728480997; x=1729085797;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7z1XFRx5WAa767478931DIH4cHF8X+E+L1pl0+bzJ/o=;
        b=VrOfirJMetpEAHaeYG1pY+PHVq8o0J5DiCqdVDtRPuxBt0NFvj9lU/9R23sWeYOh0m
         vCc5dDxYTJPFs74EK7bwIQpUXfAtQkSwg5BaMLW0cObUYhl7bdLz0ctYFDW/ROPaqw+S
         osMbVBlGXzqgWLkISQjUmK2fWA0JbzsGy+zMWw+XooafqPAMfbyT8BldAqz3JHFjJqLj
         PDeuds0zGniTGK/+JHojUILDa+NG6vD3Df574xCxcVEPlhOi/QglVeNp5gzdiMVfGY87
         you/Npnwe6cFzdrGKO7g6nd7oZVfrhcTyprOpWvkmyxKMPKdGHFLp1ahcBTm1/zhWoWZ
         pMww==
X-Forwarded-Encrypted: i=1; AJvYcCU/+wuQ6/8eCIA2EisArwodFGrbLOOZg+xHVqYe0kleFBBIZwdhox5VbvOypyvWm2e3ocRuORL0G/rIXP3J@vger.kernel.org, AJvYcCV/v4gxzakByvpRM0XJb589KqpdjDnd4Ea5TLiaLCxyThSMGj3XPXlJlUHyZ4/xT6CafeD8n4yPR6pHiQ/9Om8=@vger.kernel.org, AJvYcCXoY+ftzfvk/mNzffP02pVKf5X4wp4yyz7asoY3m+h/+h1Sa0HS164NDGGCc0yVfFLOY6EoG/xy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XGwXKWSq5/Qc/KGDccghS/d7W8v0vrRMaOzUJ9AeEgNUOlLf
	8XlDYwQ8zYI9tSEMqP733XdTRfyCqo9OEaIPaYxsBs37fnanBC1epq7wk0pX
X-Google-Smtp-Source: AGHT+IGsJEvxXtIb2li7iBcEDRdYWRnBXohOlYLYdxfwN6aIP8lCJDyFvh91ETVg4QWOgukM5r1bFA==
X-Received: by 2002:a17:903:110c:b0:1fa:9c04:946a with SMTP id d9443c01a7336-20c636e1892mr47017035ad.1.1728480997420;
        Wed, 09 Oct 2024 06:36:37 -0700 (PDT)
Received: from [198.18.0.1] (n220246094186.netvigator.com. [220.246.94.186])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c7749c9d6sm5128645ad.28.2024.10.09.06.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 06:36:36 -0700 (PDT)
Message-ID: <6077c924-f975-49a0-8ee4-4e481664ac38@gmail.com>
Date: Wed, 9 Oct 2024 21:36:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pstore: Fix uaf when backend is unregistered
To: Kees Cook <kees@kernel.org>
Cc: tony.luck@intel.com, gpiccoli@igalia.com,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, lixingyang1@qq.com
References: <2bf30957-ad04-473a-a72e-8baab648fb56@gmail.com>
 <202410081019.0E9DE76A@keescook>
From: Zach Wade <zachwade.k@gmail.com>
In-Reply-To: <202410081019.0E9DE76A@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/9 1:23, Kees Cook wrote:
> On Wed, Oct 09, 2024 at 01:10:14AM +0800, Zach Wade wrote:
>> when unload pstore_blk, we will unlink the pstore file and
>> set pos->dentry to NULL, but simple_unlink(d_inode(root), pos->dentry)
>> may free inode of pos->dentry and free pos by free_pstore_private,
>> this may trigger uaf. kasan report:
> 
> Thanks for this! I need to double check what happening here a bit more
> closely, as maybe some ordering changed after a43e0fc5e913 ("pstore:
> inode: Only d_invalidate() is needed")
> 
>> @@ -316,9 +316,10 @@ int pstore_put_backend_records(struct pstore_info *psi)
>>   		list_for_each_entry_safe(pos, tmp, &records_list, list) {
>>   			if (pos->record->psi == psi) {
>>   				list_del_init(&pos->list);
>> -				d_invalidate(pos->dentry);
>> -				simple_unlink(d_inode(root), pos->dentry);
>> +				unlink_dentry = pos->dentry;
>>   				pos->dentry = NULL;
>> +				d_invalidate(unlink_dentry);
>> +				simple_unlink(d_inode(root), unlink_dentry);
> 
> But on the face of it, this does solve the UAF. I'll double-check that
> this isn't a result of the mentioned commit.

Hi Cook,

However, I think a more appropriate solution to the problem here is to
check the reference count when uninstalling the mount point.

At the same time, the test script is attached:
#!/bin/bash
modprobe pstore_blk
blkdev=/dev/sda2
best_effort=on
mount -t pstore pstore /sys/fs/pstore
sleep 2
umount /sys/fs/pstore
modprobe -r pstore_blk

Thanks,
Zach

> 

> -Kees
> 


