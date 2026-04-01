Return-Path: <stable+bounces-232695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNwdOAK6zGmcWAYAu9opvQ
	(envelope-from <stable+bounces-232695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:24:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 441AF375236
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 08:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A628F302FA91
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F272E22B5;
	Wed,  1 Apr 2026 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DVLO9+KA"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEF22D949F;
	Wed,  1 Apr 2026 06:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024491; cv=none; b=LBV/uaJjR2ahEf9UzCS/IPcio343gPUsdC2lkPrlrG/vxrSPXCmWe4207hL2G7TtlBAgOFpr9XS969vcL0m8DXFMY++OecrkS7RdpKa4WeiF0PYvH3cJ/BIjuaugheG1Kp4z7FKz8beuLfI4Qp+Evw1c75HT0d6oLYndX2Q7TYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024491; c=relaxed/simple;
	bh=NWhwJw0PlNE4OKoOEQIDjgmBC50MfPtZs2HawxtzRik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qM2aY7UzvzHOuyIyYjqWTdx7MO2FPgiR5PzwDvMzJ9G8jqEXFTwRUJZnKnjoyQSK++mPlYqd3kV3sfNNG6jDaciEOjbPlfkWEzjjPWBSFGaBxixMQi7YDae2p+nOI+EkyGtuJAv54ixz30Ue9QsHHnLQbJDE5yJ4NELxrb7+DtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DVLO9+KA; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1775024390;
	bh=HZnzMfZvpqSSmoFTeNf3IjcL+zaPTTuEapnfCvVT6XA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=DVLO9+KAsmNUECF8tNGt15tJUrbgBiODjPs+CJMe7GwaEI+qdFRzl6eG/UBcAsezy
	 BFvXL47xwCGOWUju8oDqZs8/80asTj/1tdNCuIuzcmdnhxEEgZX14nt6LqAuOU61g2
	 E3W87Dh3appaEhclzI+MEpdLshikSDc/8ahX36B0=
X-QQ-mid: zesmtpip4t1775024383t4c81510f
X-QQ-Originating-IP: yYbonnb46PhHlXMaW2ne9Fw/sDTCKMfpUejnFRcrh7I=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Apr 2026 14:19:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6316390435373589281
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
Subject: Re: [PATCH 6.18 000/309] 6.18.21-rc1 review
Date: Wed,  1 Apr 2026 14:17:55 +0800
Message-Id: <20260401061754.237709-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N2bAIxLK0elnKdbMRogHz0kITFZDCukTAkSI03DeruhIqbGZU2JjqNWy
	A6r6xUu8R1MkFEW3UPxNsYVHlqW4lc7u72TPX6HeDDLgdLnzS/tBMrEiIF0SjW3HmlKbQ2e
	OpFpWrJbmmNcU6gvld2sPie8wxMoimhBFk0SUcGhhHMtW9hGX4oeA3yer6xA/zUShat59TZ
	+Zpf6VyYgtVylG5nul4n7ez0Fhbg7i7Q5RkC1AutNsnDll/1iNp9ecYJQ0c1HuGwHumwo4U
	+BiPKm0yaF8y+OBca/vcS9hc2lk94Qb6qe8KFfZ2KYXNkyJZP/6FhUT//GZGFX6fS1XSDES
	VpkFSsT7BavDmEXJIU34j2wrFGJA2X39SP/gENkV14HxmNikNhohMyk33C/c0XBP6B+legh
	P1GXvklV4cf/A+i5wFLqLOBGBa8+YTt7sYdz2xfcXWpav7MG+NSi38OCRODhHMBAtgr7ZRx
	rdUHnWGJLb2dTELY4wyy331Nxv8/6jjexeg02Te00I7Ez8FUFz3qrCyf9I7sGeQdVH3OKvT
	AOwzlYeD0KfjmCMwWttkNJ+mtus8CLQwnJ2yLuup6WGFWonTAaAz3aqDqOt2QG1X4jYIdqI
	LahCquUM4jCqYX2iAFSD/NLBXOdTbvJ4tcB7IkPrYKZ4eu0j/n9LihtiDB0RD6gsV+Kwzps
	uAqHY+a4ErpBsTa4VEpcqRF0fgF6GBGFk113BJzs6yqo0zdXgjxUOwoRq7KWfnbSixZ7yeV
	loVgH8s0TO8cq9iL4wH4eGk7Onk27tBZxsQnhcl8AicCa4FSia6wSs/zcUe6q50ptRbfgpf
	28l3Qx7LAap/cKYE6Jqwp1C1ujwofZ4++Q7S8bfIND1CvU5Ns7Hu3KtFtJazTF6L/uZCLzU
	9s7BWzjzyXzbaxWt9Hots5tz/kFhn1s2CisGGwfcmKDI83TjhWEZjPWcaec0Aci8vYpt4Hg
	RRT0nWKqH2o1jKohiRa3Oi0t+arRwtOuuqGQT+1MN8VQnSSX+r+CfP1a0jBvx5ezWiD8zLd
	id9LwwEikSlwP9XlTAgJxlsnSicTuM+fAyL/9pE2fFXqTWw6u6XwR/Li55+dcOWCVUIUvSC
	agS5cyc79eP
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232695-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid]
X-Rspamd-Queue-Id: 441AF375236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Build tested in our x86,arm64,loongarch,riscv config without error.

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

defconfigs:
https://gist.github.com/opsiff/decbc7d88fbf68488a7d90e46f6d3e59

Log:
strings vmlinux-* | grep "Linux version 6.18.21-rc1"
Linux version 6.18.21-rc1-g489a397a6e94 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.21-rc1-g489a397a6e94 (guanwentao@uos-PC) (aarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #2 SMP PREEMPT_DYNAMIC Wed Apr  1 11:29:04 CST 2026
Linux version 6.18.21-rc1-loong64-desktop-hwe-g489a397a6e94 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.21-rc1-loong64-desktop-hwe-g489a397a6e94 (guanwentao@uos-PC) (loongarch64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #3 SMP PREEMPT_DYNAMIC Wed Apr  1 11:58:15 CST 2026
Linux version 6.18.21-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT 
Linux version 6.18.21-rc1+ (guanwentao@uos-PC) (riscv64-linux-gnu-gcc-12 (Deepin 12.3.0-17deepin8) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #4 SMP PREEMPT Wed Apr  1 14:00:26 CST 2026
Linux version 6.18.21-rc1-g489a397a6e94 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin14) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) # SMP PREEMPT_DYNAMIC 
Linux version 6.18.21-rc1-g489a397a6e94 (guanwentao@uos-PC) (gcc (Deepin 12.3.0-17deepin14) 12.3.0, GNU ld (GNU Binutils for Deepin) 2.41) #1 SMP PREEMPT_DYNAMIC Wed Apr  1 10:56:53 CST 2026


