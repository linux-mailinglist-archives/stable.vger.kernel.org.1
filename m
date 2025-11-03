Return-Path: <stable+bounces-192229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7438C2D235
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42383BA21E
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984DA3176E4;
	Mon,  3 Nov 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJm1QDIE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7618315D58
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186971; cv=none; b=J6xhOS9mO650pgI3RtXyirpAFMYESFv+7ShtVCtKoltjM02iJ28CZ/Nq0lkyJGqDFOaZwRMdmiQgNucKeW+12RpKS6MAU2W7GRJYQKVgDpiqi3gM568+4DsFMWKJZ2DMDllgjTXKhKI44dbGQpBBmkMi0COb8jIzFQcnXPvDj28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186971; c=relaxed/simple;
	bh=MAqh8a5N+ZsOAGEcWjRLDNWJ4Cf1BpHeOMi77RPjhlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XE6g4a8fZ+rlCU3uU50p6igwnP2jidxaGa3B2GQWaH25GrKIvkmg8b9o3ZluSvWIY1LXYRxi5M8ad+VKlst/sWXMUfnCVi+QXI6C1+4lOA0pbrc5Nj5hO3GzTP8UFpVxJ8ZeyvC+OIUWnMYaiMTh/e2xrFI0UEeaOVyRPMJw1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJm1QDIE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1186924b3a.3
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 08:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186969; x=1762791769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfeI4do2p8OwX1bs3r/PVpU23cvBEdcK3KBLEfo+aK8=;
        b=cJm1QDIEvy6vQsHD2LLXTwJJJf4Mpe4/+xOPU31gpiXO/voaC5GoTJdUP49sLohvUe
         VIT0lc7p9a59kWz3sRDeNRIp71R+3k+NRLHa0uOyqjEfnoLkSwpEHgF3+xHG0rIW1z0d
         tFnbE6XgB1P2J/c1jChgyGO80pQHfClydnR3caIx3ckCib4P0qgDptgqoieL3rWnI4tU
         YNGBeWXsxrFna+hB5hpNmNKR4ZoFxvPEWlEKPLX1TE3XYWiz1tuqhTRQ4wwi0EtxK9hG
         a3059MRX9Km7YEESIe1OlxhdYoslcqhX0Hatum6onHcJ4RyA6vH5YOLuqMkS3voyNH4k
         PBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186969; x=1762791769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfeI4do2p8OwX1bs3r/PVpU23cvBEdcK3KBLEfo+aK8=;
        b=xHNt5ufbnMwZHPZtp6aalLNA4c8JtThImd3e91+VbtF3WoHzvs+CjblvsXewljjzcD
         4G4GH5PVPiqo8EQey8ntDcRW+tDq4qS5umK1Y4+x44OF1T6fmSnsFR4lu1U6Puf+dINq
         YDlyrRJcCJGUdT0Ud6eAIXz9d3nEwiYE26y+3WkvmmN3zXmpa2rlYP9Hx5skN0MAxP4i
         QuvGOtwKBh56jWrdnBHIyLFWh8GdTq8M2CdmSUEn87lPCE3rtRAWAEui5LUfcrmTSSA/
         J8olXKjkgqF1g8pZlFonwIVwfOAMUefzxcbSD6d4CfkIE+FOYuCYdOIHnEkqhPD6wqtY
         MFMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqAsb/Ngmdove9A7wpXCsy+LCRTJ81JrNWyWzvy0cTdVbdh2kMEmZ4+yVioZFsFkPEhhojLm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfj8pt6xOiFI8YsJBiw1qFfqKk3buwZm0CPk2CTJnF914n0RIP
	Br+UMJ2dSZ6zTuXFerWGl+DdLJyppsROht2pZAJyerSyGA11BKiEXmMp
X-Gm-Gg: ASbGncspTclwVIwkgLrgfPA1YaHy9lf3cdBBtAzQFvhwO0CYw3NKrpWu8+xp8c700yh
	qdxOic3dkkL0932/i/FDwWlZYBbAG97JfP7b3i1LXU3ineVKTqDGtxeuHL0gtspOeTg+8UZ+zAp
	85XXEIEjKcy//xQi8ZP4wUpBBZNonwyI/pBratcxezm7J0ycu/MzcSSxetJ1hqb7oDM+RjQ08uk
	ElYjVY8WWQvPgYY4WQMFpnt6O+ck8oZKJqzLbSj54Mwaw/eJdM1ylROZEeRtqQ0MQxcC+Vh8B/t
	jBUPyVfESGjoWji0/VFrwtMexuT0NrvIkaBvYemwZfqA7Aqg15LF8LYp9WqhRKMZwQQ4nCFR8eV
	x4xCk7vosm1WK/AZI5gdg8qjOzO7xW5CJfT1cFnu3Lm4oxN+/fKaHNCyI1UPuzEFk64VxLDB2ZF
	a6hODLr9zOU8jimo3TG/jlvedMVxCknOVlBuec96L9BhoEJ0VySXAxCUFuWylZrdN4L2R5P6MTk
	yOGGmgJrHo=
X-Google-Smtp-Source: AGHT+IEQaEN/YRqaD9Q0fZ6GjLoywGPuwEKc41YzWo/EM8FatoGxq2+IaYk2SY8ba4sIfOPAOnQ3UA==
X-Received: by 2002:a17:902:ecd0:b0:295:9b3a:16b7 with SMTP id d9443c01a7336-2959b3a1914mr60038095ad.4.1762186969039;
        Mon, 03 Nov 2025 08:22:49 -0800 (PST)
Received: from ?IPV6:2409:8a00:79b4:1a90:5d7b:82d2:2626:164a? ([2409:8a00:79b4:1a90:5d7b:82d2:2626:164a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295743772e9sm73908245ad.66.2025.11.03.08.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:22:48 -0800 (PST)
Message-ID: <a89cb9af-784d-41a6-9f1e-dfa28d09be29@gmail.com>
Date: Tue, 4 Nov 2025 00:22:20 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fix missing sb_min_blocksize() return value checks in
 some filesystems
To: Christoph Hellwig <hch@infradead.org>
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
References: <20251103135024.35289-1-yangyongpeng.storage@gmail.com>
 <aQi4Q536D6VviQ-6@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQi4Q536D6VviQ-6@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/2025 10:12 PM, Christoph Hellwig wrote:
> On Mon, Nov 03, 2025 at 09:50:24PM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> When emulating an nvme device on qemu with both logical_block_size and
>> physical_block_size set to 8 KiB, but without format, a kernel panic
>> was triggered during the early boot stage while attempting to mount a
>> vfat filesystem.
> 
> Please split this into a patch per file system, with a proper commit
> log for each.
> 
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
>> for sb_set_blocksize()")
> 
> That just adds back one error case in sb_set_blocksize.
> 
> The Fixes tag should be for the commit adding the call to
> sb_set_blocksize / sb_min_blocksize in each of the file systems.
> 

Thanks for the suggestion. I'll send v3 and split the changes into 
multiple patches.

Yongpeng,

