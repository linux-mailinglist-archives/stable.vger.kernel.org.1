Return-Path: <stable+bounces-108339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2916DA0AA3F
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 15:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B28827A35CE
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 14:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A061B87DF;
	Sun, 12 Jan 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sRib3u/v"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFF91B3948
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736693731; cv=none; b=WLLnb3UM2W/+H9UpDChNef9IelkW7EdSo2X6gAAwmIic8vLffvhNq8qKOIvRIUgV5j7xJpp13VwvJKmy5YYCW87WAv/K22hl7Un8860so27aGng81loqekuRrd0W3WFTKBY4/U4iuGVevbO+HqvE2vEVZMTCq1ITuhfBQcAbviY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736693731; c=relaxed/simple;
	bh=wfHCAQZPTAC2s/EcSeV6bFPQnqHSz5C/aSKSVEP8cQw=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=PX6j4siL5d87bVj48yyZpP6RG8AY/I/bgPJ8kZjCwyT6x+nh8bHGHNRjF0itVCGiP3FKmwZG3k1W0b8t0C0s/GZUvTbdWQBRQhy2JaGvGfU8rkOEbojcufPUS/jQxqAm001fgdKD9bIJHT5dR2xCMjOcvdU/YGJQvO+wAMv8jLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sRib3u/v; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ce46520a29so21821475ab.1
        for <stable@vger.kernel.org>; Sun, 12 Jan 2025 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736693728; x=1737298528; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4fpuqAkLEOiFYreYOKeMcvJzuwRogY8kut/I4DlD5o=;
        b=sRib3u/vV0osc0xcFCk//Rk1LLlgy2tK7bR59z5P9epbZsV05rWmGc6p5jUQFg6I2n
         gIzUQAN8AxG89mKGY0Pr6HL0tKzaZhC+s23R5aZaPEQzVQbMFt77Xj4aWDuLmyjMPPa4
         FfRI0oumQgovty9Ls5c1yxp2OWxM9bp5uG9+J3J53RUcr79l3TddOJWdTaWD6vE3tmPS
         cNdHbSHqa2JNg9k9W8mH9Up/auk7mTY6XCFNEq/SULYmaceVwAhP4yPpO3Bvcjwm/j+Y
         qknvxkfq/HS4cYXrKnutvnZ+8GxGfLAV8WszxYvJG2JBlc3pXKgiXu0g9H/49PS/1FJ5
         3v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736693728; x=1737298528;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G4fpuqAkLEOiFYreYOKeMcvJzuwRogY8kut/I4DlD5o=;
        b=bZWbfzAnqE3ZPLe+zJmogrRdXuKVhoZgN8OMEWLX2cfWUX3BecKwelXV7BR44F1uF8
         JQmeEiu6vBnmzYgEWJ5lQaex5xspqsb9PZBW2cjOdvbGyMVg1oWap90csqdQvvD9VyOU
         m9wMn/IK1rSMo/ioFrE+W+zwKe+5OvaVYes7nFOX+ZsOPSwSaWcwbUZulOY44HxjfCNa
         bTB2OmJQPgx+HuAibfaHK77dW/8z7Uthy6mc4GAiYBRBJnRo+RB7PQaGC5oteEFnKrVS
         0BClGQh41DHB/cx0ONX9G0ZwbFw5786HDAZrm0hAOpf0IZfREXHq82Nm+TRVopuQhUCC
         NLOw==
X-Gm-Message-State: AOJu0YzpV5hzLz5rKfxMjG+bl6suG4CzauIJVgTtgj6P4B47I7JT9fzQ
	Sn7omnRY+8gASQ/K8HGxURrNEoClMiUnuiPoKomLzzeNMe6SZTGf+aYNqXjP6RoI9aRlYU7magB
	f
X-Gm-Gg: ASbGnctmolbXShpxgnr3hFT85VE2FJG7B07oGQdKpSaAS89DVI51fYolBm9t4P615WZ
	hSwzv447CbJ7R/drYE2Yhl0TMIUpOrHKgRfbf/NxkOT235aN9Mv0X/+8s9xZ9PsFYBdeKJlRfpr
	aLfh1bnCvvQXy1Od1RvDs90xB1ujpGx32KmffMy7bZUV0+EkeW5ztRB6LimmgnyXWgcKsDoI9v2
	6AR+YxEoO9ADnItk8MkDAPeHTXKeGTNRUww5jr5HWjrn+lJOL2bgQ==
X-Google-Smtp-Source: AGHT+IGWMQkEiRol/YBDCVpnnUSvNM3AtSdMMHXZD3qnxQgvtFJuwUvrbSkwwTp+H2MJVIaIVRXgaw==
X-Received: by 2002:a05:6e02:3d01:b0:3a7:d84c:f2b0 with SMTP id e9e14a558f8ab-3ce3a87d5d7mr159556555ab.8.1736693728503;
        Sun, 12 Jan 2025 06:55:28 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b71782dsm2157364173.105.2025.01.12.06.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 06:55:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------0DtWDkYy5v9D6OzykGHCRKLF"
Message-ID: <aa85959b-2890-42c9-beb8-0e0109494d90@kernel.dk>
Date: Sun, 12 Jan 2025 07:55:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/eventfd: ensure
 io_eventfd_signal() defers another" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, jannh@google.com, lizetao1@huawei.com,
 ptsm@linux.microsoft.com
Cc: stable@vger.kernel.org
References: <2025011246-appealing-angler-4f22@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025011246-appealing-angler-4f22@gregkh>

This is a multi-part message in MIME format.
--------------0DtWDkYy5v9D6OzykGHCRKLF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/25 2:16 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x c9a40292a44e78f71258b8522655bffaf5753bdb
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011246-appealing-angler-4f22@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

And here's the 6.1 version.

-- 
Jens Axboe

--------------0DtWDkYy5v9D6OzykGHCRKLF
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-eventfd-ensure-io_eventfd_signal-defers-ano.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-eventfd-ensure-io_eventfd_signal-defers-ano.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBhODEyYTY1MzE1OTVkN2UwNDEyYzRmMDVlZGU2MDMyZjA0Yzg2ZWY3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFdlZCwgOCBKYW4gMjAyNSAxMToxNjoxMyAtMDcwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nL2V2ZW50ZmQ6IGVuc3VyZSBpb19ldmVudGZkX3NpZ25hbCgpIGRlZmVycyBhbm90
aGVyCiBSQ1UgcGVyaW9kCgpDb21taXQgYzlhNDAyOTJhNDRlNzhmNzEyNThiODUyMjY1NWJm
ZmFmNTc1M2JkYiB1cHN0cmVhbS4KCmlvX2V2ZW50ZmRfZG9fc2lnbmFsKCkgaXMgaW52b2tl
ZCBmcm9tIGFuIFJDVSBjYWxsYmFjaywgYnV0IHdoZW4KZHJvcHBpbmcgdGhlIHJlZmVyZW5j
ZSB0byB0aGUgaW9fZXZfZmQsIGl0IGNhbGxzIGlvX2V2ZW50ZmRfZnJlZSgpCmRpcmVjdGx5
IGlmIHRoZSByZWZjb3VudCBkcm9wcyB0byB6ZXJvLiBUaGlzIGlzbid0IGNvcnJlY3QsIGFz
IGFueQpwb3RlbnRpYWwgZnJlZWluZyBvZiB0aGUgaW9fZXZfZmQgc2hvdWxkIGJlIGRlZmVy
cmVkIGFub3RoZXIgUkNVIGdyYWNlCnBlcmlvZC4KCkp1c3QgY2FsbCBpb19ldmVudGZkX3B1
dCgpIHJhdGhlciB0aGFuIG9wZW4tY29kZSB0aGUgZGVjLWFuZC10ZXN0IGFuZApmcmVlLCB3
aGljaCB3aWxsIGNvcnJlY3RseSBkZWZlciBpdCBhbm90aGVyIFJDVSBncmFjZSBwZXJpb2Qu
CgpGaXhlczogMjFhMDkxYjk3MGNkICgiaW9fdXJpbmc6IHNpZ25hbCByZWdpc3RlcmVkIGV2
ZW50ZmQgdG8gcHJvY2VzcyBkZWZlcnJlZCB0YXNrIHdvcmsiKQpSZXBvcnRlZC1ieTogSmFu
biBIb3JuIDxqYW5uaEBnb29nbGUuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpT
aWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJp
bmcvaW9fdXJpbmcuYyB8IDEzICsrKysrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9f
dXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggOWI1OGJhNDYxNmQ0Li40ODA3
NTJmYzNlYjYgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJp
bmcvaW9fdXJpbmcuYwpAQCAtNDc5LDYgKzQ3OSwxMyBAQCBzdGF0aWMgX19jb2xkIHZvaWQg
aW9fcXVldWVfZGVmZXJyZWQoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCiAJfQogfQogCitz
dGF0aWMgdm9pZCBpb19ldmVudGZkX2ZyZWUoc3RydWN0IHJjdV9oZWFkICpyY3UpCit7CisJ
c3RydWN0IGlvX2V2X2ZkICpldl9mZCA9IGNvbnRhaW5lcl9vZihyY3UsIHN0cnVjdCBpb19l
dl9mZCwgcmN1KTsKKworCWV2ZW50ZmRfY3R4X3B1dChldl9mZC0+Y3FfZXZfZmQpOworCWtm
cmVlKGV2X2ZkKTsKK30KIAogc3RhdGljIHZvaWQgaW9fZXZlbnRmZF9vcHMoc3RydWN0IHJj
dV9oZWFkICpyY3UpCiB7CkBAIC00OTIsMTAgKzQ5OSw4IEBAIHN0YXRpYyB2b2lkIGlvX2V2
ZW50ZmRfb3BzKHN0cnVjdCByY3VfaGVhZCAqcmN1KQogCSAqIG9yZGVyaW5nIGluIGEgcmFj
ZSBidXQgaWYgcmVmZXJlbmNlcyBhcmUgMCB3ZSBrbm93IHdlIGhhdmUgdG8gZnJlZQogCSAq
IGl0IHJlZ2FyZGxlc3MuCiAJICovCi0JaWYgKGF0b21pY19kZWNfYW5kX3Rlc3QoJmV2X2Zk
LT5yZWZzKSkgewotCQlldmVudGZkX2N0eF9wdXQoZXZfZmQtPmNxX2V2X2ZkKTsKLQkJa2Zy
ZWUoZXZfZmQpOwotCX0KKwlpZiAoYXRvbWljX2RlY19hbmRfdGVzdCgmZXZfZmQtPnJlZnMp
KQorCQljYWxsX3JjdSgmZXZfZmQtPnJjdSwgaW9fZXZlbnRmZF9mcmVlKTsKIH0KIAogc3Rh
dGljIHZvaWQgaW9fZXZlbnRmZF9zaWduYWwoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCi0t
IAoyLjQ3LjEKCg==

--------------0DtWDkYy5v9D6OzykGHCRKLF--

