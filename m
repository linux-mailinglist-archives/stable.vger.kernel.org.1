Return-Path: <stable+bounces-111477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD641A22F5A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F873A5F4D
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78D1E98FF;
	Thu, 30 Jan 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l0W1FgTw"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75701E991B
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246853; cv=none; b=PXmiADKt3M8a4MZ4OxVfr6egd1hy74njqVf1jmIOAM+s0n1uxH/W7e8T0eO+0V0CDasEM9tdLUDwZk+MhLd+V0Nuy0HN47P1SfKOA3BTc9a6hHIz66pt0CU3ks/G13C4AhLDLDsAUYpcQoJescVeXqzGUc5nxA86dqZYbG7SYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246853; c=relaxed/simple;
	bh=8R6c3B6fJVC4f1MoepFzs6F6sPdpJ73p0PBa6d+jM4M=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Zg3hNr902hOCuYBs5sc0rdrQgL6zmGq0XOJF16CQkCJAcmVMVgLnAIy57Qhb48EIgVkWhx6H83odygyz1SPuviMASKsqyK+w+HJZ/e1Pde5q8OkgvbI9/jVNY2vVHOH+TJAPJzMnymimg2Y/VNiWubTr4EQfl2kyiHRgwt3axU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l0W1FgTw; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cfc1ff581dso2575155ab.3
        for <stable@vger.kernel.org>; Thu, 30 Jan 2025 06:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738246848; x=1738851648; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU06OwhztTH8QC4/s2rK/LcOpYXEj78/h5xWEGAayg4=;
        b=l0W1FgTwrvTQV/6FQ9GibxzTrryELKyZQPWeatjG6Ni2wdqaX1HTulcPi3cIhiI7nZ
         Txokt1JK9dC+60mJ5m94wKw5lQTMcoaBVssPov1tH2rAPeHqWVr3Q6wFqzVmEH/o5QeX
         j0wRw9cRbTT/UiMOKdLJFWrqCyopCG9odp/AQJJQnSgE141X/46PX6US6u///euNsd/v
         jto+5QGFLKUqZMYwCkmbFpIVx+MqK4anhwZujIlwabqvfr/6cXBenl/Xm62I3iZdw5Sx
         p+ArCVEnZ8GEFfAMWCeffe5W+F2z5jD9d84s67W5wDL0mRZfK+NA2fSFcDaRu/2D0mkq
         pvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738246848; x=1738851648;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vU06OwhztTH8QC4/s2rK/LcOpYXEj78/h5xWEGAayg4=;
        b=MSVyg9cp1zWo/P9L4DFmAW0LExz9shn41byO76muIcauTzj5C8HkNTZkmNupBJdxSq
         phtgaVYZUWgQgubtPmlhCqkGGS9UZ7oVizp5pJZJq0PqV6r7RXwx2ZFixbJzXVCA+OyK
         Nyrebye3EaIJdYFKhXvwQbNoDVKaUzIemX7q0W8l1OIA3RW/jqYEWPDcYq8dekYPXUNE
         tuYrvhrCa56EPxitkwffMAFXvmrPTnK/BM8e4hb4Oh0cq1Ff8wCLA79lRI+q44W13Al+
         9QhDytMSGfMu0CTGPnfkIUeJhy0/7E23JmoN+sP9T6Y0x1L+NkJA2+DlXKCP+aD4R5u8
         lQRg==
X-Gm-Message-State: AOJu0YzUfe8xhne15NPyN93nl99hvEPiWNobwplaWhjMb8h6bTOkW3hQ
	5OOShrcKChA1NIZ3P/H+3OUamK/XPF1E6OMaUnQ4PGVizutz0fRA68X0bhj6eMo1iSXCt1eIktj
	b
X-Gm-Gg: ASbGncuOLFIKxUOMHWSj0IftvgKjNuQfsr7rvbRKXfVOVl9wd1kcfQ+PQxvHsekxIIt
	//mvVDbNro/Xwhfq2WOvinPWCCuPoNJq8ojFb5PK6GdOCyTGy4e62dmXz37Nm6CvV2RLYSTvoIv
	XUWDdSERBnihetKb2l/46Zw1Lv11psmYTYNizWd5HgSSehWEPMKQDb/F6urThM97Kf//u5YiAch
	RCFLi/jnW5KHiPdO58ajjPDMOfq1ZRgWlW8HZxVkV/aLG+L45NXEkGyQRFWIwdcIIgfLybhAhLe
	tlGQOTw+okI=
X-Google-Smtp-Source: AGHT+IGyIs26z5ihY20TkniVwT+/JIQuczE2jV8rJIjpd0g39ZV6LZdQcg7caRVvztB9ldWORW7/0Q==
X-Received: by 2002:a92:cda7:0:b0:3ce:8b1b:2f with SMTP id e9e14a558f8ab-3cffe4b2c16mr58803805ab.17.1738246847821;
        Thu, 30 Jan 2025 06:20:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec7469f4f9sm357033173.78.2025.01.30.06.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 06:20:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------cykoxp8vyPWNWzR0jDxpHNTh"
Message-ID: <84e2f49c-47d4-402c-977d-654b4cdd3cbd@kernel.dk>
Date: Thu, 30 Jan 2025 07:20:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rsrc: require cloned buffers to
 share accounting" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, jannh@google.com
Cc: stable@vger.kernel.org
References: <2025013011-scenic-crazed-e3c8@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025013011-scenic-crazed-e3c8@gregkh>

This is a multi-part message in MIME format.
--------------cykoxp8vyPWNWzR0jDxpHNTh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/30/25 4:38 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x 19d340a2988d4f3e673cded9dde405d727d7e248
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025013011-scenic-crazed-e3c8@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Here's a 6.12-stable version of this patch.

-- 
Jens Axboe

--------------cykoxp8vyPWNWzR0jDxpHNTh
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-rsrc-require-cloned-buffers-to-share-accoun.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-rsrc-require-cloned-buffers-to-share-accoun.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2MDVkYzMyMTUyMmY0MzM0ODQ5NzU5ZDk1ODViZWY1NGRjNjA5OTRmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKYW5uIEhvcm4gPGphbm5oQGdvb2dsZS5jb20+CkRh
dGU6IFR1ZSwgMTQgSmFuIDIwMjUgMTg6NDk6MDAgKzAxMDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9yc3JjOiByZXF1aXJlIGNsb25lZCBidWZmZXJzIHRvIHNoYXJlIGFjY291bnRp
bmcKIGNvbnRleHRzCgpDb21taXQgMTlkMzQwYTI5ODhkNGYzZTY3M2NkZWQ5ZGRlNDA1ZDcy
N2Q3ZTI0OCB1cHN0cmVhbS4KCldoZW4gSU9SSU5HX1JFR0lTVEVSX0NMT05FX0JVRkZFUlMg
aXMgdXNlZCB0byBjbG9uZSBidWZmZXJzIGZyb20gdXJpbmcKaW5zdGFuY2UgQSB0byB1cmlu
ZyBpbnN0YW5jZSBCLCB3aGVyZSBBIGFuZCBCIHVzZSBkaWZmZXJlbnQgTU1zIGZvcgphY2Nv
dW50aW5nLCB0aGUgYWNjb3VudGluZyBjYW4gZ28gd3Jvbmc6CklmIHVyaW5nIGluc3RhbmNl
IEEgaXMgY2xvc2VkIGJlZm9yZSB1cmluZyBpbnN0YW5jZSBCLCB0aGUgcGlubmVkIG1lbW9y
eQpjb3VudGVycyBmb3IgdXJpbmcgaW5zdGFuY2UgQiB3aWxsIGJlIGRlY3JlbWVudGVkLCBl
dmVuIHRob3VnaCB0aGUgcGlubmVkCm1lbW9yeSB3YXMgb3JpZ2luYWxseSBhY2NvdW50ZWQg
dGhyb3VnaCB1cmluZyBpbnN0YW5jZSBBOyBzbyB0aGUgTU0gb2YKdXJpbmcgaW5zdGFuY2Ug
QiBjYW4gZW5kIHVwIHdpdGggbmVnYXRpdmUgbG9ja2VkIG1lbW9yeS4KCkNjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnCkNsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9DQUc0
OGV6MXplejRiZGhtZUdMRUZ4dGJGQURZNEN6bjNDVjB1OWRfVE1jYnZSQTAxYmdAbWFpbC5n
bWFpbC5jb20KRml4ZXM6IDdjYzJhNmVhZGNkNyAoImlvX3VyaW5nOiBhZGQgSU9SSU5HX1JF
R0lTVEVSX0NPUFlfQlVGRkVSUyBtZXRob2QiKQpTaWduZWQtb2ZmLWJ5OiBKYW5uIEhvcm4g
PGphbm5oQGdvb2dsZS5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAy
NTAxMTQtdXJpbmctY2hlY2stYWNjb3VudGluZy12MS0xLTQyZTQxNDVhYTc0M0Bnb29nbGUu
Y29tClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBp
b191cmluZy9yc3JjLmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9pb191cmluZy9yc3JjLmMgYi9pb191cmluZy9yc3JjLmMK
aW5kZXggNmYzYjZkZTIzMGJkLi5hNjdiYWUzNTA0MTYgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5n
L3JzcmMuYworKysgYi9pb191cmluZy9yc3JjLmMKQEAgLTExNTMsNiArMTE1MywxMyBAQCBz
dGF0aWMgaW50IGlvX2Nsb25lX2J1ZmZlcnMoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIHN0
cnVjdCBpb19yaW5nX2N0eCAqc3JjX2N0eAogCXN0cnVjdCBpb19yc3JjX2RhdGEgKmRhdGE7
CiAJaW50IGksIHJldCwgbmJ1ZnM7CiAKKwkvKgorCSAqIEFjY291bnRpbmcgc3RhdGUgaXMg
c2hhcmVkIGJldHdlZW4gdGhlIHR3byByaW5nczsgdGhhdCBvbmx5IHdvcmtzIGlmCisJICog
Ym90aCByaW5ncyBhcmUgYWNjb3VudGVkIHRvd2FyZHMgdGhlIHNhbWUgY291bnRlcnMuCisJ
ICovCisJaWYgKGN0eC0+dXNlciAhPSBzcmNfY3R4LT51c2VyIHx8IGN0eC0+bW1fYWNjb3Vu
dCAhPSBzcmNfY3R4LT5tbV9hY2NvdW50KQorCQlyZXR1cm4gLUVJTlZBTDsKKwogCS8qCiAJ
ICogRHJvcCBvdXIgb3duIGxvY2sgaGVyZS4gV2UnbGwgc2V0dXAgdGhlIGRhdGEgd2UgbmVl
ZCBhbmQgcmVmZXJlbmNlCiAJICogdGhlIHNvdXJjZSBidWZmZXJzLCB0aGVuIHJlLWdyYWIs
IGNoZWNrLCBhbmQgYXNzaWduIGF0IHRoZSBlbmQuCi0tIAoyLjQ3LjIKCg==

--------------cykoxp8vyPWNWzR0jDxpHNTh--

