Return-Path: <stable+bounces-176579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E721EB39787
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B7F1C26FD8
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFD527F754;
	Thu, 28 Aug 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btGA7Q1j"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E72E7BDC
	for <stable@vger.kernel.org>; Thu, 28 Aug 2025 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371119; cv=none; b=dpKDHWdt5rULAkUbHmIHBGAhhNTQ/vKo6miwlORnf5U42IIOkiw3KqZEdWHyloN3qZtJBCLWbxqCKBDRls0g1GuMVPYD6gXJhBcSjFKazROljx0o2uGfatUafmjpjsLR1V17BAe8JxRfhdt2lO4KAcBKU0cpl/h0scq795Pw1XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371119; c=relaxed/simple;
	bh=EV0quMv3ObCBqJ3q/y8sQ3bUfXMfM2am1zRyeGWm6NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsDfqd7nhoturcoA6bnmoDRniAah0kYqJ+dshDzpKVSlAzMGQ2aUSu99S6AfLTrPsn2CD6zOg09nyvDw3ZxjS8gLFjCzkpIDpsuxDF28qpvimgq5yi7V82cm8RsiGeRUpCZnZjJxvvLzjsWnWZK/Wj0jbmJu5L0co0qLaiMk3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=btGA7Q1j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756371116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pZ435TlQ+HIpGdaIluJvf5SpzIcZNmOyzGhWenFncpY=;
	b=btGA7Q1jqKFOAza8pDk11pYCfP7ZVDtO+G5rIlre/PXq0F4m1wzD3oAvyAAG9TqKUvexPT
	km210Duto4/rA6MvtCqzabV56Ye3O2I5BcwXR0oERifP1137saKG8Z6/J0cQbld3Cub6g/
	hYA4CaHI3U/FveZTMge5bX3gGjTrXL4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-21MxZb4lMRi2SyE-QAyvkg-1; Thu, 28 Aug 2025 04:51:52 -0400
X-MC-Unique: 21MxZb4lMRi2SyE-QAyvkg-1
X-Mimecast-MFC-AGG-ID: 21MxZb4lMRi2SyE-QAyvkg_1756371112
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e870646b11so190001185a.2
        for <stable@vger.kernel.org>; Thu, 28 Aug 2025 01:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371112; x=1756975912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZ435TlQ+HIpGdaIluJvf5SpzIcZNmOyzGhWenFncpY=;
        b=U5rD1vPWBrLkSVMkmp+CFUkj23i7qK/57KI9Ht1ouQDYKuyQpb2DzxywPiP37dva9W
         FAGQGDj5vJhFzM3AN/uF1hT40d6OnUPMGvdq3zYtOtjmduRJDZZhwaeUxcv5v7yLwND3
         z+Bm47Jc2GgLRrNyc9HLOrXKpcauXtA0HR3XbX+6wHGzKSivRZH1Rf8xPMQKDMWfvY7k
         oLb2uE3QRGxGtHtG6Bc28nI4BzhgaqG1oHRiEICzSGyhK7fdpRq4RsraO/691kc79xa5
         SVf5s6jA3T/4qz+zlAkS6mb0P+S/ZAbkjYF83ro1P0IQ15O+AzMX5Op0ewmIR+y06aVy
         6bsw==
X-Forwarded-Encrypted: i=1; AJvYcCVSiYw/uLJUZCWHzEL6GcjNHMRTPn26YftH05qd7thAcNvRQKBqqJ73YXZJ1N5tJI94Zbrs+5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZL9R+8uHE/fCCUV5T4R1QBxRTl8fR7Zlk9UfjOsPv05s0T8VV
	bF7iaEvCMHI9sMIp6RKv03Jwm/wsMM3UcYELGbYD/oWQxFf2tnRFuZcOU3B7s62MeT4VbBZRnPA
	1b4qDTts8gT7UkSv1c0RCQEGZajUDzdNWAmYi5BDQYTnWrXX9uWKZSzdI2w==
X-Gm-Gg: ASbGncsjUyKq5BmDCIPv0ca2bawg9Z24mUb8PTgBM0fYVyYKyLb0NuASmMFrOkrp1Fb
	JdOFC1FnIEyp6kB4Jom6VRQNuIMQ8nxzDk90FjD/KGPGHRt2Kf+7XphGsh2vRZjSmqYtwqbzUAk
	DLJWutalcCmj+oDr4oVEETGtqvJWPsw/BS4Fgge+4zIyLrR4W4beOq/6yhvc0cRyjY06rcEkzSP
	ONbhbSUsQBnvHmNzbNuWV1IEush4IEHfHu9cIz3PkR/inmvRAHrAUsLf+NB4WvfklG36D6k/yMT
	9GN9Ik+r7FmlqwfhafgCwB8BorcGw8zFcXRUPBQkJMRrEDYMd8oyjk08rI4injKE6HxyLu3vX9X
	Fom6g/+VUr64=
X-Received: by 2002:a05:620a:f05:b0:7e8:5f42:762f with SMTP id af79cd13be357-7ea110ba9f8mr2509916385a.60.1756371112149;
        Thu, 28 Aug 2025 01:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED4tnU8Ld+hquMWBtmhCmS8i+WkcLO3XqvM9PKFDRSGBc3lyi1fB02m6s4mjZWzdNveuNgJg==
X-Received: by 2002:a05:620a:f05:b0:7e8:5f42:762f with SMTP id af79cd13be357-7ea110ba9f8mr2509913885a.60.1756371111742;
        Thu, 28 Aug 2025 01:51:51 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7eebc37f2d8sm892208685a.55.2025.08.28.01.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 01:51:51 -0700 (PDT)
Message-ID: <7a5ef6e5-ea7f-41be-97c9-555666a3ef67@redhat.com>
Date: Thu, 28 Aug 2025 10:51:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] selftests: net: add test for destination in
 broadcast packets
To: Brett A C Sheffield <bacs@librecast.net>, Oscar Maes <oscmaes92@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org
References: <20250827062322.4807-1-oscmaes92@gmail.com>
 <20250827062322.4807-2-oscmaes92@gmail.com> <aK8Vp6yrrIoQEmxr@auntie>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aK8Vp6yrrIoQEmxr@auntie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 4:26 PM, Brett A C Sheffield wrote:
> On 2025-08-27 08:23, Oscar Maes wrote:
>> Add test to check the broadcast ethernet destination field is set
>> correctly.
>>
>> This test sends a broadcast ping, captures it using tcpdump and
>> ensures that all bits of the 6 octet ethernet destination address
>> are correctly set by examining the output capture file.
>>
>> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
>> ---
>> Link to discussion:
>> https://lore.kernel.org/netdev/20250822165231.4353-4-bacs@librecast.net/
>>
>> Thanks to Brett Sheffield for writing the initial version of this
>> selftest!
> 
> Thanks for leaving my author name in the file.  Perhaps you might consider
> adding:
> 
> Co-Authored-By: Brett A C Sheffield <bacs@librecast.net>
> 
> to your commit message. I spend quite a bit of my Saturday bisecting and
> diagnosing,  and writing the patch and test.

I don't want to delay the fix, since I received other reports for the
same problem, but I think proper recognition should be agreed by all the
involved parties.

I'm going to apply patch 1/2 standalone, to allow repost for this one.

>>  tools/testing/selftests/net/Makefile          |  1 +
>>  .../selftests/net/broadcast_ether_dst.sh      | 82 +++++++++++++++++++
>>  2 files changed, 83 insertions(+)
>>  create mode 100755 tools/testing/selftests/net/broadcast_ether_dst.sh
>>
>> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
>> index b31a71f2b372..56ad10ea6628 100644
>> --- a/tools/testing/selftests/net/Makefile
>> +++ b/tools/testing/selftests/net/Makefile
>> @@ -115,6 +115,7 @@ TEST_PROGS += skf_net_off.sh
>>  TEST_GEN_FILES += skf_net_off
>>  TEST_GEN_FILES += tfo
>>  TEST_PROGS += tfo_passive.sh
>> +TEST_PROGS += broadcast_ether_dst.sh
>>  TEST_PROGS += broadcast_pmtu.sh
>>  TEST_PROGS += ipv6_force_forwarding.sh
>>  
>> diff --git a/tools/testing/selftests/net/broadcast_ether_dst.sh b/tools/testing/selftests/net/broadcast_ether_dst.sh
>> new file mode 100755
>> index 000000000000..865b5c7c8c8a
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
>> @@ -0,0 +1,82 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +# Author: Brett A C Sheffield <bacs@librecast.net>
>> +# Author: Oscar Maes <oscmaes92@gmail.com>
>> +#
>> +# Ensure destination ethernet field is correctly set for
>> +# broadcast packets
>> +
>> +source lib.sh
>> +
>> +CLIENT_IP4="192.168.0.1"
>> +GW_IP4="192.168.0.2"
>> +
>> +setup() {
>> +	setup_ns CLIENT_NS SERVER_NS
>> +
>> +	ip -net "${SERVER_NS}" link add link1 type veth \
>> +		peer name link0 netns "${CLIENT_NS}"
>> +
>> +	ip -net "${CLIENT_NS}" link set link0 up
>> +	ip -net "${CLIENT_NS}" addr add "${CLIENT_IP4}"/24 dev link0
>> +
>> +	ip -net "${SERVER_NS}" link set link1 up
>> +
>> +	ip -net "${CLIENT_NS}" route add default via "${GW_IP4}"
>> +	ip netns exec "${CLIENT_NS}" arp -s "${GW_IP4}" 00:11:22:33:44:55
>> +}
>> +
>> +cleanup() {
>> +	rm -f "${CAPFILE}"
>> +	ip -net "${SERVER_NS}" link del link1
>> +	cleanup_ns "${CLIENT_NS}" "${SERVER_NS}"
>> +}
>> +
>> +test_broadcast_ether_dst() {
>> +	local rc=0
>> +	CAPFILE=$(mktemp -u cap.XXXXXXXXXX)
>> +
>> +	echo "Testing ethernet broadcast destination"
>> +
>> +	# start tcpdump listening for icmp
>> +	# tcpdump will exit after receiving a single packet
>> +	# timeout will kill tcpdump if it is still running after 2s
>> +	timeout 2s ip netns exec "${CLIENT_NS}" \
>> +		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> /dev/null &
>> +	pid=$!
>> +	sleep 0.1 # let tcpdump wake up

Here you could use slowwait checking for packet socket creation, to be
more robust WRT very slow env.

/P


