Return-Path: <stable+bounces-215769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKktI65EjGl+kQAAu9opvQ
	(envelope-from <stable+bounces-215769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:58:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E911312277F
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 09:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CFA6300ECA1
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694D1353EEC;
	Wed, 11 Feb 2026 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b="JbV5ytSW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C7354ACC
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770800293; cv=none; b=mTIGT/C11SZ96sbQ6nUxh4KANryBO+4dftH+Xd+nPxZkQL/6n944e3uwzWGb78StYJZJHq5S/6667CzAEby5a0ehPavA4YjVelQlW/4/wcjs1twQmvxjpGuVuGpYbS709znjUA8CpBReIZPdch1RcJAzsKffF0v0o4FKQ+HV4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770800293; c=relaxed/simple;
	bh=SnjDX2BmSG9+YNiOS3gG9ljjWXS6el4ibB5xVQ1G9/Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BwoQXqMm7djEdk8xwiIRuvtMBgG1+AR5LDEFDY2YWCz32Sb0YHRD0NvRguFtZTjfIMEM/ZmtWIDALBC0ErlXJfNQ79ymo1tB+LAHbWXk0+cs5M0hsyXZFgjGrwawQ6F6dpDxHtrCmGl5JeFdzR+IFp3d423MVodh13K58Rid3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=remarkable.no; spf=pass smtp.mailfrom=remarkable.no; dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b=JbV5ytSW; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=remarkable.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remarkable.no
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-59de66fda55so5965739e87.3
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 00:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remarkable.no; s=google; t=1770800290; x=1771405090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2nT5soxasCdecMDImdwifJowULDL/SH1hMInO+fMJhw=;
        b=JbV5ytSWkVfSKtzZv7fez7+1Hf4ZqJkBGbi9Q5eMyvbAkCqbt9OyjL9QQmHJ3PBmIJ
         jp59c4xeogwMTxcKZHcCbGThsHt1wAhr58klaZp+h2/U8pz/TroWW9TW0WjLAblVXkX5
         o6fri85s33j/wG+FbzPRMDw+B2kuT53WGCnaLTw4qh/h51XPkYzJY9y5wXXNItRFmYTC
         EarqGbyazXGLlrmZ23u9KtxpMaq/Lc8VrEL7T1S+BNt0Sb17w5DTAER7q1P5CUUAJmlf
         mCoTHMsNbo2ZTQSZhOD56cpohJJRk7HO4sbq+eqIdVnqAFshLaLN89Hs0U/LPrD4uNDo
         SEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770800290; x=1771405090;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nT5soxasCdecMDImdwifJowULDL/SH1hMInO+fMJhw=;
        b=JY3pwXdoAP9jyLjNWRe9yQkewDHeGOKCyoYcXTLAf3L//Dkafg8aHcz8Nqd86nlxfc
         fFD7HjaKfgbfliZQcwsnqHIkQ8bDjrhH/iSIJaOHKMeV8ovQqLegH1wQVzLuQnun+x0E
         Jrt7+71elMOOSqhBSyP9kMARrfHlElXFG0fIv+PRQlLz7J9k73kyIcFYkJln0s9E7ofS
         aDawWSlp+feWgIAZSSS/hE73n/e6gLQUKEzAK8ytMwM4KQpXlahp/LLZYY9Y1XZf3BCU
         8714yVHoAgK9i2hClpXoHc8+FTfxGXAwVj8U5+FRYfdEPOuaPY4Jfw9EhTfZ0MiaZcC0
         6Ryw==
X-Forwarded-Encrypted: i=1; AJvYcCUCsB6CAxAMl4Aq4P2yzlwj/5LJIaufqfEyVl+e5hbgR2/grXn4t7qo9hatN9p1lWhQaZuVvzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlMSmJtwO8Gr/6oEcn0w4+d46QOd9xUcDcke0pYYXOXXFGVoFK
	napE+UxS/568Z/SD8gWjtYLAJRXtiCs7bhihzYeSvvQLok2B6u1tX2V8e82qetxdGQ==
X-Gm-Gg: AZuq6aIsJ4tapfLTTUM8BVdi72b50XmM7uoHKfaWtcBTMxSgBN0i5BnDSFgZU1XPEJK
	yRT4VsQF9tYd+pDn/XwK4Xe2agwFoLyDShHcc3MIFMJjjvZbkMf8bDTyPX24lCnQkoBS3dIXpkr
	YLYOZCFmXjYHiIv7Mp5eXLsbZ1v1jbIP3XMBORk6vigSCOV5tf1U+PF6+itwG8XJZl9LdgndHDu
	49y3eIrOJKDzKgOn4KM+UV6GLknSkISpf/820B5UBDOeDeD+ZrcAOAIvzLaiRrUKHbz/eercnMR
	3xrAaBcStoaCVnWdUU6rUW6Lww/6gEKDX+ZLaPhWp433Z1JsUzAMN1OdtzhqBp6e8nWJPOBJbmn
	9mr/z+/oOZLW7R73FiT9vpxHJKckuXkHPxxZQ3KUJChmrnGgDvnCA2uFtvQc54XAR0o+QnOE/L9
	C4OIA9Kn/FTNeokn7ZEWvNB4Z8By9K4EX8CfQCOpeZeRgbA7d+Ls5LDYHognaQ0Jg50+VYgnuij
	Z4Cw/GEYstqrIZy7BejnCs1Bdt9K7ESlgdMWRk1T2a29Q/S+ekOfFLnd3ujJOaxGLe0E0L/uCPP
	5p9O
X-Received: by 2002:a05:6512:2c09:b0:59e:5b90:d7d1 with SMTP id 2adb3069b0e04-59e5c2baca1mr685434e87.8.1770800289656;
        Wed, 11 Feb 2026 00:58:09 -0800 (PST)
Received: from ?IPV6:2001:4643:2b9c:0:64dc:7ba4:ffb0:37f7? ([2001:4643:2b9c:0:64dc:7ba4:ffb0:37f7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f5a4f5fsm206590e87.56.2026.02.11.00.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 00:58:09 -0800 (PST)
Message-ID: <cc9bcfe1-4667-4a33-b370-1f3912f0adca@remarkable.no>
Date: Wed, 11 Feb 2026 09:58:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Korsnes <johan.korsnes@remarkable.no>
Subject: Re: [PATCH 6.12 094/169] vsock/test: fix seqpacket message bounds
 test
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Sasha Levin <sashal@kernel.org>
References: <20260128145334.006287341@linuxfoundation.org>
 <20260128145337.388867288@linuxfoundation.org>
 <61627e8a-6998-4138-a174-d7fd257db93e@remarkable.no>
 <aYw9N_Ido_FZzblw@sgarzare-redhat>
Content-Language: en-US
In-Reply-To: <aYw9N_Ido_FZzblw@sgarzare-redhat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[remarkable.no,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[remarkable.no:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[remarkable.no:+];
	TAGGED_FROM(0.00)[bounces-215769-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan.korsnes@remarkable.no,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,remarkable.no:mid,remarkable.no:dkim,msgid.link:url]
X-Rspamd-Queue-Id: E911312277F
X-Rspamd-Action: no action

On 11/02/2026 09:30, Stefano Garzarella wrote:
> On Wed, Feb 11, 2026 at 08:50:11AM +0100, Johan Korsnes wrote:
>> On 28/01/2026 16:22, Greg Kroah-Hartman wrote:
>>> 6.12-stable review patch.  If anyone has any objections, please let me know.
>>>
>>> ------------------
>>>
>>> From: Stefano Garzarella <sgarzare@redhat.com>
>>>
>>> [ Upstream commit 0a98de80136968bab7db37b16282b37f044694d3 ]
>>>
>>> The test requires the sender (client) to send all messages before waking
>>> up the receiver (server).
>>> Since virtio-vsock had a bug and did not respect the size of the TX
>>> buffer, this test worked, but now that we are going to fix the bug, the
>>> test hangs because the sender would fill the TX buffer before waking up
>>> the receiver.
>>>
>>> Set the buffer size in the sender (client) as well, as we already do for
>>> the receiver (server).
>>>
>>> Fixes: 5c338112e48a ("test/vsock: rework message bounds test")
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Link: https://patch.msgid.link/20260121093628.9941-3-sgarzare@redhat.com
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>>> ---
>>>  tools/testing/vsock/vsock_test.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>>> index 0c22ff7a8de2a..79ef11c0ab14f 100644
>>> --- a/tools/testing/vsock/vsock_test.c
>>> +++ b/tools/testing/vsock/vsock_test.c
>>> @@ -359,6 +359,7 @@ static void test_stream_msg_peek_server(const struct test_opts *opts)
>>>
>>>  static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>>>  {
>>> +	unsigned long long sock_buf_size;
>>>  	unsigned long curr_hash;
>>>  	size_t max_msg_size;
>>>  	int page_size;
>>> @@ -371,6 +372,16 @@ static void test_seqpacket_msg_bounds_client(const struct test_opts *opts)
>>>  		exit(EXIT_FAILURE);
>>>  	}
>>>
>>> +	sock_buf_size = SOCK_BUF_SIZE;
>>> +
>>> +	setsockopt_ull_check(fd, AF_VSOCK, SO_VM_SOCKETS_BUFFER_MAX_SIZE,
>>> +			     sock_buf_size,
>>> +			     "setsockopt(SO_VM_SOCKETS_BUFFER_MAX_SIZE)");
>>
>> Hi Greg,
>>
>> This patch causes build failure as the setsockopt_ull_check() function
>> does not seem to be defined in the 6.12 tree.
> 
> I guess just when you build vsock_test, right?
>

Correct. I should have specified that.

> BTW to fix that we should backport commit 86814d8ffd55 ("vsock/test: 
> verify socket options after setting them").
> 
> I tried to cherry-pick it on current linux-6.12.y and apply clean.
> 

I can confirm it builds fine after cherry-picking that commit.

Kind regards,
Johan

> Greg, let me know if I should send a proper patch for 6.12.
> 
> Thanks,
> Stefano
> 


