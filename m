Return-Path: <stable+bounces-215734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNmeMWTai2lIcAAAu9opvQ
	(envelope-from <stable+bounces-215734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 02:24:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D33AA120746
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 02:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 261DD3013953
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 01:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB47286415;
	Wed, 11 Feb 2026 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="b86/g32+"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84666285061;
	Wed, 11 Feb 2026 01:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770773087; cv=none; b=XfhVtwaLaJwhjyBr0W86IroKTUahLdy1G5niX/hjed7WmJspL3x5FqrcTGrLLY4x5WygIgu1A9Jgoi0qbZ/vWr9d9dyW/JkS52gSl4jQdZetlH9bp1ADfcUCYKtucyYs9inRipIgZVK8rONLB7i5TAkUGZ+RgY2v9yVN7OZUkds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770773087; c=relaxed/simple;
	bh=VZw11mAnIHFM71gWThJobMmVmweJG9NUQgyzLaGGqec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6tHYOiPUdnPzUPiUEOhnv7goO6Dw26oCklfnmf77AikSyjZVzLImGRlJ3oyIl81Pvh++KeVJR4STEixteePPBcn7Yn3+SOQJz0RnYVn1uh7VlX0Ce8Ek4Jji856ck5pIAcz5X+MURQPsi+QqhjVF1qMCkb0AG9M8cGTYUoC2po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=b86/g32+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+M
	nDmV5IQu/jnXX+pmPU4nJ4kwJNeE3fTXXAd2vIReY=; b=b86/g32+FT4tra5Zfh
	v4CunaMUZab3+RGQnBJb3CR5/vASUYw3wrGhdN0qoK7D2vF5R0A6MDTVxNYlug05
	XlObd8HIgY2u6o7KCIHbYwyeKPD0g5rFunf+hPlIDKU74f9KVBfFWmerb2yLH8gy
	cdIO0xn1JnPe0WP7LoitnFpMw=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBHL1Yj2otp2VksLA--.37135S2;
	Wed, 11 Feb 2026 09:23:47 +0800 (CST)
From: ranxiaokai627@163.com
To: pratyush@kernel.org
Cc: akpm@linux-foundation.org,
	graf@amazon.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	rppt@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH -next 1/2] kho: fix missing early_memunmap() call in kho_populate()
Date: Wed, 11 Feb 2026 01:23:46 +0000
Message-ID: <20260211012346.208225-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2vxzv7g4sof5.fsf@kernel.org>
References: <2vxzv7g4sof5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHL1Yj2otp2VksLA--.37135S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7try3tr18Gw45uFy5GF15urg_yoW8tr4kpF
	WrGa1jkw48tayjqa12gF12934Fgw4ktw1fta4UAa4fJF1DZrnaq3yxGa40vFnrXr1S93WS
	yF4vqayfW3WkCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUpVbDUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbC7gP7SGmL2iPjdwAA3R
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux-foundation.org,amazon.com,lists.infradead.org,vger.kernel.org,kvack.org,soleen.com,zte.com.cn,163.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215734-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranxiaokai627@163.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email]
X-Rspamd-Queue-Id: D33AA120746
X-Rspamd-Action: no action

>Hi Ran,
>
>Thanks for the fix.
>
>On Fri, Feb 06 2026, ranxiaokai627@163.com wrote:
>
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>
>> kho_populate() returns without calling early_memunmap() on success
>> path, this will cause early ioremap virtual address space leak.
>>
>> Fixes: b50634c5e84a ("kho: cleanup error handling in kho_populate()")
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>>
>> b50634c5e84a ("kho: cleanup error handling in kho_populate()")
>> has not landed in upstream, so
>> Cc: <stable@vger.kernel.org> is unnecessary?
>>
>>  kernel/liveupdate/kexec_handover.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index fb3a7b67676e..76b714db175d 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -1463,6 +1463,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>>  	struct kho_scratch *scratch = NULL;
>>  	phys_addr_t mem_map_phys;
>>  	void *fdt = NULL;
>> +	int populated = 0;
>
>Nit: Please use a bool and true/false. I think it reads much nicer.

yes.

>>  	int err;
>>  
>>  	/* Validate the input FDT */
>> @@ -1529,16 +1530,17 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>>  	kho_in.scratch_phys = scratch_phys;
>>  	kho_in.mem_map_phys = mem_map_phys;
>>  	kho_scratch_cnt = scratch_cnt;
>> -	pr_info("found kexec handover data.\n");
>>  
>> -	return;
>> +	populated = 1;
>> +	pr_info("found kexec handover data.\n");
>>  
>>  err_unmap_scratch:
>>  	early_memunmap(scratch, scratch_len);
>>  err_unmap_fdt:
>>  	early_memunmap(fdt, fdt_len);
>>  err_report:
>
>Nit: now that this code can be reached by non-error paths, we should
>re-name the labels. I think dropping the "err_" prefix should be enough.

Thanks for your review.
Very helpful suggestion. I will send a v2.

>With these fixed,
>
>Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
>> -	pr_warn("disabling KHO revival\n");
>> +	if (!populated)
>> +		pr_warn("disabling KHO revival\n");
>>  }
>>  
>>  /* Helper functions for kexec_file_load */


