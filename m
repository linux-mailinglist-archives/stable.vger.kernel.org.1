Return-Path: <stable+bounces-248884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0COmKWdhB2q90wIAu9opvQ
	(envelope-from <stable+bounces-248884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:09:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22476555EEF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B70E314A368
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932D3D6471;
	Fri, 15 May 2026 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cbihZQJq"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B53D5246;
	Fri, 15 May 2026 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778865378; cv=none; b=VdoOh7Mhdsf/qias4qa9cB+3Mot2/QYW9bQwZF5fQB/aUOhTnQV+lIj3AWFlqwm9qw21GP2f+EKIBIR9Z58Tt7lwG9KqqcRLtz+X1yU2sUiU2O3RedXa3ZxTjfUUQe5YC6oTzZ9Yk2bXKUk2TCKTBhJlG9HX95SI7Y9TScr286g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778865378; c=relaxed/simple;
	bh=DI/6D/R5nHTuDntls6I2FBYAisir9sF9H9f3qLqPKOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=psRtroQqosz3zMUUA4kYp8CFTwa6mJ1kxbeqLzKxAdToO7TKkD2VeiL35C0NypYLeLYmzLdeRjwsZqiklMix5A0818JfXl8Sms7h4fPHyyQecxdZcI4SBlT57BqdqxIMVPKIa8M9LBirhu5ZQF20RiRQTC27Fbz5csXh9tSCo44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cbihZQJq; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778865282;
	bh=+dkHU0yum/qGskzBEdOQ2VhQjD07OM1eCJK8M6tYl6A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=cbihZQJqL733IzgrAsovW4PHI9MfZI1TUAC2hNfZCiyc+T4hxnMZqsX1GWONENg8T
	 xoo/PUBRHdLtMwA+EzcFICHq9fPgRhSeF/hwIJ969gcG3GqQApYwyuj1gitkE75vS2
	 FDj/Sqi6m/oPq6ZwPa0LZ1jWJPsugugRx4Ajj0Fg=
X-QQ-mid: zesmtpip2t1778865277ta37a6308
X-QQ-Originating-IP: BVaw1WmTVjX6UJvjaRuQKIdWGuQDo0toGNBLtoMZANg=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 16 May 2026 01:14:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18348356817988327989
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
Subject: Re: [PATCH 6.18 000/188] 6.18.32-rc1 review
Date: Sat, 16 May 2026 01:13:04 +0800
Message-Id: <20260515171303.613447-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OBP6NRneNv5in6VFnSCXlgjhpdEEjRL8jryzan7LYDwX55Rkpuj/fK5f
	iAPIzwhTxo8nJgXPdphvZwHM8m6zSSyO6sSYIvAg1MjgZcCRIS+mWRztVBprRj5DoqwV8HX
	4p0FqvLjGZzuQ5iygLTY8mn4frNSyNUAKbLwMaEP4lykYjf6GdUPJOE9u0iqqKmwrGEo3wT
	Kndnv499r3sSYt7DtKzbY8JdMoecONoxyWdZRgfJGWKOsyrIx3/GRNOfKMhbluO4KbubeTX
	yRptm52UlZdrdbYxP1SgrndZSHHYRBRBCgOq0UmVpbrrkt9Bq+94k9/1cjPafsb0TEbEf4O
	JkTDaJnysZfsWDekhi8JxSUnxadaGksthQGngfTT5TX/4uTihGXocvicI8RXYFm3Kq4Xv7w
	ZWPZIf4PjOe8cEJeknkIzHY9OK9u8naz4u6RVFv94r2d1nZS1/3270irY+OkvwhnfPdy3zq
	yYxIAupf3gj4nyST50L5PU0PTnG5lLBiDD4ZxVnHooSvZO46wYpGKifP6KvpbgOarygy1Fk
	zew/iorN16jTfVscM7E+YFmyAcgPHcVB8C0Jz44S0a2Xx0nXXycyBM7SU4aHQwe7BgdIdtg
	xzNKlzinZCvrcM4y0QTYZPSHxo3f6c9wsm5ZRHJGE5it4PMMOujiDW2gH53x4y1XfdXWqIX
	fT97su+MtdMVxN6EbHlPAnZQiwp1g5yqEuPyLnTY5sezXQSbo0krmvBanCKQlUkcFSuWV2f
	uKoEzVNVQpykqQ67uxCDAlF3yc30mkPn5iZMT3nlT8guI28TMHUuGdRmhT2+rgz1UTzP7Hy
	fpVp7uKFrev7lHMfkUzWly30ELBgVMN+evPxjyNv2oLRePOCZpvXCaLKBeo/0qDkMMX58Qt
	DgCucLdyUIak5XvnMyupGBKnC7AueRHCESTwBYP+VZb48wLt8mXMqMikx6EAAIxmt2A5CoM
	ngQudSmvGqvtKYS4b7rYf4n4Cmf6L4gGIb1ipg+vAsTArPp/dgo9/PmtkbBpjcSZOgkSxWg
	pIijnMKuFssHS/q6VOoRBJgP4Kt3EM6LcoaB6Q3FAHWuYu5uqsJKSIl0lAeRECiMwp5fR1l
	Q==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 22476555EEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248884-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,uniontech.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim,infradead.org:email]
X-Rspamd-Action: no action

Build failed, you can drop the commit to build ok:
git revert 0253904dd601b15da2983297d64c106a393b3aa3.
Revert "sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation"

Tested-by: Wentao Guan <guanwentao@uniontech.com>

BRs
Wentao Guan

defconfigs:
https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9

Log:
kernel/sched/ext.c: In function ‘scx_enable’:
kernel/sched/ext.c:4924:34: error: ‘HK_TYPE_DOMAIN_BOOT’ undeclared (first use in this function); did you mean ‘HK_TYPE_DOMAIN’?
 4924 |         if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
      |                                  ^~~~~~~~~~~~~~~~~~~
      |                                  HK_TYPE_DOMAIN
kernel/sched/ext.c:4924:34: note: each undeclared identifier is reported only once for each function it appears in
  CC [M]  crypto/algif_hash.o

commit 4fca0e550d506e1c95504c2d9247bc92bf621bf6
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Mon May 26 13:06:21 2025 +0200

    sched/isolation: Save boot defined domain flags

    HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
    but also cpuset isolated partitions.

    Housekeeping still needs a way to record what was initially passed
    to isolcpus= in order to keep these CPUs isolated after a cpuset
    isolated partition is modified or destroyed while containing some of
    them.

    Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.

    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Reviewed-by: Phil Auld <pauld@redhat.com>
    Reviewed-by: Waiman Long <longman@redhat.com>
    Cc: Ingo Molnar <mingo@redhat.com>
    Cc: Marco Crivellari <marco.crivellari@suse.com>
    Cc: Michal Hocko <mhocko@suse.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Tejun Heo <tj@kernel.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Vlastimil Babka <vbabka@suse.cz>
    Cc: Waiman Long <longman@redhat.com>

