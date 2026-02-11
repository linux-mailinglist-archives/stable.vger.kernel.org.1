Return-Path: <stable+bounces-215763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMlnD28+jGlyjwAAu9opvQ
	(envelope-from <stable+bounces-215763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:31:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC1F122424
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 761DE3061514
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D485E34EF07;
	Wed, 11 Feb 2026 08:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlmnxdCG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="deO52FMv"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C332D452
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770798664; cv=none; b=lpS71t9sOwI+UKX/gQYqsma4chl/8eEPueCcVqlLGh7l3HWnS+E2QHK89c+/suJVhcugHPlknXEnOfuXqH1b522RkNsXGEeq4lg9hf8hi4TwNw3JBS/ofHFhpBL63TF9xZuvJlKvscpFvoeiLyzb1s8TAzP+Q/GYzv8s/3yMoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770798664; c=relaxed/simple;
	bh=L+RzPB2XgZkwHXOiETeRI5QKRu4DkbYwNWRldGc4q0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAks36bQHDfgpUWP1qkE7TS1aWvsYBtBOoMEizaTF612l1aWQRi2eschM7uo36x4auU1xEdGsMIwZ8r7sUvibwkeOlkRlp4ypsaKa+JXQFT4AoWLNyElo34v0piPVaqVwjAZg2c/3zNSbAUndV+vF/L2txrwMnpKb8mRHGYwJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlmnxdCG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=deO52FMv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770798661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gjJtZqFQZ1VGaFIFZH95XeOOE6KaDU1AzjXSlUCybq4=;
	b=SlmnxdCGDHrGJQF+pGdQWjrurxS5z8/u3O06SP9b8jol+nA2jlg71CXt6m8dQ1gg5k41Bk
	8bmwM44k/2TmfJ3txIsdRFFYBjMUicXBy4H9w1byfK4VByaMu8RxJg62iLShuJpcPvXGPz
	1N9glOX4ooX8RyMTGsEGsrl2Yg11zBc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-_HAYggmQMuKI0uiwdqzJcg-1; Wed, 11 Feb 2026 03:31:00 -0500
X-MC-Unique: _HAYggmQMuKI0uiwdqzJcg-1
X-Mimecast-MFC-AGG-ID: _HAYggmQMuKI0uiwdqzJcg_1770798659
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4806b12ad3fso64399735e9.0
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 00:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770798658; x=1771403458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjJtZqFQZ1VGaFIFZH95XeOOE6KaDU1AzjXSlUCybq4=;
        b=deO52FMvplJrS4fzc8HHNmzOI/L1x9eVUOgMW/r07LgS+War2GYGhQs+xM3f6LSY/h
         p8x084Ct4q8ai0f9iZyERUn2IF3VqgoR22zjMBNmp9SFcRgwCK/sFv/iubtcmK9rkfpl
         hsWIkHNsoQQj2MaZcmMUhn1ahQkN9yysCTW4yBf97uIm5NB9gVPYCxaVFecJ3U+2oCCv
         72gXW1yrZmu8bAOARtFwVIjQD/bLSsgN2Mit+l/8Up7oPMTiEWrh8Nz5c3VRXIQHjbo9
         rjMQzKnoIuP5OJxB4OC4eLJeONcE02Q5UFs5nNSmdtf0lUSIqP1YFfOpskE9n6Q6rYkZ
         nofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770798658; x=1771403458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjJtZqFQZ1VGaFIFZH95XeOOE6KaDU1AzjXSlUCybq4=;
        b=N54BjHiR0I1bbmdi4fEgZ3zmf43Nt7BpObBVnbjAhxjWu4D1FZPXh1x3cl2X6UgGB8
         cOu7XKSydv+pBtdYU0+tYDkEud+byrWwzy12OUWVyUL+lhca820QyEzFYrMQeTYNVhWS
         uO78TDm0bXUNMDYq2aE9etaSQs9+nGX6oRZcUZzoD55PXM7kzQInjw9BAd7LUXAZtKmZ
         BZbOBqbqGH5EzUjqwNboOaBhybby8wrYPWQyJsamZKBaOf+GaMYEpWPEX9J1UeCGD63E
         8gkT+d67ltguP72Yxb6ki/ticu7Ir/HzOqaCutfL7Q7VdbxSwtbr21ZIYDIxLBTO5c12
         qSVA==
X-Forwarded-Encrypted: i=1; AJvYcCUl6K0rwfwbNq8X6WETCQT2zZXwOM6TBV+rKKnxliyniCX5DB3oIYUL6TXOEm64vhbzt+vmpiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXdGHiUu+wrE2HK3ukjntu5k34YZXaQgW3GDGkEIKRmf+XwZw
	VtHmo+GG546XR4SQVQf2fVeQtJOKdRXaN5FH3n1HlJzeRYGXfXkpawY7Q9r3OIIjpMZWHfgPUNw
	5bZQakD4QuZHMJeZw2Q2SN1fMNpbNbwqHWhJJzLxbAJlit6vr9PBtumidVA==
X-Gm-Gg: AZuq6aLYw9US5EjWIYmiO20UyCHyyvbVTc9LMzScz/teTsat6mhWc41J7U7XHClY9Aa
	DJXxmm8fzyqDhftKiTcPSbVgRwsJjL2EJTYxy4tlQ0jV+d9JaD42LjPhz5q+wBvlIGbyLOxv97F
	Cc91Br08FnhwXZt8g/5JfSpZqiRODdsLrnel7oqAqLP25NJyeajWEcKI6CCJr43dJ1NDTi8oxF5
	0Q1+DMXejtVunnCN7zbmEiC3DT1dSOeDXDUixDryqY/TS5yeKetWWR+eJietVZPyrGU2SyJmaqt
	jZ99HEHAwHBB6PiR1y1aaFxTHmtKKvQbd3b0mmztNrj0NUBJQxvHYUGUAMNf4m5UV++sXTU8FyN
	p9cf1w2+mLK3TsGAKYpuJQvNmJv3vv8aS1ghuIUMCDPeyh0KdwJ3MGzt8zD5guCnK4z6N7d8=
X-Received: by 2002:a05:600c:1384:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-4835dfcf9a0mr11195795e9.22.1770798658429;
        Wed, 11 Feb 2026 00:30:58 -0800 (PST)
X-Received: by 2002:a05:600c:1384:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-4835dfcf9a0mr11195405e9.22.1770798657800;
        Wed, 11 Feb 2026 00:30:57 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783e5be13sm2956514f8f.35.2026.02.11.00.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 00:30:57 -0800 (PST)
Date: Wed, 11 Feb 2026 09:30:49 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Johan Korsnes <johan.korsnes@remarkable.no>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, patches@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, 
	Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 094/169] vsock/test: fix seqpacket message bounds
 test
Message-ID: <aYw9N_Ido_FZzblw@sgarzare-redhat>
References: <20260128145334.006287341@linuxfoundation.org>
 <20260128145337.388867288@linuxfoundation.org>
 <61627e8a-6998-4138-a174-d7fd257db93e@remarkable.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <61627e8a-6998-4138-a174-d7fd257db93e@remarkable.no>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-215763-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: ACC1F122424
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 08:50:11AM +0100, Johan Korsnes wrote:
>On 28/01/2026 16:22, Greg Kroah-Hartman wrote:
>> 6.12-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Stefano Garzarella <sgarzare@redhat.com>
>>
>> [ Upstream commit 0a98de80136968bab7db37b16282b37f044694d3 ]
>>
>> The test requires the sender (client) to send all messages before waking
>> up the receiver (server).
>> Since virtio-vsock had a bug and did not respect the size of the TX
>> buffer, this test worked, but now that we are going to fix the bug, the
>> test hangs because the sender would fill the TX buffer before waking up
>> the receiver.
>>
>> Set the buffer size in the sender (client) as well, as we already do for
>> the receiver (server).
>>
>> Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> Link: https://patch.msgid.link/20260121093628.9941-3-sgarzare@redhat.com
>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  tools/testing/vsock/vsock_test.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>> index 0c22ff7a8de2a..79ef11c0ab14f 100644
>> --- a/tools/testing/vsock/vsock_test.c
>> +++ b/tools/testing/vsock/vsock_test.c
>> @@ -359,6 +359,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>>
>>  static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>>  {
>> +	unsigned long long sock_buf_size;
>>  	unsigned long curr_hash;
>>  	size_t max_msg_size;
>>  	int page_size;
>> @@ -371,6 +372,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>>  		exit(EXIT_FAILURE);
>>  	}
>>
>> +	sock_buf_size = SOCK_BUF_SIZE;
>> +
>> +	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>> +			     sock_buf_size,
>> +			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>
>Hi Greg,
>
>This patch causes build failure as the setsockopt_ull_check() function
>does not seem to be defined in the 6.12 tree.

I guess just when you build vsock_test, right?

BTW to fix that we should backport commit 86814d8ffd55 ("vsock/test: 
verify socket options after setting them").

I tried to cherry-pick it on current linux-6.12.y and apply clean.

Greg, let me know if I should send a proper patch for 6.12.

Thanks,
Stefano


