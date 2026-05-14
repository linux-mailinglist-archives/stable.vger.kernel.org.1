Return-Path: <stable+bounces-247242-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOpcH+TxBWq3dgIAu9opvQ
	(envelope-from <stable+bounces-247242-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:01:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C467854466F
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9EF2C3007A78
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 16:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E836329365;
	Thu, 14 May 2026 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="CJZe4RpF"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA331B11E;
	Thu, 14 May 2026 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778774473; cv=none; b=UI+YiFa4byOEAOIPR5DFIQLBbdckN6rFW3w46q1P2HjrBgvtbbzJYRM2azfdPk2IUqkvo+CHq6L5imul4mV7C5bJt0xwC8jzGqwkKurk4S5SOCQzg2FrCtlaxEDu6tKQRzYjpcBgZdKlJgP1JkKsSk8grWwnn2bnNoSzCIXF+78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778774473; c=relaxed/simple;
	bh=QIsDG66HnAC31RA+POj6UTFZ3PY5KCH6nE1mFBNkGUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=epEsHC4yGrL7AN9aQRKXsOSEd7d6MWMnyKc26czCcObD6d49k72qq0HeyxmOfgFdpK1RI16dy7Ty2Yx+fe+6FEkw7bVUAacJmFD5KKUhp7pVgrk7FJ7iIx0J9ImoXndBtYzMbYcUoJ6sgZM8WPufXKTNKviQ/uQEpcING9OZ0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=CJZe4RpF; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778774358;
	bh=QIsDG66HnAC31RA+POj6UTFZ3PY5KCH6nE1mFBNkGUM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=CJZe4RpFb/jEVd960yyHW4ajIIkNba9RRGjBMTW2c4rhywoPAghGS7ZxpDbdTeP6/
	 k/rHEwr02Vc22FXzDQedu50qBsjIFPU89vVhOl4u8vy/IixqJSuzcIYufoHPm2LCsx
	 D3tWbgU2RL9NbmofYR7a6+Usb7Xg5SM48guXixSM=
X-QQ-mid: esmtpgz16t1778774352t1070e312
X-QQ-Originating-IP: LuWI56tf0CfKs5BEqnAnu607Ih8bt8YEWiKbRxpL4ek=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 May 2026 23:59:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6921566505251205290
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
Subject: Re: [PATCH 6.18 000/268] 6.18.30-rc2 review
Date: Thu, 14 May 2026 23:57:49 +0800
Message-Id: <20260514155749.487213-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260513153744.746440810@linuxfoundation.org>
References: <20260513153744.746440810@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N/BaP5J2bFjvbYkFpxsefG3Q9iT0BxsAfBDKGUPvBN4JoYS4A/Yu0PPz
	SMQL9WW7zcFxBALnW12M5eyNFx42hWhftqsmkfd1oaqAvbDYsWvZEfmRykQjfwbuWemyBPF
	9V18+txnDjvFGG/FBRQhqcf0k8bpWAHA+rNOCLlt7Dsomv/AekpsfSIBa2u1cDBOz2qkHpk
	o3oVQEUAO3O77Gp7n7JU6QBmKnFP4WaQ9X0rQhYpnnaAKCYOZRuRheLX0UGInhUdHdJDzfM
	kO2EQeO6fYMMEwCoZ1I+TjP0OnIhyENcEANqJ80FFI+EDq1deSMTx17/TSOSVFw/+il+Q0G
	fbrYGrJJ4/KvZHiuGuy7nuHEwgiUikbscAObHTodsc4i8aje1I9YVZNaQopPtno4ljEyXqX
	lb1v03O1oHamVSsa9eKhy9g38Kpub9H48BBlJw9wPToBNaAih952jkNlyT+kZJAj+4spOG2
	0RILgTbbG71mVSIQ1MuMDiaVHeLZK67tI1GRUrsALRMPFvZuKuz1DopSsUv8koKQpRUMZTR
	5zDFb5zepvBQvAyIe3LeUV+5/YUBN54hDfWS1Pq79Gjh3naDATpzxgtis23GliBrJvIBHSL
	PHsf7MAT4g6iDTotyxNHJvzeAAxnNvn6yfQC62xqrUaddTh3qxVE48+BCMJ8n6jCg/kdYzz
	my3TzO19Qn8c4Cas7HoQuu5iN/FM90Bjw+24tl0lEhWAEshiriq0ubPSAT14CVm5guBtyis
	I3yDIImdX0g9wy+HoXatpEXGxt844klfQRHT66bdexihCoZSRvhSJKpXRRGT0WxMQdAq2gc
	tJGaNMrCtKwCVhrKNL5fhq3cyOo8tydoV1w+49PlNFjFrZaUQuP5yE6v8Hxobj2I0hdeXY6
	qG1yrwle/JS8r0K4m/SdampxsDnnLLm4OQonc6q2Wk+xU2oI8Nip+4a1dq0V1rJJFB1w1U9
	WSZwFqHjE5QrVCTOozf+HTgbZsPzdyloIVzz2r4EVDusyhX+c9NoZBUhM7e8srk+V7wM1+D
	ayM6Sgys0AtA5mZ/oFOGuFWYmJ4qTZQY0rqBRcivIujLjcYUmJ8nmZj5qxu2HAAic/xd4O8
	almQd8Kdt5Zayqx/D+gT6f8IUNRIzM6mA==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: C467854466F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-247242-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RSPAMD_EMAILBL_FAIL(0.00)[guanwentao.uos-pc:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uos-pc:email,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

defconfigs:
https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9

Log:
Linux version 6.18.30-rc2-gf83e9543dfa5 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.30-rc2-gf83e9543dfa5 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Thu May 14 23:10:57 CST 2026
Linux version 6.18.30-rc2-gf83e9543dfa5 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.30-rc2-gf83e9543dfa5 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Thu May 14 23:28:41 CST 2026
Linux version 6.18.30-rc2+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.18.30-rc2+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Thu May 14 23:45:36 CST 2026
Linux version 6.18.30-rc2-gf83e9543dfa5 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.30-rc2-gf83e9543dfa5 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Thu May 14 22:46:55 CST 2026


