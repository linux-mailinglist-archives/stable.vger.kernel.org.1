Return-Path: <stable+bounces-81470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815B99355B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C044FB22418
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5571D2229;
	Mon,  7 Oct 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fUXwayiT"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961A156E4
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323364; cv=none; b=dqK7JQhW3vJc3oW+9CLuprI0HKYFlowoEthT0ih2NmlJq/ZZiL1SJhdi3Lck8KYCbOl7glNv4ULCKloi1Hq30YGml5pwrImqFyuKYLQz/Exi9YlM9KzfvPLnGCiYkii/yi3nL5BszsrvxfVKGBBu6YWmpk5cVI3ld16Z6xKCGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323364; c=relaxed/simple;
	bh=yrwrASI1NvLKsncJExB6CXjErvmUL4rQGV3fDTTOtGM=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=NxgxWv211wxXS8wFeY4ffESQrZHzl4hDWl2p8g0IoLM74fqM3o7qqzMigwQWnncqBteklYEFoVV7TCj3H1TRaYt7xF1/aScRg51RmGMYDkPkZdM9k/6XuCVTF/Zr5ziUeqGqY0lg4mQT3Yq5wMWBrCBYqy+qD1hE9JT5clgX47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fUXwayiT; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82ce1cd202cso208718839f.0
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728323360; x=1728928160; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8masw7Rupv6E0R6OBg49hOCG9jwNyex+uAhc1q9PXU=;
        b=fUXwayiTXIevo6huoqXNJQngs6OChRDd2kXlo73zS6H1VlidTU055DaSBiNiK+c4Am
         mYT124SBLxBj9JW09euOh/hfVExfBixhT1/8T+OD6v4CJqBok/et0wuzODOa93htZ8rY
         609YBD71uKPQTpmtYB/OxQXL0losRKXF3pMCKePZP3s678cH4DXM37FCwcqL/XWsQSXC
         zFsdcv+M/dM3aaMlib+oSFMpnRrtODOcHvpbVzCd9EmR6UcDKOMceDnht3ak4ikq4iYZ
         XFvu70wv0hvtG/O+ilDYBYU5SpoSxwdRJ64Zzq73mYgwTDv/3BGhBp69bPQshRBcFQc6
         ixhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728323360; x=1728928160;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x8masw7Rupv6E0R6OBg49hOCG9jwNyex+uAhc1q9PXU=;
        b=Evr4xG1bhxrVot422xbbkwZgbwWR+9xXpDM4gB0fVHV+3ZIfOvSqxqaSpg4JbHZnAJ
         M5HNrCg5JIuwwMXEPovJz4t8J0nkiWIYhCbg1XrY+Ap9IRJcm+9UT/OiPxiqy3KppD4L
         bKA4nct8cpdLKvkTGky8ck14Q5lLC+RrumqOxMwKnDi60qXNrzI+LLZNME8outdJWgQe
         ZCVU/rKnnX7+a+opM6vMEKXvDDG/q4SdzKLmQd2BUfdz3njFJBERPAADbHYfpnrGQ8h7
         73t3Bci3KqDufXRea8jl/M++zBErEvJfFWPaAwSwDOVWDuuEJnF+DYHW2E6uBev6u3fk
         VfeA==
X-Gm-Message-State: AOJu0YwLf4XTuhUJ1Fmx8WByNmPVzhgfstbsnplx2UdW7JcYmvb8HmlA
	ZxQzkyJtDa88V4UgaWM5CwBu63vx/Qyw20sFVexULPvnBPHJgAbROOGDapUjPdheXOS9bXiU4M8
	AofQ=
X-Google-Smtp-Source: AGHT+IGwMmhAnbDCfNC5LSnthbRAi7sUV2E69p8+XJO+lli/jdnqEDFXuckqf0HjMLOvcV5d/Zhpgg==
X-Received: by 2002:a05:6602:15c6:b0:82a:aa33:c8cf with SMTP id ca18e2360f4ac-834f7c5a9a1mr1385581339f.3.1728323360457;
        Mon, 07 Oct 2024 10:49:20 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503b152c5sm133521439f.36.2024.10.07.10.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:49:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ttAnHTqzDBU0Nwioh2O1rXxO"
Message-ID: <1d4d32fb-8831-4458-adcb-d9ae9ffb5f15@kernel.dk>
Date: Mon, 7 Oct 2024 11:49:19 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/net: harden multishot termination
 case for recv" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2024100732-pessimist-ambiguous-58e3@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024100732-pessimist-ambiguous-58e3@gregkh>

This is a multi-part message in MIME format.
--------------ttAnHTqzDBU0Nwioh2O1rXxO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/24 11:30 AM, gregkh@linuxfoundation.org wrote:
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
> git cherry-pick -x c314094cb4cfa6fc5a17f4881ead2dfebfa717a7
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100732-pessimist-ambiguous-58e3@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Ditto for 6.6-stable.

-- 
Jens Axboe

--------------ttAnHTqzDBU0Nwioh2O1rXxO
Content-Type: text/x-patch; charset=UTF-8;
 name="6.6-0001-io_uring-net-harden-multishot-termination-case-for-r.patch"
Content-Disposition: attachment;
 filename*0="6.6-0001-io_uring-net-harden-multishot-termination-case-for-";
 filename*1="r.patch"
Content-Transfer-Encoding: base64

RnJvbSA2OGQ2OTRlZGUyMjAyMDljOGY5ZmFkMzNjNzZhZDQxMzczODI2YTAzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFRodSwgMjYgU2VwIDIwMjQgMDc6MDg6MTAgLTA2MDAKU3ViamVjdDogW1BBVENIXSBp
b191cmluZy9uZXQ6IGhhcmRlbiBtdWx0aXNob3QgdGVybWluYXRpb24gY2FzZSBmb3IgcmVj
dgoKSWYgdGhlIHJlY3YgcmV0dXJucyB6ZXJvLCBvciBhbiBlcnJvciwgdGhlbiBpdCBkb2Vz
bid0IG1hdHRlciBpZiBtb3JlCmRhdGEgaGFzIGFscmVhZHkgYmVlbiByZWNlaXZlZCBmb3Ig
dGhpcyBidWZmZXIuIEEgY29uZGl0aW9uIGxpa2UgdGhhdApzaG91bGQgdGVybWluYXRlIHRo
ZSBtdWx0aXNob3QgcmVjZWl2ZS4gUmF0aGVyIHRoYW4gcGFzcyBpbiB0aGUKY29sbGVjdGVk
IHJldHVybiB2YWx1ZSwgcGFzcyBpbiB3aGV0aGVyIHRvIHRlcm1pbmF0ZSBvciBrZWVwIHRo
ZSByZWN2CmdvaW5nIHNlcGFyYXRlbHkuCgpOb3RlIHRoYXQgdGhpcyBpc24ndCBhIGJ1ZyBy
aWdodCBub3csIGFzIHRoZSBvbmx5IHdheSB0byBnZXQgdGhlcmUgaXMKdmlhIHNldHRpbmcg
TVNHX1dBSVRBTEwgd2l0aCBtdWx0aXNob3QgcmVjZWl2ZS4gQW5kIGlmIGFuIGFwcGxpY2F0
aW9uCmRvZXMgdGhhdCwgdGhlbiAtRUlOVkFMIGlzIHJldHVybmVkIGFueXdheS4gQnV0IGl0
IHNlZW1zIGxpa2UgYW4gZWFzeQpidWcgdG8gaW50cm9kdWNlLCBzbyBsZXQncyBtYWtlIGl0
IGEgYml0IG1vcmUgZXhwbGljaXQuCgpMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vYXhib2Uv
bGlidXJpbmcvaXNzdWVzLzEyNDYKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6
IGIzZmRlYTZlY2I1NSAoImlvX3VyaW5nOiBtdWx0aXNob3QgcmVjdiIpClNpZ25lZC1vZmYt
Ynk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmluZy9uZXQuYyB8
IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2lvX3VyaW5nL25ldC5jIGIvaW9fdXJpbmcvbmV0LmMKaW5kZXgg
Y2YxMDYwZmIwNGY0Li43NDEyOTA0Mzg3YmYgMTAwNjQ0Ci0tLSBhL2lvX3VyaW5nL25ldC5j
CisrKyBiL2lvX3VyaW5nL25ldC5jCkBAIC05MzAsNiArOTMwLDcgQEAgaW50IGlvX3JlY3Yo
c3RydWN0IGlvX2tpb2NiICpyZXEsIHVuc2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAlpbnQg
cmV0LCBtaW5fcmV0ID0gMDsKIAlib29sIGZvcmNlX25vbmJsb2NrID0gaXNzdWVfZmxhZ3Mg
JiBJT19VUklOR19GX05PTkJMT0NLOwogCXNpemVfdCBsZW4gPSBzci0+bGVuOworCWJvb2wg
bXNob3RfZmluaXNoZWQ7CiAKIAlpZiAoIShyZXEtPmZsYWdzICYgUkVRX0ZfUE9MTEVEKSAm
JgogCSAgICAoc3ItPmZsYWdzICYgSU9SSU5HX1JFQ1ZTRU5EX1BPTExfRklSU1QpKQpAQCAt
OTk5LDYgKzEwMDAsNyBAQCBpbnQgaW9fcmVjdihzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5z
aWduZWQgaW50IGlzc3VlX2ZsYWdzKQogCQlyZXFfc2V0X2ZhaWwocmVxKTsKIAl9CiAKKwlt
c2hvdF9maW5pc2hlZCA9IHJldCA8PSAwOwogCWlmIChyZXQgPiAwKQogCQlyZXQgKz0gc3It
PmRvbmVfaW87CiAJZWxzZSBpZiAoc3ItPmRvbmVfaW8pCkBAIC0xMDA2LDcgKzEwMDgsNyBA
QCBpbnQgaW9fcmVjdihzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3Vl
X2ZsYWdzKQogCWVsc2UKIAkJaW9fa2J1Zl9yZWN5Y2xlKHJlcSwgaXNzdWVfZmxhZ3MpOwog
Ci0JaWYgKCFpb19yZWN2X2ZpbmlzaChyZXEsICZyZXQsICZtc2csIHJldCA8PSAwLCBpc3N1
ZV9mbGFncykpCisJaWYgKCFpb19yZWN2X2ZpbmlzaChyZXEsICZyZXQsICZtc2csIG1zaG90
X2ZpbmlzaGVkLCBpc3N1ZV9mbGFncykpCiAJCWdvdG8gcmV0cnlfbXVsdGlzaG90OwogCiAJ
cmV0dXJuIHJldDsKLS0gCjIuNDUuMgoK

--------------ttAnHTqzDBU0Nwioh2O1rXxO--

