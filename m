Return-Path: <stable+bounces-263548-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sAvkJsrbMGoZYAUAu9opvQ
	(envelope-from <stable+bounces-263548-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:14:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89B68C0DB
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:14:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=YuTR8Akc;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263548-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263548-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A37304408F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC653CE4B5;
	Tue, 16 Jun 2026 05:13:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8E3CE48E
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:13:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586817; cv=none; b=MpzruLo+LgwbzUKXmPWLFM/qLARFmaeVVbUXBye7+FEk4fY2iQDgS7WVL32Nz+vh7RrjbFGkOGsIGxwdvUsQEUYosGFApFdk6LwdDbcIgxO/ejTA3NQdAbo7owdhX4ZDH6W4oxr3FIpCBhETj46Rl2fdWsYClrd0nyCgfWz/K4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586817; c=relaxed/simple;
	bh=V6uk2nNWbMqLiZpmCXp5GbJz9TkYJ+4Q5ogc0DgQbXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GZRLE6xsQWv2tGYirz98X7SEY0h2lpoobJ1Zcv1/hGGnbvlSpzkqzFSJwYnASKKzSEc5XQNNN2y9vMfbh8P09cTc2NJDAyRu0OBXmEXDQ1+epKxrCztvacghrcV5hO9OQkkTBVGqaR/wbtVpphD2cbfnSKTwlGbmIvCJVNypoZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YuTR8Akc; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906343D4B;
	Mon, 15 Jun 2026 22:13:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6FA763F763;
	Mon, 15 Jun 2026 22:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781586815; bh=V6uk2nNWbMqLiZpmCXp5GbJz9TkYJ+4Q5ogc0DgQbXg=;
	h=From:To:Cc:Subject:Date:From;
	b=YuTR8Akc4IXBg796IzObC5ZyJnD/SK0Fp+2ZOzRI6gP7kXvSNIVv2jnp/xFNYFtni
	 mGPFEnMAat49Zz7L7ghWgvFH4tY8vKXTCTfPlOp8Ox2A1IGAr+0O0PBKQ5lMi7+IMI
	 R+1Ft2PopAJhIOcDJDf9YPHKi/Ts6SFccXxQt/eg=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	lee@kernel.org,
	mark.rutland@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 6.18.y 0/5] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 06:13:24 +0100
Message-Id: <20260616051329.111597-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-263548-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:catalin.marinas@arm.com,m:lee@kernel.org,m:mark.rutland@arm.com,m:sdonthineni@nvidia.com,m:will@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:dkim,arm.com:mid,arm.com:url,arm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE89B68C0DB

This is a v6.18-only backport of a workaround for a TLB invalidation
issue affecting several CPUs. The final patches landed in mainline
yesterday:

  https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16

This issue has been assigned CVE ID CVE-2025-10263, and Arm have
published a security bulletin:

  https://developer.arm.com/documentation/112137/latest/

I've pushed a copy of this backport to my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.18/arm-4118414/backport

Mark.

Mark Rutland (3):
  arm64: cputype: Add C1-Ultra definitions
  arm64: cputype: Add C1-Premium definitions
  arm64: errata: Mitigate TLBI errata on various Arm CPUs

Shanker Donthineni (1):
  arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Will Deacon (1):
  arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU

 Documentation/arch/arm64/silicon-errata.rst | 46 +++++++++++++++++++++
 arch/arm64/Kconfig                          | 38 +++++++++++++++++
 arch/arm64/include/asm/cputype.h            |  4 ++
 arch/arm64/kernel/cpu_errata.c              | 34 ++++++++++++++-
 4 files changed, 120 insertions(+), 2 deletions(-)

-- 
2.30.2


