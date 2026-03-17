Return-Path: <stable+bounces-225992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFSaMuRQuWmuAQIAu9opvQ
	(envelope-from <stable+bounces-225992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:02:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899D2AA5D1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47817304FA52
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB08217648;
	Tue, 17 Mar 2026 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wFs4VYEc"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA821018A
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752538; cv=none; b=bvpjA4fW1oXvZc37I29j+wOoyY6ZFpPoSNRIAc9/gnKthUlXXUfjbtVy5QfQo7uXc7dThIbxiZZ7MId+5Ap5ue0J3VT3UqgECzlxz+OWZuT5hyljnPU2W82lZlpY7sGRk6b6JPv+4ngozClyhH6LteWyNSJ4eS+95Uz5qZDRzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752538; c=relaxed/simple;
	bh=FIv9LAX3UlpYWK89wT52ryfmOjHkOL9RrsF8r6Iu2m0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=D3Tw2HQ4Ux4tX/JS/p6VEeEBWPjGrVVlYqwah0XldUF261ofpyysAlkps5z1cML/VrBiDFOZNWB58SpnUEHF7gOxAj/bDmxkKhdfOQa3l9OMf+zLOQN6fjkkHo7RTS099DeEy10FdmfBTvsAGV7KRQ8Oq4LC8DUq7hXM3w3fPxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wFs4VYEc; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so3354476fac.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 06:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773752535; x=1774357335; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68+qKrlvT5Pypsj67S9lk8XydQk852UrNtvDDJWIhLY=;
        b=wFs4VYEcsnms913jDAhRObTx8TW5S5WkajFG3YPZ9uVEGPcYAChGx23PSbgCMuUx54
         QF7vgRMaCF1Y31Jih4TJI5TuVDl3CU6z5Cm0f/ktDmxrMt6JioYdpMpsghDTsObVk29X
         PNRT75tu5wmfdvk4i8dygjXrJhF4ne2p2PZB0zEvjcasumBNYZXQLa0CMDOM6XZgUvpN
         t0D9CZi67rDuYv5QP9M8ssQ3zJL4YBHSSCCYU8SfuLpoz4tCM+w9qVmKZkbg6wpZDncN
         rlzox/diiU2KZET2SO/MDrNAk/SO21LjYUah/+5+XZ/LzfvDkzZbffHFY0EOJ70IKLLv
         Db0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752535; x=1774357335;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68+qKrlvT5Pypsj67S9lk8XydQk852UrNtvDDJWIhLY=;
        b=kPxEPtcqAZfiP2adZGWI1ImsT9AJLreGtOGqo1XZzwVIUGLaof+ljsQDVFIe37vdHl
         uBZ+w33ZZGEdgJwQ5QDCNXFA8pLaPFkMwi+xTyGBiFuQim+UQQxhwJQMqyhDO5hlIY0B
         QZsP4by+CyMsztAOPGlau91KVbkwkmPqxXfu2RaZxmWNIad6OeLw9X4X4vVjrZymU9pU
         N1Jl8TqOM1j8t9nPvoiCCuODcVaKwhBc2vQ4AeesCoiuiy9uZ+C6UEtyq5QsfX8Idz5L
         NtPichVPklbbBS1hgbrZWeyf8GUDInv9pOoMG6BraKWNW9kHI4vyGhIosH6mV5EnyIH2
         zmDw==
X-Gm-Message-State: AOJu0Yw+aqWDazhRzSdj1e6+y7chYRxdgjUo5xib11X9muSOC+1OgCNB
	Za46bUTc8YoYai5bomaMvufJKPgJugXQU8JupH65djYeujVgXpzQDHes6tBqRwTZfm8=
X-Gm-Gg: ATEYQzyrAkR/prrVd5adM0+mI6g4voC2KHbFOr+VdB/YfZEp/+sLPHBHsZX0LpqiDS4
	2jfKgz+xxZupEj4iQgOXIkxqoDlSAVekP9h+RDpkipiFbVDVtjglvE7RJZiLiNcP5v/Kxx/VnSG
	G4U4lvpbGesmoVjTXotc/x+FSg1JV3w2np8YPL4CaO403s/rQVmF8HFkw5LMa4DvpZQXJLRmBek
	tga/4S2VG1HMiM+tAZtRo3dmFgjJ6HUawAaQ5YsTqoUnphRzUNYf3pWqHGgyFGMKmoJR1Eif+yV
	f0N7yxxnEpZ/6WMByHVhbvk3dj/+0mBs0dRwhWiNEnTeiKY3KrXdBW2p2NfVz9AnMa1UMb10x5m
	qcGxmrFnYOT0MHINRRcWSBC2W5KsqbW43hgZz5HW6GYeBCmiuLW6//R63PVZcgi2Z2Ln922GGee
	Vz/JiB2dPFh3L3lZqUYUW4DGaIwY9Qaf3OpdmZKeMk6MM+5DI/RI+PlybtCbUdfDP4SaGzqH/aY
	MgqIJvq9Q==
X-Received: by 2002:a05:6871:520b:b0:417:59ab:d73b with SMTP id 586e51a60fabf-417b9404199mr10133171fac.43.1773752535045;
        Tue, 17 Mar 2026 06:02:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6c7885sm18177043fac.17.2026.03.17.06.02.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 06:02:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------UATGLzEuYMezMnnyajdYHMqX"
Message-ID: <65795284-4721-470a-92ea-1c68d5e75f86@kernel.dk>
Date: Tue, 17 Mar 2026 07:02:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: ensure ctx->rings is stable for
 task work flags" failed to apply to 6.19-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com, naup96721@gmail.com
Cc: stable@vger.kernel.org
References: <2026031717-scowling-sandfish-e480@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026031717-scowling-sandfish-e480@gregkh>
X-Spamd-Result: default: False [0.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225992-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:email,kernel.dk:mid]
X-Rspamd-Queue-Id: 1899D2AA5D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------UATGLzEuYMezMnnyajdYHMqX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's this one and the following one too, for 6.19.

-- 
Jens Axboe

--------------UATGLzEuYMezMnnyajdYHMqX
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-eventfd-use-ctx-rings_rcu-for-flags-checkin.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-eventfd-use-ctx-rings_rcu-for-flags-checkin.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3MDcxMGMyMjBiNThlODRlMDhiOTI0ODMzZDRjYWViMWQxNTAwODU5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgOSBNYXIgMjAyNiAxNDozNTo0OSAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMi8y
XSBpb191cmluZy9ldmVudGZkOiB1c2UgY3R4LT5yaW5nc19yY3UgZm9yIGZsYWdzIGNoZWNr
aW5nCgpDb21taXQgMTc3YzY5NDMyMTYxZjZlNGJhYjA3Y2NhY2Y4YTE3NDhhNjg5OGE2YiB1
cHN0cmVhbS4KClNpbWlsYXJseSB0byB3aGF0IGNvbW1pdCBlNzhmN2I3MGU4MzcgZGlkIGZv
ciBsb2NhbCB0YXNrIHdvcmsgYWRkaXRpb25zLAp1c2UgLT5yaW5nc19yY3UgdW5kZXIgUkNV
IHJhdGhlciB0aGFuIGRlcmVmZXJlbmNlIC0+cmluZ3MgZGlyZWN0bHkuIFNlZQp0aGF0IGNv
bW1pdCBmb3IgbW9yZSBkZXRhaWxzLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4
ZXM6IDc5Y2ZlOWU1OWMyYSAoImlvX3VyaW5nL3JlZ2lzdGVyOiBhZGQgSU9SSU5HX1JFR0lT
VEVSX1JFU0laRV9SSU5HUyIpClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtl
cm5lbC5kaz4KLS0tCiBpb191cmluZy9ldmVudGZkLmMgfCAxMCArKysrKysrLS0tCiAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2lvX3VyaW5nL2V2ZW50ZmQuYyBiL2lvX3VyaW5nL2V2ZW50ZmQuYwppbmRleCA3OGY4
YWI3ZGIxMDQuLmFiNzg5ZTFlYmU5MSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvZXZlbnRmZC5j
CisrKyBiL2lvX3VyaW5nL2V2ZW50ZmQuYwpAQCAtNzYsMTEgKzc2LDE1IEBAIHZvaWQgaW9f
ZXZlbnRmZF9zaWduYWwoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIGJvb2wgY3FlX2V2ZW50
KQogewogCWJvb2wgc2tpcCA9IGZhbHNlOwogCXN0cnVjdCBpb19ldl9mZCAqZXZfZmQ7Ci0K
LQlpZiAoUkVBRF9PTkNFKGN0eC0+cmluZ3MtPmNxX2ZsYWdzKSAmIElPUklOR19DUV9FVkVO
VEZEX0RJU0FCTEVEKQotCQlyZXR1cm47CisJc3RydWN0IGlvX3JpbmdzICpyaW5nczsKIAog
CWd1YXJkKHJjdSkoKTsKKworCXJpbmdzID0gcmN1X2RlcmVmZXJlbmNlKGN0eC0+cmluZ3Nf
cmN1KTsKKwlpZiAoIXJpbmdzKQorCQlyZXR1cm47CisJaWYgKFJFQURfT05DRShyaW5ncy0+
Y3FfZmxhZ3MpICYgSU9SSU5HX0NRX0VWRU5URkRfRElTQUJMRUQpCisJCXJldHVybjsKIAll
dl9mZCA9IHJjdV9kZXJlZmVyZW5jZShjdHgtPmlvX2V2X2ZkKTsKIAkvKgogCSAqIENoZWNr
IGFnYWluIGlmIGV2X2ZkIGV4aXN0cyBpbiBjYXNlIGFuIGlvX2V2ZW50ZmRfdW5yZWdpc3Rl
ciBjYWxsCi0tIAoyLjUzLjAKCg==
--------------UATGLzEuYMezMnnyajdYHMqX
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-ensure-ctx-rings-is-stable-for-task-work-fl.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-ensure-ctx-rings-is-stable-for-task-work-fl.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4ZTc0NmJkMWRhZGFmOTM1NDJjYTU5ZGM5NzFiMjMzMzMyYzQ2Y2E2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgOSBNYXIgMjAyNiAxNDoyMTozNyAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBpb191cmluZzogZW5zdXJlIGN0eC0+cmluZ3MgaXMgc3RhYmxlIGZvciB0YXNrIHdvcmsg
ZmxhZ3MKIG1hbmlwdWxhdGlvbgoKQ29tbWl0IDk2MTg5MDgwMjY1ZTZiYjVkZGUzYTRhZmJh
Zjk0N2FmNDkzZTNmODIgdXBzdHJlYW0uCgpJZiBERUZFUl9UQVNLUlVOIHwgU0VUVVBfVEFT
S1JVTiBpcyB1c2VkIGFuZCB0YXNrIHdvcmsgaXMgYWRkZWQgd2hpbGUKdGhlIHJpbmcgaXMg
YmVpbmcgcmVzaXplZCwgaXQncyBwb3NzaWJsZSBmb3IgdGhlIE9SJ2luZyBvZgpJT1JJTkdf
U1FfVEFTS1JVTiB0byBoYXBwZW4gaW4gdGhlIHNtYWxsIHdpbmRvdyBvZiBzd2FwcGluZyBp
bnRvIHRoZQpuZXcgcmluZ3MgYW5kIHRoZSBvbGQgcmluZ3MgYmVpbmcgZnJlZWQuCgpQcmV2
ZW50IHRoaXMgYnkgYWRkaW5nIGEgMm5kIC0+cmluZ3MgcG9pbnRlciwgLT5yaW5nc19yY3Us
IHdoaWNoIGlzCnByb3RlY3RlZCBieSBSQ1UuIFRoZSB0YXNrIHdvcmsgZmxhZ3MgbWFuaXB1
bGF0aW9uIGlzIGluc2lkZSBSQ1UKYWxyZWFkeSwgYW5kIGlmIHRoZSByZXNpemUgcmluZyBm
cmVlaW5nIGlzIGRvbmUgcG9zdCBhbiBSQ1Ugc3luY2hyb25pemUsCnRoZW4gdGhlcmUncyBu
byBuZWVkIHRvIGFkZCBsb2NraW5nIHRvIHRoZSBmYXN0IHBhdGggb2YgdGFzayB3b3JrCmFk
ZGl0aW9ucy4KCk5vdGU6IHRoaXMgaXMgb25seSBkb25lIGZvciBERUZFUl9UQVNLUlVOLCBh
cyB0aGF0J3MgdGhlIG9ubHkgc2V0dXAgbW9kZQp0aGF0IHN1cHBvcnRzIHJpbmcgcmVzaXpp
bmcuIElmIHRoaXMgZXZlciBjaGFuZ2VzLCB0aGVuIHRoZXkgdG9vIG5lZWQgdG8KdXNlIHRo
ZSBpb19jdHhfbWFya190YXNrcnVuKCkgaGVscGVyLgoKTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvaW8tdXJpbmcvMjAyNjAzMDkwNjI3NTkuNDgyMjEwLTEtbmF1cDk2NzIxQGdt
YWlsLmNvbS8KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDc5Y2ZlOWU1OWMy
YSAoImlvX3VyaW5nL3JlZ2lzdGVyOiBhZGQgSU9SSU5HX1JFR0lTVEVSX1JFU0laRV9SSU5H
UyIpClJlcG9ydGVkLWJ5OiBIYW8tWXUgWWFuZyA8bmF1cDk2NzIxQGdtYWlsLmNvbT4KU3Vn
Z2VzdGVkLWJ5OiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdtYWlsLmNvbT4KU2ln
bmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGluY2x1ZGUv
bGludXgvaW9fdXJpbmdfdHlwZXMuaCB8ICAxICsKIGlvX3VyaW5nL2lvX3VyaW5nLmMgICAg
ICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKysrKysrKystLQogaW9fdXJpbmcvcmVnaXN0
ZXIuYyAgICAgICAgICAgIHwgMTIgKysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDM1
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9pb191cmluZ190eXBlcy5oIGIvaW5jbHVkZS9saW51eC9pb191cmluZ190eXBlcy5o
CmluZGV4IDRjOTc3MDUzNmViNS4uZjNhOGExMzA2Y2Y0IDEwMDY0NAotLS0gYS9pbmNsdWRl
L2xpbnV4L2lvX3VyaW5nX3R5cGVzLmgKKysrIGIvaW5jbHVkZS9saW51eC9pb191cmluZ190
eXBlcy5oCkBAIC0zNzEsNiArMzcxLDcgQEAgc3RydWN0IGlvX3JpbmdfY3R4IHsKIAkgKiBy
ZWd1bGFybHkgYm91bmNlIGIvdyBDUFVzLgogCSAqLwogCXN0cnVjdCB7CisJCXN0cnVjdCBp
b19yaW5ncwlfX3JjdQkqcmluZ3NfcmN1OwogCQlzdHJ1Y3QgbGxpc3RfaGVhZAl3b3JrX2xs
aXN0OwogCQlzdHJ1Y3QgbGxpc3RfaGVhZAlyZXRyeV9sbGlzdDsKIAkJdW5zaWduZWQgbG9u
ZwkJY2hlY2tfY3E7CmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmluZy5jIGIvaW9fdXJp
bmcvaW9fdXJpbmcuYwppbmRleCA2M2VmZDYwODI5ZjMuLjViN2ViZjE0MzQxMiAxMDA2NDQK
LS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9pb191cmluZy5jCkBA
IC0xMjAyLDYgKzEyMDIsMjEgQEAgdm9pZCB0Y3R4X3Rhc2tfd29yayhzdHJ1Y3QgY2FsbGJh
Y2tfaGVhZCAqY2IpCiAJV0FSTl9PTl9PTkNFKHJldCk7CiB9CiAKKy8qCisgKiBTZXRzIElP
UklOR19TUV9UQVNLUlVOIGluIHRoZSBzcV9mbGFncyBzaGFyZWQgd2l0aCB1c2Vyc3BhY2Us
IHVzaW5nIHRoZQorICogUkNVIHByb3RlY3RlZCByaW5ncyBwb2ludGVyIHRvIGJlIHNhZmUg
YWdhaW5zdCBjb25jdXJyZW50IHJpbmcgcmVzaXppbmcuCisgKi8KK3N0YXRpYyB2b2lkIGlv
X2N0eF9tYXJrX3Rhc2tydW4oc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCit7CisJbG9ja2Rl
cF9hc3NlcnRfaW5fcmN1X3JlYWRfbG9jaygpOworCisJaWYgKGN0eC0+ZmxhZ3MgJiBJT1JJ
TkdfU0VUVVBfVEFTS1JVTl9GTEFHKSB7CisJCXN0cnVjdCBpb19yaW5ncyAqcmluZ3MgPSBy
Y3VfZGVyZWZlcmVuY2UoY3R4LT5yaW5nc19yY3UpOworCisJCWF0b21pY19vcihJT1JJTkdf
U1FfVEFTS1JVTiwgJnJpbmdzLT5zcV9mbGFncyk7CisJfQorfQorCiBzdGF0aWMgdm9pZCBp
b19yZXFfbG9jYWxfd29ya19hZGQoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGZs
YWdzKQogewogCXN0cnVjdCBpb19yaW5nX2N0eCAqY3R4ID0gcmVxLT5jdHg7CkBAIC0xMjU2
LDggKzEyNzEsNyBAQCBzdGF0aWMgdm9pZCBpb19yZXFfbG9jYWxfd29ya19hZGQoc3RydWN0
IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGZsYWdzKQogCSAqLwogCiAJaWYgKCFoZWFkKSB7
Ci0JCWlmIChjdHgtPmZsYWdzICYgSU9SSU5HX1NFVFVQX1RBU0tSVU5fRkxBRykKLQkJCWF0
b21pY19vcihJT1JJTkdfU1FfVEFTS1JVTiwgJmN0eC0+cmluZ3MtPnNxX2ZsYWdzKTsKKwkJ
aW9fY3R4X21hcmtfdGFza3J1bihjdHgpOwogCQlpZiAoY3R4LT5oYXNfZXZmZCkKIAkJCWlv
X2V2ZW50ZmRfc2lnbmFsKGN0eCwgZmFsc2UpOwogCX0KQEAgLTEyODEsNiArMTI5NSwxMCBA
QCBzdGF0aWMgdm9pZCBpb19yZXFfbm9ybWFsX3dvcmtfYWRkKHN0cnVjdCBpb19raW9jYiAq
cmVxKQogCWlmICghbGxpc3RfYWRkKCZyZXEtPmlvX3Rhc2tfd29yay5ub2RlLCAmdGN0eC0+
dGFza19saXN0KSkKIAkJcmV0dXJuOwogCisJLyoKKwkgKiBEb2Vzbid0IG5lZWQgdG8gdXNl
IC0+cmluZ3NfcmN1LCBhcyByZXNpemluZyBpc24ndCBzdXBwb3J0ZWQgZm9yCisJICogIURF
RkVSX1RBU0tSVU4uCisJICovCiAJaWYgKGN0eC0+ZmxhZ3MgJiBJT1JJTkdfU0VUVVBfVEFT
S1JVTl9GTEFHKQogCQlhdG9taWNfb3IoSU9SSU5HX1NRX1RBU0tSVU4sICZjdHgtPnJpbmdz
LT5zcV9mbGFncyk7CiAKQEAgLTI3NjAsNiArMjc3OCw3IEBAIHN0YXRpYyB2b2lkIGlvX3Jp
bmdzX2ZyZWUoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgpCiAJaW9fZnJlZV9yZWdpb24oY3R4
LT51c2VyLCAmY3R4LT5zcV9yZWdpb24pOwogCWlvX2ZyZWVfcmVnaW9uKGN0eC0+dXNlciwg
JmN0eC0+cmluZ19yZWdpb24pOwogCWN0eC0+cmluZ3MgPSBOVUxMOworCVJDVV9JTklUX1BP
SU5URVIoY3R4LT5yaW5nc19yY3UsIE5VTEwpOwogCWN0eC0+c3Ffc3FlcyA9IE5VTEw7CiB9
CiAKQEAgLTMzODksNiArMzQwOCw3IEBAIHN0YXRpYyBfX2NvbGQgaW50IGlvX2FsbG9jYXRl
X3NjcV91cmluZ3Moc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsCiAJaWYgKHJldCkKIAkJcmV0
dXJuIHJldDsKIAljdHgtPnJpbmdzID0gcmluZ3MgPSBpb19yZWdpb25fZ2V0X3B0cigmY3R4
LT5yaW5nX3JlZ2lvbik7CisJcmN1X2Fzc2lnbl9wb2ludGVyKGN0eC0+cmluZ3NfcmN1LCBy
aW5ncyk7CiAJaWYgKCEoY3R4LT5mbGFncyAmIElPUklOR19TRVRVUF9OT19TUUFSUkFZKSkK
IAkJY3R4LT5zcV9hcnJheSA9ICh1MzIgKikoKGNoYXIgKilyaW5ncyArIHJsLT5zcV9hcnJh
eV9vZmZzZXQpOwogCmRpZmYgLS1naXQgYS9pb191cmluZy9yZWdpc3Rlci5jIGIvaW9fdXJp
bmcvcmVnaXN0ZXIuYwppbmRleCAxMjMxOGMyNzYwNjguLmZmOWQ3NWZmYmQxNSAxMDA2NDQK
LS0tIGEvaW9fdXJpbmcvcmVnaXN0ZXIuYworKysgYi9pb191cmluZy9yZWdpc3Rlci5jCkBA
IC01NDUsNyArNTQ1LDE1IEBAIHN0YXRpYyBpbnQgaW9fcmVnaXN0ZXJfcmVzaXplX3Jpbmdz
KHN0cnVjdCBpb19yaW5nX2N0eCAqY3R4LCB2b2lkIF9fdXNlciAqYXJnKQogCWN0eC0+c3Ff
ZW50cmllcyA9IHAtPnNxX2VudHJpZXM7CiAJY3R4LT5jcV9lbnRyaWVzID0gcC0+Y3FfZW50
cmllczsKIAorCS8qCisJICogSnVzdCBtYXJrIGFueSBmbGFnIHdlIG1heSBoYXZlIG1pc3Nl
ZCBhbmQgdGhhdCB0aGUgYXBwbGljYXRpb24KKwkgKiBzaG91bGQgYWN0IG9uIHVuY29uZGl0
aW9uYWxseS4gV29yc3QgY2FzZSBpdCdsbCBiZSBhbiBleHRyYQorCSAqIHN5c2NhbGwuCisJ
ICovCisJYXRvbWljX29yKElPUklOR19TUV9UQVNLUlVOIHwgSU9SSU5HX1NRX05FRURfV0FL
RVVQLCAmbi5yaW5ncy0+c3FfZmxhZ3MpOwogCWN0eC0+cmluZ3MgPSBuLnJpbmdzOworCXJj
dV9hc3NpZ25fcG9pbnRlcihjdHgtPnJpbmdzX3JjdSwgbi5yaW5ncyk7CisKIAljdHgtPnNx
X3NxZXMgPSBuLnNxX3NxZXM7CiAJc3dhcF9vbGQoY3R4LCBvLCBuLCByaW5nX3JlZ2lvbik7
CiAJc3dhcF9vbGQoY3R4LCBvLCBuLCBzcV9yZWdpb24pOwpAQCAtNTU0LDYgKzU2MiwxMCBA
QCBzdGF0aWMgaW50IGlvX3JlZ2lzdGVyX3Jlc2l6ZV9yaW5ncyhzdHJ1Y3QgaW9fcmluZ19j
dHggKmN0eCwgdm9pZCBfX3VzZXIgKmFyZykKIG91dDoKIAlzcGluX3VubG9jaygmY3R4LT5j
b21wbGV0aW9uX2xvY2spOwogCW11dGV4X3VubG9jaygmY3R4LT5tbWFwX2xvY2spOworCisJ
LyogV2FpdCBmb3IgY29uY3VycmVudCBpb19jdHhfbWFya190YXNrcnVuKCkgKi8KKwlpZiAo
dG9fZnJlZSA9PSAmbykKKwkJc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgpOwogCWlvX3Jl
Z2lzdGVyX2ZyZWVfcmluZ3MoY3R4LCB0b19mcmVlKTsKIAogCWlmIChjdHgtPnNxX2RhdGEp
Ci0tIAoyLjUzLjAKCg==

--------------UATGLzEuYMezMnnyajdYHMqX--

