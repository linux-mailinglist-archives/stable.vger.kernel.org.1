Return-Path: <stable+bounces-227223-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCL0NS6fu2kLmAIAu9opvQ
	(envelope-from <stable+bounces-227223-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:01:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BA43A2C704F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C650F300C7CC
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D64738B140;
	Thu, 19 Mar 2026 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="eYVb1JgF"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7220397E99;
	Thu, 19 Mar 2026 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903626; cv=none; b=EQMQekxZz3zyieDuq+o51pfjiTIKNQfLPmugB3AKBe1l7O/62/ToyKy+/B2WNpQr+4kv1fhQ7e/zY8gkFc335AU2khQ4D4FDnEQzqBfLUwumVV7MMhf5c6NKttBmwixNowSBghiY2Ca6lw8Ivx+ahG56a78miAa/agZQRLn4sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903626; c=relaxed/simple;
	bh=tfSo07p9kP2k0yOq/vyE8jSA85R5JBaNYmOl4Di8iWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMyjXNeT3J87Kz7I5jpVAS5Imeo7aaPxUiIFAgTFmJMk7K7eNIaAa2rIx2SW0KGc0cU0tFhx0Jtf+cMtehZzvy5Hwuj3XhAc9pmgnRnheAu7IO4tlr9xx5J7pQlA4W2xwjJJyF1BnrbpO/Big5i+6rIuFolXglzpELt5CfHBLiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=eYVb1JgF; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1773903502;
	bh=tfSo07p9kP2k0yOq/vyE8jSA85R5JBaNYmOl4Di8iWs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=eYVb1JgFKg1jOEJ/VH1RJrDT3VdQa1mu4/RCCuTo2rOTLGstJkpz3kW/QqRXQRz7E
	 FDoOxgD6dXm2Fbr1qMSSbn2N8lvTBVbi8Ws4YDtoMCKsivKN/8fBBk87qfP35tNDJ6
	 7UmdR/cCPN7lMv4IP+6f0M7WDIhfXlQWNAdttrPE=
X-QQ-mid: zesmtpip3t1773903495t1cdd0f2e
X-QQ-Originating-IP: Z14SeiRpFBicsPXaWHT63VJxEZPfcm7o6/zAG1l1+gw=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 19 Mar 2026 14:58:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4130904497638004089
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
Subject: Re: [PATCH 6.18 000/335] 6.18.19-rc2 review
Date: Thu, 19 Mar 2026 14:57:14 +0800
Message-Id: <20260319065714.925454-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260318122621.714862892@linuxfoundation.org>
References: <20260318122621.714862892@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OPf0glEsUFOQi8r/9kwQt1mbs/ywgIYLyJQP1Zj/+BUjQPNSnXA2JHeb
	qWviGXUtBZgz7ljNNTSg1bHdTDIg7wRRsmS2+ZlXlrFHOw0gqoB2WYizLfC1OBGP+r0rhLP
	B+/Uh6JweFKAMZl3IduR1jupe2x2mEhcC3vsiIRjtBbTX3/xs+c29FF+QlAggCAsBA3AOZ/
	Cck4lKz5xWi2EBnygq+clrzoEz3Y0AJCEeRFLx1Axt674i487NPJ0m7k/HxWZlPuCz/vWNb
	zFYEoJT7raGLtI0BUwoF6/gaOnB7sx7zdiJfUT+igMZZ85MvN1iTAKR7hQKEvp7alOo6LV5
	B5V4iDqFjOvtkA2lqzINsoGwg/GVPBiiCSxMv0lnxT77USRyzoK7bYsyUcTnnaXSlgzETst
	VjXG4OoVwebsYVzQ6CEJBEnawhE60ELxQZXuKzJDmMhYGQjr8q8VAtBISG0R01Q3CKOOt4g
	HmN9/HvvcS7pDjyxuLyCgoUL1E+mnY3yjStrNKViSY9rOiIsRKbneYRDa/0xEdNCuw17/WS
	/MabBTNl9YqBCnH2LLf6qtUgkbFoHDUyWU2l19Hb3FZCZu8uQZy0rkblc5ezVn1EPJfWLq5
	rgtYD3Eeny6tkQEICwGumjpmTpPfmJVYwNbai8gWxP2E7i5WGg99FZ0cKWNxkhoCiH1zBPP
	KDVvgMoq6fqTiJtuPCGosA+td8PL/f7yNruy5Fwdysah9HpN8LxjZOBokqplIbJpeofUOp3
	ogBkSEg4ZbS+PVUYA5J7X3sf1hg7Mxb8Ra5f9q6fiatnDdGtVxijV/5w3p+116wyDxQ2RbL
	L2+EyWXySdmnZy0XXWiTJ0v2eI7g5Bj0Zb4fFnSN0izUtmlSFNcAcshnMh7B+edzTTVWQqv
	/WExbnvTC2QRNxCAuBPzal8LcS2TF7q6fA/p+Uza3g2Q0fIurveF2mqVc91XxzOvNnOpHhO
	mMopUplJUs9LxZ1wI6R/LTvnWweP3pZRzP1R/sIaoxDX+p+l6jQmmEORtj2y2yxdV3q2Oa6
	lIP4UveCISOwTGsFbdXpt5ellYYEw=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227223-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.937];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uos-pc:email]
X-Rspamd-Queue-Id: BA43A2C704F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Now build success in our x86,arm64,loongarch config without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

Log:
strings vmlinux-* | grep "Linux version 6.18.19-rc2"
Linux version 6.18.19-rc2-g1cc312cd0408-dirty (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.19-rc2-g1cc312cd0408-dirty (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #25.01.00.17 SMP PREEMPT_DYNAMIC Thu Mar 19 13:43:54 CST 2026
Linux version 6.18.19-rc2-loong64-desktop-hwe-g1cc312cd0408-dirty (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.19-rc2-loong64-desktop-hwe-g1cc312cd0408-dirty (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #25.01.00.17 SMP PREEMPT_DYNAMIC Thu Mar 19 14:25:35 CST 2026
Linux version 6.18.19-rc2-g1cc312cd0408-dirty (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin14) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.18.19-rc2-g1cc312cd0408-dirty (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin14) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #25.01.00.17 SMP PREEMPT_DYNAMIC Thu Mar 19 12:35:44 CST 2026


