Return-Path: <stable+bounces-180798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DB9B8DB43
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F43817CB3E
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C232749E9;
	Sun, 21 Sep 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KKhK+kkD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9C21FF24
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758458766; cv=none; b=hznubzFHpqENZpLcjp+Ueo5SP79pC+Py74Ftk/X2Cz7oszWUig4A0tjLOlJ6wrQ/NQeloSMHRab2zxDxK556vPzXb5Ja33QVy4Zx4KaOdSHXWNFYFH3pVXgYvDNFdViqw8acVDbDlYhB+kj3o9LZQJZLXhdgTzcrWYSqSKy8XB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758458766; c=relaxed/simple;
	bh=CzqgmKtypZ48X9iZ/brUaz4dBsngszQEHfmOGIT5jmU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=IePzLVdRVz6oqlQBNgZGo3k1xFfjgsRDvaJrqL+j6de/x3wopM09med3J0F97OZ6cKV22GpLLMyEx1Gt/2HxVdsQh+nCjSnkLnb+HvZXj7rMmXx+ojQ0hsjYIMOX9zNS+BnlJW/f9vQvgYX9oPuFtr9l8PiytZTd7nFxGgf/iTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KKhK+kkD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26058a9e3b5so27219115ad.2
        for <stable@vger.kernel.org>; Sun, 21 Sep 2025 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1758458763; x=1759063563; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD+1oUyihHwl8K2KOiw28hA38/ZmbgnvlUl1YOZxOyQ=;
        b=KKhK+kkDCrnZ62BFBcTSEyUoU2cCwXEz9mJGc8TeJ+M/ZJf/bEPT8xU8x1BrHciVUi
         1x/UvJlVaq9jAMPZ/LRlm/Jg3v0vt8tqtOi4nfJ0n5gz/Bp03MTioyZ19AQBtPg5ZCn7
         FcFLdWK++yEcrP0TvqtnlvMY0E6TIykMhOxDAXujXM9iNz1YQd2vUUST0nqgvsNoX0Xl
         rQWKIB3v6ofDuksHDR5rnx+svLk4nnxmZC4sIpZhJxJa9Cl0bt/6uFAhdGMZOyeYKEya
         aEg+ofKf3vifJJrX7i8NhzA1sFSByYKf4uDGlCvOD3982C5Enm33hPuXA9W05VLfO6jh
         2EzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758458763; x=1759063563;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mD+1oUyihHwl8K2KOiw28hA38/ZmbgnvlUl1YOZxOyQ=;
        b=Jn4dtsT34P9M84KOhsB5YsiAv6YkS0ZdeB7uyec43ntz+VfOe2oxFWm8vysr24Mi2g
         Pgxr1UYV5jZGVtZcwLB6Md/6WrUs/oCtTzNW1dQYOQTY3eUtztxWESkZwT5WCBU7VlR9
         29SnPd4e0nEnsMJksGb3mEDTB5FqUiPq5FwqPkmH9vdFqALZq9n0qMncqVHkhHUiH3n8
         lrb9NXPzqVcJ4Q6MjvQxYyyy/zGQ3BJppZIZNw5G2kH+WlM/p3tZTWDoSCgEUjOk3Vuo
         1ql8Jvs+8n94pVwRbpMNNGnhM3P1+GMsYsbcNiW25D7h//M1qqzK1v6qLAioynKD38n6
         OG9g==
X-Gm-Message-State: AOJu0YzSDj93PtjTlKYmqBGXby8NfAwaPQmA9gk7ltd716mg3cDRRjZF
	RpZWwc30GeVdLJskBR9+Q7ejIgHkg8aksFxwZFpjR4ENKv+DgiR0Yy6G7pIs/Uw4UvY=
X-Gm-Gg: ASbGncvmJk76+8GHs3ZSjtloijTr54jaRUIE18R0ehy+o8I8j0bt4pc1kpJqvRdnDLi
	ZIG3peQZcac8jLM/afIH6E78Gfi/GBXEuKuCxH7ejjRa8aC5WLNzw7LZMtt72PVRXfMjujBci8K
	HYHVxqLc+EePN0wU94DT9nyUdS/2nqNxBeYXPSy4YfSxDHUF9eG8aT6TYV2kbmMzGhnsOAGoTFU
	X/evlOCmLPpxNFpiHTESUtM6D1ckoFDGhFKMpfrbBAqSePA1if2sWfMjLFMsSK73v28EtxSlFQw
	yJ20JBBkdEFiNyLIWD/1SgHH5vAQEsvNIi3tEzFtZJgpGijs17Hg5LlVtFG09MGaiiCKncvTept
	xRYjvNnKPlhhOI2VeLbpC
X-Google-Smtp-Source: AGHT+IE4vt6Lzrv4CGiWcnxZCU0s63oB2pQALAPwtbNCplX0n9J/cUC7rnlqB2djtVeyIARb+cHFjQ==
X-Received: by 2002:a17:902:ccd2:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-269ba56694bmr120945735ad.46.1758458763454;
        Sun, 21 Sep 2025 05:46:03 -0700 (PDT)
Received: from [172.17.2.81] ([178.208.16.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698030fff0sm104332405ad.105.2025.09.21.05.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 05:46:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------emavec00zJ0W0It0Xcg4c4Nf"
Message-ID: <6ce95113-74e7-480a-942e-378dee39c801@kernel.dk>
Date: Sun, 21 Sep 2025 06:46:00 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: include dying ring in task_work
 "should cancel"" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, thaler@thaler.hu
Cc: stable@vger.kernel.org
References: <2025092128-embassy-flyable-e3fb@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025092128-embassy-flyable-e3fb@gregkh>

This is a multi-part message in MIME format.
--------------emavec00zJ0W0It0Xcg4c4Nf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 6:32 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 3539b1467e94336d5854ebf976d9627bfb65d6c3
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092128-embassy-flyable-e3fb@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

And 6.1-stable variants here.

-- 
Jens Axboe

--------------emavec00zJ0W0It0Xcg4c4Nf
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-include-dying-ring-in-task_work-should-canc.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-include-dying-ring-in-task_work-should-canc.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkMjJkOGMyZDkzOWQzNTcwYTIyZTAxYmQxYWFjYzhjNTUxMzAyNTIxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTggU2VwIDIwMjUgMTA6MjE6MTQgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gaW9fdXJpbmc6IGluY2x1ZGUgZHlpbmcgcmluZyBpbiB0YXNrX3dvcmsgInNob3VsZCBj
YW5jZWwiCiBzdGF0ZQoKQ29tbWl0IDM1MzliMTQ2N2U5NDMzNmQ1ODU0ZWJmOTc2ZDk2Mjdi
ZmI2NWQ2YzMgdXBzdHJlYW0uCgpXaGVuIHJ1bm5pbmcgdGFza193b3JrIGZvciBhbiBleGl0
aW5nIHRhc2ssIHJhdGhlciB0aGFuIHBlcmZvcm0gdGhlCmlzc3VlIHJldHJ5IGF0dGVtcHQs
IHRoZSB0YXNrX3dvcmsgaXMgY2FuY2VsZWQuIEhvd2V2ZXIsIHRoaXMgaXNuJ3QKZG9uZSBm
b3IgYSByaW5nIHRoYXQgaGFzIGJlZW4gY2xvc2VkLiBUaGlzIGNhbiBsZWFkIHRvIHJlcXVl
c3RzIGJlaW5nCnN1Y2Nlc3NmdWxseSBjb21wbGV0ZWQgcG9zdCB0aGUgcmluZyBiZWluZyBj
bG9zZWQsIHdoaWNoIGlzIHNvbWV3aGF0CmNvbmZ1c2luZyBhbmQgc3VycHJpc2luZyB0byBh
biBhcHBsaWNhdGlvbi4KClJhdGhlciB0aGFuIGp1c3QgY2hlY2sgdGhlIHRhc2sgZXhpdCBz
dGF0ZSwgYWxzbyBpbmNsdWRlIHRoZSByaW5nCnJlZiBzdGF0ZSBpbiBkZWNpZGluZyB3aGV0
aGVyIG9yIG5vdCB0byB0ZXJtaW5hdGUgYSBnaXZlbiByZXF1ZXN0IHdoZW4KcnVuIGZyb20g
dGFza193b3JrLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA2LjErCkxpbms6IGh0
dHBzOi8vZ2l0aHViLmNvbS9heGJvZS9saWJ1cmluZy9kaXNjdXNzaW9ucy8xNDU5ClJlcG9y
dGVkLWJ5OiBCZW5lZGVrIFRoYWxlciA8dGhhbGVyQHRoYWxlci5odT4KU2lnbmVkLW9mZi1i
eTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5nL2lvX3VyaW5n
LmMgfCAxMiArKysrKysrKy0tLS0KIGlvX3VyaW5nL2lvX3VyaW5nLmggfCAgNCArKy0tCiBp
b191cmluZy9wb2xsLmMgICAgIHwgIDIgKy0KIGlvX3VyaW5nL3RpbWVvdXQuYyAgfCAgMiAr
LQogNCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmMgYi9pb191cmluZy9pb191cmluZy5j
CmluZGV4IGZhMGM5YzA0NDkzMS4uMmFhZTBkZTYxNjljIDEwMDY0NAotLS0gYS9pb191cmlu
Zy9pb191cmluZy5jCisrKyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKQEAgLTEyNDgsOCArMTI0
OCwxMCBAQCBzdGF0aWMgdm9pZCBpb19yZXFfdGFza19jYW5jZWwoc3RydWN0IGlvX2tpb2Ni
ICpyZXEsIGJvb2wgKmxvY2tlZCkKIAogdm9pZCBpb19yZXFfdGFza19zdWJtaXQoc3RydWN0
IGlvX2tpb2NiICpyZXEsIGJvb2wgKmxvY2tlZCkKIHsKLQlpb190d19sb2NrKHJlcS0+Y3R4
LCBsb2NrZWQpOwotCWlmIChsaWtlbHkoIWlvX3Nob3VsZF90ZXJtaW5hdGVfdHcoKSkpCisJ
c3RydWN0IGlvX3JpbmdfY3R4ICpjdHggPSByZXEtPmN0eDsKKworCWlvX3R3X2xvY2soY3R4
LCBsb2NrZWQpOworCWlmIChsaWtlbHkoIWlvX3Nob3VsZF90ZXJtaW5hdGVfdHcoY3R4KSkp
CiAJCWlvX3F1ZXVlX3NxZShyZXEpOwogCWVsc2UKIAkJaW9fcmVxX2NvbXBsZXRlX2ZhaWxl
ZChyZXEsIC1FRkFVTFQpOwpAQCAtMTc3MSw4ICsxNzczLDEwIEBAIHN0YXRpYyBpbnQgaW9f
aXNzdWVfc3FlKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxh
Z3MpCiAKIGludCBpb19wb2xsX2lzc3VlKHN0cnVjdCBpb19raW9jYiAqcmVxLCBib29sICps
b2NrZWQpCiB7Ci0JaW9fdHdfbG9jayhyZXEtPmN0eCwgbG9ja2VkKTsKLQlpZiAodW5saWtl
bHkoaW9fc2hvdWxkX3Rlcm1pbmF0ZV90dygpKSkKKwlzdHJ1Y3QgaW9fcmluZ19jdHggKmN0
eCA9IHJlcS0+Y3R4OworCisJaW9fdHdfbG9jayhjdHgsIGxvY2tlZCk7CisJaWYgKHVubGlr
ZWx5KGlvX3Nob3VsZF90ZXJtaW5hdGVfdHcoY3R4KSkpCiAJCXJldHVybiAtRUZBVUxUOwog
CXJldHVybiBpb19pc3N1ZV9zcWUocmVxLCBJT19VUklOR19GX05PTkJMT0NLfElPX1VSSU5H
X0ZfTVVMVElTSE9UKTsKIH0KZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3VyaW5nLmggYi9p
b191cmluZy9pb191cmluZy5oCmluZGV4IDM3ZWY4NDUyMGJlNC4uMTk0ZTMyMzBmODUzIDEw
MDY0NAotLS0gYS9pb191cmluZy9pb191cmluZy5oCisrKyBiL2lvX3VyaW5nL2lvX3VyaW5n
LmgKQEAgLTQwMyw5ICs0MDMsOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaW9fYWxsb3dlZF9y
dW5fdHcoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCiAgKiAyKSBQRl9LVEhSRUFEIGlzIHNl
dCwgaW4gd2hpY2ggY2FzZSB0aGUgaW52b2tlciBvZiB0aGUgdGFza193b3JrIGlzCiAgKiAg
ICBvdXIgZmFsbGJhY2sgdGFza193b3JrLgogICovCi1zdGF0aWMgaW5saW5lIGJvb2wgaW9f
c2hvdWxkX3Rlcm1pbmF0ZV90dyh2b2lkKQorc3RhdGljIGlubGluZSBib29sIGlvX3Nob3Vs
ZF90ZXJtaW5hdGVfdHcoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCiB7Ci0JcmV0dXJuIGN1
cnJlbnQtPmZsYWdzICYgKFBGX0tUSFJFQUQgfCBQRl9FWElUSU5HKTsKKwlyZXR1cm4gKGN1
cnJlbnQtPmZsYWdzICYgKFBGX0tUSFJFQUQgfCBQRl9FWElUSU5HKSkgfHwgcGVyY3B1X3Jl
Zl9pc19keWluZygmY3R4LT5yZWZzKTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIGlvX3Jl
cV9xdWV1ZV90d19jb21wbGV0ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgczMyIHJlcykKZGlm
ZiAtLWdpdCBhL2lvX3VyaW5nL3BvbGwuYyBiL2lvX3VyaW5nL3BvbGwuYwppbmRleCBhMDE1
MmJkYzFjNjEuLmU5ZjgzZDNmYzgzNSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvcG9sbC5jCisr
KyBiL2lvX3VyaW5nL3BvbGwuYwpAQCAtMjQxLDcgKzI0MSw3IEBAIHN0YXRpYyBpbnQgaW9f
cG9sbF9jaGVja19ldmVudHMoc3RydWN0IGlvX2tpb2NiICpyZXEsIGJvb2wgKmxvY2tlZCkK
IAlzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCA9IHJlcS0+Y3R4OwogCWludCB2OwogCi0JaWYg
KHVubGlrZWx5KGlvX3Nob3VsZF90ZXJtaW5hdGVfdHcoKSkpCisJaWYgKHVubGlrZWx5KGlv
X3Nob3VsZF90ZXJtaW5hdGVfdHcoY3R4KSkpCiAJCXJldHVybiAtRUNBTkNFTEVEOwogCiAJ
ZG8gewpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvdGltZW91dC5jIGIvaW9fdXJpbmcvdGltZW91
dC5jCmluZGV4IDU3ZmU2M2ZhYTZiYS4uMGJmZDExMWU5MTY0IDEwMDY0NAotLS0gYS9pb191
cmluZy90aW1lb3V0LmMKKysrIGIvaW9fdXJpbmcvdGltZW91dC5jCkBAIC0yNzUsNyArMjc1
LDcgQEAgc3RhdGljIHZvaWQgaW9fcmVxX3Rhc2tfbGlua190aW1lb3V0KHN0cnVjdCBpb19r
aW9jYiAqcmVxLCBib29sICpsb2NrZWQpCiAJaW50IHJldCA9IC1FTk9FTlQ7CiAKIAlpZiAo
cHJldikgewotCQlpZiAoIWlvX3Nob3VsZF90ZXJtaW5hdGVfdHcoKSkgeworCQlpZiAoIWlv
X3Nob3VsZF90ZXJtaW5hdGVfdHcocmVxLT5jdHgpKSB7CiAJCQlzdHJ1Y3QgaW9fY2FuY2Vs
X2RhdGEgY2QgPSB7CiAJCQkJLmN0eAkJPSByZXEtPmN0eCwKIAkJCQkuZGF0YQkJPSBwcmV2
LT5jcWUudXNlcl9kYXRhLAotLSAKMi41MS4wCgo=
--------------emavec00zJ0W0It0Xcg4c4Nf
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-backport-io_should_terminate_tw.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-backport-io_should_terminate_tw.patch"
Content-Transfer-Encoding: base64

RnJvbSA2YTZlNjc1ZGE5MjE3ZDc3NTM4NmEwMGNkYjYxMzQ3ZjNiYWJlZWVjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTggU2VwIDIwMjUgMTE6Mjc6MDYgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gaW9fdXJpbmc6IGJhY2twb3J0IGlvX3Nob3VsZF90ZXJtaW5hdGVfdHcoKQoKUGFydHMg
b2YgY29tbWl0IGI2ZjU4YTNmNGFhOGRiYTQyNDM1NmM3YTY5Mzg4YTgxZjQ0NTkzMDAgdXBz
dHJlYW0uCgpCYWNrcG9ydCBpb19zaG91bGRfdGVybWluYXRlX3R3KCkgaGVscGVyIHRvIGp1
ZGdlIHdoZXRoZXIgdGFza193b3JrCnNob3VsZCBiZSBydW4gb3IgdGVybWluYXRlZC4KClNp
Z25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmlu
Zy9pb191cmluZy5jIHwgIDUgKystLS0KIGlvX3VyaW5nL2lvX3VyaW5nLmggfCAxMyArKysr
KysrKysrKysrCiBpb191cmluZy9wb2xsLmMgICAgIHwgIDMgKy0tCiBpb191cmluZy90aW1l
b3V0LmMgIHwgIDIgKy0KIDQgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIvaW9fdXJp
bmcvaW9fdXJpbmcuYwppbmRleCAyOWFkZmM2ZDZlYzIuLmZhMGM5YzA0NDkzMSAxMDA2NDQK
LS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9pb191cmluZy5jCkBA
IC0xMjQ5LDggKzEyNDksNyBAQCBzdGF0aWMgdm9pZCBpb19yZXFfdGFza19jYW5jZWwoc3Ry
dWN0IGlvX2tpb2NiICpyZXEsIGJvb2wgKmxvY2tlZCkKIHZvaWQgaW9fcmVxX3Rhc2tfc3Vi
bWl0KHN0cnVjdCBpb19raW9jYiAqcmVxLCBib29sICpsb2NrZWQpCiB7CiAJaW9fdHdfbG9j
ayhyZXEtPmN0eCwgbG9ja2VkKTsKLQkvKiByZXEtPnRhc2sgPT0gY3VycmVudCBoZXJlLCBj
aGVja2luZyBQRl9FWElUSU5HIGlzIHNhZmUgKi8KLQlpZiAobGlrZWx5KCEocmVxLT50YXNr
LT5mbGFncyAmIFBGX0VYSVRJTkcpKSkKKwlpZiAobGlrZWx5KCFpb19zaG91bGRfdGVybWlu
YXRlX3R3KCkpKQogCQlpb19xdWV1ZV9zcWUocmVxKTsKIAllbHNlCiAJCWlvX3JlcV9jb21w
bGV0ZV9mYWlsZWQocmVxLCAtRUZBVUxUKTsKQEAgLTE3NzMsNyArMTc3Miw3IEBAIHN0YXRp
YyBpbnQgaW9faXNzdWVfc3FlKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQg
aXNzdWVfZmxhZ3MpCiBpbnQgaW9fcG9sbF9pc3N1ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwg
Ym9vbCAqbG9ja2VkKQogewogCWlvX3R3X2xvY2socmVxLT5jdHgsIGxvY2tlZCk7Ci0JaWYg
KHVubGlrZWx5KHJlcS0+dGFzay0+ZmxhZ3MgJiBQRl9FWElUSU5HKSkKKwlpZiAodW5saWtl
bHkoaW9fc2hvdWxkX3Rlcm1pbmF0ZV90dygpKSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAJcmV0
dXJuIGlvX2lzc3VlX3NxZShyZXEsIElPX1VSSU5HX0ZfTk9OQkxPQ0t8SU9fVVJJTkdfRl9N
VUxUSVNIT1QpOwogfQpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuaCBiL2lvX3Vy
aW5nL2lvX3VyaW5nLmgKaW5kZXggODg2OTIxZDJkNThkLi4zN2VmODQ1MjBiZTQgMTAwNjQ0
Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmgKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuaApA
QCAtMzk1LDYgKzM5NSwxOSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaW9fYWxsb3dlZF9ydW5f
dHcoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCiAJCSAgICAgIGN0eC0+c3VibWl0dGVyX3Rh
c2sgPT0gY3VycmVudCk7CiB9CiAKKy8qCisgKiBUZXJtaW5hdGUgdGhlIHJlcXVlc3QgaWYg
ZWl0aGVyIG9mIHRoZXNlIGNvbmRpdGlvbnMgYXJlIHRydWU6CisgKgorICogMSkgSXQncyBi
ZWluZyBleGVjdXRlZCBieSB0aGUgb3JpZ2luYWwgdGFzaywgYnV0IHRoYXQgdGFzayBpcyBt
YXJrZWQKKyAqICAgIHdpdGggUEZfRVhJVElORyBhcyBpdCdzIGV4aXRpbmcuCisgKiAyKSBQ
Rl9LVEhSRUFEIGlzIHNldCwgaW4gd2hpY2ggY2FzZSB0aGUgaW52b2tlciBvZiB0aGUgdGFz
a193b3JrIGlzCisgKiAgICBvdXIgZmFsbGJhY2sgdGFza193b3JrLgorICovCitzdGF0aWMg
aW5saW5lIGJvb2wgaW9fc2hvdWxkX3Rlcm1pbmF0ZV90dyh2b2lkKQoreworCXJldHVybiBj
dXJyZW50LT5mbGFncyAmIChQRl9LVEhSRUFEIHwgUEZfRVhJVElORyk7Cit9CisKIHN0YXRp
YyBpbmxpbmUgdm9pZCBpb19yZXFfcXVldWVfdHdfY29tcGxldGUoc3RydWN0IGlvX2tpb2Ni
ICpyZXEsIHMzMiByZXMpCiB7CiAJaW9fcmVxX3NldF9yZXMocmVxLCByZXMsIDApOwpkaWZm
IC0tZ2l0IGEvaW9fdXJpbmcvcG9sbC5jIGIvaW9fdXJpbmcvcG9sbC5jCmluZGV4IGFiMjdh
NjI3ZmQ0Yy4uYTAxNTJiZGMxYzYxIDEwMDY0NAotLS0gYS9pb191cmluZy9wb2xsLmMKKysr
IGIvaW9fdXJpbmcvcG9sbC5jCkBAIC0yNDEsOCArMjQxLDcgQEAgc3RhdGljIGludCBpb19w
b2xsX2NoZWNrX2V2ZW50cyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgYm9vbCAqbG9ja2VkKQog
CXN0cnVjdCBpb19yaW5nX2N0eCAqY3R4ID0gcmVxLT5jdHg7CiAJaW50IHY7CiAKLQkvKiBy
ZXEtPnRhc2sgPT0gY3VycmVudCBoZXJlLCBjaGVja2luZyBQRl9FWElUSU5HIGlzIHNhZmUg
Ki8KLQlpZiAodW5saWtlbHkocmVxLT50YXNrLT5mbGFncyAmIFBGX0VYSVRJTkcpKQorCWlm
ICh1bmxpa2VseShpb19zaG91bGRfdGVybWluYXRlX3R3KCkpKQogCQlyZXR1cm4gLUVDQU5D
RUxFRDsKIAogCWRvIHsKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL3RpbWVvdXQuYyBiL2lvX3Vy
aW5nL3RpbWVvdXQuYwppbmRleCA3Y2RjMjM0YzVmNTMuLjU3ZmU2M2ZhYTZiYSAxMDA2NDQK
LS0tIGEvaW9fdXJpbmcvdGltZW91dC5jCisrKyBiL2lvX3VyaW5nL3RpbWVvdXQuYwpAQCAt
Mjc1LDcgKzI3NSw3IEBAIHN0YXRpYyB2b2lkIGlvX3JlcV90YXNrX2xpbmtfdGltZW91dChz
dHJ1Y3QgaW9fa2lvY2IgKnJlcSwgYm9vbCAqbG9ja2VkKQogCWludCByZXQgPSAtRU5PRU5U
OwogCiAJaWYgKHByZXYpIHsKLQkJaWYgKCEocmVxLT50YXNrLT5mbGFncyAmIFBGX0VYSVRJ
TkcpKSB7CisJCWlmICghaW9fc2hvdWxkX3Rlcm1pbmF0ZV90dygpKSB7CiAJCQlzdHJ1Y3Qg
aW9fY2FuY2VsX2RhdGEgY2QgPSB7CiAJCQkJLmN0eAkJPSByZXEtPmN0eCwKIAkJCQkuZGF0
YQkJPSBwcmV2LT5jcWUudXNlcl9kYXRhLAotLSAKMi41MS4wCgo=

--------------emavec00zJ0W0It0Xcg4c4Nf--

