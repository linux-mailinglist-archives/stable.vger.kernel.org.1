Return-Path: <stable+bounces-81459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D39993537
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70321C2229F
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EF31DD896;
	Mon,  7 Oct 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yM1Uiwmv"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D368C13632B
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322957; cv=none; b=NNVQpLwUBNQzuCuQOlWQxVRxO2AgaC8V5v0fJvQKghzqI1dKnXyl4/k6fWdwEOMva0Dj6MihgRce3O3I/lu26E2/PmH0H27GvIJP0sf12fI+iADpuWKLc6iJu4w/WviNK8uL8uemz5ZcfPp6DQt4ls6BVK9/R0LAapNq0+wfDxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322957; c=relaxed/simple;
	bh=w6ZnCNt1Vqg3icH/I290wMUm2+4XbFE9JVYOmCHrHQc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=MmdvjsAbkbkd14DocBW7LFOKt/LEgiDAv+X030eNLvsUTz86cdLzhV+qof90eLIe07xzRLkxVHoorDXJo8wy602RQm1A5R9w4NPRlwZrT8V5tObwqPG51dMq5PWaBRB/jSU3belIr+RgXsVZXNAjA0j8Z0YMJg+gnobV9KLfqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yM1Uiwmv; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a2761f1227so15746435ab.0
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 10:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728322953; x=1728927753; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS5NA1ThaEVnkiTkM/GVrPYk7r9jGIHbFBqyFUVNhbA=;
        b=yM1UiwmvkZFoaq/Ei8cNSBRBtnk5vg1J11KUOn7cR+dTb4T7+R+dzcpYpCghQqiCxd
         NEtOZOkrjwG85HeSkCFeulYnZ4ML8d00vXp6ziDhBWEedf1H9Q1JlF1NuHG+mMRE75M8
         lh0ni7gMgwyp4VmXYp7DhMiasSymAIdIET4rhvBsGEzWoJweUp6j2BvkdIMTjkclXMLD
         qzQ4xkjcGx19Pm/bzscAa5bMS7hDrQLjtNEwWIL/OAh/c4CLwGKf9PQ7WWXabyz8FKu1
         nwKz+DE08u8ynTQqXDB/ws84g3Mi5zvKicNyv6qcGrkJgQPv5aiQPTRcgOt9FOVRDcT3
         uDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728322953; x=1728927753;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PS5NA1ThaEVnkiTkM/GVrPYk7r9jGIHbFBqyFUVNhbA=;
        b=d4o69nA4qhREAoEKfF1kMebLCmlovnpIrkXycZbUPLzkuEqrPcERnON+29bVWOmvhL
         wD1i5dFpx/9R5Z7kcpWFd3T/9SG5cxF5USCqZXyLTe7B4XWogh17/ASbIMJHHC1dNtAo
         5T/WiRrqGbwNU/bIsB/arn0wtCeTxIpbusp4LXvUrL3kvhKlwC7hv2FD6E2iTY5mLPE3
         vtfrgGYsTx3DPnoyvbJVcNFdAQaVYNnw3FxkyCUlVamDe5H2Qe1pkTDu+hl6zqqTOE/w
         7zOfwzmiUb/yqDzHP0W7w7mDBRIpoEOjo4lMEjbTn40dIxtChQnqb41k32yP4XIqfLos
         +gKQ==
X-Gm-Message-State: AOJu0Yw2C3msWSGZDu+oR9lKjN/Qqdybn0YdHhOPy3CXR4h29nVwt2g0
	wBjS8LoB7YEHff4kGiB38TTkFR5D/g7RV4DAox/0ONs+I1M5mtotUK7qADKBQ/E=
X-Google-Smtp-Source: AGHT+IEFqk2OLzut3DxcDk1Bt62GqmNjTUGT35SDJggK18lVB9U6VXzjUmDWn9pT4Tl+5qHXdYVbzA==
X-Received: by 2002:a05:6e02:1fc8:b0:3a0:aa15:3497 with SMTP id e9e14a558f8ab-3a375976e55mr112884675ab.1.1728322952902;
        Mon, 07 Oct 2024 10:42:32 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db90af1a9asm198127173.164.2024.10.07.10.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:42:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------g2Q5I6jsE2Syy05xn6km1t5h"
Message-ID: <bc227357-0a18-41f7-8743-04de427bff36@kernel.dk>
Date: Mon, 7 Oct 2024 11:42:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: harden multishot termination
 case for recv" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2024100733-porridge-situated-e017@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024100733-porridge-situated-e017@gregkh>

This is a multi-part message in MIME format.
--------------g2Q5I6jsE2Syy05xn6km1t5h
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 11:30 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x c314094cb4cfa6fc5a17f4881ead2dfebfa717a7
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100733-porridge-situated-e017@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> 
> Possible dependencies:

Here's one that applies for 6.1, trivial fixup, passes test suite.

-- 
Jens Axboe
--------------g2Q5I6jsE2Syy05xn6km1t5h
Content-Type: text/x-patch; charset=UTF-8;
 name="6.1-0001-io_uring-net-harden-multishot-termination-case-for-r.patch"
Content-Disposition: attachment;
 filename*0="6.1-0001-io_uring-net-harden-multishot-termination-case-for-";
 filename*1="r.patch"
Content-Transfer-Encoding: base64

RnJvbSA2MDU1N2Q4NDJiY2NmNGU2YTExNDM2MTYzMzQ4YTI2NzBlZmNjMDgyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMjYgU2VwIDIwMjQgMDc6MDg6MTAgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9uZXQ6IGhhcmRlbiBtdWx0aXNob3QgdGVybWluYXRpb24gY2FzZSBmb3IgcmVj
dgoKSWYgdGhlIHJlY3YgcmV0dXJucyB6ZXJvLCBvciBhbiBlcnJvciwgdGhlbiBpdCBkb2Vz
bid0IG1hdHRlciBpZiBtb3JlCmRhdGEgaGFzIGFscmVhZHkgYmVlbiByZWNlaXZlZCBmb3Ig
dGhpcyBidWZmZXIuIEEgY29uZGl0aW9uIGxpa2UgdGhhdApzaG91bGQgdGVybWluYXRlIHRo
ZSBtdWx0aXNob3QgcmVjZWl2ZS4gUmF0aGVyIHRoYW4gcGFzcyBpbiB0aGUKY29sbGVjdGVk
IHJldHVybiB2YWx1ZSwgcGFzcyBpbiB3aGV0aGVyIHRvIHRlcm1pbmF0ZSBvciBrZWVwIHRo
ZSByZWN2CmdvaW5nIHNlcGFyYXRlbHkuCgpOb3RlIHRoYXQgdGhpcyBpc24ndCBhIGJ1ZyBy
aWdodCBub3csIGFzIHRoZSBvbmx5IHdheSB0byBnZXQgdGhlcmUgaXMKdmlhIHNldHRpbmcg
TVNHX1dBSVRBTEwgd2l0aCBtdWx0aXNob3QgcmVjZWl2ZS4gQW5kIGlmIGFuIGFwcGxpY2F0
aW9uCmRvZXMgdGhhdCwgdGhlbiAtRUlOVkFMIGlzIHJldHVybmVkIGFueXdheS4gQnV0IGl0
IHNlZW1zIGxpa2UgYW4gZWFzeQpidWcgdG8gaW50cm9kdWNlLCBzbyBsZXQncyBtYWtlIGl0
IGEgYml0IG1vcmUgZXhwbGljaXQuCgpMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vYXhib2Uv
bGlidXJpbmcvaXNzdWVzLzEyNDYKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6
IGIzZmRlYTZlY2I1NSAoImlvX3VyaW5nOiBtdWx0aXNob3QgcmVjdiIpClNpZ25lZC1vZmYt
Ynk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9uZXQuYyB8
IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL25ldC5jIGIvaW9fdXJpbmcvbmV0LmMKaW5kZXgg
NDg0MDRiZDMzMDAxLi5mNDFhY2FiZjdiNGEgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL25ldC5j
CisrKyBiL2lvX3VyaW5nL25ldC5jCkBAIC04OTMsNiArODkzLDcgQEAgaW50IGlvX3JlY3Yo
c3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAlpbnQg
cmV0LCBtaW5fcmV0ID0gMDsKIAlib29sIGZvcmNlX25vbmJsb2NrID0gaXNzdWVfZmxhZ3Mg
JiBJT19VUklOR19GX05PTkJMT0NLOwogCXNpemVfdCBsZW4gPSBzci0+bGVuOworCWJvb2wg
bXNob3RfZmluaXNoZWQ7CiAKIAlpZiAoIShyZXEtPmZsYWdzICYgUkVRX0ZfUE9MTEVEKSAm
JgogCSAgICAoc3ItPmZsYWdzICYgSU9SSU5HX1JFQ1ZTRU5EX1BPTExfRklSU1QpKQpAQCAt
OTU3LDYgKzk1OCw3IEBAIGludCBpb19yZWN2KHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNp
Z25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAJCXJlcV9zZXRfZmFpbChyZXEpOwogCX0KIAorCW1z
aG90X2ZpbmlzaGVkID0gcmV0IDw9IDA7CiAJaWYgKHJldCA+IDApCiAJCXJldCArPSBzci0+
ZG9uZV9pbzsKIAllbHNlIGlmIChzci0+ZG9uZV9pbykKQEAgLTk2OCw3ICs5NzAsNyBAQCBp
bnQgaW9fcmVjdihzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2Zs
YWdzKQogCWlmIChtc2cubXNnX2lucSkKIAkJY2ZsYWdzIHw9IElPUklOR19DUUVfRl9TT0NL
X05PTkVNUFRZOwogCi0JaWYgKCFpb19yZWN2X2ZpbmlzaChyZXEsICZyZXQsIGNmbGFncywg
cmV0IDw9IDAsIGlzc3VlX2ZsYWdzKSkKKwlpZiAoIWlvX3JlY3ZfZmluaXNoKHJlcSwgJnJl
dCwgY2ZsYWdzLCBtc2hvdF9maW5pc2hlZCwgaXNzdWVfZmxhZ3MpKQogCQlnb3RvIHJldHJ5
X211bHRpc2hvdDsKIAogCXJldHVybiByZXQ7Ci0tIAoyLjQ1LjIKCg==

--------------g2Q5I6jsE2Syy05xn6km1t5h--

