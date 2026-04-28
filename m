Return-Path: <stable+bounces-241542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMZ1NWOM8GkuUwEAu9opvQ
	(envelope-from <stable+bounces-241542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:30:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 923E3482A8C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 12:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7D31304C962
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5713ECBD7;
	Tue, 28 Apr 2026 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+efvmnI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDB37CD25
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372214; cv=none; b=a1fxVKV1iamOjk4SK7wMeEwNBpKyP2vFh5GtAcF8ukorX7tgeiB9sdugudNgDuSUr7wLfCbWMN64LAjoRND3GE7lhY2tIDe2Vo64y65mHNlXAkN17xejO2QrbMO410W7UBEdRAuTiFh5Yu4gNFCYy6bGp0tlG0L/1v6VvsdZBo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372214; c=relaxed/simple;
	bh=9Wt0iy5ayw0cQwuJpZ/wnzJmfEyzqf8hdthusy325Pw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B1s1SE3jFPQmNbe++ccjJ6CTFspCAloIlOIEV8XlHuBdVWJ9S1w3DSjxwJys5uRvqie8oxqY3cl1nyVy3nZMPhSqpgn0bwwLQJULE7tW8mh/eIv53eqXDxpmtLa0IQ8waGBWxtOTZZz6Vy3conTII1uDfboQX13pSKUJ+PkhwZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+efvmnI; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-672a206d806so10305503a12.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777372211; x=1777977011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7c867vhN0NJ0ysluuN7kPjni8MsLU+yiUrh20mCAzU=;
        b=u+efvmnIaOsAO0tdp6+xA05ecNTa5yClmUrtISo4sBE7lb1SaCt9spwcAZzdwtUrx6
         a0KIDTAS3xofORai0TYETJN7f3ooWHbrmnpHhCuR2or5ykQF7WrMSzgXv3sXq1Gv5mRl
         4glRb+oCLir4POt27218sdrQymFA/5Icj62N2tCWUTwuuMt/2c8Nh5Ozo3cs/E8iuK4w
         1Ca+dIzj1o0WmBB/7GidtNbjM9Mp22r1AOyrbn6Oilj5kS12uenFBWHKl5vWjozpd/ET
         Gu1VvT0eAB5mZssDJ9NBr8WoExZ/LSoEA9lkKPEukCpGT+PsvgF+WyhW4aodB2JzDkw4
         6CeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777372211; x=1777977011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7c867vhN0NJ0ysluuN7kPjni8MsLU+yiUrh20mCAzU=;
        b=asxHYFY1+Tx3f0Hd5JYvZjx9ky5P3ZEUrmWXodZrcI77GS/8aJDmTTeEDNv3yozc0A
         ZXZE5INO9iYA4CUz2LziFU/w71cMlerYNIiwrCSjbfFpZRaTN0TW6ZNTM41dSikGLdrW
         1IzksNwvHwmM1sgvoIJY/A5LGWdkJgmikms+cS52vz4Z0n+M371EjaV9u1aLCa7JQw1z
         o98xcmti27Gqs+szQwxcLLIS8DCaOHmPiolIU2ONcOACXq8cZCNAGZsAZpjQg8ameok6
         /QxQWTuZyOOK7dr3GxceGcYuCxY3Sc7FtzPb+T3FV70p1Ow89RPOKiP7DKVxvaF2Hi8s
         jJXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/GLpHYmk02aY3gYzdZfDAtPBYOdZUR5+TxYVK+LWgzNV7GE0S64ZqCgMwz0dLAXn0bop5i+UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHPlrGg8KDSVQZbXGHOKW6Z0Ktaqt6CV41KHApOFCQXr0dGMp
	ikomevxPb4piq9A9nOCjJyisnfiVl3OIk6++qVDN6+F6+kSqLw/1MIjqGCnGc3eaW1am/ZI/h/X
	7pQ==
X-Received: from edru26.prod.google.com ([2002:aa7:d55a:0:b0:674:1e56:7dde])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:158d:b0:678:a553:bcf3
 with SMTP id 4fb4d7f45d1cf-679bb0a125bmr1160027a12.21.1777372210503; Tue, 28
 Apr 2026 03:30:10 -0700 (PDT)
Date: Tue, 28 Apr 2026 11:30:01 +0100
In-Reply-To: <20260428103008.696141-1-tabba@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428103008.696141-2-tabba@google.com>
Subject: [PATCH 1/8] KVM: arm64: Make EL2 exception entry and exit
 context-synchronization events
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 923E3482A8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241542-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

SCTLR_EL2.EIS and SCTLR_EL2.EOS control whether exception entry and
exit at EL2 are Context Synchronisation Events (CSEs). Per ARM DDI
0487 M.b, EIS is governed by D1.4.2 rule RBBSRF (p. D1-7205) and EOS
by D1.4.4.1 rule RBWCFK (p. D1-7209). D24.2.175 (p. D24-9754):

  - !FEAT_ExS: the bit is RES1, so the entry/exit is unconditionally
    a CSE.
  - FEAT_ExS: the reset value is architecturally UNKNOWN; software
    must set the bit to make the entry/exit a CSE.

INIT_SCTLR_EL2_MMU_ON in arch/arm64/include/asm/sysreg.h sets neither
bit. KVM/arm64 hot paths rely on ERET from EL2 being a CSE, and on
synchronous EL1->EL2 entry being a CSE, to elide explicit ISBs after
MSRs to context-switching system registers (HCR_EL2, HFGxTR_EL2,
HCRX_EL2, ZCR_EL2, CPACR_EL1, CPTR_EL2, SCTLR_EL1, ptrauth keys,
etc.); examples include the activate-traps path,
ptrauth_switch_to_guest, and the FPSIMD trap re-enable in
kvm_hyp_handle_fpsimd. On FEAT_ExS hardware those reliances are not
architecturally backed unless EOS=1 (and, for entry, EIS=1), and
whether they hold today depends on firmware initialisation outside
the kernel's control.

Make the guarantee explicit: include SCTLR_ELx_EIS | SCTLR_ELx_EOS in
INIT_SCTLR_EL2_MMU_ON so that EL2 exception entry and exit are
unconditionally CSEs regardless of whether FEAT_ExS is implemented.
This matches the pairing in arch/arm64/kvm/config.c which treats EIS
and EOS together as RES1 under !FEAT_ExS.

INIT_SCTLR_EL2_MMU_OFF is left unchanged: that path is used during
very early EL2 init and the EL2 MMU-off transition, neither of which
relies on these bits in the same way.

Fixes: fe2c8d19189e ("KVM: arm64: Turn SCTLR_ELx_FLAGS into INIT_SCTLR_EL2_MMU_ON")
Signed-off-by: Fuad Tabba <tabba@google.com>
---
 arch/arm64/include/asm/sysreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 736561480f36..7aa08d59d494 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -844,7 +844,7 @@
 #define INIT_SCTLR_EL2_MMU_ON						\
 	(SCTLR_ELx_M  | SCTLR_ELx_C | SCTLR_ELx_SA | SCTLR_ELx_I |	\
 	 SCTLR_ELx_IESB | SCTLR_ELx_WXN | ENDIAN_SET_EL2 |		\
-	 SCTLR_ELx_ITFSB | SCTLR_EL2_RES1)
+	 SCTLR_ELx_ITFSB | SCTLR_ELx_EIS | SCTLR_ELx_EOS | SCTLR_EL2_RES1)
 
 #define INIT_SCTLR_EL2_MMU_OFF \
 	(SCTLR_EL2_RES1 | ENDIAN_SET_EL2)
-- 
2.54.0.545.g6539524ca2-goog


