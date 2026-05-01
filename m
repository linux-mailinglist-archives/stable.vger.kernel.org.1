Return-Path: <stable+bounces-242564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB0GD7k+9WkzJwIAu9opvQ
	(envelope-from <stable+bounces-242564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 02:00:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C75D4B06B9
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 02:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A17E302E905
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 00:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF38837F8A3;
	Sat,  2 May 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbGHyovq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBBA37B012
	for <stable@vger.kernel.org>; Sat,  2 May 2026 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680007; cv=none; b=L0OUpOKuAhJrzb+RNPDqPjqKW/WbO/5mQkY6M+EPXFkvZD0G5oFP6Kgkamxudbp7Ua913zHezu7uiLXfo8CbIDbHcVt3qpJs5ajQnvYTyERgpXynLiwCRGATAw6Y7l+pGgQjQ4UwPqoZ3tKpkr+TsdwOxcQY6j0aP+lSkSxsBBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680007; c=relaxed/simple;
	bh=plF6X9o4F3co/ajQd71ZJkW+9fqzrvmmBg+CaBUKCWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtKkYbEvVElvAIh52hwxeuQeA1sCil/yHSDf4PNUmupTc3qgt+Ka78RQGrNiONk8ytziAb8Cu4Edpu7vDGCgpPRWVCSBy+aBTyb33okyEbw6zEkkNc/IwA61o6OY1kBfZqyJn3unJMIBx977oSpvRCXeEE/uekn1gNAQWjz/Rso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbGHyovq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so1034455b3a.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 17:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777680006; x=1778284806; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jZbQqiA/fecMgvSQZW2ffEuq3Qf9g5f25sCTnXGKHio=;
        b=UbGHyovqK8epCG2Dk5airsPEOPK3umhQGKisl3dgp5zGD8xMuTZLjaLFIVC/mORGtZ
         lFcsw2A+1iHajToSInzvQgY4d5c5BxBZzt1D7QrMlEGcoQjAzZXDAehNsQ/XSZ0hgyGZ
         tsWvqx7fYk4+6dODmmPcKkh9KirYj2TkDa9/tZd1H+iA8XevVuE6UXKdoEri0irKD5nt
         qWzJ8cKxZyAnFk8LmxAfakwb96jeEmk3/0faqF13V5xZzFIBfq3NAUdQLGjkiI6lFApd
         qLvbdpXYohxqqrR524Qnk+TihE7Jif2zHZ7OgkVGgeKlYZ1ipbXl5sclq/FXZtdFIANO
         cCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777680006; x=1778284806;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jZbQqiA/fecMgvSQZW2ffEuq3Qf9g5f25sCTnXGKHio=;
        b=lR/vNu8SqoqmJ6+UUKptuAxADkTcNZNb+J4Bw8hP/WViwBkBcbgMmo5ocN7vYeiiit
         YavraoPWkINk7So3T6MJoHTbdbyYwGKnwZGLrBsbAdaStb5qN0hrzssWxR2RMZmSuPi3
         x3PqtPi90XYFV9hS4Sb+y+2CR0NwMP7gayZG3a3a46c+Z0+2lLpAmoK7KeFkCuGdnRUa
         TZ7TC5jUzdMzsILcTqIh3wLJdIdadkM0SWukIY81IX65971dpBUQXDxeIvbd5kmOXDjG
         /OXBRmk4MBI8k8ziFeClOeAF0jV4fv2w2j+V2H+JtiaEfFAnQTa1g8UMSwQiUmsuGf2c
         UVmA==
X-Forwarded-Encrypted: i=1; AFNElJ+jP1E6pJkTsNi9xpsVGYg80Ei9irpoSmuaEtwHEKP7rjjVzNsv2DX0X2UPTRAL5kG70ZqpG/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOkuAarffiqKmotEEz9hUEh0IR0R1M4oqthBulBdKfQ+wZNFc
	BnV+uswXIQQYm9lokHJ6DJRHKbBazEN4WW8hqo2LrmlAFTIZj1UsK+RF
X-Gm-Gg: AeBDieulsLzJ7nYt8D5f0EjccTwzL5BXm/IrEjTrj+P8x0Xpf523MbNb8sA6xhKskhH
	BO4KzCgI3Dq/z5TD9ZtEdwIbiQouM0NgLRx7LBev7hKrcG0TS+z+enyNcdYjn7dDA0yt/0++wZd
	ExTGqkssQ2SM4+KVJMqnukrI69Sulzj0Jk0WttMMC7gB+4cXLXPDQ2MSkhl61hLG0K1eso5kyII
	2WuqvU6bTQd7oClz3YqkQDgSOwR3r1BLkYFuCXaUr/x02XZSSiyka2VJpeez0QJg+HCjZab1dlR
	NuaDbAXihFN3AF8jMEXnRRzuZqLoMbQJvmJZ01j07Do9xW1lMVPiSgiPYvmP1UT+tGID72Xpww4
	u0AC0van+SpTYFihRVdkvSTKh7HAXe56sThvJElPDXucFEH1k6dKw9OavEjl6WLvMBwv+VBaBqY
	NyTVMayVyNx8jP+NGMfpPqWaMeeJu7kA==
X-Received: by 2002:a05:6a00:1bc9:b0:82f:4386:7989 with SMTP id d2e1a72fcca58-8352d20264bmr1064459b3a.24.1777680005486;
        Fri, 01 May 2026 17:00:05 -0700 (PDT)
Received: from localhost ([121.237.249.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8351587db67sm3674725b3a.13.2026.05.01.17.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 17:00:04 -0700 (PDT)
Date: Sat, 2 May 2026 07:49:48 +0800
From: Coiby Xu <coiby.xu@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <afU7EcMFfM4PZZfy@Rk>
References: <20260403100126.1468200-1-coxu@redhat.com>
 <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
 <adRIwaLxqIoIDkTF@Rk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adRIwaLxqIoIDkTF@Rk>
X-Rspamd-Queue-Id: 8C75D4B06B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242564-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coibyxu@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]

On Tue, Apr 07, 2026 at 08:44:39AM +0800, Coiby Xu wrote:
>On Fri, Apr 03, 2026 at 07:48:29PM +0530, Sourabh Jain wrote:
>>Hello Coiby,
>
>Hi Sourabh,
>
>>
>>On 03/04/26 15:31, Coiby Xu wrote:
>>>If kexec_add_buffer fails, keys_header will be freed. And depending on
>>>/sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>>following two problems if the kexec_file_load syscall is called again,
>>>  1. Double free of keys_header if reuse=false
>>>  2. UAF of keys_header if reuse=true
>>>
>>>Address these problems by setting keys_header to NULL after freeing
>>>kbuf.buffer and re-building keys_header when necessary respectively.
>>>
>>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>>Cc: stable@vger.kernel.org
>>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>>Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>>---
>>> kernel/crash_dump_dm_crypt.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>>index a20d4097744a..92eebef27156 100644
>>>--- a/kernel/crash_dump_dm_crypt.c
>>>+++ b/kernel/crash_dump_dm_crypt.c
>>>@@ -417,7 +417,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>> 		return -ENOENT;
>>> 	}
>>>-	if (!is_dm_key_reused) {
>>>+	if (!is_dm_key_reused || !keys_header) {
>>> 		image->dm_crypt_keys_addr = 0;
>>> 		r = build_keys_header();
>>> 		if (r)
>>>@@ -433,6 +433,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>> 	r = kexec_add_buffer(&kbuf);
>>> 	if (r) {
>>> 		kvfree((void *)kbuf.buffer);
>>>+		keys_header = NULL;
>>> 		return r;
>>> 	}
>>> 	image->dm_crypt_keys_addr = kbuf.mem;
>>>
>>>base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
>>
>>Sashiko raised seven concerns on this patch. Most of them are
>>not directly related to the changes introduced here, but I
>>think they can be addressed along with this fix.
>>
>>https://sashiko.dev/#/patchset/20260403100126.1468200-1-coxu%40redhat.com
>
>Thanks for pointing me to the Sashiko's code review and also sharing
>your meticulous analysis!
>
>>
>>
[...]
>>
>>4. get_keys_from_kdump_reserved_memory() may run into issues
>>   if kexec_crash_image->dm_crypt_keys_addr is larger than a
>>   page size during memcpy. Because kmap_local_page only maps
>>   one page.
>>
>>How about moving this in a loop and do map and copy page by page?
>
>Yeah, looping over the pages should be a robust solution.

After failing to reproduce the predicted issue, I realized there is no
need for looping page by page because kexec_add_buffer will try to find
a continuous physical memory region. So I dropped this idea in v2. But
thanks for helping me learning something new:)

-- 
Best regards,
Coiby

