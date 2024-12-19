Return-Path: <stable+bounces-105349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455DE9F8381
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 19:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC8E164916
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65C419994F;
	Thu, 19 Dec 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="esfQX1QR"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68741760
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634011; cv=none; b=AhQI2Pw3xclgCWARNSQSEXQ1kmF8n6QUzA6Wtw9/+AozvNoFTvrXb4PovR8IJlbMr2EXJCcSrEgBkHgQGspk4cYoGI4Lc5PzuwHS2ELHbt1u1I090qneOwLKgnFvjKBrPXzbNs/d76p1AIrOPehNKGiJGjpjrhnjlXr+VJgOMTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634011; c=relaxed/simple;
	bh=NzXSnceUDDCifQtoDuUZqnM9WyC6JA2RESev74S7C0U=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=cooXK+T1RDVTiCN2a0qnQGX7XNJ/IJ0vDHaf5kDDdv3K5zC9icPq9Jfv2gaUE9WsrzdTDfZ6uZXEHzPPxiRIPdTjakggvQW6k3MBAOFoYt1j9zMAaWXwe/9/dvq2IAInPCcVShxfsNFUsJ+Zkiqlqh5n/T7EyVVDf/2/ZD7h5oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=esfQX1QR; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e9b8b0b9so90849539f.0
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734634007; x=1735238807; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U1ulIhv73g4MoS/C+87c+ffUftN6FrBGqNtp6eMXrjk=;
        b=esfQX1QRSqurutvqUuhzIk+aJTkjqY1dn3ZnK3okkCmEqRyuxqhdkHHI2WEUtmACaY
         mX2q3stCfmRk2XJi9bdrXwu7wpuZYM4nJ94k37o4L4E8mJv3hR4xSETrVEz31ITlMBBL
         6sIUCsKZ3yToGhrj9XBm0p83R4pVPdE70ftWyEKyQZ/14rEs0B2ZvVBM9A3KZNVFl12A
         5nJi+sv+VZfXypQ+pC/72L7A7r8u0hYsVSaVnv74KEpWNe5YtxwfkG6Li3M2OmLwOQtZ
         2cYIijVGGNuTXAoA1rovlIJ3Fkd7bLmwZTfljDksi8gOpITMiSMqrn1M7Je9oYLFVirc
         Rirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734634007; x=1735238807;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1ulIhv73g4MoS/C+87c+ffUftN6FrBGqNtp6eMXrjk=;
        b=X1kFeZWyYwGMXMUHaNcWArNFcJbhnKlVtj24ed9bh3UEXBXGf+vEnjc2VDfXIut8UT
         WlWm/S5NyhzADjU9XvDX2moguunWRDvoMrHqJNQBkYRTiLrK4ieO9siENsGbIPl/qHNI
         d+ZYBH5L1/Gvw7g2Y5fafNfFZTf8FL2uPC79e20Lfse0AgUgvTk8Im15lAUgn7Z7qekl
         9zJ4jtpqI1Dyp3hWkUw3haRXhUg8cR04aaAw/r7ph++F6/w8xAY0Xj1h9whpQCcCGZ4K
         K1vGHATcZWiTZKcteu69GSZCvbOxB3+F0P7DRTbx6P4MTmt6TATgw78RBoNYJ3hg+dkT
         5Z2A==
X-Gm-Message-State: AOJu0Yx/2EbWBoLrHNJXbeEo0D1SStzOyiGgvmx4vZz74FlHYGhou+ev
	iCNsFN9FupFuBkIOl0xKgmDvA4bKwX+Rkar9N4kAPSiSgk9G2qh30u9+hUq7/H7nGdczQWDqLqg
	P
X-Gm-Gg: ASbGncuniyQ28+rYqqyJTE/xKo3O2XfDnEvikKb/Wd2Ugi3jC/MbeoIiTkVm0UWAAw8
	l8jBFGRzUyYoHzl7ZUZK7VAsfbza/gYf/atISqDSB3dmZj4+HFt7C2uxFiF95Jnt+NX+ssHL7Xz
	TDket+iBC13S1h6UVe/LoaFTvuIp/X3tr8edsBnval4K+YTSC5hwsY3tjYPb4S1UaVeJFZLJeyD
	ole6oMOp9uD68mvImykKSs9iJZnotYqcA0W4emZPy58StVuzpWm
X-Google-Smtp-Source: AGHT+IGiF3vz/iudxfhlzC2nZBlNFBasIPslZAmkWg5BSsGMg+L6MLeCH0scF+YWRcoKzv1+4OGvBg==
X-Received: by 2002:a05:6602:2cc7:b0:843:ebf1:16df with SMTP id ca18e2360f4ac-847585dfb94mr738508439f.10.1734634007222;
        Thu, 19 Dec 2024 10:46:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf4f4adsm405166173.17.2024.12.19.10.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 10:46:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------iJy1JUGCMa8R1flJgQVy0qwv"
Message-ID: <87dc6df8-6392-4b19-99c6-c8295d630931@kernel.dk>
Date: Thu, 19 Dec 2024 11:46:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: 6.1-stable backports

This is a multi-part message in MIME format.
--------------iJy1JUGCMa8R1flJgQVy0qwv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Can you queue these 3 patches up for 6.1-stable? Same as the 6.6 set,
just applied on 6.1-stable.

Thanks!

-- 
Jens Axboe


--------------iJy1JUGCMa8R1flJgQVy0qwv
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-io_uring-rw-avoid-punting-to-io-wq-directly.patch"
Content-Disposition: attachment;
 filename="0003-io_uring-rw-avoid-punting-to-io-wq-directly.patch"
Content-Transfer-Encoding: base64

RnJvbSBlMDJiZmIyZTgxZTQyMTNiNTJiZjQ3YWRiOGIzNDhiMmMyZmIwMDdjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogTW9uLCAxOCBNYXIgMjAyNCAyMjowMDoyOCArMDAwMApTdWJqZWN0
OiBbUEFUQ0ggMy8zXSBpb191cmluZy9ydzogYXZvaWQgcHVudGluZyB0byBpby13cSBkaXJl
Y3RseQoKQ29tbWl0IDZlNmI4YzYyMTIwYTIyYWNkOGNiNzU5MzA0ZTRjZDJlMzIxNWQ0ODgg
dXBzdHJlYW0uCgpraW9jYl9kb25lKCkgc2hvdWxkIGNhcmUgdG8gc3BlY2lmaWNhbGx5IHJl
ZGlyZWN0aW5nIHJlcXVlc3RzIHRvIGlvLXdxLgpSZW1vdmUgdGhlIGhvcHBpbmcgdG8gdHcg
dG8gdGhlbiBxdWV1ZSBhbiBpby13cSwgcmV0dXJuIC1FQUdBSU4gYW5kIGxldAp0aGUgY29y
ZSBjb2RlIGlvX3VyaW5nIGhhbmRsZSBvZmZsb2FkaW5nLgoKU2lnbmVkLW9mZi1ieTogUGF2
ZWwgQmVndW5rb3YgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+ClRlc3RlZC1ieTogTWluZyBM
ZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvNDEzNTY0ZTU1MGZlMjM3NDRhOTcwZTE3ODNkZmE1NjYyOTFiMGU2Zi4xNzEwNzk5MTg4
LmdpdC5hc21sLnNpbGVuY2VAZ21haWwuY29tClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2Ug
PGF4Ym9lQGtlcm5lbC5kaz4KKGNoZXJyeSBwaWNrZWQgZnJvbSBjb21taXQgNmU2YjhjNjIx
MjBhMjJhY2Q4Y2I3NTkzMDRlNGNkMmUzMjE1ZDQ4OCkKLS0tCiBpb191cmluZy9pb191cmlu
Zy5jIHwgNiArKystLS0KIGlvX3VyaW5nL2lvX3VyaW5nLmggfCAxIC0KIGlvX3VyaW5nL3J3
LmMgICAgICAgfCA4ICstLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBi
L2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggMGIxMzYxNjYzMjY3Li4yNWIwNjNlNTYyMzAg
MTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJp
bmcuYwpAQCAtNDM0LDcgKzQzNCw3IEBAIHN0YXRpYyB2b2lkIGlvX3ByZXBfYXN5bmNfbGlu
ayhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKIAl9CiB9CiAKLXZvaWQgaW9fcXVldWVfaW93cShz
dHJ1Y3QgaW9fa2lvY2IgKnJlcSwgYm9vbCAqZG9udF91c2UpCitzdGF0aWMgdm9pZCBpb19x
dWV1ZV9pb3dxKHN0cnVjdCBpb19raW9jYiAqcmVxKQogewogCXN0cnVjdCBpb19raW9jYiAq
bGluayA9IGlvX3ByZXBfbGlua2VkX3RpbWVvdXQocmVxKTsKIAlzdHJ1Y3QgaW9fdXJpbmdf
dGFzayAqdGN0eCA9IHJlcS0+dGFzay0+aW9fdXJpbmc7CkBAIC0xOTA5LDcgKzE5MDksNyBA
QCBzdGF0aWMgdm9pZCBpb19xdWV1ZV9hc3luYyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgaW50
IHJldCkKIAkJYnJlYWs7CiAJY2FzZSBJT19BUE9MTF9BQk9SVEVEOgogCQlpb19rYnVmX3Jl
Y3ljbGUocmVxLCAwKTsKLQkJaW9fcXVldWVfaW93cShyZXEsIE5VTEwpOworCQlpb19xdWV1
ZV9pb3dxKHJlcSk7CiAJCWJyZWFrOwogCWNhc2UgSU9fQVBPTExfT0s6CiAJCWJyZWFrOwpA
QCAtMTk1OCw3ICsxOTU4LDcgQEAgc3RhdGljIHZvaWQgaW9fcXVldWVfc3FlX2ZhbGxiYWNr
KHN0cnVjdCBpb19raW9jYiAqcmVxKQogCQlpZiAodW5saWtlbHkocmVxLT5jdHgtPmRyYWlu
X2FjdGl2ZSkpCiAJCQlpb19kcmFpbl9yZXEocmVxKTsKIAkJZWxzZQotCQkJaW9fcXVldWVf
aW93cShyZXEsIE5VTEwpOworCQkJaW9fcXVldWVfaW93cShyZXEpOwogCX0KIH0KIApkaWZm
IC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuaCBiL2lvX3VyaW5nL2lvX3VyaW5nLmgKaW5k
ZXggM2I4N2Y1NDIxZWI2Li5hMWY2NzliODE5OWUgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lv
X3VyaW5nLmgKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuaApAQCAtNTQsNyArNTQsNiBAQCBz
dGF0aWMgaW5saW5lIGJvb2wgaW9fcmVxX2Zmc19zZXQoc3RydWN0IGlvX2tpb2NiICpyZXEp
CiB2b2lkIF9faW9fcmVxX3Rhc2tfd29ya19hZGQoc3RydWN0IGlvX2tpb2NiICpyZXEsIGJv
b2wgYWxsb3dfbG9jYWwpOwogYm9vbCBpb19hbGxvY19hc3luY19kYXRhKHN0cnVjdCBpb19r
aW9jYiAqcmVxKTsKIHZvaWQgaW9fcmVxX3Rhc2tfcXVldWUoc3RydWN0IGlvX2tpb2NiICpy
ZXEpOwotdm9pZCBpb19xdWV1ZV9pb3dxKHN0cnVjdCBpb19raW9jYiAqcmVxLCBib29sICpk
b250X3VzZSk7CiB2b2lkIGlvX3JlcV90YXNrX2NvbXBsZXRlKHN0cnVjdCBpb19raW9jYiAq
cmVxLCBib29sICpsb2NrZWQpOwogdm9pZCBpb19yZXFfdGFza19xdWV1ZV9mYWlsKHN0cnVj
dCBpb19raW9jYiAqcmVxLCBpbnQgcmV0KTsKIHZvaWQgaW9fcmVxX3Rhc2tfc3VibWl0KHN0
cnVjdCBpb19raW9jYiAqcmVxLCBib29sICpsb2NrZWQpOwpkaWZmIC0tZ2l0IGEvaW9fdXJp
bmcvcncuYyBiL2lvX3VyaW5nL3J3LmMKaW5kZXggYjMyMzk1ZDg3MmM2Li42OTI2NjNiZDg2
NGYgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL3J3LmMKKysrIGIvaW9fdXJpbmcvcncuYwpAQCAt
MTY3LDEyICsxNjcsNiBAQCBzdGF0aWMgaW5saW5lIGxvZmZfdCAqaW9fa2lvY2JfdXBkYXRl
X3BvcyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKIAlyZXR1cm4gTlVMTDsKIH0KIAotc3RhdGlj
IHZvaWQgaW9fcmVxX3Rhc2tfcXVldWVfcmVpc3N1ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkK
LXsKLQlyZXEtPmlvX3Rhc2tfd29yay5mdW5jID0gaW9fcXVldWVfaW93cTsKLQlpb19yZXFf
dGFza193b3JrX2FkZChyZXEpOwotfQotCiAjaWZkZWYgQ09ORklHX0JMT0NLCiBzdGF0aWMg
Ym9vbCBpb19yZXN1Ym1pdF9wcmVwKHN0cnVjdCBpb19raW9jYiAqcmVxKQogewpAQCAtMzQx
LDcgKzMzNSw3IEBAIHN0YXRpYyBpbnQga2lvY2JfZG9uZShzdHJ1Y3QgaW9fa2lvY2IgKnJl
cSwgc3NpemVfdCByZXQsCiAJaWYgKHJlcS0+ZmxhZ3MgJiBSRVFfRl9SRUlTU1VFKSB7CiAJ
CXJlcS0+ZmxhZ3MgJj0gflJFUV9GX1JFSVNTVUU7CiAJCWlmIChpb19yZXN1Ym1pdF9wcmVw
KHJlcSkpCi0JCQlpb19yZXFfdGFza19xdWV1ZV9yZWlzc3VlKHJlcSk7CisJCQlyZXR1cm4g
LUVBR0FJTjsKIAkJZWxzZQogCQkJaW9fcmVxX3Rhc2tfcXVldWVfZmFpbChyZXEsIGZpbmFs
X3JldCk7CiAJfQotLSAKMi40NS4yCgo=
--------------iJy1JUGCMa8R1flJgQVy0qwv
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-rw-treat-EOPNOTSUPP-for-IOCB_NOWAIT-like-EA.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-rw-treat-EOPNOTSUPP-for-IOCB_NOWAIT-like-EA.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlM2QwN2VkMzE0NmIzOGQwYjNmYjk1MmUzM2NlODlhOThiNzRjZjRmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMTAgU2VwIDIwMjQgMDg6MzA6NTcgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
M10gaW9fdXJpbmcvcnc6IHRyZWF0IC1FT1BOT1RTVVBQIGZvciBJT0NCX05PV0FJVCBsaWtl
CiAtRUFHQUlOCgpDb21taXQgYzBhOWQ0OTZlMGZlY2U2N2RiNzc3YmQ0ODU1MDM3NmNmMjk2
MGM0NyB1cHN0cmVhbS4KClNvbWUgZmlsZSBzeXN0ZW1zLCBvY2ZzMiBpbiB0aGlzIGNhc2Us
IHdpbGwgcmV0dXJuIC1FT1BOT1RTVVBQIGZvcgphbiBJT0NCX05PV0FJVCByZWFkL3dyaXRl
IGF0dGVtcHQuIFdoaWxlIHRoaXMgY2FuIGJlIGFyZ3VlZCB0byBiZQpjb3JyZWN0LCB0aGUg
dXN1YWwgcmV0dXJuIHZhbHVlIGZvciBzb21ldGhpbmcgdGhhdCByZXF1aXJlcyBibG9ja2lu
Zwppc3N1ZSBpcyAtRUFHQUlOLgoKQSByZWZhY3RvcmluZyBpb191cmluZyBjb21taXQgZHJv
cHBlZCBjYWxsaW5nIGtpb2NiX2RvbmUoKSBmb3IKbmVnYXRpdmUgcmV0dXJuIHZhbHVlcywg
d2hpY2ggaXMgb3RoZXJ3aXNlIHdoZXJlIHdlIGFscmVhZHkgZG8gdGhhdAp0cmFuc2Zvcm1h
dGlvbi4gVG8gZW5zdXJlIHdlIGNhdGNoIGl0IGluIGJvdGggc3BvdHMsIGNoZWNrIGl0IGlu
Cl9faW9fcmVhZCgpIGl0c2VsZiBhcyB3ZWxsLgoKUmVwb3J0ZWQtYnk6IFJvYmVydCBTYW5k
ZXIgPHIuc2FuZGVyQGhlaW5sZWluLXN1cHBvcnQuZGU+Ckxpbms6IGh0dHBzOi8vZm9zc3Rv
ZG9uLm9yZy9AZ3VydWJlcnRAbWFzdG9kb24uZ3VydWJlcnQuZGUvMTEzMTEyNDMxODg5NjM4
NDQwCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiBhMDhkMTk1YjU4NmEgKCJp
b191cmluZy9ydzogc3BsaXQgaW9fcmVhZCgpIGludG8gYSBoZWxwZXIiKQpTaWduZWQtb2Zm
LWJ5OiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvcncuYyB8
IDggKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9pb191cmluZy9ydy5jIGIvaW9fdXJpbmcvcncuYwppbmRleCBkNTRmMjZkYjAxMzUu
LmIzMjM5NWQ4NzJjNiAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvcncuYworKysgYi9pb191cmlu
Zy9ydy5jCkBAIC03NTcsNiArNzU3LDE0IEBAIHN0YXRpYyBpbnQgX19pb19yZWFkKHN0cnVj
dCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAKIAlyZXQgPSBp
b19pdGVyX2RvX3JlYWQocncsICZzLT5pdGVyKTsKIAorCS8qCisJICogU29tZSBmaWxlIHN5
c3RlbXMgbGlrZSB0byByZXR1cm4gLUVPUE5PVFNVUFAgZm9yIGFuIElPQ0JfTk9XQUlUCisJ
ICogaXNzdWUsIGV2ZW4gdGhvdWdoIHRoZXkgc2hvdWxkIGJlIHJldHVybmluZyAtRUFHQUlO
LiBUbyBiZSBzYWZlLAorCSAqIHJldHJ5IGZyb20gYmxvY2tpbmcgY29udGV4dCBmb3IgZWl0
aGVyLgorCSAqLworCWlmIChyZXQgPT0gLUVPUE5PVFNVUFAgJiYgZm9yY2Vfbm9uYmxvY2sp
CisJCXJldCA9IC1FQUdBSU47CisKIAlpZiAocmV0ID09IC1FQUdBSU4gfHwgKHJlcS0+Zmxh
Z3MgJiBSRVFfRl9SRUlTU1VFKSkgewogCQlyZXEtPmZsYWdzICY9IH5SRVFfRl9SRUlTU1VF
OwogCQkvKiBpZiB3ZSBjYW4gcG9sbCwganVzdCBkbyB0aGF0ICovCi0tIAoyLjQ1LjIKCg==

--------------iJy1JUGCMa8R1flJgQVy0qwv
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-rw-split-io_read-into-a-helper.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-rw-split-io_read-into-a-helper.patch"
Content-Transfer-Encoding: base64

RnJvbSA0MmJjOThlZjAzNTgwNjA3NzJmYmQzNDRhNzQyODViMDRlMWE1YzU0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IE1vbiwgMTEgU2VwIDIwMjMgMTM6MzE6NTYgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
M10gaW9fdXJpbmcvcnc6IHNwbGl0IGlvX3JlYWQoKSBpbnRvIGEgaGVscGVyCgpDb21taXQg
YTA4ZDE5NWI1ODZhMjE3ZDc2YjQyMDYyZjg4ZjM3NWEzZWVkZGE0ZCB1cHN0cmVhbS4KCkFk
ZCBfX2lvX3JlYWQoKSB3aGljaCBkb2VzIHRoZSBncnVudCBvZiB0aGUgd29yaywgbGVhdmlu
ZyB0aGUgY29tcGxldGlvbgpzaWRlIHRvIHRoZSBuZXcgaW9fcmVhZCgpLiBObyBmdW5jdGlv
bmFsIGNoYW5nZXMgaW4gdGhpcyBwYXRjaC4KClJldmlld2VkLWJ5OiBHYWJyaWVsIEtyaXNt
YW4gQmVydGF6aSA8a3Jpc21hbkBzdXNlLmRlPgpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+CihjaGVycnkgcGlja2VkIGZyb20gY29tbWl0IGEwOGQxOTVi
NTg2YTIxN2Q3NmI0MjA2MmY4OGYzNzVhM2VlZGRhNGQpCi0tLQogaW9fdXJpbmcvcncuYyB8
IDE1ICsrKysrKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvcncuYyBiL2lvX3VyaW5n
L3J3LmMKaW5kZXggOWQ2ZTE3YTI0NGFlLi5kNTRmMjZkYjAxMzUgMTAwNjQ0Ci0tLSBhL2lv
X3VyaW5nL3J3LmMKKysrIGIvaW9fdXJpbmcvcncuYwpAQCAtNjkxLDcgKzY5MSw3IEBAIHN0
YXRpYyBpbnQgaW9fcndfaW5pdF9maWxlKHN0cnVjdCBpb19raW9jYiAqcmVxLCBmbW9kZV90
IG1vZGUpCiAJcmV0dXJuIDA7CiB9CiAKLWludCBpb19yZWFkKHN0cnVjdCBpb19raW9jYiAq
cmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCitzdGF0aWMgaW50IF9faW9fcmVhZChz
dHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQogewogCXN0
cnVjdCBpb19ydyAqcncgPSBpb19raW9jYl90b19jbWQocmVxLCBzdHJ1Y3QgaW9fcncpOwog
CXN0cnVjdCBpb19yd19zdGF0ZSBfX3MsICpzID0gJl9fczsKQEAgLTgzNiw3ICs4MzYsMTgg
QEAgaW50IGlvX3JlYWQoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1
ZV9mbGFncykKIAkvKiBpdCdzIGZhc3RlciB0byBjaGVjayBoZXJlIHRoZW4gZGVsZWdhdGUg
dG8ga2ZyZWUgKi8KIAlpZiAoaW92ZWMpCiAJCWtmcmVlKGlvdmVjKTsKLQlyZXR1cm4ga2lv
Y2JfZG9uZShyZXEsIHJldCwgaXNzdWVfZmxhZ3MpOworCXJldHVybiByZXQ7Cit9CisKK2lu
dCBpb19yZWFkKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxh
Z3MpCit7CisJaW50IHJldDsKKworCXJldCA9IF9faW9fcmVhZChyZXEsIGlzc3VlX2ZsYWdz
KTsKKwlpZiAocmV0ID49IDApCisJCXJldHVybiBraW9jYl9kb25lKHJlcSwgcmV0LCBpc3N1
ZV9mbGFncyk7CisKKwlyZXR1cm4gcmV0OwogfQogCiBzdGF0aWMgYm9vbCBpb19raW9jYl9z
dGFydF93cml0ZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgc3RydWN0IGtpb2NiICpraW9jYikK
LS0gCjIuNDUuMgoK

--------------iJy1JUGCMa8R1flJgQVy0qwv--

