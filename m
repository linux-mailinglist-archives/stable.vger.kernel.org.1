Return-Path: <stable+bounces-242328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yA4KKZKP9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:33:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B22A4AC0E0
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C877730C7097
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E68D39F179;
	Fri,  1 May 2026 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCKyhwHX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220636AB72
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634514; cv=none; b=A+kRCcWNB8EhFjhOGebSVy3cYjYrsA/vbAY1NwZ6YWcBVPPU+UQy3EXpgJpkfEzj/WMAY8JH2bwfixGkxqbZbr039BtCfF66CGPSmPJpkeM205QtZHP4EQC+jU6+9A1RelD7ZjCpj+Gcd+TwOsH8eByoZ7hfrCtDukLvtNCvoR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634514; c=relaxed/simple;
	bh=qUux5fWnaB7vwSuaIK7yJ/xoTOk1kHLhaO5Fj32opLY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T1/S8YWRlHPF5MSierIWSH1xZPfh45DNnF0ntDWkgwWAtCe8ATfwt106pst/Pdro0JkiXS0c8ql/vkoRWHq9LScTcx//tZX10qKCSHm+JQhlHaHdg3m9Kr4HFN1qVl5KjFIi74et9r/9RGf6jfVnMYVmHEBxX8T2x/TwWlBdrI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCKyhwHX; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4411a36715dso1164000f8f.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634511; x=1778239311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OsvmNiIFOjSLSp4rcDSw+qNHN7ZNglz3VqzWWNlV7vU=;
        b=bCKyhwHXoa2an2ZvtTZAWgZAckjcVwu/L0Pdj8xcKdZXzyndJz6qFK19tNwHY/VKKN
         GlihEssAAdZGopoW446Jx8DGi6wMSYAsH5XYjmLZyL7sBeJDqAcLAkfoqZdzsHEHaXqt
         xaqjz4rq2+nbfe4zUnLLY4q8xLVJgRX+pi7gTSRAbriIjHeE5v/otY2AYdT6+DW1yl1d
         aJuBaG7gbx2VO/MkHr/8+J7IHM+6TxJx8HXN6h+bvZu31Vox5UNgLpfLKJ3e+i413Cfo
         4AaNctjRnYjzA1eohtiG6DvrRF/aQMscuJEjVLmDvFVQkx6nQPUN+S1VTVdIdoouuc3T
         AIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634511; x=1778239311;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OsvmNiIFOjSLSp4rcDSw+qNHN7ZNglz3VqzWWNlV7vU=;
        b=QI28aQRga4mnByi69aZQQLhTvQAzqfmkl9mRqhnbvgmNzGXGzGi67Z3M3FY6LkeIZY
         jOf6hlCKbAV146yyKtHAkzno8O6w7/wOxC4lYJJbrINBGsRMzr31lKXkv0vzjEduIpvI
         ijVDmTuKfjHUoE3l/gcZasQYUu/kx3n+VKp3VpuBLwFgqTCySSwX6z4SO5ovpwr9SOfm
         rJgZFw1P5+s/wyMBxzXe77PK+oUrKaPHe31yc9P9qnSPdzDd8slVStqw7KGiJbesyGWp
         scfN/Xa1lm5rngeZ9RDpNP2dUTD9QAPwKXdAVcamXMQ4cIMIAmjVTSQO2vGTDnUQ2qGB
         XAcQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gyhlLsd1S83yegjxdSaocDI9Ziz6KI4e6cq0eYTcaOBx7mKpIHBPeihETyb6n8gL7mo+8h14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNGvwkVceafANsJb+Hd9g2FsvlrqA3dggMw4iRxOrxaR1PVOIW
	by1thmvzXPqz7nFVOLQ2pWGcKDlJgnM0LhPieLH4SmQz3Gk8bJhYv2tzmPmJLX3KfsN+Ycgzgv/
	gog==
X-Received: from wrbgg9.prod.google.com ([2002:a05:6000:2f89:b0:449:ba46:e362])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2f8a:b0:441:1cf9:4f06
 with SMTP id ffacd0b85a97d-4493fed64c0mr11269061f8f.31.1777634510466; Fri, 01
 May 2026 04:21:50 -0700 (PDT)
Date: Fri,  1 May 2026 12:21:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501112149.2824881-1-tabba@google.com>
Subject: [PATCH v2 0/6] KVM: arm64: EL2 synchronisation and pKVM stage-2 error
 propagation fixes
From: Fuad Tabba <tabba@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	qperret@google.com, vdonnefort@google.com, tabba@google.com, 
	catalin.marinas@arm.com, will@kernel.org, yaoyuan@linux.alibaba.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2B22A4AC0E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242328-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi folks,

V2 of the kvm/arm64 audit fixes [1].

Changes since v1:

    Patch 1 (SCTLR_EL2.EIS|EOS): Fixes: tag corrected to 0a35bd285f43
    ("arm64: Convert SCTLR_EL2 to sysreg infrastructure"); the commit
    message now explains that the conversion auto-generated
    SCTLR_EL2_RES1 to UL(0).  Code unchanged.

    Patches 2-3 (NULL vcpu guard, __deactivate_fgt typo): unchanged.

    Patch 4 (new): Seed selftest_vcpu's memcache to mirror
    hyp-main.c's pkvm_refill_memcache() flow; required by the
    pre-check in patches 5-6.

    Patches 5-6 (host->guest share/donate, formerly v1 patches 5-6):
    reworked to pre-check the vcpu memcache against
    kvm_mmu_cache_min_pages() during the existing pre-check pass,
    before any state mutation.  The WARN_ON() around
    kvm_pgtable_stage2_map() then asserts an invariant the pre-check
    pass establishes, rather than swallowing a reachable -ENOMEM.

Dropped since v1:

    - Patch 2 (HCR_EL2 sync): failure path not reachable.
    - Patches 7-8 (guest->host share/unshare): the stage-2 map cannot
      fail at those call sites (the leaf already exists).

Carried `Reviewed-by` tag (thanks!) and added `Assisted-by:` tags.

Note that with `review-prompts` in the `Assisted-by:` tags, I am
referring to subsystem guides that I added to the base prompts [2],
which I plan submit for upstreaming.

Cheers,
/fuad

[1] https://lore.kernel.org/all/20260428103008.696141-1-tabba@google.com/
[2] https://github.com/masoncl/review-prompts

Fuad Tabba (6):
  KVM: arm64: Make EL2 exception entry and exit context-synchronization
    events
  KVM: arm64: Guard against NULL vcpu on VHE hyp panic path
  KVM: arm64: Fix __deactivate_fgt macro parameter typo
  KVM: arm64: Seed pkvm_ownership_selftest vcpu memcache
  KVM: arm64: Pre-check vcpu memcache for host->guest share
  KVM: arm64: Pre-check vcpu memcache for host->guest donate

 arch/arm64/include/asm/sysreg.h         |  2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 +-
 arch/arm64/kvm/hyp/nvhe/mem_protect.c   | 24 ++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/pkvm.c          | 16 +++++++++++++++-
 arch/arm64/kvm/hyp/vhe/switch.c         |  3 ++-
 5 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog


