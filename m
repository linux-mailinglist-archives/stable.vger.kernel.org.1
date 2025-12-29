Return-Path: <stable+bounces-203605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37939CE6FE5
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AD203011414
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807DC31986D;
	Mon, 29 Dec 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jfNYsBqp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1C31A54F
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767017882; cv=none; b=HOt3/oZw0M9+Wpa9UXSE5dQ1kFscGbvy+ghWiUXqhgbpwV12eZ91vLlx4qE2YCCrVtgNoHjXb7MCZXbcxTncS7Blw6F4JCDGrrUzUtiXZ2G9VDVaOO5gGeG2txYCv3iCIpGrswv4g7S1944xNt2wq5F/mGg96cfKH7Ahtp4bgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767017882; c=relaxed/simple;
	bh=G6Ioj7h+e+PstWC+XpxwOINb3zwdCIIcjXvJXzxbOPg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Vt7Se5JFTGaIpWhLhROrhG78KsNk2qb6AO6KLGFavulZ9FqGQEoyxmqifjfduE6n8Ep5zpm+1D6amTEDt3CE+L3z9FZhdEyZ96yeoZ1B0mewzaZ4e9IerLc/KAEyIn3JYLI/SK2OQUtozyrvm6rzG0569/NWOp1v2ZtwLHPEhKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jfNYsBqp; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c6e815310aso7419730a34.0
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 06:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767017878; x=1767622678; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5WSZvZCd364bNPuofmGCZZbnlNvyvxjr2jF2ICCL7g=;
        b=jfNYsBqp1FxzuqtgLyNSugcbqCNJCrDx1zDbelvAsVeve9HZge8Taym47Ul9I2eTL5
         pUrHLatZg9wjTT21ztG9DpvWrbyxJjSKQy07bz/8Q8FC6NatukI+zv3yyZYvUPlGZ2Pw
         N7T/cuSJqZ0ubWoZJvL7uTQ+EyTp1+1W9FNkmFlh+tLZo9i83eCjo46qnw9DGvmePaUZ
         OBBr/beP5bb5NEIoa493aWvhzRzruQ0HTF9YVdMloBaRuszu+VAv87O9XCWN2wWHLH+h
         qqnXxOLt/sS7BaSxof4zrWM7ozTCXbJaVO21MXlTIOraLg4FIzlZIv0w4qDOsE5NLbuL
         0PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767017878; x=1767622678;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m5WSZvZCd364bNPuofmGCZZbnlNvyvxjr2jF2ICCL7g=;
        b=aj4QmSxIKymXZSDVjEuUoTJKR5KN4HvppUcuKeFQD9UjSHlKcn9QEc3NHxRfphngWK
         GYc879f0q7wWAiwLv/HlvsvTUmxoT6uzHUIhQR55U9lqajcrx54J1h+5gzrmeA23hQUG
         lookS/P1DaiV1Ds2OPditFzuKaD76F340eynF4Xl6W8pFbC43dQFRA+3/Z7riyB5dKlU
         hacwuI5M5AqE7xTUQJUTfs2S/Crzm1pbbcwAw4EeYJZwZEoEeLC0h41PD4JlLeSa7kAp
         X2bIKncDEG2JPdAYlitYwHUXnmvnEXp+sZk8zrovOMD6dbJ+5llkgEgD/JAbKOL4WEbY
         +LHw==
X-Gm-Message-State: AOJu0YwaIUaVaKIcGRZWFxx8Od+MmJPg7RWkh7+1RIx20kDJkrrZuoVk
	+ux6ZB7Oqc8r7tMgAt6SWdzzMbLaBV0WOfw7T6CC74qobN0LyfrwScBk/Iy3ET+bm1zPbYfglqI
	wR3Q4
X-Gm-Gg: AY/fxX6FQliUPDLAbWkczz6fNm9JdEC7D8pz3Kl45ZzfmGkiLD8ncptvNehBTito7c9
	lYtfdD7eRGyLshOEPhTGIsP4ZED05DI9wQAqgCpyQhweStEI/6OBD7bgG5NyhCcv/B9qCY2Namd
	FLV6OAFYmIfcQk+9vUHyfkx0wSQflZpTgp2qqmWwXHY7nabS2dDumaGII07xwZcey1Ti7UU8cj7
	Gthp+Vv+wyB2h7WLncLnDXLTdrB4xVUsL25EzjfNGB7SMmV46aU0Tjc8sbOL8wDovkbfXn173MA
	jsPoYBh1GE1ugGhgCERWpEAhXCA+Rzo2NOY0II5MJOgUoelBqD7Wc8rTLXYaADILnN0LTTmsqdI
	e/MwYGMsZJKZnIh0DrjhfFUpVFj+oTgdweoPoqKiVGhuapBwOnvW6lsPYabRwfssgxU2rx/JBmf
	yy+cMQZ3yj
X-Google-Smtp-Source: AGHT+IGwAOo6pcFSVXZ8bOkzR5XlMI7qk8DuEK4pyVADnTa054w8VKu8elkSR82PPfWGnV0KSHhtnA==
X-Received: by 2002:a05:6830:4408:b0:7c7:568d:cba with SMTP id 46e09a7af769-7cc667f65cemr16914877a34.0.1767017877856;
        Mon, 29 Dec 2025 06:17:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66728296sm20799199a34.4.2025.12.29.06.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Dec 2025 06:17:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------09kb0pW0EDqEvUXFrYgYB80V"
Message-ID: <64681c34-0056-4a33-9995-1e57e37c8250@kernel.dk>
Date: Mon, 29 Dec 2025 07:17:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/poll: correctly handle
 io_poll_add() return value on" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2025122926-disarray-agile-9880@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025122926-disarray-agile-9880@gregkh>

This is a multi-part message in MIME format.
--------------09kb0pW0EDqEvUXFrYgYB80V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/25 5:21 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's one for 6.6-stable.

-- 
Jens Axboe

--------------09kb0pW0EDqEvUXFrYgYB80V
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-poll-correctly-handle-io_poll_add-return-va.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-poll-correctly-handle-io_poll_add-return-va.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2NmEzYTFhMDQ4NDlhODQ1ZWMyNzYwZGFiZmRkYWFhNWI4MzVjYzg1IE1vbiBTZXAg
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
Z2l0IGEvaW9fdXJpbmcvcG9sbC5jIGIvaW9fdXJpbmcvcG9sbC5jCmluZGV4IGI2YzhhY2Q4
NjI1ZS4uNjQ4MzVkNjkyYzM3IDEwMDY0NAotLS0gYS9pb191cmluZy9wb2xsLmMKKysrIGIv
aW9fdXJpbmcvcG9sbC5jCkBAIC0xMDI0LDEyICsxMDI0LDE3IEBAIGludCBpb19wb2xsX3Jl
bW92ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQog
CiAJCXJldDIgPSBpb19wb2xsX2FkZChwcmVxLCBpc3N1ZV9mbGFncyAmIH5JT19VUklOR19G
X1VOTE9DS0VEKTsKIAkJLyogc3VjY2Vzc2Z1bGx5IHVwZGF0ZWQsIGRvbid0IGNvbXBsZXRl
IHBvbGwgcmVxdWVzdCAqLwotCQlpZiAoIXJldDIgfHwgcmV0MiA9PSAtRUlPQ0JRVUVVRUQp
CisJCWlmIChyZXQyID09IElPVV9JU1NVRV9TS0lQX0NPTVBMRVRFKQogCQkJZ290byBvdXQ7
CisJCS8qIHJlcXVlc3QgY29tcGxldGVkIGFzIHBhcnQgb2YgdGhlIHVwZGF0ZSwgY29tcGxl
dGUgaXQgKi8KKwkJZWxzZSBpZiAocmV0MiA9PSBJT1VfT0spCisJCQlnb3RvIGNvbXBsZXRl
OwogCX0KIAotCXJlcV9zZXRfZmFpbChwcmVxKTsKIAlpb19yZXFfc2V0X3JlcyhwcmVxLCAt
RUNBTkNFTEVELCAwKTsKK2NvbXBsZXRlOgorCWlmIChwcmVxLT5jcWUucmVzIDwgMCkKKwkJ
cmVxX3NldF9mYWlsKHByZXEpOwogCXByZXEtPmlvX3Rhc2tfd29yay5mdW5jID0gaW9fcmVx
X3Rhc2tfY29tcGxldGU7CiAJaW9fcmVxX3Rhc2tfd29ya19hZGQocHJlcSk7CiBvdXQ6Ci0t
IAoyLjUxLjAKCg==

--------------09kb0pW0EDqEvUXFrYgYB80V--

