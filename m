Return-Path: <stable+bounces-215799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKOVAfhyjGn6oAAAu9opvQ
	(envelope-from <stable+bounces-215799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:15:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A265124229
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1652630078FF
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9D311960;
	Wed, 11 Feb 2026 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9mT1boy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnYDYtyt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37403944F
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770812149; cv=none; b=gAkP8rog/AJDI5tAVvkr6UjRUJsjrGj42nLxJX+mCzayGyLwu2h0y0/tYNUSgdwLh9jfPNOsgP/TH4KZi84pEGBaBW2nELqh76qpPmgDFn0I82Q3uZB6faRTk4NDvy3fCLm9ds6X+6kwbkRihqFE673fzXi9rZN+7FSiivdckY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770812149; c=relaxed/simple;
	bh=zwtrR6VDQqRfiGwabJda0K6rC6Ytzxc2xzn9PKLh8Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVT11DNi6cjjJiH+8sCpGkwZpVyS0M/D/F+BU2epjD3pYTb9zco1VQT6Llov/ImVcsT4n1Q39QDpMdEvrzxAMCEr9ggs7AwSmDOcVIE/7qSjCWL5cYS3jukK6MZLSN8ksqhshL7nGRe2qUtmxR1DTfd32Rpb9Sjlei0UMJ2LGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9mT1boy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnYDYtyt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770812147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EpzX+ghvAFNjZ7ZxVYHEPBHpEaI5GQyf0hEL4AV2dRE=;
	b=K9mT1boyyvzsbJW+HgXlf/2csFFUCc8ph8m6YM0A3hFJVZhMboobwublHb2XNAzypOk+zJ
	WFg1+lZ2oZW7nZQVvhul38lm1hLwDY4M8y6L54o3iDrSJeCteHcAjNkdZTeYIRRczfygKq
	te0hG9qZsrZtCBtwIQCoCEoGznF8RHE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-p7pjgDmfPbeWUzwyL-xvqA-1; Wed, 11 Feb 2026 07:15:45 -0500
X-MC-Unique: p7pjgDmfPbeWUzwyL-xvqA-1
X-Mimecast-MFC-AGG-ID: p7pjgDmfPbeWUzwyL-xvqA_1770812145
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so43428945e9.1
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 04:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770812144; x=1771416944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpzX+ghvAFNjZ7ZxVYHEPBHpEaI5GQyf0hEL4AV2dRE=;
        b=JnYDYtytSXe5WLiXSEoNG9yMGHFBwS4nLDm40/0wIXCu9birTSJaOmwQ33fj2uSzLY
         ifyq/ChDydK2sv0pHz4adHgIGMi5X0ZW/ce3ZmE/Sk0Ebv6xLVGY0fwdtuRUTS/xsOMr
         pspb4FhFQelvNIpJ6wgSUMUrANeUG5ByiHiSl5tIiEmWoXEjW8DspPnVUfyvX4W+s5wH
         jLyLzdyhVrlENTpHwfJ8zpBtj3NU8pvKTkIH9/O9WKIsWUWZZh24z8nYgV5inTSFsqGn
         RzXg9SupoGJWqe6x1CjgcKPUCwTLIov0DJ65GfL0XWcB5K0oCeku+N29649WzljBNF9d
         vmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770812144; x=1771416944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpzX+ghvAFNjZ7ZxVYHEPBHpEaI5GQyf0hEL4AV2dRE=;
        b=PUpQOYM0zDAJGEcgjEQYJeKRxhbCkG4r6fyaNT7HJ+23ZMd5vJgtgBfcll0M26TF2i
         xY0THBJbpL3tmKO9BV05FSJcfs0T6AwypokeH0mMqSNIhm3xke8gARiqw20kEURQF7J8
         13Uz8f9/1OVIFUwSK4hjcukI1J3W6+qzQmaNuIA4s/w949p+4m36W/HKqZaXo74Z26T8
         pxlmYkAzB6xXmTlmz6eLBV13NnljEmJodt31IVgoTc3YJTqhQaTLks1V/Fge2O2dgOhj
         43fR9z6Fr6akoow6dBkM2aBECg4p93ytY3J1Z1lzQILMc8wNJlD/U0lDIgR2IkOk6fcB
         9EaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV73kgaeajFgD9jICtqyqT1uqirBulfn2T1ETkzleUx79dyRC+MtZ8CzTzqT6gaMJx6w9tFovY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ1MIuO4ZQx8wu2ErwKFw2mJfEQcIbH/hUNWsdJga6cDkvOqYV
	KRXe3FIZ8Dvax6UyF9RHjrV5l4RL3DJXZgcL4qmJHkmguKeOMKXa6NOcGkpyu67y5/CFBWCC1LT
	ZPWBYf1ZlXH5gv5R1E6Ws1LCpfxuUS4DmMekPwrto2EWOmDd7Rqw2C5/7ow==
X-Gm-Gg: AZuq6aJMSVrxUBHs7F7gp370/fygr03AzG77iDUc5/cpKWN+T1pfni2SQZ6W4DkK5ZL
	I3MgxCkgs24sy+as1QYHlHmsTPsyKp+Fq0tE+n5wDtxiw4O0OVZl0HtYADdpdqSzlUHyWlEjHNx
	6oL5upNoxcbg4LuzJhG6x8C/i6ja30MLxGQ3V7BrptXgt5IDia/jPp88GGIJq5xYppcpRHYUpv8
	TVKIt7GZPvtk3VXXgOaSFR9EkR8o9jFI48vNHrZbwZNIU5VhHsBDS67KpjkaL28Um3hlKktzZlG
	b7QcvX0zFy0o7N1XJ5x3bQSY2FjvQwXOrGFQXag+RUofsU2v8MLVeKdoYaMSrFkqIGMB/NCifWy
	HZ8ldwmOUCHL7jOSZbsz+peYPZzitjMC1m/bHwwn/CtIEy+SQTgmXpgFAlcMeSFniYniO1C8=
X-Received: by 2002:a05:600c:c4a8:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-4835b979c30mr31799975e9.32.1770812144642;
        Wed, 11 Feb 2026 04:15:44 -0800 (PST)
X-Received: by 2002:a05:600c:c4a8:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-4835b979c30mr31799315e9.32.1770812144089;
        Wed, 11 Feb 2026 04:15:44 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a5bf1efsm37289995e9.0.2026.02.11.04.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:15:43 -0800 (PST)
Date: Wed, 11 Feb 2026 13:15:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Korsnes <johan.korsnes@remarkable.no>, stable@vger.kernel.org, 
	patches@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 094/169] vsock/test: fix seqpacket message bounds
 test
Message-ID: <aYxyYLI9IjI5VxCp@sgarzare-redhat>
References: <20260128145334.006287341@linuxfoundation.org>
 <20260128145337.388867288@linuxfoundation.org>
 <61627e8a-6998-4138-a174-d7fd257db93e@remarkable.no>
 <aYw9N_Ido_FZzblw@sgarzare-redhat>
 <cc9bcfe1-4667-4a33-b370-1f3912f0adca@remarkable.no>
 <2026021103-gusto-karaoke-6c60@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2026021103-gusto-karaoke-6c60@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215799-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A265124229
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 12:37:20PM +0100, Greg Kroah-Hartman wrote:
>On Wed, Feb 11, 2026 at 09:58:08AM +0100, Johan Korsnes wrote:
>> On 11/02/2026 09:30, Stefano Garzarella wrote:
>> > On Wed, Feb 11, 2026 at 08:50:11AM +0100, Johan Korsnes wrote:

[...]

>> >> Hi Greg,
>> >>
>> >> This patch causes build failure as the setsockopt_ull_check() function
>> >> does not seem to be defined in the 6.12 tree.
>> >
>> > I guess just when you build vsock_test, right?
>> >
>>
>> Correct. I should have specified that.
>>
>> > BTW to fix that we should backport commit 86814d8ffd55 ("vsock/test:
>> > verify socket options after setting them").
>> >
>> > I tried to cherry-pick it on current linux-6.12.y and apply clean.
>> >
>>
>> I can confirm it builds fine after cherry-picking that commit.
>>
>> Kind regards,
>> Johan
>>
>> > Greg, let me know if I should send a proper patch for 6.12.
>
>Great!  Can you send a proper patch for 6.12.y for this?

Done, I discovered that a similar issue is also in 6.6.y so I sent a fix 
also for that tree:
- 6.12.y: 
   https://lore.kernel.org/stable/20260211115948.108140-1-sgarzare@redhat.com/
- 6.6.y: 
   https://lore.kernel.org/stable/20260211121135.116071-1-sgarzare@redhat.com/

Thanks,
Stefano


