Return-Path: <stable+bounces-143263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B81AB3815
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E48A3AF75E
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1510420322;
	Mon, 12 May 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IiHSHtxS"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4725C710
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055245; cv=none; b=L/umNNobq1YFTQ65TOcFUDKN4bDCQFKLKYsFVvzt/xYeObDqRlnX4Th4VEhD6PsdcMLbii2qpUkQ747cbflVczwqlzs+zvUA8euJ71eP9k7o57KaMn2GueU5Xe2t5w7AMZfVApc6hN3GkkadQ5pIjld9cxwAprPA3jefS1SeBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055245; c=relaxed/simple;
	bh=/es/OGqj+dunjHemPVZaFc2eHnLlOtafXIS3cQwbIo8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=dYK5MgeBBs1k9UuwJQLBCcxPKOIn2q3n6qEnvpUldo8gSm8sdZuytaupxvdDD++aJUD0UapnJaGYpT/u6bf/USMcMauyvsL/j50vS4dVaVwVjUSeUQ2Nw9rO02K8RwGfUGwWd5zTE9GApQ1Gm7I8wqB6LVApX/VKohG6cLTHeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IiHSHtxS; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2d5e5e21b92so3271419fac.0
        for <stable@vger.kernel.org>; Mon, 12 May 2025 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747055240; x=1747660040; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WYl3ux3wxZcYZl2fHIrqxq1iEi/69TL/mFHXbbBymw=;
        b=IiHSHtxSRhNFCIoWxYkxN14Wk/LqXgU1yEjN7Yf8qcAxIto/zgpH0u1HankRqm/iun
         P41QXcdR9LTZpW/WmlBsIeqCV3OtQJN7ellk1r24hJj4TYr1lkaSX3pB5lUdisC4oOe7
         mPYirhv7rzvrfRD6orGvyGBNWKuRUuzg1Ba4ekqf/aeWJROgyjyUj0Zp5nMVOewJPbFa
         z9dse9+Jw1tU6ggEaurL4HjXRwDtGb1CwutrewtXGaHUWtkSUBh/sEhOJmN6Lstjti4l
         q5fEwPaOaZ717MPTTWpcuxzl9HLbDFmKUaujHhmfkSHi8UQ92uNUc/FdijXjtq17SIOu
         rOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055240; x=1747660040;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9WYl3ux3wxZcYZl2fHIrqxq1iEi/69TL/mFHXbbBymw=;
        b=qKewfbkkSVSUvTbmnC/wDUq//0WF7MRI+KrLAyTSMLVYxH1au2ltwNnfKruzT+piDJ
         YnC4g0Vj05b92XqaIIImHsjh5EtCn4Q5lqYhXGpgbosiWxczwBp+CwMJUafnUuf3STk5
         tVF34QhYoB4vAPYRQSD6NfwuLo8TB6iulHjGZc+Bz5lv6qH+Gu8drrazTOJBexAg/GUE
         qNHfX60IW5yV8wnSJ6EF+Sm0QqUlRtVAushmb+nn8vYHmq75vtb69NkiUl5CXiIA22Zn
         8TmdLyh1bX54ZczZxWo8RZYsZhnAmRIVX9hBmTrFporLk+vz/ZX/h+FD9VzewkEkrEDj
         Ok8w==
X-Gm-Message-State: AOJu0Yy48bWfK34gkFpEw5kmJyMXuHWq3jb1a2nktRZQdMeyN8TcCzJ4
	W6pQiHfWxhiKASXumYz0TmWQ/0UKpHZcvL/u5fnGWlvit1UahzdEMRkqeKQ1b9w=
X-Gm-Gg: ASbGncvuB5JVAZUhA2GXrGfBf04G9j4slHw4jvLSAQJSYfQguRVuvdGdi9FP0wCG+vm
	Vdyv1Ch1zFKV5QqwMjdcnT0O2wO7braxrTI36ztgG3S83wh5JbnIUowjLVzUinx5Tf8K8UHp4f9
	K0OETSIFAzMH9PMByQlRTTG+KKDlinSlH6i9tYaZ4D/wQvWXHRevy9YIN7oy5X0Kgp8JqVJh8kO
	le9ZdXffS4wE6F4cB97xBjUZcn90zOcyR+HYEOdCcc5leSe/NdsQuIHu0+v5xdPApWPdAOm2C4M
	M8+j9z9frJvHy9VqgD3oI2/FMl8LB9rDAUoDUPMXB8d9NxQ=
X-Google-Smtp-Source: AGHT+IGrGzkGvQeQYp2tbD31wHSZiipCBqMTcD6wei6fg9++cgcGok+CccrjbchUyaauzwuHFIvI4A==
X-Received: by 2002:a05:6870:46aa:b0:2da:843d:e530 with SMTP id 586e51a60fabf-2dba4213f57mr7916993fac.2.1747055239840;
        Mon, 12 May 2025 06:07:19 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fa226587acsm1590648173.115.2025.05.12.06.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:07:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------dr0SvtAF9P0T4ynx9lEealyg"
Message-ID: <a7dc23a8-8696-47b7-bcb2-3d45993b6c5b@kernel.dk>
Date: Mon, 12 May 2025 07:07:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: ensure deferred completions are
 flushed for" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, christian.mazakas@gmail.com,
 norman_maurer@apple.com
Cc: stable@vger.kernel.org
References: <2025051212-antirust-outshoot-07f7@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025051212-antirust-outshoot-07f7@gregkh>

This is a multi-part message in MIME format.
--------------dr0SvtAF9P0T4ynx9lEealyg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 4:01 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's a tested 6.1-stable backport.

-- 
Jens Axboe

--------------dr0SvtAF9P0T4ynx9lEealyg
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-ensure-deferred-completions-are-posted-for-.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-ensure-deferred-completions-are-posted-for-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkNzE0ZGJkZmNlODU4YmMzMjBhMGU5Zjk4M2Y3MjY1Mjk4OGZmMTFiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFdlZCwgNyBNYXkgMjAyNSAwODowNzowOSAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBpb191cmluZzogZW5zdXJlIGRlZmVycmVkIGNvbXBsZXRpb25zIGFyZSBwb3N0ZWQgZm9y
CiBtdWx0aXNob3QKCkNvbW1pdCA2ODdiMmJhZTBlZmZmOWIyNWUwNzE3MzdkNmFmNTAwNGU2
ZTM1YWY1IHVwc3RyZWFtLgoKTXVsdGlzaG90IG5vcm1hbGx5IHVzZXMgaW9fcmVxX3Bvc3Rf
Y3FlKCkgdG8gcG9zdCBjb21wbGV0aW9ucywgYnV0IHdoZW4Kc3RvcHBpbmcgaXQsIGl0IG1h
eSBmaW5pc2ggdXAgd2l0aCBhIGRlZmVycmVkIGNvbXBsZXRpb24uIFRoaXMgaXMgZmluZSwK
ZXhjZXB0IGlmIGFub3RoZXIgbXVsdGlzaG90IGV2ZW50IHRyaWdnZXJzIGJlZm9yZSB0aGUg
ZGVmZXJyZWQgY29tcGxldGlvbnMKZ2V0IGZsdXNoZWQuIElmIHRoaXMgb2NjdXJzLCB0aGVu
IENRRXMgbWF5IGdldCByZW9yZGVyZWQgaW4gdGhlIENRIHJpbmcsCmFuZCBjYXVzZSBjb25m
dXNpb24gb24gdGhlIGFwcGxpY2F0aW9uIHNpZGUuCgpXaGVuIG11bHRpc2hvdCBwb3N0aW5n
IHZpYSBpb19yZXFfcG9zdF9jcWUoKSwgZmx1c2ggYW55IHBlbmRpbmcgZGVmZXJyZWQKY29t
cGxldGlvbnMgZmlyc3QsIGlmIGFueS4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnICMg
Ni4xKwpSZXBvcnRlZC1ieTogTm9ybWFuIE1hdXJlciA8bm9ybWFuX21hdXJlckBhcHBsZS5j
b20+ClJlcG9ydGVkLWJ5OiBDaHJpc3RpYW4gTWF6YWthcyA8Y2hyaXN0aWFuLm1hemFrYXNA
Z21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+
Ci0tLQogaW9fdXJpbmcvaW9fdXJpbmcuYyB8IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIv
aW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCA0ODg3OTNiMTE5ZDAuLmYzOWQ2NjU4OTE4MCAx
MDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9pb191cmlu
Zy5jCkBAIC04MTksNiArODE5LDE0IEBAIGJvb2wgaW9fcG9zdF9hdXhfY3FlKHN0cnVjdCBp
b19yaW5nX2N0eCAqY3R4LAogewogCWJvb2wgZmlsbGVkOwogCisJLyoKKwkgKiBJZiBtdWx0
aXNob3QgaGFzIGFscmVhZHkgcG9zdGVkIGRlZmVycmVkIGNvbXBsZXRpb25zLCBlbnN1cmUg
dGhhdAorCSAqIHRob3NlIGFyZSBmbHVzaGVkIGZpcnN0IGJlZm9yZSBwb3N0aW5nIHRoaXMg
b25lLiBJZiBub3QsIENRRXMKKwkgKiBjb3VsZCBnZXQgcmVvcmRlcmVkLgorCSAqLworCWlm
ICghd3FfbGlzdF9lbXB0eSgmY3R4LT5zdWJtaXRfc3RhdGUuY29tcGxfcmVxcykpCisJCV9f
aW9fc3VibWl0X2ZsdXNoX2NvbXBsZXRpb25zKGN0eCk7CisKIAlpb19jcV9sb2NrKGN0eCk7
CiAJZmlsbGVkID0gaW9fZmlsbF9jcWVfYXV4KGN0eCwgdXNlcl9kYXRhLCByZXMsIGNmbGFn
cywgYWxsb3dfb3ZlcmZsb3cpOwogCWlvX2NxX3VubG9ja19wb3N0KGN0eCk7Ci0tIAoyLjQ5
LjAKCg==

--------------dr0SvtAF9P0T4ynx9lEealyg--

