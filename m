Return-Path: <stable+bounces-23676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C74A8674AF
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A852884BF
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40788604D7;
	Mon, 26 Feb 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TARadbnb"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD1A604AC
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950164; cv=none; b=uTqCR8vUcmhjOt/Qu3JX5IQ8DaVJ9TlwPpwX8AB2vqL3dhSPf5dhhkKSD7F9m9N2dEKq1yy4ypcHUJmOo0dqQ2HxlZvGa52P9GcaB/M2pUToKnr2JijvKcDA/rUFMKbaJ+G2ZPqcsqehhEJ68S9R9PCYImVGRJoGS9NthMmX/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950164; c=relaxed/simple;
	bh=ACqo46t8URJ5p95jVGHiydkoHaUI7I+FQkF5xBVq9lA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdwUpjFRWMTi2aVQCu5f5FaRUT7K3Ct0iuIathzB5/oPbMZfJu3P1r2JlnM8eZ20PqgBL9Yllq6bXy3I1dKRl3ftfJ7kBR8uDz3aOBy7GQlNQsPvjna8FHogoyjKMrq5B1dwbTMeHpxMCCYHMK4L1Fz0HCQ623rx6am2yhnreQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TARadbnb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A607B1FB47;
	Mon, 26 Feb 2024 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708950159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89eULqn577RpTwP3kwMbLstkZKnDEjXexu/ktnY77Oo=;
	b=TARadbnbbCcOOjsL/IAsr8GyZ1DWgCgIAoluF65+7rr8zyB+cqImVYoFfTHgi4ZAHcOjy4
	WSYIKJTcMSl5E/ZORAq6goYEh/xb+lxJM57b4nGyOrz3E3uPRled6EshyuDl1ykfNCvSaT
	W+YLm5PEt/z8oGza8MA0eOhbLNEg4pY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62B7B13AA1;
	Mon, 26 Feb 2024 12:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GJ7eFY+C3GU9TQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 26 Feb 2024 12:22:39 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: stable@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
	Borislav Petkov <bp@suse.de>,
	Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 1/7] x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix
Date: Mon, 26 Feb 2024 14:22:31 +0200
Message-Id: <20240226122237.198921-2-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226122237.198921-1-nik.borisov@suse.com>
References: <20240226122237.198921-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A607B1FB47
X-Spam-Flag: NO

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

[ Upstream commit 0576d1ed1e153bf34b54097e0561ede382ba88b0 ]

Add a macro _ASM_RIP() to add a (%rip) suffix on 64 bits only. This is
useful for immediate memory references where one doesn't want gcc
to possibly use a register indirection as it may in the case of an "m"
constraint.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210910195910.2542662-3-hpa@zytor.com
Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/include/asm/asm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index cd339b88d5d4..9116ef22bc53 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -6,12 +6,13 @@
 # define __ASM_FORM(x)	x
 # define __ASM_FORM_RAW(x)     x
 # define __ASM_FORM_COMMA(x) x,
+# define __ASM_REGPFX			%
 #else
 #include <linux/stringify.h>
-
 # define __ASM_FORM(x)	" " __stringify(x) " "
 # define __ASM_FORM_RAW(x)     __stringify(x)
 # define __ASM_FORM_COMMA(x) " " __stringify(x) ","
+# define __ASM_REGPFX			%%
 #endif
 
 #ifndef __x86_64__
@@ -48,6 +49,9 @@
 #define _ASM_SI		__ASM_REG(si)
 #define _ASM_DI		__ASM_REG(di)
 
+/* Adds a (%rip) suffix on 64 bits only; for immediate memory references */
+#define _ASM_RIP(x)	__ASM_SEL_RAW(x, x (__ASM_REGPFX rip))
+
 #ifndef __x86_64__
 /* 32 bit */
 
-- 
2.34.1


