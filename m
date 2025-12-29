Return-Path: <stable+bounces-203604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E97E5CE6FD9
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDA0B300C6E1
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7105E3128C5;
	Mon, 29 Dec 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="181ARnMH"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE78821
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017813; cv=none; b=SRSN1qNsGQc8pGPIXtF25Dp6zAnfAqg/pr3U8YTufE9/o3aBgN6U4mkKwMAXXCk8y3DS14kZwREa9kOGVyIMv3Xfj9HEjzuFyrjxUcM6+SWZ4kA00VLVdb5SOaPSzpbjdf+qstkSCi/lSufxsz9MmuiSIucvZ6bnAse5DleqcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017813; c=relaxed/simple;
	bh=d3J3v1DKmbcruhzVTlB0j7XPOAiycdw3OPpTIHblkEk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Mp5+rbb71X8qNa+5pPfEC0yoIvArr03hJdDoQrnVGIh2ZVaAz9Rnd3JqfVedjvWWSNG+fK2pr+wGIAsJdXeZH2vAthac8haqxc0BWr81odKoYYZubiRgZFRLEdMonSoRsCt/0A/cdSNbga0UE4HMiyl5cyCGXlvbkUD6udV90dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=181ARnMH; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-65d132240b5so5040090eaf.2
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 06:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767017808; x=1767622608; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UINXBwZaq8zvu2Ii4PTcqPJcC6mIxKJRXBJy1dgJWJ8=;
        b=181ARnMHA0AVvLtLtgtlGRl6RgOnCVF/4mUMBf5daaqwuUSSy+S6nqHQsj0EXqTm77
         +ka0l9iieBqA+d2pqtzSRHrnaRqq6Y5P6vrsGyj8HgWgHYGGMXGQXBDjZPVBkNOu3ixA
         LsIlz0a6Up0dVbabVtv+fj9Nip0vsAdQErDZdZC1LPANDheCFlO9+ANe52h5LZw9GVnX
         pC+bqO5MjjIZJBzJoNu3l4/OIM6J7P8bqbQMsnwvwwJJNSP4pUswSEE6DYxyiY1pmlaY
         ET5NiDc9QOPgAAid2CjrtwFlrE/3o/A/cOVUsf0fLCu9R/oM39VXDmN1UCesTzgdEXQJ
         nfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767017808; x=1767622608;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UINXBwZaq8zvu2Ii4PTcqPJcC6mIxKJRXBJy1dgJWJ8=;
        b=uN8dilM3t1qqWGG4fFcRpLwYBurWVP8SJgtJzuJysUsEsegFc1mjFWR7MK8IlZKg/Z
         oKy3KJ27K/X3JCswgGDWa0ctZW198Q3YRx6L1AatzLrooS1zDa1GqOuKMVwSQi88yuMw
         9PYdmoEeIiCgO5O4sxtYg4nq290CFsBb4xcEDD3iVsv6Hmsu4M1ebqnvCmlmYoiuH7av
         T2kk577M4ip7BH36ZcA7aFcqQ4EM28ThDYYHE9wxanjsOHCfUd708TQKVBmVQbx1MMvM
         0aaQFb1hlCbshCpca1ft3USGARQ1ebnq4EFvDt8tZlh5QU3JONggl9NMh/znsTTfjyDd
         BbwA==
X-Gm-Message-State: AOJu0YyeTMvqmr8KBMMtQsl8LC61NdEjjDR8G4jJIU5BoSj4371Mj3NN
	X05jXUpfq3o3n4unnHPtuz/Z27/8rxmYXF25hlXz7Nz3CWQExNXD0tkceL68Bch2seLVUfsQ7vY
	z+l5o
X-Gm-Gg: AY/fxX4snbswRc/d19bKzH5XuDg9S2HNEMytdlfxRIwcFtVTnaWwmaM2MRCgU9GVEnm
	+RK2Ln3yHmg+v++NQHMAf2VX1p3121HONXrKKkKlL0InJRyx8TmHA9Obt2lx2wAnQTrWDMk0tht
	/I8mqezLoXEkDjy/E/lLZ1MOqej6DkXDCTtcGEyUeY3hfYGBYl6wWzBnzBfhwrVhAeNwDWlI1go
	3mEWT0MzwzsSPVNRo7gRCmCtXRMKMJWnFph7kj16+Zqq12q/KUj2nNibr5IgaMjHpYgcdg1hVks
	EHzgd9HT7AuFj0AyUtJ3Q7msPfXTGlGj0B+VQdO1CPuSkfSiXb7vrhGXViK0D62VVEZ1FUbm5em
	GB1r+FgWA8/NJVulpfZ2LJgns72vttl9RcFkDjgXmgOQ0TvDF+D6jbQ4NjTuSUOaPOTtbNYkuND
	CbWLsL7hE0p7J0TJF/LyA=
X-Google-Smtp-Source: AGHT+IFc/0WRHoW1ELOGgpL5TCrXeZleDkJ5zFoqJ+auVkfsXMpNLMSUq4paJNi6yv3c0oCLM0O6dQ==
X-Received: by 2002:a05:6820:151b:b0:65d:4d:4243 with SMTP id 006d021491bc7-65d0eb2e757mr13359235eaf.45.1767017808344;
        Mon, 29 Dec 2025 06:16:48 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65d0f69ae7esm18801678eaf.9.2025.12.29.06.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 06:16:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------F7TpjfjK4OMaKP0VxM00ZAy7"
Message-ID: <d8706721-d859-4040-8d24-aa9ffe876eab@kernel.dk>
Date: Mon, 29 Dec 2025 07:16:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: correctly handle
 io_poll_add() return value on" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2025122905-unused-cash-520e@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025122905-unused-cash-520e@gregkh>

This is a multi-part message in MIME format.
--------------F7TpjfjK4OMaKP0VxM00ZAy7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 4:34 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.1-stable.

-- 
Jens Axboe

--------------F7TpjfjK4OMaKP0VxM00ZAy7
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-correctly-handle-io_poll_add-return-va.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-correctly-handle-io_poll_add-return-va.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiY2Y4NGIxYWFhNmM1YTVhZDU4M2Q2YWI4NTZhMDUyZDU3OTFlNGNjIE1vbiBTZXAg
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
Z2l0IGEvaW9fdXJpbmcvcG9sbC5jIGIvaW9fdXJpbmcvcG9sbC5jCmluZGV4IGU5ZjgzZDNm
YzgzNS4uZDRkMTA3OTMxZjYyIDEwMDY0NAotLS0gYS9pb191cmluZy9wb2xsLmMKKysrIGIv
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
cmVxX3NldF9mYWlsKHByZXEpOwogCWlvX3JlcV90YXNrX2NvbXBsZXRlKHByZXEsICZsb2Nr
ZWQpOwogb3V0OgogCWlvX3Jpbmdfc3VibWl0X3VubG9jayhjdHgsIGlzc3VlX2ZsYWdzKTsK
LS0gCjIuNTEuMAoK

--------------F7TpjfjK4OMaKP0VxM00ZAy7--

