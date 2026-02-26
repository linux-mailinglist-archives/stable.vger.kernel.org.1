Return-Path: <stable+bounces-219763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIEMIlPrn2nYewQAu9opvQ
	(envelope-from <stable+bounces-219763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:42:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E099B1A1630
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD373306B4C4
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302AE38BF79;
	Thu, 26 Feb 2026 06:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NujxsXvm"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAE36BCC9
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088122; cv=none; b=dqORo/EgKy4okit02zMEhqkI44BCuZQvObwMZMLAwVwPq0/5vDlI5knkCtzpKaLYahswITs0AWZhOn9k2xlNT9y6GbT8TcvUtYYJnhf6/UBg27SRbu+fvScfQjcBQFD4oABXHINr9dvOk7HNSgNaMB1o1UKxsV/ffegBwFMFkI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088122; c=relaxed/simple;
	bh=7qr7VnYXHVytZrK0HNiE02w0xjhN3ZPCZEMFvscc8GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JxW4Zo8v31GqZqdVrMbzSB5cxugZff3Gb4BXWP35tzQZOQKRiLRTClfCyGcPu3TlrwUWksnuKUvle5ILamJyRWmxNBDazRx65VqW8XTua39pgY5s76vYKrQO6LRcpxQ7bL5F41TD/iOxmkVjyf5CmoPOY/TXqz0EOrtEbUlFp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NujxsXvm; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=AC
	wIhIgRIisYxKiIGBBdMNAPKLXx2JqpLaXROLQ2eMA=; b=NujxsXvmj36IqM59Vi
	gj1ivCebfyMEYggJQn+sz/Qw2nE6Nq8wKLIJUZJvJotWQ/GEfKE/RMkRmS+R5hTs
	71yHZd0C0xE3rMll0WOdgu1wqO5zGAGkwCGvTb5imgxbjDo+uqGnYyI5FmbASM8u
	A41qROqCrYhdOm32BD4ORoMFA=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnyO4V659pYC5lQg--.54S3;
	Thu, 26 Feb 2026 14:41:30 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.6.y 2/2] x86/sev: Check for MWAITX and MONITORX opcodes in the #VC handler
Date: Thu, 26 Feb 2026 14:41:12 +0800
Message-Id: <20260226064112.2737715-2-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226064112.2737715-1-jetlan9@163.com>
References: <20260226064112.2737715-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnyO4V659pYC5lQg--.54S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFW5tr48AF45XF4fJFW5ZFb_yoW8Xw1Dpr
	WfCw40qr4kWa95ua9rurn7Zr1UCF4vgrWxXa4DKwn3t39Fqw1ktwnayw1aqry3uFyvg3y3
	J3ZIvF1xtFy8uw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisqXPUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbCwxpDDGmf6xpnogAA3U
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219763-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,alien8.de,163.com];
	DKIM_TRACE(0.00)[163.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jetlan9@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: E099B1A1630
X-Rspamd-Action: no action

From: Tom Lendacky <thomas.lendacky@amd.com>

[ Upstream commit e70316d17f6ab49a6038ffd115397fd68f8c7be8 ]

The MWAITX and MONITORX instructions generate the same #VC error code as
the MWAIT and MONITOR instructions, respectively. Update the #VC handler
opcode checking to also support the MWAITX and MONITORX opcodes.

Fixes: e3ef461af35a ("x86/sev: Harden #VC instruction emulation somewhat")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/453d5a7cfb4b9fe818b6fb67f93ae25468bc9e23.1713793161.git.thomas.lendacky@amd.com
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 arch/x86/kernel/sev-shared.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 1dbf114b3365..caa3de2dcd0a 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1237,12 +1237,14 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 		break;
 
 	case SVM_EXIT_MONITOR:
-		if (opcode == 0x010f && modrm == 0xc8)
+		/* MONITOR and MONITORX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc8 || modrm == 0xfa))
 			return ES_OK;
 		break;
 
 	case SVM_EXIT_MWAIT:
-		if (opcode == 0x010f && modrm == 0xc9)
+		/* MWAIT and MWAITX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc9 || modrm == 0xfb))
 			return ES_OK;
 		break;
 
-- 
2.43.0


