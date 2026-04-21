Return-Path: <stable+bounces-240255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KFoGzYB6GlJEAIAu9opvQ
	(envelope-from <stable+bounces-240255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:59:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F000F4405E0
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 00:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDB0C3029D4B
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 22:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F238552F;
	Tue, 21 Apr 2026 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="GUEBSGKF"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA913822AA
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 22:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812337; cv=none; b=nz1yVgdt+bLMQaqjBcTGkwSCTN/jH2YlxOotUvbL8wy4HO7ylCEHXM1waZpKC65Bf5yE0FJhv2EjjSE1yw3Goih7lG5VFpd0J49tTjGXXY+2PtfowwH7fogq5s3OjwutNK2SfLZ3kqCjPQ4Q2jP9Oabnekou//PHkC1AmapJVXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812337; c=relaxed/simple;
	bh=tVS1I51gR8ialQjV66JTaRvpNhYQyIiFfnHQHHNlOKg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=XojiZL+4an6CNk+FHwi/zHz5gMtwtXDNhsazlJlI3RrFLNPPK82w9saHFYEgfbfm2UCzUAoa4T7cjW1haSBh1J+Huizp6X4GJtJgZPRoepairYZlQQ0iYLjEOZj9/8VIMlWlZF/KT2LWQQqrlkJhVyeMI5NVASNf7xucHkstPMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=GUEBSGKF; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4779b2497b4so2831378b6e.3
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776812334; x=1777417134; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCp5VnunPbPtqwjenjYn7N3AFQ6NsGppCcqzyezyOQw=;
        b=GUEBSGKFglWNFmo1o4PYySQGP7LMkEHRiQzkC3Ivsi62gHSwOE5MX3TfutGV6mGa/f
         yX/7V1eiBF3D6S96ncbxAxbZYQ7s9BWwK2o5D5tV07ZIzbV4u9235tEajnB6VaRK3hAx
         vzbUxq8L0FcqXQ0oSX9nBrqXE9yzPrWdyUa5X6TxriGAi/vOktU5L49KfHvxLGgyLl83
         e/Ju9UltiJXYY3biR9ff+RIhBa4OY2+zcnw4mny2ixsf2FZyYKx03lPB8TD7w+2iiTnv
         1MfeLH5mDjPENI+YSG2t3fDVJpAdUz9TpcZkbwBR+wfi3TUgKoZn3mekW0MiGn3lg82Z
         dZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776812334; x=1777417134;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCp5VnunPbPtqwjenjYn7N3AFQ6NsGppCcqzyezyOQw=;
        b=G5HCJek8e8oPNj56CVFrAwjnPwZHSbJ0haw/ASJ2xotaTb9wgl6cbYmCCTB0Oz6Ykr
         R/Y7BWeRZPOP4wIzuFIGqbsSTbDDsKyLlW8pQEujqqbTz4czX3cR1MfirFagNlrF/fKI
         0mTjx8dt/syMFcpYSmEcABJwpNdM80isqBaKE6rm7uBslvBtWTMJxzSn0wHligicPKwM
         dgdct85NRSamR3U/zC63BS+wPndqjzi5WJcy+pq6N/lMTshaE1z7pRn3nmAWCmac0saE
         G9wmmmEKoS1hHE0xRRha7SRRjH9WbMy0/NZCYfkQO7hqiH6fCulXFGu3cXph1HobFHlu
         ryPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+JZQrFxeGgY1F2oYW6Np4wwVLURaR6d1W+O9V2bLvRZwkGI7Txk/cHxMXioH+zjtskZintu0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHZGS4uJS6Z1GYV+lHx0+FJlC5lwWcDZ2neb7edFEkJiZZnc0
	/VU9UHdSdhbHa9giCNeZrxIRjiTgzycbPv8cZF85jiW5Qto4P8BZ6ks6dotPN13EyhGNkPUh/7b
	qq6HXQtk=
X-Gm-Gg: AeBDieuSyjtiS/MyuLT/gB9VnL3bL98/90Eqo2lR6QELGghG3s9zK6EKQwqIIT75J06
	FBpSwQ04KJjX+syWy0XAMupX5c0Ej8/XgBwNnoCbqmChUlW4/6zwDyRMb2TqyPyokPOb6EsYMEE
	ZTuJBDRkRbsGE+Tdz4RSUbISSZ1bSA/ZnoPkTDnw2Fp/MRRIgK1cZwXMG3ODnZS6AEuD98D3b9Y
	Wn3RbWeEOcYfFLUoHMipKUa8DRGt6jOSbHPakSNB3SAJ4faGfPn94F3kKSRUcxOvqc0MC3XozLs
	LWZlqs43tNP0Huo8Q+OFRfy5CuXO+4iWPPSk7WRGfLz+4ZMXPtqfTzA1z7nGeDvdPsutIdJ8FsP
	xl8l9aanJdt7bASKp/MKJan1KKo5PaKVdCK7q9AGxwC0nzpCmXdlizhW54HQmkO/wPzhzmlfQbj
	0qBH5fSjWPStMH9nJNFuRKwXPieZVXwtvC8DV4Gf6uzuA7s9KopN986NKdAVZomPkj9xUxcqWZ3
	XFnGOmqzfiz97Vsl9Xn
X-Received: by 2002:a05:6808:690b:b0:467:16e4:d263 with SMTP id 5614622812f47-4799ca9c15emr10810877b6e.44.1776812334343;
        Tue, 21 Apr 2026 15:58:54 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799ff451d9sm9841826b6e.8.2026.04.21.15.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 15:58:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------A7X9iAKAQsAJ4DD6TaBJvWWc"
Message-ID: <3512c6ae-0b99-4c50-89ed-f1087a558a25@kernel.dk>
Date: Tue, 21 Apr 2026 16:58:52 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
From: Jens Axboe <axboe@kernel.dk>
To: Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev,
 syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com
References: <20260413155819.042779211@linuxfoundation.org>
 <20260413155837.438151458@linuxfoundation.org>
 <d4b85e905345dc69e9c660c7f51775703fa83320.camel@decadent.org.uk>
 <d7d521e7-35bb-463b-b1f5-552bb931bdff@kernel.dk>
Content-Language: en-US
In-Reply-To: <d7d521e7-35bb-463b-b1f5-552bb931bdff@kernel.dk>
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel.dk:mid,kernel.dk:email]
X-Rspamd-Queue-Id: F000F4405E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------A7X9iAKAQsAJ4DD6TaBJvWWc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/26 4:18 PM, Jens Axboe wrote:
>>> @@ -6024,16 +6035,17 @@ static int io_poll_update(struct io_kioc
>>>  		if (req->poll_update.update_user_data)
>>>  			preq->user_data = req->poll_update.new_user_data;
>>>  
>>> -		ret2 = io_poll_add(preq, issue_flags);
>>> +		ret2 = __io_poll_add(preq, issue_flags);
>>>  		/* successfully updated, don't complete poll request */
>>>  		if (!ret2)
>>>  			goto out;
>>> +		preq->result = ret2;
>>> +
>>>  	}
>>> -	req_set_fail(preq);
>>> -	io_req_complete(preq, -ECANCELED);
>>> +	if (preq->result < 0)
>>> +		req_set_fail(preq);
>>> +	io_req_complete(preq, preq->result);
>>
>> If __io_poll_add() returned an events mask then it completed preq, but
>> then we also complete preq here.  Is that really correct?
> 
> Let me take a closer look, I do agree with you that the final result
> does not look entirely correct.

As far as I can tell, these two should be applied to 5.10 and 5.15
stable. The first one fixes an old backporting issue that I didn't
notice until doing some targeted testing just now. The second one should
take care of the issues that Ben spotted in the current backport.

Will be nice when 5.x is finally taken out behind the barn :-)

-- 
Jens Axboe
--------------A7X9iAKAQsAJ4DD6TaBJvWWc
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-fix-EPOLL_URING_WAKE-sometimes-not-bei.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-fix-EPOLL_URING_WAKE-sometimes-not-bei.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3ZmRmZmZjZTUwOGYzOGQ4OTMzOGU4YmJlZDQyMWRkOTFkZGZjYjNmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMjEgQXByIDIwMjYgMTY6NDE6MzIgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gaW9fdXJpbmcvcG9sbDogZml4IEVQT0xMX1VSSU5HX1dBS0Ugc29tZXRpbWVzIG5vdCBi
ZWluZwogbWFza2VkIGluCgpSYXRoZXIgdGhhbiBkbyBpdCBvbmx5IHdoZW4gd2UganVtcCBz
dHJhaWdodCB0byBleGVjdXRpb24sIG1hcmsgaXQKcmVnYXJkbGVzcy4gVGhpcyBlbnN1cmVz
IGl0IGRvZXNuJ3QgZ2V0IGxvc3QuCgpGaXhlczogY2NmMDZiNWE5ODFjICgiaW9fdXJpbmc6
IHBhc3MgaW4gRVBPTExfVVJJTkdfV0FLRSBmb3IgZXZlbnRmZCBzaWduYWxpbmcgYW5kIHdh
a2V1cHMiKQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0t
LQogaW9fdXJpbmcvaW9fdXJpbmcuYyB8IDE3ICsrKysrKysrLS0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCmluZGV4IDM4ZGVj
ZmMxYTkxNC4uZGI1YzlmYmRlYzNiIDEwMDY0NAotLS0gYS9pb191cmluZy9pb191cmluZy5j
CisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKQEAgLTU3OTQsMTcgKzU3OTQsMTYgQEAgc3Rh
dGljIGludCBpb19wb2xsX3dha2Uoc3RydWN0IHdhaXRfcXVldWVfZW50cnkgKndhaXQsIHVu
c2lnbmVkIG1vZGUsIGludCBzeW5jLAogCWlmIChtYXNrICYmICEobWFzayAmIHBvbGwtPmV2
ZW50cykpCiAJCXJldHVybiAwOwogCi0JaWYgKGlvX3BvbGxfZ2V0X293bmVyc2hpcChyZXEp
KSB7Ci0JCS8qCi0JCSAqIElmIHdlIHRyaWdnZXIgYSBtdWx0aXNob3QgcG9sbCBvZmYgb3Vy
IG93biB3YWtldXAgcGF0aCwKLQkJICogZGlzYWJsZSBtdWx0aXNob3QgYXMgdGhlcmUgaXMg
YSBjaXJjdWxhciBkZXBlbmRlbmN5IGJldHdlZW4KLQkJICogQ1EgcG9zdGluZyBhbmQgdHJp
Z2dlcmluZyB0aGUgZXZlbnQuCi0JCSAqLwotCQlpZiAobWFzayAmIEVQT0xMX1VSSU5HX1dB
S0UpCi0JCQlwb2xsLT5ldmVudHMgfD0gRVBPTExPTkVTSE9UOworCS8qCisJICogSWYgd2Ug
dHJpZ2dlciBhIG11bHRpc2hvdCBwb2xsIG9mZiBvdXIgb3duIHdha2V1cCBwYXRoLAorCSAq
IGRpc2FibGUgbXVsdGlzaG90IGFzIHRoZXJlIGlzIGEgY2lyY3VsYXIgZGVwZW5kZW5jeSBi
ZXR3ZWVuCisJICogQ1EgcG9zdGluZyBhbmQgdHJpZ2dlcmluZyB0aGUgZXZlbnQuCisJICov
CisJaWYgKG1hc2sgJiBFUE9MTF9VUklOR19XQUtFKQorCQlwb2xsLT5ldmVudHMgfD0gRVBP
TExPTkVTSE9UOwogCisJaWYgKGlvX3BvbGxfZ2V0X293bmVyc2hpcChyZXEpKQogCQlfX2lv
X3BvbGxfZXhlY3V0ZShyZXEsIG1hc2spOwotCX0KIAlyZXR1cm4gMTsKIH0KIAotLSAKMi41
My4wCgo=
--------------A7X9iAKAQsAJ4DD6TaBJvWWc
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-poll-fix-backport-of-io_poll_add-changes.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-poll-fix-backport-of-io_poll_add-changes.patch"
Content-Transfer-Encoding: base64

RnJvbSA3YTYxYzM4YzRkNmFlM2Q1Y2JlNmVmYTA2ODg1YjFjYTgyMWExMjljIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMjEgQXByIDIwMjYgMTY6NDQ6MDYgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gaW9fdXJpbmcvcG9sbDogZml4IGJhY2twb3J0IG9mIGlvX3BvbGxfYWRkKCkgY2hhbmdl
cwoKVGhlIDUuMTUvNS4xMCBiYWNrcG9ydCBvZiA4NDIzMGFkMmQyYWYgaGFkIGEgZmV3IGlz
c3VlcywgZHVlIHRvIHRoZQpvbGRlciBwb2xsIGJhc2UuIE5vdGFibHkgcmV0dXJuIHZhbHVl
IGhhbmRsaW5nIF9faW9fYXJtX3BvbGxfaGFuZGxlcigpCmFuZCBpbiByZXR1cm4gX19pb19w
b2xsX2FkZCgpIGFzIHdlbGwuIEZpeCB0aGVtIHVwLgoKUmVwb3J0ZWQtYnk6IEJlbiBIdXRj
aGluZ3MgPGJlbkBkZWNhZGVudC5vcmcudWs+CkZpeGVzOiAzNDllZjVkMmU3YmYgKCJpb191
cmluZy9wb2xsOiBjb3JyZWN0bHkgaGFuZGxlIGlvX3BvbGxfYWRkKCkgcmV0dXJuIHZhbHVl
IG9uIHVwZGF0ZSIpClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5k
az4KLS0tCiBpb191cmluZy9pb191cmluZy5jIHwgMTIgKysrKy0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCmluZGV4IGRiNWM5
ZmJkZWMzYi4uMDc1MTllOWE2OTVjIDEwMDY0NAotLS0gYS9pb191cmluZy9pb191cmluZy5j
CisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKQEAgLTYxMzgsMTkgKzYxMzgsMTUgQEAgc3Rh
dGljIGludCBfX2lvX3BvbGxfYWRkKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBp
bnQgaXNzdWVfZmxhZ3MpCiAJaWYgKCFyZXQgJiYgaXB0LmVycm9yKQogCQlyZXFfc2V0X2Zh
aWwocmVxKTsKIAlyZXQgPSByZXQgPzogaXB0LmVycm9yOwotCWlmIChyZXQgPiAwKSB7CisJ
aWYgKHJldCkKIAkJX19pb19yZXFfY29tcGxldGUocmVxLCBpc3N1ZV9mbGFncywgcmV0LCAw
KTsKLQkJcmV0dXJuIHJldDsKLQl9Ci0JcmV0dXJuIDA7CisJcmV0dXJuIHJldDsKIH0KIAog
c3RhdGljIGludCBpb19wb2xsX2FkZChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQg
aW50IGlzc3VlX2ZsYWdzKQogewotCWludCByZXQ7Ci0KLQlyZXQgPSBfX2lvX3BvbGxfYWRk
KHJlcSwgaXNzdWVfZmxhZ3MpOwotCXJldHVybiByZXQgPCAwID8gcmV0IDogMDsKKwlfX2lv
X3BvbGxfYWRkKHJlcSwgaXNzdWVfZmxhZ3MpOworCXJldHVybiAwOwogfQogCiBzdGF0aWMg
aW50IGlvX3BvbGxfdXBkYXRlKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQg
aXNzdWVfZmxhZ3MpCi0tIAoyLjUzLjAKCg==

--------------A7X9iAKAQsAJ4DD6TaBJvWWc--

