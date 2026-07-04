Return-Path: <stable+bounces-271884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a0exL01pSGrtpwAAu9opvQ
	(envelope-from <stable+bounces-271884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:00:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8670666C
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 04:00:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b="RJ6PF/kc";
	dmarc=pass (policy=none) header.from=uniontech.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271884-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271884-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9E2D30191B3
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 02:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B09340401;
	Sat,  4 Jul 2026 02:00:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D249433E84;
	Sat,  4 Jul 2026 02:00:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783130440; cv=none; b=ASSl7mGG+fOpe+D8LujGeXuvPwyaAJpK59maI+Un1IGBvachamJ4sZcd436Cyg3S1TVMvpQsAzvJIqtO+MBQ//3U4K4+IOHZNfxgav7F/RC4xb5vi+jOLxw9WzdCkiOqxxSWiAgBJGWB4ZX5WoiHT0pylSuT/oAbvwx70MnJ4Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783130440; c=relaxed/simple;
	bh=Hld71cANZUg3kQQbj0eo7ByxUckv3nSlaI94jQeeIU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WGJQW5I7g9kuGtEAnUv3qdSgYS7OJu0SlKHDuA+s/L5F49/ES9x7Ka40mYAPMuVb/o4FFiCudo6aw2o6+DBvcH+3EkaVuJWfv8WCH5SEYv3oXUJL9A5fXg0045HJCN5LG4eUwief1ZnzfbGNmLTTS4Gv8Uon0wPFaqZSq0Nhj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RJ6PF/kc; arc=none smtp.client-ip=54.92.39.34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783130351;
	bh=95G3e2y4YliAGQtdof++SdvvRuI8no4JUWbTcPlO8vc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=RJ6PF/kcMjSM2wBG+eKV7aZiKRhmh/jRDLBdrN3s2pER1+V9i9Pu/h0vge1tARKti
	 AiM6TKaXfeQSxxg44yf8EnPjaVD1hX88Gncf64mZtpnhkpYyBJjF1T7M8X2gZL3d0j
	 1A8caGDfTX6WOAJNjkxFzzUsiLE7LxcPZy+RtTCg=
X-QQ-mid: esmtpgz11t1783130344te21a08a1
X-QQ-Originating-IP: zawYPNEQUv66Cxd8n+lcxy44Qbh1xpcBdbaqUD7K7Kg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 04 Jul 2026 09:59:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4754575111604876633
EX-QQ-RecipientCnt: 21
From: Wentao Guan <guanwentao@uniontech.com>
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
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 6.18 000/109] 6.18.38-rc2 review
Date: Sat,  4 Jul 2026 09:58:43 +0800
Message-Id: <20260704015841.1569932-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260703072816.644513463@linuxfoundation.org>
References: <20260703072816.644513463@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MeXtFl6q4gmHuK9S2Z5YoYqIQxKxqu/HfsFLnaoN3jw/hS7unX1c7Gwp
	O4+xlDbbmoz9k/mF7166Rx5OQgWrlD/1rP++Hb64l6nilvb4/+GwBnq22BRl9M36WWAJcL2
	yexYPDRPYG+7wrbhH+N9sGBitFiZjwwziQw7cSIefKd2OK7MvxsbYLVNmAe1Yu6bNH5NjEI
	+P4zepcwJCE06OzBGkfg6Ag3DXMlOT+Fz5aR2M3du6q7fplN6UmRh6P0NNQhEfRuvof/cir
	w9mezb7t0MEEVjZLvp71VQzoDfF9ZtIjuaxkoyCCCTDpX98ojZyqdhTsX+6ABs09vrJlc+C
	iY88R6/8QhXkSFRQblPttkt8OWlxeBigkeKUtxZeqxwAO9Iz5ceauCVt1VKTsE5DvNcID76
	IdpbOxK8uDVmLY7xzwYb18NWrdbJ65lHI9ZuZFni6a+N9xcqIkK54od4539QGaeW91FNVHN
	6dw75xJxUz6+LP6QwPoCRvBbb8wWSyAKTTVYSv1VtGQRHEIJd2Tey5GrjEzPjHAtLr+5QfO
	2JMo4BYbhAP2FF5TMatP+mEFbpomElmYwZ1VFP+05o1IlwI+WIDjS3c6pZFpbZn73ZqVLny
	e+cPhPLIc/EbFo4s7csg5RRK9cpN9qi862YH11q9/Rz2Wvgx79bCiDKZYGV5MszOVxQ2r8Y
	bwIynWb8kumE4oykTAoy3XcM1uUxX8J5KV3V6E1tR+TOd0M/qjUIMjV1CIV1Ov1RCih+Hdd
	Koupz3cuoRsxEhARXgeGlwr1lGMNLLWxrPsNkYVG/6alcVlilQlRQU/SUmCo7E/8h94BdoI
	J43sn6LLRV15MCpaQ7QvdCLRHGGae+KhNkbt1ppPVCsudJP5c5aR/HZJWgrBB6+ZNpSyoEj
	6ZBguWbQI+vy9CibdJkNOhgjtOX1oP/dhnnXtOgg/CLjgsb6pVWUaT25z1xOwwZULXHWEM/
	CWnzWpKsGdbN7ewozvIbW51fidGSXq111GB6ccZAjlTzqArEPkDZ93kyA9fZ9jJM30XG9rW
	oeEgxksojHvJyJAYd7C0EZzs1TKS4A6pQoYMEa0M71D8IMDjjbcaFWmPle7reDkYYQOO6Qg
	jn+cKd8yqVT
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:guanwentao@uniontech.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271884-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13B8670666C

Hi,

Build tested in our x86,arm64,riscv,loongarch config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

Log:
Linux version 6.18.38-rc2-g455fe3223158 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.38-rc2-g455fe3223158 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Sat Jul  4 04:10:09 CST 2026
Linux version 6.18.38-rc2-g455fe3223158 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.38-rc2-g455fe3223158 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Sat Jul  4 04:28:45 CST 2026
Linux version 6.18.38-rc2+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.18.38-rc2+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Sat Jul  4 04:45:54 CST 2026
Linux version 6.18.38-rc2-g455fe3223158 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.38-rc2-g455fe3223158 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Sat Jul  4 03:49:21 CST 2026


