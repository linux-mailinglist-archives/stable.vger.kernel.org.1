Return-Path: <stable+bounces-69668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339A957C8B
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 06:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57B4B22D74
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 04:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F643FE4A;
	Tue, 20 Aug 2024 04:49:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B624E541
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 04:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724129347; cv=none; b=HzFkd113HV3uEmabxusFIBwdCwMdhOC0/vSNm1uK/1LH4ffLK7Zdg37Lsz54jK6MJKsy6omMTdUVVMc54LVwlVZc/s0hfOVQ9/E86TYfbv+fxJZFe/BVAT2VK9liTM8laBcu+Gtu94yzKgSX8qH7Je+sZ4e0KdtgSZagPhRB9r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724129347; c=relaxed/simple;
	bh=vNz6hEzuYijA1TgDkkezCXD7HGknoTYO2HHAZPWUUOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YXiKYWQZWp/hwvNbi70VtB3wCaAX+WvJysbW2LQHJGMumlrmaYscDcI2cRVvPsz135nRaa89ZlhTjyjCSD1pLvdwxsT7JdCcaijx3uVgYzldCskBpI+wUi/cFTz9Ph4d8nYcKI7eRUMkoW+ZAGJRd7PWbOAuGFVI+kThyl1LOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428119da952so40528655e9.0
        for <stable@vger.kernel.org>; Mon, 19 Aug 2024 21:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724129344; x=1724734144;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALr5L9SS4h75GJ0msFfevTh0cqjXGdoJZIpXt9kUwpw=;
        b=LsGOurmo4joEoZewyfhOmiKAxfzx91CyQTd1c1TKoQfqBLB04ZxPzEZhUe+Jocbog+
         CdupD9T9DPbjer/xjZzVxzG0TtKHHp12R6tGvq9Or1X/ChQKkvwd/bv8breH2b7eFbs4
         x6Vk0YVroSZ0BnutIeukcbtaCd2fnImdSHHNdhEVC9IdAIiLGQ3W79WppH5m45pYno+T
         +oogxAR7b1M4VVEZxyXb8M9I9KZ0VRaujn/V3OUx2BOaJe2iTHfX5TNYLd0xYv7QH2jV
         3Czj60GFfgfkP76Mn5sq0vJTKwTwQCk1ezi24HEYoqSr1KHftUeITEhsEfVoXW8Bm7JE
         IwzA==
X-Forwarded-Encrypted: i=1; AJvYcCXZSMkZeTfk9cRCfvehuKluvjRHNIujeceRBcMS9Fu+lWv0IYMInaOlNvnWpLkzTBBY5tHH6Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU1E/AdmJDa4UltS/Fbf0Gmi14W5AZoebnw7yc8mcgh8Lal319
	hgRf4YNeZ39tcQSE2XaRo6iPtvvssd4o0BTYf04juQFSdEudaQFf
X-Google-Smtp-Source: AGHT+IEKbRyAyK3bufxtdUOt8Pjb9fSK7pH1I9438DShOc4aPGzCWfxo0hO/U8P4l/ZhaJGsr7aYkw==
X-Received: by 2002:a05:600c:35cd:b0:428:16a0:1c3d with SMTP id 5b1f17b1804b1-429ed7ae16cmr87308265e9.19.1724129344284;
        Mon, 19 Aug 2024 21:49:04 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7bb5fsm186680115e9.40.2024.08.19.21.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 21:49:03 -0700 (PDT)
Message-ID: <0d12eb50-c51b-496e-a931-9ce8fb6a1455@kernel.org>
Date: Tue, 20 Aug 2024 06:49:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] drm/amd/display: Fix a typo in revert commit
To: "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>,
 "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240815224525.3077505-1-Roman.Li@amd.com>
 <20240815224525.3077505-13-Roman.Li@amd.com>
 <CY8PR12MB81935FA7A89D077A2D0DADB489812@CY8PR12MB8193.namprd12.prod.outlook.com>
 <360cabdc-3ba7-47a0-8e4f-f0ed8cea54bc@kernel.org>
 <CY8PR12MB819387431D6D6E754929ECB9898C2@CY8PR12MB8193.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CY8PR12MB819387431D6D6E754929ECB9898C2@CY8PR12MB8193.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 08. 24, 16:29, Li, Roman wrote:
> Thank you, Jiri, for your feedback.
> I've dropped this patch from DC v.3.2.297.
> We will  follow-up on this separately and merge it after you do confirm the issue you reported is fixed.

The patch is all fine and very welcome to be upstream as soon as 
possible. With this patch, it works as expected.

But the process is broken. Your and Fangzhi Zuo's send-email setup to 
the least.


BTW you write in the commit log:
Fixes: 4b6564cb120c ("drm/amd/display: Fix MST BW calculation
Regression")

But:
$ git show 4b6564cb120c
fatal: ambiguous argument '4b6564cb120c': unknown revision or path not 
in the working tree.


Instead, it is:
commit 338567d17627064dba63cf063459605e782f71d2
Author: Fangzhi Zuo <Jerry.Zuo@amd.com>
Date:   Mon Jul 29 10:23:03 2024 -0400

     drm/amd/display: Fix MST BW calculation Regression


So apparently, someone in the process rebases the tree or something. 
Which is another breakage (non-reliable SHAs).

thanks,
-- 
js
suse labs


