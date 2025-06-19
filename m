Return-Path: <stable+bounces-154749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0F0AE0027
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260EA7A6CEA
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 08:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36137264A61;
	Thu, 19 Jun 2025 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="fp8r3iJI"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339EC241684
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750322661; cv=none; b=PL3yAoP0JhEMah0mcyN9paC3iBu6EG1HEzRdUtbYd4DgndOQBdkrQchrBZD2Rl0rxas1+qDuz9+NN/mfgV808dAsKImzSApkiJCyBYuw4z6lfLbUPhRlTJcVDSOboB232LoLmqpIwg8eQiGku9BoeBSn76SgcdS1gZ3P0bz19Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750322661; c=relaxed/simple;
	bh=xrjPkWlmRjHVm4Ph0nbuO82mfWYe4h0jD5lODzmTPrA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=EmhL4tIZf/U1t5k0f1rp6+HSYkKGo8Md2qhwKJ7L51vzzSMeCZKPfraWdf1sBEvGQzC3Km34jl4oiCtTLOvAnQFyn2Nk0Nna32BMQ6EEDAENKi++T4C/7lUfbJe5yAxTcrzxfz4hpssf8ttxE6aeSqq9mzZroUrW2TZjwX5AAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=fp8r3iJI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Content-Type: multipart/mixed; boundary="------------MOWanaC4Y9AVXLCa1hXdoq6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1750322094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0iU19t271qLXOs4UrAtmlB2T2/Dxyk3qYFSNoTEbsM=;
	b=fp8r3iJII+K0bn+egids6TwscBGL/QXeTsTHW0P+dNN67kE3y+0cMEITQrGOJbVAqVKCm6
	vISUfxWDj87NuxJIjzQpPy2kNgUDvYmeQH79rrN/pDT1am0LvdfxQXMk8cpk5XTO8VFSCJ
	+k7EXtGf3k1mzo6Glk0TAcN1jQa/ZAC3kbEjKvjZmedqK3G1OoVtHloeOXiKJsYlh3q0ku
	S2VMCtHUxOp5YGNheNLM5zbxR6nzhC8tOr5YKvGknh9FI20/kxdqp6FgQBv+MaA1fPx2lA
	oij8VfpytH1YcnMCCQ+ED03rGri8VERsidZsA3bgpoLG1ModHIz+GvyJs9KBIA==
Message-ID: <4c1dcc23-fcbb-4777-8e76-a1da74ac9790@manjaro.org>
Date: Thu, 19 Jun 2025 10:34:52 +0200
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
 <1faa145a-65eb-4650-a5a1-6e9f9989b73f@manjaro.org>
 <2025061742-underhand-defeat-eb33@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <2025061742-underhand-defeat-eb33@gregkh>
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

This is a multi-part message in MIME format.
--------------MOWanaC4Y9AVXLCa1hXdoq6k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/25 16:05, Greg KH wrote:
> Also for the newer kernels, this was only backported to 6.6.y, so
> anything older than that should need this, right?

Well, yes. The patches I applied on my end are attached.

-- 
Best, Philip
--------------MOWanaC4Y9AVXLCa1hXdoq6k
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-5.4.292-std-gnu11.patch"
Content-Disposition: attachment; filename="linux-5.4.292-std-gnu11.patch"
Content-Transfer-Encoding: base64

Q29tbWl0IGIzYmVlMWU3YzNmMmIxYjc3MTgyMzAyYzdiMjEzMWM4MDQxNzU4NzAgeDg2L2Jv
b3Q6IENvbXBpbGUgYm9vdCBjb2RlIHdpdGggLXN0ZD1nbnUxMSB0b28KZml4ZWQgYSBidWls
ZCBmYWlsdXJlIHdoZW4gY29tcGlsaW5nIHdpdGggR0NDIDE1LiBUaGUgc2FtZSBjaGFuZ2Ug
aXMgcmVxdWlyZWQgZm9yIGxpbnV4LTUuNC4yOTIuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpcyBD
bGF5dG9uIDxjaHJpczI1NTNAZ29vZ2xlbWFpbC5jb20+Ck1vZGlmaWVkLWJ5OiBQaGlsaXAg
TXVlbGxlciA8cGhpbG1AbWFuamFyby5vcmc+Ckxpbms6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQv
P2lkPWIzYmVlMWU3YzNmMmIxYjc3MTgyMzAyYzdiMjEzMWM4MDQxNzU4NzAKCgpkaWZmIC1y
dXAgbGludXgtNS40LjI5Mi5vcmlnL2FyY2gveDg2L01ha2VmaWxlIGxpbnV4LTUuNC4yOTIv
YXJjaC94ODYvTWFrZWZpbGUKLS0tIGxpbnV4LTUuNC4yOTIub3JpZy9hcmNoL3g4Ni9NYWtl
ZmlsZQkyMDI1LTA0LTEwIDEzOjM3OjQ0LjAwMDAwMDAwMCArMDEwMAorKysgbGludXgtNS40
LjI5Mi9hcmNoL3g4Ni9NYWtlZmlsZQkyMDI1LTA0LTI2IDE5OjM3OjM4LjI5NDM4Njk2OCAr
MDEwMApAQCAtMzEsNyArMzEsNyBAQCBlbmRpZgogQ09ERTE2R0NDX0NGTEFHUyA6PSAtbTMy
IC1XYSwkKHNyY3RyZWUpL2FyY2gveDg2L2Jvb3QvY29kZTE2Z2NjLmgKIE0xNl9DRkxBR1MJ
IDo9ICQoY2FsbCBjYy1vcHRpb24sIC1tMTYsICQoQ09ERTE2R0NDX0NGTEFHUykpCiAKLVJF
QUxNT0RFX0NGTEFHUwk6PSAkKE0xNl9DRkxBR1MpIC1nIC1PcyAtRERJU0FCTEVfQlJBTkNI
X1BST0ZJTElORyBcCitSRUFMTU9ERV9DRkxBR1MJOj0gLXN0ZD1nbnUxMSAkKE0xNl9DRkxB
R1MpIC1nIC1PcyAtRERJU0FCTEVfQlJBTkNIX1BST0ZJTElORyAtRF9fRElTQUJMRV9FWFBP
UlRTIFwKIAkJICAgLVdhbGwgLVdzdHJpY3QtcHJvdG90eXBlcyAtbWFyY2g9aTM4NiAtbXJl
Z3Bhcm09MyBcCiAJCSAgIC1mbm8tc3RyaWN0LWFsaWFzaW5nIC1mb21pdC1mcmFtZS1wb2lu
dGVyIC1mbm8tcGljIFwKIAkJICAgLW1uby1tbXggLW1uby1zc2UgJChjYWxsIGNjLW9wdGlv
biwtZmNmLXByb3RlY3Rpb249bm9uZSkKLS0tIGxpbnV4LTUuNC4yOTIub3JpZy9kcml2ZXJz
L2Zpcm13YXJlL2VmaS9saWJzdHViL01ha2VmaWxlCTIwMjUtMDUtMDEgMDk6MzE6MDkuNzU1
MDU5MTI4ICswMjAwCisrKyBsaW51eC01LjQuMjkyL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xp
YnN0dWIvTWFrZWZpbGUJMjAyNS0wNS0wMSAxNjo0ODoyMi4wMjkyNDk5MTcgKzAyMDAKQEAg
LTcsNyArNyw3IEBACiAjCiBjZmxhZ3MtJChDT05GSUdfWDg2XzMyKQkJOj0gLW1hcmNoPWkz
ODYKIGNmbGFncy0kKENPTkZJR19YODZfNjQpCQk6PSAtbWNtb2RlbD1zbWFsbAotY2ZsYWdz
LSQoQ09ORklHX1g4NikJCSs9IC1tJChCSVRTKSAtRF9fS0VSTkVMX18gLU8yIFwKK2NmbGFn
cy0kKENPTkZJR19YODYpCQkrPSAtc3RkPWdudTExIC1tJChCSVRTKSAtRF9fS0VSTkVMX18g
LU8yIFwKIAkJCQkgICAtZlBJQyAtZm5vLXN0cmljdC1hbGlhc2luZyAtbW5vLXJlZC16b25l
IFwKIAkJCQkgICAtbW5vLW1teCAtbW5vLXNzZSAtZnNob3J0LXdjaGFyIFwKIAkJCQkgICAt
V25vLXBvaW50ZXItc2lnbiBcCi0tLSBsaW51eC01LjQuMjkyLm9yaWcvYXJjaC94ODYvYm9v
dC9jb21wcmVzc2VkL01ha2VmaWxlCTIwMjUtMDUtMDEgMDk6MzE6MDkuNzU1MDU5MTI4ICsw
MjAwCisrKyBsaW51eC01LjQuMjkyL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9NYWtlZmls
ZQkyMDI1LTA1LTAxIDE2OjQ4OjIyLjAyOTI0OTkxNyArMDIwMApAQCAtMzIsNiArMzIsNyBA
QCBLQlVJTERfQ0ZMQUdTICs9IC1ERElTQUJMRV9CUkFOQ0hfUFJPRklMCiBjZmxhZ3MtJChD
T05GSUdfWDg2XzMyKSA6PSAtbWFyY2g9aTM4NgogY2ZsYWdzLSQoQ09ORklHX1g4Nl82NCkg
Oj0gLW1jbW9kZWw9c21hbGwKIEtCVUlMRF9DRkxBR1MgKz0gJChjZmxhZ3MteSkKK0tCVUlM
RF9DRkxBR1MgKz0gLXN0ZD1nbnUxMQogS0JVSUxEX0NGTEFHUyArPSAtbW5vLW1teCAtbW5v
LXNzZQogS0JVSUxEX0NGTEFHUyArPSAkKGNhbGwgY2Mtb3B0aW9uLC1mZnJlZXN0YW5kaW5n
KQogS0JVSUxEX0NGTEFHUyArPSAkKGNhbGwgY2Mtb3B0aW9uLC1mbm8tc3RhY2stcHJvdGVj
dG9yKQo=
--------------MOWanaC4Y9AVXLCa1hXdoq6k
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
--------------MOWanaC4Y9AVXLCa1hXdoq6k
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-5.15.180-std-gnu11.patch"
Content-Disposition: attachment; filename="linux-5.15.180-std-gnu11.patch"
Content-Transfer-Encoding: base64

Q29tbWl0IGIzYmVlMWU3YzNmMmIxYjc3MTgyMzAyYzdiMjEzMWM4MDQxNzU4NzAgeDg2L2Jv
b3Q6IENvbXBpbGUgYm9vdCBjb2RlIHdpdGggLXN0ZD1nbnUxMSB0b28KZml4ZWQgYSBidWls
ZCBmYWlsdXJlIHdoZW4gY29tcGlsaW5nIHdpdGggR0NDIDE1LiBUaGUgc2FtZSBjaGFuZ2Ug
aXMgcmVxdWlyZWQgZm9yIGxpbnV4LTUuMTUuMTgwLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXMg
Q2xheXRvbiA8Y2hyaXMyNTUzQGdvb2dsZW1haWwuY29tPgpMaW5rOiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQv
Y29tbWl0Lz9pZD1iM2JlZTFlN2MzZjJiMWI3NzE4MjMwMmM3YjIxMzFjODA0MTc1ODcwCgoK
ZGlmZiAtcnVwIGxpbnV4LTUuMTUuMTgwLm9yaWcvYXJjaC94ODYvTWFrZWZpbGUgbGludXgt
NS4xNS4xODAvYXJjaC94ODYvTWFrZWZpbGUKLS0tIGxpbnV4LTUuMTUuMTgwLm9yaWcvYXJj
aC94ODYvTWFrZWZpbGUJMjAyNS0wNC0xMCAxMzozNzo0NC4wMDAwMDAwMDAgKzAxMDAKKysr
IGxpbnV4LTUuMTUuMTgwL2FyY2gveDg2L01ha2VmaWxlCTIwMjUtMDQtMjYgMTk6Mzc6Mzgu
Mjk0Mzg2OTY4ICswMTAwCkBAIC00Myw3ICs0Myw3IEBAIGVuZGlmCiAKICMgSG93IHRvIGNv
bXBpbGUgdGhlIDE2LWJpdCBjb2RlLiAgTm90ZSB3ZSBhbHdheXMgY29tcGlsZSBmb3IgLW1h
cmNoPWkzODY7CiAjIHRoYXQgd2F5IHdlIGNhbiBjb21wbGFpbiB0byB0aGUgdXNlciBpZiB0
aGUgQ1BVIGlzIGluc3VmZmljaWVudC4KLVJFQUxNT0RFX0NGTEFHUwk6PSAtbTE2IC1nIC1P
cyAtRERJU0FCTEVfQlJBTkNIX1BST0ZJTElORyAtRF9fRElTQUJMRV9FWFBPUlRTIFwKK1JF
QUxNT0RFX0NGTEFHUwk6PSAtc3RkPWdudTExIC1tMTYgLWcgLU9zIC1ERElTQUJMRV9CUkFO
Q0hfUFJPRklMSU5HIC1EX19ESVNBQkxFX0VYUE9SVFMgXAogCQkgICAtV2FsbCAtV3N0cmlj
dC1wcm90b3R5cGVzIC1tYXJjaD1pMzg2IC1tcmVncGFybT0zIFwKIAkJICAgLWZuby1zdHJp
Y3QtYWxpYXNpbmcgLWZvbWl0LWZyYW1lLXBvaW50ZXIgLWZuby1waWMgXAogCQkgICAtbW5v
LW1teCAtbW5vLXNzZSAkKGNhbGwgY2Mtb3B0aW9uLC1mY2YtcHJvdGVjdGlvbj1ub25lKQo=


--------------MOWanaC4Y9AVXLCa1hXdoq6k--

