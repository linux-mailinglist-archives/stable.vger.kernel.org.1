Return-Path: <stable+bounces-215694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABovLyeqi2naYAAAu9opvQ
	(envelope-from <stable+bounces-215694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 22:59:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B2311F947
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 22:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7977A302A2DD
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 21:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0AE331A77;
	Tue, 10 Feb 2026 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BdUOQQtE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60253321C8
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770760730; cv=none; b=XHswmzwx+9qF6D5IYkKI0AZTjAgmKfh6Qy9e249gTjzjQcPVIxyoeM9rz63jCoPaF3UhYMa02O9LU8eIydnn1mVgYxHGX2I4KV0xPxUDySXcLyglkxLnaUQ3ErhGgrFIMMEwaBrHSdFxl6VQ5CxfDY5PNB7I69yw8YM/+fFp48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770760730; c=relaxed/simple;
	bh=o1pAZToFHKjXfyv5shJjrm1Qhbi6A4w+s9RNmG+qjv0=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=PEgOvFW9Vobv8a3lRpA3FEZ/AyXrS6pAuk+FjZQNNYKBZLBUtwZd7wcQqAFD6ZWGQDZ5qkKCubT16VEZEdMwF3jpKDY1W780AZaZPnz6RGIpfLuSouq8vt/c1JXkxS5jJIo2ScTKjhFK9WGoqBrgZt54tAagGLzI/h6w4jF5r1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BdUOQQtE; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d18d9503eeso1151257a34.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 13:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770760727; x=1771365527; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ypb/2aQP2AuZZypbrhbpDUZTZ5qclsCF8qYGQzw4cVs=;
        b=BdUOQQtEhA6+xVjiIzj/mfoalVOp6ZbKS3Pg9cPVpguKON0nr/pz9lHkEqVzeDOJZp
         TqEbV8rUhZJCL6GjYfkEDa8wYQx6vkPGUn5efAFQmNsz91VkZSmzTc67RYx80BBzqBjx
         Ptz3tvS8ETd7t5LO2SwvQxkj+JX1rycSP35Bf+J6nxYv/wHKrqiqLkxxEZ5QsBStuxqV
         6F4W1JpiY7djbBqUVuIQTmsCoIWhFzDTEzi6wsIVNJt3W/XcSLuiFzllg8sdqwsIVb90
         8hxV8xunbcBGFYDkzU7l57KvGKPnt3iRM1tpmk2pQ/h9M3rczHJba6jpyGLImXn9b1UU
         QVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770760727; x=1771365527;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypb/2aQP2AuZZypbrhbpDUZTZ5qclsCF8qYGQzw4cVs=;
        b=qk5/C4e8k/POuT8OEDl61/431QQjBVur/8ztsK/0+1zdfrjKdjcw3eRera2OTDIup3
         FMPOUIDYv/SY4qmT/nRWma9CxURYuGA1ai/hwziDRmhp+Rk35JG2A5z6XY8Pk5AJ75m+
         p9AgJb0fobePQ/7a5ZOtaN4bC+chsnExFV9ZqECiOi3gyA+NHYqChXrJB8hHef/AH9Dn
         5XCikFlnctNboIBynIcOklj94czsZRhAvMENu8aUjWAM08frGsVuCPNTzwfAf64Q38dE
         J7nItrIT4Pfa/mf+FV7w0DRQz1q0sWOIc7XtcUPJOquLj4eZ5qfh690A+up4tgzClT1j
         lv3A==
X-Gm-Message-State: AOJu0YwUNHi3HGihyXNUTwjOFMo/8eFCqlyAvk1OE9Xcg9+hYTdBrP68
	kBN04aC6tGOfZqeABRQ6lm++1GgyKpIMsNgUCj4XlLuUc2aAO2NVUAxPo58FVU8W92Q8XrnK6hq
	xvfrebC4=
X-Gm-Gg: AZuq6aKhgztuu2If8LXKkWmREzmMmv7ZEJEp3E8gxLkUf2RlYYKeEMQI5VagXz+BfCu
	FF12qBLLuk2pBmr21/L8M05IJpWuSgrTr8itKoSmBdE0QAuRmzKUiVlgQY5xUXw1oKR3fDqN+r+
	QKchRj/1NuChyYbhNCJgzkLZ7PMy+L7BWoqQlUpjYFWG5YExEWtfS0K49Dfs15IfdvXIHttBG2o
	I7rEqEl8GIGfX3vuuB0xjA+OP4AY12k9T11HSjEjkTxq60pAEwEiCoP/IRCa5Xqhe4E9QgszmO1
	T0FNuYhHpEg/0ZW9Wcb2hC5kBqqnmGBFTZCrXyqpYQq5UpiID5dNMI1Cs3Tl9yckbW1XVdCFMus
	Iv1eUNgb1NUtzDTzmuk3IktF/5t707xnHrC1+XUizrFhlkfw/AfQ9EuqL7hhZEvmYa9kokzjH46
	Bov0f7uRsJtzvs8S0wX+k8uUIwGxxPka/Dq5CRVC3Ft2RZDx4heJoWmVn+cLd7QyHAKMdTB+Yag
	VQecfMn
X-Received: by 2002:a05:6830:d8b:b0:7cf:e539:dcf0 with SMTP id 46e09a7af769-7d464408133mr10088923a34.10.1770760727211;
        Tue, 10 Feb 2026 13:58:47 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4646fb56dsm10672131a34.3.2026.02.10.13.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 13:58:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------3riiYxJ775NHx0tlyS1Rjj0r"
Message-ID: <51b76881-90fa-4de3-9c39-68d076b5706f@kernel.dk>
Date: Tue, 10 Feb 2026 14:58:45 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: 6.12-stable inclusion request
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-215694-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18B2311F947
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------3riiYxJ775NHx0tlyS1Rjj0r
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

See:

https://github.com/axboe/liburing/issues/1530

for the reasonings here, but please add this patch to the 6.12-stable
queue. Thanks!

-- 
Jens Axboe


--------------3riiYxJ775NHx0tlyS1Rjj0r
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-rw-recycle-buffers-manually-for-non-mshot-r.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-rw-recycle-buffers-manually-for-non-mshot-r.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhMmQyYmFkNzQ4NWQyYWY4ZGM1NjRjODU2NTgzOWIyM2EzZjgyMDVkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFdlZCwgMjAgQXVnIDIwMjUgMjA6MDM6MzUgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9ydzogcmVjeWNsZSBidWZmZXJzIG1hbnVhbGx5IGZvciBub24tbXNob3QgcmVh
ZHMKCkNvbW1pdCBkOGUxZGVjMmY4NjBlZTQwNjIzNjA5YWE2YzRmMjJlMWVlNDU2MDVkIHVw
c3RyZWFtLgoKVGhlIG1zaG90IHNpZGUgb2YgcmVhZHMgYWxyZWFkeSBkb2VzIHRoaXMsIGJ1
dCB0aGUgcmVndWxhciByZWFkIHBhdGgKZG9lcyBub3QuIFRoaXMgbGVhZHMgdG8gbmVlZGlu
ZyByZWN5Y2xpbmcgY2hlY2tzIHNwcmlua2xlZCBpbiB2YXJpb3VzCnNwb3RzIGluIHRoZSAi
Z28gYXN5bmMiIHBhdGgsIGxpa2UgYXJtaW5nIHBvbGwuIEluIHByZXBhcmF0aW9uIGZvcgpn
ZXR0aW5nIHJpZCBvZiB0aG9zZSwgZW5zdXJlIHRoYXQgcmVhZCByZWN5Y2xlcyBhcHByb3By
aWF0ZWx5LgoKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDgyMTAyMDc1
MC41OTg0MzItOC1heGJvZUBrZXJuZWwuZGsKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8
YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5nL3J3LmMgfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvcncuYyBiL2lv
X3VyaW5nL3J3LmMKaW5kZXggOTk2Y2Q0YmVjNDgyLi4xYTM4YjM1NzgzNjcgMTAwNjQ0Ci0t
LSBhL2lvX3VyaW5nL3J3LmMKKysrIGIvaW9fdXJpbmcvcncuYwpAQCAtOTUzLDYgKzk1Myw4
IEBAIGludCBpb19yZWFkKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNz
dWVfZmxhZ3MpCiAJaWYgKHJldCA+PSAwKQogCQlyZXR1cm4ga2lvY2JfZG9uZShyZXEsIHJl
dCwgaXNzdWVfZmxhZ3MpOwogCisJaWYgKHJlcS0+ZmxhZ3MgJiBSRVFfRl9CVUZGRVJTX0NP
TU1JVCkKKwkJaW9fa2J1Zl9yZWN5Y2xlKHJlcSwgaXNzdWVfZmxhZ3MpOwogCXJldHVybiBy
ZXQ7CiB9CiAKLS0gCjIuNTEuMAoK

--------------3riiYxJ775NHx0tlyS1Rjj0r--

