Return-Path: <stable+bounces-169740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083AB2832F
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9A63A2B57
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED3B21256E;
	Fri, 15 Aug 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hXbNzO6p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A0191
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272818; cv=none; b=IXBAZFzAs3W0oriUIkTI9J1/L7EWHViqFTRkLUdTTUJ68rMak0T0q6x8CmFukaT7+kcz5teMhizZG/9DVM3yC6FjHpBcwCmYbNPjk+Q7CKb2tS9inPCaaWSkSnOnLU+toarcgGao6WwPtP4gFaqIXfgPpHNRJPDKMPYuUhxBfMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272818; c=relaxed/simple;
	bh=qd8UOMTkIyY28iwecJuxTfWxlOETGY4x6ki7aXw7ork=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=cYRozTl5M4yKQ+F/uITjyB2Rco05Vy39ibMsZe4q0XKXG2jQEg/ISh0hHomF9+zyLYXL3HbVT1Dx7krxKCScBQzmjRkBvmYJGHXXlmZtRM6HRcrevRDXqWdWbqDImNJxK+gv38hzZp5dCsnuWLkuV9a/Ta+AazTm2lRATkA3LiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hXbNzO6p; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4717390ad7so1468868a12.1
        for <stable@vger.kernel.org>; Fri, 15 Aug 2025 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755272815; x=1755877615; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GROwf4FeMzDrHrLy+bAgNxjBlwUc3Gz6wG2Lkw7pL4=;
        b=hXbNzO6pyQOT/kvrN3PKf/2N6gmnzCysQbsAtBYxEzNNigATfwEkx/eEZpIe+kPsg4
         2H9KfCStH1++w2tj6NEONxUNgEXBUDJnhuuDiHRt4ERzBcVBfrndBYWq15lHPvzkQ/yT
         qON/QuGwHGeE0MoAdiVnxj7G1lJc7cpvp+DoGzSNMdAEK/4bJMdrzr1iyqZJAqL34QMu
         xQw1Sg/TMurSkMUCV5MsooLhca1j48MWyBYmJf4s/kWWJhIloz0ofAf8c4B9UvstbVMA
         +cEg3QKYPtb3HwbkTjiU9aqr786Jrfpup5lhaEMwMQxl7Knc9fvORzfeiGQziUs9Vvv2
         Z/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272815; x=1755877615;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9GROwf4FeMzDrHrLy+bAgNxjBlwUc3Gz6wG2Lkw7pL4=;
        b=gumcqZLO0Ei9wjgKjOToFCVQiVMtI2fEZEAsZnNy+K6hxWTyCSkTv2uI8AqqYwxCIJ
         eIZqO7Ch4GZowgahonX28dBgJ4MVYboNykobqau8wPqU3XcU4Mu93+PjJETwlHwM+qTH
         KjNY3m2CeNErF/VBxGeP07PHHIJFRgeZ8P4VJK/iPO1ptKNbaEnvYIoQdcWqw4YFaw4a
         Vy39Rdw6c00Tb2NmIAdx0uIhkzQ1IoWWztF6tZXmBiFz7OvDIzCKDLIscMFAT10NzCN2
         HwKO+e//5I8tNJxJimBzkIobentE451XiQ3mMoHp2XURQaA+QvdXPAxsfgFdgtr/6inl
         eSLQ==
X-Gm-Message-State: AOJu0YzMtZgVQ+Xy/Miuvju2Wr6k/CAHHncwEBRqya5T/Fb55fV+zlhj
	xSQy3Nzg5oi9eFp7/MZY1EvlNrLkzZYvu3yBoyqJ3NmMN1+Vw/TD3BeUlsEUidwgq/Ru5fv7u2q
	zLof3
X-Gm-Gg: ASbGncvZKVVlGroTlIlS+Fwkj+mjbTo6S6vNQ8Je7Io0ScbyGKMEHwX0Rlq8QX+xaw9
	rUJN+EOAZo8LWfVyrXmsRe4n84EedQ+VAAmpDr3K4vV50Ibqcor5j0JQDWw/3ZTLbdN6n3TDXKm
	CU0MWLQWHZkQT8EvrgsaXX0D3dDcdgtcLGcCHmYrZ4oJ5d6TM5gGDUcEr33v/6hT4xyq8UcFctF
	5ErR5iOEayLDBDl/IVOY2yShySTvO/I4tY6aOEQjf2JeI5pmRfqbRThpEQmwvOLuS2duGza2Lyr
	vVkkLZBJJ+K2oXJGNNQ5nuQtZLlb8hOFYYuXTvVt5/BByJ2/4fKzuMoEigvSCZmqMN41cypvMES
	uAqait0TXweNycrfRA9ptVEtXMYaosQ==
X-Google-Smtp-Source: AGHT+IFTmujVh2XRNYVJxm6hwhESo/VJa5ee28cxq7eRF+xGqCpGYfno75/6SRJKzJtv3gYnxH5z+Q==
X-Received: by 2002:a17:903:2346:b0:23f:aec2:c880 with SMTP id d9443c01a7336-2446d744172mr35037875ad.19.1755272815014;
        Fri, 15 Aug 2025 08:46:55 -0700 (PDT)
Received: from [10.2.2.247] ([50.196.182.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f116sm16633055ad.158.2025.08.15.08.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:46:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------SA703zAeiUEZz8TH7QyMw7PX"
Message-ID: <15e7ab1a-46d9-4d3d-b48e-3e10e570829e@kernel.dk>
Date: Fri, 15 Aug 2025 09:46:53 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: commit partial buffers on
 retry" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org, superman.xpt@gmail.com
Cc: stable@vger.kernel.org
References: <2025081549-shorter-borrower-941d@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025081549-shorter-borrower-941d@gregkh>

This is a multi-part message in MIME format.
--------------SA703zAeiUEZz8TH7QyMw7PX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 9:26 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x 41b70df5b38bc80967d2e0ed55cc3c3896bba781
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081549-shorter-borrower-941d@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Here's one for 6.6-stable.

-- 
Jens Axboe

--------------SA703zAeiUEZz8TH7QyMw7PX
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-net-commit-partial-buffers-on-retry.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-net-commit-partial-buffers-on-retry.patch"
Content-Transfer-Encoding: base64

RnJvbSBjMTZjYjRlMmE0YjFhNDg3Y2E3ZmVhZTU5MzFkZmIyMmFjNDk1Yjc2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMTIgQXVnIDIwMjUgMDg6MzA6MTEgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9uZXQ6IGNvbW1pdCBwYXJ0aWFsIGJ1ZmZlcnMgb24gcmV0cnkKCkNvbW1pdCBh
NmRmZGE3ZGE1YzY1YjI4MmMxNjYzMzI2YmUxNmU1N2FlYzNkMWJkIHVwc3RyZWFtLgoKUmlu
ZyBwcm92aWRlZCBidWZmZXJzIGFyZSBwb3RlbnRpYWxseSBvbmx5IHZhbGlkIHdpdGhpbiB0
aGUgc2luZ2xlCmV4ZWN1dGlvbiBjb250ZXh0IGluIHdoaWNoIHRoZXkgd2VyZSBhY3F1aXJl
ZC4gaW9fdXJpbmcgZGVhbHMgd2l0aCB0aGlzCmFuZCBpbnZhbGlkYXRlcyB0aGVtIG9uIHJl
dHJ5LiBCdXQgb24gdGhlIG5ldHdvcmtpbmcgc2lkZSwgaWYKTVNHX1dBSVRBTEwgaXMgc2V0
LCBvciBpZiB0aGUgc29ja2V0IGlzIG9mIHRoZSBzdHJlYW1pbmcgdHlwZSBhbmQgdG9vCmxp
dHRsZSB3YXMgcHJvY2Vzc2VkLCB0aGVuIGl0IHdpbGwgaGFuZyBvbiB0byB0aGUgYnVmZmVy
IHJhdGhlciB0aGFuCnJlY3ljbGUgb3IgY29tbWl0IGl0LiBUaGlzIGlzIHByb2JsZW1hdGlj
IGZvciB0d28gcmVhc29uczoKCjEpIElmIHNvbWVvbmUgdW5yZWdpc3RlcnMgdGhlIHByb3Zp
ZGVkIGJ1ZmZlciByaW5nIGJlZm9yZSBhIGxhdGVyIHJldHJ5LAogICB0aGVuIHRoZSByZXEt
PmJ1Zl9saXN0IHdpbGwgbm8gbG9uZ2VyIGJlIHZhbGlkLgoKMikgSWYgbXVsdGlwbGUgc29j
a2VycyBhcmUgdXNpbmcgdGhlIHNhbWUgYnVmZmVyIGdyb3VwLCB0aGVuIG11bHRpcGxlCiAg
IHJlY2VpdmVzIGNhbiBjb25zdW1lIHRoZSBzYW1lIG1lbW9yeS4gVGhpcyBjYW4gY2F1c2Ug
ZGF0YSBjb3JydXB0aW9uCiAgIGluIHRoZSBhcHBsaWNhdGlvbiwgYXMgZWl0aGVyIHJlY2Vp
dmUgY291bGQgbGFuZCBpbiB0aGUgc2FtZQogICB1c2Vyc3BhY2UgYnVmZmVyLgoKRml4IHRo
aXMgYnkgZGlzYWxsb3dpbmcgcGFydGlhbCByZXRyaWVzIGZyb20gcGlubmluZyBhIHByb3Zp
ZGVkIGJ1ZmZlcgphY3Jvc3MgbXVsdGlwbGUgZXhlY3V0aW9ucywgaWYgcmluZyBwcm92aWRl
ZCBidWZmZXJzIGFyZSB1c2VkLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKUmVwb3J0
ZWQtYnk6IHB0IHggPHN1cGVybWFuLnhwdEBnbWFpbC5jb20+CkZpeGVzOiBjNTZlMDIyYzBh
MjcgKCJpb191cmluZzogYWRkIHN1cHBvcnQgZm9yIHVzZXIgbWFwcGVkIHByb3ZpZGVkIGJ1
ZmZlciByaW5nIikKU2lnbmVkLW9mZi1ieTogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRr
PgotLS0KIGlvX3VyaW5nL25ldC5jIHwgMTkgKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvaW9fdXJpbmcvbmV0LmMgYi9pb191cmluZy9uZXQuYwppbmRleCBlNDU1ZjA1MWU2MmUu
LmU3ZjhhNzllMDQ5YyAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvbmV0LmMKKysrIGIvaW9fdXJp
bmcvbmV0LmMKQEAgLTM1MSw2ICszNTEsMTMgQEAgc3RhdGljIGludCBpb19zZXR1cF9hc3lu
Y19hZGRyKHN0cnVjdCBpb19raW9jYiAqcmVxLAogCXJldHVybiAtRUFHQUlOOwogfQogCitz
dGF0aWMgdm9pZCBpb19uZXRfa2J1Zl9yZWN5bGUoc3RydWN0IGlvX2tpb2NiICpyZXEpCit7
CisJcmVxLT5mbGFncyB8PSBSRVFfRl9QQVJUSUFMX0lPOworCWlmIChyZXEtPmZsYWdzICYg
UkVRX0ZfQlVGRkVSX1JJTkcpCisJCWlvX2tidWZfcmVjeWNsZV9yaW5nKHJlcSk7Cit9CisK
IGludCBpb19zZW5kbXNnX3ByZXBfYXN5bmMoc3RydWN0IGlvX2tpb2NiICpyZXEpCiB7CiAJ
aW50IHJldDsKQEAgLTQ0Miw3ICs0NDksNyBAQCBpbnQgaW9fc2VuZG1zZyhzdHJ1Y3QgaW9f
a2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQogCQkJa21zZy0+bXNnLm1z
Z19jb250cm9sbGVuID0gMDsKIAkJCWttc2ctPm1zZy5tc2dfY29udHJvbCA9IE5VTEw7CiAJ
CQlzci0+ZG9uZV9pbyArPSByZXQ7Ci0JCQlyZXEtPmZsYWdzIHw9IFJFUV9GX1BBUlRJQUxf
SU87CisJCQlpb19uZXRfa2J1Zl9yZWN5bGUocmVxKTsKIAkJCXJldHVybiBpb19zZXR1cF9h
c3luY19tc2cocmVxLCBrbXNnLCBpc3N1ZV9mbGFncyk7CiAJCX0KIAkJaWYgKHJldCA9PSAt
RVJFU1RBUlRTWVMpCkBAIC01MjEsNyArNTI4LDcgQEAgaW50IGlvX3NlbmQoc3RydWN0IGlv
X2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAkJCXNyLT5sZW4gLT0g
cmV0OwogCQkJc3ItPmJ1ZiArPSByZXQ7CiAJCQlzci0+ZG9uZV9pbyArPSByZXQ7Ci0JCQly
ZXEtPmZsYWdzIHw9IFJFUV9GX1BBUlRJQUxfSU87CisJCQlpb19uZXRfa2J1Zl9yZWN5bGUo
cmVxKTsKIAkJCXJldHVybiBpb19zZXR1cF9hc3luY19hZGRyKHJlcSwgJl9fYWRkcmVzcywg
aXNzdWVfZmxhZ3MpOwogCQl9CiAJCWlmIChyZXQgPT0gLUVSRVNUQVJUU1lTKQpAQCAtODkx
LDcgKzg5OCw3IEBAIGludCBpb19yZWN2bXNnKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNp
Z25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAJCX0KIAkJaWYgKHJldCA+IDAgJiYgaW9fbmV0X3Jl
dHJ5KHNvY2ssIGZsYWdzKSkgewogCQkJc3ItPmRvbmVfaW8gKz0gcmV0OwotCQkJcmVxLT5m
bGFncyB8PSBSRVFfRl9QQVJUSUFMX0lPOworCQkJaW9fbmV0X2tidWZfcmVjeWxlKHJlcSk7
CiAJCQlyZXR1cm4gaW9fc2V0dXBfYXN5bmNfbXNnKHJlcSwga21zZywgaXNzdWVfZmxhZ3Mp
OwogCQl9CiAJCWlmIChyZXQgPT0gLUVSRVNUQVJUU1lTKQpAQCAtOTkxLDcgKzk5OCw3IEBA
IGludCBpb19yZWN2KHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVf
ZmxhZ3MpCiAJCQlzci0+bGVuIC09IHJldDsKIAkJCXNyLT5idWYgKz0gcmV0OwogCQkJc3It
PmRvbmVfaW8gKz0gcmV0OwotCQkJcmVxLT5mbGFncyB8PSBSRVFfRl9QQVJUSUFMX0lPOwor
CQkJaW9fbmV0X2tidWZfcmVjeWxlKHJlcSk7CiAJCQlyZXR1cm4gLUVBR0FJTjsKIAkJfQog
CQlpZiAocmV0ID09IC1FUkVTVEFSVFNZUykKQEAgLTEyMzUsNyArMTI0Miw3IEBAIGludCBp
b19zZW5kX3pjKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxh
Z3MpCiAJCQl6Yy0+bGVuIC09IHJldDsKIAkJCXpjLT5idWYgKz0gcmV0OwogCQkJemMtPmRv
bmVfaW8gKz0gcmV0OwotCQkJcmVxLT5mbGFncyB8PSBSRVFfRl9QQVJUSUFMX0lPOworCQkJ
aW9fbmV0X2tidWZfcmVjeWxlKHJlcSk7CiAJCQlyZXR1cm4gaW9fc2V0dXBfYXN5bmNfYWRk
cihyZXEsICZfX2FkZHJlc3MsIGlzc3VlX2ZsYWdzKTsKIAkJfQogCQlpZiAocmV0ID09IC1F
UkVTVEFSVFNZUykKQEAgLTEzMDYsNyArMTMxMyw3IEBAIGludCBpb19zZW5kbXNnX3pjKHN0
cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAKIAkJaWYg
KHJldCA+IDAgJiYgaW9fbmV0X3JldHJ5KHNvY2ssIGZsYWdzKSkgewogCQkJc3ItPmRvbmVf
aW8gKz0gcmV0OwotCQkJcmVxLT5mbGFncyB8PSBSRVFfRl9QQVJUSUFMX0lPOworCQkJaW9f
bmV0X2tidWZfcmVjeWxlKHJlcSk7CiAJCQlyZXR1cm4gaW9fc2V0dXBfYXN5bmNfbXNnKHJl
cSwga21zZywgaXNzdWVfZmxhZ3MpOwogCQl9CiAJCWlmIChyZXQgPT0gLUVSRVNUQVJUU1lT
KQotLSAKMi41MC4xCgo=

--------------SA703zAeiUEZz8TH7QyMw7PX--

