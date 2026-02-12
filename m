Return-Path: <stable+bounces-215934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNPFOc2njWkK5wAAu9opvQ
	(envelope-from <stable+bounces-215934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 11:13:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0FB12C590
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 11:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B7C304F236
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89992E0902;
	Thu, 12 Feb 2026 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCuZ5hRP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8oDHDL+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6575D2DC333
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770891011; cv=none; b=G/On7Km62Hhb3RS5AReuZfgXY92hM0V4ee7NFC3Q0oYReK5PrQMhDR6QugugIA+nAjmriiSuhL1835HytDUCO6kRGTXHc34tIwzpczx30sTFOZESjEhy4Cj9W/10CHntRnDCvm1AJwOSAnMnTnnCJABmiLWYQVM1IPnhZCx89f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770891011; c=relaxed/simple;
	bh=SGaCcfVfOD01Cl86Knz26tLX4aJ70u9hQYfrkP4z5FM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nt0fizC5VOxONmKlDvy99P18++Y4NGB6T/a7MfWbkUCK8PA4lPDbMwsEdMSDGA5Q3ZwK2mzfQAXzjCspZtCA/Zb8IBAWBkHUvsDo4f0yHFfSeGLD4WjaLVceNbGghgFsad+DcfeDJ1XXxLHhfMmAV4wqo9488cxg33zk3bV99nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCuZ5hRP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8oDHDL+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770891009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGtZzlI0afIe1oXYIL6I39556RNwafluFe5WLDNAu60=;
	b=fCuZ5hRPPsi9frrPBgZr4n+Fj40n+pXi7ahjL3h4ICbhv9aR46ELDXQD5hg6DCg2G/6MQf
	nnSpBW4YMFcH3rGG9uOlOaw/z1SzeKqy54fEoTO40rbyf97srihrqNoykLvWBLtGhac4FI
	Pc7SNicQWOKb+sj5zC4ToIfWc9z35Sg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-V5YWIOKfM96q0fpE6RYJOQ-1; Thu, 12 Feb 2026 05:10:07 -0500
X-MC-Unique: V5YWIOKfM96q0fpE6RYJOQ-1
X-Mimecast-MFC-AGG-ID: V5YWIOKfM96q0fpE6RYJOQ_1770891006
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4368060a5e5so4415884f8f.3
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 02:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770891006; x=1771495806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MGtZzlI0afIe1oXYIL6I39556RNwafluFe5WLDNAu60=;
        b=G8oDHDL+lGk9V1J+uwIuvYtRI0vcK8NFlpD8Yv/Hg+9H52Sqq7jpe+2v2hnNXwhPdJ
         lY7EkkAKvnl3FreULZEFDFxLt8k6mpOOoexij1IRqMpiZsep5XoMo2sXWWnEPkuv0IN+
         FNwtuOp6zIo1DFx0UFgw6oJR6qL68uK3QSkXPn6XgTTezMlNWHyQPo6nWQjlpy6+8wH4
         kLGp2qYs53qzDvV5UVcYwK5G2l3HRhpDSDpvWEbIkXs/P16O2FUkqJT53vHHjyM2st7I
         S+PnajoWNKbKXuix3l07m2p/JiroM3puD2eUEm0cBd6CyK51zQxaqtGUx8kmItg38+YM
         oK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770891006; x=1771495806;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGtZzlI0afIe1oXYIL6I39556RNwafluFe5WLDNAu60=;
        b=RRx+yFlilav/sbXYm9UY3URr/d+Zi4aCDpcenuyTlfJcjH7CN7lMKye2IH4qQeVgay
         X8PlGoHOdJmAvdY+VbunA25Kk3iiQzmXogkNMcuFmXqKhQp2T+MvqoO4VQu89jKLCY1c
         /9kk/2l14GIwWdW3MilkN03V+TRDH14Qzb/3Db+qJ2iphcGn2F8iFOP8ENLNwV5g7doH
         kCe1qOjFTNszzkOlO7ONJXULLJbYtx5yVAKN9N9hYXVeWxncvv1K5aA+2Td09cINWE7T
         pO2fVbt8s9X6iONhlN1bwU3crcLlgnk80XvezMreksH043HVQRolf2wDJlc7duiGfcxw
         RsmA==
X-Forwarded-Encrypted: i=1; AJvYcCWG0uer3/L0Zcmw9uWOD5gkAvxvUZkv2sAj/+6JNpSYSFl++irqY11CkzxfWJXPKb094b0bRB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBg9RUHWO49j34yjIpu7+ZDOShvGhut7rN3O/fzhx+S5Ab47H
	tFm17gWFwwBAlfdMZw7DWPjoicXPIRY3xl/T7N+L89Tz8Pkfyd+djpG+VeCgkqPSAYxwUfiV6wn
	O9/+KbGUH8T4Z6uk/6uJxz+200tOCLgWQ1/HOakOmbABl7xJym2M8Uorg2A==
X-Gm-Gg: AZuq6aKKlADdx8sUjm/7lOFOWYXjZjTN5QxeIayUpXDKNeWHVJQxTgSfH+SbtRgVoUS
	7h4MK+eu89BOpD71H8gJjP+WMvsp/eyoHLIdr3BeRUEVY8Fh9kGNV0iULdyGo60JcHW+elqDhYe
	OD3Pf1AzR7zDG3NZYIqPp2dXHAxGKXOvOx/nvEu95rgbStxQ1JDCybayRMSEeWSfMG8/NsSJbQ5
	cukxO+WIk9utpvPc9QL8Pav3Bwchr0VO7/blppF8Dn2cnkyBkObYmj/nJleCWX7WokQJwPP5sE7
	2az67NysYKJHxRcGXYFdUXrvD86TBXKOGxKL6TVPTrczD2QZsWKovN6V5yn7XWReA/LVZBc7RB9
	np4we/9Ql3LTIf8ozkBxtS18wIo8o75Wqsa0NuUfeH2+Lohhony0Q3A68a376zQ==
X-Received: by 2002:a05:6000:4024:b0:436:1b1:6cbb with SMTP id ffacd0b85a97d-4378aa01106mr3209829f8f.7.1770891005908;
        Thu, 12 Feb 2026 02:10:05 -0800 (PST)
X-Received: by 2002:a05:6000:4024:b0:436:1b1:6cbb with SMTP id ffacd0b85a97d-4378aa01106mr3209788f8f.7.1770891005389;
        Thu, 12 Feb 2026 02:10:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d325f7sm11303724f8f.8.2026.02.12.02.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 02:10:04 -0800 (PST)
Message-ID: <7c6933fc-663d-4bf6-8594-c14c4be83c98@redhat.com>
Date: Thu, 12 Feb 2026 11:10:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/hyperv: During panic do VMBus unload after frame
 buffer is flushed
From: Jocelyn Falempe <jfalempe@redhat.com>
To: mhklkml@zohomail.com, mhklinux@outlook.com, drawat.floss@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, ryasuoka@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, stable@vger.kernel.org
References: <20260209070201.1492-1-mhklinux@outlook.com>
 <20260209070201.1492-2-mhklinux@outlook.com>
 <a5372b72-8dc0-4f2d-ad5c-086f3e75ee81@redhat.com>
 <002601dc9baa$517d8b40$f478a1c0$@zohomail.com>
 <e9d35c78-1c4b-4a9c-8cf0-9531e972279f@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <e9d35c78-1c4b-4a9c-8cf0-9531e972279f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[zohomail.com,outlook.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215934-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jfalempe@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zohomail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: 8C0FB12C590
X-Rspamd-Action: no action

On 12/02/2026 10:49, Jocelyn Falempe wrote:
> On 12/02/2026 00:01, mhklkml@zohomail.com wrote:
>> From: Jocelyn Falempe <jfalempe@redhat.com> Sent: Wednesday, February 
>> 11, 2026 1:54 PM
>>
>> But for this patch, the issue is that drm_panic() never gets called if 
>> CONFIG_PRINTK
>> isn't set. In that case, kmsg_dump_register() is a stub that returns 
>> an error.  So
>> drm_panic_register() never registers the callback to drm_panic(). And if
>> drm_panic() isn't going to run, responsibility for doing the VMBus unload
>> must remain with the VMBus code. It's hard to actually test this case 
>> because
>> of depending on printk() for debugging output, so double-check my
>> thinking.
> 
> Ok you're right. I changed from 
> atomic_notifier_chain_register(&panic_notifier_list, ...) to 
> kmsg_dump_register() in the v10 of drm_panic.
> 
> So I should either make DRM_PANIC depends on PRINTK, or call 
> atomic_notifier_chain_register() if PRINTK is not defined.
> 
> As I think kernel without PRINTK are uncommon, I'll probably do the 
> first solution.
> 

FYI, I just sent the corresponding change:

https://patchwork.freedesktop.org/series/161544/

Best regards,

--

Jocelyn


