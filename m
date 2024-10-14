Return-Path: <stable+bounces-83811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A50F99CB9C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82871F229CB
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620A81A7060;
	Mon, 14 Oct 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="duqbwf0q"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C001514CB
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912798; cv=none; b=RVAfHviC7bm+R6sMmWhmM4p5M6RtoNB95HHsipdleuKgimRATGfDmuQlHbeF9QLAcrF0HTROLub30OXVv9nQn/JUs99gU5yuGEgYZ37jMqMOdvtv1jBqNDcwHK5HDa5jmo0Zl9BAgjFgGMdDWobMkqD/F+lF1hNh5IGfCC7t2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912798; c=relaxed/simple;
	bh=WwToIEQOocvN3CeLBNDvT90zl/GwC8HGAgfulx8xAoA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=caVYoWREZhaIx8S2GQaI71gTMOh/gyGR1qjPCnKCcWwiR/RXOERRjCtd/MGhRG4BkjhX4pOupymLvCnESRV+faIwcP5uqTmIfDQc5vVgE5pc9tkIf/lwlvqcTstENoslmtEUI6V4uyL/hW73Igtp4Wj0/C1YoNT7lCXYFyjPVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=duqbwf0q; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-835496c8d6fso254443739f.0
        for <stable@vger.kernel.org>; Mon, 14 Oct 2024 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728912794; x=1729517594; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bF4M6gKMjodmuB9FqFf4d+JQYZA1cxdSCF0sMffl87k=;
        b=duqbwf0qyc6nkH+qLMSyazdWZG+m6ERY1a7nmslYc2ICFVy+BFLePVyn4UrwJ6ZFkm
         YznSe7RZ7Zku0yV0x27gKGaVzx9d0XG4MsjcCA7q8D5vJeYSgUPdpYHZFImmLmSVIYkR
         9W6gL5ere3W/slU6fIakPFrIdUOe938UMXJGCP3SGU6k8Bv8Gt1U98t500Gim0XHADKv
         VvAYWvpR8sGQWlc95+IkIvxe3v5Y2FxpGlkFPHnndvNILwxwhTfQiBLbI6gKtKkxCO0q
         bwyaKQBGcN0u0kxWlFNDn4Vz6ZAW3UtwikTdmrqJDAakKaLwrmz3hdGQeSA3p6YM05kp
         +P+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728912794; x=1729517594;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bF4M6gKMjodmuB9FqFf4d+JQYZA1cxdSCF0sMffl87k=;
        b=IkYbEL1Zdzhj/t2an7GSdUvZpFp+7ZfPsG5NdGmy61giC+Y0Pbvhh2mSTD8nZIvAyB
         TFKmOSUOUvQJeC7WmhQtasiYf6oFlwU8QbjNIdwowt0lTc8t+n6BodcLUub8EdrcBLLX
         3bbX9N+/ovmVVMft8+lRoS8FTjaz8BzDNgzVN+lPtS9Z20l3CQWbTOPW1ucMO+DoO+T1
         fOGqonUgst3bw5pl8XIkb0on/vdQHpByM5MgT8U5ci66JMtyJsIEua0nFQ6bibJ3rDLA
         aHNokbqgW07qzuZ0KeCyV3JrXjTUgsU6X6JsPHl3NsBySaU6CTCj8JnlDk2wr+TMqKcQ
         DG0g==
X-Gm-Message-State: AOJu0Yyiu0j+pGstMiS6UBeoP6JBF6vSrgyp+Te9APiFPaZOSjimjGj3
	fgabRrS7L8hQFSTkG7m9J/ai5g5zvdYF+JRmWpntEzGp+Mjlxtb31B3+IvOmT4Q=
X-Google-Smtp-Source: AGHT+IFJQLqdPcIrqn7lMV8o+hUD9LD5eVOm1iXxN4p3Cj921YNKpn+Cc1FMCNRtwBLrohUhigS5NA==
X-Received: by 2002:a05:6602:29d2:b0:82c:f8fb:2c23 with SMTP id ca18e2360f4ac-83a64d9fcb9mr633335539f.15.1728912794217;
        Mon, 14 Oct 2024 06:33:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbadada160sm5317859173.157.2024.10.14.06.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 06:33:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------nXjoRy95xhkuKAnWczztrf60"
Message-ID: <d2971cde-895e-4161-bed2-5661217050b7@kernel.dk>
Date: Mon, 14 Oct 2024 07:33:12 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/rw: fix cflags posting for single
 issue multishot" failed to apply to 6.11-stable tree
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
References: <2024101436-avalanche-approach-5c90@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024101436-avalanche-approach-5c90@gregkh>

This is a multi-part message in MIME format.
--------------nXjoRy95xhkuKAnWczztrf60
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/24 5:48 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.11-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
> git checkout FETCH_HEAD
> git cherry-pick -x c9d952b9103b600ddafc5d1c0e2f2dbd30f0b805
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101436-avalanche-approach-5c90@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Here's the tested backport of that patch.

-- 
Jens Axboe

--------------nXjoRy95xhkuKAnWczztrf60
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-rw-fix-cflags-posting-for-single-issue-mult.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-rw-fix-cflags-posting-for-single-issue-mult.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjNWJhZGE5NTExNWEyNTE1ZmRjMzBkODY3NWRiNjI4Y2ZhMzFlNGI3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+CkRh
dGU6IFNhdCwgNSBPY3QgMjAyNCAxOTowNjo1MCAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIGlv
X3VyaW5nL3J3OiBmaXggY2ZsYWdzIHBvc3RpbmcgZm9yIHNpbmdsZSBpc3N1ZSBtdWx0aXNo
b3QKIHJlYWQKCkNvbW1pdCBjOWQ5NTJiOTEwM2I2MDBkZGFmYzVkMWMwZTJmMmRiZDMwZjBi
ODA1IHVwc3RyZWFtLgoKSWYgbXVsdGlzaG90IGdldHMgZGlzYWJsZWQsIGFuZCBoZW5jZSB0
aGUgcmVxdWVzdCB3aWxsIGdldCB0ZXJtaW5hdGVkCnJhdGhlciB0aGFuIHBlcnNpc3QgZm9y
IG1vcmUgaXRlcmF0aW9ucywgdGhlbiBwb3N0aW5nIHRoZSBDUUUgd2l0aCB0aGUKcmlnaHQg
Y2ZsYWdzIGlzIHN0aWxsIGltcG9ydGFudC4gTW9zdCBub3RhYmx5LCB0aGUgYnVmZmVyIHJl
ZmVyZW5jZQpuZWVkcyB0byBiZSBpbmNsdWRlZC4KClJlZmFjdG9yIHRoZSByZXR1cm4gb2Yg
X19pb19yZWFkKCkgYSBiaXQsIHNvIHRoYXQgdGhlIHByb3ZpZGVkIGJ1ZmZlcgppcyBhbHdh
eXMgcHV0IGNvcnJlY3RseSwgYW5kIGhlbmNlIHJldHVybmVkIHRvIHRoZSBhcHBsaWNhdGlv
bi4KClJlcG9ydGVkLWJ5OiBTaGFyb24gUm9zbmVyIDxTaGFyb24gUm9zbmVyPgpMaW5rOiBo
dHRwczovL2dpdGh1Yi5jb20vYXhib2UvbGlidXJpbmcvaXNzdWVzLzEyNTcKQ2M6IHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDJhOTc1ZDQyNmM4MiAoImlvX3VyaW5nL3J3OiBk
b24ndCBhbGxvdyBtdWx0aXNob3QgcmVhZHMgd2l0aG91dCBOT1dBSVQgc3VwcG9ydCIpClNp
Z25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmlu
Zy9ydy5jIHwgMTkgKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW9fdXJpbmcvcncu
YyBiL2lvX3VyaW5nL3J3LmMKaW5kZXggNTZhNjlmMGU1ZDIzLi4yMTg1YTEzMmU3ZjUgMTAw
NjQ0Ci0tLSBhL2lvX3VyaW5nL3J3LmMKKysrIGIvaW9fdXJpbmcvcncuYwpAQCAtOTcyLDE3
ICs5NzIsMjEgQEAgaW50IGlvX3JlYWRfbXNob3Qoc3RydWN0IGlvX2tpb2NiICpyZXEsIHVu
c2lnbmVkIGludCBpc3N1ZV9mbGFncykKIAkJaWYgKGlzc3VlX2ZsYWdzICYgSU9fVVJJTkdf
Rl9NVUxUSVNIT1QpCiAJCQlyZXR1cm4gSU9VX0lTU1VFX1NLSVBfQ09NUExFVEU7CiAJCXJl
dHVybiAtRUFHQUlOOwotCX0KLQotCS8qCi0JICogQW55IHN1Y2Nlc3NmdWwgcmV0dXJuIHZh
bHVlIHdpbGwga2VlcCB0aGUgbXVsdGlzaG90IHJlYWQgYXJtZWQuCi0JICovCi0JaWYgKHJl
dCA+IDAgJiYgcmVxLT5mbGFncyAmIFJFUV9GX0FQT0xMX01VTFRJU0hPVCkgeworCX0gZWxz
ZSBpZiAocmV0IDw9IDApIHsKKwkJaW9fa2J1Zl9yZWN5Y2xlKHJlcSwgaXNzdWVfZmxhZ3Mp
OworCQlpZiAocmV0IDwgMCkKKwkJCXJlcV9zZXRfZmFpbChyZXEpOworCX0gZWxzZSB7CiAJ
CS8qCi0JCSAqIFB1dCBvdXIgYnVmZmVyIGFuZCBwb3N0IGEgQ1FFLiBJZiB3ZSBmYWlsIHRv
IHBvc3QgYSBDUUUsIHRoZW4KKwkJICogQW55IHN1Y2Nlc3NmdWwgcmV0dXJuIHZhbHVlIHdp
bGwga2VlcCB0aGUgbXVsdGlzaG90IHJlYWQKKwkJICogYXJtZWQsIGlmIGl0J3Mgc3RpbGwg
c2V0LiBQdXQgb3VyIGJ1ZmZlciBhbmQgcG9zdCBhIENRRS4gSWYKKwkJICogd2UgZmFpbCB0
byBwb3N0IGEgQ1FFLCBvciBtdWx0aXNob3QgaXMgbm8gbG9uZ2VyIHNldCwgdGhlbgogCQkg
KiBqdW1wIHRvIHRoZSB0ZXJtaW5hdGlvbiBwYXRoLiBUaGlzIHJlcXVlc3QgaXMgdGhlbiBk
b25lLgogCQkgKi8KIAkJY2ZsYWdzID0gaW9fcHV0X2tidWYocmVxLCBpc3N1ZV9mbGFncyk7
CisJCWlmICghKHJlcS0+ZmxhZ3MgJiBSRVFfRl9BUE9MTF9NVUxUSVNIT1QpKQorCQkJZ290
byBkb25lOworCiAJCXJ3LT5sZW4gPSAwOyAvKiBzaW1pbGFybHkgdG8gYWJvdmUsIHJlc2V0
IGxlbiB0byAwICovCiAKIAkJaWYgKGlvX3JlcV9wb3N0X2NxZShyZXEsIHJldCwgY2ZsYWdz
IHwgSU9SSU5HX0NRRV9GX01PUkUpKSB7CkBAIC0xMDAzLDYgKzEwMDcsNyBAQCBpbnQgaW9f
cmVhZF9tc2hvdChzdHJ1Y3QgaW9fa2lvY2IgKnJlcSwgdW5zaWduZWQgaW50IGlzc3VlX2Zs
YWdzKQogCSAqIEVpdGhlciBhbiBlcnJvciwgb3Igd2UndmUgaGl0IG92ZXJmbG93IHBvc3Rp
bmcgdGhlIENRRS4gRm9yIGFueQogCSAqIG11bHRpc2hvdCByZXF1ZXN0LCBoaXR0aW5nIG92
ZXJmbG93IHdpbGwgdGVybWluYXRlIGl0LgogCSAqLworZG9uZToKIAlpb19yZXFfc2V0X3Jl
cyhyZXEsIHJldCwgY2ZsYWdzKTsKIAlpb19yZXFfcndfY2xlYW51cChyZXEsIGlzc3VlX2Zs
YWdzKTsKIAlpZiAoaXNzdWVfZmxhZ3MgJiBJT19VUklOR19GX01VTFRJU0hPVCkKLS0gCjIu
NDUuMgoK

--------------nXjoRy95xhkuKAnWczztrf60--

