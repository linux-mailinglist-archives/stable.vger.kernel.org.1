Return-Path: <stable+bounces-265745-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OsHYEB+PMWrAmgUAu9opvQ
	(envelope-from <stable+bounces-265745-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:59:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C14DA693B33
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:59:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernelci.org header.s=google header.b=Q5XR4PWW;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265745-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265745-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=kernelci.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74BCA30982EE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26047B41C;
	Tue, 16 Jun 2026 17:59:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2444779AA
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:59:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632768; cv=none; b=RvTHCS7AmFW69sVAf6nLxZKvbl79AGy1+WWhq6SBLYCNcgrAH1xk+bnU4MQS++kznc08uWRreVBcQ1adu01EzTbDPi4fC+CiE/UTuhSiocoXH7DbFk2i1g3LHJEQQiQI59mozMrYJPGOAk2m9wz4UIlKYEqDuuOJeJtYV8ewUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632768; c=relaxed/simple;
	bh=iQ/QL//uLACXlqhIamA+VQKfR0n0uCfYATHVvOKleFg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=LzrLvq2pCnH8pkZlp8BoDik2y7CJ2GBic9+sgCCZPkUBtJFr/KPb1L0jKhjSIby2/B3WOtI/B0a02UmRZXEYBK49vZkrPoyiQBd5snLOBkx2ZazePN2m66LVTDpyV56KpRRYISQ15mEtD3b3Znu5AYHwgT/rT8mzvARwoaSCYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=Q5XR4PWW; arc=none smtp.client-ip=74.125.82.43
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13988680a69so1986526c88.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1781632766; x=1782237566; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0co8zyo++piCKAQU5sgxN4YzXVDezIl2LJDQ/lVY0Zk=;
        b=Q5XR4PWWVU7al0EmQxb2LYcM3jM0wEOVCDSXH/vsFKpYEGAkSrxWovDOtQEv29/Gst
         NaLBSbsjbdiU7h/JRmpFPST9TggAcDMUTDbY8d2m6NTDXdop8y7j0fR5xC6E2xuQIn5M
         3fMy8d2LiCkdYAHR8ountYVwMK6FQqU73TKetyBIesBieQ9IeW3df5R3FfHqZFSZukNG
         +Ow0Ep5w3x656fxTzslC98wlSlOBqvZF7PIYxspJPaa6AQV/ygBI+AbMiQKjMGbkOqQn
         06jfiaaf/S2P3V0zBpmvwaaFuAIrNYRZeyXy3adYoCWE+4vzXOrH/nKR1ICHh4tBMxSw
         LyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781632766; x=1782237566;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0co8zyo++piCKAQU5sgxN4YzXVDezIl2LJDQ/lVY0Zk=;
        b=RxibJiQ+HFDa3dbw3z2T61bKl9FJpJAJSLAYAnpXDHGoZ9tea/oL4j0YNLEuLRvICe
         6DsM1E4I6BXCwasV4Kui7ZMZFZAiujdkvCjxxPTyr6XJbhiukxWJTw81VAXmYpkTkO7q
         aTdpo2N/Ju52lQHUADneW5xQPjHa0eVherZV43xSc/kLB4UCFoO/b3SJzRHbzne3PE5g
         bcItZNhGryOYQGu8arOGxxbfoIXE7xfPtXiE59zzsGvUx/X9c8eC42t5MA/xW5R27YDm
         yCYtbkm7dGy1CeOZ9+adYp8YLptN/8LkZ0ODCQBwoufLl+Lt2039V7PUM1qsx8avukQw
         Guag==
X-Forwarded-Encrypted: i=1; AFNElJ8kyBu3m8MPAeXDkjqh84JFjBLuIkL8LJP6Ut16NgITw1i89Em86+S6sSZHltzgkrrrbm9h3zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmnt8jz0cYbeN53Fqm/wQTzxXdL13CHIkse/k06aFsxYf1XnCV
	fpTQWrJUj7TNaCpXgweLqrZweYpdiwjzAbrTv0uCZWhmRb8RKXTL2bhhfDM72Kobs9PpW2BDWi0
	5gPq/
X-Gm-Gg: Acq92OH6lUW+2XAD9uaFT5qwG9G35AHV204YRBl+HUF6PlBYFMSCCeDGVtZlv+xRVjs
	4maZKoc1y6keV/LRWkq79bRe9o12fkYoA23cN0KSiUD/0q/hYum0RKA4fo5HASmiztLVkcBVfCR
	MsZQ1Equ86vknt32eHHoAjegXyreHccYmLsYy7UssHlAa/jhouBTiFeiSe+/V5VQXLpC5Sh0gY8
	bcKceFEZd0Lg7hxNG8C3hGqs9qlEi8qFV1DqdhNZbcom2TAztm3FHjfRUjpLAeamdybb3SDDJjx
	TH5c8V83Fyj+dSFYJFPORLycfhPeKdrAOGUUjZ3Dzedo8wYh0qL8e++8zYjVLncgfjrd2mHBPIt
	GOklkB1nYVjsR2/89HQcFbYVO23qMC3cT8YEPlUX3VjgroM9xJamC3HjcJMpbHlx2JH415sk0g2
	ommENlQiWzzWZVahgn
X-Received: by 2002:a05:7300:6d15:b0:304:df0e:9db0 with SMTP id 5a478bee46e88-30bc9ce33e2mr259640eec.15.1781632766023;
        Tue, 16 Jun 2026 10:59:26 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ddaf69asm20810980eec.0.2026.06.16.10.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:59:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-5=2E15=2Ey=3A_=28build=29_initial?=
 =?utf-8?q?ization_of_=E2=80=98void_*_=28*=29=28struct_crypto=5Fscomp_*=29?=
 =?utf-8?q?=E2=80=99_from_incompa=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 16 Jun 2026 17:59:25 -0000
Message-ID: <178163274542.15780.10458817119163247870@330cfa3079ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265745-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kernelci-results@groups.io,m:gus@collabora.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email,330cfa3079ca:mid,lists.linux.dev:replyto,kernelci.org:dkim,kernelci.org:email,kernelci.org:url,kernelci.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C14DA693B33





Hello,

New build issue found on stable-rc/linux-5.15.y:

---
 initialization of ‘void * (*)(struct crypto_scomp *)’ from incompatible pointer type ‘void * (*)(void)’ [-Werror=incompatible-pointer-types] in drivers/crypto/nx/nx-common-pseries.o (drivers/crypto/nx/nx-common-pseries.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:ac808b02ae66c254b1738fb240c91d4a180b45c6
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  1447d275e58bdaca26b8afd80e370fa21f2ee717


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
/tmp/kci/linux/drivers/crypto/nx/nx-common-pseries.c:1021:35: error: initialization of ‘void * (*)(struct crypto_scomp *)’ from incompatible pointer type ‘void * (*)(void)’ [-Werror=incompatible-pointer-types]
 1021 |         .alloc_ctx              = nx842_pseries_crypto_alloc_ctx,
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/crypto/nx/nx-common-pseries.c:1021:35: note: (near initialization for ‘nx842_pseries_alg.alloc_ctx’)
/tmp/kci/linux/drivers/crypto/nx/nx-common-pseries.c:1022:35: error: initialization of ‘void (*)(struct crypto_scomp *, void *)’ from incompatible pointer type ‘void (*)(void *)’ [-Werror=incompatible-pointer-types]
 1022 |         .free_ctx               = nx842_crypto_free_ctx,
      |                                   ^~~~~~~~~~~~~~~~~~~~~
/tmp/kci/linux/drivers/crypto/nx/nx-common-pseries.c:1022:35: note: (near initialization for ‘nx842_pseries_alg.free_ctx’)
cc1: some warnings being treated as errors

=====================================================


# Builds where the incident occurred:

## ppc64le_defconfig on (powerpc):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6a316b0cec8c02389388bc08


#kernelci issue maestro:ac808b02ae66c254b1738fb240c91d4a180b45c6

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

