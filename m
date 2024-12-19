Return-Path: <stable+bounces-105346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B0E9F8352
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 19:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2FE16AC85
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645FC19CD19;
	Thu, 19 Dec 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g+He3GpE"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80A35948
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734633305; cv=none; b=NGPOjnW0ZRUd1o3ocFtsrhCDFFKb13hXQBHtos7trVduDW/lddjdcsv6V9WqNdHqS74r8lOiIKmgNFMFM6XM4Cv+/0Kcpx/oBSOo/LVdzsYT5gk5Ret743LrP/iTrZOrf9s7WmdXi1dq4U1JWxZ9g5bts9EIBJEYtos9z9RITvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734633305; c=relaxed/simple;
	bh=6eJ+c10B6DGlXZEPpqQVo4M4DrmFux6UzJA6VJBo4L8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=lb8iejWHw/tElDJoEry83oaSsKR0HRmLmfBqJ95pDCXDBn8Wr1Vdmcqyp1FN8ZWsrbS3jKV/zO9jYNVleyZzXbsxLGh9W2ynGmkh0fDgqmgvwyrUvmJ7+NOuy7wqqvPhU/6UcbMNq3JBY2Jcz+phfbl8VYWAVRIazm6/bwCGqg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g+He3GpE; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a9cdcec53fso8207195ab.1
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734633300; x=1735238100; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S2lPtOqfydI7GUmn3RJRuUNJYR1kKVSMGAtY07asevM=;
        b=g+He3GpEChkVZTtL32yW1Df66WiZR+hGAea3QnuInFmiAZN/N1+I0/xIJHMSoQdR/A
         FEGGscfOuz8S7sHa49XJBWDhWatnJhh1GY5Iszco/9wuxOAodTATjk/X1nGMhCi2EH78
         PMdm2z746agJbIlpFJCIThRDgJB9oCndjnvvdkIYhBjhiaVAcf/JnmUr7bPs0bCzBymE
         klaGGwoL4kB3cJ9ENayNxnMD4agLUpDYmE39uqclj7LIvZZZPM7vPR0n3uUlV5qLVKgF
         e6tlYLp3UOJjNpeNXEZZ+dzvwi9E/LLNton+hJEKHFefxHUMkbaPQfsZD9q7Pp6rM7C6
         5M1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734633300; x=1735238100;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2lPtOqfydI7GUmn3RJRuUNJYR1kKVSMGAtY07asevM=;
        b=iAcRQJO4v68YzJCIdnLxBl9yAPpjqhVhy6dmz1oFz2zwVtx3vEPeLwbRG1gkO2xw30
         pMilZoXn6HLd71+ZjfhNr0EJWnYMATczfGc5uOIte7/V7KWkMarAYVD4FleDDMyETJ2l
         OpwmFF+2yvp9+kIWgRimY0XCOzUTns4xoB9bT9cq8mYenOj7NU41oS4Mdvf9kXWL7WUA
         eJa4d4gulrE9Zr54IyK9CFflRJJtj6HiKobT7FNo0FhB3UFC0GzzE12kYp5Xyii/OydS
         HIhxBtSju0V4tt2oz1R8owvWyGsnT22Puu4BLOfIQ4dNuizg8TvsoWzNklSoAU3oP0rR
         aNvA==
X-Gm-Message-State: AOJu0YwKqfiTxeuWg1r0X5gODC+WgY2xDt09I4rkfI598kQjOQlbv8tz
	zjihdrP8T1Hpl4v+OzcrsovnAreY4Trahx5nHMTMSqeejrsFk1mGp5zS12OOvGnubgOBkFg+xCK
	k
X-Gm-Gg: ASbGncv56cCG4UHJXbPYTWe0N7r8qHaeMXi/hgQe7TY6HlH0CPo9wYp8MuhDhUxQQXi
	VRHeaJiyJ211dUu7HC0MFVvvzH2k2VcT7/cxDwZ8sD+vnIs8qU+T/JiXEf8tlm3c9F9LjEwJJMK
	m1W0f1vUF4t0RtRwSBDuhzXkAdbTOuwzqyLb3xR1AGhIJNz2WUMu1h5GlNOm2E7k0fCTSJWujVj
	HYmDEvTDEVzS5LuZrBm3hbnsULpG+QtDcRIsVytjcrH3u8etqmh
X-Google-Smtp-Source: AGHT+IGGx0dNHbqwUVNJdfNxwMHhAhjYbaaaTKP8KbdBpkFMxSBGtdGTwejnHuQTN8no5OB6t3E86Q==
X-Received: by 2002:a05:6e02:1fe8:b0:3a6:c98d:86bc with SMTP id e9e14a558f8ab-3c2d14d21b6mr1430215ab.1.1734633300211;
        Thu, 19 Dec 2024 10:35:00 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf67705sm402626173.61.2024.12.19.10.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 10:34:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------pr19G4gMMTWxSEYgcwyYkuSV"
Message-ID: <164c752f-ae4d-48a5-a11d-1d7462f817cb@kernel.dk>
Date: Thu, 19 Dec 2024 11:34:58 -0700
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
Subject: 6.6-stable backports

This is a multi-part message in MIME format.
--------------pr19G4gMMTWxSEYgcwyYkuSV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Can you guys queue up these patches for 6.6-stable?

Thanks!

-- 
Jens Axboe


--------------pr19G4gMMTWxSEYgcwyYkuSV
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-rw-split-io_read-into-a-helper.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-rw-split-io_read-into-a-helper.patch"
Content-Transfer-Encoding: base64

RnJvbSAxZDM0MmYwNGVhNjI1MjIzOWU4YzMwYTAyYjU1MTMxYTRkOGQ4ODQxIE1vbiBTZXAg
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
L3J3LmMKaW5kZXggZTkwNDA0YzgxMmZhLi42YWUyOWI4OGJhZjggMTAwNjQ0Ci0tLSBhL2lv
X3VyaW5nL3J3LmMKKysrIGIvaW9fdXJpbmcvcncuYwpAQCAtNzEyLDcgKzcxMiw3IEBAIHN0
YXRpYyBpbnQgaW9fcndfaW5pdF9maWxlKHN0cnVjdCBpb19raW9jYiAqcmVxLCBmbW9kZV90
IG1vZGUpCiAJcmV0dXJuIDA7CiB9CiAKLWludCBpb19yZWFkKHN0cnVjdCBpb19raW9jYiAq
cmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCitzdGF0aWMgaW50IF9faW9fcmVhZChz
dHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQogewogCXN0
cnVjdCBpb19ydyAqcncgPSBpb19raW9jYl90b19jbWQocmVxLCBzdHJ1Y3QgaW9fcncpOwog
CXN0cnVjdCBpb19yd19zdGF0ZSBfX3MsICpzID0gJl9fczsKQEAgLTg1Nyw3ICs4NTcsMTgg
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
--------------pr19G4gMMTWxSEYgcwyYkuSV
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-rw-treat-EOPNOTSUPP-for-IOCB_NOWAIT-like-EA.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-rw-treat-EOPNOTSUPP-for-IOCB_NOWAIT-like-EA.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA4M2E0MjE5ZmRhMDJjMGZkYTkzYzNkZWYyZDg1ZTk1MjE2MWQ0NjUxIE1vbiBTZXAg
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
aXQgYS9pb191cmluZy9ydy5jIGIvaW9fdXJpbmcvcncuYwppbmRleCA2YWUyOWI4OGJhZjgu
LjhhMTZmOTdmNWFjMyAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvcncuYworKysgYi9pb191cmlu
Zy9ydy5jCkBAIC03NzgsNiArNzc4LDE0IEBAIHN0YXRpYyBpbnQgX19pb19yZWFkKHN0cnVj
dCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MpCiAKIAlyZXQgPSBp
b19pdGVyX2RvX3JlYWQocncsICZzLT5pdGVyKTsKIAorCS8qCisJICogU29tZSBmaWxlIHN5
c3RlbXMgbGlrZSB0byByZXR1cm4gLUVPUE5PVFNVUFAgZm9yIGFuIElPQ0JfTk9XQUlUCisJ
ICogaXNzdWUsIGV2ZW4gdGhvdWdoIHRoZXkgc2hvdWxkIGJlIHJldHVybmluZyAtRUFHQUlO
LiBUbyBiZSBzYWZlLAorCSAqIHJldHJ5IGZyb20gYmxvY2tpbmcgY29udGV4dCBmb3IgZWl0
aGVyLgorCSAqLworCWlmIChyZXQgPT0gLUVPUE5PVFNVUFAgJiYgZm9yY2Vfbm9uYmxvY2sp
CisJCXJldCA9IC1FQUdBSU47CisKIAlpZiAocmV0ID09IC1FQUdBSU4gfHwgKHJlcS0+Zmxh
Z3MgJiBSRVFfRl9SRUlTU1VFKSkgewogCQlyZXEtPmZsYWdzICY9IH5SRVFfRl9SRUlTU1VF
OwogCQkvKiBpZiB3ZSBjYW4gcG9sbCwganVzdCBkbyB0aGF0ICovCi0tIAoyLjQ1LjIKCg==

--------------pr19G4gMMTWxSEYgcwyYkuSV
Content-Type: text/x-patch; charset=UTF-8;
 name="0003-io_uring-rw-avoid-punting-to-io-wq-directly.patch"
Content-Disposition: attachment;
 filename="0003-io_uring-rw-avoid-punting-to-io-wq-directly.patch"
Content-Transfer-Encoding: base64

RnJvbSAyMDU1OGFlMTM2NTYyYTcxZDAwMzMzMDZjZDY2YzY5YjYzMGNjNzAwIE1vbiBTZXAg
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
Zy5jIHwgOCArKysrLS0tLQogaW9fdXJpbmcvaW9fdXJpbmcuaCB8IDEgLQogaW9fdXJpbmcv
cncuYyAgICAgICB8IDggKy0tLS0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmluZy5j
IGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCA3MGRkNmE1Yjk2NDcuLmQ0ZGU0YjU0MzE5
OSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9pb191
cmluZy5jCkBAIC00OTIsNyArNDkyLDcgQEAgc3RhdGljIHZvaWQgaW9fcHJlcF9hc3luY19s
aW5rKHN0cnVjdCBpb19raW9jYiAqcmVxKQogCX0KIH0KIAotdm9pZCBpb19xdWV1ZV9pb3dx
KHN0cnVjdCBpb19raW9jYiAqcmVxLCBzdHJ1Y3QgaW9fdHdfc3RhdGUgKnRzX2RvbnRfdXNl
KQorc3RhdGljIHZvaWQgaW9fcXVldWVfaW93cShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKIHsK
IAlzdHJ1Y3QgaW9fa2lvY2IgKmxpbmsgPSBpb19wcmVwX2xpbmtlZF90aW1lb3V0KHJlcSk7
CiAJc3RydWN0IGlvX3VyaW5nX3Rhc2sgKnRjdHggPSByZXEtPnRhc2stPmlvX3VyaW5nOwpA
QCAtMTQ3NSw3ICsxNDc1LDcgQEAgdm9pZCBpb19yZXFfdGFza19zdWJtaXQoc3RydWN0IGlv
X2tpb2NiICpyZXEsIHN0cnVjdCBpb190d19zdGF0ZSAqdHMpCiAJaWYgKHVubGlrZWx5KHJl
cS0+dGFzay0+ZmxhZ3MgJiBQRl9FWElUSU5HKSkKIAkJaW9fcmVxX2RlZmVyX2ZhaWxlZChy
ZXEsIC1FRkFVTFQpOwogCWVsc2UgaWYgKHJlcS0+ZmxhZ3MgJiBSRVFfRl9GT1JDRV9BU1lO
QykKLQkJaW9fcXVldWVfaW93cShyZXEsIHRzKTsKKwkJaW9fcXVldWVfaW93cShyZXEpOwog
CWVsc2UKIAkJaW9fcXVldWVfc3FlKHJlcSk7CiB9CkBAIC0yMDQwLDcgKzIwNDAsNyBAQCBz
dGF0aWMgdm9pZCBpb19xdWV1ZV9hc3luYyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgaW50IHJl
dCkKIAkJYnJlYWs7CiAJY2FzZSBJT19BUE9MTF9BQk9SVEVEOgogCQlpb19rYnVmX3JlY3lj
bGUocmVxLCAwKTsKLQkJaW9fcXVldWVfaW93cShyZXEsIE5VTEwpOworCQlpb19xdWV1ZV9p
b3dxKHJlcSk7CiAJCWJyZWFrOwogCWNhc2UgSU9fQVBPTExfT0s6CiAJCWJyZWFrOwpAQCAt
MjA4OSw3ICsyMDg5LDcgQEAgc3RhdGljIHZvaWQgaW9fcXVldWVfc3FlX2ZhbGxiYWNrKHN0
cnVjdCBpb19raW9jYiAqcmVxKQogCQlpZiAodW5saWtlbHkocmVxLT5jdHgtPmRyYWluX2Fj
dGl2ZSkpCiAJCQlpb19kcmFpbl9yZXEocmVxKTsKIAkJZWxzZQotCQkJaW9fcXVldWVfaW93
cShyZXEsIE5VTEwpOworCQkJaW9fcXVldWVfaW93cShyZXEpOwogCX0KIH0KIApkaWZmIC0t
Z2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuaCBiL2lvX3VyaW5nL2lvX3VyaW5nLmgKaW5kZXgg
ODI0MjgyMDc0MmVlLi41NzY1OGQyNGE3M2UgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3Vy
aW5nLmgKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuaApAQCAtNjMsNyArNjMsNiBAQCBzdHJ1
Y3QgZmlsZSAqaW9fZmlsZV9nZXRfZml4ZWQoc3RydWN0IGlvX2tpb2NiICpyZXEsIGludCBm
ZCwKIHZvaWQgX19pb19yZXFfdGFza193b3JrX2FkZChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwg
dW5zaWduZWQgZmxhZ3MpOwogYm9vbCBpb19hbGxvY19hc3luY19kYXRhKHN0cnVjdCBpb19r
aW9jYiAqcmVxKTsKIHZvaWQgaW9fcmVxX3Rhc2tfcXVldWUoc3RydWN0IGlvX2tpb2NiICpy
ZXEpOwotdm9pZCBpb19xdWV1ZV9pb3dxKHN0cnVjdCBpb19raW9jYiAqcmVxLCBzdHJ1Y3Qg
aW9fdHdfc3RhdGUgKnRzX2RvbnRfdXNlKTsKIHZvaWQgaW9fcmVxX3Rhc2tfY29tcGxldGUo
c3RydWN0IGlvX2tpb2NiICpyZXEsIHN0cnVjdCBpb190d19zdGF0ZSAqdHMpOwogdm9pZCBp
b19yZXFfdGFza19xdWV1ZV9mYWlsKHN0cnVjdCBpb19raW9jYiAqcmVxLCBpbnQgcmV0KTsK
IHZvaWQgaW9fcmVxX3Rhc2tfc3VibWl0KHN0cnVjdCBpb19raW9jYiAqcmVxLCBzdHJ1Y3Qg
aW9fdHdfc3RhdGUgKnRzKTsKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL3J3LmMgYi9pb191cmlu
Zy9ydy5jCmluZGV4IDhhMTZmOTdmNWFjMy4uYTYyZjg0ZTI4YmFjIDEwMDY0NAotLS0gYS9p
b191cmluZy9ydy5jCisrKyBiL2lvX3VyaW5nL3J3LmMKQEAgLTE2OCwxMiArMTY4LDYgQEAg
c3RhdGljIGlubGluZSBsb2ZmX3QgKmlvX2tpb2NiX3VwZGF0ZV9wb3Moc3RydWN0IGlvX2tp
b2NiICpyZXEpCiAJcmV0dXJuIE5VTEw7CiB9CiAKLXN0YXRpYyB2b2lkIGlvX3JlcV90YXNr
X3F1ZXVlX3JlaXNzdWUoc3RydWN0IGlvX2tpb2NiICpyZXEpCi17Ci0JcmVxLT5pb190YXNr
X3dvcmsuZnVuYyA9IGlvX3F1ZXVlX2lvd3E7Ci0JaW9fcmVxX3Rhc2tfd29ya19hZGQocmVx
KTsKLX0KLQogI2lmZGVmIENPTkZJR19CTE9DSwogc3RhdGljIGJvb2wgaW9fcmVzdWJtaXRf
cHJlcChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKIHsKQEAgLTM1OSw3ICszNTMsNyBAQCBzdGF0
aWMgaW50IGtpb2NiX2RvbmUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHNzaXplX3QgcmV0LAog
CWlmIChyZXEtPmZsYWdzICYgUkVRX0ZfUkVJU1NVRSkgewogCQlyZXEtPmZsYWdzICY9IH5S
RVFfRl9SRUlTU1VFOwogCQlpZiAoaW9fcmVzdWJtaXRfcHJlcChyZXEpKQotCQkJaW9fcmVx
X3Rhc2tfcXVldWVfcmVpc3N1ZShyZXEpOworCQkJcmV0dXJuIC1FQUdBSU47CiAJCWVsc2UK
IAkJCWlvX3JlcV90YXNrX3F1ZXVlX2ZhaWwocmVxLCBmaW5hbF9yZXQpOwogCX0KLS0gCjIu
NDUuMgoK

--------------pr19G4gMMTWxSEYgcwyYkuSV--

