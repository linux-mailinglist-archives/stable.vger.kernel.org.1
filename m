Return-Path: <stable+bounces-177917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5581B467F7
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 03:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7907BE908
	for <lists+stable@lfdr.de>; Sat,  6 Sep 2025 01:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A00717A2E8;
	Sat,  6 Sep 2025 01:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kd+Jywjj"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95E18E3F
	for <stable@vger.kernel.org>; Sat,  6 Sep 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757121786; cv=none; b=P4D2tbjSxzTeKKQZf/zD0XQspDH1q1BRRwfkRxc9gohqWHyglEZWQV3hl9jcNMJiQcq8PcSqvEgkjsQnSyCy58viq0mzlshDYZQFsFEp9olG0T4uYXzwPZl+adLjb2DkvLEc09bT4i3mEPPW40OGD6QiLIBwa82m3gX59T2m4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757121786; c=relaxed/simple;
	bh=mf+rej9vS1ju1RiBQZDkQEwtlSk2HxNPZfgZWyBRiYA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=tofUiNPtTBn+OOETJ4zcBksIFHGrkZk7QzH2S03ljdh7XJKbLxec8AcjX0HKPH9ew6sq4yXvVRtxQ2D3pOoIQlfsZv8zGWC/sgeKPZCCYtBctJmL6N6nSYGlSVchI1a6A8/dv57Emccu/Ms4W2jm53U237dskAU/zC6EbxHxI60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kd+Jywjj; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e98b75eb577so3075309276.1
        for <stable@vger.kernel.org>; Fri, 05 Sep 2025 18:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757121782; x=1757726582; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nBUBT3L9uK2WCevTmIF1+knbvuZuIMEpp//7yXt1gc=;
        b=kd+Jywjjs/2OtR1Fl+xSt2CJoFeEdVVWA/bO6I5cOSmprfu85T1TDGHn1PXfHPr+G0
         kPzMjydVRKCOSfqT8KLrrnQtbtMQhgrEl5DD2kiTqcwgf/OmquyoUGsblTaEuwsZrzfh
         Nn/488HgYCz3XRX60UNEe7jUqKFb2nDTs5I2EWCuun418oHrUVi4Qy5cUjHM6kgfu2A0
         /ByKN+P5NYUa40Qaqlksd5lUKzNMH5gXLCJmt/sdaO1VuXgAup7Tn9DYRgh3zHIzssq6
         LH/lYrgyGXZkC7q261KgGy2TGcu5fNWYARRHZrOwid2kQhZHCCDEPR+My7f5SqFUPeRa
         aKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757121782; x=1757726582;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7nBUBT3L9uK2WCevTmIF1+knbvuZuIMEpp//7yXt1gc=;
        b=d4mu1g/pUn4hTiUdWGS9iqbKAHd0JVdPbqdLYsCg3jwMLkmVYb1YtSS4iIeTVb2Zii
         Th3T8gEHH7YhINMQHs3sqhn+BL3q7RgbKR/C4GB4GtU+v96BvssX7bt2Ba9JtMQ/k4ss
         Vrq8HCN4I9ebqpV4UO1cPeWVKSB2FHeABec9gNfzj7MXBRhStGtJraVdNTvN/ToJc/Sw
         TdmbjkR7ynxyOqKq3wItsAldACQBGpJc3HNhyOHTh1yhqwBf4xSbHPonlaPuyxB3ICHu
         7Ccs9yCbbSnl9dPEz8U6cKOQF9eL+m687L+P5yRSvRFLCbBG+bw/0RYxQJmeuPry1xdA
         1xDw==
X-Forwarded-Encrypted: i=1; AJvYcCVglC15mSj4VAI9VE0qPfIlN81DUv3xQTuc2KRRENmK4RAlVU+w6t5vtMgNqSyt6PiIedeAnu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxWIJxAPNShYhY3FIYub/8D+v4LcYd6QVDK8Ox0/hcPkiueZGQ
	N58VSB+bRCSGFRO6GhwtafVxCqsOv/wujjDULTb4vHCV2D9IST6XMjEiQvkasEv0ln0=
X-Gm-Gg: ASbGnctA7KOmMBizLgrDbeezhPBbTLYozWY5QT2xZgejngCW9scYtxQHnfcCB6jcVO+
	0/tNl2pRBLbwD0GaojTW0vWI3t9gRRh1VRF4O1L5SZxRp3MkbA/4jjqxSWM9XYkqBXYl0xsACZp
	T9jr+xN9IMBsKOYBglD2PB8jr7fjPfmaonDCGndshSgHODd65BenCWKF/6XHIKOvMT1n4BfWFcf
	dSLZpHwehGOQbi57QawslAtLw62G0X8Tk8mhICvc7QkO5NEHMWLoRWZcdwWhPhdSeDcsCMWh+el
	br5gj5xLtCe0CqBa4GOz3bqoB6Gwcl2a7OjdwNtE39Ri9fiWi4LgHKWClVPeuHCWeB0d9GZuxCS
	YHnkumFsQXHdPyX10QlE=
X-Google-Smtp-Source: AGHT+IHP+konxWyNQLlCGc+fM2fS8TY1g6xEQGVgKo47hw8J2bAGOLUQ+4uFaZDwEwHf3EyoDfyF4w==
X-Received: by 2002:a05:690e:23c2:b0:5f3:317e:409f with SMTP id 956f58d0204a3-60b63eb9508mr3027857d50.3.1757121781646;
        Fri, 05 Sep 2025 18:23:01 -0700 (PDT)
Received: from [172.17.0.109] ([50.168.186.2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a850287fsm34002027b3.47.2025.09.05.18.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 18:23:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------FYqkBqQtnHPkO04kcVamWQrq"
Message-ID: <96857683-167a-4ba8-ad26-564e5dcae79b@kernel.dk>
Date: Fri, 5 Sep 2025 19:23:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 11/15] io_uring/msg_ring: ensure io_kiocb freeing
 is deferred for RCU
From: Jens Axboe <axboe@kernel.dk>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org
Cc: vegard.nossum@oracle.com,
 syzbot+54cbbfb4db9145d26fc2@syzkaller.appspotmail.com
References: <20250905110406.3021567-1-harshit.m.mogalapalli@oracle.com>
 <20250905110406.3021567-12-harshit.m.mogalapalli@oracle.com>
 <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>
Content-Language: en-US
In-Reply-To: <f43fe976-4ef5-4dea-a2d0-336456a4deae@kernel.dk>

This is a multi-part message in MIME format.
--------------FYqkBqQtnHPkO04kcVamWQrq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/25 1:58 PM, Jens Axboe wrote:
> On 9/5/25 5:04 AM, Harshit Mogalapalli wrote:
>> diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
>> index 5ce332fc6ff5..3b27d9bcf298 100644
>> --- a/include/linux/io_uring_types.h
>> +++ b/include/linux/io_uring_types.h
>> @@ -648,6 +648,8 @@ struct io_kiocb {
>>  	struct io_task_work		io_task_work;
>>  	/* for polled requests, i.e. IORING_OP_POLL_ADD and async armed poll */
>>  	struct hlist_node		hash_node;
>> +	/* for private io_kiocb freeing */
>> +	struct rcu_head		rcu_head;
>>  	/* internal polling, see IORING_FEAT_FAST_POLL */
>>  	struct async_poll		*apoll;
>>  	/* opcode allocated if it needs to store data for async defer */
> 
> This should go into a union with hash_node, rather than bloat the
> struct. That's how it was done upstream, not sure why this one is
> different?

Here's a test variant with that sorted. Greg, I never got a FAILED email
on this one, as far as I can tell. When a patch is marked with CC:
stable@vger.kernel.org and the origin of the bug clearly marked with
Fixes, I'm expecting to have a 100% reliable notification if it fails to
apply. If not, I just kind of assume patches flow into stable.

Was this missed on my side, or was it on the stable side? If the latter,
how did that happen? I always ensure that stable has what it needs and
play nice on my side, but if misses like this can happen with the
tooling, that makes me a bit nervous.

-- 
Jens Axboe
--------------FYqkBqQtnHPkO04kcVamWQrq
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-msg_ring-ensure-io_kiocb-freeing-is-deferre.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-msg_ring-ensure-io_kiocb-freeing-is-deferre.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBmOGUxM2MzZjMwMjc0ODFhYjdiMmJlZmU0ZDA2ZWQzNzI1NDc0MjBkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgOCBKdWwgMjAyNSAxMTowMDozMiAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nL21zZ19yaW5nOiBlbnN1cmUgaW9fa2lvY2IgZnJlZWluZyBpcyBkZWZlcnJlZCBm
b3IKIFJDVQoKQ29tbWl0IGZjNTgyY2QyNmU4ODhiMDY1MmJjMTQ5NGYyNTIzMjk0NTNmZDNi
MjMgdXBzdHJlYW0uCgpzeXpib3QgcmVwb3J0cyB0aGF0IGRlZmVyL2xvY2FsIHRhc2tfd29y
ayBhZGRpbmcgdmlhIG1zZ19yaW5nIGNhbiBoaXQKYSByZXF1ZXN0IHRoYXQgaGFzIGJlZW4g
ZnJlZWQ6CgpDUFU6IDEgVUlEOiAwIFBJRDogMTkzNTYgQ29tbTogaW91LXdyay0xOTM1NCBO
b3QgdGFpbnRlZCA2LjE2LjAtcmM0LXN5emthbGxlci0wMDEwOC1nMTdiYmRlMmUxNzE2ICMw
IFBSRUVNUFQoZnVsbCkKSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2dsZSBDb21wdXRlIEVu
Z2luZS9Hb29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgR29vZ2xlIDA1LzA3LzIwMjUKQ2Fs
bCBUcmFjZToKIDxUQVNLPgogZHVtcF9zdGFja19sdmwrMHgxODkvMHgyNTAgbGliL2R1bXBf
c3RhY2suYzoxMjAKIHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24gbW0va2FzYW4vcmVwb3J0
LmM6NDA4IFtpbmxpbmVdCiBwcmludF9yZXBvcnQrMHhkMi8weDJiMCBtbS9rYXNhbi9yZXBv
cnQuYzo1MjEKIGthc2FuX3JlcG9ydCsweDExOC8weDE1MCBtbS9rYXNhbi9yZXBvcnQuYzo2
MzQKIGlvX3JlcV9sb2NhbF93b3JrX2FkZCBpb191cmluZy9pb191cmluZy5jOjExODQgW2lu
bGluZV0KIF9faW9fcmVxX3Rhc2tfd29ya19hZGQrMHg1ODkvMHg5NTAgaW9fdXJpbmcvaW9f
dXJpbmcuYzoxMjUyCiBpb19tc2dfcmVtb3RlX3Bvc3QgaW9fdXJpbmcvbXNnX3JpbmcuYzox
MDMgW2lubGluZV0KIGlvX21zZ19kYXRhX3JlbW90ZSBpb191cmluZy9tc2dfcmluZy5jOjEz
MyBbaW5saW5lXQogX19pb19tc2dfcmluZ19kYXRhKzB4ODIwLzB4YWEwIGlvX3VyaW5nL21z
Z19yaW5nLmM6MTUxCiBpb19tc2dfcmluZ19kYXRhIGlvX3VyaW5nL21zZ19yaW5nLmM6MTcz
IFtpbmxpbmVdCiBpb19tc2dfcmluZysweDEzNC8weGEwMCBpb191cmluZy9tc2dfcmluZy5j
OjMxNAogX19pb19pc3N1ZV9zcWUrMHgxN2UvMHg0YjAgaW9fdXJpbmcvaW9fdXJpbmcuYzox
NzM5CiBpb19pc3N1ZV9zcWUrMHgxNjUvMHhmZDAgaW9fdXJpbmcvaW9fdXJpbmcuYzoxNzYy
CiBpb193cV9zdWJtaXRfd29yaysweDZlOS8weGI5MCBpb191cmluZy9pb191cmluZy5jOjE4
NzQKIGlvX3dvcmtlcl9oYW5kbGVfd29yaysweDdjZC8weDExODAgaW9fdXJpbmcvaW8td3Eu
Yzo2NDIKIGlvX3dxX3dvcmtlcisweDQyZi8weGViMCBpb191cmluZy9pby13cS5jOjY5Ngog
cmV0X2Zyb21fZm9yaysweDNmYy8weDc3MCBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jOjE0
OAogcmV0X2Zyb21fZm9ya19hc20rMHgxYS8weDMwIGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0
LlM6MjQ1CiA8L1RBU0s+Cgp3aGljaCBpcyBzdXBwb3NlZCB0byBiZSBzYWZlIHdpdGggaG93
IHJlcXVlc3RzIGFyZSBhbGxvY2F0ZWQuIEJ1dCBtc2cKcmluZyByZXF1ZXN0cyBhbGxvYyBh
bmQgZnJlZSBvbiB0aGVpciBvd24sIGFuZCBoZW5jZSBtdXN0IGRlZmVyIGZyZWVpbmcKdG8g
YSBzYW5lIHRpbWUuCgpBZGQgYW4gcmN1X2hlYWQgYW5kIHVzZSBrZnJlZV9yY3UoKSBpbiBi
b3RoIHNwb3RzIHdoZXJlIHJlcXVlc3RzIGFyZQpmcmVlZC4gT25seSB0aGUgb25lIGluIGlv
X21zZ190d19jb21wbGV0ZSgpIGlzIHN0cmljdGx5IHJlcXVpcmVkIGFzIGl0CmhhcyBiZWVu
IHZpc2libGUgb24gdGhlIG90aGVyIHJpbmcsIGJ1dCB1c2UgaXQgY29uc2lzdGVudGx5IGlu
IHRoZSBvdGhlcgpzcG90IGFzIHdlbGwuCgpUaGlzIHNob3VsZCBub3QgY2F1c2UgYW55IG90
aGVyIGlzc3VlcyBvdXRzaWRlIG9mIEtBU0FOIHJpZ2h0ZnVsbHkKY29tcGxhaW5pbmcgYWJv
dXQgaXQuCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9pby11cmluZy82ODZjZDJl
YS5hMDBhMDIyMC4zMzgwMzMuMDAwNy5HQUVAZ29vZ2xlLmNvbS8KUmVwb3J0ZWQtYnk6IHN5
emJvdCs1NGNiYmZiNGRiOTE0NWQyNmZjMkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNj
OiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAwNjE3YmI1MDBiZmEgKCJpb191cmlu
Zy9tc2dfcmluZzogaW1wcm92ZSBoYW5kbGluZyBvZiB0YXJnZXQgQ1FFIHBvc3RpbmciKQpT
aWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CihjaGVycnkgcGlj
a2VkIGZyb20gY29tbWl0IGZjNTgyY2QyNmU4ODhiMDY1MmJjMTQ5NGYyNTIzMjk0NTNmZDNi
MjMpCi0tLQogaW5jbHVkZS9saW51eC9pb191cmluZ190eXBlcy5oIHwgMTIgKysrKysrKysr
Ky0tCiBpb191cmluZy9tc2dfcmluZy5jICAgICAgICAgICAgfCAgNCArKy0tCiAyIGZpbGVz
IGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9pb191cmluZ190eXBlcy5oIGIvaW5jbHVkZS9saW51eC9pb191
cmluZ190eXBlcy5oCmluZGV4IDVjZTMzMmZjNmZmNS4uNjE2NzVlYTk1ZTBiIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L2lvX3VyaW5nX3R5cGVzLmgKKysrIGIvaW5jbHVkZS9saW51
eC9pb191cmluZ190eXBlcy5oCkBAIC02NDYsOCArNjQ2LDE2IEBAIHN0cnVjdCBpb19raW9j
YiB7CiAJYXRvbWljX3QJCQlyZWZzOwogCWJvb2wJCQkJY2FuY2VsX3NlcV9zZXQ7CiAJc3Ry
dWN0IGlvX3Rhc2tfd29yawkJaW9fdGFza193b3JrOwotCS8qIGZvciBwb2xsZWQgcmVxdWVz
dHMsIGkuZS4gSU9SSU5HX09QX1BPTExfQUREIGFuZCBhc3luYyBhcm1lZCBwb2xsICovCi0J
c3RydWN0IGhsaXN0X25vZGUJCWhhc2hfbm9kZTsKKwl1bmlvbiB7CisJCS8qCisJCSAqIGZv
ciBwb2xsZWQgcmVxdWVzdHMsIGkuZS4gSU9SSU5HX09QX1BPTExfQUREIGFuZCBhc3luYyBh
cm1lZAorCQkgKiBwb2xsCisJCSAqLworCQlzdHJ1Y3QgaGxpc3Rfbm9kZQloYXNoX25vZGU7
CisKKwkJLyogZm9yIHByaXZhdGUgaW9fa2lvY2IgZnJlZWluZyAqLworCQlzdHJ1Y3QgcmN1
X2hlYWQJCXJjdV9oZWFkOworCX07CiAJLyogaW50ZXJuYWwgcG9sbGluZywgc2VlIElPUklO
R19GRUFUX0ZBU1RfUE9MTCAqLwogCXN0cnVjdCBhc3luY19wb2xsCQkqYXBvbGw7CiAJLyog
b3Bjb2RlIGFsbG9jYXRlZCBpZiBpdCBuZWVkcyB0byBzdG9yZSBkYXRhIGZvciBhc3luYyBk
ZWZlciAqLwpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvbXNnX3JpbmcuYyBiL2lvX3VyaW5nL21z
Z19yaW5nLmMKaW5kZXggMzViMWI1ODVlOWNiLi5iNjhlMDA5YmNlMjEgMTAwNjQ0Ci0tLSBh
L2lvX3VyaW5nL21zZ19yaW5nLmMKKysrIGIvaW9fdXJpbmcvbXNnX3JpbmcuYwpAQCAtODIs
NyArODIsNyBAQCBzdGF0aWMgdm9pZCBpb19tc2dfdHdfY29tcGxldGUoc3RydWN0IGlvX2tp
b2NiICpyZXEsIHN0cnVjdCBpb190d19zdGF0ZSAqdHMpCiAJCXNwaW5fdW5sb2NrKCZjdHgt
Pm1zZ19sb2NrKTsKIAl9CiAJaWYgKHJlcSkKLQkJa21lbV9jYWNoZV9mcmVlKHJlcV9jYWNo
ZXAsIHJlcSk7CisJCWtmcmVlX3JjdShyZXEsIHJjdV9oZWFkKTsKIAlwZXJjcHVfcmVmX3B1
dCgmY3R4LT5yZWZzKTsKIH0KIApAQCAtOTEsNyArOTEsNyBAQCBzdGF0aWMgaW50IGlvX21z
Z19yZW1vdGVfcG9zdChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgc3RydWN0IGlvX2tpb2Ni
ICpyZXEsCiB7CiAJcmVxLT50YXNrID0gUkVBRF9PTkNFKGN0eC0+c3VibWl0dGVyX3Rhc2sp
OwogCWlmICghcmVxLT50YXNrKSB7Ci0JCWttZW1fY2FjaGVfZnJlZShyZXFfY2FjaGVwLCBy
ZXEpOworCQlrZnJlZV9yY3UocmVxLCByY3VfaGVhZCk7CiAJCXJldHVybiAtRU9XTkVSREVB
RDsKIAl9CiAJcmVxLT5vcGNvZGUgPSBJT1JJTkdfT1BfTk9QOwotLSAKMi41MS4wCgo=

--------------FYqkBqQtnHPkO04kcVamWQrq--

