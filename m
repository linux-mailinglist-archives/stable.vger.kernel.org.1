Return-Path: <stable+bounces-266600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 21USC7D0MWojtAUAu9opvQ
	(envelope-from <stable+bounces-266600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:13:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B821695EAB
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 03:13:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=nI8UM5h6;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266600-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266600-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FCFD311D9CD
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 01:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789B12D2397;
	Wed, 17 Jun 2026 01:13:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BB91E1E04;
	Wed, 17 Jun 2026 01:13:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781658791; cv=none; b=rXQ7g/iifflUzJKEks0K0WBd1kM64ShkK05PeaUUgYubKJKhMqRd5jj75r4DUWlhodRfFQeQjXGXGFbCK1U7TRmq+Fc2bXdR1GKaXC+fFaeoC0yg87Bsv98C+CzkI9++AN/0ytdamp6MtVJh+JO6ogcLEjLr/c+pufTiWIi6I6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781658791; c=relaxed/simple;
	bh=EMZ1WS3wDMjYIu5dV7yniTBHC0KRA1o2siFdDYktM/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=srkqABoRcLb7/zuYItCVbL5lQKTbNkKKMUiPh52sgPVmOBd/rSwqugCEgV88f8flYqQCmTVtmpBvlYQ/2e4++qXcemW9ggJtjs1UnFxu/qzOwEeHtv/tZukN4csc6wUMCG84Kptx5oytYTW+yoFN1NqkjQT5sDUw/hzi9IzBKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI8UM5h6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBE11F000E9;
	Wed, 17 Jun 2026 01:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781658790;
	bh=5Uqn6OKxHmP6e/ADDSYwMfh9TAS7e7+5aWVdC9k5xyI=;
	h=From:To:Cc:Subject:Date;
	b=nI8UM5h6WyIkzNaBAQsY8Hi0toqd7UTv3Ya4zuQ4h37PELMS9oBWVlhwBlvP8+u0h
	 Y1b40J4XLS5K0x3IMEBf1ZOK2z2N16u2cR8MHxm+N/lZdbjgUjCddSKixyDX2do8aq
	 6V7sj/veq69JHLE3MuPFwinbK9JZRjMIrRY+7px0X4YffbvskmCdbwGw5uwcArKo2s
	 0sB609ZrDb/NVUEbRDZDZl/6fo/v2VYWM/817nSP8/ysoU+w0b8ZUkzST+lzpo3j7x
	 xIPWPUwDQAUu/7EWM/e19EafZj1U5Qz0DthnALKRcPiqNo8FJIWTpa6tOqXf86mpcb
	 tdDb2f+fnu1BA==
From: Clark Williams <clrkwllms@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	x86@ekrnel.org,
	kvm@vger.kernel.org
Subject: [PATCH v2 0/2] linux-6.1.y: fix build errors with newer GCC/glibc
Date: Tue, 16 Jun 2026 20:13:00 -0500
Message-ID: <20260617011303.3969027-1-clrkwllms@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bpf@vger.kernel.org,m:x86@ekrnel.org,m:kvm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266600-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[clrkwllms@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
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
X-Rspamd-Queue-Id: 9B821695EAB

Please apply to linux-6.1.y.

Two build fixes for newer toolchains (GCC 15+ / glibc 2.43+):

1) tools/lib/bpf: strchr() now propagates const in newer glibc,
   causing -Werror=discarded-qualifiers on next_path in
   resolve_full_path().  Equivalent to upstream commit d70f79fef658.

2) KVM: VMX: regparm(0) on vmread_error_trampoline is a no-op on
   x86-64 and newer GCC emits -Wattributes for it.  Guard with
   CONFIG_X86_32.  Simpler equivalent of upstream commit 0b5e7a16a0a7
   which redesigns the declaration entirely.

Changes since v1:
- Fixed Assisted-by tag format per coding-assistants.html
- Added upstream commit references per stable-kernel-rules.html
- Updated KVM subsystem prefix to conventional KVM: VMX: style
- Fixed Author/Signed-off-by email mismatch

Clark Williams (2):
  tools/lib/bpf: fix const-qualifier discard in resolve_full_path
  KVM: VMX: guard regparm(0) on vmread_error_trampoline for x86_32 only

 arch/x86/kvm/vmx/vmx_ops.h | 7 +++++--
 tools/lib/bpf/libbpf.c     | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)


base-commit: 228da13e907e2b46b7222cfc35290fbfad920bef
-- 
2.54.0


