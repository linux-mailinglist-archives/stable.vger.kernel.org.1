Return-Path: <stable+bounces-158796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A37AEBCE7
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491B2646D67
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328E2E9749;
	Fri, 27 Jun 2025 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z3uO6E4R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9976F2E92CA
	for <stable@vger.kernel.org>; Fri, 27 Jun 2025 16:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751040847; cv=none; b=IcrzwbnnGOoX4AfWn9+GdfaLuqCV60jxp1vgiZa3QDmPfyDCLveWmZMVPoCAHy41XF3hS5/OvFi13ftiojfVgosRgv4vU6ZN7rFv+24Sga6aEDs8/QHv7ZaLG8ap8tWk+0lnDx7N9nrbh0hx3Ah4fhf+GgUnV7c2we6j1wZQsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751040847; c=relaxed/simple;
	bh=wFz2HEByO3qqoQd/YFhLSlqELBVaa+7dpV7PgF2pusA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Xt15vj59uu3guDH7p/qoFaaCRm1Gm3X3xST6inj7MxhDI5oPqmZO0jPjInyk8eeRFfunVLsdZJ2RsJ+u69JjQEcjgICxBWmU7hUtEib+Cv6kwmLHqP3+RlXnZhV+/6T1LpLZKljAYGVDQJ7ZfxBKmhpBWaA3ZM57NDHWHFWy3uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z3uO6E4R; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3156588b3a.2
        for <stable@vger.kernel.org>; Fri, 27 Jun 2025 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751040845; x=1751645645; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XH0ss9r0zvMwN14w4ioi3gpI5AopWMXnld3bFr2y9i4=;
        b=Z3uO6E4RJV0KaAGeRjBhv4yKepwuh3XDwAJC/mM44eWlhInrbW00hDuqvXCApKQZkL
         RJISPXLcLmABe6aAdSYl1lxP2w7J/L35ynTLe7zMEK9oQirEGwhoIpjA/f2GVD7wcCON
         QlnXNkoQWg44nA6Wzkm47aw215e+5CCnHTKBWBvyAfUWLyzn1MuGOEtCqVLtYzknKy5i
         fuON4Lg1GlFxtjgp6/yxzME/RSZpdU3o7OmNAIcKZHOVxLhOREKja11WbFaIZqZ/v7GI
         ZyJdc0EzDDpIHr0W0hG4WdhskcFJvWRPsuiHb1laS3s6+DioXpBsCCq0bAXwnhP77wK8
         QD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751040845; x=1751645645;
        h=in-reply-to:content-language:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XH0ss9r0zvMwN14w4ioi3gpI5AopWMXnld3bFr2y9i4=;
        b=O4yEhwB8FMMS3hjNc0zkLwUrZoRCY131c3X0Oe4ylbB2rgzwkjDi6BbqBROxucdCUT
         YwsXMkhS45c1Cef/XlQOOKcoTGGHhZoqUARGNezrASfPBJ6xHSzINBG0qVqpdrapbunh
         dtvYqg6QJ9OFDvZIwq4VQQ36YJ3eG+4WnppCjb3aQ9Q1YH5I58a797aV0I657gbRxnJK
         bYTdmMvKDDRoWOxd+duLNKyVLMGGDi2jNDQvm+Y8aft5eopYr8i+Nyk+FqTKrC9vAm/5
         djWs9vGU3NMZBNMmvd9BZBqgj6DL2156bzJ3A9osobxrbnqRgfILFkxpllih2tgkHCgx
         siJQ==
X-Gm-Message-State: AOJu0Ywi74R391kha8Ef64TOZtMSY9GQbXIIxaS60lm3F9BZcbsLYLhj
	l6GMnEd/2uTIGN27CkGyLRG606FyAS16POvds8/4LTTFiHX5t0m+38CZhRPRpxK9M4Q=
X-Gm-Gg: ASbGncsRLBIs2Qn33VhHlmjcHoyQ9ZnQpX2NvH1NBaTdGwuklqE9u+Gf+mvZH3Pkd6u
	KBsCxOkZgIlTaD7gQFKKGd0CdlLdYMsn6udxNsDk95e51OJ7c5PzOREawxVBZtkkCi/6BS0A12x
	2hakns2bqL/rGnF9F9lwXqJvlB8XvLZ4yr00PiKmhrFnYsQTtoSmlaSNw6/ggoaiFu7qjermcBb
	f0v7kf4C0oKK5/M8l3D6gpYHejlkYX74f0EQKHB1dyCq3BMyMjyCGc8Eg3451ycYumaEOz7sew+
	8C3OP329WDUMWtVexgmL2qGGMjCGw7bht1G4nxzQ6SVUq40zUQAyqtncAg==
X-Google-Smtp-Source: AGHT+IEahASsvWdsyuCr03RG5x+KGTEapiblMcDmqIs2ariAYlIjrbPUxchtDJrE+jkAcgzcFEGpKw==
X-Received: by 2002:a17:902:ea0e:b0:21f:617a:f1b2 with SMTP id d9443c01a7336-23ac46580damr56259415ad.46.1751040844818;
        Fri, 27 Jun 2025 09:14:04 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c5bc7sm19077405ad.221.2025.06.27.09.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:14:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------U6R26DQ1ldi1SRR26EjZvnWK"
Message-ID: <e7a573fc-5d40-45b6-a38a-38d188f9bfbf@kernel.dk>
Date: Fri, 27 Jun 2025 10:14:03 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/zcrx: fix area release on
 registration failure" failed to apply to 6.15-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com
Cc: stable@vger.kernel.org
References: <2025062018-ahead-armory-59ac@gregkh>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <2025062018-ahead-armory-59ac@gregkh>

This is a multi-part message in MIME format.
--------------U6R26DQ1ldi1SRR26EjZvnWK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 4:34 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 0ec33c81d9c7342f03864101ddb2e717a0cce03e
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062018-ahead-armory-59ac@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Here's one for 6.15-stable.

-- 
Jens Axboe
--------------U6R26DQ1ldi1SRR26EjZvnWK
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-zcrx-fix-area-release-on-registration-failu.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-zcrx-fix-area-release-on-registration-failu.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA0YTFiMGYxYjkwZDE0ZTY5NDMwYzVhYTc2ODI5ODhkMzVlZWI4YjY5IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogVHVlLCAyNyBNYXkgMjAyNSAxODowNzozMyArMDEwMApTdWJqZWN0
OiBbUEFUQ0hdIGlvX3VyaW5nL3pjcng6IGZpeCBhcmVhIHJlbGVhc2Ugb24gcmVnaXN0cmF0
aW9uIGZhaWx1cmUKCkNvbW1pdCAwZWMzM2M4MWQ5YzczNDJmMDM4NjQxMDFkZGIyZTcxN2Ew
Y2NlMDNlIHVwc3RyZWFtLgoKT24gYXJlYSByZWdpc3RyYXRpb24gZmFpbHVyZSB0aGVyZSBt
aWdodCBiZSBubyBpZnEgc2V0IGFuZCBpdCdzIG5vdCBzYWZlCnRvIGFjY2VzcyBhcmVhLT5p
ZnEgaW4gdGhlIHJlbGVhc2UgcGF0aCB3aXRob3V0IGNoZWNraW5nIGl0IGZpcnN0LgoKQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IGYxMmVjZjVlMWM1ZWMgKCJpb191cmlu
Zy96Y3J4OiBmaXggbGF0ZSBkbWEgdW5tYXAgZm9yIGEgZGVhZCBkZXYiKQpTaWduZWQtb2Zm
LWJ5OiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdtYWlsLmNvbT4KTGluazogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci9iYzAyODc4Njc4YTVmZWMyOGJjNzdkMzMzNTVjZGJh
NzM1NDE4NDg0LjE3NDgzNjU2NDAuZ2l0LmFzbWwuc2lsZW5jZUBnbWFpbC5jb20KU2lnbmVk
LW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGlvX3VyaW5nL3pj
cnguYyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvemNyeC5jIGIvaW9fdXJpbmcvemNyeC5j
CmluZGV4IGZlODY2MDZiOWYzMC4uNzEwMzZkMzFiMzBmIDEwMDY0NAotLS0gYS9pb191cmlu
Zy96Y3J4LmMKKysrIGIvaW9fdXJpbmcvemNyeC5jCkBAIC0xODcsNyArMTg3LDggQEAgc3Rh
dGljIHZvaWQgaW9fZnJlZV9yYnVmX3Jpbmcoc3RydWN0IGlvX3pjcnhfaWZxICppZnEpCiAK
IHN0YXRpYyB2b2lkIGlvX3pjcnhfZnJlZV9hcmVhKHN0cnVjdCBpb196Y3J4X2FyZWEgKmFy
ZWEpCiB7Ci0JaW9femNyeF91bm1hcF9hcmVhKGFyZWEtPmlmcSwgYXJlYSk7CisJaWYgKGFy
ZWEtPmlmcSkKKwkJaW9femNyeF91bm1hcF9hcmVhKGFyZWEtPmlmcSwgYXJlYSk7CiAKIAlr
dmZyZWUoYXJlYS0+ZnJlZWxpc3QpOwogCWt2ZnJlZShhcmVhLT5uaWEubmlvdnMpOwotLSAK
Mi41MC4wCgo=

--------------U6R26DQ1ldi1SRR26EjZvnWK--

