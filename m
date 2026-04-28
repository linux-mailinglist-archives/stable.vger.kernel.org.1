Return-Path: <stable+bounces-241778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NaEQE8Mq8WkJeQEAu9opvQ
	(envelope-from <stable+bounces-241778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 23:46:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9280748C62E
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 23:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4178D30182BD
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F96235949;
	Tue, 28 Apr 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="p2ANZPky"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBB64A07
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777412800; cv=none; b=o1yPTxfF5xPcq2JhcIaALc8m3IO6K7f4cjQkea+SEDkyd1tIkw1LiGrNScgbzczCONQiSZUC+CU27VMg63Tcw/3ZLhuvlzihDQsu+m4ypzgQSK69t3OyLl5VbrAcW8FsOjvHFQDTZM02SMUaVf5NK4FrxAAJWCO2KntxWwHzg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777412800; c=relaxed/simple;
	bh=VZon8wmIm1NGMGyoaz+LwgzflXzNPF4zKAQ56WJ/SM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dLII4grerRu0STMKAly+jTCeaHhqWJEs7i2jUW2u7qITUCvoiD8ujPJlyfT50HlZm7mOI2jXahlqHwCpPGjTJU0+37yCy8ll8HP1s9G+gqMvqIPGy75wkumrkgkwap0wxI0eP2tjBKkhlyt0lHdMvWGm4Pguo2TJmJPgDiMDV/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=p2ANZPky; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4D1E7C0263;
	Wed, 29 Apr 2026 00:46:33 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:761::1:11])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA id TkhkmZ1L4iE0-9bfXlUa9;
	Wed, 29 Apr 2026 00:46:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1777412792;
	bh=RdNGQ+KDGY+L9RxM0oPBgMEfn+ylqAkexzJx3Vm/WPo=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=p2ANZPkyxtr2yjjh+myQmOE0RRRKsCuk1nBly2QW7nMGy3ti3RZMt0xrFPre1njP/
	 X+7g/8p5sL4y73JrQQ4HqiuNlwZxCqXcEu7JFVYZYS96BCCXlTJTR8XyVS91tw/hAR
	 LygBZntkpKuMlAejp94AGH9btUcPUARj8TWTJzaU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: stable@vger.kernel.org
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH 6.6.y v1 0/6] SRSO handling for Zen5 CPUs
Date: Wed, 29 Apr 2026 00:46:04 +0300
Message-Id: <20260428214610.2138600-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9280748C62E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241778-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series backports a few SRSO handling features for Zen5 CPUs from the
mainline kernel. The only important ones are
"x86/bugs: KVM: Add support for SRSO_MSR_FIX" and
"x86/bugs: Add SRSO_USER_KERNEL_NO support". The rest are added to avoid
conflicts when applying the aforementioned patches.

Changes since v0:
- Add e3417ab75ab2 ("KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count transitions")
  to fix a performance regression introduced by 8442df2b49ed ("x86/bugs: KVM: Add support for SRSO_MSR_FIX")
  (Suggested by Sean Christopherson)

Borislav Petkov (1):
  x86/bugs: KVM: Add support for SRSO_MSR_FIX

Borislav Petkov (AMD) (1):
  x86/bugs: Add SRSO_USER_KERNEL_NO support

David Kaplan (1):
  x86/bugs: Fix handling when SRSO mitigation is disabled

Josh Poimboeuf (2):
  x86/srso: Print actual mitigation if requested mitigation isn't
    possible
  x86/srso: Remove 'pred_cmd' label

Sean Christopherson (1):
  KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count
    transitions

 Documentation/admin-guide/hw-vuln/srso.rst | 13 +++++
 arch/x86/include/asm/cpufeatures.h         |  5 ++
 arch/x86/include/asm/msr-index.h           |  1 +
 arch/x86/kernel/cpu/bugs.c                 | 46 ++++++++++-----
 arch/x86/kernel/cpu/common.c               |  1 +
 arch/x86/kvm/svm/svm.c                     | 65 ++++++++++++++++++++++
 arch/x86/kvm/svm/svm.h                     |  2 +
 arch/x86/lib/msr.c                         |  2 +
 8 files changed, 120 insertions(+), 15 deletions(-)

-- 
2.34.1


