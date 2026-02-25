Return-Path: <stable+bounces-219511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFWcFV+enmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:01:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A05F192C46
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6075330439E7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B016C3195FD;
	Wed, 25 Feb 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eu570Diw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74615311C07;
	Wed, 25 Feb 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002764; cv=none; b=meuGG9DFYT/YWMvDZ3e5A5yg4fh9zStlyEi0DNDhATQAHHsNk9COvEjvCbuW9a9+4C2mSSz0HawvcTHVxoVgv8H1X8a87PAdXac9Tl+aHJiC0+GsTVPuNJ/mp5lbxaOtQs0IiuPY34d63DmaDTGsxASXhjby2YszmFz688wKFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002764; c=relaxed/simple;
	bh=9JVE30yjWeREaJSn/gB6cTpkB4IMwUTRR+KlyZRo9lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0vec0+nXderPMtNAlaBTwtb5eR8iUPyD/Op1XIS9bd6i0ymQv68Q3oB9nLcq62w4FwTHcWYvqHBEV6Ria0gDZPcBYCR8+fLS07h1iAFDXXh6gZxUm5BUVr4JxSQ/jC2OIRPQC9Nelcv7wceaGy6t3NLIR6KDyYcTqt8Gn/jgdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eu570Diw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D69BC116D0;
	Wed, 25 Feb 2026 06:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002764;
	bh=9JVE30yjWeREaJSn/gB6cTpkB4IMwUTRR+KlyZRo9lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Eu570DiwLoy3/YoCCD/bma7GYXwzLasYeJijc8yotrHC7VYgLZzU6MRNJoejf8DHg
	 WZFb0fx3P7RB5Sn9pllUNMNoNP37/Y312mEcYpdIfJW+2d+n1+pNqsRtHP38lEBX6S
	 e8+Cxq55ORkxtaIJlaNAEAoddvC/ONvLy9P7blOU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 594/641] s390/kexec: Make KEXEC_SIG available when CONFIG_MODULES=n
Date: Tue, 24 Feb 2026 17:25:20 -0800
Message-ID: <20260225012402.908783420@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219511-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A05F192C46
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Egorenkov <egorenar@linux.ibm.com>

[ Upstream commit dd3411959b57df6e05a3ccbac67b0a836871c0c4 ]

The commit c8424e776b09 ("MODSIGN: Export module signature definitions")
replaced the dependency of KEXEC_SIG on SYSTEM_DATA_VERIFICATION with the
dependency on MODULE_SIG_FORMAT. This change disables KEXEC_SIG in s390
kernels built with MODULES=n if nothing else selects MODULE_SIG_FORMAT.

Furthermore, the signature verification in s390 kexec does not require
MODULE_SIG_FORMAT because it requires only the struct module_signature and,
therefore, does not depend on code in kernel/module_signature.c.

But making ARCH_SUPPORTS_KEXEC_SIG depend on SYSTEM_DATA_VERIFICATION is
also incorrect because it makes KEXEC_SIG available on s390 only if some
other arbitrary option (for instance a file system or device driver)
selects it directly or indirectly.

To properly make KEXEC_SIG available for s390 kernels built with MODULES=y
as well as MODULES=n _and_ also not depend on arbitrary options selecting
SYSTEM_DATA_VERIFICATION, set ARCH_SUPPORTS_KEXEC_SIG=y for s390 and select
SYSTEM_DATA_VERIFICATION when KEXEC_SIG=y.

Fixes: c8424e776b09 ("MODSIGN: Export module signature definitions")
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index df22b10d91415..e60d2b823e091 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -270,6 +270,7 @@ config S390
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
+	select SYSTEM_DATA_VERIFICATION if KEXEC_SIG
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY
@@ -296,7 +297,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
 	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_SIG
-	def_bool MODULE_SIG_FORMAT
+	def_bool y
 
 config ARCH_SUPPORTS_KEXEC_PURGATORY
 	def_bool y
-- 
2.51.0




