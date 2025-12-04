Return-Path: <stable+bounces-199989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0418CA333E
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 11:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17A9530A912F
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039BB2D839D;
	Thu,  4 Dec 2025 10:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOgGBDrF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVrLqzx9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765225CC40
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843305; cv=none; b=Uqh0GF0XubA2Ap8CKlVSRZXf/T+8spb75WAZlK3SWfXUZbf+rWtlECL209rb0z3kfbgU956JU7Pcxj+UUQWCBNM4KSucPm8C023kVBawR/qyDYlUfK8nG3CutqB0qG75D1eefXtGfFUW34T7piytM/1Jo9rEqN9mT07+DOD6Fos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843305; c=relaxed/simple;
	bh=xhd7INMoLHdoH3FWmXgpLtLaPcTA2LlwpZBk1Efmb3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrltzah2vyaxz5jjPsVlWCNUqsQmjyEpnVkUbp9hheq+8SazwUdaFWt2vGorr4lJUvh5ypJOx8fvgdr11+QwL5cWnGU7o6X9SOF1Qvf+82s4rt3jKnQMOMW790vtjOKkTHlc+HC4Aofts+wRqvgjqj9NdnepQRclf3PdWfykOmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOgGBDrF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVrLqzx9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764843286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B2LO/5zMJ3eLj3Ui7KfIU89YlIB8J5UWNviyBiKbRQQ=;
	b=BOgGBDrFk86tJVIPHSxapa+Pwq6q5EltNwFxor1qYQn/kkepWw4Cj90ozYj+QFltTjTlSn
	jww0KrsTrf/3gn1gMCGWI4QSQiWZCfFNqUSTRfzrQtQxf5n8qdwgnyw47U9BbQ+9e9BtPs
	t9cz+ud+UFGZ6W3/Z6CwgPl1Gie9KfE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-yrepTRwvOKKA88YF6gXzcg-1; Thu, 04 Dec 2025 05:14:45 -0500
X-MC-Unique: yrepTRwvOKKA88YF6gXzcg-1
X-Mimecast-MFC-AGG-ID: yrepTRwvOKKA88YF6gXzcg_1764843284
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42e2d5e833fso404445f8f.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764843284; x=1765448084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2LO/5zMJ3eLj3Ui7KfIU89YlIB8J5UWNviyBiKbRQQ=;
        b=AVrLqzx9q7r+hzFoQU+deY8J+HR7gCPGlVcXAnpP8W/p1NfsIBV4r2VDMVF20ZV2nX
         p4+1rkqXZUWaXPN6nFLYSLyP/pl1cLRuKrHovCC+sVm0WaJx1J9BS+tSlBol6XCxO6Vl
         sV+jcAhnCma2376MtXwV+rxGFbUZuFw+kx/9Nq/KrQMOjBz0ovCtcPSTjZgpdJetgxqm
         VNHWkwL0f7PxhyceygmQP0uvWdo7Uc42Fni3l+5W/IHlm+D3OdbV7aOcAdi45amXv9HB
         piiW3/3wV53BydDTEe0rKMRr3zuK1Qk/58rZvKSL83AaUqi927eg14uRUbBR09CFEk/T
         5q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764843284; x=1765448084;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2LO/5zMJ3eLj3Ui7KfIU89YlIB8J5UWNviyBiKbRQQ=;
        b=IIiU+x14lVJQaSgiLRfKS0AZ0q04RRBLfteCgvLYzl14Qephfp13EymNb49lBdJFlx
         gHT5sJwSyxeTXzGv6obJ+u670IKWPukNGlYhdmJaO9cnQwBcchHRrWp0zXOOY9U3T/jK
         CCToozeT9aK4kfa+l/X9zY3n+Kuju9cjERVRq5BnV4edEoaIVbb84dAtt0UE8xZN/rtM
         Kj4LFNMWLo5YdlE7EHHbYMsyW4tksB27ltOb0vnmuaMor5d2mfT1kYvj86kQxX1dnIRM
         fyfChIXtB86pbPOL0EOOflfIsGPfZjsvroi+KMyrontH0UuZlXwylPuBTFso2HYOoKph
         l/0w==
X-Forwarded-Encrypted: i=1; AJvYcCXWibXUYZb2sUlEskBuO/6CrK5pfEVnTpTUQ6n1RS3eUIg5aFLBcqL0mH1Yo2tqEL3B6ov0Qlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedwYE2Q10JzTmNIKAnPNIPH9vfrg8+0WzlyAsnOCnqDUS8n3+
	Rb8YurBk+ci4nwDqO4XYwRNcMI8P83UR95+gdhlqjjrCqP4Qw83jjIxs/JGULdlwGKG1yxwMlTd
	9PTTPaqWR7s2NMGv68RtaIoGfX7xnwS8qwvHxk+5RxK4aHMGCwUCtH8oiuA==
X-Gm-Gg: ASbGncvM+d3Sn/p2xAjjVFQLpVfV5oI/g1bBy+9Hp3NAygigu8sPYQv0JisHEUVsnM1
	16iTEli432qXloRWFZ047noI+s/8ttHXzRLHWhCmkKecLCy8r0vHmkFgo9UDvCApnOrq2dmiaBm
	AVUtKspIWOD6m5ymg4AeHYPSvmUgrm4VOPDdDj0UT5JC34jqssug3aOeMHg4UBjUCbPajVa8NMr
	6f51G5fPRoq1YeAUY/Xm2pVQhDWoHIexae9ES2AyqTszwd2T4xlOproSK4Ex1MlcGI3kNPZWFor
	Qc3Kn72bq5OrslptPrVjq5u+AF8z8lv+96T5G8jR4qi3pPIreVe/H4KUqDxzDkF79/vWxpxzg8w
	Krrxs0KXAw010
X-Received: by 2002:a05:6000:288d:b0:429:ed90:91dd with SMTP id ffacd0b85a97d-42f7318fba9mr5515257f8f.6.1764843284399;
        Thu, 04 Dec 2025 02:14:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElN+HcBRl5XnGi3Kq56b7oNXxUHDspypS/DGIK1WJzMIYiUYTR5XfdZw0bq/l6K1JvBbLQxg==
X-Received: by 2002:a05:6000:288d:b0:429:ed90:91dd with SMTP id ffacd0b85a97d-42f7318fba9mr5515219f8f.6.1764843283891;
        Thu, 04 Dec 2025 02:14:43 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeb38sm2319668f8f.12.2025.12.04.02.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 02:14:43 -0800 (PST)
Message-ID: <a36e79d0-c5b7-4487-bdfc-cdaf1b67efed@redhat.com>
Date: Thu, 4 Dec 2025 11:14:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/hsr: fix NULL pointer dereference in
 prp_get_untagged_frame()
To: Felix Maurer <fmaurer@redhat.com>, Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
 Arvid Brodin <arvid.brodin@alten.se>, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 khalid@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20251129093718.25320-1-ssrane_b23@ee.vjti.ac.in>
 <aTBAp3axHXSkrYKO@thinkpad>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aTBAp3axHXSkrYKO@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/25 2:52 PM, Felix Maurer wrote:
> On Sat, Nov 29, 2025 at 03:07:18PM +0530, Shaurya Rane wrote:
>> prp_get_untagged_frame() calls __pskb_copy() to create frame->skb_std
>> but doesn't check if the allocation failed. If __pskb_copy() returns
>> NULL, skb_clone() is called with a NULL pointer, causing a crash:
>> Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN NOPTI
>> KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
>> CPU: 0 UID: 0 PID: 5625 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full)
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>> RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
>> Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 23 29 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
>> RSP: 0018:ffffc9000d00f200 EFLAGS: 00010207
>> RAX: ffffffff892235a1 RBX: 0000000000000000 RCX: ffff88803372a480
>> RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
>> RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
>> R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
>> R13: 0000000000000820 R14: 000000000000000f R15: ffff88805144cc00
>> FS:  0000555557f6d500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000555581d35808 CR3: 000000005040e000 CR4: 0000000000352ef0
>> Call Trace:
>>  <TASK>
>>  hsr_forward_do net/hsr/hsr_forward.c:-1 [inline]
>>  hsr_forward_skb+0x1013/0x2860 net/hsr/hsr_forward.c:741
>>  hsr_handle_frame+0x6ce/0xa70 net/hsr/hsr_slave.c:84
>>  __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
>>  __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
>>  __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
>>  netif_receive_skb_internal net/core/dev.c:6278 [inline]
>>  netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
>>  tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
>>  tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
>>  tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
>>  new_sync_write fs/read_write.c:593 [inline]
>>  vfs_write+0x5c9/0xb30 fs/read_write.c:686
>>  ksys_write+0x145/0x250 fs/read_write.c:738
>>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> RIP: 0033:0x7f0449f8e1ff
>> Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
>> RSP: 002b:00007ffd7ad94c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
>> RAX: ffffffffffffffda RBX: 00007f044a1e5fa0 RCX: 00007f0449f8e1ff
>> RDX: 000000000000003e RSI: 0000200000000500 RDI: 00000000000000c8
>> RBP: 00007ffd7ad94d20 R08: 0000000000000000 R09: 0000000000000000
>> R10: 000000000000003e R11: 0000000000000293 R12: 0000000000000001
>> R13: 00007f044a1e5fa0 R14: 00007f044a1e5fa0 R15: 0000000000000003
>>  </TASK>
>> Add a NULL check immediately after __pskb_copy() to handle allocation
>> failures gracefully.
> 
> Thank you, the fix looks good to me. Just a small nit pick (this can
> probably be done when applying): please add the empty lines around the
> trace again. Other than that:
> 
> Reviewed-by: Felix Maurer <fmaurer@redhat.com>
> Tested-by: Felix Maurer <fmaurer@redhat.com>

No need to repost: I'll adjust that while applying the patch.

Thanks!

/P


