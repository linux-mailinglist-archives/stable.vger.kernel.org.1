Return-Path: <stable+bounces-23622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EDE8670D6
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6B428A8A0
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CAF5B206;
	Mon, 26 Feb 2024 10:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hB1W1n8/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hB1W1n8/"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2EA2C869
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708942371; cv=none; b=VbPV7Nk0tQzRYKYOPbCBvaFYeSznsslWGJqOuLN4kFIAaoeIeoE/goyhnLVHrMYrffmR1mliqI3oig6+pFaOP22sZ/En40Mxxevvh5MrPfsNgMik0YxHR5ghluxJwvctIywmNbqM0x/6uao6s4cPVbKDzXKm9s/1VW8mramVWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708942371; c=relaxed/simple;
	bh=2D0zDXUzZf5RJ00qCbOnkXaqsm+9nDokxGDk67ZZXPU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JAoxC9RRUDyg1n4vYk7xfOs3cbxXibQz9Q5y2yQ36jJLSDyB3MZDcj2Dk3c/fUGFJPVQpCS6J5aouAiLH2aLKluqj5THKACKZhHipe5fpoh8exKQ3JYZnVBxdKcz5Pamq9s8Z2o3ARS4shmbOoNTst2Oz1xNEP1wI1YWrSCffCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hB1W1n8/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hB1W1n8/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 74ACF1F8C4;
	Mon, 26 Feb 2024 10:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708942366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x0Vi7bh5qL66+ILP80Qd1s+dL/ftVQMxsE3skM8QFos=;
	b=hB1W1n8/RMXdVZneTha1fC3Mv87Xhuj7eEI6jIbg4lI9ha+I/U3D3wC9Es+dQgzxcLhLsf
	s95vv3oczQjAaTLwCHyrzwNh9UFRPnrYVtjPtZAkno58qa7cmVx8NdtJTvGX3rDK4378j6
	CHu0r9HpT5D563X6C1AYd5mV4qEpyG4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708942366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x0Vi7bh5qL66+ILP80Qd1s+dL/ftVQMxsE3skM8QFos=;
	b=hB1W1n8/RMXdVZneTha1fC3Mv87Xhuj7eEI6jIbg4lI9ha+I/U3D3wC9Es+dQgzxcLhLsf
	s95vv3oczQjAaTLwCHyrzwNh9UFRPnrYVtjPtZAkno58qa7cmVx8NdtJTvGX3rDK4378j6
	CHu0r9HpT5D563X6C1AYd5mV4qEpyG4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4924B13A3A;
	Mon, 26 Feb 2024 10:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1xZlDx5k3GX/LAAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 26 Feb 2024 10:12:46 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: stable@vger.kernel.org
Cc: Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH 0/7] 5.4 backport of recent mds improvement patches
Date: Mon, 26 Feb 2024 12:12:32 +0200
Message-Id: <20240226101239.17633-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.13
X-Spamd-Result: default: False [3.13 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[eflags.cf:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.57)[81.33%]
X-Spam-Flag: NO

Here's the recently merged mds improvement patches adapted to latest stable tree.
I've only compile tested them, but since I have also done similar backports for
older kernels I'm sure they should work.
The main difference is in the definition of the CLEAR_CPU_BUFFERS macro since
5.4 doesn't contains the alternative relocation handling logic hence the verw
instruction is moved out of the alternative definition and instead we have a jump which
skips the verw instruction there. That way the relocation will be handled by the
toolchain rather than the kernel.

H. Peter Anvin (Intel) (1):
  x86/asm: Add _ASM_RIP() macro for x86-64 (%rip) suffix

Pawan Gupta (5):
  x86/bugs: Add asm helpers for executing VERW
  x86/entry_64: Add VERW just before userspace transition
  x86/entry_32: Add VERW just before userspace transition
  x86/bugs: Use ALTERNATIVE() instead of mds_user_clear static key
  KVM/VMX: Move VERW closer to VMentry for MDS mitigation

Sean Christopherson (1):
  KVM/VMX: Use BT+JNC, i.e. EFLAGS.CF to select VMRESUME vs. VMLAUNCH

 Documentation/x86/mds.rst            | 38 ++++++++++++++++++++--------
 arch/x86/entry/Makefile              |  2 +-
 arch/x86/entry/common.c              |  2 --
 arch/x86/entry/entry.S               | 23 +++++++++++++++++
 arch/x86/entry/entry_32.S            |  3 +++
 arch/x86/entry/entry_64.S            | 10 ++++++++
 arch/x86/entry/entry_64_compat.S     |  1 +
 arch/x86/include/asm/asm.h           |  6 ++++-
 arch/x86/include/asm/cpufeatures.h   |  2 +-
 arch/x86/include/asm/irqflags.h      |  1 +
 arch/x86/include/asm/nospec-branch.h | 26 ++++++++++---------
 arch/x86/kernel/cpu/bugs.c           | 15 +++++------
 arch/x86/kernel/nmi.c                |  3 ---
 arch/x86/kvm/vmx/run_flags.h         |  7 +++--
 arch/x86/kvm/vmx/vmenter.S           |  9 ++++---
 arch/x86/kvm/vmx/vmx.c               | 12 ++++++---
 16 files changed, 111 insertions(+), 49 deletions(-)
 create mode 100644 arch/x86/entry/entry.S

--
2.34.1


