Return-Path: <stable+bounces-23623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EFA8670D5
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508F01F2C1B6
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F815B202;
	Mon, 26 Feb 2024 10:12:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE55A7BA
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942371; cv=none; b=cqO1AhhrlES9NTe8NgfuKwz33MsaCYi7r4Ie7lK3v63BWLw2UOG50Q+l/8qu5iH3az/CPUGoAJ/ZRO7BxudqvU4TrLmv3iXVSD4cmlOReTdA2qYn5uTnspuWWaATVR/oy7YfaYtBRIbgHQmG1AjiFHJCic/W0QkVx+Vp+LYEyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942371; c=relaxed/simple;
	bh=iofTlUnWqyyuorDADic03hY2XABvBDGcXQ377daJWGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhT0Yuq9nci62Ermev02w8Yj0go+6jAvj3Uo6usCYbZSg5afmBd5W/KYW/XLqzQqCDE5x1ZSODxtm4govyJB5/2jben74cNmkbvh8oJFmn6QJYO+njponqkrS3Tgo3Xsjjihn5bFdnrwV2GwGMi3bJfy81HLlS6V4lAdXmB/p7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E77881FB44;
	Mon, 26 Feb 2024 10:12:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A6B7D13A80;
	Mon, 26 Feb 2024 10:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YPNTJh9k3GX/LAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 26 Feb 2024 10:12:47 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 4/7] x86/entry_32: Add VERW just before userspace transition
Date: Mon, 26 Feb 2024 12:12:36 +0200
Message-Id: <20240226101239.17633-5-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226101239.17633-1-nik.borisov@suse.com>
References: <20240226101239.17633-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E77881FB44
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

As done for entry_64, add support for executing VERW late in exit to
user path for 32-bit mode.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20240213-delay-verw-v8-3-a6216d83edb7%40linux.intel.com
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/entry/entry_32.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 740df9cc2196..45419307fa1a 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1013,6 +1013,7 @@ ENTRY(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
+	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -1094,6 +1095,7 @@ ENTRY(entry_INT80_32)
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
+	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization
@@ -1567,6 +1569,7 @@ ENTRY(nmi)
 
 	/* Not on SYSENTER stack. */
 	call	do_nmi
+	CLEAR_CPU_BUFFERS
 	jmp	.Lnmi_return
 
 .Lnmi_from_sysenter_stack:
-- 
2.34.1


