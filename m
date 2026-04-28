Return-Path: <stable+bounces-241541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKtrG2GM8GkuUwEAu9opvQ
	(envelope-from <stable+bounces-241541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:30:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4725482A85
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E2E4301DEF6
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14FA3ECBD7;
	Tue, 28 Apr 2026 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oQHe34oP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018553ECBFD
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372212; cv=none; b=Fg1Kipr/oudMfPNYcb4GSMag0jk2NcjglPKp0BnSw0Nx0V7VLeBAw7sbWyCJh/V3A3Dr247IOdWqRoVW9N0ohZg+AayYFQarS1aKR3kA3TUwbZjgU5ScCv1k2U75BBmVwIVJloCJX1mUbvxtB5PwHYTPb8npe23Q1+abQGO6xtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372212; c=relaxed/simple;
	bh=Q1SQtMHy3aqsHkz2pqwBb00QPVJHhdgc6QUsbv3XMuk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hT3heevC75DUdIY2c7CQcRH0954DkqYpvX6Fqof8WeWykgVuX/Vx5D8o1DgoZYb7h3YlTow6yApbLmAHoNTKAXuwJ67IslyIeh7JqYpj4TE+ImdkOji1dbDVIGIaM9fZvIF/OLSKOYVzDsc6eH7ZlCAnlS9Xm9sayUNLCTL1ZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oQHe34oP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4837bfcfe0dso125256095e9.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777372209; x=1777977009; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ybPE6uBPAKDLSIVRQh3Dd/khXkWqQgT9nsbAgFbes8s=;
        b=oQHe34oPA9XmpeNDCzIzkkzcuI29Q0ml2z+Uh09iSXZuI6MySlMDJloZb0cv7bFkMd
         qp5BZ/I7RFm97SuKvEa1pFmKfUY38yR5BtLj9joCQiKyxjSovN5HoLkuZOF4eC4SpgCj
         akyHoGpRBw/ScvoHSZs85WDbm8Lq9wHetzhDpgWRZkYHjiXoCj0ui6tAonKaaXL+OrOw
         i3zFW/LYptl7UTDy1YSCbgIB+RK8wTBR/38Sy+C2ET3hQr5IMIXhWhcpCzwCgay4PZ5Z
         aEQ+dNEEQxGC9G82ig63UxWBqnUvDCpUaHq6CjnbYYEqds3Npuli1BjzAUWiww22Exzi
         ZdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372209; x=1777977009;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ybPE6uBPAKDLSIVRQh3Dd/khXkWqQgT9nsbAgFbes8s=;
        b=fsGTiebhTHbiLY724vCzGXQEgxlE72qxgnd/tIwEv/uU25ROJb1T7hkqIc/0JHGG22
         r9EBCiZ8C1Yf/beVrvm+I43tKTA6Qorj+G62cVbl+yqe77okCQofDPRxOMT9qnzGX8a5
         GECOuGxwzvHMvP+vnajG7IXsRDWm1bruuWg7/+0auZW3f2nmN1jpmkFOgXemrL8vvpPg
         oxASSV2NLneVrCTv+4NaB3KrqrgIKOL0ge3R2L1uqGAj7kLufQDhkcfvFULXTQwwwdM0
         e2tow0USvE6tBTw+WkJ6Ud176NZ+fubaMbW+4Y5YW9XUDX0a96e7rnmkY1gO7Nf/aUu0
         1LLw==
X-Forwarded-Encrypted: i=1; AFNElJ+t4McAkeJlZohaut0ZD8TcQXJyTB9T7hrYV11ZqYPlZ6DP1G/c6RVUIwb9OZmruhlaB4/Ogkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3HXRs8YKJ7XeRMlxiNozPBOoffaVdeyqMvZxWT0heR3KmlWC
	d6YEcsvEcdKTPI7AHgpMsvM6/R5oZBNO2pEFhf9tCocnB3qm14s0Y4PSpKM5Xn86eY7LbjrvQvG
	Ikw==
X-Received: from wmby10.prod.google.com ([2002:a05:600c:c04a:b0:486:fca5:7a8d])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a013:b0:48a:563c:c8e0
 with SMTP id 5b1f17b1804b1-48a77ad5a89mr41979925e9.1.1777372209349; Tue, 28
 Apr 2026 03:30:09 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:30:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428103008.696141-1-tabba@google.com>
Subject: [PATCH 0/8] KVM: arm64: EL2 synchronisation and pKVM stage-2 error
 propagation fixes
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D4725482A85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241541-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi folks,

This is yet another series of fixes I'd like to land before posting a
follow-up to Will's pKVM infrastructure series [1].

I found these while developing KVM and arm64 system guides for
review-prompts [2], an open-source set of AI-assisted review prompts
used by sashiko [3]. While writing the guides I tried to find cases
that would be easy to miss or trip up an LLM, and stumbled on these
bugs. A local run with the updated guides flagged all of them
correctly (some of the commit messages incorporate feedback from that
run, e.g., the impact of WARN_ON() in hyp). I plan to upstream the
guides once they are complete.

The patches fall into three groups:

EL2 context-synchronisation (patches 1-2):

  Patch 1 sets SCTLR_EL2.EIS and SCTLR_EL2.EOS in
  INIT_SCTLR_EL2_MMU_ON. On FEAT_ExS hardware these bits are
  UNKNOWN at reset; without them EL2 exception entry and exit are
  not architecturally guaranteed to be Context Synchronisation
  Events. KVM/arm64 hot paths rely on that guarantee implicitly to
  elide explicit ISBs after MSRs to context-switching sysregs.

  Patch 2 adds an explicit ISB after write_sysreg_hcr() on the
  __deactivate_traps() path. The activate path is covered by the
  ERET that follows (a CSE, guaranteed by patch 1); on the
  deactivate path, subsequent EL2 sysreg accesses run before any
  natural CSE.

Minor fixes (patches 3-4):

  Patch 3 fixes a parameter-name typo in __deactivate_fgt() that
  causes it to silently capture a variable from the enclosing scope
  rather than use its declared parameter.

  Patch 4 guards the VHE hyp panic path against a NULL vcpu pointer;
  the nVHE counterpart already has this guard.

pKVM stage-2 error propagation (patches 5-8):

  At EL2 in nVHE/pKVM, WARN_ON() is not warn-and-continue: it
  expands to a BRK that enters the invalid-host-el2 vector and
  branches to hyp_panic(), which is __noreturn.

  Four pKVM memory-transition functions wrapped the return value of
  kvm_pgtable_stage2_map() in WARN_ON() and discarded it. For the
  share and donation paths the map can fail via -ENOMEM when the
  vcpu memcache is exhausted, converting a recoverable hypercall
  error into a fatal hyp panic. The four patches capture and
  propagate the return value, with appropriate stage-2 unmap and
  host-side rollback for the reachable failure cases.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260105154939.11041-1-will@kernel.org/
[2] https://github.com/masoncl/review-prompts
[3] https://sashiko.dev/

Fuad Tabba (8):
  KVM: arm64: Make EL2 exception entry and exit context-synchronization
    events
  KVM: arm64: Synchronise HCR_EL2 writes on the guest exit path
  KVM: arm64: Guard against NULL vcpu on VHE hyp panic path
  KVM: arm64: Fix __deactivate_fgt macro parameter typo
  KVM: arm64: Propagate stage-2 map failure on host->guest share
  KVM: arm64: Propagate stage-2 map failure on host->guest donation
  KVM: arm64: Propagate stage-2 map failure on guest->host share
  KVM: arm64: Propagate stage-2 map failure on guest->host unshare

 arch/arm64/include/asm/sysreg.h         |  2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c   | 99 +++++++++++++++++++++----
 arch/arm64/kvm/hyp/nvhe/switch.c        | 11 +++
 arch/arm64/kvm/hyp/vhe/switch.c         | 14 +++-
 5 files changed, 111 insertions(+), 17 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


