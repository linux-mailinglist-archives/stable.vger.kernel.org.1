Return-Path: <stable+bounces-188030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74583BF0837
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0F33A3144
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B3D23C8A1;
	Mon, 20 Oct 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRDqtSpR"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0881D618C
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955783; cv=none; b=kLYOXbhmUd90rEQJ4PmKsWyQaJAoZZJc058NyRAtEMQTNUP+0NVefabUh9b/smlHPgvr3VKMBouZd7PsE1/9pw5TUTI68IfAkVNCTmkY+RPH/k846tiov57mqH+aWVcKV56rlrhEDaS+gjpDH6MyA31pKQxsw2YpCtpB84FS6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955783; c=relaxed/simple;
	bh=Y/Of83zNnX6sLmH5GHkmtmLz/GMJGrrvbX//+5h9WSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QN5Yg+IU3jrCfbn5ZJiXbe6Dn6YAI2Bc60TiDb+BWNr+Zpuf7DBkCY7yOg+loQ+KrezApkyixPl9POxAAexV1qiHWkFUGQ42FBeSlIPiWXQJd0rj/Dmg72FnHSs3Q7YcNhM9f3ffmtC6wYxmLXCMgETQZCyuoUBGIHP2rCLbvHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRDqtSpR; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-430d0cad0deso8845685ab.2
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760955781; x=1761560581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwVo13kZhRZYVn6fdjYldZCTWh9uLDhB/G1K2cn+K/o=;
        b=NRDqtSpR6Om9EL/EVbI8uUOL4d3a7lY6WTNWqbhWHkFY+H3X/2RlnAiQGyGtrBVVwe
         WokDmIyaJSwXGH3JoG7Sqz4dkHxS/20mKrB7I1b9iDCpbzLLdIq5twOOzh48rMIZZS9v
         +iB9s+Zd+rAGiaw/1OhD65uDpKUV/pqbnwc+j+ez0a3zxmpGVq8hipheR2pbBzN9J0r3
         BLnxRXo5a/WOj30ifE2wTtC9rv9nfWmY4kFRDJPoCZM+X29Nbfi3OstW5NcgzPXpUgs9
         hFEXru5X/Wt61ffdn0glk+u17p2KQxYJwZ4iOy4NtjjI0FvrArSZJ/q9FCaqBnnRJY2T
         OGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955781; x=1761560581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwVo13kZhRZYVn6fdjYldZCTWh9uLDhB/G1K2cn+K/o=;
        b=M9TTEmNh5fVxxi+Vaa++bJnz2a3RxjCe2yqg1AyIZmZ6v9y6JvVVHmuW4y6OmJkJVG
         VvzDccop1niRaDQHff0qlJmjXBqyLD0rZ05SQ1t7I44m6gLcfCtFrSf0U9Y7WP29EvKB
         cdrYOJ/fcG99+/6OWWBn9R4bX2Z+Fwz6Nok8abraueRbA76AUlYYdZe5l0ssbFO05x8s
         zGwsonfgYD98JED+W9znu+msKz8iMivnIUxc/6uaK6DUzcFri7ADXUDFt75E9RnitI74
         l/k7RdbIm9NFotdCWvvcCO/rE/v6ddBAVX12VWtEn19HvirYNNULs6CUfuRZODSlrjOm
         FJ6A==
X-Gm-Message-State: AOJu0Yyl168CZHVU3/YshfIi6tpA/GUndmv84gs3tGNEzli+kEcja0Oq
	8M7530ilZ4xFPc9NwdDtt0tdW2ZZBOrx+p8WBIV7BRHi4U/6yXNRFi+D
X-Gm-Gg: ASbGncv9hr0FF/2XFNVMYcw4EYuFi40JN34D5i9nj1j4MwB8+z9tDB9MczAT6v6bK4a
	OrBZvQxZ8ovx1Jp6YVw+qFbiMNdTtEkM877W9Yohh8qu0KtkrVDn2HnOh+gJkTbNfK4JFtnRljn
	I5nO0ERI/mRQMr4+Fi511WTxHrufUkXPTsIqjb8BRYgOVx8RxoHjoG470BzdRKF0/XXBaK9LLZx
	RUGeOFxZWNu7bB+QG7F8kn949aBnorBVSOcoVR1f2WtPJGBBNt7/3ogSJzWwChZSB8WUGC1spkj
	8ykwoqiC0/Mwz1lm1WzxFdNtqmIKtp161DI1u8Q+hMDTcCOKuA/uegKJfONXDcQFnB72mtteYQd
	ycMhJ+sfDxtZ3NbvB1wxf8Uprs54dnUWrjWkF2WX6kap3GZwh2wUmLujSP9FbC9sUsBioDu9rrK
	bGihlPkpFoFHeIV+r8YyMprtwraR42BodquLUh/K1mlQGp/vxHnzTvRN1S3t88WH6SNbyH
X-Google-Smtp-Source: AGHT+IG4dp/N0dV5mHcutfGgLi7WUo9KkOeCCIQt4U+ykxHYiQAKOUA3QFXQGElCS92gu8u84w17IQ==
X-Received: by 2002:a05:6e02:2197:b0:42f:87c1:cc3f with SMTP id e9e14a558f8ab-430c526b099mr184393265ab.18.1760955781036;
        Mon, 20 Oct 2025 03:23:01 -0700 (PDT)
Received: from [192.168.88.138] (108-75-189-46.lightspeed.wchtks.sbcglobal.net. [108.75.189.46])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d071ebccsm28529785ab.17.2025.10.20.03.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 03:23:00 -0700 (PDT)
Message-ID: <5e29b2ef-086a-406f-ba3b-f0b7a09617bb@gmail.com>
Date: Mon, 20 Oct 2025 05:22:59 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/amd: Check whether secure display TA loaded
 successfully
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, khalid@kernel.org
References: <20251018165653.1939869-1-adrian.ytw@gmail.com>
 <2025102014-hummus-handgun-d228@gregkh>
Content-Language: en-US
From: Adrian Yip <adrian.ytw@gmail.com>
In-Reply-To: <2025102014-hummus-handgun-d228@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/2025 4:06 AM, Greg KH wrote:
> On Sat, Oct 18, 2025 at 11:56:40AM -0500, Adrian Yip wrote:
>> Hi everyone,
>>
>> This is a patch series of backports from a upstream commit:
>>
>>      c760bcda8357 ("drm/amd: Check whether secure display TA loaded successfully")
>>
>> to the following stable kernel trees:
>>    * 6.17.y
>>    * 6.12.y
>>    * 6.6.y
>>    * 6.1.y
>>
>> Each patch applied without conflicts.
>>
>> Compiling tests will be done for patches as I send them in.
>> I have not tested backports personally, but Shuah khan has Kindly offered
>>    to test them.
>>
>> This is my first patch, please do let me know if there are any corrections
>>    or criticisms, I will take them to heart.
> 
> Meta-comment, do not send a "patch series" that can not all be applied
> to the same tree.  When applying a series of patches (1-4 as sent here),
> that implies that all 4 go to the same place.  That's not the case here,
> so I need to pick out the patches individually some how, and apply patch
> 1 to one tree, 2 to another, and so on.  It looks a bit odd to apply
> patch 4/4 to only one tree, right?
> 
> I've picked these apart this time, but next time, just send 4 patches
> separately, not as a series, as you can see others do on the stable
> list, and all will be fine.
> 
> thanks,
> 
> greg k-h

Thank you Greg, I appreciate your time and comments. I will be applying 
your feedback to future patches, and the explanation makes perfect 
sense. Sorry for the inconvenience.

There may also be some confusion with me saying Shuah offering to test 
them. For some context, Shuah told me about this fix after she noticed 
it on her machine and gave me the opportunity to make the patch. The 
offer to test them was given to me along with it, but I don't believe 
the tests were done on each of the stable trees yet.

I'm writing to make sure these patches are added responsibly.
Feel free to ignore if this isn't a problem. Thank you again.

Respectfully,

Adrian Yip

