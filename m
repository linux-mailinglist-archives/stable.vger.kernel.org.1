Return-Path: <stable+bounces-256441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPGIGbzLGGrrnQgAu9opvQ
	(envelope-from <stable+bounces-256441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:11:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7D85FB3BB
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 01:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC8FB300CE98
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC99D367F45;
	Thu, 28 May 2026 23:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iE6K5eni"
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CED33D4E2
	for <stable@vger.kernel.org>; Thu, 28 May 2026 23:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780009913; cv=none; b=Z99/GYMzcmm8sgEhWQxfoJGPb3AUqiuyN4b8c8vQ3UQzYPA628OjzHcrmxOn+ClsP6jTJnyHHIi9X0XfUfa/vgQTjdoYbfuKT4NZdIeoykLvjaJDk+IsYHKfgpXIXfZ15P0MxEGnxkKFtR40jQffvEbg/zfg38rO0DtuJpTRHCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780009913; c=relaxed/simple;
	bh=5adojc1go2KwpqMc05wDsZ4zJsAbD9xwCcHX4ApiQpE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F+qrCOT+6eLMu2vqVy9s+Lf1V4JPX/1I9vftsAp7a8LCueu3C28B0/UP4/ziEJ3AXqa/PPkFyYKI3iVC8vU2np1ssBFRYgg+85NFnPero1gTDsTv3/POQ7Jzofy2GPya5bm+Cw154rbel38Emhs78483XiR2VfY9memni+npQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iE6K5eni; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780009908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MKHPi9+ltAWfK4xQDeY6Lr/5mupcQ2dHPDNSkERP3Kc=;
	b=iE6K5eniOKNQNutkwjMcx8rMi50fuHOggu4HA7XmDYcTuucmvdd1yweDbzlvIjwfkkSpjI
	cCKYlPQNA8Kla9XvPpO3VGDKLazPv3xQe690vdvPyWzXqyIbaiTGoPbL7vxaYitMGiKi+4
	slRCw9Q3aX7u5pRNw1+XfsFToIYhHFE=
From: Atish Patra <atish.patra@linux.dev>
Subject: [PATCH 0/2] KVM: Miscallenous SEV/SNP fixes
Date: Thu, 28 May 2026 16:11:37 -0700
Message-Id: <20260528-sev_snp_fixes-v1-0-d67a08151779@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKrLGGoC/x3LQQqAIBBA0avIrBPUsLKrRITZVLMxcUCC6O5Jy
 8fnP8CYCRlG8UDGQkxXrNCNgHD6eKCkrRqMMp2yxkrGsnBMy043slRr3/aDC9o7DfVJGf9Ql2l
 +3w+rHfcLXwAAAA==
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Marc Orr <marcorr@google.com>, Peter Gonda <pgonda@google.com>, 
 Brijesh Singh <brijesh.singh@amd.com>, Youngjae Lee <youngjaelee@meta.com>, 
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
 John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: clm@meta.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
 Atish Patra <atishp@meta.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atish.patra@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-256441-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+]
X-Rspamd-Queue-Id: DC7D85FB3BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series addresses a few issues found during code audit of the
KVM SEV/SNP and CCP driver code. The fixes include a incorrect lock state
and incomplete state handling during intra-host migration for SNP VMs.

To: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
To: Marc Orr <marcorr@google.com>
To: Peter Gonda <pgonda@google.com>
To: Brijesh Singh <brijesh.singh@amd.com>
To: Youngjae Lee <youngjaelee@meta.com>
To: Ashish Kalra <ashish.kalra@amd.com>
To: Michael Roth <michael.roth@amd.com>
To: John Allen <john.allen@amd.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: clm@meta.com
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: stable@vger.kernel.org

Signed-off-by: Atish Patra <atishp@meta.com>
---
Atish Patra (2):
      KVM: SEV: Do not allow SEV-SNP VMs from intra-host migration
      crypto: ccp: Fix possible deadlock in SEV init failure path

 arch/x86/kvm/svm/sev.c       | 3 ++-
 drivers/crypto/ccp/sev-dev.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260525-sev_snp_fixes-0b73789c1a91

Best regards,
-- 
Atish Patra <atishp@meta.com>


