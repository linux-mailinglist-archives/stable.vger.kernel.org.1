Return-Path: <stable+bounces-263508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jfWHCOGnMGrcVwUAu9opvQ
	(envelope-from <stable+bounces-263508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:33:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6959368B480
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:33:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cWhsn4fs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263508-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263508-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC913044A55
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 01:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA82327AC4C;
	Tue, 16 Jun 2026 01:33:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB331A6803
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 01:33:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573589; cv=none; b=DLmhH8LYb0cxLGzXiOJao+jTSeTx66L72wXZPBP0Gc2TfHATTfK8P2VIrcwso6j/9hKZQEwCAiA2Fg8D0LNbCJlf6aUqt4TA43l1G502zayk9jCGvH8hagwxFYO5HTFUdgCYPZBUyWo812hkyunR8fjorgZKNzUiRwXGQ+nfXHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573589; c=relaxed/simple;
	bh=6/330ckFM9Oh45Ccvc7GgfGZkMmkTzvxRP/gjWt6t8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRIVL1vF5ZnSrBPWQorUrm+96jAtvndssG5Uk0d98SVttZfRmcMLInMA2HLr1Zl2ozViCLX28+GTJPvdiACy959seMz/SaFiBgFmXhMNmXpYZQtr4U9KOlLcmLMOFWYbWeAOyzijoYvszjN5qTmSpoiTKfsQbEj03FXNPsPiIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWhsn4fs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AAF1F000E9;
	Tue, 16 Jun 2026 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573588;
	bh=u/0ln8B4zODi09O8Xgpl5oIkPPZJJEAzdIbJa/lcpsA=;
	h=From:To:Cc:Subject:Date;
	b=cWhsn4fsApermdmOH9rfhaVbkIAfSsX8f5zzfS0rcwrx2hzj1dYJXPHjSeTx3Z0DM
	 yZwH9sthsHpYvx9WfUwFc7sGLghbfDRutkqHSPmmeyAKngbCKrHkDlHPA8zEC1ZuMj
	 urfA2qFZVifpltJO2EqUu8u1FxKrEzv2UMxkWmZ63u6q2GndXcdJqsCjCZYsokp+JO
	 ggdQzbYHjLGC9cDnBeRjadUbYbcRhbHP0OcC39RdsLxbiYPNgYNzzy3iz4+jEEgUtj
	 K58j1KwTfLpuRl4kUleoQ2Dc0w9OLBR7uLglwuKiRVYFZFr9fajHKQKv3QQelthSJC
	 oGHR6Ia4Ne3Rg==
From: Clark Williams <clrkwllms@kernel.org>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH linux-6.1.y 0/2] 
Date: Mon, 15 Jun 2026 20:33:04 -0500
Message-ID: <20260616013306.3850069-1-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263508-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[clrkwllms@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clrkwllms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6959368B480

GCC 16.1.1 introduces stricter diagnostics that surface two latent issues
in the 6.1.y stable tree, both of which become hard errors under -Werror:

1. -Wattributes on regparm(0) for x86-64
arch/x86/kvm/vmx/vmx_ops.h applies __attribute__((regparm(0))) to
vmread_error_trampoline(). On x86-32 this is intentional: it overrides
the kernel's -mregparm=3 convention so the trampoline receives its
arguments on the stack, matching the inline-asm callers that push args
before the call. On x86-64 the attribute has always been a no-op (the
SysV ABI already passes arguments in registers), but older GCC silently
accepted it. GCC 16.1.1 now warns, which -Werror promotes to a build
failure. The fix guards the attribute with #ifdef CONFIG_X86_32.

2. -Wdiscarded-qualifiers in libbpf
In tools/lib/bpf/libbpf.c, resolve_full_path() assigns the result
of strchr() on a const char * to a plain char * variable. Newer
GCC/glibc combinations propagate the const qualifier through strchr(),
so this assignment now triggers -Werror=discarded-qualifiers. Since the
variable (next_path) is only used for pointer arithmetic and is never
written through, the fix is simply to declare it const char *.

Clark Williams (2):
  tools/lib/bpf: fix const-qualifier discard in resolve_full_path
  kvm/vmx: guard regparm(0) on vmread_error_trampoline for x86_32 only

 arch/x86/kvm/vmx/vmx_ops.h | 7 +++++--
 tools/lib/bpf/libbpf.c     | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)


-- 
2.54.0


