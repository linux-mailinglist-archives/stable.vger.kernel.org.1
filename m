Return-Path: <stable+bounces-223295-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KMUOZ02qml+NQEAu9opvQ
	(envelope-from <stable+bounces-223295-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:06:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F5D21A778
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 03:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E001B3053B8F
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 02:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7485132B98D;
	Fri,  6 Mar 2026 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddWvLvvT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rpWk4H4G"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99030DD11
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762762; cv=none; b=bq7vbixkZ/2qnedB7M2nMKPn1OnwxKr0UJo3qOIriOy0KrvO9LnRNM8JfuH9klL/FDVRyapGDy1DTh9PlC2uYXHK5qb3yT7bOg7zbzC661dJ+j+nZedQ9EI/Kwb5+ReLzeauzA3dHwHX0FvP49mucoXNQMMwcuFQ4ryjT5sJSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762762; c=relaxed/simple;
	bh=nsKQ37saL2v30eJ8dxlprdP8ilkf6sMcjRw0O5R9hfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2WasUjq2b5tzEg4HolvU/JVZsCm6S/STS2okNRpqjeKMALNiBG2mpIWVhMclSYr7uM5SUryreFgh0YQv8gmt4sAMnMD6GLj1OqTbtB5LYEDGjYgc80IqRl/rmdI7+eu4hkYjzud2ivDMiiUq7U373nH9l0PGDvHlZPXR1m4VlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddWvLvvT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rpWk4H4G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772762758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ku+fyGp/YTBjGS772gug0NvDgqgMuQqPxeBeDkG1f5g=;
	b=ddWvLvvTOx0OZMK4I1h4IsF2+Qgx7Vd/ad0vkBefNBqlLHsy6MePG+u3iZIdoKd/bpPFF4
	Shnn2D0/aF0NOz32TqZUlLJph0dGa2X8r0m7hy9KkvmcAIeNYw5I0dQDZtnI/kE4cGpxoK
	pwZE9IrhcXgNVRkm83DJWiiT9dhuupU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-g8YlpsO_N1yCV94zJevp5Q-1; Thu, 05 Mar 2026 21:05:57 -0500
X-MC-Unique: g8YlpsO_N1yCV94zJevp5Q-1
X-Mimecast-MFC-AGG-ID: g8YlpsO_N1yCV94zJevp5Q_1772762756
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae4e20a414so261959835ad.3
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 18:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772762756; x=1773367556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ku+fyGp/YTBjGS772gug0NvDgqgMuQqPxeBeDkG1f5g=;
        b=rpWk4H4GVnpOwGVAp8xCJCjti+A7b/rQgUg+/af1ZjTJkbK97cFvjx12WpTHhEspWE
         sWaLjuJQG2l8EX2LnRL3Mc1gJfFCLB74xgK3hNqCy8Y3IAycx31cR5KtFWgKs/SCeFPu
         OiqAugixENrckV9vx+RVjL4O5VAfN1wdMFZ96YLqXWiM5U5IW73Sa/Jb04b0jNbTMF4s
         dCX72Qbrl1x0EGKqCjK0+5aBfQRkaaxpRv/SOUxI5tRmlVId7lpknVRGGTr2miIURruZ
         hZBIFqIyuo1ENjc56EA/nFB4viMdIdwmVC0Z/gP0C0NZXjK7Z8c3pKJaFTqKTLRlQ7fM
         +KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772762756; x=1773367556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku+fyGp/YTBjGS772gug0NvDgqgMuQqPxeBeDkG1f5g=;
        b=Y6P+GA14oM85bvj501ONWTYnSxWQ12sxssxMYNp430WY0j4Ab0EGErb6Yf4xApI3u/
         fP9bjiES54SXAVYfXpwLROmhxXRS5BzM0sNnvDvo1hcwv7BPzELwyzDwov6u/zo196/F
         +/N0ZOyNcs4siPNrJxzryOW+mop0WF4ig2+7Dpn97/rEn4FomQgqnrU5iHcu7Mw41MWs
         8BIxrSA8cuGs70X+qTFxBTgV73XKROiNIAuoW7a7GndUYqisqxuxMYiAJvGc79MzAC8v
         chc4JGjXBjlL8NHuZVUenld5kYjXoMD0opZqSST3y58sqkqyalUvoaILlD87ZPbIoUg0
         5fxg==
X-Forwarded-Encrypted: i=1; AJvYcCUKj1JQX4gl4+aKeG/ZmYdd7nYxt1C4n8bSdTBbvafxpq37uUpmQlrX9oSO11n4uyFAX8Evdps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1oiRe76Iy/1POEHO1+1rAuJerjr1HOsOBkXIRlqZ7kJ9nVHV
	ftprb8DL83OrC6cCRsRjsjaBHbRdc5H7llqnNygfPkET0uYKrJtcciM0RCIt59nrZnmjnZbMA+l
	egkMW2ZJOTp2cwVFHIJ63TdEHS6fSj5i3ygqxK0EGMjz+1k/AV47wWTXoLA==
X-Gm-Gg: ATEYQzxq7ubwG0sThWswKuMOEzlA90HQEsP7GXDVEZOTqwprBN7AJx18UBNR0eWTpaF
	hCz5Mebtwu+G0Mbs+4mRAbInS8IivDpUjfCm9WZzHW+9jzFV/c57LvYR8p0CKWhN8C4oDhRvZcv
	baRoaDAlM/e0dHgP/QmYqic4OKrV6fhDsO6wkpuuK8K3vYyB5z/+gawgsWUUxH+AHlcqWig5lOV
	Luk/8aRky9S30MYAQzQ7lsLIS+ik+6Hvgp0Fg2KVKZjd5aI+iprGM0oLHsPRmSRVlEF1ZY0mELj
	+K/P03oGVl5NFbk8vooBhXwBIEBahOTUiR5pYXs7UJBbRQU1kul3gsxnJZem418s/dh8HoTFkSK
	T1lrvEvT4chli
X-Received: by 2002:a17:903:19e5:b0:2ae:61bb:425c with SMTP id d9443c01a7336-2ae8242cfa9mr6322975ad.35.1772762756408;
        Thu, 05 Mar 2026 18:05:56 -0800 (PST)
X-Received: by 2002:a17:903:19e5:b0:2ae:61bb:425c with SMTP id d9443c01a7336-2ae8242cfa9mr6322775ad.35.1772762755920;
        Thu, 05 Mar 2026 18:05:55 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f77350sm517165ad.51.2026.03.05.18.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 18:05:55 -0800 (PST)
Date: Fri, 6 Mar 2026 10:00:12 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	stable@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crash_dump: Don't log dm-crypt key bytes in
 read_key_from_user_keying
Message-ID: <aaoyu2ZnZNHMVb8n@Rk>
References: <20260227230008.858641-2-thorsten.blum@linux.dev>
 <aaUIhtN0oUkP5ALi@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aaUIhtN0oUkP5ALi@MiWiFi-R3L-srv>
X-Rspamd-Queue-Id: 54F5D21A778
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223295-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:48:22AM +0800, Baoquan He wrote:
>On 02/28/26 at 12:00am, Thorsten Blum wrote:
>> When debug logging is enabled, read_key_from_user_keying() logs the
>> first 8 bytes of the key payload and partially exposes the dm-crypt key.
>> Stop logging any key bytes.
>>
>> Fixes: 479e58549b0f ("crash_dump: store dm crypt keys in kdump reserved memory")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>>  kernel/crash_dump_dm_crypt.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index 27a144920562..5ce958d069dd 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -168,8 +168,8 @@ static int read_key_from_user_keying(struct dm_crypt_key *dm_key)
>>
>>  	memcpy(dm_key->data, ukp->data, ukp->datalen);
>>  	dm_key->key_size = ukp->datalen;
>> -	kexec_dprintk("Get dm crypt key (size=%u) %s: %8ph\n", dm_key->key_size,
>> -		      dm_key->key_desc, dm_key->data);
>> +	kexec_dprintk("Get dm crypt key (size=%u) %s\n", dm_key->key_size,
>
>Make sense to me.
>
>The kexec_dprintk() is only for debug printing. We can remove above line
>or change it to pr_debug() if security is worried.
>
>Coiby, what do you think?

I think we can assume a key can be reliably read thus no need to print
the first 8 bytes to check it. So this patch looks good to me. And
thanks to Thorsten for suggesting multiple improvements on
kernel/crash_dump_dm_crypt.c!

>
>Thanks
>Baoquan
>

-- 
Best regards,
Coiby


