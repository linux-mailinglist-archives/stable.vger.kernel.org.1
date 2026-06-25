Return-Path: <stable+bounces-268314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5hdMFjPyPGo3uwgAu9opvQ
	(envelope-from <stable+bounces-268314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:17:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD36C4232
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 11:17:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268314-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268314-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 726E730075C7
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 09:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219F374E46;
	Thu, 25 Jun 2026 09:12:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCE86341;
	Thu, 25 Jun 2026 09:12:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378765; cv=none; b=T2saQEbOdh6RwpczFyq7gD5rWCdMauVOt2QE3Ja3hqR0RXqUTs8PzwuCiCLbnSggSNuyUuHwgygf+KhSrOIBSIqS3wouDfvsSHu0m9A7oTzw17j87hopsIKOm7NAkkKgSHKp83oNg5VEgsEWo5B6H6LUUrzAT2dTz6XStEwJ86o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378765; c=relaxed/simple;
	bh=phD44Soa9TdRo10MhwYe6q+yPEAM2IZei9j+HAfyAS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baIu/RLhRoQg0R1wF8rbIT3EzWHlSZmW4UDus+h4XFgGma/3FpKRW3DGACy05Ybaq+4ZkIo7NowMPcor+uPSbzGmeo88yd+m6s7mOoLGqIoSMmoMx5pZ34hsmXN2uGfC76W395AWowbYprG/hGh/QZz5cdxjEkI/XtZ3GnA8NwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4A4BA298580;
	Thu, 25 Jun 2026 11:06:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 8JKdjviwgb2F; Thu, 25 Jun 2026 11:06:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 87EE4298599;
	Thu, 25 Jun 2026 11:06:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m6VPW3jCY1jW; Thu, 25 Jun 2026 11:06:39 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 106E3298580;
	Thu, 25 Jun 2026 11:06:39 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: upstream+x86@sigma-star.at,
	rppt@kernel.org,
	peterz@infradead.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@kernel.org,
	Richard Weinberger <richard@nod.at>,
	stable@vger.kernel.org
Subject: [PATCH] x86/Kconfig: enable ROX also when STRICT_KERNEL_RWX is present
Date: Thu, 25 Jun 2026 11:06:27 +0200
Message-ID: <20260625090627.1501095-1-richard@nod.at>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268314-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:upstream+x86@sigma-star.at,m:rppt@kernel.org,m:peterz@infradead.org,m:hpa@zytor.com,m:x86@kernel.org,m:dave.hansen@linux.intel.com,m:bp@alien8.de,m:mingo@redhat.com,m:tglx@kernel.org,m:richard@nod.at,m:stable@vger.kernel.org,m:upstream@sigma-star.at,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[richard@nod.at,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[nod.at];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard@nod.at,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:email];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,x86];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9ABD36C4232

Running a kernel with CONFIG_MODULES=3Dn causes the W+X page dectection
to trigger:
x86/mm: Found insecure W+X mapping at address 0xffffffffc033a000

The W+X pages come from __its_alloc() with type being EXECMEM_MODULE_TEXT=
.
Without ARCH_HAS_EXECMEM_ROX pgprot is PAGE_KERNEL instead of
PAGE_KERNEL_ROX.

Cc: stable@vger.kernel.org
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Fixes: 47410d839fcda ("x86/Kconfig: only enable ROX cache in execmem when=
 STRICT_MODULE_RWX is set")
Suggested-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0b5f30d769ffb..330ccbf6726ad 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,7 +85,7 @@ config X86
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
 	select ARCH_HAS_ELF_RANDOMIZE
-	select ARCH_HAS_EXECMEM_ROX		if X86_64 && STRICT_MODULE_RWX
+	select ARCH_HAS_EXECMEM_ROX		if X86_64 && (STRICT_MODULE_RWX || STRICT_=
KERNEL_RWX)
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
--=20
2.51.0


