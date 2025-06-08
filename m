Return-Path: <stable+bounces-151874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF1EAD1146
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 08:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E41B168F63
	for <lists+stable@lfdr.de>; Sun,  8 Jun 2025 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4131DE8BF;
	Sun,  8 Jun 2025 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NoLcLY0p"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AF81EFFB7
	for <stable@vger.kernel.org>; Sun,  8 Jun 2025 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749364071; cv=none; b=WFiJ/P8tVUcufl4iuGZ5/f5yuZwtz4R7cZr9UJv93CZTJo8M4u8efuJ3JLjPzfsprzgBCbAYSyuCou7LmCE6QGZxXp7DZEWUKkD8KEiloUSfL/djggJqonXUw2ewZQA8InSwrdzUH7Zg8ntRVM+FAH0CEk++fmY0Zi08PTKZosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749364071; c=relaxed/simple;
	bh=HeGugFW0r+7vNKqL6GE5xxDD5HfyQigi3lwGo8XHS18=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ZgRcTMU2k5n3+CGICACYya/8aCzMPcbHkA8C2fk9fLEQQ88Ue8qfVHjOaX1eQN3nuFWxPhaT6oah7N6Lgzly84bVZoQ0yNOX4uIXlJzU+MUJDF4NHqIZSffjeEcnZ/X6YdTkmYXLukX4xtb6YO9l7VhDA4v5KhK6Tpeosz9VxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NoLcLY0p; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Content-Type: multipart/mixed; boundary="------------qRkW41hOaaSj7qoTfWig12ZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1749364060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unscTxquZV2mXnMesCVMYxdvPcdiCsokwFVe9Rx3qOA=;
	b=NoLcLY0pskqFsVc7an3nslhUyFQ1UAmqBbEAO2z/Yeqbz2j99X2NBcr/N/xR56cNE3UfBi
	HIEBwjOV3taBUhMjewlwGnBUhm6DBDfyTnytdfC06lDz3P+8x4erhodkOBeblNtBjrq601
	slopO8Xio12a6e47m1dLJ1J1MCGRmT/RHgnwwhR/fD2xpjCX1rw/yy2XA5K0811KDX7rQK
	619E9k6fFFN+nXDVT1n3mK8EoMdBKXYHIcCU9+VT2MItZiz6p9XF3xKSeHWcxWA3qU2f/T
	/STX2ENmrIYhptwG/1LS8nA8rpe4jODXplUfOIPDdEeXcX3OjH/1byKWxYe3rg==
Message-ID: <1faa145a-65eb-4650-a5a1-6e9f9989b73f@manjaro.org>
Date: Sun, 8 Jun 2025 08:27:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Laura Nao <laura.nao@collabora.com>, stable@vger.kernel.org,
 Uday M Bhat <uday.m.bhat@intel.com>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
 <20250320112806.332385-1-laura.nao@collabora.com>
 <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org>
 <2025040121-strongbox-sculptor-15a1@gregkh>
 <722c3acd-6735-4882-a4b1-ed5c75fd4339@manjaro.org>
 <2025060532-cadmium-shaking-833e@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <2025060532-cadmium-shaking-833e@gregkh>
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

This is a multi-part message in MIME format.
--------------qRkW41hOaaSj7qoTfWig12ZG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 10:46, Greg KH wrote:
> I have no context here, sorry...

So basically, starting with GCC 15.1 the kernel series doesn't compile 
again and errors out with: FAILED unresolved symbol filp_close. I tested 
now v5.10.237 as well, which failed similar to v5.10.238.

There are some Debian reports out there:

https://linux.debian.bugs.dist.narkive.com/2JKeaFga/bug-1104662-failed-unresolved-symbol-filp-close-linux-kernel-5-10-237
https://www.mail-archive.com/debian-kernel@lists.debian.org/msg142397.html

And I also found this one:

https://lists-ec2.96boards.org/archives/list/linux-stable-mirror@lists.linaro.org/thread/7XFQI52N3KGUGFLPWCSJZW6DDFZCOXP4/

For GCC 14.1 I had to add the gnu 11 patch, which was discussed already. 
Also 5.4 and 5.15 still compile with the newer toolchain ...

-- 
Best, Philip
--------------qRkW41hOaaSj7qoTfWig12ZG
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-5.10.236-std-gnu11.patch"
Content-Disposition: attachment; filename="linux-5.10.236-std-gnu11.patch"
Content-Transfer-Encoding: base64

Q29tbWl0IGIzYmVlMWU3YzNmMmIxYjc3MTgyMzAyYzdiMjEzMWM4MDQxNzU4NzAgeDg2L2Jv
b3Q6IENvbXBpbGUgYm9vdCBjb2RlIHdpdGggLXN0ZD1nbnUxMSB0b28KZml4ZWQgYSBidWls
ZCBmYWlsdXJlIHdoZW4gY29tcGlsaW5nIHdpdGggR0NDIDE1LiBUaGUgc2FtZSBjaGFuZ2Ug
aXMgcmVxdWlyZWQgZm9yIGxpbnV4LTUuMTAuMjM2LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXMg
Q2xheXRvbiA8Y2hyaXMyNTUzQGdvb2dsZW1haWwuY29tPgpNb2RpZmllZC1ieTogUGhpbGlw
IE11ZWxsZXIgPHBoaWxtQG1hbmphcm8ub3JnPgpMaW5rOiBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0
Lz9pZD1iM2JlZTFlN2MzZjJiMWI3NzE4MjMwMmM3YjIxMzFjODA0MTc1ODcwCgoKZGlmZiAt
cnVwIGxpbnV4LTUuMTAuMjM2Lm9yaWcvYXJjaC94ODYvTWFrZWZpbGUgbGludXgtNS4xMC4y
MzYvYXJjaC94ODYvTWFrZWZpbGUKLS0tIGxpbnV4LTUuMTAuMjM2Lm9yaWcvYXJjaC94ODYv
TWFrZWZpbGUJMjAyNS0wNC0xMCAxMzozNzo0NC4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4
LTUuMTAuMjM2L2FyY2gveDg2L01ha2VmaWxlCTIwMjUtMDQtMjYgMTk6Mzc6MzguMjk0Mzg2
OTY4ICswMTAwCkBAIC0zMSw3ICszMSw3IEBAIGVuZGlmCiBDT0RFMTZHQ0NfQ0ZMQUdTIDo9
IC1tMzIgLVdhLCQoc3JjdHJlZSkvYXJjaC94ODYvYm9vdC9jb2RlMTZnY2MuaAogTTE2X0NG
TEFHUwkgOj0gJChjYWxsIGNjLW9wdGlvbiwgLW0xNiwgJChDT0RFMTZHQ0NfQ0ZMQUdTKSkK
IAotUkVBTE1PREVfQ0ZMQUdTCTo9ICQoTTE2X0NGTEFHUykgLWcgLU9zIC1ERElTQUJMRV9C
UkFOQ0hfUFJPRklMSU5HIC1EX19ESVNBQkxFX0VYUE9SVFMgXAorUkVBTE1PREVfQ0ZMQUdT
CTo9IC1zdGQ9Z251MTEgJChNMTZfQ0ZMQUdTKSAtZyAtT3MgLURESVNBQkxFX0JSQU5DSF9Q
Uk9GSUxJTkcgLURfX0RJU0FCTEVfRVhQT1JUUyBcCiAJCSAgIC1XYWxsIC1Xc3RyaWN0LXBy
b3RvdHlwZXMgLW1hcmNoPWkzODYgLW1yZWdwYXJtPTMgXAogCQkgICAtZm5vLXN0cmljdC1h
bGlhc2luZyAtZm9taXQtZnJhbWUtcG9pbnRlciAtZm5vLXBpYyBcCiAJCSAgIC1tbm8tbW14
IC1tbm8tc3NlICQoY2FsbCBjYy1vcHRpb24sLWZjZi1wcm90ZWN0aW9uPW5vbmUpCg==

--------------qRkW41hOaaSj7qoTfWig12ZG--

