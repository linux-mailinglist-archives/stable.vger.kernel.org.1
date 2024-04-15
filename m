Return-Path: <stable+bounces-39947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A808A577F
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839191C2248D
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1EA82886;
	Mon, 15 Apr 2024 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oKRJ14i6"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B711F8286A
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197837; cv=none; b=FuUrrZhUHTHbMR71TUEUZwtUzcl8LJGGLJ2piiCJ3uHhrdWq1m6kKpIUwp7ukxs4i0+7HhyHPbqeXlepArs4zxsnZw6Diu5Y1RM4L8sRfGwY9GJFce4KjbsFPCy7bm7BNU/z/rjmenWlPUfAfbU6bTbgtNxhAcnS6ZCrtjoJTWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197837; c=relaxed/simple;
	bh=DfdBeAeqT4zAf3cms9MXLqnBVlyJsx0fdBYns8xgSJ4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=K2NJ3GaRsiQm1pRRXGgUywJmgSs0NPEa8xXv+YdGgv1AKmKiu4Ts+XeV9QnibR/dJtAk1qBjUXaeAp98N13Q9o7EZ4/eWmBzLsXfPIWFa4evpeh96enZ3kVVwlF1tDlaX6Pl0lQx6vd8KzJl/N/kKxO20rTcR6IJi46fMqkVR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oKRJ14i6; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36a29832cbdso3906605ab.1
        for <stable@vger.kernel.org>; Mon, 15 Apr 2024 09:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713197832; x=1713802632; darn=vger.kernel.org;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lbGfzsDVHalUen8kcDa9fHYHVCHTdY4gdWD7PcggIA=;
        b=oKRJ14i62ABDJKir4VKfoLPvlTKOIy2rRhwowEzvf7nmCmI3X4I/l2f/HbtbtDoO43
         03yISmew3F5aL5fhbE7p+jVXpvEV/pT3n/Tx/XIgCNV8y5lSvXT6lievvwYERm5Rpl6l
         0G/1aTn1YcFIBJT572lsrPsSlOYJWYPCdpa+qjZewEO7xM/D/4mOxeUiSNToNTVEKbI1
         tWLY7KQacseN7y20AiwB0l2hzZX1PTVuC99pEtqwEcYXBLme09epmUoWPXLTI0dkJ5i1
         sQz9sc0TXQWCCbsvZGWDkTkER4bvOve7EIjtj1Ju3IEQpxaSGOTmjxRxxDCbyhG/nruO
         3UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197832; x=1713802632;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5lbGfzsDVHalUen8kcDa9fHYHVCHTdY4gdWD7PcggIA=;
        b=X8kwW5JveGzo128xT0vRiuRXufuRehvU4yTba4nytcI61NqDdrKQR2hGLIR7nTp8In
         3DbaDTXQqxRQAtF8pc8fH+rR6lSv7WmIIuDBkfjQBx6Ek97zI410lNUKJfCFQ87tnJ+W
         ye/OECottvDXcnEwQ+b7q4glMqLJf84GlVkqoSyIk8cH44pM/U8ZAvLxIurMRRnAt6Ko
         6lNAMJLIyDCgBzM4l6ZijgzAewWGCAn+lelvK+Ij0mxSki9w1im69YtJCOMFVMT7Gz3I
         0JTY6OMs+vt7LpsnsfC+WEESd1QlX4KRvILyIV140osPna9HoFeV8/3zIcXwoHQ1uCGR
         1VNg==
X-Gm-Message-State: AOJu0YzvA708q13YUIca66iJ7saCp0Ce+O1PnYwljItvPCCJ4xCcWWVc
	NwuZzRGGvj2zpsM1foMV9qT7QZc4YnOlEcsaVc8Tq4WAFMWbrj+JTNjSujMC4wY=
X-Google-Smtp-Source: AGHT+IHWaOuXyNCOq3h499fokVSdkixXaizC3WbhWrntLu5LaCX6FR5g1oIDiqRnFC0msCcHaxw6tA==
X-Received: by 2002:a05:6e02:6cf:b0:36b:c2d:6ec5 with SMTP id p15-20020a056e0206cf00b0036b0c2d6ec5mr8691677ils.2.1713197831767;
        Mon, 15 Apr 2024 09:17:11 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f1-20020a056e020c6100b0036b2224e4besm359813ilj.84.2024.04.15.09.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 09:17:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------20LvRVOsjfUao5lL1n9lxKhp"
Message-ID: <f3f0e73c-b038-4c50-bd0f-ec725c01c62e@kernel.dk>
Date: Mon, 15 Apr 2024 10:17:10 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring: Fix io_cqring_wait() not
 restoring sigmask on" failed to apply to 6.1-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, izbyshev@ispras.ru
Cc: stable@vger.kernel.org
References: <2024041502-handsaw-overpass-5b8a@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2024041502-handsaw-overpass-5b8a@gregkh>

This is a multi-part message in MIME format.
--------------20LvRVOsjfUao5lL1n9lxKhp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/15/24 6:36 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 978e5c19dfefc271e5550efba92fcef0d3f62864
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024041502-handsaw-overpass-5b8a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

And lastly, here's the 6.1-stable version.

-- 
Jens Axboe


--------------20LvRVOsjfUao5lL1n9lxKhp
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-io_uring-Fix-io_cqring_wait-not-restoring-sigmask-on.patch"
Content-Disposition: attachment;
 filename*0="0001-io_uring-Fix-io_cqring_wait-not-restoring-sigmask-on.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA2OWY4NmU4NmJlM2U0NGEyYmUzZjc5ZTAyNjlmZWE1MGQ0ZGEzYTkzIE1vbiBTZXAg
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
cmluZy5jIHwgMTYgKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0
aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9pb191cmluZy9pb191cmlu
Zy5jIGIvaW9fdXJpbmcvaW9fdXJpbmcuYwppbmRleCA2OGYxYjZmODY5OWEuLjk1OGMzYjYx
OTAyMCAxMDA2NDQKLS0tIGEvaW9fdXJpbmcvaW9fdXJpbmcuYworKysgYi9pb191cmluZy9p
b191cmluZy5jCkBAIC0yNDI2LDYgKzI0MjYsMTQgQEAgc3RhdGljIGludCBpb19jcXJpbmdf
d2FpdChzdHJ1Y3QgaW9fcmluZ19jdHggKmN0eCwgaW50IG1pbl9ldmVudHMsCiAJCQlyZXR1
cm4gMDsKIAl9IHdoaWxlIChyZXQgPiAwKTsKIAorCWlmICh1dHMpIHsKKwkJc3RydWN0IHRp
bWVzcGVjNjQgdHM7CisKKwkJaWYgKGdldF90aW1lc3BlYzY0KCZ0cywgdXRzKSkKKwkJCXJl
dHVybiAtRUZBVUxUOworCQl0aW1lb3V0ID0ga3RpbWVfYWRkX25zKHRpbWVzcGVjNjRfdG9f
a3RpbWUodHMpLCBrdGltZV9nZXRfbnMoKSk7CisJfQorCiAJaWYgKHNpZykgewogI2lmZGVm
IENPTkZJR19DT01QQVQKIAkJaWYgKGluX2NvbXBhdF9zeXNjYWxsKCkpCkBAIC0yNDM5LDE0
ICsyNDQ3LDYgQEAgc3RhdGljIGludCBpb19jcXJpbmdfd2FpdChzdHJ1Y3QgaW9fcmluZ19j
dHggKmN0eCwgaW50IG1pbl9ldmVudHMsCiAJCQlyZXR1cm4gcmV0OwogCX0KIAotCWlmICh1
dHMpIHsKLQkJc3RydWN0IHRpbWVzcGVjNjQgdHM7Ci0KLQkJaWYgKGdldF90aW1lc3BlYzY0
KCZ0cywgdXRzKSkKLQkJCXJldHVybiAtRUZBVUxUOwotCQl0aW1lb3V0ID0ga3RpbWVfYWRk
X25zKHRpbWVzcGVjNjRfdG9fa3RpbWUodHMpLCBrdGltZV9nZXRfbnMoKSk7Ci0JfQotCiAJ
aW5pdF93YWl0cXVldWVfZnVuY19lbnRyeSgmaW93cS53cSwgaW9fd2FrZV9mdW5jdGlvbik7
CiAJaW93cS53cS5wcml2YXRlID0gY3VycmVudDsKIAlJTklUX0xJU1RfSEVBRCgmaW93cS53
cS5lbnRyeSk7Ci0tIAoyLjQzLjAKCg==

--------------20LvRVOsjfUao5lL1n9lxKhp--

