Return-Path: <stable+bounces-10815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E256482CDA9
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 17:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781172840D3
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 16:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345562103;
	Sat, 13 Jan 2024 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tzlJHiEL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C84A23
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3ae9d1109so13540225ad.0
        for <stable@vger.kernel.org>; Sat, 13 Jan 2024 08:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705162311; x=1705767111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tRe8OIH5w5P/VO443nw3GKQzFAsZ/6p3h2Ol2oxukM=;
        b=tzlJHiEL/r68OxGbWpyt3pLMVVx2s64WGu9ZptEE1LcFq4NueCvijT+FC4/7lTv1of
         tMrlryiX2bW79fPStvdujcOoNzdv2E2uPzNfX+fr7BrnoWyCog6tESqMpT9hPBf7nJLw
         8TcMBJ+StmWCgmntKKpKT/YDJC4npuickFg9LwfuYYfMVde+9GsgLY5D9i6xeK2nmFI0
         9UED85s8mWa5ecoZKYgxY+isoeMtC58TyBppaApfENO0YAM9YYVOFxK2uZ1b+bBuAplu
         S9DrO4FmONarWW97O6Yh2iekx5tFtc7fb/n+s+3III4B+Nxu0/xhlRTSdvGG02LrwEvc
         5VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705162311; x=1705767111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tRe8OIH5w5P/VO443nw3GKQzFAsZ/6p3h2Ol2oxukM=;
        b=aZKfZ/Vslrayz1Kh/uGwexYgcW5AOqGfpZG9C6usgf9/QmHMbrPoXPKuELbk+6usIW
         BjlGpR9bfA52lbolOvVCCdBbvWEAncrJN0b8i4SirBlJfaNXBjrc9OUbeGxanQY9RvMg
         gn99IGZE8ODvBusmpyBshX27Hk1zBuyFclZtrrbzJNaMlK1altRPgafaMkaVQf800+BZ
         A5r6WUm0RmG7tmTGXAEJbQu+Gg5oJHlibpTOW/nMQnFXnsQib1UPfCilJplfO4WVdmgv
         agLsaIEGnFTWMDwcAhcV46c3dWX5HUxIuZ29vef7EHmKBUHcK2N5P1inQtnErzZ0maHv
         5b6g==
X-Gm-Message-State: AOJu0YyGndhMA2NosB03/12Ap8o9xIkuxviclMxnHDemcpo97y/NDD1o
	rYWT3Xn1ikPFPWSeQVvLTVjf4f6h+sNB9w==
X-Google-Smtp-Source: AGHT+IFoMF7iBEApNoQlLYroD9xomsTzk8f3xeyoQX711SXoV3x+eo2aI5C8JVDK5dlDhdyFZLhwdQ==
X-Received: by 2002:a17:902:a711:b0:1d3:cf95:fd4b with SMTP id w17-20020a170902a71100b001d3cf95fd4bmr5724707plq.6.1705162311333;
        Sat, 13 Jan 2024 08:11:51 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903005200b001d49c061804sm5015559pla.202.2024.01.13.08.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jan 2024 08:11:50 -0800 (PST)
Message-ID: <29108779-92d0-40dc-a259-72a24ad5d385@kernel.dk>
Date: Sat, 13 Jan 2024 09:11:49 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Crash in NVME tracing on 5.10LTS
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: John Sperbeck <jsperbeck@google.com>, Bean Huo <beanhuo@micron.com>,
 Sagi Grimberg <sagi@grimberg.me>, khazhy@google.com, stable@vger.kernel.org
References: <20240109181722.228783-1-jsperbeck@google.com>
 <2024011150-twins-humorist-e01d@gregkh>
 <CAFNjLiVJ0OKp7kKsNTr-mCJvG+dkYis2F1fE==Fhz65eZfT+aQ@mail.gmail.com>
 <eec063eb-853a-40ac-b0f6-ce14da5b3c6a@kernel.dk>
 <2024011314-debtless-clunky-ea56@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024011314-debtless-clunky-ea56@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/24 2:34 AM, Greg KH wrote:
> On Thu, Jan 11, 2024 at 12:38:03PM -0700, Jens Axboe wrote:
>> On 1/11/24 10:00 AM, John Sperbeck wrote:
>>> On Thu, Jan 11, 2024 at 1:46?AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Tue, Jan 09, 2024 at 10:17:22AM -0800, John Sperbeck wrote:
>>>>> With 5.10LTS (e.g., 5.10.206), on a machine using an NVME device, the
>>>>> following tracing commands will trigger a crash due to a NULL pointer
>>>>> dereference:
>>>>>
>>>>> KDIR=/sys/kernel/debug/tracing
>>>>> echo 1 > $KDIR/tracing_on
>>>>> echo 1 > $KDIR/events/nvme/enable
>>>>> echo "Waiting for trace events..."
>>>>> cat $KDIR/trace_pipe
>>>>>
>>>>> The backtrace looks something like this:
>>>>>
>>>>> Call Trace:
>>>>>  <IRQ>
>>>>>  ? __die_body+0x6b/0xb0
>>>>>  ? __die+0x9e/0xb0
>>>>>  ? no_context+0x3eb/0x460
>>>>>  ? ttwu_do_activate+0xf0/0x120
>>>>>  ? __bad_area_nosemaphore+0x157/0x200
>>>>>  ? select_idle_sibling+0x2f/0x410
>>>>>  ? bad_area_nosemaphore+0x13/0x20
>>>>>  ? do_user_addr_fault+0x2ab/0x360
>>>>>  ? exc_page_fault+0x69/0x180
>>>>>  ? asm_exc_page_fault+0x1e/0x30
>>>>>  ? trace_event_raw_event_nvme_complete_rq+0xba/0x170
>>>>>  ? trace_event_raw_event_nvme_complete_rq+0xa3/0x170
>>>>>  nvme_complete_rq+0x168/0x170
>>>>>  nvme_pci_complete_rq+0x16c/0x1f0
>>>>>  nvme_handle_cqe+0xde/0x190
>>>>>  nvme_irq+0x78/0x100
>>>>>  __handle_irq_event_percpu+0x77/0x1e0
>>>>>  handle_irq_event+0x54/0xb0
>>>>>  handle_edge_irq+0xdf/0x230
>>>>>  asm_call_irq_on_stack+0xf/0x20
>>>>>  </IRQ>
>>>>>  common_interrupt+0x9e/0x150
>>>>>  asm_common_interrupt+0x1e/0x40
>>>>>
>>>>> It looks to me like these two upstream commits were backported to 5.10:
>>>>>
>>>>> 679c54f2de67 ("nvme: use command_id instead of req->tag in trace_nvme_complete_rq()")
>>>>> e7006de6c238 ("nvme: code command_id with a genctr for use-after-free validation")
>>>>>
>>>>> But they depend on this upstream commit to initialize the 'cmd' field in
>>>>> some cases:
>>>>>
>>>>> f4b9e6c90c57 ("nvme: use driver pdu command for passthrough")
>>>>>
>>>>> Does it sound like I'm on the right track?  The 5.15LTS and later seems to be okay.
>>>>>
>>>>
>>>> If you apply that commit, does it solve the issue for you?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> The f4b9e6c90c57 ("nvme: use driver pdu command for passthrough")
>>> upstream commit doesn't apply cleanly to 5.10LTS.  If I adjust it to
>>> fit, then the crash no longer occurs for me.
>>>
>>> A revert of 706960d328f5 ("nvme: use command_id instead of req->tag in
>>> trace_nvme_complete_rq()") from 5.10LTS also prevents the crash.
>>>
>>> My leaning would be for a revert from 5.10LTS, but I think the
>>> maintainers would have better insight then me.  It's also possible
>>> that this isn't serious enough to worry about in general.  I don't
>>> really know.
>>
>> Either solution is fine with me, doesn't really matter. I was wondering
>> how this ended up in stable, and it looks like it was one of those
>> auto-selections... Those seem particularly dangerous the further back
>> you go.
> 
> Now reverted, thanks.  But note, that commit does say it fixes an issue
> this far back, which is why it was applied.

Yeah, looking into it, I can see how this was applied. And hard to know
not to, it's one of those boundary conditions that may happen for stable
backports and that only the ones intimate with the nvme code will spot.
Just one of those things, I think.

-- 
Jens Axboe


