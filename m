Return-Path: <stable+bounces-147953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A28AC696B
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 14:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3884E474C
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58B2857C9;
	Wed, 28 May 2025 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d31Gx/GP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R/7pgUp+"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B1283FD3
	for <stable@vger.kernel.org>; Wed, 28 May 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435777; cv=none; b=YOHo6Rnm5/MI3fwAyznxkfJdfRWKiVSCT8+xgvsLRDU5i1P38r1NIUPudos1XxK7AzASEnBFCzwzio3PRNqFEulvDWKDWzXJ4EbjJeuZmhTT02MQ8z3LoMKMwbS5xN5eP62vIbZQygOjaavgQuHVerJ2mLM5J9KoMI/CpljIIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435777; c=relaxed/simple;
	bh=ssJ0Vjc2+wN1MmE+iyXyH6fQJtr9m258QsChEelUTm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJqmMxwG7uTPWPdCQN+9TIn1V2g+2We/DMTxqVQnv0n4j9gxUIzM6SptuM693ASMOWafBKiRVzOEBzWEU2L/R70bgSEFe93lsKb/lp3YG2shgv90lwIQbT1v6zsfZIVk+NLUnV3cYjJAx9cD6j9CoEwOLzCPTW5eoqfUAzy5Pu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d31Gx/GP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R/7pgUp+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27C0F21AE4;
	Wed, 28 May 2025 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748435773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlzcsl/OislF/CTk7Ff7aWZAEbJyJ7hReAUFJ1BEXf0=;
	b=d31Gx/GPN2G366m/LTUDl7etfCfaCQfrAfLT6i5US++QI9lrfLD1RnXEoEuQ2GTvzZca+R
	naRXUT6f6A7+j+hX/ro6XD0f33RVBOuttpK8CPRex+XXrQFHe1LfXCfK+RSi2oP2ZyYdup
	JmVxbZhE/9+aH3F8RV8iFtjr2UM5o1E=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748435772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zlzcsl/OislF/CTk7Ff7aWZAEbJyJ7hReAUFJ1BEXf0=;
	b=R/7pgUp+6V9xuegpTJwo28lkzGp9cn3fX//TJnLRUDj+Qf6zj0AOEuScKHCNXZqNbK2iX3
	gqJVWCYuxNf0PrN/quDPzqP79n2nIzaFOy6cGMkzRXikSNjr9JAg/yflfKsU0h4BPjZmEZ
	el+BZnljuWlllEQm6HtcPJwpID1KxDo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB43E136E0;
	Wed, 28 May 2025 12:36:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V60YKDsDN2ijKQAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 28 May 2025 12:36:11 +0000
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
Subject: [PATCH 2/3] x86/mm/pat: don't collapse pages without PSE set
Date: Wed, 28 May 2025 14:35:56 +0200
Message-ID: <20250528123557.12847-3-jgross@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Collapsing pages to a leaf PMD or PUD should be done only if
X86_FEATURE_PSE is available, which is not the case when running e.g.
as a Xen PV guest.

Cc: <stable@vger.kernel.org>
Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/pat/set_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 30ab4aced761..e6a6ac8cdc1d 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1257,6 +1257,9 @@ static int collapse_pmd_page(pmd_t *pmd, unsigned long addr,
 	pgprot_t pgprot;
 	int i = 0;
 
+	if (!cpu_feature_enabled(X86_FEATURE_PSE))
+		return 0;
+
 	addr &= PMD_MASK;
 	pte = pte_offset_kernel(pmd, addr);
 	first = *pte;
-- 
2.43.0


