Return-Path: <stable+bounces-266646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FaRPF0lBMmo3xgUAu9opvQ
	(envelope-from <stable+bounces-266646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:40:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67697696E50
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:40:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=Owpdw5Nz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266646-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-266646-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC882301ECCC
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A83B635B;
	Wed, 17 Jun 2026 06:40:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10A3542F6;
	Wed, 17 Jun 2026 06:39:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678402; cv=none; b=XRf3xNozXzmcXp5P3QsWzL5zjTK7XM7IjlO9YVqkXC/KtLWLXM2btOTOsAzfyUG3uhUc8CGrAegyCWaEjjOoqxBmZnPQzNC5di2zywfET52C79gJGXa3X5kVO3Dg20dfjPj8XVUxpeine8muWluCkI23NXp27FoUvRR9Yaz3lD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678402; c=relaxed/simple;
	bh=8/9ViRRaBKEF2YISDo1QAVs+IVqgYW8NHcoRlBWau9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxCxBhw8LNLFJ5XmpGc4qyNWAt9rxyZB+DhMlP6Bep/yKvS5aQBRwPAsDMvs1RBqS6vmhzj7Xz3DPygekbErmP2l41uCzGzwdLvwCSd4759tvFPVQRZSmTHN501sXZczzUuKeFsHH57qHI0Y9c7rhO4H5Yx74N2GaytHJb1mtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Owpdw5Nz; arc=none smtp.client-ip=18.169.211.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781678319;
	bh=8/9ViRRaBKEF2YISDo1QAVs+IVqgYW8NHcoRlBWau9I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Owpdw5Nz+sCIUTs8Q69YvPr5HtCCCM21nUtZgAoM+oWR/ewQXIJbjgGRjUxV7VE7o
	 in9IHy+Ne1UBmcJy9f5zY4qfCOhl5LP1RjLi0uO88NRzi38ZVVKXkH68jisOE7Pl79
	 ZKJkxmBlio016VQ1hBoVic67qwBbH+V626IILVWE=
X-QQ-mid: zesmtpsz8t1781678312t3a5506a6
X-QQ-Originating-IP: L0uZcgUqq6qX+JAZdIvCU18Ar7NHQk/DXjZrshiJ6EU=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jun 2026 14:38:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14321659712413733696
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
Subject: Re: [PATCH 6.18 000/325] 6.18.36-rc1 review
Date: Wed, 17 Jun 2026 14:38:21 +0800
Message-Id: <20260617063820.880745-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NU60Kbs86PFjh5YoCQ4I3+fsJ1FXvYlJdJ5yI4wHGq/EyI0Bdqy7wT1w
	uj8tAB/fzOTJlEy89kn+3IzI6OZl2xX3bRIPUAkHqD+9/XqaL4G50Wfc9WoIP57/56MK90P
	xY9gx/8bWkfpx8xewYrSG8DHG3lHBv0vy+I4SrTxEd297DV+nhpzBZotkrGyB/ybE/8Lb02
	oelnHGLcEqUjNLvjAKKX6+QubKM4KUeqKbVi7gxA/rQOHHAooPTH+gNT96bKswb3wa+i/xu
	IuFja9F0qz0d+hbI+L3P7dmgRe05UrX2oTVa5E4Z+1+KN6aKMPahtaM02AUPovIghtYxllx
	qHqVRtr8BlV4luezXSfnICH30PEoqTZA6X6fhOf1l4HubOiEyqDXhMNX7SobUwDKuE/rf8v
	dvlArz1W5vq+fmJ9CDycmW3ZiHJJym1rnkydeQ22lzRj5CMls2V7BYZDr6VBItMd2ygtKhZ
	/xgAaXgnyQWboyeygZ239ue2cOM/pR8J5/8VIzIUv+V2hneSzNbk8SbL56j8oMoNczTFYFO
	R+T0AT097fcv0//hW23ZxRPD+zCAE5hwlSzDQvrE++p9pkKyT7tTUs952L+vqcItfCe6CzW
	5Mm7Omj44NAPU5TVj6CQV0H1w3Fit9VIDmmFTaAFCh85skCurYhCzt19ghA80GC7fREJgZ7
	xyBShZK85DSXN23e7hdnjkm/twXZr+wZOBVX9LSGfpXshOkIhCGCpFoTv61qn2mxSuD/lID
	XGxcpTTmG3OydU8JXo7zJon+rptZ5ndnXpEY2OkUN2dEaY+rLr5xUNJr0nBd/A5rmsZS5jz
	N29cA8AuPIVLrE4RKHDPmnO/+F8x4n/UBb72zdBE7vBNa7I05LR40AjZ57cOWD7Sd2LjVn8
	Hl21lbjxHnONLU+77/Hfe4kYMC3iz9q9TgaIIU7YdD3XPZ5XChWAHn6cdiCx3hKYRsKhtwJ
	g01oxEY9Hg1Fz9ry6sNDW6hal7e38L3NVCOpctPoppx52DsrPmvGE2ep8MqU+LV6ORWF9Oi
	XBRinJvkjX2pY/fZTh9MwAbLbaPdnbem3bxM5lTBZ3l4b7pfbBZ8xr/CEhVBrwQJNvPYw+Q
	auXKjcOd9vLSs9IAR0Ir9U=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266646-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:guanwentao@uniontech.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67697696E50

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

defconfigs:
https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9

Log:
Linux version 6.18.36-rc1-g1b6356bc9016 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.36-rc1-g1b6356bc9016 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Wed Jun 17 10:22:33 CST 2026
Linux version 6.18.36-rc1-g1b6356bc9016 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.36-rc1-g1b6356bc9016 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Wed Jun 17 10:45:35 CST 2026
Linux version 6.18.36-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.18.36-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Wed Jun 17 11:02:54 CST 2026
Linux version 6.18.36-rc1-g1b6356bc9016 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.36-rc1-g1b6356bc9016 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Wed Jun 17 09:57:57 CST 2026

