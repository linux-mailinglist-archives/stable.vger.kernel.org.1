Return-Path: <stable+bounces-233476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DdBBJlT1GnhtAcAu9opvQ
	(envelope-from <stable+bounces-233476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:45:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDF83A8800
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 02:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BAA83012239
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 00:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789831DE4FB;
	Tue,  7 Apr 2026 00:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cS4Wm063";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+pYarDB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938AB14A62B
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775522710; cv=none; b=cnyaMkSZUupkdnafcB8KBV/6od2s3di1ykxHBGW/90ZE9ZDcwbqozLD9G/JIQiYwfIcRC7yiGS4/OcYgrSUR5/7KE9AhBb/II0cUp151x0rZ0aDY5mo2fn/5yvS+0TXPNSzVINiOaHQ+k7IHTF4qvpHNEOsoNuTdWJeX4gjKP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775522710; c=relaxed/simple;
	bh=MLDrVV6k3fWCuF1WahCiklT5sWZ3vORf6BtnfH9zskA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsobeH7ml2mZ5plxIWp727MuGne8An0ugf9xvmLreWYPudrddjelzMlmR0UojTBxRNy+MI9KPDl3vIgJGm3XVzDAs2VkM+78CSLOMuAbOrKmMp+SCPcq9V3foM6LA2SApkH/0sN/czM1evn9rfoeWxGD25G9FSNnu+2kfxaGANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cS4Wm063; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+pYarDB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775522707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAKgvtlNper5lCbakuqzfiLcu5MRQF/fn6jWM++Sjr8=;
	b=cS4Wm063WiGHAtME/MyP1BtSo12Hu20DAPAI57afPEyEzcmhS4/s28L7GmNF2Llgn7AqGU
	NkV86L4iB3F3rH/qIAmsfSLSyNtSgidayN2bGzAWJ9jNZhweWGVxd6/sfbtdoRuifOSXq5
	6QlXz8l0JRFsfJ+g3yCShGq7CbSOMuQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-bZU4-1PfPCqaaso_bALHRg-1; Mon, 06 Apr 2026 20:45:06 -0400
X-MC-Unique: bZU4-1PfPCqaaso_bALHRg-1
X-Mimecast-MFC-AGG-ID: bZU4-1PfPCqaaso_bALHRg_1775522705
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d90c7ec5aso11387461a91.2
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 17:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775522705; x=1776127505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAKgvtlNper5lCbakuqzfiLcu5MRQF/fn6jWM++Sjr8=;
        b=G+pYarDBbeMGHUgwERzLoGABIC2DDDwGxUVUJ1vKqPL2u0Bh7Topdgw07Ooh9yW6q1
         tcq7ZmmfbonMgdN81UCO+iwDkCn1Og/muAhJ2J17lxAhSRDNoPI+Ad/H5yqB05Waz2f9
         AewgRvg+2HxcEEhJ4jSUL77pemXexhobSCFBDAbfzj5vqseK67UX/LSx2FTIM9ZX2b9e
         yfxaSZAxJKRGni7YlvvAINKZ6Y2pqVbXdMxCGbNybbJx1yTawxNJq1UQ1PJdBPZzwjWL
         UwVYOTjYx2GIifNTLsh3gdgRHoJeE2bU8RD6EMjr+xBMQ0K8n0cJ1uaXeiwxkIPPb5/X
         /i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775522705; x=1776127505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAKgvtlNper5lCbakuqzfiLcu5MRQF/fn6jWM++Sjr8=;
        b=CGKF8rv43qUPNfXaRDPRs8xjZ71bn7AkuRPHwQljBN6wQ8uNMKGUBfj0+yz0p3rZMC
         tIdgcKevh7PIrt9FOgZfxV35Aqeuk1+MyOzL7YaRkhuF8GVNQKD483h4BB4dC5oKfVk+
         lIjVq4XUQPnrmTldb8Sp46KeujflhrXYjSSL1hkDJeXkPf0xPFnjPp5kYqj29apVPJL2
         8bx691SrUYKabGa9RlxrupuvgS0S0v0Pktw1w4DZuz2snaX7TgzjUaItUaOCZ4QdGdWL
         4RhWOSMjLJuhAgdURITI/j2/Po9wY853PgUx3qH7QCOH5usehHFYUNZayGKVwU5pACGs
         TVEg==
X-Forwarded-Encrypted: i=1; AJvYcCV3SL04XUsKB/Ns1HUhNYEInxcQmjWLZ/x2t//qTX2dKZBzR3USv+OXWRNeBaodsnCyUNl+qsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7x7JlcIhHQM5RBmRrU8/1HHCNToF9LWn36ti9z0Vnl5a9EYZs
	6XdCDBcTXwTNFKgAxxuk8HG8H4npb9brWcM4LvkGmW3dZo41Xw++RGtdrEAzAm6paMdEkD6AgcY
	j4B9wS9LISRFF5RTM5OIqmhrhDlTCRdXuacuKPMdwCgDR/796TO45bIBlAg==
X-Gm-Gg: AeBDietWAPoEK8h+r6ttduQ4buF9w3UG9p7jk1HmzlYsS8zWlqe9e9S5GrOSx5DCeOc
	e7fWX/+iT5+Cp1syqLoab3AcRAtzRSzF+4jcbpQj6hY4LC34gbnN9PI9viZ/clYW5KsLku45pmF
	IxrXmLE/Wf8a6qgt7I5t8R1gk+XDcPlmw4Ko7WLrT7HXTfZX57J+Lc5ARTj6FDtp3pJXeNi8eCV
	sxFNoSdGZVBHmwkPxx1p+it/MEFOyVeq2FfIqIysmaI6tVuoZXLE3X9IzcRLXQcLb3GFq8Qp5PY
	gTWqu2xpCf2wsxqhjU6tyql7Ka/l+kxHBQp5ZynYPMQgsDel3bwhHyvAd/P758XeWwlag4HDjL6
	FeJuCNFvX0grI
X-Received: by 2002:a17:90a:d2ce:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-35de678fc27mr13201170a91.1.1775522704899;
        Mon, 06 Apr 2026 17:45:04 -0700 (PDT)
X-Received: by 2002:a17:90a:d2ce:b0:35b:8d89:719b with SMTP id 98e67ed59e1d1-35de678fc27mr13201139a91.1.1775522704261;
        Mon, 06 Apr 2026 17:45:04 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe623d94sm20615062a91.7.2026.04.06.17.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 17:45:03 -0700 (PDT)
Date: Tue, 7 Apr 2026 08:44:39 +0800
From: Coiby Xu <coxu@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org, stable@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crash_dump: Fix potential double free and UAF of
 keys_header
Message-ID: <adRIwaLxqIoIDkTF@Rk>
References: <20260403100126.1468200-1-coxu@redhat.com>
 <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <972b9a73-d066-4a38-8a4b-fe7d1ba2944b@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233476-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6CDF83A8800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 07:48:29PM +0530, Sourabh Jain wrote:
>Hello Coiby,

Hi Sourabh,

>
>On 03/04/26 15:31, Coiby Xu wrote:
>>If kexec_add_buffer fails, keys_header will be freed. And depending on
>>/sys/kernel/config/crash_dm_crypt_key/reuse, it will lead to the
>>following two problems if the kexec_file_load syscall is called again,
>>   1. Double free of keys_header if reuse=false
>>   2. UAF of keys_header if reuse=true
>>
>>Address these problems by setting keys_header to NULL after freeing
>>kbuf.buffer and re-building keys_header when necessary respectively.
>>
>>Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>>Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memory hot-plugging")
>>Cc: stable@vger.kernel.org
>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>Reported-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>Signed-off-by: Coiby Xu <coxu@redhat.com>
>>---
>>  kernel/crash_dump_dm_crypt.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>>diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>>index a20d4097744a..92eebef27156 100644
>>--- a/kernel/crash_dump_dm_crypt.c
>>+++ b/kernel/crash_dump_dm_crypt.c
>>@@ -417,7 +417,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  		return -ENOENT;
>>  	}
>>-	if (!is_dm_key_reused) {
>>+	if (!is_dm_key_reused || !keys_header) {
>>  		image->dm_crypt_keys_addr = 0;
>>  		r = build_keys_header();
>>  		if (r)
>>@@ -433,6 +433,7 @@ int crash_load_dm_crypt_keys(struct kimage *image)
>>  	r = kexec_add_buffer(&kbuf);
>>  	if (r) {
>>  		kvfree((void *)kbuf.buffer);
>>+		keys_header = NULL;
>>  		return r;
>>  	}
>>  	image->dm_crypt_keys_addr = kbuf.mem;
>>
>>base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
>
>Sashiko raised seven concerns on this patch. Most of them are
>not directly related to the changes introduced here, but I
>think they can be addressed along with this fix.
>
>https://sashiko.dev/#/patchset/20260403100126.1468200-1-coxu%40redhat.com

Thanks for pointing me to the Sashiko's code review and also sharing
your meticulous analysis!

>
>
>1. build_keys_header() does not release key_header memory on
>   error. This can cause incorrect keys to be loaded for the
>   kdump kernel in subsequent system calls.
>
>Can be addressed by releasing keys_header on error path.

I'll address this issue! Thanks for the suggestion!

>
>2–3. get_keys_header_size() uses key_count to find the size of
>key_header buffer, which can lead to out-of-bounds access
>at two places.
>  a. Around kexec_add_buffer()
>  b. In build_keys_header()
>
>I think there is one more place where this applies is:
>  c. In get_keys_from_kdump_reserved_memory() at memcpy
>
>I agree with solution provided by Sashiko of using keys_header->total_keys
>instead.

Thanks for showing me where out-of-bounds accesses can happen! I'll do
some testing to see if using keys_header->total_keys is sufficient.

>
>4. get_keys_from_kdump_reserved_memory() may run into issues
>   if kexec_crash_image->dm_crypt_keys_addr is larger than a
>   page size during memcpy. Because kmap_local_page only maps
>   one page.
>
>How about moving this in a loop and do map and copy page by page?

Yeah, looping over the pages should be a robust solution.

>
>5. Related to releasing the keyring_ref reference count, but
>   I did not fully understand this concern.

My latest test already covers the case where there are two keys to
iterate over. I'll dig more into keyring_ref to see if Sashiko's
concerns is valid.

>
>6. restore_dm_crypt_keys_to_thread_keyring() does not release
>   previously allocated keys_header, leading to a memory leak.

Thanks for raising the concern! Although we can assume the system will
reboot soon after vmcore dumping is finished, it's better to free
keys_header.

>
>As per kdump.rst, restore was introduced to handle CPU and
>memory hotplug cases. Is it needed when there is no in-kernel
>update to the kdump image on CPU or memory hotplug events?
>
>But in that case, we rely on a udev rule to reload the kdump image
>again.
>
>I am confused about when exactly we need to restore.

To clarify, reuse other than restore is needed for non in-kernel update
when handing CPU/memory hotplugging. Yes, a udev rule is also needed in
this case.

For restore, it's to restore dm-crypt keys in kdump kernel. I'll see if
I can update the documentation to improve clarity.

>
>
>7. Possible memory leak and data races due to concurrent kexec loads.
>
>I think we can ignore this because both kexec system calls are protected
>by the same lock.

I agree, this concern can be dismissed.

>
>I also noticed that kdump.rst still says CONFIG_CRASH_DM_CRYPT is
>only supported on x86_64 for now. With the patch series below,
>this needs to change, right?
>https://lore.kernel.org/all/20260225060347.718905-1-coxu@redhat.com/

Yes, the documentation will need to updated. Thanks for the reminder!

>
>- Sourabh Jain
>
>
>
>

-- 
Best regards,
Coiby


