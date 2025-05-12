Return-Path: <stable+bounces-143267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4798AAB382A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A1D7A7ADE
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D266255F2E;
	Mon, 12 May 2025 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E+89xFB0"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E83522F
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055525; cv=none; b=CDqBb9UdzqdJaJPWQVLPM+690jia5SJlT/oogwDOFzexQewrzTmqmGbmax0yIuMPDYTgV8Pyu2zZp6BS0q0vNeo3/xX76RrqHyjOkhmJpHzTUPCPxXR3/JGMqga+50UUdwzvyNoGWICIakShyQtbdmFVsMQ9UvsifqLuqQo37vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055525; c=relaxed/simple;
	bh=w8///LzCnB5AQ50RmApRCPuCxVNPNuZoz3YsguUQ/Vw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=TYtRy+YxStLqUAqkue+guWLsvxt5FDMR/GSVEOwLxq2oce/45e92y6Riu4pt+13ShTxcsJbiqJVDqwuD3nROJJ8yC7o1V1Q81qqNvnefyB0m3aL7El5Xiiqn5sQvKjKAK6gPkf7+Xx6rF6Krn/MePdroKbDr+YLwsexzOIw397o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E+89xFB0; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d81cba18e1so37428235ab.3
        for <stable@vger.kernel.org>; Mon, 12 May 2025 06:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747055523; x=1747660323; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YEhzcNfS5grOiw/xXpKKku1hHMhjGiuZ3zNEI2k73s=;
        b=E+89xFB0DZUeZC4GEVemodCdGgYm1Ztbb+qNTgvpRaQJi0PPCmgglRGeHjfQVsSbQX
         kQsmZk3dbzSCdJthIvIP4oGoCIcSmNkaDa7l2hAn8GaPb8hHVMllLawe9IfbYpKzEYF8
         51gbIi1cEGrDw/2Hxjae46N76hEzuAHoEJA0vkOWf4/2LnhjQR8dy94cB1wv9aK4uyij
         Fa9jUpMzhuW2v0J/TyJ3Mb8dHToJCGFja92pd+PB40EoBOkw0MQojzbXm2X7GaUdy6/o
         35kJG5Xb6P9VMFNrn2gZSUlguGzsQr3ijMrw/eKzEErgH2KVP/qeHOeMn3B6bbzDqze1
         YXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055523; x=1747660323;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2YEhzcNfS5grOiw/xXpKKku1hHMhjGiuZ3zNEI2k73s=;
        b=WhKvZaxKiIOs59fE/UkLX3hguV8PiUnhjBm6zFyy1MFNfpjyMNzzjgi3Mo3+k2Y0Oq
         lms3mzKKJvfoLHPflXmL3MbdPLAM+0BjZkEAauOYP8Od3mKqWnk5mOZ+8Eq9LKQUcF48
         SHG8HktW+wPr0wJGdG71MubR/M+ltTlaW3KPaSIFJKrqvLOnbS3I6q8pPcQtVtr6K8n1
         n9FdjKGw4Tp0PFRdbEApt+Wd8JwIcrotG5qTr1ABmBfKMZtHS1SF4/GSVdkL0bXwYNfB
         3V2YD4fY40G1oJ97V7XQf0MCPj8VRRWhXIxNUizoI7DyAejeV9TR3VbCM5XJD2xKyM+i
         3evw==
X-Gm-Message-State: AOJu0YxngphvVO7OTjtvqFt4sax/hBQLSrsL6N2UMyGylyvlCdHP4YjF
	fz6pregz8iHVX6vNqvbniEqxeJhgJNjhFsuCovU+qso2qZr0kuUkPPnl1fDFEjY=
X-Gm-Gg: ASbGncuWNaEejoViT5W949wqQ89JSBeEJaMxBuzoxj4rS5p5W7cwG3TSEcMUl2+UPSG
	RrfDtQEc4b/UKuIknG80UMESDplfdCWzoULzwx4gxJbgN0DAuJF6Xy21ne9virJ6ziI5d2lqYNY
	QWMA/5D1cauX6l+r9iBvehydS2FbyyPj7yuG7eQ7fIheBvL2+J0ubGaouFV2+oMwTBdyfYezF9d
	bLmpAqk9P08hJnmMnEvdlOSgCIpotmUPFkom9Mp67yUAypoA7Lie+22QU10ynRBM4geWu5UBlgf
	+cPh1wZo6JBvdiQIBCzE8ILTlTm4cmxwBnBcmlXqC8sWe6WgFxrYp4q/9g==
X-Google-Smtp-Source: AGHT+IH2FU72oOVTw4UbyuTVPETpo8S/wGLjw8ccsSanT4iiwDPaJK81m6ezDEF3WmLeVuLyMfJpxg==
X-Received: by 2002:a05:6e02:1a27:b0:3d8:1d7c:e192 with SMTP id e9e14a558f8ab-3da7e1e305bmr156765005ab.7.1747055522889;
        Mon, 12 May 2025 06:12:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa224dc88asm1590692173.35.2025.05.12.06.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:12:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------da06VxLQ8wCEEx2Q30wl4VwX"
Message-ID: <c316e5d6-216c-45ef-b435-922b8f15304a@kernel.dk>
Date: Mon, 12 May 2025 07:12:01 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: always arm linked timeouts prior
 to issue" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, chase@path.net
Cc: stable@vger.kernel.org
References: <2025051225-maximize-tingly-00b5@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025051225-maximize-tingly-00b5@gregkh>

This is a multi-part message in MIME format.
--------------da06VxLQ8wCEEx2Q30wl4VwX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 4:01 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's a tested 6.12-stable backport.

-- 
Jens Axboe

--------------da06VxLQ8wCEEx2Q30wl4VwX
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-always-arm-linked-timeouts-prior-to-issue.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-always-arm-linked-timeouts-prior-to-issue.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSA1MWM1NGQ5MjYyYzhmM2Q2ZDJiMjYyYWNiYjEwYzgwMDY4ZDQ0ZWZmIE1vbiBTZXAg
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
b191cmluZy9pb191cmluZy5jIHwgNTAgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMzUg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3Vy
aW5nL2lvX3VyaW5nLmMKaW5kZXggZmVmNWM2ZTNiMjUxLi5hZGNmMWFiYzE1MTMgMTAwNjQ0
Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpA
QCAtNDQxLDI0ICs0NDEsNiBAQCBzdGF0aWMgc3RydWN0IGlvX2tpb2NiICpfX2lvX3ByZXBf
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
NTExLDcgKzQ5Myw2IEBAIHN0YXRpYyB2b2lkIGlvX3ByZXBfYXN5bmNfbGluayhzdHJ1Y3Qg
aW9fa2lvY2IgKnJlcSkKIAogc3RhdGljIHZvaWQgaW9fcXVldWVfaW93cShzdHJ1Y3QgaW9f
a2lvY2IgKnJlcSkKIHsKLQlzdHJ1Y3QgaW9fa2lvY2IgKmxpbmsgPSBpb19wcmVwX2xpbmtl
ZF90aW1lb3V0KHJlcSk7CiAJc3RydWN0IGlvX3VyaW5nX3Rhc2sgKnRjdHggPSByZXEtPnRh
c2stPmlvX3VyaW5nOwogCiAJQlVHX09OKCF0Y3R4KTsKQEAgLTUzNiw4ICs1MTcsNiBAQCBz
dGF0aWMgdm9pZCBpb19xdWV1ZV9pb3dxKHN0cnVjdCBpb19raW9jYiAqcmVxKQogCiAJdHJh
Y2VfaW9fdXJpbmdfcXVldWVfYXN5bmNfd29yayhyZXEsIGlvX3dxX2lzX2hhc2hlZCgmcmVx
LT53b3JrKSk7CiAJaW9fd3FfZW5xdWV1ZSh0Y3R4LT5pb193cSwgJnJlcS0+d29yayk7Ci0J
aWYgKGxpbmspCi0JCWlvX3F1ZXVlX2xpbmtlZF90aW1lb3V0KGxpbmspOwogfQogCiBzdGF0
aWMgdm9pZCBpb19yZXFfcXVldWVfaW93cV90dyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgc3Ry
dWN0IGlvX3R3X3N0YXRlICp0cykKQEAgLTE3MjMsMTcgKzE3MDIsMjQgQEAgc3RhdGljIGJv
b2wgaW9fYXNzaWduX2ZpbGUoc3RydWN0IGlvX2tpb2NiICpyZXEsIGNvbnN0IHN0cnVjdCBp
b19pc3N1ZV9kZWYgKmRlZiwKIAlyZXR1cm4gISFyZXEtPmZpbGU7CiB9CiAKKyNkZWZpbmUg
UkVRX0lTU1VFX1NMT1dfRkxBR1MJKFJFUV9GX0NSRURTIHwgUkVRX0ZfQVJNX0xUSU1FT1VU
KQorCiBzdGF0aWMgaW50IGlvX2lzc3VlX3NxZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5z
aWduZWQgaW50IGlzc3VlX2ZsYWdzKQogewogCWNvbnN0IHN0cnVjdCBpb19pc3N1ZV9kZWYg
KmRlZiA9ICZpb19pc3N1ZV9kZWZzW3JlcS0+b3Bjb2RlXTsKIAljb25zdCBzdHJ1Y3QgY3Jl
ZCAqY3JlZHMgPSBOVUxMOworCXN0cnVjdCBpb19raW9jYiAqbGluayA9IE5VTEw7CiAJaW50
IHJldDsKIAogCWlmICh1bmxpa2VseSghaW9fYXNzaWduX2ZpbGUocmVxLCBkZWYsIGlzc3Vl
X2ZsYWdzKSkpCiAJCXJldHVybiAtRUJBREY7CiAKLQlpZiAodW5saWtlbHkoKHJlcS0+Zmxh
Z3MgJiBSRVFfRl9DUkVEUykgJiYgcmVxLT5jcmVkcyAhPSBjdXJyZW50X2NyZWQoKSkpCi0J
CWNyZWRzID0gb3ZlcnJpZGVfY3JlZHMocmVxLT5jcmVkcyk7CisJaWYgKHVubGlrZWx5KHJl
cS0+ZmxhZ3MgJiBSRVFfSVNTVUVfU0xPV19GTEFHUykpIHsKKwkJaWYgKChyZXEtPmZsYWdz
ICYgUkVRX0ZfQ1JFRFMpICYmIHJlcS0+Y3JlZHMgIT0gY3VycmVudF9jcmVkKCkpCisJCQlj
cmVkcyA9IG92ZXJyaWRlX2NyZWRzKHJlcS0+Y3JlZHMpOworCQlpZiAocmVxLT5mbGFncyAm
IFJFUV9GX0FSTV9MVElNRU9VVCkKKwkJCWxpbmsgPSBfX2lvX3ByZXBfbGlua2VkX3RpbWVv
dXQocmVxKTsKKwl9CiAKIAlpZiAoIWRlZi0+YXVkaXRfc2tpcCkKIAkJYXVkaXRfdXJpbmdf
ZW50cnkocmVxLT5vcGNvZGUpOwpAQCAtMTc0Myw4ICsxNzI5LDEyIEBAIHN0YXRpYyBpbnQg
aW9faXNzdWVfc3FlKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVf
ZmxhZ3MpCiAJaWYgKCFkZWYtPmF1ZGl0X3NraXApCiAJCWF1ZGl0X3VyaW5nX2V4aXQoIXJl
dCwgcmV0KTsKIAotCWlmIChjcmVkcykKLQkJcmV2ZXJ0X2NyZWRzKGNyZWRzKTsKKwlpZiAo
dW5saWtlbHkoY3JlZHMgfHwgbGluaykpIHsKKwkJaWYgKGNyZWRzKQorCQkJcmV2ZXJ0X2Ny
ZWRzKGNyZWRzKTsKKwkJaWYgKGxpbmspCisJCQlpb19xdWV1ZV9saW5rZWRfdGltZW91dChs
aW5rKTsKKwl9CiAKIAlpZiAocmV0ID09IElPVV9PSykgewogCQlpZiAoaXNzdWVfZmxhZ3Mg
JiBJT19VUklOR19GX0NPTVBMRVRFX0RFRkVSKQpAQCAtMTc1Nyw3ICsxNzQ3LDYgQEAgc3Rh
dGljIGludCBpb19pc3N1ZV9zcWUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGlu
dCBpc3N1ZV9mbGFncykKIAogCWlmIChyZXQgPT0gSU9VX0lTU1VFX1NLSVBfQ09NUExFVEUp
IHsKIAkJcmV0ID0gMDsKLQkJaW9fYXJtX2x0aW1lb3V0KHJlcSk7CiAKIAkJLyogSWYgdGhl
IG9wIGRvZXNuJ3QgaGF2ZSBhIGZpbGUsIHdlJ3JlIG5vdCBwb2xsaW5nIGZvciBpdCAqLwog
CQlpZiAoKHJlcS0+Y3R4LT5mbGFncyAmIElPUklOR19TRVRVUF9JT1BPTEwpICYmIGRlZi0+
aW9wb2xsX3F1ZXVlKQpAQCAtMTgwMCw4ICsxNzg5LDYgQEAgdm9pZCBpb193cV9zdWJtaXRf
d29yayhzdHJ1Y3QgaW9fd3Ffd29yayAqd29yaykKIAllbHNlCiAJCXJlcV9yZWZfZ2V0KHJl
cSk7CiAKLQlpb19hcm1fbHRpbWVvdXQocmVxKTsKLQogCS8qIGVpdGhlciBjYW5jZWxsZWQg
b3IgaW8td3EgaXMgZHlpbmcsIHNvIGRvbid0IHRvdWNoIHRjdHgtPmlvd3EgKi8KIAlpZiAo
YXRvbWljX3JlYWQoJndvcmstPmZsYWdzKSAmIElPX1dRX1dPUktfQ0FOQ0VMKSB7CiBmYWls
OgpAQCAtMTkyMSwxNSArMTkwOCwxMSBAQCBzdHJ1Y3QgZmlsZSAqaW9fZmlsZV9nZXRfbm9y
bWFsKHN0cnVjdCBpb19raW9jYiAqcmVxLCBpbnQgZmQpCiBzdGF0aWMgdm9pZCBpb19xdWV1
ZV9hc3luYyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgaW50IHJldCkKIAlfX211c3RfaG9sZCgm
cmVxLT5jdHgtPnVyaW5nX2xvY2spCiB7Ci0Jc3RydWN0IGlvX2tpb2NiICpsaW5rZWRfdGlt
ZW91dDsKLQogCWlmIChyZXQgIT0gLUVBR0FJTiB8fCAocmVxLT5mbGFncyAmIFJFUV9GX05P
V0FJVCkpIHsKIAkJaW9fcmVxX2RlZmVyX2ZhaWxlZChyZXEsIHJldCk7CiAJCXJldHVybjsK
IAl9CiAKLQlsaW5rZWRfdGltZW91dCA9IGlvX3ByZXBfbGlua2VkX3RpbWVvdXQocmVxKTsK
LQogCXN3aXRjaCAoaW9fYXJtX3BvbGxfaGFuZGxlcihyZXEsIDApKSB7CiAJY2FzZSBJT19B
UE9MTF9SRUFEWToKIAkJaW9fa2J1Zl9yZWN5Y2xlKHJlcSwgMCk7CkBAIC0xOTQyLDkgKzE5
MjUsNiBAQCBzdGF0aWMgdm9pZCBpb19xdWV1ZV9hc3luYyhzdHJ1Y3QgaW9fa2lvY2IgKnJl
cSwgaW50IHJldCkKIAljYXNlIElPX0FQT0xMX09LOgogCQlicmVhazsKIAl9Ci0KLQlpZiAo
bGlua2VkX3RpbWVvdXQpCi0JCWlvX3F1ZXVlX2xpbmtlZF90aW1lb3V0KGxpbmtlZF90aW1l
b3V0KTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIGlvX3F1ZXVlX3NxZShzdHJ1Y3QgaW9f
a2lvY2IgKnJlcSkKLS0gCjIuNDkuMAoK

--------------da06VxLQ8wCEEx2Q30wl4VwX--

