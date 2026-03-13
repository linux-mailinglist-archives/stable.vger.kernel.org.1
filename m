Return-Path: <stable+bounces-225393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCsbFPaItGmBpQAAu9opvQ
	(envelope-from <stable+bounces-225393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:00:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D6028A3DB
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5ADBA3009386
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B817C203;
	Fri, 13 Mar 2026 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UNaJcBEC"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64882DF144
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439215; cv=none; b=iiamb/XIx0NQYg1yuAhPxbjEG3t6kUxAUtG5fOvlAbRyR0PwBcAELvypgK/31tK3gKyKaPgN1lcOAqsH9ARiwWmfBBO38W0J/vbSSqyin9BJASZAU/9U0MY/1HBT+U+ZRRixuyHJiFj2A8bqvXpaFmJrkYr1cUy1oOsMuFayqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439215; c=relaxed/simple;
	bh=Fki1s4fDGJxiopO/CaHv57jB0+hIbsaAgC8qx91k32Y=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=nNxDf4Ukdryc0GtcenU9aay0agqBvaUroqFheKFzWa5fqPuiNO1cV0tx//KzbWogdqTXw+nkPbY5qnaODlvorbK3bRz0lO2kZv/QhjGMBhrpVOn4vfh6Pe+3ls15mfQA5KyhSpPNOhXhEmopqO0D0sdiNzy0Wkpj0HqbsCji2kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UNaJcBEC; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-466f59dbe4bso704958b6e.0
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773439211; x=1774044011; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w1UGoUPo400nGRFZuvt8bWH6eYMWt2jJB5rsGhtsNpw=;
        b=UNaJcBEC8ygHjibsFAHjpySd+ul2QyqLnVpjn/UnM98wH8OoDx83cs+RxVRLc3GXsy
         YirEOHMnyJivg6sqwygwcfhYNAlBlO7VxMPHg8zMn+6MUU22xCi3qS6ywc+DCAhxdLIF
         rf0uN8pBNG62MHxN8inC2fS7+nzV0QbrDqVfz8IutMvwQDP8BIq83XCiJedMToEJZuqG
         TEkOnbFoYeQpthNgZU6zV5Y+4YDJbBc1JXyzoCr+FvPijMw7PABDycFxdfHrXiTVvuAW
         VTfBhrCtqo90ABFosp7zSF6oEt1jY/6EbMEIRXXMIJ47Aa5ugw/PICbPYhYerq8B4KNu
         HEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773439211; x=1774044011;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1UGoUPo400nGRFZuvt8bWH6eYMWt2jJB5rsGhtsNpw=;
        b=VXqZtoWtuYm+ZUj1b7ho2/Uq2ezMEyXKuNjqIfCNJ2zvWWURVNzTDTaXpeVeuY47ZU
         X4R/V1XRY0MUTf0MxrrBGYC9uyOrIg9hLTCQw6o1RGnfKAOfN+6xU5nuCm0KtnoYKbNy
         sXDXXY8dSzZYYcQWsCTr42VJZFiaCadhtpRbg85pEeXCYtyFSPuBStQA8De5MApF9IFq
         3Eh3TL48rCWL4vRmeJMLLfOdv42dfkssVOfBdq7y14kZ79NndyaRuCsCT2ODrqBazv8K
         XUyvf8q014RYh8JGE0RgA+5Sm8ENAofNNbQtdR2kw5/j3iB6+Gi0CvvOfeBTNjxh+WaI
         zr0g==
X-Gm-Message-State: AOJu0Yz0oAVTEQsqSG5WQHz2BnodiyhGO36poFX2U5xr0RGbXmUKvIe3
	wILCmpMCQekKPuCM1mFHP0W7SgN1BXCKIOL9aqbkctzn5zunkrMLkxGPxqBqnmd97Zbvm+Wi/s7
	on9VGenk=
X-Gm-Gg: ATEYQzzcS0SKYzvfUrLD5Ksosc47j9WrEt+5b/pS59+QTnyUeXBVoKt8BCo9Z5Klcj3
	iC+R331epfmtykmENUWsqo7qi0XQ3QD5doqwaogREQhD0xe9kNVAaNQ5OC14jLKWresdWatnBs/
	0viKn+bQGK1RQt2NUJf2We4zJp1H/KbwObxRvTuMelVVRwQw2EfthCLc/menYE8kNjuGuCs9Mzv
	2PAZkucoyQl3uKTAOwXrBrV5MIQacvhWM2i5O6PouFeZMG8dUcNg/uouS0ooSSDLPHUrWpUXjKV
	eIDWBhCJky4DBtIm/LrCOeoyXQ0RmO/oKipA8S0e+YjxcvmT2kaZxy9wPfDUhUFHjJ6lcRp1WUC
	vgVAuHMRM/XGBJsPgzVBBsztBvS/d21hXxk75IU5L1fjtYgXV2nDq7c4/yCdXfutskMzlqSzmIy
	dOlREZAaDvNxqxakLv24iGqmq9tUc0AdDtJgnN8repLyFQ1og6dzCFlGLLn6rY1EESyaG3sKHDF
	RMF0qbHacZYqqb+bNA=
X-Received: by 2002:a05:6808:f89:b0:460:f435:2aa1 with SMTP id 5614622812f47-467575df561mr2626101b6e.46.1773439211275;
        Fri, 13 Mar 2026 15:00:11 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e26e2c6sm9724322fac.7.2026.03.13.15.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 15:00:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------0EAb55IrM3gYynnY9ZxQZpW3"
Message-ID: <0379aa3c-0bba-4836-b633-0bc8bc8ae4c7@kernel.dk>
Date: Fri, 13 Mar 2026 16:00:09 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: 5.10 / 5.15 stable inclusion request
X-Spamd-Result: default: False [-0.56 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-225393-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,kernel.dk:email,kernel.dk:mid]
X-Rspamd-Queue-Id: 41D6028A3DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------0EAb55IrM3gYynnY9ZxQZpW3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Looks like the backport of:

Fixes: 84230ad2d2af ("io_uring/poll: correctly handle io_poll_add() return value on update")

to 5.10-stable and 5.15-stable were missed, probably by me. In any case,
here's a backport, please add to the 5.10/5.15 stable queues. No rush,
just for whatever is the next release.

-- 
Jens Axboe


--------------0EAb55IrM3gYynnY9ZxQZpW3
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-correctly-handle-io_poll_add-return-va.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-correctly-handle-io_poll_add-return-va.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzNzE1MjZhODVhOWIyNDk3MDAzNmIxMDM2NWQ1YjBhOWM2MDIxZmI5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IEZyaSwgMTMgTWFyIDIwMjYgMTU6NTA6MjEgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9wb2xsOiBjb3JyZWN0bHkgaGFuZGxlIGlvX3BvbGxfYWRkKCkgcmV0dXJuIHZh
bHVlIG9uCiB1cGRhdGUKCkNvbW1pdCA4NDIzMGFkMmQyYWZiZjBjNDRjMzI5NjdlNTI1YzBh
ZDkyZTI2YjRlIHVwc3RyZWFtLgoKV2hlbiB0aGUgY29yZSBvZiBpb191cmluZyB3YXMgdXBk
YXRlZCB0byBoYW5kbGUgY29tcGxldGlvbnMKY29uc2lzdGVudGx5IGFuZCB3aXRoIGZpeGVk
IHJldHVybiBjb2RlcywgdGhlIFBPTExfUkVNT1ZFIG9wY29kZQp3aXRoIHVwZGF0ZXMgZ290
IHNsaWdodGx5IGJyb2tlbi4gSWYgYSBQT0xMX0FERCBpcyBwZW5kaW5nIGFuZAp0aGVuIFBP
TExfUkVNT1ZFIGlzIHVzZWQgdG8gdXBkYXRlIHRoZSBldmVudHMgb2YgdGhhdCByZXF1ZXN0
LCBpZiB0aGF0CnVwZGF0ZSBjYXVzZXMgdGhlIFBPTExfQUREIHRvIG5vdyB0cmlnZ2VyLCB0
aGVuIHRoYXQgY29tcGxldGlvbiBpcyBsb3N0CmFuZCBhIENRRSBpcyBuZXZlciBwb3N0ZWQu
CgpBZGRpdGlvbmFsbHksIGVuc3VyZSB0aGF0IGlmIGFuIHVwZGF0ZSBkb2VzIGNhdXNlIGFu
IGV4aXN0aW5nIFBPTExfQURECnRvIGNvbXBsZXRlLCB0aGF0IHRoZSBjb21wbGV0aW9uIHZh
bHVlIGlzbid0IGFsd2F5cyBvdmVyd3JpdHRlbiB3aXRoCi1FQ0FOQ0VMRUQuIEZvciB0aGF0
IGNhc2UsIHdoYXRldmVyIGlvX3BvbGxfYWRkKCkgc2V0IHRoZSB2YWx1ZSB0bwpzaG91bGQg
anVzdCBiZSByZXRhaW5lZC4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiA5
N2IzODhkNzBiNTMgKCJpb191cmluZzogaGFuZGxlIGNvbXBsZXRpb25zIGluIHRoZSBjb3Jl
IikKUmVwb3J0ZWQtYnk6IHN5emJvdCs2NDFlZWM2YjdhZjFmNjJmMmI5OUBzeXprYWxsZXIu
YXBwc3BvdG1haWwuY29tClRlc3RlZC1ieTogc3l6Ym90KzY0MWVlYzZiN2FmMWY2MmYyYjk5
QHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8
YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5nL2lvX3VyaW5nLmMgfCAyNiArKysrKysr
KysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lv
X3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggZTU4ODllYzAyNzNmLi5lZTRjYjg3NDJiZTYgMTAw
NjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcu
YwpAQCAtNjEyNyw3ICs2MTI3LDcgQEAgc3RhdGljIGludCBpb19wb2xsX2FkZF9wcmVwKHN0
cnVjdCBpb19raW9jYiAqcmVxLCBjb25zdCBzdHJ1Y3QgaW9fdXJpbmdfc3FlICpzcWUKIAly
ZXR1cm4gMDsKIH0KIAotc3RhdGljIGludCBpb19wb2xsX2FkZChzdHJ1Y3QgaW9fa2lvY2Ig
KnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQorc3RhdGljIGludCBfX2lvX3BvbGxf
YWRkKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCiB7
CiAJc3RydWN0IGlvX3BvbGxfaW9jYiAqcG9sbCA9ICZyZXEtPnBvbGw7CiAJc3RydWN0IGlv
X3BvbGxfdGFibGUgaXB0OwpAQCAtNjEzOSwxMSArNjEzOSwyMSBAQCBzdGF0aWMgaW50IGlv
X3BvbGxfYWRkKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxh
Z3MpCiAJaWYgKCFyZXQgJiYgaXB0LmVycm9yKQogCQlyZXFfc2V0X2ZhaWwocmVxKTsKIAly
ZXQgPSByZXQgPzogaXB0LmVycm9yOwotCWlmIChyZXQpCisJaWYgKHJldCA+IDApIHsKIAkJ
X19pb19yZXFfY29tcGxldGUocmVxLCBpc3N1ZV9mbGFncywgcmV0LCAwKTsKKwkJcmV0dXJu
IHJldDsKKwl9CiAJcmV0dXJuIDA7CiB9CiAKK3N0YXRpYyBpbnQgaW9fcG9sbF9hZGQoc3Ry
dWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKK3sKKwlpbnQg
cmV0OworCisJcmV0ID0gX19pb19wb2xsX2FkZChyZXEsIGlzc3VlX2ZsYWdzKTsKKwlyZXR1
cm4gcmV0IDwgMCA/IHJldCA6IDA7Cit9CisKIHN0YXRpYyBpbnQgaW9fcG9sbF91cGRhdGUo
c3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIHsKIAlz
dHJ1Y3QgaW9fcmluZ19jdHggKmN0eCA9IHJlcS0+Y3R4OwpAQCAtNjE1OSw2ICs2MTY5LDcg
QEAgc3RhdGljIGludCBpb19wb2xsX3VwZGF0ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5z
aWduZWQgaW50IGlzc3VlX2ZsYWdzKQogCQlyZXQgPSBwcmVxID8gLUVBTFJFQURZIDogLUVO
T0VOVDsKIAkJZ290byBvdXQ7CiAJfQorCXByZXEtPnJlc3VsdCA9IC1FQ0FOQ0VMRUQ7CiAJ
c3Bpbl91bmxvY2soJmN0eC0+Y29tcGxldGlvbl9sb2NrKTsKIAogCWlmIChyZXEtPnBvbGxf
dXBkYXRlLnVwZGF0ZV9ldmVudHMgfHwgcmVxLT5wb2xsX3VwZGF0ZS51cGRhdGVfdXNlcl9k
YXRhKSB7CkBAIC02MTcxLDE2ICs2MTgyLDE3IEBAIHN0YXRpYyBpbnQgaW9fcG9sbF91cGRh
dGUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAkJ
aWYgKHJlcS0+cG9sbF91cGRhdGUudXBkYXRlX3VzZXJfZGF0YSkKIAkJCXByZXEtPnVzZXJf
ZGF0YSA9IHJlcS0+cG9sbF91cGRhdGUubmV3X3VzZXJfZGF0YTsKIAotCQlyZXQyID0gaW9f
cG9sbF9hZGQocHJlcSwgaXNzdWVfZmxhZ3MpOworCQlyZXQyID0gX19pb19wb2xsX2FkZChw
cmVxLCBpc3N1ZV9mbGFncyk7CiAJCS8qIHN1Y2Nlc3NmdWxseSB1cGRhdGVkLCBkb24ndCBj
b21wbGV0ZSBwb2xsIHJlcXVlc3QgKi8KIAkJaWYgKCFyZXQyKQogCQkJZ290byBvdXQ7CisJ
CXByZXEtPnJlc3VsdCA9IHJldDI7CisKIAl9Ci0JcmVxX3NldF9mYWlsKHByZXEpOwotCWlv
X3JlcV9jb21wbGV0ZShwcmVxLCAtRUNBTkNFTEVEKTsKKwlpZiAocHJlcS0+cmVzdWx0IDwg
MCkKKwkJcmVxX3NldF9mYWlsKHByZXEpOworCWlvX3JlcV9jb21wbGV0ZShwcmVxLCBwcmVx
LT5yZXN1bHQpOwogb3V0OgotCWlmIChyZXQgPCAwKQotCQlyZXFfc2V0X2ZhaWwocmVxKTsK
IAkvKiBjb21wbGV0ZSB1cGRhdGUgcmVxdWVzdCwgd2UncmUgZG9uZSB3aXRoIGl0ICovCiAJ
aW9fcmVxX2NvbXBsZXRlKHJlcSwgcmV0KTsKIAlpb19yaW5nX3N1Ym1pdF91bmxvY2soY3R4
LCAhKGlzc3VlX2ZsYWdzICYgSU9fVVJJTkdfRl9OT05CTE9DSykpOwotLSAKMi41My4wCgo=


--------------0EAb55IrM3gYynnY9ZxQZpW3--

