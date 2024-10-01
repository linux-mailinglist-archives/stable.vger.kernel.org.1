Return-Path: <stable+bounces-78499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027698BE5A
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19BC1F228AD
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049A1BBBC0;
	Tue,  1 Oct 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lxyHK8Tl"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA9224CF
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790620; cv=none; b=eZkXACQwMuYmj+SQulzPJKRea7rCHT2DzD5qcECJ/jiIzZE8RdrFU8D1o5FcOvKVl2Ao/aLaOHb/ENneoOJK0o9+EwQvIH46yy5hMCp1me5+A5ozkEgi1O7Og/BvHwQQCjY6vP3rT4wednwcDk4VOGP5l8ManVTJ4hi0Cf3RmTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790620; c=relaxed/simple;
	bh=PFrR7AUjQUj+jGNihbhbyKUlOM4tm8nIqbDCWAqUmr0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=AeAL5uNqcrv10R5lFFr0dT7BlYLcvuvJ1YYF5Zhi8ByKtVhPxDqjloiwbOlQTyKV8OeyY+v8MzUt1SeTHPNyoVmbyGY/ZLf0mGTD9WTOnlnb2eciJUzK/IwU69aPYJtW7oAoq2WBr96YxlrirFHwcqd4qmQQco9ufEovOw/ySsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lxyHK8Tl; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-83493f2dda4so143821939f.1
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727790618; x=1728395418; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6/fkKWZRbv0TsE2oolIwh954/3x3EYCzE1oVtVXZ28=;
        b=lxyHK8TlqrNvumCfPT2cL9L4O0kcGyK8nn7WV4FJ7iKI8+6DxBYfK2pUq8WU992+F4
         IdsX1QqksYo219Cws556iVkkAJAcNeEQxv50maARn+HmrGbKuT0IhwoVUGM1Wpov2mWS
         LOiNxjHhQB+NDEspaxOVvikv0yW4rrCF2fCD6mH9vuqV6VWOUnnF+c9CcfDVo0wG8+pt
         4IkSdKhV9OuHxu9n8OE3vPD0ejxLzGHXjxLKjmRBoWpCxUhFUjHmAE1g2Ysa7q8yJDL2
         Gw8AUlRwvdcFXjf9/RYZ3RQf8+CVX2vFym/Fru6tv29+VJQbion8jCuHRu/0zXbaGqxf
         sepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790618; x=1728395418;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V6/fkKWZRbv0TsE2oolIwh954/3x3EYCzE1oVtVXZ28=;
        b=IERs4Gfi6cM/FbGrhZ72TcoYNqlicj9+/MbCBV0qshzKaI5IbFH9ODpR7X3PBnpcB4
         rMViZMLAC6nLnFf8ynec6/7WfR6fgq1zoGivP+tEqGGM+6uXbuK6M51nvbHpXrJP1HzJ
         e5BZt7ymLMi0OdDrzEGF1gHzjWVFMHqLaHMt0vX/9B+D17K3oWI95QDo/QFQr2xVmbk7
         e/zrYJnj7PcFoGXkV1hm7aQEbQcCYJRKdUPNpXCjZBr9Qa0tlETFcCyBu1Modz2BC+jB
         BO3cRG1G9ztqLUtszaxPbQSZ8ZB3YG8PiaAQtOEMRF7uhi0Snsmu5tsJfVFDQPcVLSvU
         qKSw==
X-Gm-Message-State: AOJu0YwGoMTljkZ2SPRODO1LKF83V3o/ho/lwBUM7+Cbb0p33mPdowks
	oBx8W248hfyPMCAahEQ7idWoD21Li/J8jrzOyl0H60eCNWeMAQ5bEwQ4SuFNCbE=
X-Google-Smtp-Source: AGHT+IHm86lQ/XKEWgDbR9BNv4I78xECawC2+D9o7XdJO0VwnbHno/v8twkniS1siobUXFfYia1naA==
X-Received: by 2002:a05:6e02:138f:b0:3a0:9c04:8047 with SMTP id e9e14a558f8ab-3a35eb0dff5mr24162165ab.6.1727790617933;
        Tue, 01 Oct 2024 06:50:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344de1d80sm31017995ab.70.2024.10.01.06.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:50:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Thyw0OxVMvFRBgsjg5e5YcDM"
Message-ID: <32ef9660-2e25-4a5c-a019-4aa642543106@kernel.dk>
Date: Tue, 1 Oct 2024 07:50:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/sqpoll: do not allow pinning
 outside of cpuset" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, felix.moessbauer@siemens.com
Cc: stable@vger.kernel.org
References: <2024100131-number-deface-36a6@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024100131-number-deface-36a6@gregkh>

This is a multi-part message in MIME format.
--------------Thyw0OxVMvFRBgsjg5e5YcDM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 1:19 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x f011c9cf04c06f16b24f583d313d3c012e589e50
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100131-number-deface-36a6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's one for 5.15-stable AND 5.10-stable, remember that any stable
io_uring backport for 5.15-stable also applies to 5.10-stable as they
use the same codebase.

-- 
Jens Axboe
--------------Thyw0OxVMvFRBgsjg5e5YcDM
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-sqpoll-do-not-allow-pinning-outside-of-cpus.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-sqpoll-do-not-allow-pinning-outside-of-cpus.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwY2U0NGQ4NzFkNTVkYzcwNjdkNmVmODU1NTNiYTUyNTEwYTA0MzM3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpeCBNb2Vzc2JhdWVyIDxmZWxpeC5tb2Vzc2Jh
dWVyQHNpZW1lbnMuY29tPgpEYXRlOiBNb24sIDkgU2VwIDIwMjQgMTc6MDA6MzYgKzAyMDAK
U3ViamVjdDogW1BBVENIXSBpb191cmluZy9zcXBvbGw6IGRvIG5vdCBhbGxvdyBwaW5uaW5n
IG91dHNpZGUgb2YgY3B1c2V0CgpUaGUgc3VibWl0IHF1ZXVlIHBvbGxpbmcgdGhyZWFkcyBh
cmUgdXNlcmxhbmQgdGhyZWFkcyB0aGF0IGp1c3QgbmV2ZXIKZXhpdCB0byB0aGUgdXNlcmxh
bmQuIFdoZW4gY3JlYXRpbmcgdGhlIHRocmVhZCB3aXRoIElPUklOR19TRVRVUF9TUV9BRkYs
CnRoZSBhZmZpbml0eSBvZiB0aGUgcG9sbGVyIHRocmVhZCBpcyBzZXQgdG8gdGhlIGNwdSBz
cGVjaWZpZWQgaW4Kc3FfdGhyZWFkX2NwdS4gSG93ZXZlciwgdGhpcyBDUFUgY2FuIGJlIG91
dHNpZGUgb2YgdGhlIGNwdXNldCBkZWZpbmVkCmJ5IHRoZSBjZ3JvdXAgY3B1c2V0IGNvbnRy
b2xsZXIuIFRoaXMgdmlvbGF0ZXMgdGhlIHJ1bGVzIGRlZmluZWQgYnkgdGhlCmNwdXNldCBj
b250cm9sbGVyIGFuZCBpcyBhIHBvdGVudGlhbCBpc3N1ZSBmb3IgcmVhbHRpbWUgYXBwbGlj
YXRpb25zLgoKSW4gYjdlZDZkOGZmZDYgd2UgZml4ZWQgdGhlIGRlZmF1bHQgYWZmaW5pdHkg
b2YgdGhlIHBvbGxlciB0aHJlYWQsIGluCmNhc2Ugbm8gZXhwbGljaXQgcGlubmluZyBpcyBy
ZXF1aXJlZCBieSBpbmhlcml0aW5nIHRoZSBvbmUgb2YgdGhlCmNyZWF0aW5nIHRhc2suIElu
IGNhc2Ugb2YgZXhwbGljaXQgcGlubmluZywgdGhlIGNoZWNrIGlzIG1vcmUKY29tcGxpY2F0
ZWQsIGFzIGFsc28gYSBjcHUgb3V0c2lkZSBvZiB0aGUgcGFyZW50IGNwdW1hc2sgaXMgYWxs
b3dlZC4KV2UgaW1wbGVtZW50ZWQgdGhpcyBieSB1c2luZyBjcHVzZXRfY3B1c19hbGxvd2Vk
ICh0aGF0IGhhcyBzdXBwb3J0IGZvcgpjZ3JvdXAgY3B1c2V0cykgYW5kIHRlc3RpbmcgaWYg
dGhlIHJlcXVlc3RlZCBjcHUgaXMgaW4gdGhlIHNldC4KCkZpeGVzOiAzN2QxZTJlMzY0MmUg
KCJpb191cmluZzogbW92ZSBTUVBPTEwgdGhyZWFkIGlvLXdxIGZvcmtlZCB3b3JrZXIiKQpD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDYuMSsKU2lnbmVkLW9mZi1ieTogRmVsaXgg
TW9lc3NiYXVlciA8ZmVsaXgubW9lc3NiYXVlckBzaWVtZW5zLmNvbT4KTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDkwOTE1MDAzNi41NTkyMS0xLWZlbGl4Lm1vZXNz
YmF1ZXJAc2llbWVucy5jb20KU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2Vy
bmVsLmRrPgotLS0KIGlvX3VyaW5nL2lvX3VyaW5nLmMgfCA1ICsrKystCiAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW9f
dXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggOGVkMmM2NTUy
OTcxLi42YjZmZDI0NDIzM2YgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysr
IGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpAQCAtNTYsNiArNTYsNyBAQAogI2luY2x1ZGUgPGxp
bnV4L21tLmg+CiAjaW5jbHVkZSA8bGludXgvbW1hbi5oPgogI2luY2x1ZGUgPGxpbnV4L3Bl
cmNwdS5oPgorI2luY2x1ZGUgPGxpbnV4L2NwdXNldC5oPgogI2luY2x1ZGUgPGxpbnV4L3Ns
YWIuaD4KICNpbmNsdWRlIDxsaW51eC9ibGtkZXYuaD4KICNpbmNsdWRlIDxsaW51eC9idmVj
Lmg+CkBAIC04NzQ2LDEwICs4NzQ3LDEyIEBAIHN0YXRpYyBpbnQgaW9fc3Ffb2ZmbG9hZF9j
cmVhdGUoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsCiAJCQlyZXR1cm4gMDsKIAogCQlpZiAo
cC0+ZmxhZ3MgJiBJT1JJTkdfU0VUVVBfU1FfQUZGKSB7CisJCQlzdHJ1Y3QgY3B1bWFzayBh
bGxvd2VkX21hc2s7CiAJCQlpbnQgY3B1ID0gcC0+c3FfdGhyZWFkX2NwdTsKIAogCQkJcmV0
ID0gLUVJTlZBTDsKLQkJCWlmIChjcHUgPj0gbnJfY3B1X2lkcyB8fCAhY3B1X29ubGluZShj
cHUpKQorCQkJY3B1c2V0X2NwdXNfYWxsb3dlZChjdXJyZW50LCAmYWxsb3dlZF9tYXNrKTsK
KwkJCWlmICghY3B1bWFza190ZXN0X2NwdShjcHUsICZhbGxvd2VkX21hc2spKQogCQkJCWdv
dG8gZXJyX3NxcG9sbDsKIAkJCXNxZC0+c3FfY3B1ID0gY3B1OwogCQl9IGVsc2UgewotLSAK
Mi40NS4yCgo=

--------------Thyw0OxVMvFRBgsjg5e5YcDM--

