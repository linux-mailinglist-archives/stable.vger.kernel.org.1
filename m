Return-Path: <stable+bounces-225974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c+j1NORQuWkoAgIAu9opvQ
	(envelope-from <stable+bounces-225974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:02:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D349B2AA5D2
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 45B00303A276
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC493C73C0;
	Tue, 17 Mar 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DL9Sr7Iv"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48063C6A3D
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752382; cv=none; b=WJ8DyT3Qn0wSYPI3xkLSvSrLstnA/kRB1Ck1s3Ozd64GbbzksJtaw1WyV7GAooW/wVLiKOguN6ngrUcxUJat1y64ISFZgcCQpPzUZgDraFN50uU487Fo5T1oF7sG3DgZTKxFYmLQMd3bN0dN7UKJ+vzdGuxvCpe0OC0xDmdNM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752382; c=relaxed/simple;
	bh=Lw1Q2KCCiz8nj6exr/Eke4nZYQruMtMWJGNy+TewuXg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Z07cq0hlhCr6nMnsVwRM8Sy4nUJXBFBkx2whSQw7vEnE+Hr4oPPFMU3+cmEIYnepUcYvK4PVT1mauYMWdmvtxWHiJ8WwFogY332eUryoK7lB3sXG6j6xxdgmLNyrfNHXij1X3lMJcRZ6HT0U17XGn76yEB7S9v3YmkxjuWv9LhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DL9Sr7Iv; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-464bc03efd8so3749224b6e.2
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773752380; x=1774357180; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkwUmi/Ea5MAtsW8mnEudhJXDU7K3LG3tUiAJ0N2NeA=;
        b=DL9Sr7IvtGsB5kOe0h8aRSwiu0wTWnaGTRiKezqiFlkgPU7EcItDiTgj7M84vlmpYd
         XBwp6KM+z3Nq34Qb45B3QvzDVXEoSsARo8sVaPgazk9YsRVRU5dCLY0fiqhYMqEhZKI+
         zGcie0/0b4DGmeMk/W16P7TtAN/1L2DBY8U/zi9WvbTCIoOshyIsoafnPws8hhDj9SHD
         RFbeGidY5WF2OKRF9nYfMp6FaEQmXoBLRObmn9KzN48cOvgfjeXef1FPyUbgmN4RZ9dR
         Mz8ptbWcznSTEl2geq7cuxUU7r5ODbmn8x0LYJzaF+h7vtFdM+Qcx5hJHr4ZWLYcnsSi
         o6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773752380; x=1774357180;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkwUmi/Ea5MAtsW8mnEudhJXDU7K3LG3tUiAJ0N2NeA=;
        b=WI/gob4A1Y3GlHo2w+1Pu3wOE+ksmHefSzQ3ZH5awh+dWQHMVUh/BhJ8A0qmuNNnIm
         zuhBYeJ9oVaRsvDnc2kpT1L/yB88kDteS5grkMcjpMo9eLN3yjRKi6AW+DAsPLqczvdF
         xhXC00ZxEqH4rljYFwXU/jw3mgfqXCxqa7M5zuCY6/ZPU4YEY7TOSKTpV+ZOnCYKEwPt
         JS7nbrljJzFpCXKPWGHGWYT+0/GPHOpLvEoBwxwpvCqg7ZfmPCym1JG73SgOcKePfYiQ
         eS8jnvzE5AkBbp+8adqUzY6XwnFo4NWcsJ2cojsGetZxIY8/AysTmKCrVten1aOw4C6i
         VxFg==
X-Gm-Message-State: AOJu0YwtUxdv/FlImqiQWbGPpsEh7VBK2uML2khQZHdOXOGRxZYTYOKX
	kVm7M/2/G9WEh381o/wP54q0hhdzzbhhuEYJq+iv+Hf3tXIF6oxBNE/wGZ3ln7z9y1ttryW3ZYw
	BSrcGG4Y=
X-Gm-Gg: ATEYQzwwVIbpjA7yyzIGIq5i+Re3KRyDAHk9DgKcYWqKG2m+JUgtDqoyHDesBvRMaBd
	CquMoEqd8+CQyscd4K2uPWTefJQrHcBLTS0TgiNjcS8NIush1C+/YiAztJkOf+nuMCMhmwX72+y
	TQ/ShNcZm/HfUjiPr8xoiS/8OmEwJGwav7ZVJRWVTNtkWszg7YxfXzcJ2DE5pgxsc7efERtqYW+
	GS2UxI4EjWyGzpARx+W8s5nGLb/D/AfhzLcYwydEhRN/OhAyFE9V1Y/UykUgaNocNETJIMtj77h
	bLODyWNaz5EuarmMcd8rk0AaTTqMThxZrzEoYjb8oCvGiXl4O5XPEL0lrg8+gIF379QSd4QyL3t
	bCfEJ4q2p511jyTzNt5ZMUZ2fkydzgLd0TrGDcIonrdPH783NbpNuzzol6IBJy/j8bb5BeTa2r6
	8Z1/Qg8MIfuYCwSqIukoGdDVbjtAm6NWrlY7wUIcFenny96KEL7lJJv30B/0qY7UIjweiMECTiF
	aSGof1IEgZNDEMFz592
X-Received: by 2002:a05:6808:6414:b0:467:2418:cee2 with SMTP id 5614622812f47-4675757805cmr9315599b6e.56.1773752379572;
        Tue, 17 Mar 2026 05:59:39 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46744873a6asm10050879b6e.9.2026.03.17.05.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 05:59:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------tcqGXRUlHzbR3Jpp0u03xkRc"
Message-ID: <4e1d07d8-73fe-41d2-a2a7-31f769f4503c@kernel.dk>
Date: Tue, 17 Mar 2026 06:59:37 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: check if target buffer list
 is still legacy on" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, keenanat2000@gmail.com
Cc: stable@vger.kernel.org
References: <2026031700-vagrancy-doze-c356@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026031700-vagrancy-doze-c356@gregkh>
X-Spamd-Result: default: False [-0.56 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225974-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmail.com];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,kernel.dk:mid,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D349B2AA5D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a multi-part message in MIME format.
--------------tcqGXRUlHzbR3Jpp0u03xkRc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 6:55 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's a tested version for 6.12.

-- 
Jens Axboe

--------------tcqGXRUlHzbR3Jpp0u03xkRc
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-kbuf-check-if-target-buffer-list-is-still-l.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-kbuf-check-if-target-buffer-list-is-still-l.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkOWM5YjIyOTgzYWRlM2FiNTBjYjM2ZmY3ZDVmODg2NDczOTYzYWYyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMTIgTWFyIDIwMjYgMDg6NTk6MjUgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9rYnVmOiBjaGVjayBpZiB0YXJnZXQgYnVmZmVyIGxpc3QgaXMgc3RpbGwgbGVn
YWN5IG9uCiByZWN5Y2xlCgpDb21taXQgYzJjMTg1YmU1Yzg1ZDM3MjE1Mzk3YzhlODc4MWFi
ZjBhNjliZWMxZiB1cHN0cmVhbS4KClRoZXJlJ3MgYSBnYXAgYmV0d2VlbiB3aGVuIHRoZSBi
dWZmZXIgd2FzIGdyYWJiZWQgYW5kIHdoZW4gaXQKcG90ZW50aWFsbHkgZ2V0cyByZWN5Y2xl
ZCwgd2hlcmUgaWYgdGhlIGxpc3QgaXMgZW1wdHksIHNvbWVvbmUgY291bGQndmUKdXBncmFk
ZWQgaXQgdG8gYSByaW5nIHByb3ZpZGVkIHR5cGUuIFRoaXMgY2FuIGhhcHBlbiBpZiB0aGUg
cmVxdWVzdAppcyBmb3JjZWQgdmlhIGlvLXdxLiBUaGUgbGVnYWN5IHJlY3ljbGluZyBpcyBt
aXNzaW5nIGNoZWNraW5nIGlmIHRoZQpidWZmZXJfbGlzdCBzdGlsbCBleGlzdHMsIGFuZCBp
ZiBpdCdzIG9mIHRoZSBjb3JyZWN0IHR5cGUuIEFkZCB0aG9zZQpjaGVja3MuCgpDYzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogYzdmYjE5NDI4ZDY3ICgiaW9fdXJpbmc6IGFk
ZCBzdXBwb3J0IGZvciByaW5nIG1hcHBlZCBzdXBwbGllZCBidWZmZXJzIikKUmVwb3J0ZWQt
Ynk6IEtlZW5hbiBEb25nIDxrZWVuYW5hdDIwMDBAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5
OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcva2J1Zi5jIHwg
MTIgKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9rYnVmLmMgYi9pb191cmluZy9r
YnVmLmMKaW5kZXggOWJkMjdkZWVlZTZmLi4yNTU5N2YwNjI5ZjMgMTAwNjQ0Ci0tLSBhL2lv
X3VyaW5nL2tidWYuYworKysgYi9pb191cmluZy9rYnVmLmMKQEAgLTYyLDkgKzYyLDE3IEBA
IGJvb2wgaW9fa2J1Zl9yZWN5Y2xlX2xlZ2FjeShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5z
aWduZWQgaXNzdWVfZmxhZ3MpCiAKIAlidWYgPSByZXEtPmtidWY7CiAJYmwgPSBpb19idWZm
ZXJfZ2V0X2xpc3QoY3R4LCBidWYtPmJnaWQpOwotCWxpc3RfYWRkKCZidWYtPmxpc3QsICZi
bC0+YnVmX2xpc3QpOwotCXJlcS0+ZmxhZ3MgJj0gflJFUV9GX0JVRkZFUl9TRUxFQ1RFRDsK
KwkvKgorCSAqIElmIHRoZSBidWZmZXIgbGlzdCB3YXMgdXBncmFkZWQgdG8gYSByaW5nLWJh
c2VkIG9uZSwgb3IgcmVtb3ZlZCwKKwkgKiB3aGlsZSB0aGUgcmVxdWVzdCB3YXMgaW4tZmxp
Z2h0IGluIGlvLXdxLCBkcm9wIGl0LgorCSAqLwogCXJlcS0+YnVmX2luZGV4ID0gYnVmLT5i
Z2lkOworCWlmIChibCAmJiAhKGJsLT5mbGFncyAmIElPQkxfQlVGX1JJTkcpKQorCQlsaXN0
X2FkZCgmYnVmLT5saXN0LCAmYmwtPmJ1Zl9saXN0KTsKKwllbHNlCisJCWttZW1fY2FjaGVf
ZnJlZShpb19idWZfY2FjaGVwLCBidWYpOworCXJlcS0+ZmxhZ3MgJj0gflJFUV9GX0JVRkZF
Ul9TRUxFQ1RFRDsKKwlyZXEtPmtidWYgPSBOVUxMOwogCiAJaW9fcmluZ19zdWJtaXRfdW5s
b2NrKGN0eCwgaXNzdWVfZmxhZ3MpOwogCXJldHVybiB0cnVlOwotLSAKMi41My4wCgo=

--------------tcqGXRUlHzbR3Jpp0u03xkRc--

