Return-Path: <stable+bounces-249619-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EgxKtZ9DGoSiQUAu9opvQ
	(envelope-from <stable+bounces-249619-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:12:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A05812C8
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BCB4304C8A1
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B08326D45;
	Tue, 19 May 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrDkPxvr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDB7280331;
	Tue, 19 May 2026 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202569; cv=none; b=l21zHXrJ+k3nJfYDDeJricHHyGTFbqceXyAzQ0eyGincKrkjOfNdcMSTuYajItyHBYFdxZQf9hZey8A68ka1Bk+md0fI7+FF2wSzMPXJaNbqBl2DeWBIJYaJ65VzAiIi8lVF2A1QatxwNJ36/OPnz3vUul6ZjOoFmBWNF99Owso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202569; c=relaxed/simple;
	bh=q9+qi0pPB4wHF8JR1gEWaEjNcHR8ZBtdrSr/12td2L4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uKPcshv4SQwTRD9oah9JRWSe/4mg8LNf6Dhbyz60oTDpeUc5zd/0wdcMEe6me0+jOfV7XQmUDuvHFvo7Q4jZe+ZqeC1VNNahiO7vrJRd4jVoCOWg57051ltRydmu5JY/R8S5o9HN0z0SgglGwtlXENlS3ZjioZ1AW2HXnnA1DYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrDkPxvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBFDC2BCB3;
	Tue, 19 May 2026 14:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779202568;
	bh=q9+qi0pPB4wHF8JR1gEWaEjNcHR8ZBtdrSr/12td2L4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IrDkPxvrS3HoITD7bVTIvkEOdBQIuDaMjVcV9yvSHmNDfG6ru0Y0TB/aHVgFmrnK4
	 /pNsbcDqwAuB7CqhqlnE7zn5K8kkFOlY1aH/dBnZn3iIBF0IzNuZ1KYAAr+r2sCgVC
	 qWO02j3IXZwGUGTyZq2kBpPMU+XvjcfgeRAXrTcZ8PyOt70oXZCS0zOkqtt1feqCmP
	 J7XB0NUgv7ywjrWj3S3hTwscdxF+zzpgS8R3/WxZD/EENeLok9FPtIJPj4pqtDNuAP
	 zlMqHz2Woc7D+VKUZ8j2q6LoaWm9U7hazvGp5Ykq54R6xNHN/c3BZaeAWvxnhH/tZH
	 HAtJzS/0p2ZDw==
Message-ID: <e26a39da-828f-4b9d-af15-71e827919dba@kernel.org>
Date: Tue, 19 May 2026 16:56:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] module: decompress: check return value of
 module_extend_max_pages()
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Andrii Kuchmenko <capyenglishlite@gmail.com>,
 linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org, dmitry.torokhov@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260518143233.16091-1-capyenglishlite@gmail.com>
 <be6734b9-112e-4e71-9013-1c6dc5f750da@kernel.org>
Content-Language: fr-FR
In-Reply-To: <be6734b9-112e-4e71-9013-1c6dc5f750da@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249619-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 060A05812C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looks like something went wrong with that reponse, so let's try again:


Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>



Le 18/05/2026 à 18:21, Christophe Leroy (CS GROUP) a écrit :
> 
> 
> Le 18/05/2026 à 16:32, Andrii Kuchmenko a écrit :
>> [Vous ne recevez pas souvent de courriers de 
>> capyenglishlite@gmail.com. Découvrez pourquoi ceci est important à 
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> module_extend_max_pages() calls kvrealloc() internally and returns
>> -ENOMEM on allocation failure. The return value is never checked.
>> The decompression loop then continues calling module_get_next_page(),
>> which writes struct page pointers into info->pages[]. When used_pages
>> reaches the stale max_pages value (not updated due to the failed
>> extend), a subsequent write to info->pages[used_pages++] goes out of
>> bounds into adjacent heap memory.
>>
>> Adjacent slab objects in the same kmalloc cache (pipe_buffer,
>> seq_operations, cred) can be corrupted, potentially leading to local
>> privilege escalation on kernels without SLAB_VIRTUAL mitigation.
>>
>> The call order in finit_module() is:
>>
>>    module_decompress()    <- vulnerable, runs FIRST
>>    load_module()
>>      module_sig_check()   <- signature check, runs SECOND
>>
>> Decompression happens before signature verification. A crafted
>> compressed module submitted via finit_module(MODULE_INIT_COMPRESSED_FILE)
>> reaches this code path before any signature gate is applied. On kernels
>> with module.sig_enforce=0 (default without SecureBoot) or with
>> unprivileged user namespaces (Ubuntu, Debian default), this is
>> reachable without CAP_SYS_MODULE.
>>
>> Confirmed present in mainline (tested on v6.14-rc3).
>>
>> Fix: add the missing error check after module_extend_max_pages() and
>> return immediately on failure. This matches the pattern used by every
>> other kvrealloc() caller in the module loading path.
>>
>> Fixes: 169a58ad824d ("module: add in-kernel support for decompressing")
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Andrii Kuchmenko <capyenglishlite@gmail.com>
>> ---
>> Changes in v2:
>>   - Remove unnecessary initialization of 'error' to 0 (Christophe Leroy)
>>   - Remove unrelated blank line after if (error) return error 
>> (Christophe Leroy)
>>
>>   kernel/module/decompress.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
>> --- a/kernel/module/decompress.c
>> +++ b/kernel/module/decompress.c
>> @@ -XXX,9 +XXX,12 @@ int module_decompress(struct load_info *info,
>>                                  const void *buf, size_t size)
>>   {
>>          unsigned int n_pages;
>>          int error;
>>          ssize_t data_size;
>>
>>          n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
>>          error = module_extend_max_pages(info, n_pages);
>> +       if (error)
>> +               return error;
>>          data_size = MODULE_DECOMPRESS_FN(info, buf, size);
>>          if (data_size < 0) {
>>                  error = data_size;
>> -- 
>> 2.39.0
> 
> 


