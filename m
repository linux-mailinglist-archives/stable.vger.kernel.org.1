Return-Path: <stable+bounces-212729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qjXGNRjNemnU+gEAu9opvQ
	(envelope-from <stable+bounces-212729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:59:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC2AB490
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 03:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B94713004D07
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 02:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24D5356A12;
	Thu, 29 Jan 2026 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="kSbJmV8V"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504B153BE9
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769655572; cv=pass; b=ZVtYMDwQjkRuQbjiGR5bNpKIU685QzO8gMCYB3ezGYEJ2nF4nrML6RQ9Qu+pclAPxmEjDlQZYLGYDEJvqyorVIlIY7+1QCHyYuT3bBW5xSN5ZCglSo/FMvs5xtMVm+3+SEa+bE1Ew3vIEHfLIhGV22bT/Cw17xFxvst7foLM228=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769655572; c=relaxed/simple;
	bh=d8cztXYczvSOszr3V7pMy5PpP3cnZAjkRbR9QfTDyWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVpYRKWTDQHLOz2rjSUeDDjO+FLUNIf1oahHOT0Zzxw8nig6q/xVHOIud2ZxNY9sBNDIhgyAF+RzY+ep0j6L2t0qJaBJJa4pSs6vHRiqA46Jz/cAL02cHFIYisgDMqReOdDw5nPktl8YIxdDnwWmiBADzdeneJse4hTH35Hl4WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=kSbJmV8V; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b785801c93so1326399eec.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 18:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769655568; cv=none;
        d=google.com; s=arc-20240605;
        b=LYowUUJxa2Ibqg+/9nTs0LRrPNihU/gBfMoYlIhqUzKcbD7heOBjvbAo6jPRiETSkI
         n6SetztGCgeRSHozaBMw0LnyqDLcx1xUJbPnlnkASZZMfw8CKvbGEuzLdcTvbuzXFr03
         1vgNU0fk6xC+qGvLdtFhYH82gWGtd4UKinTfz6IsNPP7HFogKGRjq27slWYgMkjKpY/q
         h2wetsMYEVp6OdGUWj+hKhXQGMwJmQakkWyDglWZzKZHHLfP0MAg1xU5sk11AvmJsyY1
         +pLtv1n7wXNgfXh0XXpLp4p9g+5rNmYvrot6Xz/xwB1ocuNh3BENgvwyvGSsphdCBHAX
         Bgdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b1/1hgdrdOtGYjDRlu3dvktHWpc4PrVZjEiQ0nlClDM=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=aBmcl/7TpIxNjcaSGomGDbVuR+T3YFrq1QwKPAj/gGc3bTl0MZ1BQj4hZSJu0vKikW
         KhulG/KIQyIwsndAdqMWZ9ZTXqTw4kUeVIlO6DhBFROHAgyAlP5xZnshQSmoE22o4kbw
         TYvkkhSbkuqnOHvtevtAMeuMmTYOF4s+d/9eTwufxRcPK3s5TivtxR2jHiEl9o8iQZqt
         wqQyx9P/d6+9qfDq0jiHspNe55rayvAfQlE7BGlWBx9Ljp++piJbhgUUKWpty/RCdP4G
         p2ltxtOV0nLPL47JRuK1oMrOVhnl3Vmpn0ybzFh9nI4h+C4Ua3WrRVlLAF/DnuXWHmbL
         yS3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1769655568; x=1770260368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1/1hgdrdOtGYjDRlu3dvktHWpc4PrVZjEiQ0nlClDM=;
        b=kSbJmV8VGQZMwuvj1mzLdjIxOgeVXAmM8d47kl02/Jo92J83OSc7G0/PLfuaI6D+Hu
         sJ6oP9sNS+LNSrIAM6zfpOBSzeVoFfxjUmffLi+pnKFjnWOsqBUg+wlDyB9f9xzajoxs
         u/e6P8JnavNMrB2hnzmCN3Fd6EBf2WAEiPkxeSUyrZT4wNOf4YjCSiQbasKk2wwDvhJP
         IBsNuVJ7qjXWFdIYhgH0a09/pFz3vfcrbM3QhnfNRN7jdOkOi7d0xj72bkxFuspq3pii
         VqdBU0Z2uBBQeb1Vy9N+Rw+8hC+vJ/rcGi8xHUgYaZXEwZpCMaL0/whBFo1jqXj6SjCw
         cFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769655568; x=1770260368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1/1hgdrdOtGYjDRlu3dvktHWpc4PrVZjEiQ0nlClDM=;
        b=v7ChFimmCPmh75nNuWnezJ6k/Rt/UMhD5vObijGkHWXIe6Dr4deXB88beUdUDtVr1O
         Dr1BgNxJ9B8ZaTZgwN6PcXCEfv8nacs8KLyqI8jo4JUwdlYnIbaBsFoX0SjevdFp2pgO
         ufurM8uqVqIpEHxKQn8wXOhDUcsyey6k86trrFcmFBB1vEDBAe2q/o0oimos/9mtNUAs
         xtdMJ8Usl90GvrdUV/K6XM1CPAv8uwXUtpiCQd0P/tWQ24BFp3pD2yP8iiYcPh65GGzQ
         8hlPokHAz3PudF76/soQf0UQjUS/VGn3+CipsejI1jVUHMLW7+ARrqTW3fEhaXf21YdM
         y2wQ==
X-Gm-Message-State: AOJu0YwVSB6EOI2T6NEkeySYMoxpbmniagPOTRbdCpRZsVhKnifthnr7
	7Hm4PMElJto2/YSs3NkQYt4BSxaHfX94Mmz6V+roLtH8GB/kchZfi4JUPGrjBLyr8UCOJ4f5DMP
	ZTvo7Qt+Z2mh+AptamlDPkvLmf/GKgcZMWG5yLqAErw==
X-Gm-Gg: AZuq6aJEaapaJq+2x4PamggVuFHYit3Xa5S5RXC1yflHYR31j5J5pe0baA/nPoqJ8/f
	mC69D7PBfRxBpc7JAF1uMGVXIoHDhjAk0XqiX5jVH0jmmRDL6lA736CVpRnkc5XFA6RGg9Xh8Bq
	Qk8rl8GABFkHnqiAbZYoVp7sHxXdW1dUZvXHYh4Sp1eMvIK2dwMqKWKD2iQ8GKZxnKv0g7rVKqb
	hSTJEEdyMuxThnKjTWL0yVTnjdij6mp7Ygvs5gRG5IFsc/KA01oF6dW6v8i3xt5Hl/cIzkT
X-Received: by 2002:a05:7022:7a4:b0:11b:ceee:b78a with SMTP id
 a92af1059eb24-124a00aaff5mr4519762c88.19.1769655567618; Wed, 28 Jan 2026
 18:59:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128145344.331957407@linuxfoundation.org>
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 29 Jan 2026 11:59:10 +0900
X-Gm-Features: AZwV_QhApBiJkDbKT_aFAZUil7LKIchbu9gATA5R1VL45l1QkcwrVx9tfXGG0m4
Message-ID: <CAKL4bV7BeCwHonkdgtO9cHyWKW9Jc7R-uhxrnWsoVSjTOg1pdQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/227] 6.18.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212729-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 75BC2AB490
X-Rspamd-Action: no action

Hi Greg

On Thu, Jan 29, 2026 at 1:18=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.8 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Jan 2026 14:53:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.18.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.8-rc1rv-gc0a52e9c6618
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260103, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Thu Jan 29 11:35:00 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

