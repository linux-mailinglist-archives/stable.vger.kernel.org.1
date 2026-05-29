Return-Path: <stable+bounces-256686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNhVE9XXGWqjzQgAu9opvQ
	(envelope-from <stable+bounces-256686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:15:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E5060724E
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09CA330BCC62
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 17:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D290D39479E;
	Fri, 29 May 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="h4oJGSV+"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C0366052;
	Fri, 29 May 2026 17:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077368; cv=none; b=JHwtFsWkfnkCaMTi9WPjYG8PzhHGvb8ZVUlTGRlUONRfWL0yR1jUPyVOtjEtMAtsbf0YCfccr5qtKF9H2M1PRpJGqw9w2CwUumFrkHIV35FyMOiPCsB5OChJGwSBiKlJE9zDdS+PA/tFa/VSRlJJA/1pQMSxGi/OBlScvpyO/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077368; c=relaxed/simple;
	bh=vm6Q0S4YiiKH57VVKy1Ac0D68zpw0soutwjtY13VWfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlwTnUVY5dqSnivnV+pzq7uizlnwrtblBjT8J2/JHko9HWVd4ETyWYmpZxUn7M7Mnei0F/ICbB/kll3+fuJL/iVRTJAFcvbK8Lm0MAgxRcS3O2zMZjCF8tMn/x5l+K1nYGdaR2VmkIZPSm38d+yC1Jcia1Lvh5kisZEYIM82dJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=h4oJGSV+; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id F143426F0D;
	Fri, 29 May 2026 19:47:48 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1XfauoxPqr5W; Fri, 29 May 2026 19:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780076868; bh=vm6Q0S4YiiKH57VVKy1Ac0D68zpw0soutwjtY13VWfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h4oJGSV+2PgRlFdbzV1ULDeJVL/lqL+Km7CRWBdBd5kcbZJ+O75J5pc8zfVHRJhJq
	 MybCKuQCx1yMB4R1W3k8ON1Tkk6+93JsNHlPzElkB8k2yRMkyu99NRaXVzNnzG31bI
	 OdtspWH3Vs8ki4SXCEtrS8bEUumpwzT2wngqz+AsK7BnTnzuReoSZvrhLZE2WcnbBV
	 MfVoNI7FCQUg2sUZ3/IdlWv+P1LSdcquMpZgNrFb/8VOurr2yafq/tf4OttpL1Qv+W
	 27M7dC0Xm9UqazMHyRKeLwv6RpP3q8OqIkajSWpL7Bi3tG8fMm+4W2JGuBe7gzDxTB
	 1PsxwU44ih+MQ==
From: Masoud Aghasi <maghasi@disroot.org>
To: gregkh@linuxfoundation.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Masoud Aghasi <maghasi@disroot.org>
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
Date: Fri, 29 May 2026 18:44:17 +0100
Message-ID: <20260529174419.351793-1-maghasi@disroot.org>
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[disroot.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[disroot.org:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,disroot.org];
	TAGGED_FROM(0.00)[bounces-256686-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maghasi@disroot.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[disroot.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,disroot.org:email,disroot.org:mid,disroot.org:dkim]
X-Rspamd-Queue-Id: E7E5060724E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested kernel 7.0.11‑rc1 on the following setups:

1. QEMU VM, Arch Linux x86_64
   Booted successfully. No regressions, panics or oops observed.

2. Raspberry Pi 4B (4 GB), Raspberry Pi OS Lite 64‑bit
   Booted successfully. Observed a null‑pointer dereference oops
   in journalctl, which also occurs in the previous stable kernel
   (v7.0.10). So no regressions observed.

Details:

$ uname -a
Linux testrpi 7.0.11-rc1-v8+ #1 SMP PREEMPT Fri May 29 13:18:21 BST 2026 aarch64 GNU/Linux

$ sudo journalctl -b | grep -iE "error|warn|fail|oops|panic"
May 29 11:35:10 testrpi rpi-resize-swap-file[369]: mkswap: /var/swap: warning: wiping old swap signature.
May 29 11:35:11 testrpi kernel: Internal error: Oops: 0000000096000005 [#1]  SMP
May 29 11:35:22 testrpi bluetoothd[542]: Failed to set mode: Failed (0x03)
May 29 11:35:25 testrpi NetworkManager[561]: <info>  [1780050925.4153] failed to open /run/network/ifstate
May 29 11:35:31 testrpi cloud-init[525]: 2026-05-29 10:35:31,802 - modules.py[WARNING]: Could not find module named cc_netplan_nm_patch (searched ['cc_netplan_nm_patch', 'cloudinit.config.cc_netplan_nm_patch'])

Tested-by: Masoud Aghasi <maghasi@disroot.org>

Best regards

