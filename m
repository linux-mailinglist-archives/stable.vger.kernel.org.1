Return-Path: <stable+bounces-256647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IoQEkapGWodyQgAu9opvQ
	(envelope-from <stable+bounces-256647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:57:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBF060415F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48177302F752
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CB042DFF7;
	Fri, 29 May 2026 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="ofgK2H2W"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278663F410A;
	Fri, 29 May 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065973; cv=none; b=R++shw/ssXFo4Zcz1yEzmSx62KuGzARyt5U2fM6ugv8NkqbO7nmImrWllBgrah5qfkchAMP7LEjym0OSE6dqmHB9AbAGbthZ8OV5bmR67yfR3Ayh70m6IAAaLKcs+A2PnQVw3DBtQGjJn8ErK0uc5mv508P7e9VnJmSxLk52KWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065973; c=relaxed/simple;
	bh=V9wVFrjL2s+J6A1HeEIPVxKxw1Vqrz1KQ6SjM4LVf00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXBHJpM9Lck7hBI7bGW0l6i/ZUIGXlMHseRC+pKHn8LosT9bmUIPKLYQdft/N/3iqAHEIFHzF8PwHb41pp5FPPzJn1t3WrrrqZEcBtFSgpA+CkNN6/Btm3o2LH9XoMMgxyRJ1x9QPPY0saeYhhJvVkiJP08lRHI1+VIqLB7cE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ofgK2H2W; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780065880;
	bh=aQuiN57gGblTDVdeHTf3pgndGWjilaSgrAFg/rCxDco=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ofgK2H2WLl5ouk/HOTgjUtqX5wvTwUY4XjAyNwZh54CxNeFhRTrEybrWWVdJwjSHI
	 ffJfU+/PUduP9tXDTV+Pyo0TAIIGgPWq9+XgTE2IlLOLh71uZEu3yvCwTEaHTBlgV3
	 2Hl1lsjmkhOrLqyMJ5KKOASpbYlJLPBNTOqO0qb0=
X-QQ-mid: zesmtpsz4t1780065873t868af0b4
X-QQ-Originating-IP: yQD9oCqZeyI8NxAwMemD0/auxZ2yG5oT20Sph+Z0SnQ=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 May 2026 22:44:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15854156992415530431
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
Subject: Re: [PATCH 6.18 000/377] 6.18.34-rc1 review
Date: Fri, 29 May 2026 22:44:27 +0800
Message-Id: <20260529144427.2989037-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OegHrGdQ9dQUJeug1R/+dFU3X+7wfva/cchgOQCdT8XJtTnuwgmzq2pO
	82BzEyU/aA+0W7XPtUuGTlA/uZ2gtA8f/bmDSjK82tA7mYWAz06dOUiZdyh1m/GV75GHpQY
	llKUj8T9El1F/ogA90+SN3rOHEJNvvnBb0oKypSVRD93wFwi5aU0XWWVzHd9SVkbZqBovfg
	Cikh6ZIBfIlvohH/wEbQr1kTLeEAEXaC1aY31Z1k0Pn7C3hDPlgPQssVkwiVTTtAJJbLCFT
	S+swb/hz/D7f1rXWG2rvgi1oKBVXr5kFGdPymaAhcjTz6S/cx+KQNYQJJEFyBel9S0tN10E
	K+OdGWPyAH2XioDA4SMXjSaZ5zkWqshlqGkgMVhqQ0+mzFTasfJTl0aE8GTVrw5tnWZ+W4v
	5RdwtoMOSsa7JkrfENhFOmR/CMQLwvLR5iTL8/mFKHKwM9WAFHrj1MCLgknlq2Wyn7jb5ig
	KMSn46C3VPFltJPMlgoj5Sbc46BlqDrM9TdN18n4Mz1M1OvCQJ16AQbgMpzWq6SjtgjUpju
	j6GPtuEYkSKoZeBt0vdVQO4sk9YppcPDxhV9XA0fsVhzAS0oXx97fqKU/4O+tBmvSeeI+A2
	VOUFRjGnG82amB/A9kVVL8ewrPPbwGAWkEQuN6tJWdBoLY21Sk11pt+/S3A0r0d4Iu4uiZA
	KOiBRAX/LXhTJjJN246VSGlBwfb7k410ZAXLDXXvs+irBZV6q8ALFBS62KdNaGEvExl8fZC
	Y8CQ4YRo/rqHhJFJE5xmEciiPhW6MJQMsyUIn7LDe3PBReUt760pmKuMqLC278hOHfyI+7k
	eroetJWYYzShh05Cc3xsv7ffq2yykDfo4ZthVOdak1FSxzpV3gVP2v6OdT77kJ5sTRBV8Nn
	Ya4/duITufd9wio1xcKJOWfpJj9wbQHrzk58UPbzjcsJH+2/oeQDsga1TI/C91Tayqxm8SW
	Fim2+OXbgylQ6UmSFw6+V5HZ9EKaUcWJNIsCGAAgjPM5WKsh6kS6FsESmEm+qVHp+ep7M/3
	YP6wKIJLkvNoe4Nwl5gKQfjGS28nnkQX2z7LlLKBifzuADMMT9DzNsmcGnBMsmqUTcMVke+
	u0hXVFncnrrYRHISMtKU9c5G+jR+rbkz88rdzjsfcF8IdzeLLVtj8I=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256647-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uos-pc:email,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Queue-Id: BCBF060415F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

defconfigs:
https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9

Log:
strings vmlinux-*6.18.34-rc1* | grep "Linux version 6.18.34"
Linux version 6.18.34-rc1-g89dbc07155c2 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.34-rc1-g89dbc07155c2 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Fri May 29 22:01:37 CST 2026
Linux version 6.18.34-rc1-g89dbc07155c2 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.34-rc1-g89dbc07155c2 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Fri May 29 22:19:13 CST 2026
Linux version 6.18.34-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT 
Linux version 6.18.34-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Fri May 29 22:38:58 CST 2026
Linux version 6.18.34-rc1-g89dbc07155c2 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.34-rc1-g89dbc07155c2 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Fri May 29 21:40:40 CST 2026


