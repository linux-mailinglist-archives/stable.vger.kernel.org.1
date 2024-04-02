Return-Path: <stable+bounces-35614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A041895791
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33AB7B21962
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED7912BF1A;
	Tue,  2 Apr 2024 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x8AAo7oa"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFD63398A
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069498; cv=none; b=llLg3iqdVuTTvpRsV+0FAMKO0pXC8ocgT9ctel1xoFa+H4wFAbuYziheYTF2cnC4dKdAmZwZB794S6OhXdvngo+J636AuAOIIY0UwsdysJ5lnHgeIMBLIcA/cEsbRaVNT0unWGg7B1PWlRoqa0AHmjlOeSAs9rYTPi3+fU505l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069498; c=relaxed/simple;
	bh=78TEXJhgP6xrwDz8UQ0KMMfK2W/4c+HvrZZpYCxvt1s=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=OQ2ZVMhMurvMGbtRyoMsvlVDSE0r0Jn8jhn/XDbGGmHSfgAGUHIaaOzdAecoePbQVsoTwFSAaaJfG++QRjKy9GzTrUc9hsVhlhHwCaFf5CEtvJw6Ql5aoEL1Yt14m9VKYUDtD1NV5yLhdhzLVZn4MPTnDJ5l9nSPSpWI/AoUaQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x8AAo7oa; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3688dcc5055so2075025ab.1
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712069491; x=1712674291; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5nkRY0KRwbJME1XHIvP20KQl0k10CpM1fGJWCd0lmGw=;
        b=x8AAo7oaup19BJhzLnhHWNuqQoMq/ZrDbOBJNM3o9zqiITcKreDt2BD4wc0f53dSgt
         211y3DxzCZG05WyM6crZKW+GvCJBQWptysgdGhps0ITA4apK3DZreqv1d68nxFllYS/t
         gWBZiYTe4+PXKeBuOuEGGlZLygexvSQtsENTiHXnXY5GIAP0d0moS5Jj8fXlm5TwifSZ
         xVjb5ec9txrpISim4nZZEs0OqxlB2OpwbvdfMq/qVEEg5Ol7mX0ojCy7KeAnDz03B3+F
         1fwqrKgiKlxUD2g/29BFnvf/mXLxl7abBECvGIdbSb5t4o9aAdNAcTuAJUYB6k18IBHN
         HDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712069491; x=1712674291;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nkRY0KRwbJME1XHIvP20KQl0k10CpM1fGJWCd0lmGw=;
        b=TO97KJ0p9cwQVBitjtKy0I/be3xmwpX4qrWngw3P7Aj2JPiMYDeKUH0GHYbyuoDUy1
         fSO5FdBsqQp26B+o67ZWepGnfRdU8Y5v2/a66PLPt1tmxYnXN/VLsVtuzXr2pSjUyTEA
         IaBweQrQ37kxX1vG6T98UzKLCGiiQ2wYBpU1rSPojl0DqsCSCTask89k30oYTVmES82v
         4fz9tXWFFO9BQx3RKI86ThgTqau84hK3kQTxJF9hoqHs1IFYWPmpK4fNpwPzplntQYUK
         Bz9DKPX+WYqTeR1xQhL9dFFY18vWT8h3KE4ZrmORUc6cLnsLIHIYDBQ8FehQJ4AKDRy8
         rZgQ==
X-Gm-Message-State: AOJu0YzA+YIIQUeXfBQ5l/O7oWiGx8MqAFLNkINoIWlXR2EEAlLFZ2Gx
	0QgoXkAI8q48h9yTII4gVt5wPwQvXl7pvnA5NvuHQOQlBufycIFWuZSRuA9r1J7THDb1Nu0K61V
	v
X-Google-Smtp-Source: AGHT+IE/UlM1T7CRRoKFIFE+aGK8/GxdHG6ute3IZhvM1RiwvEHUHdUVhG/fGJcGSJHRjXTHqs3BKQ==
X-Received: by 2002:a05:6e02:2195:b0:369:b728:583c with SMTP id j21-20020a056e02219500b00369b728583cmr5681963ila.3.1712069491282;
        Tue, 02 Apr 2024 07:51:31 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u17-20020a92da91000000b00368706996b8sm3295550iln.38.2024.04.02.07.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:51:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------XB4gNHwm3QjWNGmdbTSLzSBj"
Message-ID: <5e662379-5949-4c42-9fd9-43d79812b08a@kernel.dk>
Date: Tue, 2 Apr 2024 08:51:29 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable <stable@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: 5.10/15 file registration fixup

This is a multi-part message in MIME format.
--------------XB4gNHwm3QjWNGmdbTSLzSBj
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

A previous stable backport neglected to handle that we now don't clear
'ret' since the SCM registration went away. I checked the other stable
kernels and it's only affecting 5.10/5.15.

Can you apply this fixup patch for 5.10-stable and 5.15-stable? I
provided one for each even though they are identical, but the fixup
sha is obviously different for them.

Thanks!

-- 
Jens Axboe

--------------XB4gNHwm3QjWNGmdbTSLzSBj
Content-Type: text/x-patch; charset=UTF-8;
 name="5.10-0001-io_uring-ensure-0-is-returned-on-file-registration-s.patch"
Content-Disposition: attachment;
 filename*0="5.10-0001-io_uring-ensure-0-is-returned-on-file-registration";
 filename*1="-s.patch"
Content-Transfer-Encoding: base64

RnJvbSBhOGMyMjkyMWEwOGE4ZDUwYjEwZmM4MzZjZmY0MzQ4ZDVkZGUxN2UyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMiBBcHIgMjAyNCAwODoyODowNCAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nOiBlbnN1cmUgJzAnIGlzIHJldHVybmVkIG9uIGZpbGUgcmVnaXN0cmF0aW9uIHN1
Y2Nlc3MKCkEgcHJldmlvdXMgYmFja3BvcnQgbWlzdGFrZW5seSByZW1vdmVkIGNvZGUgdGhh
dCBjbGVhcmVkICdyZXQnIHRvIHplcm8sCmFzIHRoZSBTQ00gbG9nZ2luZyB3YXMgcGVyZm9y
bWVkLiBGaXggdXAgdGhlIHJldHVybiB2YWx1ZSBzbyB3ZSBkb24ndApyZXR1cm4gYW4gZXJy
YW50IGVycm9yIG9uIGZpeGVkIGZpbGUgcmVnaXN0cmF0aW9uLgoKRml4ZXM6IGE2NzcxZjM0
M2FmOSAoImlvX3VyaW5nOiBkcm9wIGFueSBjb2RlIHJlbGF0ZWQgdG8gU0NNX1JJR0hUUyIp
ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191
cmluZy9pb191cmluZy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lv
X3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggZmM2MDM5NmM5MDM5Li45M2Y5ZWNlZGM1OWYgMTAw
NjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcu
YwpAQCAtODI0Nyw3ICs4MjQ3LDcgQEAgc3RhdGljIGludCBpb19zcWVfZmlsZXNfcmVnaXN0
ZXIoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIHZvaWQgX191c2VyICphcmcsCiAJfQogCiAJ
aW9fcnNyY19ub2RlX3N3aXRjaChjdHgsIE5VTEwpOwotCXJldHVybiByZXQ7CisJcmV0dXJu
IDA7CiBvdXRfZnB1dDoKIAlmb3IgKGkgPSAwOyBpIDwgY3R4LT5ucl91c2VyX2ZpbGVzOyBp
KyspIHsKIAkJZmlsZSA9IGlvX2ZpbGVfZnJvbV9pbmRleChjdHgsIGkpOwotLSAKMi40My4w
Cgo=
--------------XB4gNHwm3QjWNGmdbTSLzSBj
Content-Type: text/x-patch; charset=UTF-8;
 name="5.15-0001-io_uring-ensure-0-is-returned-on-file-registration-s.patch"
Content-Disposition: attachment;
 filename*0="5.15-0001-io_uring-ensure-0-is-returned-on-file-registration";
 filename*1="-s.patch"
Content-Transfer-Encoding: base64

RnJvbSA1MWViZGMzYjA5OTZjYzQzNTAyYjI1ZTk1NjM3YzY2YmIwODNlMjUyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMiBBcHIgMjAyNCAwODoyODowNCAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nOiBlbnN1cmUgJzAnIGlzIHJldHVybmVkIG9uIGZpbGUgcmVnaXN0cmF0aW9uIHN1
Y2Nlc3MKCkEgcHJldmlvdXMgYmFja3BvcnQgbWlzdGFrZW5seSByZW1vdmVkIGNvZGUgdGhh
dCBjbGVhcmVkICdyZXQnIHRvIHplcm8sCmFzIHRoZSBTQ00gbG9nZ2luZyB3YXMgcGVyZm9y
bWVkLiBGaXggdXAgdGhlIHJldHVybiB2YWx1ZSBzbyB3ZSBkb24ndApyZXR1cm4gYW4gZXJy
YW50IGVycm9yIG9uIGZpeGVkIGZpbGUgcmVnaXN0cmF0aW9uLgoKRml4ZXM6IGQ5MDlkMzgx
YzMxNSAoImlvX3VyaW5nOiBkcm9wIGFueSBjb2RlIHJlbGF0ZWQgdG8gU0NNX1JJR0hUUyIp
ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191
cmluZy9pb191cmluZy5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lv
X3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggYTUxNDI5YzAzNDJlLi5mZjZjMzZhZWMyN2MgMTAw
NjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcu
YwpAQCAtODQyMiw3ICs4NDIyLDcgQEAgc3RhdGljIGludCBpb19zcWVfZmlsZXNfcmVnaXN0
ZXIoc3RydWN0IGlvX3JpbmdfY3R4ICpjdHgsIHZvaWQgX191c2VyICphcmcsCiAJfQogCiAJ
aW9fcnNyY19ub2RlX3N3aXRjaChjdHgsIE5VTEwpOwotCXJldHVybiByZXQ7CisJcmV0dXJu
IDA7CiBvdXRfZnB1dDoKIAlmb3IgKGkgPSAwOyBpIDwgY3R4LT5ucl91c2VyX2ZpbGVzOyBp
KyspIHsKIAkJZmlsZSA9IGlvX2ZpbGVfZnJvbV9pbmRleChjdHgsIGkpOwotLSAKMi40My4w
Cgo=

--------------XB4gNHwm3QjWNGmdbTSLzSBj--

