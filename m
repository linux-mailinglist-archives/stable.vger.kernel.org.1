Return-Path: <stable+bounces-249076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD60I/yuCWpXlAQAu9opvQ
	(envelope-from <stable+bounces-249076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 14:05:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE088560E1E
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 14:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1F80300CC83
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5687935E1AF;
	Sun, 17 May 2026 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="j3Atcre2"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67DE405C5F;
	Sun, 17 May 2026 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779019511; cv=none; b=nUWb4iq4OCx0HXqw+Nb+OFxqXNSa1V7bv5K29iKbhP5YOTxFIrG3tyq6uMmpKibiFHyY+gmhu1X1IHMHA1M1dn1yoCbO5NEFkQcyOsqivKfbXqI6bbNnFBoxASR7snXBZTnGwP2QIx/GxWYAF6zGHI2Zgl981IsOApp4Q5juXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779019511; c=relaxed/simple;
	bh=OtXWl+k3usGYBnvkGDVnXXEYzLVmykoJcczCN0snD2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eWqxlzYG2c4nrSP+w42/hdi6SaNUpCNh7MogSyzsiQjLiba59iqNFVFaKbrsOYmVSgMWTXB5Io/KLO05c2iH8VbB/8YlU4/YRGbKKRT/NBZ0EO+nChmACn0o4zVZBHcUm3afrHh6zKiiJpP5yIhsx6qbAucGjuJkH2zVglZ7BuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=j3Atcre2; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1779019422;
	bh=OtXWl+k3usGYBnvkGDVnXXEYzLVmykoJcczCN0snD2E=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=j3Atcre2cjM5wzTrbseVc3AReYNZ6D24i+lOcOcTNn91y7KZlvWoDct0lqp/uanWA
	 1Mg1R/lCFS3ZlSnotgsdKWazeKJF9u1X8d1OkpDjnfTkPk02ptgtvi5iYkdqr5qNyH
	 aurAO4vU1YW11+kl59Be5M2WbuvvvnQqBEvoWwtE=
X-QQ-mid: zesmtpip2t1779019416tddc3375c
X-QQ-Originating-IP: N+lJ3L8fbyYczC/mV+z16jZ0gJdcxPvgU+WyLoMmYpU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 17 May 2026 20:03:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12950981022435617714
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
Subject: Re: [PATCH 6.12 000/143] 6.12.90-rc2 review
Date: Sun, 17 May 2026 20:02:13 +0800
Message-Id: <20260517120213.765904-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260516102210.570453769@linuxfoundation.org>
References: <20260516102210.570453769@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MSe4HyfuRpiamruV7Z6nsiFRoTM8XM5TN54esKhU+iZpNphpv0T18Pks
	AfrSK4ERXgnwIeylFqXzQ2pCNZ0Mv5TVk9KVHKS6mjb9mqij0bhUW6z6yH69oovKjsyL4ok
	O184mLHK7v4yIAXqjDZaV5Ud4GalufHbpJfBxV4XPwknbDRur2r0CMFBwJ9PWa5qJW685oW
	DBS7IynLPxQd8wUuNA6WAXwYpmwcYIM+yW8rYpGICQFBXFtpaalp0d/w3YWHQND5maQ5HdJ
	DSzT3ITaI9A7ZrAa9Uhc7fHSxMe7WPW40nYsEbya3Abs2Ed5A06jDunss3/4mpNjkpTFvf1
	+1WapKeX3lrGl4IGC8R5o85qvNvoe/EsKnZ6YyaTXwdiKUEisQGyzcrpOY4uoELeq1XqxZ6
	WwOI48z4KxDkot4dX5C9iNCBq2/JY0OxqTNPhod/fm9obeLvAGUNjdf4MaCtVAoRMNIwEIR
	M9qgLdb5yE+lAZAzWYsn5pC0aL4qVt4Igpb4uhq87o1B+DKb+BSq4IYbhXLFnl2rcrsqzrF
	aQlHUtBEXA+b4HfeuyBfzhDURkb+Sgj5TGPN3tX5XtZ0jcM0O0GnQzQfe+KRl8Q5lG3VF/g
	aMOFXb39wVZFPa5vPdZzDk9qpVbXpTNvuyCYaxQ3zipYHiqyJ+zgcj7C0Vr0jPj0YEHWgQg
	wi9lDKsOyqSP0HTc9oi1P3io10C7vBcPYqjUnqqK0+muRqvRh01SeNoDKvauifHV1RXTF/V
	1Icp6P/moFU0gUPK+A5Ww7WSAW4ST33DAGLlCJJFVXxQBaU0ppfHC56t/mQQ8I+Pnk8+S/D
	ISdQcg8rBhezJEcBJUVN8OHYSHWuLSkLQrIPweFuSnc+YioCQ/hO9rCso8ZDihM+KHIBsFt
	1LOjz43MFIm1G13IA/C6sDBMfzf6sSf7o3eD99bcKtC9c0pVpe9JRazjfbMMnGCkTZNDnDj
	W08mze0CUGHQLYlPfwZsl5cuhlZ1kLmWj9PgIUjjeBvdVN0q1+x5Qp68+/Esl6jWWxBG74/
	m2MR492E9InPSbzvtaHuXsLy808SVjI2Y2OtltCDhdkoKkdIREPtAUPRx70CLSqUI3pdkyF
	WjKiFR80Vx1SDWt/N/+yhrbKcYa8W2pWBkZe67oZteTsCWy0G6rk0qc5lUjq7z27g==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: AE088560E1E
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249076-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uos-pc:email]
X-Rspamd-Action: no action

Build tested in our x86,arm64,loongarch,riscv config successfully without 6.12.90-rc1 error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

Log:
Linux version 6.12.90-rc2-gb82aebd59f80 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.12.90-rc2-gb82aebd59f80 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT Sun May 17 19:08:08 CST 2026
Linux version 6.12.90-rc2-gb82aebd59f80 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.12.90-rc2-gb82aebd59f80 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Sun May 17 19:28:05 CST 2026
Linux version 6.12.90-rc2+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP
Linux version 6.12.90-rc2+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP Sun May 17 19:49:23 CST 2026
Linux version 6.12.90-rc2-gb82aebd59f80 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.12.90-rc2-gb82aebd59f80 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Sun May 17 18:50:02 CST 2026

