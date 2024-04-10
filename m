Return-Path: <stable+bounces-37952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383B889EF5B
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 12:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4771C20E26
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23DA154BF6;
	Wed, 10 Apr 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OBrIP0pP"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9E156C68
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743266; cv=none; b=DCnZ/NdE+3EO/CrrX/mDIlCuDH86EFMMk4JzLEmemdNfjqDKULo5HtkJJ8C/w4aK/76GL//xaNZdMzY1HMMy1j5F/cNKFWEoIzhwvHuDzvKm/OBi6myn4jXFpM6khmuDQVJCbhXx4x75hM9lc4RPn3v3B91xQGohdBRlkbAg+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743266; c=relaxed/simple;
	bh=Ps+iXm2rJB29VSKmeUorwg0BZGHtd9vyd/JrpJCmnM8=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=F0X7vMqGV0vi+E/bSmLafv5f1vViWLsxpnX20kvkWIsV06j4O8DKu8phesZFq5auzInPc5gwqg7KLUOUhOJjsryPXXvwoZ87YXerPm9GUn/ewqLGRALW2+Nf6KC3wNobwQ78iQBpBZI5iGe09oSLZOa7Oh38ptPGkQYYDjafglE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OBrIP0pP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so4999215a12.0
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712743261; x=1713348061; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps+iXm2rJB29VSKmeUorwg0BZGHtd9vyd/JrpJCmnM8=;
        b=OBrIP0pPt91nE2vOUdmTXcVUyRiZfAujiHZJLbmW7RJh0gTuGJaPajvNa0FmIFLUxw
         +mkiHOQyVWA1bIkmw07lGgPZmQsGxnEySeVq28wcn9FVwdTT+SmO6yJ03IH7Dr3t3Vlr
         BoBJCM0ZOZh0IHHvpnn5H+fizsHb6rZ2qDpfe9z+NiXAvIUPPwurQtr/7wzHGlZRFa03
         QQK6HlqLVueEIOON4aTCOIRuThcY8qE72VF1ijDgFpfA7EEBQ4OLQk7H/93zGW0V22Rr
         GCTXAPVLbRIvJw/lW7Dsfu5aL8MqssRvfAtLmdA6oe3/HDea5rjPfOorjI5jH/Jk/obO
         M8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712743261; x=1713348061;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ps+iXm2rJB29VSKmeUorwg0BZGHtd9vyd/JrpJCmnM8=;
        b=ABEpKHFvmfRe2c0AnRlFLmCODSj5fN0BHa/ak1gHkXHkV3dMaH+93sERJE/yzJt5wj
         TZ4385YVTY4ybP5GdzpDxXGqlwhePyVEOikvgWyfktltoDtTbs9zs7n5XGN7BXQrbmQJ
         lLxKq7hOVU2MbUMJV0Zs0A2C7ey6Mm38X4jrJJYg28VAsT1d187GiFsdkrW1s4le+z2n
         dGfb+Y9iSJjITNkiPpo/dkJdeoe6GBBgMllq83kT+QI20sBN/iIzqUlstbApPFRky6AZ
         qTG2LZUXSS2wiKKppMI7l4T/UJEZ9BBqvDiDFPhin6a3Cyn6LLarXxF/LL18XB0zjtA0
         d4pg==
X-Gm-Message-State: AOJu0YwbdE3EPSYOHPjSrDed6Ug9dX5MTMSxmBoxqMnC194vbqHFLINl
	dbtOQKGsBlxLndQsiiy74DEV0igpu1ww4qtruTx1Hi/2/lj/e4oz6BqZDlP0M1zpYS2cv88TRV0
	S
X-Google-Smtp-Source: AGHT+IGXME83A+qm5B9LcJoqESsDEhEgf83fwaPBOJISMdFiTAC3InWjDSWpf4EtwZFIEvuYoooeHQ==
X-Received: by 2002:a17:906:97c5:b0:a4e:39ed:2afd with SMTP id ef5-20020a17090697c500b00a4e39ed2afdmr1297659ejb.21.1712743261099;
        Wed, 10 Apr 2024 03:01:01 -0700 (PDT)
Received: from ?IPV6:2003:e5:8705:9b00:4df1:9dd5:4f97:24a? (p200300e587059b004df19dd54f97024a.dip0.t-ipconnect.de. [2003:e5:8705:9b00:4df1:9dd5:4f97:24a])
        by smtp.gmail.com with ESMTPSA id n2-20020a1709062bc200b00a517e505e3bsm6719315ejg.204.2024.04.10.03.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 03:01:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------T1OhHD1Xcb05nyyETCSei0C8"
Message-ID: <3363d9f7-cdc1-4e5e-a476-45e03f5e9b10@suse.com>
Date: Wed, 10 Apr 2024 12:00:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Dr. Neal Krawetz" <dr.krawetz@hackerfactor.com>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Backported patch for linux-5.4

This is a multi-part message in MIME format.
--------------T1OhHD1Xcb05nyyETCSei0C8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

there has been a report of a failure in a 5.4 based kernel, which has
been fixed in kernel 5.10 with commit abee7c494d8c41bb388839bccc47e06247f0d7de.

Please apply the attached backported patch to the stable 5.4 kernel.


Juergen
--------------T1OhHD1Xcb05nyyETCSei0C8
Content-Type: text/x-patch; charset=UTF-8; name="patch-for-5.4.patch"
Content-Disposition: attachment; filename="patch-for-5.4.patch"
Content-Transfer-Encoding: base64

RnJvbSBhYmVlN2M0OTRkOGM0MWJiMzg4ODM5YmNjYzQ3ZTA2MjQ3ZjBkN2RlIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
CkRhdGU6IEZyaSwgOSBPY3QgMjAyMCAxNjo0MjoyNSArMDIwMApTdWJqZWN0OiB4ODYvYWx0
ZXJuYXRpdmU6IERvbid0IGNhbGwgdGV4dF9wb2tlKCkgaW4gbGF6eSBUTEIgbW9kZQoKWyBV
cHN0cmVhbSBjb21taXQgIGFiZWU3YzQ5NGQ4YzQxYmIzODg4MzliY2NjNDdlMDYyNDdmMGQ3
ZGUgXQoKV2hlbiBydW5uaW5nIGluIGxhenkgVExCIG1vZGUgdGhlIGN1cnJlbnRseSBhY3Rp
dmUgcGFnZSB0YWJsZXMgbWlnaHQKYmUgdGhlIG9uZXMgb2YgYSBwcmV2aW91cyBwcm9jZXNz
LCBlLmcuIHdoZW4gcnVubmluZyBhIGtlcm5lbCB0aHJlYWQuCgpUaGlzIGNhbiBiZSBwcm9i
bGVtYXRpYyBpbiBjYXNlIGtlcm5lbCBjb2RlIGlzIGJlaW5nIG1vZGlmaWVkIHZpYQp0ZXh0
X3Bva2UoKSBpbiBhIGtlcm5lbCB0aHJlYWQsIGFuZCBvbiBhbm90aGVyIHByb2Nlc3NvciBl
eGl0X21tYXAoKQppcyBhY3RpdmUgZm9yIHRoZSBwcm9jZXNzIHdoaWNoIHdhcyBydW5uaW5n
IG9uIHRoZSBmaXJzdCBjcHUgYmVmb3JlCnRoZSBrZXJuZWwgdGhyZWFkLgoKQXMgdGV4dF9w
b2tlKCkgaXMgdXNpbmcgYSB0ZW1wb3JhcnkgYWRkcmVzcyBzcGFjZSBhbmQgdGhlIGZvcm1l
cgphZGRyZXNzIHNwYWNlIChvYnRhaW5lZCB2aWEgY3B1X3RsYnN0YXRlLmxvYWRlZF9tbSkg
aXMgcmVzdG9yZWQKYWZ0ZXJ3YXJkcywgdGhlcmUgaXMgYSByYWNlIHBvc3NpYmxlIGluIGNh
c2UgdGhlIGNwdSBvbiB3aGljaApleGl0X21tYXAoKSBpcyBydW5uaW5nIHdhbnRzIHRvIG1h
a2Ugc3VyZSB0aGVyZSBhcmUgbm8gc3RhbGUKcmVmZXJlbmNlcyB0byB0aGF0IGFkZHJlc3Mg
c3BhY2Ugb24gYW55IGNwdSBhY3RpdmUgKHRoaXMgZS5nLiBpcwpyZXF1aXJlZCB3aGVuIHJ1
bm5pbmcgYXMgYSBYZW4gUFYgZ3Vlc3QsIHdoZXJlIHRoaXMgcHJvYmxlbSBoYXMgYmVlbgpv
YnNlcnZlZCBhbmQgYW5hbHl6ZWQpLgoKSW4gb3JkZXIgdG8gYXZvaWQgdGhhdCwgZHJvcCBv
ZmYgVExCIGxhenkgbW9kZSBiZWZvcmUgc3dpdGNoaW5nIHRvIHRoZQp0ZW1wb3JhcnkgYWRk
cmVzcyBzcGFjZS4KCkZpeGVzOiBjZWZhOTI5YzAzNGViNWQgKCJ4ODYvbW06IEludHJvZHVj
ZSB0ZW1wb3JhcnkgbW0gc3RydWN0cyIpClNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4KU2lnbmVkLW9mZi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVs
KSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Ckxpbms6IGh0dHBzOi8vbGttbC5rZXJuZWwub3Jn
L3IvMjAyMDEwMDkxNDQyMjUuMTIwMTktMS1qZ3Jvc3NAc3VzZS5jb20KLS0tCiBhcmNoL3g4
Ni9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oIHwgOSArKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9tbXVfY29udGV4dC5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vbW11X2NvbnRleHQuaApp
bmRleCBjZGFhYjMwODgwYjkxLi5jZDZiZTZmMTQzZTg1IDEwMDY0NAotLS0gYS9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9tbXVfY29udGV4dC5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L21tdV9jb250ZXh0LmgKQEAgLTM3OSw2ICszNzksMTUgQEAgc3RhdGljIGlubGluZSB0ZW1w
X21tX3N0YXRlX3QgdXNlX3RlbXBvcmFyeV9tbShzdHJ1Y3QgbW1fc3RydWN0ICptbSkKIAl0
ZW1wX21tX3N0YXRlX3QgdGVtcF9zdGF0ZTsKIAogCWxvY2tkZXBfYXNzZXJ0X2lycXNfZGlz
YWJsZWQoKTsKKworCS8qCisJICogTWFrZSBzdXJlIG5vdCB0byBiZSBpbiBUTEIgbGF6eSBt
b2RlLCBhcyBvdGhlcndpc2Ugd2UnbGwgZW5kIHVwCisJICogd2l0aCBhIHN0YWxlIGFkZHJl
c3Mgc3BhY2UgV0lUSE9VVCBiZWluZyBpbiBsYXp5IG1vZGUgYWZ0ZXIKKwkgKiByZXN0b3Jp
bmcgdGhlIHByZXZpb3VzIG1tLgorCSAqLworCWlmICh0aGlzX2NwdV9yZWFkKGNwdV90bGJz
dGF0ZS5pc19sYXp5KSkKKwkJbGVhdmVfbW0oc21wX3Byb2Nlc3Nvcl9pZCgpKTsKKwogCXRl
bXBfc3RhdGUubW0gPSB0aGlzX2NwdV9yZWFkKGNwdV90bGJzdGF0ZS5sb2FkZWRfbW0pOwog
CXN3aXRjaF9tbV9pcnFzX29mZihOVUxMLCBtbSwgY3VycmVudCk7CiAKLS0gCmNnaXQgMS4y
LjMtMS5lbDcKCg==

--------------T1OhHD1Xcb05nyyETCSei0C8--

