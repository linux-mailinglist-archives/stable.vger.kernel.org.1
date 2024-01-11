Return-Path: <stable+bounces-10536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6982B541
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 20:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250FE1F26465
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192555E4C;
	Thu, 11 Jan 2024 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GPQELZ5d"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261D353E16
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-360576be804so3541585ab.0
        for <stable@vger.kernel.org>; Thu, 11 Jan 2024 11:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705001885; x=1705606685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnFwFbkAikblbLT9tn/zGUorZlUhk9IO39A1Via1qFU=;
        b=GPQELZ5daNarhrLKgySstTAoaEHqrYmCcP7WE9U0RxiQ00d9UUXjJQ0yaBqzc8Bqzp
         yOg0jYTx1kjToXeGBY4tdCMlj4xkglPzEvoEpnR0EvV9j7umn56lYg2sEMR8M7S21Tf9
         MpOKxxKQ1P+kiy+BKGcnh6RYqH9u0ps2ux4JnKBllVH+Z5tWiU95kyzMPIg2i1Mksdn7
         OQKajQurSGaK7P5kXddznoSbkhP4atVcBWIp2ruhmONGxYZUbazxf0t06uM8h5jo9DFj
         2z7vOUYcYSgPrw5gUG3uyDoEI9q35HmgcK+vfHDXkuIL5DYVG+yhGQ8HT06VFHtBnujQ
         k+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705001885; x=1705606685;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnFwFbkAikblbLT9tn/zGUorZlUhk9IO39A1Via1qFU=;
        b=wcssumKe+W36WR9P/5FmYy5ySvEnw8O+MbtFYq6gDJJqmTrhYP66Jp8pGxjU/Gpn37
         YuPeZKMFAzOxFQhdaxuKVNVtVSIhb+nzY+CgExUtlplYuM1HHFY5yV1TBMpjbiJ0i3Ky
         0IRAB1oqhGnpmBGgUMJZiXR5eOZRtGBStAxmO3BmIhGXWdYbpEv/v0i8OJSA0RLJDrHK
         liAGv9k4BdfVekkuTsKhgn1tFwJbKeFGv2Y2Yo3kXiZ2PjVbUR4gBPXxbK+y+zO+mcMX
         JmFabcqD/OEHNbY/ryuyErTycUejptxBb/52xBARf9IszayzGTWle7Wsst7Vmq6GPTDV
         aoxg==
X-Gm-Message-State: AOJu0YyAY56YJCLmGcljrKn06TFBHWtBa9lpOWSrIUtICzlzBTS48trK
	kegC9vQ0quLSRZRmNaE/jVtkAtoAETiMbA==
X-Google-Smtp-Source: AGHT+IEnwBmRrqBHbjlYwlHbR62zmvzQU+Ho9fDPqbi2IK34qYp2FVKY6xFoUVkT1mDFN5ku9qCLWg==
X-Received: by 2002:a05:6602:1799:b0:7bf:f20:2c78 with SMTP id y25-20020a056602179900b007bf0f202c78mr292297iox.1.1705001885147;
        Thu, 11 Jan 2024 11:38:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id cq9-20020a056638478900b00469328386c8sm481037jab.162.2024.01.11.11.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 11:38:04 -0800 (PST)
Message-ID: <eec063eb-853a-40ac-b0f6-ce14da5b3c6a@kernel.dk>
Date: Thu, 11 Jan 2024 12:38:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Crash in NVME tracing on 5.10LTS
Content-Language: en-US
To: John Sperbeck <jsperbeck@google.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Bean Huo <beanhuo@micron.com>, Sagi Grimberg <sagi@grimberg.me>,
 khazhy@google.com, stable@vger.kernel.org
References: <20240109181722.228783-1-jsperbeck@google.com>
 <2024011150-twins-humorist-e01d@gregkh>
 <CAFNjLiVJ0OKp7kKsNTr-mCJvG+dkYis2F1fE==Fhz65eZfT+aQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFNjLiVJ0OKp7kKsNTr-mCJvG+dkYis2F1fE==Fhz65eZfT+aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 10:00 AM, John Sperbeck wrote:
> On Thu, Jan 11, 2024 at 1:46?AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, Jan 09, 2024 at 10:17:22AM -0800, John Sperbeck wrote:
>>> With 5.10LTS (e.g., 5.10.206), on a machine using an NVME device, the
>>> following tracing commands will trigger a crash due to a NULL pointer
>>> dereference:
>>>
>>> KDIR=/sys/kernel/debug/tracing
>>> echo 1 > $KDIR/tracing_on
>>> echo 1 > $KDIR/events/nvme/enable
>>> echo "Waiting for trace events..."
>>> cat $KDIR/trace_pipe
>>>
>>> The backtrace looks something like this:
>>>
>>> Call Trace:
>>>  <IRQ>
>>>  ? __die_body+0x6b/0xb0
>>>  ? __die+0x9e/0xb0
>>>  ? no_context+0x3eb/0x460
>>>  ? ttwu_do_activate+0xf0/0x120
>>>  ? __bad_area_nosemaphore+0x157/0x200
>>>  ? select_idle_sibling+0x2f/0x410
>>>  ? bad_area_nosemaphore+0x13/0x20
>>>  ? do_user_addr_fault+0x2ab/0x360
>>>  ? exc_page_fault+0x69/0x180
>>>  ? asm_exc_page_fault+0x1e/0x30
>>>  ? trace_event_raw_event_nvme_complete_rq+0xba/0x170
>>>  ? trace_event_raw_event_nvme_complete_rq+0xa3/0x170
>>>  nvme_complete_rq+0x168/0x170
>>>  nvme_pci_complete_rq+0x16c/0x1f0
>>>  nvme_handle_cqe+0xde/0x190
>>>  nvme_irq+0x78/0x100
>>>  __handle_irq_event_percpu+0x77/0x1e0
>>>  handle_irq_event+0x54/0xb0
>>>  handle_edge_irq+0xdf/0x230
>>>  asm_call_irq_on_stack+0xf/0x20
>>>  </IRQ>
>>>  common_interrupt+0x9e/0x150
>>>  asm_common_interrupt+0x1e/0x40
>>>
>>> It looks to me like these two upstream commits were backported to 5.10:
>>>
>>> 679c54f2de67 ("nvme: use command_id instead of req->tag in trace_nvme_complete_rq()")
>>> e7006de6c238 ("nvme: code command_id with a genctr for use-after-free validation")
>>>
>>> But they depend on this upstream commit to initialize the 'cmd' field in
>>> some cases:
>>>
>>> f4b9e6c90c57 ("nvme: use driver pdu command for passthrough")
>>>
>>> Does it sound like I'm on the right track?  The 5.15LTS and later seems to be okay.
>>>
>>
>> If you apply that commit, does it solve the issue for you?
>>
>> thanks,
>>
>> greg k-h
> 
> The f4b9e6c90c57 ("nvme: use driver pdu command for passthrough")
> upstream commit doesn't apply cleanly to 5.10LTS.  If I adjust it to
> fit, then the crash no longer occurs for me.
> 
> A revert of 706960d328f5 ("nvme: use command_id instead of req->tag in
> trace_nvme_complete_rq()") from 5.10LTS also prevents the crash.
> 
> My leaning would be for a revert from 5.10LTS, but I think the
> maintainers would have better insight then me.  It's also possible
> that this isn't serious enough to worry about in general.  I don't
> really know.

Either solution is fine with me, doesn't really matter. I was wondering
how this ended up in stable, and it looks like it was one of those
auto-selections... Those seem particularly dangerous the further back
you go.

-- 
Jens Axboe


