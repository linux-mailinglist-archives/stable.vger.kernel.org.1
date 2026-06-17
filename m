Return-Path: <stable+bounces-266734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xjt5CpuPMmqS2AUAu9opvQ
	(envelope-from <stable+bounces-266734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:14:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEAB699969
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 14:14:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=HFvNnWN6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266734-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266734-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC2D7304AE4A
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906ED3F0751;
	Wed, 17 Jun 2026 12:09:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB863B4EAA;
	Wed, 17 Jun 2026 12:09:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781698156; cv=none; b=pgo7BysAv1LddxV0VdFUSNFeWpBXfYmODn8bnyFfCULW16U3XF0GlXWZeHwyRT41OsN4NiEaZmsVh7YQEAaEnp96sbRFvGtSp6sCDNvUPdnR7Q54H5OLEM81Jfzll+grPD+HYf1M6UZG7KDipaVvZ+4SDkOAMugjzNtcuLLE+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781698156; c=relaxed/simple;
	bh=SMgrSA/kIjByUED9+XkXmN8xQD9JA6hPkyyYkau0aBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hqdM7CyERcDKPsLWGws7DnlPbUszOFqAMK8dgc4rOHyQXP68ZKm13PW7cRYhDXyjoA8oOzz0nYuOi4WS9X9StkJXbzTJQYyi9q+E2vP2M1HqKFK++4vPAJUl7M91pkH3SbjP2cjZWBdSJYWWr2RaGnsgerYZGvYzWgm1O8SsE2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HFvNnWN6; arc=none smtp.client-ip=54.206.16.166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781698089;
	bh=SMgrSA/kIjByUED9+XkXmN8xQD9JA6hPkyyYkau0aBQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HFvNnWN6fA0kXa4AQRrJKN4VKGHbAXkdGvavTMLteyHI3LwKPkSEe5tdRLG1u+zek
	 IjkGWvBXJURxQTjWcSUGIU4MbpQPekOCJm/nNhIvPJXj/DIJ+MLn3TH14BXS3uIsv7
	 taWg+lD3xhm2BJiHTqVLkh37P8tkWOnabMFjvn6s=
X-QQ-mid: zesmtpsz4t1781698083t041b0929
X-QQ-Originating-IP: Jb0C0ZXzNqY/BFbTVt39oM2OHBuQciYf+eq6X0aQM6Q=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jun 2026 20:08:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11797564057231867192
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
Subject: Re: [PATCH 6.6 000/452] 6.6.143-rc1 review
Date: Wed, 17 Jun 2026 20:07:49 +0800
Message-Id: <20260617120747.1241937-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OA2O1J/qT0Faq+b2gmU82E529Fk2xtR3zC41GU+9WV6cPAs+StJJTDR4
	f2jNrULRJ0mGWY/79tu1KL+MV+r5d9dDqHPT7rbus1I60OyBBP5j8ZFAo55Ub0u4oUxRwE+
	2bF2YFVWnk5lkZCvF2vW4sWuf8AzUmanCn/Np1c+A7vl3OHaqZLa04fGgvCXkZDaYvU6pI7
	kWUFuTTZ+QRJXdDthMX6bumbLA6BkcFdZyFAF5zvmvm5WInjI8yjoOkiXdxSLu88UcPB29T
	v/8H2f2bHKP3Hv22FLY3S0YilawKQkznfM+4XjDOz8s1sQbghPxyr0GVaJTmWhCdyvVDhP+
	r9Et0m+cJyiaVm43cEs+wdKb9roAJ9ndCU87RYkqv/HLCFJRHg1e7Cm+fSwi2jOzeK0G/sd
	6lL1lNVSsEOGlyjhLAxr0C9iaGx+CEgFdedW0AuUt1J86NfZMet8ouR2qsuHSs0+Z8lpPix
	Virm4ukhkXGeIkc8iIzRk4Yy6iHgSi40LfzU2f+gYijQo1EKmkWv8dWx84AfcnE8LBYJ5zP
	qqv+faWF8cBAjN8DGDrqsH4d7fO/ctBgoLqYgt3Y4uDYsARmCluLTvI/D/iv8qIlpYNtlVa
	pRQcLDk2a8Q9yxw8OFxzrHcinPXwaIZOkW/9lcoQUwPt+X/XhQ2vqkkrehtwpUg4Vvgnvvc
	l4AWrlddt7di9vm/XNO5gL873xULbMGn+2s4d0fcmxeeWlPGOwrjNZ+TsNWi5VGJ7kyUctd
	DtnqtH8u+/ZVmNYN5aeK+KdUTfTi0RRrL7nzkmiHYvoD6Hy5rgfOdcfnAEm2qYjPZvVbcxr
	fpTTjmKbqc173IAZ5RE6MRGOFROOw3y+m85ulugERJ8ksGYIl6dW62U5Mr28iGnClxmK//L
	+Rc2+FqARHl+7qgQjF6Soc8bGvU6os30MQSVM2Oh52+NUnf+i2W4g1SgmjT1dA+hgtkoIp4
	YUKFQyYA9xrJAU19JuZZQOtlEQJEGe0S7+P3o1QN4PL/PBZwXpXBszxmUbhO6+C3IqbFhKi
	xaTwemyyXJtclH4drgyaivHFHerE2cN0QB+wQqBgEonY4l951zZcMnDm/MVS9lFZ9CXrBau
	R6AejTkf75zcBTW5t1UdDZGvSp1LmVOo9Ytr7TNWE6zCse3vjNLwDVh4KTqaTNs/UKYT7tk
	mXO5fwho8na80O4=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:guanwentao@uniontech.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-266734-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BEAB699969

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

Log:
Linux version 6.6.143-rc1-arm64-desktop-hwe-gc3a40fddacf0 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.6.143-rc1-arm64-desktop-hwe-gc3a40fddacf0 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT Wed Jun 17 15:27:25 CST 2026
Linux version 6.6.143-rc1-loong64-desktop-hwe-gc3a40fddacf0 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.6.143-rc1-loong64-desktop-hwe-gc3a40fddacf0 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT Wed Jun 17 15:43:37 CST 2026
Linux version 6.6.143-rc1-riscv64-desktop-hwe+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP
Linux version 6.6.143-rc1-riscv64-desktop-hwe+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP Wed Jun 17 15:57:42 CST 2026
Linux version 6.6.143-rc1-amd64-desktop-hwe-gc3a40fddacf0 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.6.143-rc1-amd64-desktop-hwe-gc3a40fddacf0 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Wed Jun 17 15:11:47 CST 2026

