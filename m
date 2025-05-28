Return-Path: <stable+bounces-147954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B1AC696D
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 14:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2742A4E47A4
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986CA2857F0;
	Wed, 28 May 2025 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s1EnRGDG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="s1EnRGDG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36B28688F
	for <stable@vger.kernel.org>; Wed, 28 May 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435781; cv=none; b=NS/+VcH6nOGkv++LwQPMAxIpb88cj59vNkIDfAejWBIGoQlRMqOvOsoSpNp777RqPSV1oZ1iUHXsoGRULzBVEGlfuNN1IqieMP+PgRJ/usZYqe6RibhBswjcJuUhWVp4vz734Zmw5GyFw1jRVqjdFIeIdldk5JfeGhdgJ05UbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435781; c=relaxed/simple;
	bh=DDn3bDzacoLdEbYTtaefGSuDRRRTSSmIS3JDSnPZlR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPuo0uSvGIsuiYOvvPhvOQoYy53cKO1+XmdmGREQEuTBsaopzTJws+KoUB5qcIjhPNM8tIDSGWMovMatFXki16wWoyDVXoOu0ZONI81Sd2XPl6ap9yxcG231W3/CXwJtM3yvSwhIaoHXsi47fmnwY/GywCsswAsjvICY7Ik/yH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s1EnRGDG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=s1EnRGDG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D45411F8B9;
	Wed, 28 May 2025 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748435777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/hGv7jZb/4TX+WGvVm1B9o6zeX04OtGYX/XldpPRP0=;
	b=s1EnRGDGGug3fifeX50rJKby6jd0HYMtDaLrLLcOoQ4BvOcApT9NX1c2yaGdzf89038Izn
	hcgH8XJEmPHXri2HhA8O9wk+RmjLAaIdo5pP4CUmaQmymrc2fNSnaRc8v3QDI54kfQkUvD
	lyLg+5Avc/Ziv1sawOO/u6Dbx4myZPI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748435777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j/hGv7jZb/4TX+WGvVm1B9o6zeX04OtGYX/XldpPRP0=;
	b=s1EnRGDGGug3fifeX50rJKby6jd0HYMtDaLrLLcOoQ4BvOcApT9NX1c2yaGdzf89038Izn
	hcgH8XJEmPHXri2HhA8O9wk+RmjLAaIdo5pP4CUmaQmymrc2fNSnaRc8v3QDI54kfQkUvD
	lyLg+5Avc/Ziv1sawOO/u6Dbx4myZPI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85331136E0;
	Wed, 28 May 2025 12:36:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BDIbH0EDN2ipKQAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 28 May 2025 12:36:17 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: xin@zytor.com,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] x86/alternative: make kernel ITS thunks read-only
Date: Wed, 28 May 2025 14:35:57 +0200
Message-ID: <20250528123557.12847-4-jgross@suse.com>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -6.80

When allocating memory pages for kernel ITS thunks, make them read-only
after having written the last thunk.

This will be needed when X86_FEATURE_PSE isn't available, as the thunk
memory will have PAGE_KERNEL_EXEC protection, which is including the
write permission.

Cc: <stable@vger.kernel.org>
Fixes: 5185e7f9f3bd ("x86/module: enable ROX caches for module text on 64 bit")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/alternative.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ecfe7b497cad..bd974a0ac88a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -217,6 +217,15 @@ static void *its_alloc(void)
 	return no_free_ptr(page);
 }
 
+static void its_set_kernel_ro(void *addr)
+{
+#ifdef CONFIG_MODULES
+	if (its_mod)
+		return;
+#endif
+	execmem_restore_rox(addr, PAGE_SIZE);
+}
+
 static void *its_allocate_thunk(int reg)
 {
 	int size = 3 + (reg / 8);
@@ -234,6 +243,8 @@ static void *its_allocate_thunk(int reg)
 #endif
 
 	if (!its_page || (its_offset + size - 1) >= PAGE_SIZE) {
+		if (its_page)
+			its_set_kernel_ro(its_page);
 		its_page = its_alloc();
 		if (!its_page) {
 			pr_err("ITS page allocation failed\n");
@@ -2338,6 +2349,11 @@ void __init alternative_instructions(void)
 	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
 	apply_returns(__return_sites, __return_sites_end);
 
+	/* Make potential last thunk page read-only. */
+	if (its_page)
+		its_set_kernel_ro(its_page);
+	its_page = NULL;
+
 	/*
 	 * Adjust all CALL instructions to point to func()-10, including
 	 * those in .altinstr_replacement.
-- 
2.43.0


