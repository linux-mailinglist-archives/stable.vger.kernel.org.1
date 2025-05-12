Return-Path: <stable+bounces-143266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D9EAB3827
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FB3175199
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DFA255F51;
	Mon, 12 May 2025 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Gq0RN7hH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614029293D
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055492; cv=none; b=EX1672k9dPqSSTLBpEOXnTGCtp49kNQ59+y9lSDrVKZjxfhUoHtSWRM2NcSJG9+wY7kSCZ25AjOS0Q+DbFJ16YiBzpVdbJrPUGztnlo+jqTXudpUo4J63QbZnJXE3+r+J6BXqWe0YBqstsvdk3wDb07LeoKC4amSdxDYnx4ezxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055492; c=relaxed/simple;
	bh=foaIrzAF9ou1640Ecaw+2wvx45W4e65ENwsyuYR+34I=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=qmi0xbh8rC2Zv5qcaLo8sxYCRGPSvO8wgeslzfhqDGaifhn5vHav5q+5I/e1UNog18Z8os/DRo41VINBm6aAEB6klhGCt35HljuQybJZl4yTQ6x7iF7DCilt7cOrAwXk0PxbhaPkgqWlDmckg4RhV2xpBhi3wS6QC3knDII3DNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Gq0RN7hH; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22fa414c497so50188735ad.0
        for <stable@vger.kernel.org>; Mon, 12 May 2025 06:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747055489; x=1747660289; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpnrv5BKf+DzFVsQgo1DYRewJ+HVogwWE6BgxPk97Ok=;
        b=Gq0RN7hH+CkeVtqPJWAcygEQQLZVs5+Cvn1xzymDY/0jEpPB93oZTzUTNEHDBWqVi3
         yY45kpt4uUUfX7c8EkzNkM/hjVEKB2E0jBy3SKX/u5r9o9hrofOGuIADZsgFd2iFJGLR
         73Ql1yE6Nd6LXQt9qrTPR3HAMrfGLSRzkZdepiZqg1dt76+Kk9AdJxRCbVKUALpKdro3
         sF9zAV7XuyZLFbNEqx9RkMPlTAWolm+yoGm8lOOA8hQazltOtRFGN63UoB7XTK1Gta4B
         GagF+fqkC+El1lhz9hrreG6pfiZhZtHP0wUYYxwxDKbEwJxIFq9d0O5d0gSiyZJcD70y
         h2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055489; x=1747660289;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zpnrv5BKf+DzFVsQgo1DYRewJ+HVogwWE6BgxPk97Ok=;
        b=UGOi8ESXqHwUOrutrzyGO9zvXEdGpJNlCweCy/JaQldUtKDp7OFUXZ88s6tOxJpBOI
         xBzP8KbM9sgBy+ZE9n1Eb7QOS7Yq3JNFE8hcz5fSHZ3iqslCP32Ow5tLoSohmNT4sTHL
         uVzNnY6Th1bW7F+cQVg7CPmvMZGEgDIKKKnwYZt9ZCIPVl443R4G5CcSUOGv3h3otUsm
         w+EkqfbLmqrejRI7Znb9EPwCglnruUASS2G4k65Uzb3nrinw6ipSHgTCmffovBkhoRIR
         XHOQG1+wgLfbUq8oFY+jDOzLmDMYChvS1OvDoCiJi8i3LBUayHFj6PWGHqEnXTTPAoJH
         64Ng==
X-Gm-Message-State: AOJu0YzgHYwcLz8zVI7NrMJzqvPONx/34nvw6WdaFiBqgsPVLhIsixMw
	5wuHHijcZ/AICJ4hhNOOtQGCtiYN9F+Z7VKbX3SXGLtmpM7wgMvQlCv3rhb8blZzXzxkspWsPl8
	v
X-Gm-Gg: ASbGncvQ/rL5jNqkrrLLz9APFHkgJzNuv0vjL2slDDtzcU7mJrt1xVP4na7vwux5Sq1
	1DvZOaFH7AzjN/+A2FG7Ut5rBND5FFqwpTnuNQi7h2Qky6pqTtN+oiTejJX9MvnPRiKsi0Orc/O
	7Igzf+B/rs7UVFGgYNVHEjcGb1Hjm2Z/+8t9+tjEZoYlMLacEwav9onqzUFV97EWsGKvhownRvz
	/QVxzuEzX+tD6DPmuLRFfAyYUFcjgC85rdohANp+Lvoszupt5iRBPOU3Yo6iu5Ash7rRk5Xp6Gs
	w7yVF1otEcTRnWmwVg+ZR6WJ2IrKsMTDz2l7NVyufV4n40k=
X-Google-Smtp-Source: AGHT+IGNpnUK0npr3vL3+M6uOEp+4ACIvGw2qiYbbdBp80aB84gGgjOdU85SNEGo6eVU2Sd+OKPytw==
X-Received: by 2002:a05:6e02:154e:b0:3da:7c22:6804 with SMTP id e9e14a558f8ab-3da7e1e6fbcmr127929075ab.6.1747055477636;
        Mon, 12 May 2025 06:11:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e161532sm22456075ab.59.2025.05.12.06.11.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:11:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------W2XTyQ0MHrw9dc02CT0YxZE0"
Message-ID: <1218794b-4a68-4f31-ac96-cb5da002edc1@kernel.dk>
Date: Mon, 12 May 2025 07:11:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: always arm linked timeouts prior
 to issue" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, chase@path.net
Cc: stable@vger.kernel.org
References: <2025051225-punisher-evident-a1a8@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025051225-punisher-evident-a1a8@gregkh>

This is a multi-part message in MIME format.
--------------W2XTyQ0MHrw9dc02CT0YxZE0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 4:01 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's a testsed 6.6-stable backport.

-- 
Jens Axboe

--------------W2XTyQ0MHrw9dc02CT0YxZE0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-always-arm-linked-timeouts-prior-to-issue.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-always-arm-linked-timeouts-prior-to-issue.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSA5MTY2NDUxZWZkNDg5ZmU2YTg0ZTIyYTI2YWI3M2E0NmJmYzMzYzU1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgNSBNYXkgMjAyNSAwODozNDozOSAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBpb191cmluZzogYWx3YXlzIGFybSBsaW5rZWQgdGltZW91dHMgcHJpb3IgdG8gaXNzdWUK
CkNvbW1pdCBiNTNlNTIzMjYxYmYwNThlYTRhNTE4YjQ4MjIyMmU3YTI3N2IxODZiIHVwc3Ry
ZWFtLgoKVGhlcmUgYXJlIGEgZmV3IHNwb3RzIHdoZXJlIGxpbmtlZCB0aW1lb3V0cyBhcmUg
YXJtZWQsIGFuZCBub3QgYWxsIG9mCnRoZW0gYWRoZXJlIHRvIHRoZSBwcmUtYXJtLCBhdHRl
bXB0IGlzc3VlLCBwb3N0LWFybSBwYXR0ZXJuLiBUaGlzIGNhbgpiZSBwcm9ibGVtYXRpYyBp
ZiB0aGUgbGlua2VkIHJlcXVlc3QgcmV0dXJucyB0aGF0IGl0IHdpbGwgdHJpZ2dlciBhCmNh
bGxiYWNrIGxhdGVyLCBhbmQgZG9lcyBzbyBiZWZvcmUgdGhlIGxpbmtlZCB0aW1lb3V0IGlz
IGZ1bGx5IGFybWVkLgoKQ29uc29saWRhdGUgYWxsIHRoZSBsaW5rZWQgdGltZW91dCBoYW5k
bGluZyBpbnRvIF9faW9faXNzdWVfc3FlKCksCnJhdGhlciB0aGFuIGhhdmUgaXQgc3ByZWFk
IHRocm91Z2hvdXQgdGhlIHZhcmlvdXMgaXNzdWUgZW50cnkgcG9pbnRzLgoKQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKTGluazogaHR0cHM6Ly9naXRodWIuY29tL2F4Ym9lL2xpYnVy
aW5nL2lzc3Vlcy8xMzkwClJlcG9ydGVkLWJ5OiBDaGFzZSBIaWx0eiA8Y2hhc2VAcGF0aC5u
ZXQ+ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBp
b191cmluZy9pb191cmluZy5jIHwgNTMgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMzcg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3Vy
aW5nL2lvX3VyaW5nLmMKaW5kZXggM2NlOTM0MThlMDE1Li40ZjRhYzQwZmM2MDUgMTAwNjQ0
Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpA
QCAtNDIyLDI0ICs0MjIsNiBAQCBzdGF0aWMgc3RydWN0IGlvX2tpb2NiICpfX2lvX3ByZXBf
bGlua2VkX3RpbWVvdXQoc3RydWN0IGlvX2tpb2NiICpyZXEpCiAJcmV0dXJuIHJlcS0+bGlu
azsKIH0KIAotc3RhdGljIGlubGluZSBzdHJ1Y3QgaW9fa2lvY2IgKmlvX3ByZXBfbGlua2Vk
X3RpbWVvdXQoc3RydWN0IGlvX2tpb2NiICpyZXEpCi17Ci0JaWYgKGxpa2VseSghKHJlcS0+
ZmxhZ3MgJiBSRVFfRl9BUk1fTFRJTUVPVVQpKSkKLQkJcmV0dXJuIE5VTEw7Ci0JcmV0dXJu
IF9faW9fcHJlcF9saW5rZWRfdGltZW91dChyZXEpOwotfQotCi1zdGF0aWMgbm9pbmxpbmUg
dm9pZCBfX2lvX2FybV9sdGltZW91dChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKLXsKLQlpb19x
dWV1ZV9saW5rZWRfdGltZW91dChfX2lvX3ByZXBfbGlua2VkX3RpbWVvdXQocmVxKSk7Ci19
Ci0KLXN0YXRpYyBpbmxpbmUgdm9pZCBpb19hcm1fbHRpbWVvdXQoc3RydWN0IGlvX2tpb2Ni
ICpyZXEpCi17Ci0JaWYgKHVubGlrZWx5KHJlcS0+ZmxhZ3MgJiBSRVFfRl9BUk1fTFRJTUVP
VVQpKQotCQlfX2lvX2FybV9sdGltZW91dChyZXEpOwotfQotCiBzdGF0aWMgdm9pZCBpb19w
cmVwX2FzeW5jX3dvcmsoc3RydWN0IGlvX2tpb2NiICpyZXEpCiB7CiAJY29uc3Qgc3RydWN0
IGlvX2lzc3VlX2RlZiAqZGVmID0gJmlvX2lzc3VlX2RlZnNbcmVxLT5vcGNvZGVdOwpAQCAt
NDkzLDcgKzQ3NSw2IEBAIHN0YXRpYyB2b2lkIGlvX3ByZXBfYXN5bmNfbGluayhzdHJ1Y3Qg
aW9fa2lvY2IgKnJlcSkKIAogc3RhdGljIHZvaWQgaW9fcXVldWVfaW93cShzdHJ1Y3QgaW9f
a2lvY2IgKnJlcSkKIHsKLQlzdHJ1Y3QgaW9fa2lvY2IgKmxpbmsgPSBpb19wcmVwX2xpbmtl
ZF90aW1lb3V0KHJlcSk7CiAJc3RydWN0IGlvX3VyaW5nX3Rhc2sgKnRjdHggPSByZXEtPnRh
c2stPmlvX3VyaW5nOwogCiAJQlVHX09OKCF0Y3R4KTsKQEAgLTUxOCw4ICs0OTksNiBAQCBz
dGF0aWMgdm9pZCBpb19xdWV1ZV9pb3dxKHN0cnVjdCBpb19raW9jYiAqcmVxKQogCiAJdHJh
Y2VfaW9fdXJpbmdfcXVldWVfYXN5bmNfd29yayhyZXEsIGlvX3dxX2lzX2hhc2hlZCgmcmVx
LT53b3JrKSk7CiAJaW9fd3FfZW5xdWV1ZSh0Y3R4LT5pb193cSwgJnJlcS0+d29yayk7Ci0J
aWYgKGxpbmspCi0JCWlvX3F1ZXVlX2xpbmtlZF90aW1lb3V0KGxpbmspOwogfQogCiBzdGF0
aWMgX19jb2xkIHZvaWQgaW9fcXVldWVfZGVmZXJyZWQoc3RydWN0IGlvX3JpbmdfY3R4ICpj
dHgpCkBAIC0xODYzLDE3ICsxODQyLDI0IEBAIHN0YXRpYyBib29sIGlvX2Fzc2lnbl9maWxl
KHN0cnVjdCBpb19raW9jYiAqcmVxLCBjb25zdCBzdHJ1Y3QgaW9faXNzdWVfZGVmICpkZWYs
CiAJcmV0dXJuICEhcmVxLT5maWxlOwogfQogCisjZGVmaW5lIFJFUV9JU1NVRV9TTE9XX0ZM
QUdTCShSRVFfRl9DUkVEUyB8IFJFUV9GX0FSTV9MVElNRU9VVCkKKwogc3RhdGljIGludCBp
b19pc3N1ZV9zcWUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9m
bGFncykKIHsKIAljb25zdCBzdHJ1Y3QgaW9faXNzdWVfZGVmICpkZWYgPSAmaW9faXNzdWVf
ZGVmc1tyZXEtPm9wY29kZV07CiAJY29uc3Qgc3RydWN0IGNyZWQgKmNyZWRzID0gTlVMTDsK
KwlzdHJ1Y3QgaW9fa2lvY2IgKmxpbmsgPSBOVUxMOwogCWludCByZXQ7CiAKIAlpZiAodW5s
aWtlbHkoIWlvX2Fzc2lnbl9maWxlKHJlcSwgZGVmLCBpc3N1ZV9mbGFncykpKQogCQlyZXR1
cm4gLUVCQURGOwogCi0JaWYgKHVubGlrZWx5KChyZXEtPmZsYWdzICYgUkVRX0ZfQ1JFRFMp
ICYmIHJlcS0+Y3JlZHMgIT0gY3VycmVudF9jcmVkKCkpKQotCQljcmVkcyA9IG92ZXJyaWRl
X2NyZWRzKHJlcS0+Y3JlZHMpOworCWlmICh1bmxpa2VseShyZXEtPmZsYWdzICYgUkVRX0lT
U1VFX1NMT1dfRkxBR1MpKSB7CisJCWlmICgocmVxLT5mbGFncyAmIFJFUV9GX0NSRURTKSAm
JiByZXEtPmNyZWRzICE9IGN1cnJlbnRfY3JlZCgpKQorCQkJY3JlZHMgPSBvdmVycmlkZV9j
cmVkcyhyZXEtPmNyZWRzKTsKKwkJaWYgKHJlcS0+ZmxhZ3MgJiBSRVFfRl9BUk1fTFRJTUVP
VVQpCisJCQlsaW5rID0gX19pb19wcmVwX2xpbmtlZF90aW1lb3V0KHJlcSk7CisJfQogCiAJ
aWYgKCFkZWYtPmF1ZGl0X3NraXApCiAJCWF1ZGl0X3VyaW5nX2VudHJ5KHJlcS0+b3Bjb2Rl
KTsKQEAgLTE4ODMsOCArMTg2OSwxMiBAQCBzdGF0aWMgaW50IGlvX2lzc3VlX3NxZShzdHJ1
Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQogCWlmICghZGVm
LT5hdWRpdF9za2lwKQogCQlhdWRpdF91cmluZ19leGl0KCFyZXQsIHJldCk7CiAKLQlpZiAo
Y3JlZHMpCi0JCXJldmVydF9jcmVkcyhjcmVkcyk7CisJaWYgKHVubGlrZWx5KGNyZWRzIHx8
IGxpbmspKSB7CisJCWlmIChjcmVkcykKKwkJCXJldmVydF9jcmVkcyhjcmVkcyk7CisJCWlm
IChsaW5rKQorCQkJaW9fcXVldWVfbGlua2VkX3RpbWVvdXQobGluayk7CisJfQogCiAJaWYg
KHJldCA9PSBJT1VfT0spIHsKIAkJaWYgKGlzc3VlX2ZsYWdzICYgSU9fVVJJTkdfRl9DT01Q
TEVURV9ERUZFUikKQEAgLTE5MzksOCArMTkyOSw2IEBAIHZvaWQgaW9fd3Ffc3VibWl0X3dv
cmsoc3RydWN0IGlvX3dxX3dvcmsgKndvcmspCiAJZWxzZQogCQlyZXFfcmVmX2dldChyZXEp
OwogCi0JaW9fYXJtX2x0aW1lb3V0KHJlcSk7Ci0KIAkvKiBlaXRoZXIgY2FuY2VsbGVkIG9y
IGlvLXdxIGlzIGR5aW5nLCBzbyBkb24ndCB0b3VjaCB0Y3R4LT5pb3dxICovCiAJaWYgKHdv
cmstPmZsYWdzICYgSU9fV1FfV09SS19DQU5DRUwpIHsKIGZhaWw6CkBAIC0yMDM2LDE1ICsy
MDI0LDExIEBAIHN0cnVjdCBmaWxlICppb19maWxlX2dldF9ub3JtYWwoc3RydWN0IGlvX2tp
b2NiICpyZXEsIGludCBmZCkKIHN0YXRpYyB2b2lkIGlvX3F1ZXVlX2FzeW5jKHN0cnVjdCBp
b19raW9jYiAqcmVxLCBpbnQgcmV0KQogCV9fbXVzdF9ob2xkKCZyZXEtPmN0eC0+dXJpbmdf
bG9jaykKIHsKLQlzdHJ1Y3QgaW9fa2lvY2IgKmxpbmtlZF90aW1lb3V0OwotCiAJaWYgKHJl
dCAhPSAtRUFHQUlOIHx8IChyZXEtPmZsYWdzICYgUkVRX0ZfTk9XQUlUKSkgewogCQlpb19y
ZXFfZGVmZXJfZmFpbGVkKHJlcSwgcmV0KTsKIAkJcmV0dXJuOwogCX0KIAotCWxpbmtlZF90
aW1lb3V0ID0gaW9fcHJlcF9saW5rZWRfdGltZW91dChyZXEpOwotCiAJc3dpdGNoIChpb19h
cm1fcG9sbF9oYW5kbGVyKHJlcSwgMCkpIHsKIAljYXNlIElPX0FQT0xMX1JFQURZOgogCQlp
b19rYnVmX3JlY3ljbGUocmVxLCAwKTsKQEAgLTIwNTcsOSArMjA0MSw2IEBAIHN0YXRpYyB2
b2lkIGlvX3F1ZXVlX2FzeW5jKHN0cnVjdCBpb19raW9jYiAqcmVxLCBpbnQgcmV0KQogCWNh
c2UgSU9fQVBPTExfT0s6CiAJCWJyZWFrOwogCX0KLQotCWlmIChsaW5rZWRfdGltZW91dCkK
LQkJaW9fcXVldWVfbGlua2VkX3RpbWVvdXQobGlua2VkX3RpbWVvdXQpOwogfQogCiBzdGF0
aWMgaW5saW5lIHZvaWQgaW9fcXVldWVfc3FlKHN0cnVjdCBpb19raW9jYiAqcmVxKQpAQCAt
MjA3Myw5ICsyMDU0LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGlvX3F1ZXVlX3NxZShzdHJ1
Y3QgaW9fa2lvY2IgKnJlcSkKIAkgKiBXZSBhc3luYyBwdW50IGl0IGlmIHRoZSBmaWxlIHdh
c24ndCBtYXJrZWQgTk9XQUlULCBvciBpZiB0aGUgZmlsZQogCSAqIGRvZXNuJ3Qgc3VwcG9y
dCBub24tYmxvY2tpbmcgcmVhZC93cml0ZSBhdHRlbXB0cwogCSAqLwotCWlmIChsaWtlbHko
IXJldCkpCi0JCWlvX2FybV9sdGltZW91dChyZXEpOwotCWVsc2UKKwlpZiAodW5saWtlbHko
cmV0KSkKIAkJaW9fcXVldWVfYXN5bmMocmVxLCByZXQpOwogfQogCi0tIAoyLjQ5LjAKCg==


--------------W2XTyQ0MHrw9dc02CT0YxZE0--

