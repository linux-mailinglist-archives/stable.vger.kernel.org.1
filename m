Return-Path: <stable+bounces-12768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C983729D
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB40929403A
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31313E499;
	Mon, 22 Jan 2024 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QP4yC2uK"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB003D553
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951949; cv=none; b=L79lcJi4Ada2Eky3AEFitQVSj/PRrw7J1aJVGjZ4EsaHaa/t9VYVFg1o+/CGnf1iF86DA90bwlqmn/nxuT1W/pC87J3l0YBnQ33uj+RhoI5Wfoei7+2aM3+dUgZXrbJ+6CHa9HZMwg7wJv8Aumu3Yg9/VDMPhAHVhaGXfcZms6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951949; c=relaxed/simple;
	bh=KIew+2lpSOI1d79TMzbF8pPSW5mgsXA9LyPqm9HBEh8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=fiSiT1WDappyOuDGkp1cOsVrLnwJEeMx0xvAmtx0lhN0RahdPq3brGsX7Ns2DF3mT7rbmjj6QraXk60sECZYHZSZmiBp2bCw+e/8Y/MAET/sFoLbPsl5tRtvqRebU2eKSwh9JFfr2rpCz8VYXZEVNehmSfLPfAbOy353YOcdvSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QP4yC2uK; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bee01886baso43865939f.1
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705951945; x=1706556745; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onAyOaWlkSN9ovjxpvLBfl8gRMA5LiqGu31Jsu5NdzU=;
        b=QP4yC2uKwBATMTb3aUUOh/q/DGcm6a6C4W5yn0VLetcUrPn398YJnL46PzjtQ0NoWg
         0ZlKcKVIDX1A4pS+wm8SWgXLFrYwvVEkz63N8Wi5C6CuVqXy5koIQRTqz9cd38UKKd/0
         /+yD3fnZpECVPni7LDk0qsiiNZGW5q1NcFfjPUgdjw8z0f8U6oIVNViXAMMYY/fXL0jB
         ctXsL+JX5kOzO0FQQ6h+gRng1OZl5MuCt6SkJ4GUmiDg4TpWLjG5Gy0zI+ruiFvhKz6y
         VhJxu8x+f71kO6ZD9EgZzVvyqay0Rftoy20uF7iNhi1BL/93n3nDLoRl3ewK081WYF6t
         7C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705951945; x=1706556745;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=onAyOaWlkSN9ovjxpvLBfl8gRMA5LiqGu31Jsu5NdzU=;
        b=mea4+To67FLLIdp0kO4WvllfaKh3MkAPmytBn2AmqAxcoRtjtE2QzvvTtafoPeiUaU
         VB2DwRY/xsUUK/T7D+UxeRX9U2ZzuqBNG2Mf/RDGnysxtcukGyS9ITdSU04D3M7v6b0o
         O0jP2Lw+v/cxlE2MKxJ/CUxTT7t3xkoc7feR2q14vm0m6MsdG9aYwjfomn8BOb9Je6Su
         nKwn+Bbo/JEyuNNrqJtB6r0eECX+sK6Uobq4OtLon/PWYuZAk5fHLgaF+1Bx7u2m99vn
         K8rUJM/KkktxFcIbofsAVMT2pKU/AHQVoC6q9L6WlcnIp6NDcKZovu4ma2FzImsQPGtm
         f54w==
X-Gm-Message-State: AOJu0YyFq9DvVLpjOT+xBZ3ALR+RbqAdbzwJis5BGfHdCStiW1vWMWkt
	aDvmINBT8M/vzWpWpYH6G9GByupBqcu72uPxtYqiRMJOLhC0kOc+FDhBbLOuuVU=
X-Google-Smtp-Source: AGHT+IEEXPlfUu1LZgXGAeKwuWC021PQ46fhPJUnN0AYvf9Tfw98bAJarAD2nHQM7hg5ZytLQab5kw==
X-Received: by 2002:a05:6e02:1caa:b0:35f:fa79:644 with SMTP id x10-20020a056e021caa00b0035ffa790644mr7517393ill.3.1705951945692;
        Mon, 22 Jan 2024 11:32:25 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j26-20020a056e02221a00b00361a166564csm3083256ilf.4.2024.01.22.11.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 11:32:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------aUdhj370OJPEVi0WqLGilags"
Message-ID: <9326c0e9-fa64-4082-a577-c9c5b6f01917@kernel.dk>
Date: Mon, 22 Jan 2024 12:32:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: ensure io->bytes_done is
 always initialized" failed to apply to 5.15-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, xrivendell7@gmail.com
Cc: stable@vger.kernel.org
References: <2024012216-depth-bartender-bc38@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024012216-depth-bartender-bc38@gregkh>

This is a multi-part message in MIME format.
--------------aUdhj370OJPEVi0WqLGilags
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/24 12:27 PM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This one applies to 5.10 and 5.15 stable, it should go into both.
It's the same patch, just in the older bigger unified file.

-- 
Jens Axboe


--------------aUdhj370OJPEVi0WqLGilags
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-rw-ensure-io-bytes_done-is-always-initializ.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-rw-ensure-io-bytes_done-is-always-initializ.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAyZmI5NmVjZjY4YmMxZmI1NTUwOGQyMmViYWY5NTE4ZWFlYjFhMDg4IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMjIgSmFuIDIwMjQgMTI6MzA6MDcgLTA3MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9ydzogZW5zdXJlIGlvLT5ieXRlc19kb25lIGlzIGFsd2F5cyBpbml0aWFsaXpl
ZAoKY29tbWl0IDBhNTM1ZWRkYmUwZGMxZGU0Mzg2MDQ2YWI4NDlmMDhhZWIyZjhmYWYgdXBz
dHJlYW0uCgpJZiBJT1NRRV9BU1lOQyBpcyBzZXQgYW5kIHdlIGZhaWwgaW1wb3J0aW5nIGFu
IGlvdmVjIGZvciBhIHJlYWR2IG9yCndyaXRldiByZXF1ZXN0LCB0aGVuIHdlIGxlYXZlIC0+
Ynl0ZXNfZG9uZSB1bmluaXRpYWxpemVkIGFuZCBoZW5jZSB0aGUKZXZlbnR1YWwgZmFpbHVy
ZSBDUUUgcG9zdGVkIGNhbiBwb3RlbnRpYWxseSBoYXZlIGEgcmFuZG9tIHJlcyB2YWx1ZQpy
YXRoZXIgdGhhbiB0aGUgZXhwZWN0ZWQgLUVJTlZBTC4KClNldHVwIC0+Ynl0ZXNfZG9uZSBi
ZWZvcmUgcG90ZW50aWFsbHkgZmFpbGluZywgc28gd2UgaGF2ZSBhIGNvbnNpc3RlbnQKdmFs
dWUgaWYgd2UgZmFpbCB0aGUgcmVxdWVzdCBlYXJseS4KCkNjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnClJlcG9ydGVkLWJ5OiB4aW5nd2VpIGxlZSA8eHJpdmVuZGVsbDdAZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9f
dXJpbmcvaW9fdXJpbmcuYyB8IDkgKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL2lvX3Vy
aW5nLmMgYi9pb191cmluZy9pb191cmluZy5jCmluZGV4IDMwNTM1ZDRlZGVlNy4uNTVmZDZk
OThmZTEyIDEwMDY0NAotLS0gYS9pb191cmluZy9pb191cmluZy5jCisrKyBiL2lvX3VyaW5n
L2lvX3VyaW5nLmMKQEAgLTM0OTAsMTQgKzM0OTAsMTcgQEAgc3RhdGljIGlubGluZSBpbnQg
aW9fcndfcHJlcF9hc3luYyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgaW50IHJ3KQogCXN0cnVj
dCBpb3ZlYyAqaW92ID0gaW9ydy0+ZmFzdF9pb3Y7CiAJaW50IHJldDsKIAorCWlvcnctPmJ5
dGVzX2RvbmUgPSAwOworCWlvcnctPmZyZWVfaW92ZWMgPSBOVUxMOworCiAJcmV0ID0gaW9f
aW1wb3J0X2lvdmVjKHJ3LCByZXEsICZpb3YsICZpb3J3LT5pdGVyLCBmYWxzZSk7CiAJaWYg
KHVubGlrZWx5KHJldCA8IDApKQogCQlyZXR1cm4gcmV0OwogCi0JaW9ydy0+Ynl0ZXNfZG9u
ZSA9IDA7Ci0JaW9ydy0+ZnJlZV9pb3ZlYyA9IGlvdjsKLQlpZiAoaW92KQorCWlmIChpb3Yp
IHsKKwkJaW9ydy0+ZnJlZV9pb3ZlYyA9IGlvdjsKIAkJcmVxLT5mbGFncyB8PSBSRVFfRl9O
RUVEX0NMRUFOVVA7CisJfQogCWlvdl9pdGVyX3NhdmVfc3RhdGUoJmlvcnctPml0ZXIsICZp
b3J3LT5pdGVyX3N0YXRlKTsKIAlyZXR1cm4gMDsKIH0KLS0gCjIuNDMuMAoK

--------------aUdhj370OJPEVi0WqLGilags--

