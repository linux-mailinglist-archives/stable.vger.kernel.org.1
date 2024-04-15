Return-Path: <stable+bounces-39946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BDB8A5754
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 18:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B710285D5E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E008248F;
	Mon, 15 Apr 2024 16:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Oz6vgg5N"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E8C82486
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197566; cv=none; b=uOKM1GPcbGsg4FxBgtSWyeQTUMBQY7sH3WN3DBtgB7uut0Q3Tf7zvIBwvzq+Yf61NfWO5bhqv1GszLa26lcYA3cPjOriG7RD5umYagMo93FjXAgowFkxJEXKMCrDD5XRqrOO/9p+I9dn2ppeapJk7xtsdYflyNtT6BAmIiLw9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197566; c=relaxed/simple;
	bh=p31hEdXBsf9I9dzj9ViE+WOFjE5wITzlbedqB8W9BBo=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=OibbUQwxt26DA7kNFW/i90/y4ZFCvlOXK41fTIuPZ7FTD7hDLJaSZrxX6bEoalWpeUDVmM1UnSEUVi0wf3EsG5quDXhnDLk/qvXOw+NsYlsm7XK3IO6D0gOs+7Bd9zF+Jm5vUuDef7Fob7JpQzEmcuTnLbOcd7zpJq4NeJcGnYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Oz6vgg5N; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16199239f.0
        for <stable@vger.kernel.org>; Mon, 15 Apr 2024 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713197563; x=1713802363; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Asr1Kw7d+x+ByaHmtvXXVIu8CO89OBUT4OqpwRbp04o=;
        b=Oz6vgg5NBuosOCv6j3wcEt2EIx3ysl64pSfYkvGK7RFV/rRnsBZLGbGkHu2AWHy1ux
         eXtPBt+4LjRaR2Fzi/uma0pTquTtDFXkzNy2ccXtQTF8zgeH0NKlcZcikOY9xF1k9KXU
         chDd625ATOkZFsns+eUX7vS8x5fqk1HPU4Jb5l4JaTngfyc13awAN5PGdS6WuVhsJkqD
         5c9P+cvIw0JFP0/9OMV1N1GJ2V7TawGG+GDUP7+i5/SttzaNzgniKOekptfXeG0HzWbN
         hHmgM5Bi/AbjV0qYRrwxdkAxcRFsKku1CffC4chiwtR+KVKN84Z12hKtS3HYAZ+McoWo
         xl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197563; x=1713802363;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Asr1Kw7d+x+ByaHmtvXXVIu8CO89OBUT4OqpwRbp04o=;
        b=QkGBI6shj7qaon8SMwOhmUElUd+sfof/Al0+MT4tY5YM6WV8wu+l1omk5eQ+bWIGzQ
         K1M2CxJc9KWrz2ZabCXlkqosOMekfOZodAKPRRO/0a/yh8Z0V2mAKpXDs/0lz0YiGK8M
         jYPUPVGKll4UGJ9KXASIRcPjz8jGvjlYdN6gW+rnx0Ej74uXmHIY3ywZaEagYJl+vQy0
         kmIiKB+hxsFhWNDLKrajjUOBjBbuzveSebZHjjSxRlHNYA5B3yYvvrOjmV9cvcNAO8Ew
         XWBjzJ3HV1N+QsInRFmZCYACqEKR3/8qTw4i8j/iMBxcCp66fCk58/9ilYmEdTh6KWb4
         f3fg==
X-Gm-Message-State: AOJu0YxmljYTiZGNpQoc1Sw7QNIG3zxOPRUDESCypjWPekhxvZ1WIP0H
	SV4tDb+vva9k1ecTE2t/7FeHfMXtRTlQ8CDbTy17KpLrPL+7A1O2vo95zNycW6M=
X-Google-Smtp-Source: AGHT+IG9RyjhjE0JdcGiSZHGysJfBSCjkP05K2nsezCRCzV2y7XV/EKhGjx7HpiH6RHXOSc5nbMnYQ==
X-Received: by 2002:a5d:855a:0:b0:7d5:de23:13a9 with SMTP id b26-20020a5d855a000000b007d5de2313a9mr7306949ios.1.1713197563036;
        Mon, 15 Apr 2024 09:12:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca20-20020a0566381c1400b00482f756ccabsm1522387jab.179.2024.04.15.09.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:12:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------att0guBiLPiAh2T03Yh4JCFW"
Message-ID: <1a037b41-40ac-47a5-a38a-014652e9a870@kernel.dk>
Date: Mon, 15 Apr 2024 10:12:42 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: Fix io_cqring_wait() not
 restoring sigmask on" failed to apply to 6.6-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, izbyshev@ispras.ru
Cc: stable@vger.kernel.org
References: <2024041502-sandal-buckskin-2dd2@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024041502-sandal-buckskin-2dd2@gregkh>

This is a multi-part message in MIME format.
--------------att0guBiLPiAh2T03Yh4JCFW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 6:36 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x 978e5c19dfefc271e5550efba92fcef0d3f62864
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041502-sandal-buckskin-2dd2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Here's the 6.6-stable version.

-- 
Jens Axboe


--------------att0guBiLPiAh2T03Yh4JCFW
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-Fix-io_cqring_wait-not-restoring-sigmask-on.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-Fix-io_cqring_wait-not-restoring-sigmask-on.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBkYmU3NzgxMjE5MGU0YWNkMWU2ZGIxOWUyMWUyOWVjNmRmZDNlZmVkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4ZXkgSXpieXNoZXYgPGl6YnlzaGV2QGlzcHJh
cy5ydT4KRGF0ZTogRnJpLCA1IEFwciAyMDI0IDE1OjU1OjUxICswMzAwClN1YmplY3Q6IFtQ
QVRDSF0gaW9fdXJpbmc6IEZpeCBpb19jcXJpbmdfd2FpdCgpIG5vdCByZXN0b3Jpbmcgc2ln
bWFzayBvbgogZ2V0X3RpbWVzcGVjNjQoKSBmYWlsdXJlCgpDb21taXQgOTc4ZTVjMTlkZmVm
YzI3MWU1NTUwZWZiYTkyZmNlZjBkM2Y2Mjg2NCB1cHN0cmVhbS4KClRoaXMgYnVnIHdhcyBp
bnRyb2R1Y2VkIGluIGNvbW1pdCA5NTBlNzlkZDczMTMgKCJpb191cmluZzogbWlub3IKaW9f
Y3FyaW5nX3dhaXQoKSBvcHRpbWl6YXRpb24iKSwgd2hpY2ggd2FzIG1hZGUgaW4gcHJlcGFy
YXRpb24gZm9yCmFkYzg2ODJlYzY5MCAoImlvX3VyaW5nOiBBZGQgc3VwcG9ydCBmb3IgbmFw
aV9idXN5X3BvbGwiKS4gVGhlIGxhdHRlcgpnb3QgcmV2ZXJ0ZWQgaW4gY2IzMTgyMTY3MzI1
ICgiUmV2ZXJ0ICJpb191cmluZzogQWRkIHN1cHBvcnQgZm9yCm5hcGlfYnVzeV9wb2xsIiIp
LCBzbyBzaW1wbHkgdW5kbyB0aGUgZm9ybWVyIGFzIHdlbGwuCgpDYzogc3RhYmxlQHZnZXIu
a2VybmVsLm9yZwpGaXhlczogOTUwZTc5ZGQ3MzEzICgiaW9fdXJpbmc6IG1pbm9yIGlvX2Nx
cmluZ193YWl0KCkgb3B0aW1pemF0aW9uIikKU2lnbmVkLW9mZi1ieTogQWxleGV5IEl6Ynlz
aGV2IDxpemJ5c2hldkBpc3ByYXMucnU+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyNDA0MDUxMjU1NTEuMjM3MTQyLTEtaXpieXNoZXZAaXNwcmFzLnJ1ClNpZ25lZC1v
ZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9pb191
cmluZy5jIHwgMjYgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMyBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191
cmluZy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCA2MmZmN2NlZTVk
YjUuLmE1NjI4ZDI5YjliMSAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysg
Yi9pb191cmluZy9pb191cmluZy5jCkBAIC0yNTU5LDE5ICsyNTU5LDYgQEAgc3RhdGljIGlu
dCBpb19jcXJpbmdfd2FpdChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgaW50IG1pbl9ldmVu
dHMsCiAJaWYgKF9faW9fY3FyaW5nX2V2ZW50c191c2VyKGN0eCkgPj0gbWluX2V2ZW50cykK
IAkJcmV0dXJuIDA7CiAKLQlpZiAoc2lnKSB7Ci0jaWZkZWYgQ09ORklHX0NPTVBBVAotCQlp
ZiAoaW5fY29tcGF0X3N5c2NhbGwoKSkKLQkJCXJldCA9IHNldF9jb21wYXRfdXNlcl9zaWdt
YXNrKChjb25zdCBjb21wYXRfc2lnc2V0X3QgX191c2VyICopc2lnLAotCQkJCQkJICAgICAg
c2lnc3opOwotCQllbHNlCi0jZW5kaWYKLQkJCXJldCA9IHNldF91c2VyX3NpZ21hc2soc2ln
LCBzaWdzeik7Ci0KLQkJaWYgKHJldCkKLQkJCXJldHVybiByZXQ7Ci0JfQotCiAJaW5pdF93
YWl0cXVldWVfZnVuY19lbnRyeSgmaW93cS53cSwgaW9fd2FrZV9mdW5jdGlvbik7CiAJaW93
cS53cS5wcml2YXRlID0gY3VycmVudDsKIAlJTklUX0xJU1RfSEVBRCgmaW93cS53cS5lbnRy
eSk7CkBAIC0yNTg4LDYgKzI1NzUsMTkgQEAgc3RhdGljIGludCBpb19jcXJpbmdfd2FpdChz
dHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgaW50IG1pbl9ldmVudHMsCiAJCWlvd3EudGltZW91
dCA9IGt0aW1lX2FkZF9ucyh0aW1lc3BlYzY0X3RvX2t0aW1lKHRzKSwga3RpbWVfZ2V0X25z
KCkpOwogCX0KIAorCWlmIChzaWcpIHsKKyNpZmRlZiBDT05GSUdfQ09NUEFUCisJCWlmIChp
bl9jb21wYXRfc3lzY2FsbCgpKQorCQkJcmV0ID0gc2V0X2NvbXBhdF91c2VyX3NpZ21hc2so
KGNvbnN0IGNvbXBhdF9zaWdzZXRfdCBfX3VzZXIgKilzaWcsCisJCQkJCQkgICAgICBzaWdz
eik7CisJCWVsc2UKKyNlbmRpZgorCQkJcmV0ID0gc2V0X3VzZXJfc2lnbWFzayhzaWcsIHNp
Z3N6KTsKKworCQlpZiAocmV0KQorCQkJcmV0dXJuIHJldDsKKwl9CisKIAl0cmFjZV9pb191
cmluZ19jcXJpbmdfd2FpdChjdHgsIG1pbl9ldmVudHMpOwogCWRvIHsKIAkJaW50IG5yX3dh
aXQgPSAoaW50KSBpb3dxLmNxX3RhaWwgLSBSRUFEX09OQ0UoY3R4LT5yaW5ncy0+Y3EudGFp
bCk7Ci0tIAoyLjQzLjAKCg==

--------------att0guBiLPiAh2T03Yh4JCFW--

