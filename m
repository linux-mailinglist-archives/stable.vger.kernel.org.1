Return-Path: <stable+bounces-182035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C79BABB0C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 08:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD803AD6B7
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 06:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2962BCF41;
	Tue, 30 Sep 2025 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv2uFgUo"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC97D07D
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214758; cv=none; b=tfHTr0yHT8T/dFF6Z2hjO9ZXi81nKhIHr2+2i+vCvZy0ft/RgXR4PvDTMm01+CX2Pz1jTNybgifs35MC5d7QTcnUImMmA5CXEMK/ENhkv/qAYJ2KvfJYNoTyc2hoy0UY/Rz7RkaEKJzhzNNZLVMasRRzrHsaHdz1t28kb6z7JLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214758; c=relaxed/simple;
	bh=JoBHMz2B+sjw9rguNZd8esTdi3gTDyQjuYPnndRxhgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMejiY8xbDJbTPzjH8pruxf3kBPTH1nkRqpd59X6bsNSpHaVYLgOC9huXHX0QIQI6G7y1LphWBWIz57DojvpxRm4kf+LRXOOJ4cshLUrroE4HN+3yyhsZ9fApA9/kVnWXTgS7pM6R21UR4nEjPq/Ev0e5XriJEhZ9hfl0WRCUOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv2uFgUo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759214755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8AIMq+OlhpyT2npgIFmZrEOK/CbKwyfphzbxq2DUajU=;
	b=dv2uFgUorwq1KIIDAo7MrmdtblYbgq2Eho3vW1uxUvvQjQMdYuNL7SjxM8ruRnHGRv/a05
	ufJTYvFVxggWCVhQqhB6KHvFNgHfoTsKk3In9rp5NSmoSK8D1O84tGwMK7YQvAEbXPnY3X
	78GGAc/I+oziNzsZmCdSzy8fRYNqpxc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-Dl1digfgNsmbbZ2tN0nVsw-1; Tue, 30 Sep 2025 02:45:53 -0400
X-MC-Unique: Dl1digfgNsmbbZ2tN0nVsw-1
X-Mimecast-MFC-AGG-ID: Dl1digfgNsmbbZ2tN0nVsw_1759214752
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f030846a41so3589988f8f.2
        for <stable@vger.kernel.org>; Mon, 29 Sep 2025 23:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759214752; x=1759819552;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AIMq+OlhpyT2npgIFmZrEOK/CbKwyfphzbxq2DUajU=;
        b=YbtCpPF6FYM29+4IZ2oNofsLZLkMtxZFsUMMyFSEx9izaUbzvnkX49bs0d0vcOYYHV
         9fvWRTaBaUj3VjAzYShG5IWxnFtnL74kFVAOL4ldg3VCzJv4ZgyFDEIQRv9rzlGDPXMp
         sf5SZehEFfutdCr79MVRniq9kY6cj2JX/DL8zY/JrWzwyS+NHQCP/wdgAOGkxgzjauL8
         mfENfqmYuntWFN0RvUQpQ0lh39kUC2eYL2XQcMYvBRoV6NzfcQhm8C27a/FaKkvtLvFN
         g+8xClChA5K656OTl1Q2y5z1hm7L5K4tCYf2Y0Ll8Yq7EUzB+MaXuo4l1l0SSPbWhmZL
         c9dA==
X-Forwarded-Encrypted: i=1; AJvYcCWDFKtl4DSfYssK9SWg4LUAhyHrlCg07zZkmQZ/wf0K+EeRAW0Y4O8NcEW83bA46eWYbSjMzvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6336VKOnhZRJnbvjvcPPuEJEFRtC7zDLd24p448QdjLQBj80
	3r1/zCw/ZZbRnBzHbvUl+xJL43cbzM6xTxK50IwVEVWDRbQOrJB/exZfigsVKwo7MbIqu8+l1Jo
	73ZmTdOBWWdecK7PW8PHNsmMvnRTQPyyr8HAuiCnEGTlbrM6+bU0KQE1Jzg==
X-Gm-Gg: ASbGnctgNG7cHhqGaCZkwN/vRrp+P4kx0BQUQqbHAq7NCJDTi+fC9rTGf1+74y0ZBfR
	aS9uOtm/q+/j8FVgwxh02LNCajBrduX15M73cyICnahOVN0jMPaU0ON2hHP4uzUSBNw+15PPZv5
	AZxPKmk+HJDovrBMq11631tIPKyoEOYr16mK/+aWYYC89ZzdEQX3RV2PgUIeJTjVbyu3/3060GN
	rCE+akyMsBjFaXuUbaYxs3VlDwzWLnrJRFPn7efNXmAGbFIu5+4Szakt3gcFSNhCYvnvypx618K
	JYVbu94hUSOPrF2zW/pX+JsRGt7uOhajf2MLo5G79TyzutYUpQ9hZ3Ux1wNRsJomKI1kPncoSYT
	WZ0mjNQDb
X-Received: by 2002:a05:6000:1a89:b0:3ed:a43d:8eba with SMTP id ffacd0b85a97d-40e4b389211mr18844301f8f.52.1759214751624;
        Mon, 29 Sep 2025 23:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg/W6e/I7hHziArdv6ifYggaC+j0tYvxahMU2MCeZ7zKwkNHwGQwxT9opm5ct5RbwIhmPfXQ==
X-Received: by 2002:a05:6000:1a89:b0:3ed:a43d:8eba with SMTP id ffacd0b85a97d-40e4b389211mr18844269f8f.52.1759214751197;
        Mon, 29 Sep 2025 23:45:51 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d? ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c06a9ffsm7025105e9.0.2025.09.29.23.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 23:45:50 -0700 (PDT)
Message-ID: <d25474b8-c340-4546-a41e-60a6ecfc42c3@redhat.com>
Date: Tue, 30 Sep 2025 08:45:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/ksm: fix flag-dropping behavior in ksm_madvise
To: Jakub Acs <acsjakub@amazon.de>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Peter Xu <peterx@redhat.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250930063921.62354-1-acsjakub@amazon.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250930063921.62354-1-acsjakub@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.09.25 08:39, Jakub Acs wrote:
> syzkaller discovered the following crash: (kernel BUG)
> 
> [   44.607039] ------------[ cut here ]------------
> [   44.607422] kernel BUG at mm/userfaultfd.c:2067!
> [   44.608148] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> [   44.608814] CPU: 1 UID: 0 PID: 2475 Comm: reproducer Not tainted 6.16.0-rc6 #1 PREEMPT(none)
> [   44.609635] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   44.610695] RIP: 0010:userfaultfd_release_all+0x3a8/0x460
> 
> <snip other registers, drop unreliable trace>
> 
> [   44.617726] Call Trace:
> [   44.617926]  <TASK>
> [   44.619284]  userfaultfd_release+0xef/0x1b0
> [   44.620976]  __fput+0x3f9/0xb60
> [   44.621240]  fput_close_sync+0x110/0x210
> [   44.622222]  __x64_sys_close+0x8f/0x120
> [   44.622530]  do_syscall_64+0x5b/0x2f0
> [   44.622840]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   44.623244] RIP: 0033:0x7f365bb3f227
> 
> Kernel panics because it detects UFFD inconsistency during
> userfaultfd_release_all(). Specifically, a VMA which has a valid pointer
> to vma->vm_userfaultfd_ctx, but no UFFD flags in vma->vm_flags.
> 
> The inconsistency is caused in ksm_madvise(): when user calls madvise()
> with MADV_UNMEARGEABLE on a VMA that is registered for UFFD in MINOR
> mode, it accidentally clears all flags stored in the upper 32 bits of
> vma->vm_flags.
> 
> Assuming x86_64 kernel build, unsigned long is 64-bit and unsigned int
> and int are 32-bit wide. This setup causes the following mishap during
> the &= ~VM_MERGEABLE assignment.
> 
> VM_MERGEABLE is a 32-bit constant of type unsigned int, 0x8000'0000.
> After ~ is applied, it becomes 0x7fff'ffff unsigned int, which is then
> promoted to unsigned long before the & operation. This promotion fills
> upper 32 bits with leading 0s, as we're doing unsigned conversion (and
> even for a signed conversion, this wouldn't help as the leading bit is
> 0). & operation thus ends up AND-ing vm_flags with 0x0000'0000'7fff'ffff
> instead of intended 0xffff'ffff'7fff'ffff and hence accidentally clears
> the upper 32-bits of its value.
> 
> Fix it by casting `VM_MERGEABLE` constant to unsigned long to preserve
> the upper 32 bits, in case it's needed.
> 
> Note: other VM_* flags are not affected:
> This only happens to the VM_MERGEABLE flag, as the other VM_* flags are
> all constants of type int and after ~ operation, they end up with
> leading 1 and are thus converted to unsigned long with leading 1s.
> 
> Note 2:
> After commit 31defc3b01d9 ("userfaultfd: remove (VM_)BUG_ON()s"), this is
> no longer a kernel BUG, but a WARNING at the same place:
> 
> [   45.595973] WARNING: CPU: 1 PID: 2474 at mm/userfaultfd.c:2067
> 
> but the root-cause (flag-drop) remains the same.
> 
> Fixes: 7677f7fd8be76 ("userfaultfd: add minor fault registration mode")
> Signed-off-by: Jakub Acs <acsjakub@amazon.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xu Xin <xu.xin16@zte.com.cn>
> Cc: Chengming Zhou <chengming.zhou@linux.dev>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
> 
> I looked around the kernel and found one more flag that might be
> causing similar issues: "IORESOURCE_BUSY" - as its inverted version is
> bit-anded to unsigned long fields. However, it seems those fields don't
> actually use any bits from upper 32-bits as flags (yet?).
> 
> I also considered changing the constant definition by adding ULL, but am
> not sure where else that could blow up, plus it would likely call to
> define all the related constants as ULL for consistency. If you'd prefer
> that fix, let me know.
> 
> 
>   mm/ksm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 160787bb121c..c24137a1eeb7 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2871,7 +2871,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>   				return err;
>   		}
>   
> -		*vm_flags &= ~VM_MERGEABLE;
> +		*vm_flags &= ~((unsigned long) VM_MERGEABLE);
>   		break;
>   	}
>   

Wouldn't it be better to just do

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec75..0eaf8af153f98 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -296,7 +296,7 @@ extern unsigned int kobjsize(const void *objp);
  #define VM_MIXEDMAP    0x10000000      /* Can contain "struct page" and pure PFN pages */
  #define VM_HUGEPAGE    0x20000000      /* MADV_HUGEPAGE marked this vma */
  #define VM_NOHUGEPAGE  0x40000000      /* MADV_NOHUGEPAGE marked this vma */
-#define VM_MERGEABLE   0x80000000      /* KSM may merge identical pages */
+#define VM_MERGEABLE   0x80000000ul    /* KSM may merge identical pages */
  
  #ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
  #define VM_HIGH_ARCH_BIT_0     32      /* bit only usable on 64-bit architectures */


And for consistency doing it to all other flags as well? After all we have

	typedef unsigned long vm_flags_t;

-- 
Cheers

David / dhildenb


