Return-Path: <stable+bounces-253458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGUyD6uhDmpCAwYAu9opvQ
	(envelope-from <stable+bounces-253458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:09:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EE259F4DB
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BBEC3046E85
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 06:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659C3859FA;
	Thu, 21 May 2026 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BpgkYGHv"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58B3349B0D;
	Thu, 21 May 2026 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779343777; cv=none; b=gVOJ4KaN9kIktjrmu12ICJB7XbFQV5l560OAX8TRez4UaZ0Bbc7qMtbUHzqyPYQivhiBquMMZn/Pxp1VZz3Qp823KTeJYMAGNneRERWbmPexggXrOdtwd9Vv777M8u4dFrzufWyInPULld4Vv9aDyApsfLGr0sZIi1IgnjvbnC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779343777; c=relaxed/simple;
	bh=lK0qXiaKe0/6Jz1GnuzGCLwDNCSso3TwJw9y2geVDLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L2/JEvKCy6Qqje2QuWxHjgpGyPK4CuFeMEnWsaqfuQyFBTu5J2il/GB0+vK0UA/4vtKtwCDsy0eMnw8fTnzfPej9T8Yr08lO1StmALqo0tXSyg8lHnaw7C6PZWflu7ZcYTEROkh9BY7E8LAE3j6V0fWW5S6ahrcFeivfQdldQwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BpgkYGHv; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779343699;
	bh=lK0qXiaKe0/6Jz1GnuzGCLwDNCSso3TwJw9y2geVDLc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BpgkYGHvtgMTTO3FHtY6GaQV9RlHp16a2RfGQrWuHWsHGmp2tx9p77VrF0x+psbtM
	 qxJdY0ebEdJRkcP+kDTb+zJ7T7TH/1g6OzRHMvHqhCVA7OmZNI6brej26g4W+c9TkF
	 MP/rnMDFmZ1y25DOCB9ZEd7oCfr9EkxQLFdZvS4g=
X-QQ-mid: esmtpgz13t1779343692td0c60c00
X-QQ-Originating-IP: 2PLor4HyUO1Hkt/6YDGb7lTq1vS9W181eRmVi8yAc3U=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 May 2026 14:08:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10739255474463228470
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
Subject: Re: [PATCH 6.18 000/957] 6.18.32-rc1 review
Date: Thu, 21 May 2026 14:06:42 +0800
Message-Id: <20260521060641.1160944-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N9zSUNWYtR2/PVDEC3lGO4AAGGpemtWvh109i42aPXYZk6+cOlynEVsa
	JxIPJDwosx87m7GbkT7T2znbFAe+IswzmSAE6YD7QcwOMt3vfVqPhy9dXlhsH0LDRMTrNTW
	lYBca0bYwGaHjgkVBbmIQsgnmEN2WMAvClPcG6OnFFIVJrf9/Lb4Z/N+rzPDNvgDbiOm1lG
	of5TEb/5F0gP+et2/F7j7wiCqdVJleiGOnMAa1dGq3XLNuZ3OXiO8wvV8DFcetdXX6ih8WN
	FtBVTT4jpkGhuH01WLxD4d0lERCQJpy0+2Fre22YlgN2DX+iQGduwr3nNJXajgEDERpoSQu
	tk5T91CODDqopf0LEYGLWBj0zGXuQVpr/eZxe/XvarYTnMAauXEjsCoN7yYIMt1aW52zXMq
	SRcGeqvyZQgICuxLCPom2cFk9rSQU/5DirUZ1Qljp2W4n+/7SKXBjWf8Kshdh0Ohd1Knw5H
	51GijUfWI24IA7r53hrHiK3jhEhqK8Tejo+xjOCJC5vWHOBDEhdjkuMIxbc6QrDxji9/QbC
	4+mR1tz/QNqHgIqjA5iRR/eExzVBlxHFTF0Siv2Cd9v9ZxnQ6RropqZYk9aiitzAlmqee+g
	Fca/ecb8hbDwOpuF423R34bUxBnw1buklGFoGnotNnwpfUl8JOt+I7ef37itG4tP7oEoOhT
	8toXd79aEXE9tnQmuvrSXLNrqH6GVNkrAh+nXywOFXNdO+D/NR6mo/6FwVt5jxlNPBJbar2
	Ah3dw7jVAZ+m+FFUq5DKypmpFDXW9JAvF8tuRUVdV86eCfKgNvgEmBK8wIPoJK5KQqBbCGD
	Z8RCWej19UP1e0bnElSvnEtKUZxiSRg6v1Z6F5aPx0qJmeuefG0E+KZi5D8DNYM1FUDCErD
	65y8OMRtbBCcL3WyToQ0A6/1vVGtQ1cPbgt8SGZyYr88inaFN1RWhcXDKy5Bi2gzDZaHamn
	pK5uXj6cmMI2vdZmI/6j+E55ZljD24gB7DgLw6JNnzZARG4GwXAPtsIyZO86i91snbnH/7X
	rCt5M1eiPcyljAch1Iy7B5jYEgoyNQJ/AcwZdCX+RPZLiDO+U4geMDRZZbW3GbitFt8KaEX
	a3H6VEQx1yxsV2M11fNo5blAke66vvti2ARM8z7xbmI5wuSU2TBbgCrYW44ACozU+97XH4P
	BVCm
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
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
	TAGGED_FROM(0.00)[bounces-253458-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,uos-pc:email]
X-Rspamd-Queue-Id: C1EE259F4DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

defconfigs:
https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9

I means that 6.18.32-rc1 is 6.18.33-rc1.
Log:
Linux version 6.18.32-rc1-gb7adc4ce3f26 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.18.32-rc1-gb7adc4ce3f26 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT Thu May 21 12:18:48 CST 2026
Linux version 6.18.32-rc1-gb7adc4ce3f26 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.32-rc1-gb7adc4ce3f26 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Thu May 21 12:33:52 CST 2026
Linux version 6.18.32-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP
Linux version 6.18.32-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP Thu May 21 12:49:11 CST 2026
Linux version 6.18.32-rc1-gb7adc4ce3f26 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.32-rc1-gb7adc4ce3f26 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Thu May 21 12:01:24 CST 2026


