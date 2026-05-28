Return-Path: <stable+bounces-255031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKQFASdXGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:54:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E445F3FDA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA905318ECB2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3348285CAE;
	Thu, 28 May 2026 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3wcoV+cC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOpggAWG"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F173EEAE5
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979756; cv=none; b=myfFUF3xfuCylLJC9W6SB3MB08b1htECCDjcGO3v+B0qc5aSIsIyZ0vSTJ+/b+62Tbhcpm1J7MTcGqz6ulDi4IXdUqLD5oYBludLlcZpuAfzr5MHTkTk+td/IoDp19DGUk9lrDCPgyLCPsYJQRZlXLq5I0Z2PYsQQNk2DY2VDjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979756; c=relaxed/simple;
	bh=jvcDevnuQCxQVo+Z7oC9eeWzAb8+uRz2ex0LRDwdFFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWM0iKakn5Mg+eaHPHADSgIuh8FZErOU83jFJNWxdYXWT8hpnRJELFuB0v3czNZko5lVkezsBMcD4bz5GLsWT6kwCQgV9vqHAEfkHcPy7iBuZGgHRat9UV18tyDtiyMKvSP1KDgceJsOJcZ2rBqGgWZJAdP7C/PHxWX3hqtR/CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3wcoV+cC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOpggAWG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779979709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mz5Pexo5mytfPMCdzFX43BUJQWRohKcm2bDZUjBr3lg=;
	b=3wcoV+cCFhq57kSkTANEq3Cy8u3sNaclKO19r0G75VNlr2Vy3Wdz46NrVDCmMN23vXP/VR
	gfQnzx2LW/bdQjU/nb4ayUDId1B5/pXuGjoSpNSsWjZvvmcTlA+lTeoBCtg++tPqGgHJZj
	Ril+7eOyH48Kh1ETVSM+USG/29SY7ZdC34d3b/59Jcj/4H1tczG+oJMSviHpkscMgZO0kE
	9Dp7PhEA3bt1tTZ29pjaPGYJGXk22GP9E28wM6aoi3DajsgyH54E5NXdDH/I/J0sGV2CHI
	OVPENTr6hLBtRhe3+wlryqzA1itMQ3K43FLoCHxOpv/CLsLYI09SMj/P9OrNkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779979709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mz5Pexo5mytfPMCdzFX43BUJQWRohKcm2bDZUjBr3lg=;
	b=qOpggAWGg1zMOKmx9OgEixaymvIqdwSWjIWHI24or645rrMGckKaUl5JODUBwjpMaDyUF0
	LzAVB8XRO9o5N9Dw==
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable 00/14] Backport: arm64: debug: remove hook registration, split exception entry
Date: Thu, 28 May 2026 16:48:10 +0200
Message-ID: <20260528144825.850351-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-255031-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 76E445F3FDA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

this is a backport of the "arm64: debug: remove hook registration, split
exception entry" series
	https://lore.kernel.org/all/20250707114109.35672-1-ada.coupriediaz@arm.com/

which has been merged as of v6.17-rc1. It fixes the HW breakpoint issue
on PREEMPT_RT.

I only picked one dependency and manually fixed the other conflicts to
avoid a larger backport.

This has been prepared against v6.12.91. v6.12-stable is the only
relevant tree for a backport (earlier stable version have no PREEMPT_RT
support).

Ada Couprie Diaz (13):
  arm64: debug: clean up single_step_handler logic
  arm64: refactor aarch32_break_handler()
  arm64: debug: call software breakpoint handlers statically
  arm64: debug: call step handlers statically
  arm64: debug: remove break/step handler registration infrastructure
  arm64: entry: Add entry and exit functions for debug exceptions
  arm64: debug: split hardware breakpoint exception entry
  arm64: debug: refactor reinstall_suspended_bps()
  arm64: debug: split single stepping exception entry
  arm64: debug: split hardware watchpoint exception entry
  arm64: debug: split brk64 exception entry
  arm64: debug: split bkpt32 exception entry
  arm64: debug: remove debug exception registration infrastructure

Mostafa Saleh (1):
  arm64: Introduce esr_is_ubsan_brk()

 arch/arm64/include/asm/debug-monitors.h       |  34 +--
 arch/arm64/include/asm/esr.h                  |   5 +
 arch/arm64/include/asm/exception.h            |  14 +-
 arch/arm64/include/asm/kgdb.h                 |  12 +
 arch/arm64/include/asm/kprobes.h              |   8 +
 arch/arm64/include/asm/system_misc.h          |   4 -
 arch/arm64/include/asm/traps.h                |   6 +
 arch/arm64/include/asm/uprobes.h              |  11 +
 arch/arm64/kernel/debug-monitors.c            | 258 +++++++-----------
 arch/arm64/kernel/entry-common.c              | 146 +++++++++-
 arch/arm64/kernel/hw_breakpoint.c             |  60 ++--
 arch/arm64/kernel/kgdb.c                      |  39 +--
 arch/arm64/kernel/probes/kprobes.c            |  31 +--
 arch/arm64/kernel/probes/kprobes_trampoline.S |   2 +-
 arch/arm64/kernel/probes/uprobes.c            |  24 +-
 arch/arm64/kernel/traps.c                     |  80 +-----
 arch/arm64/mm/fault.c                         |  75 -----
 17 files changed, 338 insertions(+), 471 deletions(-)

Sebastian

