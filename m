Return-Path: <stable+bounces-203606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9BFCE6FEE
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8747130109A8
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5437431AA85;
	Mon, 29 Dec 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BECY0KHK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16661F5F6
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017927; cv=none; b=UL3n6NvC1OzTD9Ai4ULUl0XAEqv8Bm7GxgdZxT5ayXZObo5SCeEXivXrBUjEKFpV4uHKmFIVXiX00La4UyQgFljsqrtB4OCa22Vn5k5dxBZkD6fg8oQx5f8ke/4HRx0xaDc3qzaJISucXuIBNJHfRR12/GuycXaK/VGALIdLRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017927; c=relaxed/simple;
	bh=iQioimNfM5JkJxWwY6ZqRwdZ+ccJMEzJgH4jqBUyvyA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=sqrwQEk7h0EWlpl4hdDM8oidwDcp+fGSiQ/jxVAcd45rIc+GaCAwYojjv0MT6t1uNXrZArKc9D4UtSw+3rZjh9P/z4qbZ+/k+mlYr9DKxIbOOHEP7LXswFYIl+hYPgOzRtumiMfoOg4xaQ3j9etP3GvmGq7z4PQLCpCmiuq0LWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BECY0KHK; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c6e815310aso7420236a34.0
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 06:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767017924; x=1767622724; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWKqXTFcDpMplbAs7kKw205ClVmVbgpt3w11c6ULDBk=;
        b=BECY0KHKfumnq7XgsrLmw+ph6QPOEtogNnBHbescGe2+MAG/wLQgLHv0lX6AIcE7MM
         9cvDKEBD9pblxw/TX0orw6OsG6C+D2dYcu6r7/6Y82N5Ra+kVVCH9XVff43J/GwpJmD+
         FN+lliS/pWd66lUUHVWYF/M5v//VbmIgzzWS/EfT5WMVB9bAIRr1wLKVEeumt8VKoQio
         iNHsC61y8rKJj4FNbJ4IYrWM0XGbCy7dl9J2qpOGdcLTEohfGPwpnOSwnFKKk4GGm3dy
         4gnOf35qvn5ORK3O2FXVqYYWCaS0NQ6Mi+R6h41AMZo42MErrpZGnURiZMXpwVOF0dZ6
         rt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767017924; x=1767622724;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWKqXTFcDpMplbAs7kKw205ClVmVbgpt3w11c6ULDBk=;
        b=MxN0LLsMTfQI8t3zg+nz5a/NLQtYuHBdqct8jBTkBPeDfZwKE87mlYDF7KlOViMq+8
         dqlY2GdoHZRPmreVOTmt5g94cNf/YwCJAMMobVtnUA7ok/Gk7eVJts2sXz4G9g4xpFzG
         ZA3aInL41VO9Xw7JXouVFJhuMJZ92XBYUhaD23sdg9s57DXug4VCQmeF8UcFOcgCQBM2
         hrAaA4TLKEhP4y8mkMOS2ewmh0sbCTVmoqXlO3oiPBAjTpHD7habjnC35l3N9Fv20pXz
         Ub5NEfTsxSy8gvLLuxANqHu69IoiI40+2m6f+fq5l0V6vGse4SNeLGx2Na2OulZ2RNsR
         ME9w==
X-Gm-Message-State: AOJu0Yy3LYMbxik36lq5GCF645/Dv/Cna9ugktl0BRk0wjFqIUpmrIQs
	AsaO1wFXFQ2tTcCBOUPhi/diCg5LwPF1Nm5KVFKbAXzvChkekmaS0d6XtwtNq4qcs0wGlbnu0dd
	QTaIE
X-Gm-Gg: AY/fxX4hw3OcPmiY2jf2bV1ll6xm9zPc9sT8/ztab17q7ijDK8MWOmncujkksQm9UBR
	Ox3ksLgNFcPrN13zD4GeWsGIr9mSE8iiER/Li9UFnoiVQVif0/h248ui/gG5FJlRK4JGZ/jJy5Q
	LQEycuNO2lQfRCb1rgHz4TLoBJKGx3JNdXiDR60Axp7DPBp9GOIa5U3YCiM981wFrPJY3w25aXV
	Y7OmSmlRJMsmoLN2taJS61PSW/3nGxgy0gIW3gL9zhf2sSGzgvSJpDYBCHj1Zj7YKBWJW80b3PV
	00gF7OuK1pHmry03Un68VRUU4TOUQJVkPsnz3+XnuqicCvnaS/Ofly7wuF3UdTxsMdWN0NAkVe9
	G7O7MNxtal2BBlGU6Vazn9uoKAqxblhnRaX+nlxmAShGbHs+GsZLYNfCsg8aihK+D+s41CD+Dzr
	MU35rZac3n
X-Google-Smtp-Source: AGHT+IEuE4ya1nYlGffKfe9rk2rVoDu2+loxJK0bJApC1UwFip1wHV+4uyzuE9oBrPqDUGxaTHhcEg==
X-Received: by 2002:a05:6820:178:b0:659:9a49:8fe8 with SMTP id 006d021491bc7-65d0e9620c8mr11375659eaf.21.1767017923818;
        Mon, 29 Dec 2025 06:18:43 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f69ba9bsm18501279eaf.10.2025.12.29.06.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 06:18:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------h772bKuxGYSLedWczevbOAnJ"
Message-ID: <7fce4aa0-e145-41c3-9296-090642001dec@kernel.dk>
Date: Mon, 29 Dec 2025 07:18:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: correctly handle
 io_poll_add() return value on" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2025122911-bonding-sampling-8ca0@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025122911-bonding-sampling-8ca0@gregkh>

This is a multi-part message in MIME format.
--------------h772bKuxGYSLedWczevbOAnJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 5:22 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.12-stable.

-- 
Jens Axboe

--------------h772bKuxGYSLedWczevbOAnJ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-correctly-handle-io_poll_add-return-va.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-correctly-handle-io_poll_add-return-va.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhNDBmNWExMmQ2MmYyMGNlMmY5YzM2ODdiODgwMjE4YzA5ZTBjZDc0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMSBEZWMgMjAyNSAxMzoyNToyMiAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nL3BvbGw6IGNvcnJlY3RseSBoYW5kbGUgaW9fcG9sbF9hZGQoKSByZXR1cm4gdmFs
dWUgb24KIHVwZGF0ZQoKQ29tbWl0IDg0MjMwYWQyZDJhZmJmMGM0NGMzMjk2N2U1MjVjMGFk
OTJlMjZiNGUgdXBzdHJlYW0uCgpXaGVuIHRoZSBjb3JlIG9mIGlvX3VyaW5nIHdhcyB1cGRh
dGVkIHRvIGhhbmRsZSBjb21wbGV0aW9ucwpjb25zaXN0ZW50bHkgYW5kIHdpdGggZml4ZWQg
cmV0dXJuIGNvZGVzLCB0aGUgUE9MTF9SRU1PVkUgb3Bjb2RlCndpdGggdXBkYXRlcyBnb3Qg
c2xpZ2h0bHkgYnJva2VuLiBJZiBhIFBPTExfQUREIGlzIHBlbmRpbmcgYW5kCnRoZW4gUE9M
TF9SRU1PVkUgaXMgdXNlZCB0byB1cGRhdGUgdGhlIGV2ZW50cyBvZiB0aGF0IHJlcXVlc3Qs
IGlmIHRoYXQKdXBkYXRlIGNhdXNlcyB0aGUgUE9MTF9BREQgdG8gbm93IHRyaWdnZXIsIHRo
ZW4gdGhhdCBjb21wbGV0aW9uIGlzIGxvc3QKYW5kIGEgQ1FFIGlzIG5ldmVyIHBvc3RlZC4K
CkFkZGl0aW9uYWxseSwgZW5zdXJlIHRoYXQgaWYgYW4gdXBkYXRlIGRvZXMgY2F1c2UgYW4g
ZXhpc3RpbmcgUE9MTF9BREQKdG8gY29tcGxldGUsIHRoYXQgdGhlIGNvbXBsZXRpb24gdmFs
dWUgaXNuJ3QgYWx3YXlzIG92ZXJ3cml0dGVuIHdpdGgKLUVDQU5DRUxFRC4gRm9yIHRoYXQg
Y2FzZSwgd2hhdGV2ZXIgaW9fcG9sbF9hZGQoKSBzZXQgdGhlIHZhbHVlIHRvCnNob3VsZCBq
dXN0IGJlIHJldGFpbmVkLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDk3
YjM4OGQ3MGI1MyAoImlvX3VyaW5nOiBoYW5kbGUgY29tcGxldGlvbnMgaW4gdGhlIGNvcmUi
KQpSZXBvcnRlZC1ieTogc3l6Ym90KzY0MWVlYzZiN2FmMWY2MmYyYjk5QHN5emthbGxlci5h
cHBzcG90bWFpbC5jb20KVGVzdGVkLWJ5OiBzeXpib3QrNjQxZWVjNmI3YWYxZjYyZjJiOTlA
c3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxh
eGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvcG9sbC5jIHwgOSArKysrKysrLS0KIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvaW9fdXJpbmcvcG9sbC5jIGIvaW9fdXJpbmcvcG9sbC5jCmluZGV4IGJmZGI1Mzc1
NzJmNy4uYzgzM2ZkMThkMGVmIDEwMDY0NAotLS0gYS9pb191cmluZy9wb2xsLmMKKysrIGIv
aW9fdXJpbmcvcG9sbC5jCkBAIC0xMDM4LDEyICsxMDM4LDE3IEBAIGludCBpb19wb2xsX3Jl
bW92ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQog
CiAJCXJldDIgPSBpb19wb2xsX2FkZChwcmVxLCBpc3N1ZV9mbGFncyAmIH5JT19VUklOR19G
X1VOTE9DS0VEKTsKIAkJLyogc3VjY2Vzc2Z1bGx5IHVwZGF0ZWQsIGRvbid0IGNvbXBsZXRl
IHBvbGwgcmVxdWVzdCAqLwotCQlpZiAoIXJldDIgfHwgcmV0MiA9PSAtRUlPQ0JRVUVVRUQp
CisJCWlmIChyZXQyID09IElPVV9JU1NVRV9TS0lQX0NPTVBMRVRFKQogCQkJZ290byBvdXQ7
CisJCS8qIHJlcXVlc3QgY29tcGxldGVkIGFzIHBhcnQgb2YgdGhlIHVwZGF0ZSwgY29tcGxl
dGUgaXQgKi8KKwkJZWxzZSBpZiAocmV0MiA9PSBJT1VfT0spCisJCQlnb3RvIGNvbXBsZXRl
OwogCX0KIAotCXJlcV9zZXRfZmFpbChwcmVxKTsKIAlpb19yZXFfc2V0X3JlcyhwcmVxLCAt
RUNBTkNFTEVELCAwKTsKK2NvbXBsZXRlOgorCWlmIChwcmVxLT5jcWUucmVzIDwgMCkKKwkJ
cmVxX3NldF9mYWlsKHByZXEpOwogCXByZXEtPmlvX3Rhc2tfd29yay5mdW5jID0gaW9fcmVx
X3Rhc2tfY29tcGxldGU7CiAJaW9fcmVxX3Rhc2tfd29ya19hZGQocHJlcSk7CiBvdXQ6Ci0t
IAoyLjUxLjAKCg==

--------------h772bKuxGYSLedWczevbOAnJ--

