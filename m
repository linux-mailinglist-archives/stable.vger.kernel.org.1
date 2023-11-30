Return-Path: <stable+bounces-3232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E6C7FF1F2
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 15:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24772B214CF
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9436F5100C;
	Thu, 30 Nov 2023 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RiJYYlkN"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F179BD
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 06:33:08 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b05e65e784so2403339f.1
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 06:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701354787; x=1701959587; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJPRP/rGos1L8yAQoqnTYka6cOglpc8Neu8PdeAkang=;
        b=RiJYYlkNbu7FAYLfWB7dMLARbr3S0mpfu4lIMAMaJrL94acU4UPUE5ZUlO9pjth/WV
         vO4sxqWTA8z5U51RHc3DGMuXPhFWIT0hM/5rQBYdF4TeCjkXlBlu9JpK2iah1haQEvFW
         vvIQrbY0EKmNh5fBQBuXQD0cnexFs0/RnhMDE1uFlnAWgHB9pjpu3T/j/oytseysjPkC
         A7SLxPnD/bQK+l7wujBD1nok62wXEry85FsBN/tj4JVKcwqyBBIpa0gnwzANsgab9Xe7
         nW3fyLzwqr0WjMcbQZhZ1A/+Zi+r2CxEvG6CLFzGl8RxABIu2LCUtHF0YtrAOQCVgrZL
         reZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701354787; x=1701959587;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pJPRP/rGos1L8yAQoqnTYka6cOglpc8Neu8PdeAkang=;
        b=F9FnJ9fKDDY5tKDg73DQ5oC0+Mi9okSkvKPXc0tIK4fCjhCKKx3gU1NLgh8ybYqzAg
         gHLi6tHDva3wQz0X4ncaWQas2trbAMCn1yXd2Fv96V6ZZncpEsLu0kFL26Fuszvh3M4K
         +d+kX8W6X1/9JQTlbSLPSTJtWWpaoia3RqfJaMPFf2HjUPc50Ltk/g7aT8TyBIhl2Sng
         PCn7GWg34BlQK6zJ7T0H/4UvOyffS5OoqhqMjOHjh3au9EDZEa+t0FlNAvQceyd7nh/o
         IZQ43bnO0dSVGEaA1nNp54pos4PktMLZdwbO0GAzZSgtjNAm/EaLt/U/Px5o6EQlwhI7
         akGw==
X-Gm-Message-State: AOJu0Yz3u0ddqY7CKMeW0Zre5SEcycq0KT/VFKzmNRaVNJlImP6ptKb2
	htg7zgo9V4b/nijyPE4q6cTenw==
X-Google-Smtp-Source: AGHT+IEZQ/+5iRwWyhA7efPPQaU+ITkjQSP7+SJEbgZsbbFVUxtSjiCqrkwupx2YuRk+lEqK4RUEwA==
X-Received: by 2002:a92:ce8c:0:b0:35c:7b32:241f with SMTP id r12-20020a92ce8c000000b0035c7b32241fmr16730117ilo.2.1701354787469;
        Thu, 30 Nov 2023 06:33:07 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y19-20020a056e02129300b0035cc242a29bsm395254ilq.48.2023.11.30.06.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 06:33:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------6VqPbNG80nGeyhJbzjiv7nPY"
Message-ID: <1325a4a7-15b3-4e3b-af51-c2c660ab8456@kernel.dk>
Date: Thu, 30 Nov 2023 07:33:06 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: fix off-by one bvec index"
 failed to apply to 6.1-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, kbusch@kernel.org
Cc: stable@vger.kernel.org
References: <2023113023-heaviness-easel-554e@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023113023-heaviness-easel-554e@gregkh>

This is a multi-part message in MIME format.
--------------6VqPbNG80nGeyhJbzjiv7nPY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/23 7:31 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.

Already tested these, here's the 6.1 variant.

-- 
Jens Axboe

--------------6VqPbNG80nGeyhJbzjiv7nPY
Content-Type: text/x-patch; charset=UTF-8;
 name="6.1-io_uring-fix-off-by-one-bvec-index.patch"
Content-Disposition: attachment;
 filename="6.1-io_uring-fix-off-by-one-bvec-index.patch"
Content-Transfer-Encoding: base64

RnJvbSAwMTYzNjAyOTc3NWJjZjAyM2RhNzNhNmMwOTRhMzcxYTA0MDhhZTBlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+
CkRhdGU6IE1vbiwgMjAgTm92IDIwMjMgMTQ6MTg6MzEgLTA4MDAKU3ViamVjdDogW1BBVENI
XSBpb191cmluZzogZml4IG9mZi1ieSBvbmUgYnZlYyBpbmRleAoKY29tbWl0IGQ2ZmVmMzRl
ZTRkMTAyYmU0NDgxNDZmMjRjYWY5NmQ3YjRhMDU0MDEgdXBzdHJlYW0uCgpJZiB0aGUgb2Zm
c2V0IGVxdWFscyB0aGUgYnZfbGVuIG9mIHRoZSBmaXJzdCByZWdpc3RlcmVkIGJ2ZWMsIHRo
ZW4gdGhlCnJlcXVlc3QgZG9lcyBub3QgaW5jbHVkZSBhbnkgb2YgdGhhdCBmaXJzdCBidmVj
LiBTa2lwIGl0IHNvIHRoYXQgZHJpdmVycwpkb24ndCBoYXZlIHRvIGRlYWwgd2l0aCBhIHpl
cm8gbGVuZ3RoIGJ2ZWMsIHdoaWNoIHdhcyBvYnNlcnZlZCB0byBicmVhawpOVk1lJ3MgUFJQ
IGxpc3QgY3JlYXRpb24uCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogYmQx
MWIzYTM5MWUzICgiaW9fdXJpbmc6IGRvbid0IHVzZSBpb3ZfaXRlcl9hZHZhbmNlKCkgZm9y
IGZpeGVkIGJ1ZmZlcnMiKQpTaWduZWQtb2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMzExMjAyMjE4
MzEuMjY0NjQ2MC0xLWtidXNjaEBtZXRhLmNvbQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvcnNyYy5jIHwgMiArLQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
aW9fdXJpbmcvcnNyYy5jIGIvaW9fdXJpbmcvcnNyYy5jCmluZGV4IGNjZTk1MTY0MjA0Zi4u
N2FkYTAzMzliMzg3IDEwMDY0NAotLS0gYS9pb191cmluZy9yc3JjLmMKKysrIGIvaW9fdXJp
bmcvcnNyYy5jCkBAIC0xMzUxLDcgKzEzNTEsNyBAQCBpbnQgaW9faW1wb3J0X2ZpeGVkKGlu
dCBkZGlyLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsCiAJCSAqLwogCQljb25zdCBzdHJ1Y3Qg
YmlvX3ZlYyAqYnZlYyA9IGltdS0+YnZlYzsKIAotCQlpZiAob2Zmc2V0IDw9IGJ2ZWMtPmJ2
X2xlbikgeworCQlpZiAob2Zmc2V0IDwgYnZlYy0+YnZfbGVuKSB7CiAJCQlpb3ZfaXRlcl9h
ZHZhbmNlKGl0ZXIsIG9mZnNldCk7CiAJCX0gZWxzZSB7CiAJCQl1bnNpZ25lZCBsb25nIHNl
Z19za2lwOwotLSAKMi40Mi4wCgo=

--------------6VqPbNG80nGeyhJbzjiv7nPY--

