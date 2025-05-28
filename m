Return-Path: <stable+bounces-147952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D01BAC6968
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 14:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BECD3BA46D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 12:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D201F2857EA;
	Wed, 28 May 2025 12:36:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0659F28641F
	for <stable@vger.kernel.org>; Wed, 28 May 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435769; cv=none; b=Ai1YCvhovFbvRrnVQizyrSOa7taD0Hi2OSM2dObx6GPH5IEMMn46ibg8BHNbY6vzbxgxO18WTsYM10cPIIXNBgbLOzJdbwbvssP9qVpIqxM0xhcWVlEav7sMcg+Jx7bO7geFdXHlI0B36mxWBvcZu+7N3CYz8rjpLpV5rbpoFzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435769; c=relaxed/simple;
	bh=Ao6Yj7X14J3VPAgLaAb1nmrQ9mdqFFBKa+cv/pz23LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLaDa/RMd1z5UnCC8+vn48qHbSOH146U+aeVpjJMcnA1NDpV5Fzz+UloVdCsyToVhtnMtkZ/NLir8KKHFI52EULmEDRlD/4uVscQdSGmh20jSZW1g99ZviJsU/YcgyT/1v6DoARzeXydRCnEoS4dHr6MoYMMjV+NjavHPsChfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 35AD321BEA;
	Wed, 28 May 2025 12:36:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFC36136E0;
	Wed, 28 May 2025 12:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q2/nLDUDN2idKQAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 28 May 2025 12:36:05 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: xin@zytor.com,
	Juergen Gross <jgross@suse.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] x86/execmem: don't use PAGE_KERNEL protection for code pages
Date: Wed, 28 May 2025 14:35:55 +0200
Message-ID: <20250528123557.12847-2-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123557.12847-1-jgross@suse.com>
References: <20250528123557.12847-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 35AD321BEA
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.00

In case X86_FEATURE_PSE isn't available (e.g. when running as a Xen
PV guest), execmem_arch_setup() will fall back to use PAGE_KERNEL
protection for the EXECMEM_MODULE_TEXT range.

This will result in attempts to execute code with the NX bit set in
case of ITS mitigation being applied.

Avoid this problem by using PAGE_KERNEL_EXEC protection instead,
which will not set the NX bit.

Cc: <stable@vger.kernel.org>
Reported-by: Xin Li <xin@zytor.com>
Fixes: 5185e7f9f3bd ("x86/module: enable ROX caches for module text on 64 bit")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 7456df985d96..f5012ae31d8b 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1089,7 +1089,7 @@ struct execmem_info __init *execmem_arch_setup(void)
 		pgprot = PAGE_KERNEL_ROX;
 		flags = EXECMEM_KASAN_SHADOW | EXECMEM_ROX_CACHE;
 	} else {
-		pgprot = PAGE_KERNEL;
+		pgprot = PAGE_KERNEL_EXEC;
 		flags = EXECMEM_KASAN_SHADOW;
 	}
 
-- 
2.43.0


