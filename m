Return-Path: <stable+bounces-249069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HT7I4WDCWrJdQQAu9opvQ
	(envelope-from <stable+bounces-249069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 10:59:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FC75600D6
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 10:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACEEA300A75D
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F46334A76F;
	Sun, 17 May 2026 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cYRr/Tmr"
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F432DCF57;
	Sun, 17 May 2026 08:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779008385; cv=none; b=lBZgEJzWGm8RTRz3Yb2Tb9z3XX3FGnT6hxe/9MNQqbl4rGfO3c25f4AVOsNL1uXDwyp+6Dq5t3xx+iDFxny0qw9AahOCqvdydqlmJclhVyx/L79sO+n5WLEUpSZSVp1lizO93tTbcaWN7xshpUFlNsVbfHAQtJBEzhZnMJTsVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779008385; c=relaxed/simple;
	bh=EGDYLLZiWbYBwOMquyklVR3ty5/+AvduHltxt6fuaOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SorlwFjLaj+p3qsQ+4Ghp6pXK2SIUQZXontojIaEC4qdCoNqpvbyDUauoSAoHn+kwogIz1i1nhtKfgp1DKxNC96aDBPc4SNSuyh5oS3cf+uaz//xG3McVRG1KuFAiSBh4+jyYHZHh+P0sEYK/3MCIPZrHzPcDxr8yXzASg3gDDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cYRr/Tmr; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779008304;
	bh=EGDYLLZiWbYBwOMquyklVR3ty5/+AvduHltxt6fuaOU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cYRr/TmrD8g2gqCjsr1AxK2jraKSGhL7Mp3rgNKBQRJT0IZxCAWqdEV0Ck4jT8Qi6
	 HU+TirXu/gDEkzUtZGbRKro4pqLgQ1YxhBO/1zyBGt9he8lUzUX+jFOhLj06oTuHoC
	 V8f3BZDtK2qZUGvMVMnSMJOaapSfWSI9OHXAwFPg=
X-QQ-mid: zesmtpip2t1779008298td77be0b4
X-QQ-Originating-IP: OnvlFHb/FLRDMDFG2KNmQL6pRfvFm3h75zyKXAWL1N0=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 17 May 2026 16:58:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16581266638349175935
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
Subject: Re: [PATCH 6.18 000/187] 6.18.32-rc2 review
Date: Sun, 17 May 2026 16:56:55 +0800
Message-Id: <20260517085655.754611-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260516102236.209957148@linuxfoundation.org>
References: <20260516102236.209957148@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MczAcLGAPQL2FYmamQZF2WpwjCDFJFTIwSFO7P7J3GXVeo3IUGHy0BEq
	A43/60Szky3XhdfT7WBb7OTLAORr2V51zR0QaKJOo3ezzkXwmwU32rrpjg3hCE/8tpfEx/r
	iKH03FAE6q1D+keEPzccfmP8CNew8nYr4XPt+mtOSrNyQsbyOmdP+eANlKKX89Of40tYH79
	vPJhCj+NW/jdBoEXOj4gyFG+KSwY8VfXWzizugQyQTetbPk3mTpMs/KXDoLbp/+d2V4Vk3X
	65Bt0ScRM5ZTluv9Fe1C08raxIqYZErDfGZZiQYKTFN49ad++hhpBoUa+RCnTs6rywrMd37
	dTG8tBehyBRwNdjFBO2z9hMInV0xo/Rvw4h4MjIWkX6aa7TiXYwJ7tc0NAzA8tLV4YX/L8d
	xIn54NzeKLSl5NTMyQ+Rh3mdjPRtckc/Bt3hkgbRWGr4Vg+lsAU6KqcqtjqVfs7tqDtfJTl
	OP4Osd/73Qrn61PHR8n/aPt5YpMorf43KSpdAZVCdWij5aREvLFUn6FcCHKAKaHQA1BPTOA
	x4h+ygOYzdw0vibPIWohD3HLzxCM8euRNb4EJfi7BxIgzr3U/63fvFtK3KOOdhuaizNyMlY
	K1/zm3qgYG404pWjPWnj2ZWvdopTS4RY7TSv9UQoVRGMdUw/PPrPPF8pnKsgwQPn6aQxl8y
	lgF2FU+2TsO395/nVnQ+oWSMF8Bh0rnTGJRw3jyDpvYCnZ30ih4ed6YBLENxH+CtM1LqiaV
	fi991EDZWT7NnWQblNVhwkRdIychx+e/lUG3hXCW2u5hjoUhHtQ/hG6M6JxrQNtk2Nt5EJp
	GF7aP2lrrnW6jXfvFDfBvE+tgKc4TzcT5YXIXLkqdBWQk75rfpFW3MNiLiQTaxKrRNhjhz8
	LTv5UM5UUqHfWHf3jncsaVnz0wJR01Vg3jRYnAeSENOEnHpv82wO96fW4qFImECHp4QX7YO
	lhdh0HaitYIkWFZCNH9lexQC2k5pYXAmjyRKduqWU6l3IEbPNx4pio5+tPWd1D8LyIrpByP
	ZFOkFFErqYnuI3o5oreosPxzMJAqMNqOwjm0i+4pwmRVXAv/+a/oGAb9SAhCJ4PBevbKTcM
	FEZ3122fPUDn3dI/in0ofP2W53H8ZxcKw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 73FC75600D6
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249069-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uos-pc:email]
X-Rspamd-Action: no action

Build tested in our x86,arm64,loongarch,riscv config successfully without 6.18.32-rc1 error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

defconfigs:
https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9

Log:
Linux version 6.18.32-rc2-g2ee21fdc348b (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.32-rc2-g2ee21fdc348b (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Sun May 17 15:33:49 CST 2026
Linux version 6.18.32-rc2-g2ee21fdc348b (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.32-rc2-g2ee21fdc348b (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Sun May 17 16:03:52 CST 2026
Linux version 6.18.32-rc2+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.18.32-rc2+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Sun May 17 16:35:13 CST 2026
Linux version 6.18.32-rc2-g2ee21fdc348b (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.32-rc2-g2ee21fdc348b (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Sun May 17 15:04:20 CST 2026

