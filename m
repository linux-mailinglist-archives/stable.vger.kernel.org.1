Return-Path: <stable+bounces-169739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3E5B28303
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 17:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E7A177089
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5F3009EE;
	Fri, 15 Aug 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TBPk/cVZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B30302744
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272134; cv=none; b=t9z8+ry3VwhB+htu8T6UKRy4JqQq1CGtmIHRnJKDS0N8PbgKMUxSwMjYghccIkBAdAGnWe9mE1DjNVzSlZ9uEhGDx7om2uNnI2h18QNLhia8xnePC4x8c1E9YjGJJWyu9QipjRbe1DnlMGUxyF3HDo5ZAoZmrzSnlfjfqAepR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272134; c=relaxed/simple;
	bh=49L4BfchmF2txRMPjHxvAYKnjzA5TAauKqOm3X1NyNs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ZEfwdFMnPLhUoH+D2ebbqLZaLMTA0FJtc26E1QE3YrvJWTRLzpJ9Awrk8fKPpfxqzBQMhoSu2pme2j5Y5OWu1nXJQs8N8vOO1xOrnD9W2CFO08Qv7UJgloPP/BLVN6nBWBxBJgRaJIOCZzEa1nMZvKA+5Pd3hI1oaSlRK0DfXMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TBPk/cVZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47174c8e45so1795016a12.2
        for <stable@vger.kernel.org>; Fri, 15 Aug 2025 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755272131; x=1755876931; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ney2cD7RGKSfArn3kHweutAkee6mUkhJqdrQZLhlNIE=;
        b=TBPk/cVZmwDOJrtbZPXQ0nWtBbRW4qQFsJ0rqIALZzsMCJNaN/DUv7e7sLxjW2vwOc
         juSj+tZJ4iWMReqEu53/nYZNFCM8Pr9q/87DZWbnVHZCYPa+udJn3bUyhaZ7WPujGuVe
         bJzbqW7D9QySP0euv3Zw424Lg09q7azSWmGwNrjR0e7hRmOf79PHDVLm+0/CsA2Fmaxx
         RAVzl8E+ugnd7yV/NQo4W2o3V+gbZOPpV0kGTnbNcQTIg2CLny5mmcIPXcq6XEfEqDDe
         cYJHd0iN/lHsO+tiO0jJ1q5kVSAt0gyWgGCeppb2IdAh7G24tsU0SS1tsXFFSApgksa2
         WV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272131; x=1755876931;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ney2cD7RGKSfArn3kHweutAkee6mUkhJqdrQZLhlNIE=;
        b=tHt1M5x5+FSSLfLZiv3G6MV3FSgACf84//GNes612VcUOQKfyS2MYbxe3f32tJXvBX
         4LYxX83+pQPXzDqM9jotOmgFb1GQcC1ka+1bPswgk6un2O7JVyCpFc7CveYPApbqVnVf
         K/VyeLIK6rzO184s73Vokhin7H3AJH75M1cBsMmoI1RHgoFckQBGvR96Ot1SvnVtiYO5
         Y2vZ1vo63SEOGP1yo6NMf+4Lptk/XcIvpMIYzN7NfLitLqtGdEzPuBcXzt3ez1b5w3LE
         2TkfKGXeaczhJB5S8Km5D0U26+MlncxYD745RsKiVX4MeoQsoXXKNch9P9PAXEDfS+E1
         aB+g==
X-Gm-Message-State: AOJu0Yxqlj5q40OJKC0TmoDpdrn1qhdvFC8K7unYUSMiMPmoaUj4DazU
	oeWFUJJlPtmN98dD6EdPZzCWa/DKrvT3EsItMYTtLdRyOjDZwCqzAOlT6A5BCUhfCx0=
X-Gm-Gg: ASbGncs5c0jdQH5lqiHwawtMJnMxDOb8kPgKKFoQX3m+cCrjImZSnVNGlv0Id3bCKLm
	WCuK/WQomSDEVUNTg52HMciKvwvQtGgnvVr9l8RASwpAkeGl52+cbprZbVtlpXpUX2j1qCXkOcC
	dLylh2YPY77FvKohRcN72CI447quPADAq80+CIYSZSTrzdY6XVGyGHc+lmjIiEk5DwTrQg0o0Ey
	gZeNdYA3O10wgjh+3+bw+wtZnge9AB+wexsULxcNuYNdLflYjZY+7uIpLduJ9wu+oOfqrGy7K0t
	dNJ8+Lr81UwiyB5GB3f83lfNNRocu/jAR8RqOUnc9RHlHI3FrFq9Lk0mBA7RmAYZBtbjHT5XPlV
	kxDX/+5S0hOhRsEGFjdAL9xNE/PET3CxT2vA4bRaC
X-Google-Smtp-Source: AGHT+IFuhry3/Kvc+T5H5dHAXtYzhTCy/UhhUQWmYB281XJzIwl5kA6IsMlbHuoH/RP5/NzbDyslhQ==
X-Received: by 2002:a17:902:e945:b0:242:fbc6:6a83 with SMTP id d9443c01a7336-2446cb98f22mr34488755ad.0.1755272130743;
        Fri, 15 Aug 2025 08:35:30 -0700 (PDT)
Received: from [10.2.2.247] ([50.196.182.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446caa9306sm16660955ad.18.2025.08.15.08.35.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:35:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------rpnfdUp0DXlHr8AjOeRKw0Lp"
Message-ID: <75f257ff-21d3-4eae-afa1-a25cff16abe0@kernel.dk>
Date: Fri, 15 Aug 2025 09:35:28 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: commit partial buffers on
 retry" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, superman.xpt@gmail.com
Cc: stable@vger.kernel.org
References: <2025081548-whoops-aneurism-c7b1@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025081548-whoops-aneurism-c7b1@gregkh>

This is a multi-part message in MIME format.
--------------rpnfdUp0DXlHr8AjOeRKw0Lp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 9:26 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 41b70df5b38bc80967d2e0ed55cc3c3896bba781
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081548-whoops-aneurism-c7b1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Trivial reject, here's one for 6.12-stable.

-- 
Jens Axboe

--------------rpnfdUp0DXlHr8AjOeRKw0Lp
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-net-commit-partial-buffers-on-retry.patch"
Content-Disposition: attachment;
 filename="0001-io_uring-net-commit-partial-buffers-on-retry.patch"
Content-Transfer-Encoding: base64

RnJvbSBhNmRmZGE3ZGE1YzY1YjI4MmMxNjYzMzI2YmUxNmU1N2FlYzNkMWJkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFR1ZSwgMTIgQXVnIDIwMjUgMDg6MzA6MTEgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9uZXQ6IGNvbW1pdCBwYXJ0aWFsIGJ1ZmZlcnMgb24gcmV0cnkKClJpbmcgcHJv
dmlkZWQgYnVmZmVycyBhcmUgcG90ZW50aWFsbHkgb25seSB2YWxpZCB3aXRoaW4gdGhlIHNp
bmdsZQpleGVjdXRpb24gY29udGV4dCBpbiB3aGljaCB0aGV5IHdlcmUgYWNxdWlyZWQuIGlv
X3VyaW5nIGRlYWxzIHdpdGggdGhpcwphbmQgaW52YWxpZGF0ZXMgdGhlbSBvbiByZXRyeS4g
QnV0IG9uIHRoZSBuZXR3b3JraW5nIHNpZGUsIGlmCk1TR19XQUlUQUxMIGlzIHNldCwgb3Ig
aWYgdGhlIHNvY2tldCBpcyBvZiB0aGUgc3RyZWFtaW5nIHR5cGUgYW5kIHRvbwpsaXR0bGUg
d2FzIHByb2Nlc3NlZCwgdGhlbiBpdCB3aWxsIGhhbmcgb24gdG8gdGhlIGJ1ZmZlciByYXRo
ZXIgdGhhbgpyZWN5Y2xlIG9yIGNvbW1pdCBpdC4gVGhpcyBpcyBwcm9ibGVtYXRpYyBmb3Ig
dHdvIHJlYXNvbnM6CgoxKSBJZiBzb21lb25lIHVucmVnaXN0ZXJzIHRoZSBwcm92aWRlZCBi
dWZmZXIgcmluZyBiZWZvcmUgYSBsYXRlciByZXRyeSwKICAgdGhlbiB0aGUgcmVxLT5idWZf
bGlzdCB3aWxsIG5vIGxvbmdlciBiZSB2YWxpZC4KCjIpIElmIG11bHRpcGxlIHNvY2tlcnMg
YXJlIHVzaW5nIHRoZSBzYW1lIGJ1ZmZlciBncm91cCwgdGhlbiBtdWx0aXBsZQogICByZWNl
aXZlcyBjYW4gY29uc3VtZSB0aGUgc2FtZSBtZW1vcnkuIFRoaXMgY2FuIGNhdXNlIGRhdGEg
Y29ycnVwdGlvbgogICBpbiB0aGUgYXBwbGljYXRpb24sIGFzIGVpdGhlciByZWNlaXZlIGNv
dWxkIGxhbmQgaW4gdGhlIHNhbWUKICAgdXNlcnNwYWNlIGJ1ZmZlci4KCkZpeCB0aGlzIGJ5
IGRpc2FsbG93aW5nIHBhcnRpYWwgcmV0cmllcyBmcm9tIHBpbm5pbmcgYSBwcm92aWRlZCBi
dWZmZXIKYWNyb3NzIG11bHRpcGxlIGV4ZWN1dGlvbnMsIGlmIHJpbmcgcHJvdmlkZWQgYnVm
ZmVycyBhcmUgdXNlZC4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClJlcG9ydGVkLWJ5
OiBwdCB4IDxzdXBlcm1hbi54cHRAZ21haWwuY29tPgpGaXhlczogYzU2ZTAyMmMwYTI3ICgi
aW9fdXJpbmc6IGFkZCBzdXBwb3J0IGZvciB1c2VyIG1hcHBlZCBwcm92aWRlZCBidWZmZXIg
cmluZyIpClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0t
CiBpb191cmluZy9uZXQuYyB8IDI3ICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2lvX3VyaW5nL25ldC5jIGIvaW9fdXJpbmcvbmV0LmMKaW5kZXggMzU2Zjk1YzMz
YWEyLi5iN2M5Mzc2NWZjZmYgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL25ldC5jCisrKyBiL2lv
X3VyaW5nL25ldC5jCkBAIC00OTgsNiArNDk4LDE1IEBAIHN0YXRpYyBpbnQgaW9fYnVuZGxl
X25idWZzKHN0cnVjdCBpb19hc3luY19tc2doZHIgKmttc2csIGludCByZXQpCiAJcmV0dXJu
IG5idWZzOwogfQogCitzdGF0aWMgaW50IGlvX25ldF9rYnVmX3JlY3lsZShzdHJ1Y3QgaW9f
a2lvY2IgKnJlcSwKKwkJCSAgICAgIHN0cnVjdCBpb19hc3luY19tc2doZHIgKmttc2csIGlu
dCBsZW4pCit7CisJcmVxLT5mbGFncyB8PSBSRVFfRl9CTF9OT19SRUNZQ0xFOworCWlmIChy
ZXEtPmZsYWdzICYgUkVRX0ZfQlVGRkVSU19DT01NSVQpCisJCWlvX2tidWZfY29tbWl0KHJl
cSwgcmVxLT5idWZfbGlzdCwgbGVuLCBpb19idW5kbGVfbmJ1ZnMoa21zZywgbGVuKSk7CisJ
cmV0dXJuIC1FQUdBSU47Cit9CisKIHN0YXRpYyBpbmxpbmUgYm9vbCBpb19zZW5kX2Zpbmlz
aChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgaW50ICpyZXQsCiAJCQkJICBzdHJ1Y3QgaW9fYXN5
bmNfbXNnaGRyICprbXNnLAogCQkJCSAgdW5zaWduZWQgaXNzdWVfZmxhZ3MpCkBAIC01NjYs
OCArNTc1LDcgQEAgaW50IGlvX3NlbmRtc2coc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2ln
bmVkIGludCBpc3N1ZV9mbGFncykKIAkJCWttc2ctPm1zZy5tc2dfY29udHJvbGxlbiA9IDA7
CiAJCQlrbXNnLT5tc2cubXNnX2NvbnRyb2wgPSBOVUxMOwogCQkJc3ItPmRvbmVfaW8gKz0g
cmV0OwotCQkJcmVxLT5mbGFncyB8PSBSRVFfRl9CTF9OT19SRUNZQ0xFOwotCQkJcmV0dXJu
IC1FQUdBSU47CisJCQlyZXR1cm4gaW9fbmV0X2tidWZfcmVjeWxlKHJlcSwga21zZywgcmV0
KTsKIAkJfQogCQlpZiAocmV0ID09IC1FUkVTVEFSVFNZUykKIAkJCXJldCA9IC1FSU5UUjsK
QEAgLTY2NCw4ICs2NzIsNyBAQCBpbnQgaW9fc2VuZChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwg
dW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQogCQkJc3ItPmxlbiAtPSByZXQ7CiAJCQlzci0+
YnVmICs9IHJldDsKIAkJCXNyLT5kb25lX2lvICs9IHJldDsKLQkJCXJlcS0+ZmxhZ3MgfD0g
UkVRX0ZfQkxfTk9fUkVDWUNMRTsKLQkJCXJldHVybiAtRUFHQUlOOworCQkJcmV0dXJuIGlv
X25ldF9rYnVmX3JlY3lsZShyZXEsIGttc2csIHJldCk7CiAJCX0KIAkJaWYgKHJldCA9PSAt
RVJFU1RBUlRTWVMpCiAJCQlyZXQgPSAtRUlOVFI7CkBAIC0xMDY4LDggKzEwNzUsNyBAQCBp
bnQgaW9fcmVjdm1zZyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3Vl
X2ZsYWdzKQogCQl9CiAJCWlmIChyZXQgPiAwICYmIGlvX25ldF9yZXRyeShzb2NrLCBmbGFn
cykpIHsKIAkJCXNyLT5kb25lX2lvICs9IHJldDsKLQkJCXJlcS0+ZmxhZ3MgfD0gUkVRX0Zf
QkxfTk9fUkVDWUNMRTsKLQkJCXJldHVybiAtRUFHQUlOOworCQkJcmV0dXJuIGlvX25ldF9r
YnVmX3JlY3lsZShyZXEsIGttc2csIHJldCk7CiAJCX0KIAkJaWYgKHJldCA9PSAtRVJFU1RB
UlRTWVMpCiAJCQlyZXQgPSAtRUlOVFI7CkBAIC0xMjExLDggKzEyMTcsNyBAQCBpbnQgaW9f
cmVjdihzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQog
CQkJc3ItPmxlbiAtPSByZXQ7CiAJCQlzci0+YnVmICs9IHJldDsKIAkJCXNyLT5kb25lX2lv
ICs9IHJldDsKLQkJCXJlcS0+ZmxhZ3MgfD0gUkVRX0ZfQkxfTk9fUkVDWUNMRTsKLQkJCXJl
dHVybiAtRUFHQUlOOworCQkJcmV0dXJuIGlvX25ldF9rYnVmX3JlY3lsZShyZXEsIGttc2cs
IHJldCk7CiAJCX0KIAkJaWYgKHJldCA9PSAtRVJFU1RBUlRTWVMpCiAJCQlyZXQgPSAtRUlO
VFI7CkBAIC0xNDQxLDggKzE0NDYsNyBAQCBpbnQgaW9fc2VuZF96YyhzdHJ1Y3QgaW9fa2lv
Y2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2ZsYWdzKQogCQkJemMtPmxlbiAtPSByZXQ7
CiAJCQl6Yy0+YnVmICs9IHJldDsKIAkJCXpjLT5kb25lX2lvICs9IHJldDsKLQkJCXJlcS0+
ZmxhZ3MgfD0gUkVRX0ZfQkxfTk9fUkVDWUNMRTsKLQkJCXJldHVybiAtRUFHQUlOOworCQkJ
cmV0dXJuIGlvX25ldF9rYnVmX3JlY3lsZShyZXEsIGttc2csIHJldCk7CiAJCX0KIAkJaWYg
KHJldCA9PSAtRVJFU1RBUlRTWVMpCiAJCQlyZXQgPSAtRUlOVFI7CkBAIC0xNTAyLDggKzE1
MDYsNyBAQCBpbnQgaW9fc2VuZG1zZ196YyhzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWdu
ZWQgaW50IGlzc3VlX2ZsYWdzKQogCiAJCWlmIChyZXQgPiAwICYmIGlvX25ldF9yZXRyeShz
b2NrLCBmbGFncykpIHsKIAkJCXNyLT5kb25lX2lvICs9IHJldDsKLQkJCXJlcS0+ZmxhZ3Mg
fD0gUkVRX0ZfQkxfTk9fUkVDWUNMRTsKLQkJCXJldHVybiAtRUFHQUlOOworCQkJcmV0dXJu
IGlvX25ldF9rYnVmX3JlY3lsZShyZXEsIGttc2csIHJldCk7CiAJCX0KIAkJaWYgKHJldCA9
PSAtRVJFU1RBUlRTWVMpCiAJCQlyZXQgPSAtRUlOVFI7Ci0tIAoyLjUwLjEKCg==

--------------rpnfdUp0DXlHr8AjOeRKw0Lp--

