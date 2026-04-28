Return-Path: <stable+bounces-241644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCH3HIik8GlAWgEAu9opvQ
	(envelope-from <stable+bounces-241644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:14:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CABD484B01
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 14:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBFF030FC03C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454083FCB13;
	Tue, 28 Apr 2026 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="OoHRjBjJ"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141E3A6B88
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378111; cv=none; b=mpa9Cmb/IKFRclPlo3Q+FTgBul5TJh5UzDMHEUJ7+4AHu4NKNtk/nM8RfJwkX6aKztrXHIv8k87tM13q3pKPLLpZhFfQeGI7tM6+xlhZOnw83Qljr1zo4fA24DqO/Srqhr1xkf/iwkButaTh/JxTWmGT/lbHn2semi8cCRESFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378111; c=relaxed/simple;
	bh=Z4Lgq/Nq5TTHp3GM0hAqOXTAtngyPeRpaRMwRaTEgE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JJIXWIJJhcSqZ/xXxNk+5qVZCvFpZ9nuGF11eA4O93ocE6rGxvVUkvuqVLsF6RpSvNP2PUHeRrB43c9x39VPSJoUUO37aA/KNZay4FwHmLcJbfws688torSdqYsl9FmwFujrn6JTqIhUDSKv0XxCtruuugYxkOR/ivVWO6UIWKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=OoHRjBjJ; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c00c:0:640:e0de:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 9D1EA8062F;
	Tue, 28 Apr 2026 15:06:14 +0300 (MSK)
Received: from d-tatianin-lin.yandex-team.ru (unknown [2a02:6bf:8080:116::1:0])
	by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA id B6YlCK1L0W20-GEhcRD8Q;
	Tue, 28 Apr 2026 15:06:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1777377974;
	bh=Bp3ZhGsNUEQt6yI6Mc7N501J0dDZ39+Ssqmzljxy8gI=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=OoHRjBjJln72FedDHnp3UkAtVWE29ZyVzT4y+9Nerl0Oz2CYQva4p0QSlp107Dz1m
	 JsGwMLY/X1nyolaca8mz8vvklFeQ1r+cKXaIPxDB51yOQkbCJJ7FcZBEOmYwqqGBJq
	 2cxtAm2WYjZP6oHr9C0julH8t0y5IB7H21Jrxw6g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
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
Subject: [PATCH 6.6.y 0/5] SRSO handling for Zen5 CPUs
Date: Tue, 28 Apr 2026 15:05:40 +0300
Message-Id: <20260428120545.1970058-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9CABD484B01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241644-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,yandex-team.ru:dkim,yandex-team.ru:mid]

This series backports a few SRSO handling features for Zen5 CPUs from the
mainline kernel. The only important ones are
"x86/bugs: KVM: Add support for SRSO_MSR_FIX" and
"x86/bugs: Add SRSO_USER_KERNEL_NO support". The rest are added to avoid
conflicts when applying the aforementioned patches.

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

 Documentation/admin-guide/hw-vuln/srso.rst | 13 ++++++
 arch/x86/include/asm/cpufeatures.h         |  5 +++
 arch/x86/include/asm/msr-index.h           |  1 +
 arch/x86/kernel/cpu/bugs.c                 | 46 +++++++++++++++-------
 arch/x86/kernel/cpu/common.c               |  1 +
 arch/x86/kvm/svm/svm.c                     |  6 +++
 arch/x86/lib/msr.c                         |  2 +
 7 files changed, 59 insertions(+), 15 deletions(-)

-- 
2.34.1


