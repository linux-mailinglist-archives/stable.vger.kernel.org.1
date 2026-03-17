Return-Path: <stable+bounces-225982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AmUCnRRuWkoAgIAu9opvQ
	(envelope-from <stable+bounces-225982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:04:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE702AA6B4
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1731C30514B7
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264F53CAE61;
	Tue, 17 Mar 2026 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TnSrW0Xa"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F153C9EE7
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752459; cv=none; b=bKvF9dZmX/YLIywC3haBMY1OAm/iW2sIijlvAFT/ZbW5/C4ofkYdlSsDnEw5Bf3mkMbSrH2Dzwv0PAVRLPxyxKzHwIrnyydJl6JnxdsfEJooMfnah2k28SaPE1YmN8bEILqfvbFqD6h+hswxHI1SdNUwEsz9YMo6xLBObIpiSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752459; c=relaxed/simple;
	bh=VAlz5PesMaPnqiE3KTxc2ENgjGs1OBnll3VO0zb8pkc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=jZdMl5LUNCTcvtL0nxyPPjY6FQ+Fu7DSXkheiS76Rmqib0fBpY8VaFSYv9WhcElH5wZD51iWLDX/NNyN0S7d4WeESBQaOSb6QXbhzff/ixmbVOv8LrRQpNXClAXg463IpQdUnUTRp6BB8jZpTbiT/Ys5kMpj0zRGeLMOo19mnUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TnSrW0Xa; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so3862529fac.1
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773752456; x=1774357256; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lass1mjEICtVCK2vKchukj3E3Ua+Nz9KaTXHqfJbqcA=;
        b=TnSrW0Xa72V24iAhHYR4GPJSbUPhWjdER/ZUysAMBhSRUqvxx8OgbyLRDhLCGop6IB
         ERnuOOpi1xsM5WG4wXkCFV175SLFlTjbNhoZkAwmYprmvYneH1m/aIFNehkbz+8jnUFT
         ofSTh/mkncOeKJK5s44QM2jY1xLIWgsLnSoC6RKkzODWpLenNrgYFXsd+y1n0C5xz5q4
         hblx56UH8EJ/M6A3KP5S26KD/ukpbp3mQOhFo6ivSY4SoS6XD1V5GoK1QqFkMHXavLCD
         TMprWmNKevTimKigWGc6+C9mN4rKd84x3Nu6uD4L39VLso4A3cGD3yDNpmc/MhlGJQir
         +bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752456; x=1774357256;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lass1mjEICtVCK2vKchukj3E3Ua+Nz9KaTXHqfJbqcA=;
        b=LGIlKok4p5n0ud5C5PeeNxRuShj55CMaLHgKM9KGyEy7RcfwvKFGGcSXjNgKvhqngL
         xKUYJ3zskbwn6jxKwkHdvlVfucQMnnz1V2Vlxgw6OVZcbi83jH/6msSEnSSiFaZR2qGK
         whjDuAQEUNA7qu1QpufWdc87lbr1r4ES+vN7ZI40k+XVIeYuqEDCWt0YK3k6jw7dGT/j
         0AxpLjxT0ss3JQUp91mS65aV/TLfhwAG0AokJ2kuo1FXSkzI887nHFgMdkPfIOIsD5Qf
         Ppu9KH9YU3X/ZXmrhzSh0kTUSEec+rXySI5gNxYspMx7AC+kKYFIKpBMuurqE+omHDy0
         rkoQ==
X-Gm-Message-State: AOJu0YyqvRdNjFntmaYapP2qnFu1RUrVaNeovPWy4fdA6omwNX2Ba4M7
	FHXppebz/t2JTNi4SOMX2DmAhaj02Fc9O/CIYmq7DwzdoX38hojJ2sJGl4w4umKP92sj30QNtcO
	4Ba77S8E=
X-Gm-Gg: ATEYQzzEK2YAFCO4JGR1c4jNX49P828ZzfPZik708Cu1yXRXOjrRNcG7T7u/4HGaGUf
	219Ps2BV/3ucYcwM0ix00kypRC9oFFBkol+JSSvVqEujpn0IMTzbjXkOen879BA4dySHTpO1gmD
	RJzGfVolEp9CrkTSWY+ll0nZPh2N0cPhIlm3wNc16fKP1tH/I98FBIJzKWiD9Z/70Y8vRk1Jtm6
	DUw1C2SrYwdAGEnwS//TKGqwgkEnWHr05nFGzUvFeSDUrbuzZ6sx2L/r8nXt9BQdp8e4v03bkiy
	ynAbJvKGAMpI31NdZUlOHrO9Lg7FUbofYX/uKO1pJOMnzsoAzcrYqsxNi8v9nUiW6JNlGwc3Jdb
	DQSr1UUotjOSkOv3gsFLtn/HD+NnUQNsJvCLr8waFPmzpQTIJGSBvl+IRY+7V6Pv/dS3cWq7zrA
	ux+pKXdzmcJNOZhtr4dbhkUxVUBewi6/wfk1Z5oHzUh3W5guM3beRbzmF3Gd4+n7pqJ1eOv0+Gj
	mz81FVjHDyFXQIy/m8E
X-Received: by 2002:a05:6871:c8dc:b0:409:66f2:c281 with SMTP id 586e51a60fabf-417b944c6a7mr10508527fac.48.1773752456466;
        Tue, 17 Mar 2026 06:00:56 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1fb90csm19664271fac.4.2026.03.17.06.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 06:00:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------jR3gOkMuPpubfcpnLrR290cU"
Message-ID: <d016a6c7-3790-477f-8f8d-100d3b100afa@kernel.dk>
Date: Tue, 17 Mar 2026 07:00:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: check if target buffer list
 is still legacy on" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, keenanat2000@gmail.com
Cc: stable@vger.kernel.org
References: <2026031701-elsewhere-bulk-0f93@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026031701-elsewhere-bulk-0f93@gregkh>
X-Spamd-Result: default: False [-0.56 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225982-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: BCE702AA6B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------jR3gOkMuPpubfcpnLrR290cU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.1-stable.

-- 
Jens Axboe

--------------jR3gOkMuPpubfcpnLrR290cU
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-kbuf-check-if-target-buffer-list-is-still-l.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-kbuf-check-if-target-buffer-list-is-still-l.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzNTY2MGMwODA4NWRhZDE2OWU3MDgzMjY5OThhNTBlZjU5YWVmY2JjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTIgTWFyIDIwMjYgMDg6NTk6MjUgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9rYnVmOiBjaGVjayBpZiB0YXJnZXQgYnVmZmVyIGxpc3QgaXMgc3RpbGwgbGVn
YWN5IG9uCiByZWN5Y2xlCgpDb21taXQgYzJjMTg1YmU1Yzg1ZDM3MjE1Mzk3YzhlODc4MWFi
ZjBhNjliZWMxZiB1cHN0cmVhbS4KClRoZXJlJ3MgYSBnYXAgYmV0d2VlbiB3aGVuIHRoZSBi
dWZmZXIgd2FzIGdyYWJiZWQgYW5kIHdoZW4gaXQKcG90ZW50aWFsbHkgZ2V0cyByZWN5Y2xl
ZCwgd2hlcmUgaWYgdGhlIGxpc3QgaXMgZW1wdHksIHNvbWVvbmUgY291bGQndmUKdXBncmFk
ZWQgaXQgdG8gYSByaW5nIHByb3ZpZGVkIHR5cGUuIFRoaXMgY2FuIGhhcHBlbiBpZiB0aGUg
cmVxdWVzdAppcyBmb3JjZWQgdmlhIGlvLXdxLiBUaGUgbGVnYWN5IHJlY3ljbGluZyBpcyBt
aXNzaW5nIGNoZWNraW5nIGlmIHRoZQpidWZmZXJfbGlzdCBzdGlsbCBleGlzdHMsIGFuZCBp
ZiBpdCdzIG9mIHRoZSBjb3JyZWN0IHR5cGUuIEFkZCB0aG9zZQpjaGVja3MuCgpDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogYzdmYjE5NDI4ZDY3ICgiaW9fdXJpbmc6IGFk
ZCBzdXBwb3J0IGZvciByaW5nIG1hcHBlZCBzdXBwbGllZCBidWZmZXJzIikKUmVwb3J0ZWQt
Ynk6IEtlZW5hbiBEb25nIDxrZWVuYW5hdDIwMDBAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcva2J1Zi5jIHwg
OCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2tidWYuYyBiL2lvX3VyaW5nL2tidWYuYwpp
bmRleCBkMThmZTM5OTZkZGIuLjcwYTQ0ZDhlZjA5NCAxMDA2NDQKLS0tIGEvaW9fdXJpbmcv
a2J1Zi5jCisrKyBiL2lvX3VyaW5nL2tidWYuYwpAQCAtNjksOSArNjksMTUgQEAgdm9pZCBp
b19rYnVmX3JlY3ljbGVfbGVnYWN5KHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBp
c3N1ZV9mbGFncykKIAogCWJ1ZiA9IHJlcS0+a2J1ZjsKIAlibCA9IGlvX2J1ZmZlcl9nZXRf
bGlzdChjdHgsIGJ1Zi0+YmdpZCk7Ci0JbGlzdF9hZGQoJmJ1Zi0+bGlzdCwgJmJsLT5idWZf
bGlzdCk7CisJLyoKKwkgKiBJZiB0aGUgYnVmZmVyIGxpc3Qgd2FzIHVwZ3JhZGVkIHRvIGEg
cmluZy1iYXNlZCBvbmUsIG9yIHJlbW92ZWQsCisJICogd2hpbGUgdGhlIHJlcXVlc3Qgd2Fz
IGluLWZsaWdodCBpbiBpby13cSwgZHJvcCBpdC4KKwkgKi8KKwlpZiAoYmwgJiYgIWJsLT5i
dWZfbnJfcGFnZXMpCisJCWxpc3RfYWRkKCZidWYtPmxpc3QsICZibC0+YnVmX2xpc3QpOwog
CXJlcS0+ZmxhZ3MgJj0gflJFUV9GX0JVRkZFUl9TRUxFQ1RFRDsKIAlyZXEtPmJ1Zl9pbmRl
eCA9IGJ1Zi0+YmdpZDsKKwlyZXEtPmtidWYgPSBOVUxMOwogCiAJaW9fcmluZ19zdWJtaXRf
dW5sb2NrKGN0eCwgaXNzdWVfZmxhZ3MpOwogCXJldHVybjsKLS0gCjIuNTMuMAoK

--------------jR3gOkMuPpubfcpnLrR290cU--

