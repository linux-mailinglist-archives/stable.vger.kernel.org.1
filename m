Return-Path: <stable+bounces-158794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F56AEBCD4
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681281C6036C
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A992E9EBB;
	Fri, 27 Jun 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Mxr2ZFjK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24C19A288
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040585; cv=none; b=q+oQzNRvufNzzE+lUN46nE2l08jQlzQl+Ff3vGayy/Jz4jgj3s/NPuyw5UFk13hWkbkG/PW3ZSS3aorJuPJjuQ5bMzoCIEpNNqoLsJGXYXgJwBAjA3luk6S3GksQXO7LebZf00CY6Z7+HW5kwOIOl6BYgoEvXRZs4CZPWkSsYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040585; c=relaxed/simple;
	bh=8L/ePhARqL4vxrdU+wMAz4C0bxA9jzJhG2XvivKTMQU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=d5vcdz+tA6qSI2128YkaeCra1yznPn7ocoKcYctNinoK01su1Ekb56ogB4wljLGb4gV5NKNB+teIqHX6tVHhTwSw+T/LLBwFnDIJxybg+OdkRTQULa6hzorKI2r1TSYcR2dSbC95bn7G5q+SRFGux0+Z3BpHuxf3OUDtsXeCQXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Mxr2ZFjK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31befde0a0so15694a12.0
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751040581; x=1751645381; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwzWg5z2ZBWbe8ktd5oHBWBcZbCtRJ/os6dMwktY4As=;
        b=Mxr2ZFjKVIjajusIdS1gsa/0eddaqN3y4DfcU6kWzWkVDmFn6KGAeQuT4ss3Z2l3+V
         2UFHsqYI9YF9ZNQg66XQJp5jGyb0il7VdlHU8wDwVuvWBCFV19B4GGxhNT1D6jUwQ6Iu
         vcdxnlZF5wBIocrYY47wG8Yyj7MlzsVW8wZ3IEMH/1wzYiFK3kK/WOyo9rqnptOieX64
         p2Pjsq7FvzBj3d5xO0Kehtqk5OwAIhcTFw3v7VqFEZ0CCm+yc7HEwW/FxedT17kUOJkU
         oG7gdg9QTu6RlnkSrsh7oiMo1lkilC1p8I9Lr3f7Dc245ZkVq0XDqq4DMPkhsWvp5R35
         ifFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751040581; x=1751645381;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OwzWg5z2ZBWbe8ktd5oHBWBcZbCtRJ/os6dMwktY4As=;
        b=kH9N3kCErbx9ltMSG4xczsDQrZw9a86iwBtd2OL4KKOvyf+QgVukC0u639EL/o+aSr
         F5MQ638AE8VEux9OAgB6kzdvF5eLTiw81ZcXLtkM6WKyG5fXH8h8j1MkdgxqGNa2Q3ij
         yzY7LjoEx7e3Z36HyloWFBRi2Xz0yeRhX8T8duEZxTqgcyp6HP455eVGvySHa9tQKG11
         q7TJDOExzh3az7ZFHlk9YpXcy9ryU+bOLyzY3y+yILVJ3g6OkPgJ8UTFtbnKAfOUaScX
         DbazwpVYIQEidDmyKQwsNz5OedqaZ2ppqC/PTu/8AuSikbFeiRANEM3quyZY43mZBL2K
         3D3A==
X-Gm-Message-State: AOJu0YywphgwNXB/Ynt4b+J6oYEB7tA21Ao9QY7Pmm/iw76CkoLO4LQl
	u44UND1zWiGE1f1MLKuTjZRABM5gUrCAVd7KVHiU3Xm8TtFH9ALTXQqVm9hOrej1d9jy88ZWdEU
	nzl4V
X-Gm-Gg: ASbGnctK1yDwz42AB83kdNgC67H0Ogi932iyo1hkAdsmf6/iZeRAbv8ok+KCoZ5hdyo
	lKdTaQxDRUELgk0S4oMrfgQLhJeWcmhjo7RnVGNrsrJSkh3dSl3O3DeT4UMZKQMDp3PPBPSZV+k
	omUfRimiDmYD5WWSaiNeKMANn1yAT1utV8KAyUoUcn99cGlltzYj2KJQPTqwnU6dKJAdrVMX7eo
	qSHLYOXTZiWjqtBANuziyTuuVKx5WmzEE9IGhMVjrpdw42OWjUWgXhMWfY1dKb/PSlZKrIkgl46
	KiLEKNPnlRwbVam5k6hAm3lS8gVQKspImDkDtQ3f0Y5Khvl9am6v+kmeKQ==
X-Google-Smtp-Source: AGHT+IEqF2TBfkpALBysKmwPjYGaOydHL1ut0OGJvn1lLp8KNN5kwjV+UNsOxNoUs4LttlTbb36gIQ==
X-Received: by 2002:a17:90b:4e8f:b0:313:fab4:1df6 with SMTP id 98e67ed59e1d1-318c9280acfmr4915050a91.32.1751040580551;
        Fri, 27 Jun 2025 09:09:40 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13a509asm2700523a91.20.2025.06.27.09.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:09:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------UceZiyzMtCUo5NtCekGsqgJa"
Message-ID: <5d8cb207-7c78-4840-98cc-d8ef7bf81034@kernel.dk>
Date: Fri, 27 Jun 2025 10:09:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: account ring io_buffer_list
 memory" failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com
Cc: stable@vger.kernel.org
References: <2025062043-header-audio-50d2@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025062043-header-audio-50d2@gregkh>

This is a multi-part message in MIME format.
--------------UceZiyzMtCUo5NtCekGsqgJa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 11:40 PM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 475a8d30371604a6363da8e304a608a5959afc40
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062043-header-audio-50d2@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Here's a 6.1-stable variant.

-- 
Jens Axboe
--------------UceZiyzMtCUo5NtCekGsqgJa
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-kbuf-account-ring-io_buffer_list-memory.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-kbuf-account-ring-io_buffer_list-memory.patch"
Content-Transfer-Encoding: base64

RnJvbSBhYjFmYjQyZWJmMWNjZjMzZWQ4YzRkNGNmZDcwNWQyZmY4YmNmNzY2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogVHVlLCAxMyBNYXkgMjAyNSAxODoyNjo0NiArMDEwMApTdWJqZWN0
OiBbUEFUQ0ggMS8yXSBpb191cmluZy9rYnVmOiBhY2NvdW50IHJpbmcgaW9fYnVmZmVyX2xp
c3QgbWVtb3J5CgpDb21taXQgNDc1YThkMzAzNzE2MDRhNjM2M2RhOGUzMDRhNjA4YTU5NTlh
ZmM0MCB1cHN0cmVhbS4KCkZvbGxvdyB0aGUgbm9uLXJpbmdlZCBwYnVmIHN0cnVjdCBpb19i
dWZmZXJfbGlzdCBhbGxvY2F0aW9ucyBhbmQgYWNjb3VudAppdCBhZ2FpbnN0IHRoZSBtZW1j
Zy4gVGhlcmUgaXMgbG93IGNoYW5jZSBvZiB0aGF0IGJlaW5nIGFuIGFjdHVhbApwcm9ibGVt
IGFzIHJpbmcgcHJvdmlkZWQgYnVmZmVyIHNob3VsZCBlaXRoZXIgcGluIHVzZXIgbWVtb3J5
IG9yCmFsbG9jYXRlIGl0LCB3aGljaCBpcyBhbHJlYWR5IGFjY291bnRlZC4KCkNjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnICMgNi4xClNpZ25lZC1vZmYtYnk6IFBhdmVsIEJlZ3Vua292
IDxhc21sLnNpbGVuY2VAZ21haWwuY29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzM5ODUyMThiNTBkMzQxMjczY2FmZmY3MjM0ZTFhN2U2ZDBkYjk4MDguMTc0NzE1MDQ5
MC5naXQuYXNtbC5zaWxlbmNlQGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcva2J1Zi5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
aW9fdXJpbmcva2J1Zi5jIGIvaW9fdXJpbmcva2J1Zi5jCmluZGV4IDE0N2FkYTJjZTc0Ny4u
ZDE4ZmUzOTk2ZGRiIDEwMDY0NAotLS0gYS9pb191cmluZy9rYnVmLmMKKysrIGIvaW9fdXJp
bmcva2J1Zi5jCkBAIC01MTAsNyArNTEwLDcgQEAgaW50IGlvX3JlZ2lzdGVyX3BidWZfcmlu
ZyhzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgdm9pZCBfX3VzZXIgKmFyZykKIAkJaWYgKGJs
LT5idWZfbnJfcGFnZXMgfHwgIWxpc3RfZW1wdHkoJmJsLT5idWZfbGlzdCkpCiAJCQlyZXR1
cm4gLUVFWElTVDsKIAl9IGVsc2UgewotCQlmcmVlX2JsID0gYmwgPSBremFsbG9jKHNpemVv
ZigqYmwpLCBHRlBfS0VSTkVMKTsKKwkJZnJlZV9ibCA9IGJsID0ga3phbGxvYyhzaXplb2Yo
KmJsKSwgR0ZQX0tFUk5FTF9BQ0NPVU5UKTsKIAkJaWYgKCFibCkKIAkJCXJldHVybiAtRU5P
TUVNOwogCX0KLS0gCjIuNTAuMAoK

--------------UceZiyzMtCUo5NtCekGsqgJa--

