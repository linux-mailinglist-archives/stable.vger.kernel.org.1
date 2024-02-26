Return-Path: <stable+bounces-23675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A428674B1
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 13:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029E61C24A96
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 12:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D9604D8;
	Mon, 26 Feb 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iWGp6+vQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hty0SaRV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED131D53D
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 12:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950164; cv=none; b=PkUmGiE4Gl7yVk0I6fZLcV+urVyuzLoR3LxtahV1/sJMXGxdwFV4BRrYexKBiiNkWM7q05Xnvbom8XrTSMDV9E9r/6rl1tNSg8ka/X7l84NA8Hk5cCLAOOOr5jHK4ZDbkIfPNjqFrQkf9exzENi28O+VtNKsOw7eX15MknM10gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950164; c=relaxed/simple;
	bh=ZS0Hd7ojFe1KfY00Mj5WG2h4aHFpJJ4w5DC6JpbnTX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p83ZW+FWEk73wod2CcFkVGdOB7esLVbvA8vN0Mr/27GOXQaLj2i4D1/UI32dVR6kUSX51gyOPNKLVEaGcfSjTUUiDu73zxyIFkHoOgAnX7jynSEIV/3AhHz/UzY0J2+eKLmMyt1edstFPSDzsuZ/oLjjPV0p24TgTadwCKBorQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iWGp6+vQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hty0SaRV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5756F22581;
	Mon, 26 Feb 2024 12:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708950160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nxUJFdx1zLbgBuUdifOB7Y7/j6HwRXXGaDZDTNB5dYE=;
	b=iWGp6+vQlgQmrs1d5rpBtRB5BPGI98omvOo8Yx9IV1I/o3LsCta60d0IJZYJ7WtMBqJxgf
	upIqFRTK78kO7eer/D+bu/PLKehamPw7D5GwzJ/CAaQZuCAN98hbQ/TV66CjUem0UDXk/5
	4jEaeoNl5fKx8bmbkR8g7q8V6xAgbnA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708950159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nxUJFdx1zLbgBuUdifOB7Y7/j6HwRXXGaDZDTNB5dYE=;
	b=hty0SaRV0Oi4Drn1sTEVXoNIN4octXuf+pj7dLEjFjmCa7bStJgghmIOsKVIRjq3vYFMPC
	MS7R5JCRdPGKio6Z82gime5MaS36IW7MvlZXxByIZyLHRkreGx8xgEwYWEsgXnpj+rIG91
	4pnLat7zQn2VZnhzOYq0Ovpxt+jJKRk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27FE613A3A;
	Mon, 26 Feb 2024 12:22:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sQ4TB4+C3GU9TQAAD6G6ig
	(envelope-from <nik.borisov@suse.com>); Mon, 26 Feb 2024 12:22:39 +0000
From: Nikolay Borisov <nik.borisov@suse.com>
To: stable@vger.kernel.org
Cc: Nikolay Borisov <nik.borisov@suse.com>
Subject: [PATCH v2 0/7] 5.4 backport of recent mds improvement patches
Date: Mon, 26 Feb 2024 14:22:30 +0200
Message-Id: <20240226122237.198921-1-nik.borisov@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[eflags.cf:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Here's the recently merged mds improvement patches adapted to latest stable tree.
I've only compile tested them, but since I have also done similar backports for
older kernels I'm sure they should work.
The main difference is in the definition of the CLEAR_CPU_BUFFERS macro since
5.4 doesn't contains the alternative relocation handling logic hence the verw
instruction is moved out of the alternative definition and instead we have a jump which
skips the verw instruction there. That way the relocation will be handled by the
toolchain rather than the kernel.

Since I don't know if I will have time to work on the other branches this patchset
can be used as basis for the rest of the stable kernels. The main difference would be
which bit is used for CLEAR_CPU_BUFFERS. For kernel 6.6 the 2nd patch can be used verbatim
from upstrem (unlike this modified version) since the alternative relocation
did land in v6.5. However, even if used as-is from this patchset it's not a problem.

V2:

Added upstream commit id to individual patches.

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


