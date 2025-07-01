Return-Path: <stable+bounces-159093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A07AEEBB6
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78663B8698
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64886250;
	Tue,  1 Jul 2025 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yediIvu3"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD170810
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751331793; cv=none; b=Ei5ZJPHeXjraa509UQbGMx+7tsQeVGQ1O3IzUgQWK/xEY/5z7LSmX+Me626GRmMNdgH6/kR3EF3c0v4qJIfjKev8v+ErILQSFOxlWdq/imK9732RJkhDRsKLFTwJTveG24SKUsklcsYYgUcUNr0ahYc4bqtJJJe2j+vq9fo1+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751331793; c=relaxed/simple;
	bh=+j3dwP1DvA4rIXfX7Dsi7Qy6/P2igjJs2YfiuPEJlRo=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=TQoVKQgQJagG/U5/1tNdtQNN16wgUkzcAsA5GOxtb1b9AishBVU5rne4y/4CKyG5nBEO5WOjiYXEt6MD+vFoMx3VSX+Oy/kzkKasnX0BFuiiAB5a59qFmPuzywAAm6cVsHMRLFCO2BKbTJ9IpMOmVWNP12e9zdk+HzcAYFPR4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yediIvu3; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df3854e622so13003935ab.1
        for <stable@vger.kernel.org>; Mon, 30 Jun 2025 18:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751331788; x=1751936588; darn=vger.kernel.org;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKBvXU1au9mT4Z3fHzj3RqCTuINklFHhfthWA1N0P+E=;
        b=yediIvu3+/DHfUSUFyJMobcCpv9Xd8LpmA403oEc0+4YtvztnH8fNew1pikF5PRQRx
         AQEZ4H9JyMVOhzL8tKnrCsXjeJvwsafCdV2t5bahO85xnyzwSQjgtTFjvVSOvwOld1NZ
         OD6pGBSfoc4g8mWk7qPYZ5nELbL6ewOtt1puVCM3WDkrDcW1tascE1ZbCGemDQWViMHu
         eQAHSYaqx6GCz6neLeELrYw8CD051eNbLmT73XQdnp2nlMpwxHtHzo2broVT7Kf7gnxc
         wCXvhvGI+cs+J+6DlxfWIABw2OrcSyazgV4VuRtue9HdFNIACaueVQT1nMaG/eO637tz
         /o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751331788; x=1751936588;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKBvXU1au9mT4Z3fHzj3RqCTuINklFHhfthWA1N0P+E=;
        b=Ku5n0CvKwNWyqSqf4VGkDqSE8B0TKlL7fZgCgzE4AdVrU6q+s0WP8uiON05/sG848D
         dz1CVjoDn8V12G2mbQ81AbyDVtQwCqOy4Q6Z27W5cFB/V9TjX8029Tbi2H4mRe10vsSL
         v33703wsveg58fQmfRA+k0+VXzusL+jR1OBl33W0Q5J3t8rFCahr6TGt0ySgXLOXAfJV
         87zbDuvBOtSLUTjrYuOYcCeFTeAcb1yniEMZIOWQFk988sq1lbnfAhyO0bxOHKb195/N
         K4uxeUrNRej0sGA1qAA2GWLiwqBbO9aFuGDlisyLGcj+du0VrMBeI8jQMDuawfa532En
         Bcpg==
X-Gm-Message-State: AOJu0Yzk9n9TigZxWDR0wN3+8W9uYO6qSSdgYn7rIjLRN3PwkglLxmb3
	XYhN0pabYPZPVDSTwp+dpsF+O2tZrBRXZdGc9/4RneeYhofToLIU6n+Bqtr9ykJRr9Hxx9gPEg1
	1rCcs
X-Gm-Gg: ASbGnctOiaXJkC3TuCQjS603fXcx8TVfEzhq+61UFHzET4OQfcuZcxnfazZAnnIaelO
	9m3OZeZHH0LimGJ2uY/QKbXuqKMB5+NfG0zt3Etr01qljD9GamNn6I6JNgjqnbg+wLE8r2wjGOR
	jf47Sd/9uYZKSsdJrh0GCDTICivlAbm+wMhmEZNicxQzYGIW8wHj83dyKyATL65tczcXzdMFTT2
	jwk0TCnyHXDkMzfE/7LdD12Vy82Jje806CIZbIY0zFbSl/+iYoHkeEi8OBogtYv+Y0b3/UNDGLZ
	QHK6LceAmmpunmLEkOdhlV1g0QYrOn2t6c++tn/y8dCXOlbey//wnfPUSvc=
X-Google-Smtp-Source: AGHT+IFs4kxwxl13t6AD6PIwmFq2r/G/IHGb7VlhfWnI3UYMtLFwdzoOpplW8Jl6yxd+FnNoFDUB+Q==
X-Received: by 2002:a05:6e02:dd0:b0:3df:2f9e:3da8 with SMTP id e9e14a558f8ab-3e0465ec333mr14597435ab.9.1751331788363;
        Mon, 30 Jun 2025 18:03:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50204aa8a44sm2226691173.108.2025.06.30.18.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 18:03:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------cLlH3Yp3W5Kmgs0FPt6JE3Dy"
Message-ID: <3dbc6a08-ad33-467b-babd-437d37312e90@kernel.dk>
Date: Mon, 30 Jun 2025 19:03:06 -0600
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
Subject: 6.15.5 stable request, regression from 6.15.3..6.15.4

This is a multi-part message in MIME format.
--------------cLlH3Yp3W5Kmgs0FPt6JE3Dy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Details in the patch attached, but an unrelated vfs change broke io_uring
for anon inode reading/writing. Please queue this up asap for 6.15.5 so we
don't have have any further 6.15-stable kernels with this regression.

You can also just cherry pick it, picks cleanly. Sha is:

6f11adcc6f36ffd8f33dbdf5f5ce073368975bc3

Thanks,
-- 
Jens Axboe


--------------cLlH3Yp3W5Kmgs0FPt6JE3Dy
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-gate-REQ_F_ISREG-on-S_ANON_INODE-as-well.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-gate-REQ_F_ISREG-on-S_ANON_INODE-as-well.patch"
Content-Transfer-Encoding: base64

RnJvbSBkMDBhMGRiNWVhMWQ2YzU1YzNmZGY5YzU4MjMzM2IzY2I1MTJjYjczIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFN1biwgMjkgSnVuIDIwMjUgMTY6NDg6MjggLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZzogZ2F0ZSBSRVFfRl9JU1JFRyBvbiAhU19BTk9OX0lOT0RFIGFzIHdlbGwKCkNv
bW1pdCA2ZjExYWRjYzZmMzZmZmQ4ZjMzZGJkZjVmNWNlMDczMzY4OTc1YmMzIHVwc3RyZWFt
LgoKaW9fdXJpbmcgbWFya3MgYSByZXF1ZXN0IGFzIGRlYWxpbmcgd2l0aCBhIHJlZ3VsYXIg
ZmlsZSBvbiBTX0lTUkVHLiBUaGlzCmRyaXZlcyB0aGluZ3MgbGlrZSByZXRyaWVzIG9uIHNo
b3J0IHJlYWRzIG9yIHdyaXRlcywgd2hpY2ggaXMgZ2VuZXJhbGx5Cm5vdCBleHBlY3RlZCBv
biBhIHJlZ3VsYXIgZmlsZSAob3IgYmRldikuIEFwcGxpY2F0aW9ucyB0ZW5kIHRvIG5vdApl
eHBlY3QgdGhhdCwgc28gaW9fdXJpbmcgdHJpZXMgaGFyZCB0byBlbnN1cmUgaXQgZG9lc24n
dCBkZWxpdmVyIHNob3J0CklPIG9uIHJlZ3VsYXIgZmlsZXMuCgpIb3dldmVyLCBhIHJlY2Vu
dCBjb21taXQgYWRkZWQgU19JRlJFRyB0byBhbm9ueW1vdXMgaW5vZGVzLiBXaGVuCmlvX3Vy
aW5nIGlzIHVzZWQgdG8gcmVhZCBmcm9tIHZhcmlvdXMgdGhpbmdzIHRoYXQgYXJlIGJhY2tl
ZCBieSBhbm9uCmlub2RlcywgbGlrZSBldmVudGZkLCB0aW1lcmZkLCBldGMsIHRoZW4gaXQn
bGwgbm93IGFsbCBvZiBhIHN1ZGRlbiB3YWl0CmZvciBtb3JlIGRhdGEgd2hlbiByYXRoZXIg
dGhhbiBkZWxpdmVyIHdoYXQgd2FzIHJlYWQgb3Igd3JpdHRlbiBpbiBhCnNpbmdsZSBvcGVy
YXRpb24uIFRoaXMgYnJlYWtzIGFwcGxpY2F0aW9ucyB0aGF0IGlzc3VlIHJlYWRzIG9uIGFu
b24KaW5vZGVzLCBpZiB0aGV5IGFzayBmb3IgbW9yZSBkYXRhIHRoYW4gYSBzaW5nbGUgcmVh
ZCBkZWxpdmVycy4KCkFkZCBhIGNoZWNrIGZvciAhU19BTk9OX0lOT0RFIGFzIHdlbGwgYmVm
b3JlIHNldHRpbmcgUkVRX0ZfSVNSRUcgdG8KcHJldmVudCB0aGF0LgoKQ2M6IENocmlzdGlh
biBCcmF1bmVyIDxicmF1bmVyQGtlcm5lbC5vcmc+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnCkxpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9naG9zdHR5LW9yZy9naG9zdHR5L2Rpc2N1
c3Npb25zLzc3MjAKRml4ZXM6IGNmZDg2ZWY3ZThlNyAoImFub25faW5vZGU6IHVzZSBhIHBy
b3BlciBtb2RlIGludGVybmFsbHkiKQpTaWduZWQtb2ZmLWJ5OiBKZW5zIEF4Ym9lIDxheGJv
ZUBrZXJuZWwuZGs+Ci0tLQogaW9fdXJpbmcvaW9fdXJpbmcuYyB8IDMgKystCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
aW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3VyaW5nL2lvX3VyaW5nLmMKaW5kZXggNzQyMThj
N2I3NjA0Li4yMTFmN2Y1ZjUwN2UgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMK
KysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpAQCAtMTY0NywxMSArMTY0NywxMiBAQCBzdGF0
aWMgdm9pZCBpb19pb3BvbGxfcmVxX2lzc3VlZChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5z
aWduZWQgaW50IGlzc3VlX2ZsYWdzKQogCiBpb19yZXFfZmxhZ3NfdCBpb19maWxlX2dldF9m
bGFncyhzdHJ1Y3QgZmlsZSAqZmlsZSkKIHsKKwlzdHJ1Y3QgaW5vZGUgKmlub2RlID0gZmls
ZV9pbm9kZShmaWxlKTsKIAlpb19yZXFfZmxhZ3NfdCByZXMgPSAwOwogCiAJQlVJTERfQlVH
X09OKFJFUV9GX0lTUkVHX0JJVCAhPSBSRVFfRl9TVVBQT1JUX05PV0FJVF9CSVQgKyAxKTsK
IAotCWlmIChTX0lTUkVHKGZpbGVfaW5vZGUoZmlsZSktPmlfbW9kZSkpCisJaWYgKFNfSVNS
RUcoaW5vZGUtPmlfbW9kZSkgJiYgIShpbm9kZS0+aV9mbGFncyAmIFNfQU5PTl9JTk9ERSkp
CiAJCXJlcyB8PSBSRVFfRl9JU1JFRzsKIAlpZiAoKGZpbGUtPmZfZmxhZ3MgJiBPX05PTkJM
T0NLKSB8fCAoZmlsZS0+Zl9tb2RlICYgRk1PREVfTk9XQUlUKSkKIAkJcmVzIHw9IFJFUV9G
X1NVUFBPUlRfTk9XQUlUOwotLSAKMi41MC4wCgo=

--------------cLlH3Yp3W5Kmgs0FPt6JE3Dy--

