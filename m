Return-Path: <stable+bounces-143268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1B1AB382B
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 15:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162A47AA671
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E189262FC9;
	Mon, 12 May 2025 13:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GHnkBlnB"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD98522F
	for <stable@vger.kernel.org>; Mon, 12 May 2025 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055560; cv=none; b=Bm9WUiAyeGd86XdhBChwwJZBvF36IxjfTG02pwks0G/zcY4Ob/IDV9x8FmGfigkn0/3fYjnqjgqLeTsEwLG84phRMhF1sE79h7bGMpegvrY9zZYQQ3ASzEJIYwIcRlcEd43wero8a5b+EsWwde2Du/VaQ1WOeV/JAUeZ6GXE+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055560; c=relaxed/simple;
	bh=3OrPmx0bvhSY6Us11+ed8nnyqt717S4A6B5p35YXbmI=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=qeKcSYqtE36FGN1cHsiXuueBR9qREoXanQl1hXl6AOIOIkAMEtdhXHGDb3RiJIBFq/JwW+y2aIzAekCfsV3ndDoBhJ807bwG6PbgQfe6zqGpmXQODP5G/EYfer97fDOa8yUS4SGQrUBvlBbCXW6MkSwXGHMfJ9RA+bJdWLQ8AsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GHnkBlnB; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-8616987c261so127681939f.3
        for <stable@vger.kernel.org>; Mon, 12 May 2025 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747055557; x=1747660357; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qd9kKrJx/B/X0+dzzm/MC472uDW1vuqnKct63I2ZUn8=;
        b=GHnkBlnBmOY/VOPLmcNpsLej6yZ1Ucrlbq5kzBHAzF58wZ66lq/UiRlCXFTKameZZc
         TLzLvseN21ZOU0wxDIj/AhnwNsyIF7M9oJSx5x8UIDW2LS9Yaf59opBfpC73VV6aHBYV
         sRPAKRFuBavOeteef/w5DNinpKjJxI4rF5JGgbGPGiDNEoLgOqLHDEpc2SIX3n7G8eMF
         6y1NKa5vFR9HOUnMgL8C5Jsk85hfDPyeg7Yn3Cb7thadaGqQ56rWgUM1CMN8AFPHANWM
         wWPzdTMW6pODP+2wI4Y/JDbLetXU2/C7jpTFfcx8yU0CYhfR1nnQ7e+ngjxWEMbVXu/8
         WMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055557; x=1747660357;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Qd9kKrJx/B/X0+dzzm/MC472uDW1vuqnKct63I2ZUn8=;
        b=UmhEFZxwVremG0SnjsyZJ6MkhSCexXPOqE5EbSiI/q3J8xPBYTafhwC8gCID2gc376
         HYuq8i/N0rRCiG5QvvdtXVt50yhZxkmFuAChti3vQeU/Phak+7pQjmSpf0HRU7jXa7W0
         Si1u12MBYHMchGqlrBg30AnumbpFp3Ud97TFH9yCeAUswbWw2ZXndBmlSaYliKf+gNFT
         HzzHAdejKDUzbsPhTp3ic5P3rzTA0aH08sdxcOAXxLjVm2Y2vapSkdCHR/4OpLnxRhP2
         Tp0srjyrL5w6wYoDWiWBcJI24tS9B0x1Pv5RtXNbAAsdXv9PVKxpf5nONa4JcPS33mKd
         2EEQ==
X-Gm-Message-State: AOJu0YyOoe1WIXvaZbtm9TDoUiUYFF76Do4ogUG/6dUCVddK2SF0Zhsh
	2+Qf5UyFYqirNBO0YWPvfwvEKImha9CCFB4JYki3kx/sYbKzXADD3QBWKHTthn8=
X-Gm-Gg: ASbGnctML1NdwglMJyXWCGlsErDR+b0sZtyDihEKC7F9JveWjYwmCKGZ4oLW5O6anRI
	4jCA9QYqy4gEg4P5tQzLqKGIYaHh8ULhDFj1ZedX/hcESgYkdjKQTSAcn8FTtu9QtHiO/nGrk50
	czUPMy5L4zzEqYqRreqcnO+j+p+b82zDmKvt+0p6XHfmv5OcnaIZWwbD1bK2HSKIUAJjq7oFQi6
	1jANcB4FtnSoQ8Hzh2F/NfvSs37qTjFYBFrYX7f4ICQ6ark4ghhxIHq6QnKPcXnK+o8U7buYkvO
	64+W4iNIw+LYi4vpa/nUEXPr533pBIf6/1Of9luHG15oym4=
X-Google-Smtp-Source: AGHT+IH/Ipf67dHsaxCZZJPUvpaDUbh4LQMPzuPABISEg8If2ixVAMs4B35g48/uqyNiKtR7WB+flA==
X-Received: by 2002:a05:6602:1692:b0:85b:3fda:7dbf with SMTP id ca18e2360f4ac-8676362c972mr1390887739f.9.1747055557062;
        Mon, 12 May 2025 06:12:37 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-867635d61b6sm187342739f.22.2025.05.12.06.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 06:12:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------wox3V9Urkma0Ipd07jMXmOBB"
Message-ID: <4372dd98-0f08-4f1f-af1f-31771b09d8d0@kernel.dk>
Date: Mon, 12 May 2025 07:12:35 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: always arm linked timeouts prior
 to issue" failed to apply to 6.14-stable tree
To: gregkh@linuxfoundation.org, chase@path.net
Cc: stable@vger.kernel.org
References: <2025051224-effects-slightly-6462@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2025051224-effects-slightly-6462@gregkh>

This is a multi-part message in MIME format.
--------------wox3V9Urkma0Ipd07jMXmOBB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/25 4:01 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.14-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Here's a tested 6.14-stable backport.

-- 
Jens Axboe

--------------wox3V9Urkma0Ipd07jMXmOBB
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-always-arm-linked-timeouts-prior-to-issue.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-always-arm-linked-timeouts-prior-to-issue.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSBhYzJjZGJjZjU2YjhhZDI4MzE5NDk4Yzc4ZjE3Zjc5YTczOTY1NjE1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFN1biwgNCBNYXkgMjAyNSAwODowNjoyOCAtMDYwMApTdWJqZWN0OiBbUEFUQ0ggMS8y
XSBpb191cmluZzogYWx3YXlzIGFybSBsaW5rZWQgdGltZW91dHMgcHJpb3IgdG8gaXNzdWUK
CkNvbW1pdCBiNTNlNTIzMjYxYmYwNThlYTRhNTE4YjQ4MjIyMmU3YTI3N2IxODZiIHVwc3Ry
ZWFtLgoKVGhlcmUgYXJlIGEgZmV3IHNwb3RzIHdoZXJlIGxpbmtlZCB0aW1lb3V0cyBhcmUg
YXJtZWQsIGFuZCBub3QgYWxsIG9mCnRoZW0gYWRoZXJlIHRvIHRoZSBwcmUtYXJtLCBhdHRl
bXB0IGlzc3VlLCBwb3N0LWFybSBwYXR0ZXJuLiBUaGlzIGNhbgpiZSBwcm9ibGVtYXRpYyBp
ZiB0aGUgbGlua2VkIHJlcXVlc3QgcmV0dXJucyB0aGF0IGl0IHdpbGwgdHJpZ2dlciBhCmNh
bGxiYWNrIGxhdGVyLCBhbmQgZG9lcyBzbyBiZWZvcmUgdGhlIGxpbmtlZCB0aW1lb3V0IGlz
IGZ1bGx5IGFybWVkLgoKQ29uc29saWRhdGUgYWxsIHRoZSBsaW5rZWQgdGltZW91dCBoYW5k
bGluZyBpbnRvIF9faW9faXNzdWVfc3FlKCksCnJhdGhlciB0aGFuIGhhdmUgaXQgc3ByZWFk
IHRocm91Z2hvdXQgdGhlIHZhcmlvdXMgaXNzdWUgZW50cnkgcG9pbnRzLgoKQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKTGluazogaHR0cHM6Ly9naXRodWIuY29tL2F4Ym9lL2xpYnVy
aW5nL2lzc3Vlcy8xMzkwClJlcG9ydGVkLWJ5OiBDaGFzZSBIaWx0eiA8Y2hhc2VAcGF0aC5u
ZXQ+ClNpZ25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBp
b191cmluZy9pb191cmluZy5jIHwgNTAgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgMzUg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvaW9fdXJpbmcuYyBiL2lvX3Vy
aW5nL2lvX3VyaW5nLmMKaW5kZXggMjRiOWU5YTUxMDVkLi41NmQ5MGRlNWMzODUgMTAwNjQ0
Ci0tLSBhL2lvX3VyaW5nL2lvX3VyaW5nLmMKKysrIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwpA
QCAtNDQzLDI0ICs0NDMsNiBAQCBzdGF0aWMgc3RydWN0IGlvX2tpb2NiICpfX2lvX3ByZXBf
bGlua2VkX3RpbWVvdXQoc3RydWN0IGlvX2tpb2NiICpyZXEpCiAJcmV0dXJuIHJlcS0+bGlu
azsKIH0KIAotc3RhdGljIGlubGluZSBzdHJ1Y3QgaW9fa2lvY2IgKmlvX3ByZXBfbGlua2Vk
X3RpbWVvdXQoc3RydWN0IGlvX2tpb2NiICpyZXEpCi17Ci0JaWYgKGxpa2VseSghKHJlcS0+
ZmxhZ3MgJiBSRVFfRl9BUk1fTFRJTUVPVVQpKSkKLQkJcmV0dXJuIE5VTEw7Ci0JcmV0dXJu
IF9faW9fcHJlcF9saW5rZWRfdGltZW91dChyZXEpOwotfQotCi1zdGF0aWMgbm9pbmxpbmUg
dm9pZCBfX2lvX2FybV9sdGltZW91dChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSkKLXsKLQlpb19x
dWV1ZV9saW5rZWRfdGltZW91dChfX2lvX3ByZXBfbGlua2VkX3RpbWVvdXQocmVxKSk7Ci19
Ci0KLXN0YXRpYyBpbmxpbmUgdm9pZCBpb19hcm1fbHRpbWVvdXQoc3RydWN0IGlvX2tpb2Ni
ICpyZXEpCi17Ci0JaWYgKHVubGlrZWx5KHJlcS0+ZmxhZ3MgJiBSRVFfRl9BUk1fTFRJTUVP
VVQpKQotCQlfX2lvX2FybV9sdGltZW91dChyZXEpOwotfQotCiBzdGF0aWMgdm9pZCBpb19w
cmVwX2FzeW5jX3dvcmsoc3RydWN0IGlvX2tpb2NiICpyZXEpCiB7CiAJY29uc3Qgc3RydWN0
IGlvX2lzc3VlX2RlZiAqZGVmID0gJmlvX2lzc3VlX2RlZnNbcmVxLT5vcGNvZGVdOwpAQCAt
NTEzLDcgKzQ5NSw2IEBAIHN0YXRpYyB2b2lkIGlvX3ByZXBfYXN5bmNfbGluayhzdHJ1Y3Qg
aW9fa2lvY2IgKnJlcSkKIAogc3RhdGljIHZvaWQgaW9fcXVldWVfaW93cShzdHJ1Y3QgaW9f
a2lvY2IgKnJlcSkKIHsKLQlzdHJ1Y3QgaW9fa2lvY2IgKmxpbmsgPSBpb19wcmVwX2xpbmtl
ZF90aW1lb3V0KHJlcSk7CiAJc3RydWN0IGlvX3VyaW5nX3Rhc2sgKnRjdHggPSByZXEtPnRj
dHg7CiAKIAlCVUdfT04oIXRjdHgpOwpAQCAtNTM4LDggKzUxOSw2IEBAIHN0YXRpYyB2b2lk
IGlvX3F1ZXVlX2lvd3Eoc3RydWN0IGlvX2tpb2NiICpyZXEpCiAKIAl0cmFjZV9pb191cmlu
Z19xdWV1ZV9hc3luY193b3JrKHJlcSwgaW9fd3FfaXNfaGFzaGVkKCZyZXEtPndvcmspKTsK
IAlpb193cV9lbnF1ZXVlKHRjdHgtPmlvX3dxLCAmcmVxLT53b3JrKTsKLQlpZiAobGluaykK
LQkJaW9fcXVldWVfbGlua2VkX3RpbWVvdXQobGluayk7CiB9CiAKIHN0YXRpYyB2b2lkIGlv
X3JlcV9xdWV1ZV9pb3dxX3R3KHN0cnVjdCBpb19raW9jYiAqcmVxLCBzdHJ1Y3QgaW9fdHdf
c3RhdGUgKnRzKQpAQCAtMTcyMCwxNyArMTY5OSwyNCBAQCBzdGF0aWMgYm9vbCBpb19hc3Np
Z25fZmlsZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgY29uc3Qgc3RydWN0IGlvX2lzc3VlX2Rl
ZiAqZGVmLAogCXJldHVybiAhIXJlcS0+ZmlsZTsKIH0KIAorI2RlZmluZSBSRVFfSVNTVUVf
U0xPV19GTEFHUwkoUkVRX0ZfQ1JFRFMgfCBSRVFfRl9BUk1fTFRJTUVPVVQpCisKIHN0YXRp
YyBpbnQgaW9faXNzdWVfc3FlKHN0cnVjdCBpb19raW9jYiAqcmVxLCB1bnNpZ25lZCBpbnQg
aXNzdWVfZmxhZ3MpCiB7CiAJY29uc3Qgc3RydWN0IGlvX2lzc3VlX2RlZiAqZGVmID0gJmlv
X2lzc3VlX2RlZnNbcmVxLT5vcGNvZGVdOwogCWNvbnN0IHN0cnVjdCBjcmVkICpjcmVkcyA9
IE5VTEw7CisJc3RydWN0IGlvX2tpb2NiICpsaW5rID0gTlVMTDsKIAlpbnQgcmV0OwogCiAJ
aWYgKHVubGlrZWx5KCFpb19hc3NpZ25fZmlsZShyZXEsIGRlZiwgaXNzdWVfZmxhZ3MpKSkK
IAkJcmV0dXJuIC1FQkFERjsKIAotCWlmICh1bmxpa2VseSgocmVxLT5mbGFncyAmIFJFUV9G
X0NSRURTKSAmJiByZXEtPmNyZWRzICE9IGN1cnJlbnRfY3JlZCgpKSkKLQkJY3JlZHMgPSBv
dmVycmlkZV9jcmVkcyhyZXEtPmNyZWRzKTsKKwlpZiAodW5saWtlbHkocmVxLT5mbGFncyAm
IFJFUV9JU1NVRV9TTE9XX0ZMQUdTKSkgeworCQlpZiAoKHJlcS0+ZmxhZ3MgJiBSRVFfRl9D
UkVEUykgJiYgcmVxLT5jcmVkcyAhPSBjdXJyZW50X2NyZWQoKSkKKwkJCWNyZWRzID0gb3Zl
cnJpZGVfY3JlZHMocmVxLT5jcmVkcyk7CisJCWlmIChyZXEtPmZsYWdzICYgUkVRX0ZfQVJN
X0xUSU1FT1VUKQorCQkJbGluayA9IF9faW9fcHJlcF9saW5rZWRfdGltZW91dChyZXEpOwor
CX0KIAogCWlmICghZGVmLT5hdWRpdF9za2lwKQogCQlhdWRpdF91cmluZ19lbnRyeShyZXEt
Pm9wY29kZSk7CkBAIC0xNzQwLDggKzE3MjYsMTIgQEAgc3RhdGljIGludCBpb19pc3N1ZV9z
cWUoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAlp
ZiAoIWRlZi0+YXVkaXRfc2tpcCkKIAkJYXVkaXRfdXJpbmdfZXhpdCghcmV0LCByZXQpOwog
Ci0JaWYgKGNyZWRzKQotCQlyZXZlcnRfY3JlZHMoY3JlZHMpOworCWlmICh1bmxpa2VseShj
cmVkcyB8fCBsaW5rKSkgeworCQlpZiAoY3JlZHMpCisJCQlyZXZlcnRfY3JlZHMoY3JlZHMp
OworCQlpZiAobGluaykKKwkJCWlvX3F1ZXVlX2xpbmtlZF90aW1lb3V0KGxpbmspOworCX0K
IAogCWlmIChyZXQgPT0gSU9VX09LKSB7CiAJCWlmIChpc3N1ZV9mbGFncyAmIElPX1VSSU5H
X0ZfQ09NUExFVEVfREVGRVIpCkBAIC0xNzU0LDcgKzE3NDQsNiBAQCBzdGF0aWMgaW50IGlv
X2lzc3VlX3NxZShzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2Zs
YWdzKQogCiAJaWYgKHJldCA9PSBJT1VfSVNTVUVfU0tJUF9DT01QTEVURSkgewogCQlyZXQg
PSAwOwotCQlpb19hcm1fbHRpbWVvdXQocmVxKTsKIAogCQkvKiBJZiB0aGUgb3AgZG9lc24n
dCBoYXZlIGEgZmlsZSwgd2UncmUgbm90IHBvbGxpbmcgZm9yIGl0ICovCiAJCWlmICgocmVx
LT5jdHgtPmZsYWdzICYgSU9SSU5HX1NFVFVQX0lPUE9MTCkgJiYgZGVmLT5pb3BvbGxfcXVl
dWUpCkBAIC0xNzk3LDggKzE3ODYsNiBAQCB2b2lkIGlvX3dxX3N1Ym1pdF93b3JrKHN0cnVj
dCBpb193cV93b3JrICp3b3JrKQogCWVsc2UKIAkJcmVxX3JlZl9nZXQocmVxKTsKIAotCWlv
X2FybV9sdGltZW91dChyZXEpOwotCiAJLyogZWl0aGVyIGNhbmNlbGxlZCBvciBpby13cSBp
cyBkeWluZywgc28gZG9uJ3QgdG91Y2ggdGN0eC0+aW93cSAqLwogCWlmIChhdG9taWNfcmVh
ZCgmd29yay0+ZmxhZ3MpICYgSU9fV1FfV09SS19DQU5DRUwpIHsKIGZhaWw6CkBAIC0xOTE0
LDE1ICsxOTAxLDExIEBAIHN0cnVjdCBmaWxlICppb19maWxlX2dldF9ub3JtYWwoc3RydWN0
IGlvX2tpb2NiICpyZXEsIGludCBmZCkKIHN0YXRpYyB2b2lkIGlvX3F1ZXVlX2FzeW5jKHN0
cnVjdCBpb19raW9jYiAqcmVxLCBpbnQgcmV0KQogCV9fbXVzdF9ob2xkKCZyZXEtPmN0eC0+
dXJpbmdfbG9jaykKIHsKLQlzdHJ1Y3QgaW9fa2lvY2IgKmxpbmtlZF90aW1lb3V0OwotCiAJ
aWYgKHJldCAhPSAtRUFHQUlOIHx8IChyZXEtPmZsYWdzICYgUkVRX0ZfTk9XQUlUKSkgewog
CQlpb19yZXFfZGVmZXJfZmFpbGVkKHJlcSwgcmV0KTsKIAkJcmV0dXJuOwogCX0KIAotCWxp
bmtlZF90aW1lb3V0ID0gaW9fcHJlcF9saW5rZWRfdGltZW91dChyZXEpOwotCiAJc3dpdGNo
IChpb19hcm1fcG9sbF9oYW5kbGVyKHJlcSwgMCkpIHsKIAljYXNlIElPX0FQT0xMX1JFQURZ
OgogCQlpb19rYnVmX3JlY3ljbGUocmVxLCAwKTsKQEAgLTE5MzUsOSArMTkxOCw2IEBAIHN0
YXRpYyB2b2lkIGlvX3F1ZXVlX2FzeW5jKHN0cnVjdCBpb19raW9jYiAqcmVxLCBpbnQgcmV0
KQogCWNhc2UgSU9fQVBPTExfT0s6CiAJCWJyZWFrOwogCX0KLQotCWlmIChsaW5rZWRfdGlt
ZW91dCkKLQkJaW9fcXVldWVfbGlua2VkX3RpbWVvdXQobGlua2VkX3RpbWVvdXQpOwogfQog
CiBzdGF0aWMgaW5saW5lIHZvaWQgaW9fcXVldWVfc3FlKHN0cnVjdCBpb19raW9jYiAqcmVx
KQotLSAKMi40OS4wCgo=

--------------wox3V9Urkma0Ipd07jMXmOBB--

