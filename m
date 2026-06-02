Return-Path: <stable+bounces-259920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MppDJo5cH2pWlAAAu9opvQ
	(envelope-from <stable+bounces-259920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 00:43:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E04632857
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 00:43:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=URx3qGJ1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259920-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259920-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAC24307B54C
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 22:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8563C5855;
	Tue,  2 Jun 2026 22:37:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD83A168E;
	Tue,  2 Jun 2026 22:36:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439822; cv=none; b=oz4EQK+YBaZ4w/ZsceVPlvBZ6Nr+4D9YnSg+xuawCRpV1kCyahtq8aR6PcTBwwTIK/CiGN4PRIC0G7CGW/nkc5TnLG6O+sb8M2HGPalmyMVpTpBmrRmqL4JubO9U9Y77wbI2EfCHrOnlXxAWJ3TSDLOGaLH4aJflTt/0YfS4f+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439822; c=relaxed/simple;
	bh=urESQJEzugHb1URckCLzAK6tTchZl5F7MkXkyCmt6GQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t3mkJZ5P3MLPOBhWVtjLK5pIjaSEeOfoCNc4cwRoDlVVg4zndQNUWVZauAVjsr88X8zAGtrn0w0agZ0fPkVDaBSQYvtbBACl3aG/sgu5zhGFsc2+KJeOuqzgCiaLrzLcTJt2MkCBEomxmfqZRhE1FDXOMfOco5aDL5YeA6hV8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=URx3qGJ1; arc=none smtp.client-ip=95.215.58.178
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780439804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DXwo4i9Kx+guFPQ/MiUMcJ80u+YI2AYi7oCtxG+RLHM=;
	b=URx3qGJ1hCz5S0rxT20jA1uzsXBENZPYaKDo7t9lrflb+HambGro9A+5I64SRAd6aB7Aex
	yLsJ/MdSDok7ZEdCLCkzRCypvcEsiVsWtWG5O9ZrpEkqe0zA18kLuDLaNFvloB0vHFR6Mt
	xW1tsODevEaYIcpxqwg1ChtmGqQoWJw=
From: Atish Patra <atish.patra@linux.dev>
Subject: [PATCH v3 0/4] KVM: Miscellaneous SEV/SNP related fixes
Date: Tue, 02 Jun 2026 15:36:31 -0700
Message-Id: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO9aH2oC/13MywqDMBCF4VeRrJuSieTWVd+jFIk6rVl4ISOhR
 Xz3RqG0uDwzfP/CCGNAYpdiYRFToDAOeZSngjWdH57IQ5s3k0JqoaTihKmiYaoe4YXERW1KY10
 D3gHLZoq4PzK53fPuAs1jfO/5BNv1W7KHUgIueKuNFxYUGOOuPc7+3Iw920JJ/rAWcMQyYw1gH
 dTSeqv/8LquH3ZEK7fmAAAA
To: Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Peter Gonda <pgonda@google.com>, Brijesh Singh <brijesh.singh@amd.com>, 
 Youngjae Lee <youngjaelee@meta.com>, Ashish Kalra <ashish.kalra@amd.com>, 
 Michael Roth <michael.roth@amd.com>, John Allen <john.allen@amd.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: clm@meta.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, stable@vger.kernel.org, 
 Atish Patra <atishp@meta.com>, Sashiko <sashiko-bot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:thomas.lendacky@amd.com,m:pgonda@google.com,m:brijesh.singh@amd.com,m:youngjaelee@meta.com,m:ashish.kalra@amd.com,m:michael.roth@amd.com,m:john.allen@amd.com,m:herbert@gondor.apana.org.au,m:clm@meta.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,m:atishp@meta.com,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[atish.patra@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-259920-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atish.patra@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15E04632857

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
Changes in v3:
- Added comments, fixed commit messages and fixes tag as per discussions on v2. 
- sev_init_ex_buffer initialized with zero at allocation to prevent any kernel
  data leak in case of init_ex_file is not present. Reported by Sashiko
- Link to v2: https://lore.kernel.org/r/20260601-sev_snp_fixes-v2-0-611891b28a86@meta.com

Changes in v2:
- Added fixes based on the reports by Sashiko. 
- Added a kselftest for validating SNP VM mirroring/migration rejection. 
- Link to v1: https://lore.kernel.org/r/20260528-sev_snp_fixes-v1-0-d67a08151779@meta.com

---
Atish Patra (4):
      KVM: SEV: Do not allow intra-host migration/mirroring of SNP VMs
      KVM: selftests: Verify SNP VMs are rejected from migration and mirroring
      crypto: ccp: Fix possible deadlock in SEV init failure path
      crypto: ccp: Fix memory leak in SEV INIT_EX path

 arch/x86/kvm/svm/sev.c                             |  6 ++-
 drivers/crypto/ccp/sev-dev.c                       | 19 +++++++--
 .../testing/selftests/kvm/x86/sev_migrate_tests.c  | 47 ++++++++++++++++++++++
 3 files changed, 67 insertions(+), 5 deletions(-)
---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260525-sev_snp_fixes-0b73789c1a91

Best regards,
-- 
Atish Patra <atishp@meta.com>


