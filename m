Return-Path: <stable+bounces-39945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD58A5735
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 18:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE991C228B4
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E42F82480;
	Mon, 15 Apr 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Lyyn9ia+"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2A7F7FD
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 16:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197482; cv=none; b=jGDZHHM38q/gmbR1glSadbcjF7CBPgO6Dw6MDsjsAUjbU2vQ6Uc/iubOWsW4u5a/h6swwd5LeZj3k+8QuOa8U60x5YeUNWy8+1/AdwsJVcrOmb31lDZn2o4ibawEEPhQKL0a2WDd/0VKp2Gsd1iYY0zD+IDhAt4tatPAHxkHsu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197482; c=relaxed/simple;
	bh=ObWEBcV/E/3uzONMm2521kJRIGgmqV/pG41ts/dc4N4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=mphL3UHBtP7jEGs5u3+ddTOJ05xVx/7HGSDp5w5ZdGv8PNCqa2VPzhgC6dcEhszPBR1x82KPr5fD9rimQu4xltXByu0nMe6B5BJH8Eas0ZIeuTXYpGQXqvZiFLsujuY3ZLV9wK29wgZg7hG+Zy2Phjx63SmHwhbyyNcwODB9GW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Lyyn9ia+; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36b00f8fbedso3741545ab.0
        for <stable@vger.kernel.org>; Mon, 15 Apr 2024 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713197477; x=1713802277; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loDjz8pHHK0wUkSgcyZLLhSlbGvUSIuEGdkqxNmYPKc=;
        b=Lyyn9ia+aAZgbsgvRcm1zakgAiCCrRvKwtes/wf27mHSP5l/gmMocdfj9lBjPqxXud
         OkTFj/oFFdo8K5/y3Mo4zFFqlUsG/i++LilXValSTRqesktOE9QlPJK8C79P/ay7McV6
         BIhDQSJLCni2E4zHdtiKlYTf4HW8ofFyztcc0s/ZYfutPMU46HCjJFOUZ8XqaVDIbSMp
         2D4Gzm+6UvJSaFLPHjTG2vGPrFHEX1LrxQRV8CfZzT7ls3uxzM8Ba6rDIJYn5R8B3clL
         0JDEE1HaAXFMl7riH7uvFNTn/2vdqSeSzG35cNLssBT1hCNloZ2vTJlkEedgaLd38MdF
         /tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197477; x=1713802277;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=loDjz8pHHK0wUkSgcyZLLhSlbGvUSIuEGdkqxNmYPKc=;
        b=xBtva7BBtou6qx/Bh5VKRKxwLGsgqa8y8/PeQF5PYW8VrfjLDiA/gwGVbKFw56RDc4
         BXot/06tJg8S84DnmBojvacqgfUdoflPZikshvTKQQmCJ1QGgWbC6fRTRyjP96CeKZoc
         jGw876u8utNVhuAAWJmtWqUewdnhd8Ey9thezci5rKEXwil2pflDE7xNyJOpvVJ/8tzE
         2tEVY++IfF/JYpIRjvWhTF34jCYilqPY2PdUe50r2gtP8TFy6G8NrjQx9pVaJOEhMQHT
         8TdZBMssu/YKkt18ufwxh272cr6PtESR171XSXcDkkWaEnbup2YYsz2W7NN9T5vadfxm
         gIAA==
X-Gm-Message-State: AOJu0Yz6vcw4fwkAYHdgmv//O2WUWYgzJaclx7z9TJFgM3VGcaITtg/o
	+7RAnqPM1XrOasVVz5UzpYhPRLyrU05Eqj/CzypOCClQHWlS/UxKafzdOzXVUEs=
X-Google-Smtp-Source: AGHT+IHIdaYRahBlWDNLeAspo1V1QBxFsa+w75yzLZq6msvkuA4VLeNpf4JEN5QGHl8r83o4zvhyZw==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr11432815ioh.0.1713197476741;
        Mon, 15 Apr 2024 09:11:16 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca20-20020a0566381c1400b00482f756ccabsm1522387jab.179.2024.04.15.09.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:11:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------yjVdkopHnAPeRKa5jws03aHN"
Message-ID: <41612754-ed58-41fa-8033-a96ddff4d4a6@kernel.dk>
Date: Mon, 15 Apr 2024 10:11:15 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: Fix io_cqring_wait() not
 restoring sigmask on" failed to apply to 6.8-stable tree
To: gregkh@linuxfoundation.org, izbyshev@ispras.ru
Cc: stable@vger.kernel.org
References: <2024041501-repulsion-purging-1a06@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024041501-repulsion-purging-1a06@gregkh>

This is a multi-part message in MIME format.
--------------yjVdkopHnAPeRKa5jws03aHN
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 6:36 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.8-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
> git checkout FETCH_HEAD
> git cherry-pick -x 978e5c19dfefc271e5550efba92fcef0d3f62864
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041501-repulsion-purging-1a06@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Here's the 6.8 version of this.

-- 
Jens Axboe


--------------yjVdkopHnAPeRKa5jws03aHN
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-Fix-io_cqring_wait-not-restoring-sigmask-on.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-Fix-io_cqring_wait-not-restoring-sigmask-on.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBiYzYyMTAxMTFiNDMxNGFiMzJhYTgxYzUxZTk3ZDZiODVkMzUzNDBhIE1vbiBTZXAg
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
cmluZy9pb191cmluZy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCAxYTlmOTZlZDI1
OWUuLjRmYmVkNThmNWE1NCAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysg
Yi9pb191cmluZy9pb191cmluZy5jCkBAIC0yNjAzLDE5ICsyNjAzLDYgQEAgc3RhdGljIGlu
dCBpb19jcXJpbmdfd2FpdChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgaW50IG1pbl9ldmVu
dHMsCiAJaWYgKF9faW9fY3FyaW5nX2V2ZW50c191c2VyKGN0eCkgPj0gbWluX2V2ZW50cykK
IAkJcmV0dXJuIDA7CiAKLQlpZiAoc2lnKSB7Ci0jaWZkZWYgQ09ORklHX0NPTVBBVAotCQlp
ZiAoaW5fY29tcGF0X3N5c2NhbGwoKSkKLQkJCXJldCA9IHNldF9jb21wYXRfdXNlcl9zaWdt
YXNrKChjb25zdCBjb21wYXRfc2lnc2V0X3QgX191c2VyICopc2lnLAotCQkJCQkJICAgICAg
c2lnc3opOwotCQllbHNlCi0jZW5kaWYKLQkJCXJldCA9IHNldF91c2VyX3NpZ21hc2soc2ln
LCBzaWdzeik7Ci0KLQkJaWYgKHJldCkKLQkJCXJldHVybiByZXQ7Ci0JfQotCiAJaW5pdF93
YWl0cXVldWVfZnVuY19lbnRyeSgmaW93cS53cSwgaW9fd2FrZV9mdW5jdGlvbik7CiAJaW93
cS53cS5wcml2YXRlID0gY3VycmVudDsKIAlJTklUX0xJU1RfSEVBRCgmaW93cS53cS5lbnRy
eSk7CkBAIC0yNjMyLDYgKzI2MTksMTkgQEAgc3RhdGljIGludCBpb19jcXJpbmdfd2FpdChz
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

--------------yjVdkopHnAPeRKa5jws03aHN--

