Return-Path: <stable+bounces-147951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20835AC6964
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 14:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6583B2655
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673A1285404;
	Wed, 28 May 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sW76eO0c";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sW76eO0c"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B92836BE
	for <stable@vger.kernel.org>; Wed, 28 May 2025 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748435764; cv=none; b=G9QmLkm7zJM4Is/hCKwtEPJtOiI23Ic+Wqep2bogVVTS/hAhNz3nFyCqoPLmv5ez4TdCTYw9auUd4O4dIBA5anABhXI8nM2sU08zUvZf+1n3vY+NQ17Sv2EL/2mrt88imTQlt/0gXV1MYxbVUznJ1KSVpMLNIbNgmFlEOB/BzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748435764; c=relaxed/simple;
	bh=opFMAY7ql65PTVuG1xITeeuQ5Ru9iADMO899kbu8eR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTWUMnpW8NDIJiWJNSlbALv7dLR1/gcAXZLzn+PTRuzA3eWklRYeOD8z2+YR+/amW/SfGcWSOWBEgqZtUAGbny9ZKLIgkbPmnql4UF+2uGvGrrqPy8/CWR1/lyLUtsnYsdudJrmC1v8pMGaH6Zrw0aiaE7MtfUV1Kk6q1nQiLw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sW76eO0c; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sW76eO0c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 483B21F897;
	Wed, 28 May 2025 12:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748435760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oUHpflNkqxQqAeRF/c6Lk5cVWk0vuP3r2ZYdL4XjqBc=;
	b=sW76eO0cjSJnW4NETyMF/qAOcV8R/jWofXly4AHnsZJccejpPQ3xA3XDrBTvmODFCvw/iE
	MEKzfCjZQHWQ8r/3cP7cE+rEeW0pl36Kte3HXJ34S08MSDbs99qbJGvS/kfw+1sCyfobFh
	QXZwGb4ijWxSDK9EkFyKyD9pkv8mkck=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748435760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oUHpflNkqxQqAeRF/c6Lk5cVWk0vuP3r2ZYdL4XjqBc=;
	b=sW76eO0cjSJnW4NETyMF/qAOcV8R/jWofXly4AHnsZJccejpPQ3xA3XDrBTvmODFCvw/iE
	MEKzfCjZQHWQ8r/3cP7cE+rEeW0pl36Kte3HXJ34S08MSDbs99qbJGvS/kfw+1sCyfobFh
	QXZwGb4ijWxSDK9EkFyKyD9pkv8mkck=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5306136E0;
	Wed, 28 May 2025 12:35:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WCIeLi8DN2iWKQAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 28 May 2025 12:35:59 +0000
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
Subject: [PATCH 0/3] x86: Fix some bugs related to ITS mitigation
Date: Wed, 28 May 2025 14:35:54 +0200
Message-ID: <20250528123557.12847-1-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Running as a Xen PV guest uncovered some bugs when ITS mitigation is
active.

Juergen Gross (3):
  x86/execmem: don't use PAGE_KERNEL protection for code pages
  x86/mm/pat: don't collapse pages without PSE set
  x86/alternative: make kernel ITS thunks read-only

 arch/x86/kernel/alternative.c | 16 ++++++++++++++++
 arch/x86/mm/init.c            |  2 +-
 arch/x86/mm/pat/set_memory.c  |  3 +++
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.43.0


