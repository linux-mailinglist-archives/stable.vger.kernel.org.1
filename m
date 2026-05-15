Return-Path: <stable+bounces-248901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNSRBEF2B2pL4QIAu9opvQ
	(envelope-from <stable+bounces-248901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:38:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA1556FAB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 21:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3248130C51C7
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1D3DEFED;
	Fri, 15 May 2026 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="O7dqmSiL"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F238F629;
	Fri, 15 May 2026 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873077; cv=none; b=gDTs6DEbVWMUjSShgMeTm4/jjWD6RXMN9+UISvygY+pzs9CgNNRKNFT9DRxkSL8BX2d5LjV++VR8r9FLu6vUY5meGIFeMQ7nLI/4A9upfs4vyh8B7jIkbfS4XnVU1MX64aUNa0pReY22onMUQ202HGXPLXVyqudRslCPxFitb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873077; c=relaxed/simple;
	bh=kyfxj2mo5rCxHXOxm5xyMoAMsP60CFmZJY6lx/DDl4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bpoYSx8EnGtbfxgS6gzZf31exVAf0Quql7/zl56CGX5vipuZVAyjUzQ2NvgLShltOgOnILVoLVJ/S7J75nV9B6HCp5nUBZjtYJ1eFkjyDxrsaQvYIlBBXWzwKB0wtDqiQ41Fr6EtecX218pMG81cvOTP0GXKSxMpFl7Hw//o4p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=O7dqmSiL; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778872991;
	bh=kyfxj2mo5rCxHXOxm5xyMoAMsP60CFmZJY6lx/DDl4Y=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=O7dqmSiLahnLLTfctcXTswGLD/rm3LqgVlp06s52SITSQn/l2jI0uPDWeLg9lGGGt
	 jciDZv762GcujGYrfBWtJEH5SuTqkx11tqLKyJvWGOagT/OG5r5c9TV+7F+FWHHrLD
	 PHTLpFpNu1wP50TMZA4uvtbDCj5FN8wo3GyCDWig=
X-QQ-mid: zesmtpip3t1778872984t33a6089d
X-QQ-Originating-IP: EjvclRGT8guTSOtt91bOuSf2bxlwu4W1wKTVJeHVvSU=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 May 2026 03:23:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2303780427200084558
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
Subject: Re: [PATCH 6.6 000/474] 6.6.140-rc1 review
Date: Sat, 16 May 2026 03:21:40 +0800
Message-Id: <20260515192140.621472-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OHWc+cbX84vH4u8BCbP4CqQ5sLZx4F1V2ybM10tQNm751txco0110R7m
	LkW7TxjzXxpJhUF4MXmy1lSHhqwyc365HV3hPOWgoZoMb0CMcPedU+WLG6ck8ALhgc7gbfI
	AG1Ct3nEzxYcNDMS9TSZmMvUBR4SAZ379e/AKXqUULI5XrAFwrA6/M+B3PZmEcuf9wLifb/
	5PgR78cXRlT6iknme7Ao9pv7bgZlsRgzn54cZ9bEGK/M8/8H9EwzMv2OqHdZFANPIMI9bwV
	mnkz/AdFdf1uMrGBcnb5GX6+Q2LEfCqUgMguO3eI2YFKjSctSs9pjBcbUD22svuufNZ8R3G
	W65RwfqmPJV8Yt8bbN9MyBsk2wroJ+N+bStPgqyt+a4RN/x5eA2ZNG9Q1RV+k7jn4ertD2x
	JoAQ8Al9nPctUdEfx8xiW0rl8JXUQg7B44rNumRWlEH8lA3JQv4VdEMCR1H7QD/iYcwmOX3
	/TKexZb+pCnj83p/kyNfCxsmZzGrdiPftlD5P67/dt76lrv1v0IPlGeuo/1uBTFHuVMu71q
	vzZOXqcDftD1OUDM4E8p24WNtPh6yHqZ62del+omkAKQOomGHvLXO10ZW+vaXCUbuCzm+/Z
	mcUb9vNUIuh9zJVB/cHQt/0aBxqI/dS6BEhC4HOWWzdNmMDT4gETNE+27NaPHHnnTEiRubf
	SrDxPfgIh4vOR+Os4XLcs3jsFZFnmNbIw3WHiKosFBVebl29G9UwYqaKpaeOmPUZxvsI5cl
	rqVZ9AJRUfxitIqIVpPE4LQzVXwBZXs9QAgHzI2LoJ740BbQ5Y7eZZuXE8NoNmuJ498RgCK
	9Bjob3pcT1inpSw395bF+Wgp47sHQJjxEzjHirHYGiXnOADi5Ln//iLUMvfXhgWtGgLT6dl
	85QUV7zQA/sMGMCcVg0Qvib1Np+kxcLOt164itd06Ds9ITwUehtub7mYDTF2c6X5uim7cA1
	BBil8D9XYuzyL8T83J6n8majZG5RYigIW5TiegKGVaIAS0eJIY+H2UZalHbs4qIBWMUZWpc
	J2bgGxSmayZ5PvZaAklQjMxsIqBWqtUMH09qgHfR/eEjujmrdMHZzHbxmNIEeGF9q2Ypfti
	ErKLMf3JHxg
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 77AA1556FAB
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
	TAGGED_FROM(0.00)[bounces-248901-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Build tested in our x86,arm64,loongarch,riscv config successfully without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

Log:
Linux version 6.6.140-rc1-arm64-desktop-hwe-g7a0265922ac4-dirty (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.6.140-rc1-arm64-desktop-hwe-g7a0265922ac4-dirty (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #25.01.01.23 SMP PREEMPT Sat May 16 02:47:56 CST 2026
Linux version 6.6.140-rc1-loong64-desktop-hwe-g7a0265922ac4-dirty (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT
Linux version 6.6.140-rc1-loong64-desktop-hwe-g7a0265922ac4-dirty (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #25.01.01.23 SMP PREEMPT Sat May 16 03:02:51 CST 2026
Linux version 6.6.140-rc1-riscv64-desktop-hwe+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP
Linux version 6.6.140-rc1-riscv64-desktop-hwe+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #25.01.01.23 SMP Sat May 16 03:17:21 CST 2026
Linux version 6.6.140-rc1-amd64-desktop-hwe-g7a0265922ac4-dirty (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC
Linux version 6.6.140-rc1-amd64-desktop-hwe-g7a0265922ac4-dirty (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin15) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #25.01.01.23 SMP PREEMPT_DYNAMIC Sat May 16 02:31:39 CST 2026

