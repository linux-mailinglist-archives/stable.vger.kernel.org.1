Return-Path: <stable+bounces-62598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FD393FD00
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 20:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96611C20C27
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A08915F303;
	Mon, 29 Jul 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HUiara1P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1516F0E7
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 18:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722276138; cv=none; b=E8ZPDLnSjK9xI76LG3kaTjB2PKpSwowBG9akp8/6JGIgeDhcGSZVaOC1XBySmHCgICLc9jkBqb9m3HAIbwc5j0a0qxOcN6DzLpyfw6RccG/lKe5Le0Dc0e9VSC1jtyVwQ3trAEzeowRJo3TOrupMa4a2+9HdTEK6JMz69Ayk1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722276138; c=relaxed/simple;
	bh=dmOZftPyuH8OU2K606SY8tcRn4//Dy7GEnd2RdiU6n0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=h/SSY8l2jCbKJuq8mk7pexPdWsHehGtHc5nOFXNaFn/PbX3cCjHJp3XCpVmZmALHzvEvyX9JqXOyD3mJM6pHCugm9rACvlYduEFQ01GSRqA94xOMsRpxZe24i8fKlUi6HxL/Me9vOJbMeNlFuYYipKta2pjJ76E5PTUoHeia7uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HUiara1P; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d26cb8f71so121186b3a.2
        for <stable@vger.kernel.org>; Mon, 29 Jul 2024 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722276136; x=1722880936; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBr8JwO+erLdh/4Om9xBQS8dhExxuwCD9syR463MDWA=;
        b=HUiara1PZ0E6q30Tv+UjcVpbk5OXEcx4ogZjE3CBm7ze/yNEueX04CVngEXzmfySrn
         jRoWKmkM23d3PJ7kFLpoZdfzIihJvqv4DZDagsWLBtIBqHK11Rdkgp4iyx7zh9O7q093
         Slb0dKBqME2gTbOIlfjIVnGJ2EPz+3FfAOU/q8iKedRfa887xC4gBaojgRXJv/DakLTA
         +JIbB3ghTVbGKUnStFtyLRplQwUMOJgbGdsUk/fFbsZeN2fJHDEalWaENWLTvxBG62Mv
         XNPJlk3t6ao7aeaazxw/v1KUFga7Eao9lNnqlTsh03DCn9kRKvEmwrBN3prXnsnkFjr0
         pL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722276136; x=1722880936;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bBr8JwO+erLdh/4Om9xBQS8dhExxuwCD9syR463MDWA=;
        b=l3kOa9RYAjk8291w2oCg+VJJCIdB7kVdkS1uw0K4DXg4wE1zIAvos+ZFBEluIEn+Lc
         TC5s9r7M9PtmdIYLEK9cXeJywMexemTJMM+xBNXRn/sR54g27J8UEabQX7dzHnuwPhws
         h0YrHczzajczfMZHJwyDe0UqSB9oPOfzHPU22ECntrsOSnFBu9rQbHsEKmObXbqKZ5bq
         JzkjhyewuBFVIqsN/9bKKeljxRcPA8UAVTOa3MczrR/JPaC/+MlRzCHmvyspbgK6hqwp
         jiSXW2JBn/wV9mEjXpMBbi48V9a8fk5+GGMS1pq2PdfCNFN2ZfNyGzkMauHffl8fhl3l
         W6Ag==
X-Gm-Message-State: AOJu0YyY/EfYj0VE/BopfAQt8RcYEhAFeFqTvxTJl+irrptQo5lbUIkv
	GOr2Fb1ZilUHnYawJVrEk/k4PqC6D43BW7wqALiZyP7RxNns0Hib+oQ+VdX2LpDcW8cR0Wfy40J
	H
X-Google-Smtp-Source: AGHT+IEyU7DJ/oIdTjUo4xK4Di1Ew7E/V9xP3vKOMU4+leJ5LQlAwG739nRQSNfdYrXa58YMOe1GFA==
X-Received: by 2002:a05:6a21:9218:b0:1c3:c1d0:227 with SMTP id adf61e73a8af0-1c4774d95b0mr9605415637.8.1722276135817;
        Mon, 29 Jul 2024 11:02:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead89fda1sm7057113b3a.191.2024.07.29.11.02.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 11:02:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------xHqo50yS06uRBXoZslOq2E2m"
Message-ID: <51475de9-bb8c-495c-b556-3c1379e69687@kernel.dk>
Date: Mon, 29 Jul 2024 12:02:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/io-wq: limit retrying worker
 initialisation" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org, asml.silence@gmail.com, ju.orth@gmail.com
Cc: stable@vger.kernel.org
References: <2024072924-robin-manger-e92b@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024072924-robin-manger-e92b@gregkh>

This is a multi-part message in MIME format.
--------------xHqo50yS06uRBXoZslOq2E2m
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/24 1:55 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 0453aad676ff99787124b9b3af4a5f59fbe808e2
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072924-robin-manger-e92b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Here's the 5.10 and 5.15-stable variant of this.

-- 
Jens Axboe


--------------xHqo50yS06uRBXoZslOq2E2m
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-io_uring-io-wq-limit-retrying-worker-initialisation.patch"
Content-Disposition: attachment;
 filename*0="0002-io_uring-io-wq-limit-retrying-worker-initialisation.pat";
 filename*1="ch"
Content-Transfer-Encoding: base64

RnJvbSBlMmFhODFkNGZjMDg4ODllNDcyNTAzMTVmYmRiMGRiMTM2NWE4NDlkIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBCZWd1bmtvdiA8YXNtbC5zaWxlbmNlQGdt
YWlsLmNvbT4KRGF0ZTogV2VkLCAxMCBKdWwgMjAyNCAxODo1ODoxNyArMDEwMApTdWJqZWN0
OiBbUEFUQ0ggMi8yXSBpb191cmluZy9pby13cTogbGltaXQgcmV0cnlpbmcgd29ya2VyIGlu
aXRpYWxpc2F0aW9uCgpjb21taXQgMDQ1M2FhZDY3NmZmOTk3ODcxMjRiOWIzYWY0YTVmNTlm
YmU4MDhlMiB1cHN0cmVhbS4KCklmIGlvLXdxIHdvcmtlciBjcmVhdGlvbiBmYWlscywgd2Ug
cmV0cnkgaXQgYnkgcXVldWVpbmcgdXAgYSB0YXNrX3dvcmsuCnRhc0tfd29yayBpcyBuZWVk
ZWQgYmVjYXVzZSBpdCBzaG91bGQgYmUgZG9uZSBmcm9tIHRoZSB1c2VyIHByb2Nlc3MKY29u
dGV4dC4gVGhlIHByb2JsZW0gaXMgdGhhdCByZXRyaWVzIGFyZSBub3QgbGltaXRlZCwgYW5k
IGlmIHF1ZXVlaW5nIGEKdGFza193b3JrIGlzIHRoZSByZWFzb24gZm9yIHRoZSBmYWlsdXJl
LCB3ZSBtaWdodCBnZXQgaW50byBhbiBpbmZpbml0ZQpsb29wLgoKSXQgZG9lc24ndCBzZWVt
IHRvIGhhcHBlbiBub3cgYnV0IGl0IHdvdWxkIHdpdGggdGhlIGZvbGxvd2luZyBwYXRjaApl
eGVjdXRpbmcgdGFza193b3JrIGluIHRoZSBmcmVlemVyJ3MgbG9vcC4gRm9yIG5vdywgYXJi
aXRyYXJpbHkgbGltaXQgdGhlCm51bWJlciBvZiBhdHRlbXB0cyB0byBjcmVhdGUgYSB3b3Jr
ZXIuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogMzE0NmNiYTk5YWEyOCAo
ImlvLXdxOiBtYWtlIHdvcmtlciBjcmVhdGlvbiByZXNpbGllbnQgYWdhaW5zdCBzaWduYWxz
IikKUmVwb3J0ZWQtYnk6IEp1bGlhbiBPcnRoIDxqdS5vcnRoQGdtYWlsLmNvbT4KU2lnbmVk
LW9mZi1ieTogUGF2ZWwgQmVndW5rb3YgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+Ckxpbms6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvODI4MDQzNjkyNWRiODg0NDhjN2M4NWM2NjU2
ZWRlZTFhNDMwMjllYS4xNzIwNjM0MTQ2LmdpdC5hc21sLnNpbGVuY2VAZ21haWwuY29tClNp
Z25lZC1vZmYtYnk6IEplbnMgQXhib2UgPGF4Ym9lQGtlcm5lbC5kaz4KLS0tCiBpb191cmlu
Zy9pby13cS5jIHwgMTAgKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9pby13cS5jIGIv
aW9fdXJpbmcvaW8td3EuYwppbmRleCBmZTg1OTRhMDM5NmMuLmM1ZDI0OWY1ZDIxNCAxMDA2
NDQKLS0tIGEvaW9fdXJpbmcvaW8td3EuYworKysgYi9pb191cmluZy9pby13cS5jCkBAIC0x
OSw2ICsxOSw3IEBACiAjaW5jbHVkZSAiaW8td3EuaCIKIAogI2RlZmluZSBXT1JLRVJfSURM
RV9USU1FT1VUCSg1ICogSFopCisjZGVmaW5lIFdPUktFUl9JTklUX0xJTUlUCTMKIAogZW51
bSB7CiAJSU9fV09SS0VSX0ZfVVAJCT0gMSwJLyogdXAgYW5kIGFjdGl2ZSAqLwpAQCAtNTQs
NiArNTUsNyBAQCBzdHJ1Y3QgaW9fd29ya2VyIHsKIAl1bnNpZ25lZCBsb25nIGNyZWF0ZV9z
dGF0ZTsKIAlzdHJ1Y3QgY2FsbGJhY2tfaGVhZCBjcmVhdGVfd29yazsKIAlpbnQgY3JlYXRl
X2luZGV4OworCWludCBpbml0X3JldHJpZXM7CiAKIAl1bmlvbiB7CiAJCXN0cnVjdCByY3Vf
aGVhZCByY3U7CkBAIC03MzIsNyArNzM0LDcgQEAgc3RhdGljIGJvb2wgaW9fd3Ffd29ya19t
YXRjaF9hbGwoc3RydWN0IGlvX3dxX3dvcmsgKndvcmssIHZvaWQgKmRhdGEpCiAJcmV0dXJu
IHRydWU7CiB9CiAKLXN0YXRpYyBpbmxpbmUgYm9vbCBpb19zaG91bGRfcmV0cnlfdGhyZWFk
KGxvbmcgZXJyKQorc3RhdGljIGlubGluZSBib29sIGlvX3Nob3VsZF9yZXRyeV90aHJlYWQo
c3RydWN0IGlvX3dvcmtlciAqd29ya2VyLCBsb25nIGVycikKIHsKIAkvKgogCSAqIFByZXZl
bnQgcGVycGV0dWFsIHRhc2tfd29yayByZXRyeSwgaWYgdGhlIHRhc2sgKG9yIGl0cyBncm91
cCkgaXMKQEAgLTc0MCw2ICs3NDIsOCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaW9fc2hvdWxk
X3JldHJ5X3RocmVhZChsb25nIGVycikKIAkgKi8KIAlpZiAoZmF0YWxfc2lnbmFsX3BlbmRp
bmcoY3VycmVudCkpCiAJCXJldHVybiBmYWxzZTsKKwlpZiAod29ya2VyLT5pbml0X3JldHJp
ZXMrKyA+PSBXT1JLRVJfSU5JVF9MSU1JVCkKKwkJcmV0dXJuIGZhbHNlOwogCiAJc3dpdGNo
IChlcnIpIHsKIAljYXNlIC1FQUdBSU46CkBAIC03NjYsNyArNzcwLDcgQEAgc3RhdGljIHZv
aWQgY3JlYXRlX3dvcmtlcl9jb250KHN0cnVjdCBjYWxsYmFja19oZWFkICpjYikKIAkJaW9f
aW5pdF9uZXdfd29ya2VyKHdxZSwgd29ya2VyLCB0c2spOwogCQlpb193b3JrZXJfcmVsZWFz
ZSh3b3JrZXIpOwogCQlyZXR1cm47Ci0JfSBlbHNlIGlmICghaW9fc2hvdWxkX3JldHJ5X3Ro
cmVhZChQVFJfRVJSKHRzaykpKSB7CisJfSBlbHNlIGlmICghaW9fc2hvdWxkX3JldHJ5X3Ro
cmVhZCh3b3JrZXIsIFBUUl9FUlIodHNrKSkpIHsKIAkJc3RydWN0IGlvX3dxZV9hY2N0ICph
Y2N0ID0gaW9fd3FlX2dldF9hY2N0KHdvcmtlcik7CiAKIAkJYXRvbWljX2RlYygmYWNjdC0+
bnJfcnVubmluZyk7CkBAIC04MzEsNyArODM1LDcgQEAgc3RhdGljIGJvb2wgY3JlYXRlX2lv
X3dvcmtlcihzdHJ1Y3QgaW9fd3EgKndxLCBzdHJ1Y3QgaW9fd3FlICp3cWUsIGludCBpbmRl
eCkKIAl0c2sgPSBjcmVhdGVfaW9fdGhyZWFkKGlvX3dxZV93b3JrZXIsIHdvcmtlciwgd3Fl
LT5ub2RlKTsKIAlpZiAoIUlTX0VSUih0c2spKSB7CiAJCWlvX2luaXRfbmV3X3dvcmtlcih3
cWUsIHdvcmtlciwgdHNrKTsKLQl9IGVsc2UgaWYgKCFpb19zaG91bGRfcmV0cnlfdGhyZWFk
KFBUUl9FUlIodHNrKSkpIHsKKwl9IGVsc2UgaWYgKCFpb19zaG91bGRfcmV0cnlfdGhyZWFk
KHdvcmtlciwgUFRSX0VSUih0c2spKSkgewogCQlrZnJlZSh3b3JrZXIpOwogCQlnb3RvIGZh
aWw7CiAJfSBlbHNlIHsKLS0gCjIuNDMuMAoK

--------------xHqo50yS06uRBXoZslOq2E2m--

