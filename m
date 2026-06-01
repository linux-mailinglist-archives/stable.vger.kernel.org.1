Return-Path: <stable+bounces-259672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIZWJ44QHmrugwkAu9opvQ
	(envelope-from <stable+bounces-259672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 01:06:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14337626327
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 01:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 933CE304699D
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 23:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320DB344DBD;
	Mon,  1 Jun 2026 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Pxo7gb14"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFBC368D65
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 23:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355103; cv=none; b=bFOXZNykAFP27d7eQXnO8uMSBh3YAJ+ElBu2MzZ96SYCa+DkF4QLfQ3JZlF7eGu9qEsaUzyrECMA2bDuupJUZLRIgchbjGE64bIaMrFHT2vJpdFAhFeCNFCP7JBHRLsBNbInKm0CUdTomAFUtScZP7l0O0c8NGYvcAev0pOnIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355103; c=relaxed/simple;
	bh=bVPsmHC32xMRnbCUQzo2sQikrGCF693UprcC5PbkroU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ApkO0y28rf369e1WI0BivtEXztthThyTIP99PARtVWRR3ujQpbEweczjNgtNmOWDS/Ot4fl1LQrMSA0QJdYk356cjdl6f3f/jWckT1b1xZ+PT2T2XixhfmcEW06RIiXJCLW7BNHkv8HqtV3VNJ/LZ5k9BkPs8amMY/bPwrStPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Pxo7gb14; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780355099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ee5LGH1mkBrJOdssFnEtVdpG6R6AtAmt3hnR2uiZ+kU=;
	b=Pxo7gb14u7uOLz1Y0FCkQxiXki+1pmMfjLXzJszg5UslRDvTodrpHNNb2+Lw/HjDlVEz+D
	5N3t8cHdP1cd6hsNaMZFgtImsNbE1Gon8qjLDx8Fa7CdUSl/u15ETsrasdHxS2LjfdSAd9
	1tAZyJtU8BfQ1BykPjDnyhNVRhyvISo=
From: Atish Patra <atish.patra@linux.dev>
Date: Mon, 01 Jun 2026 16:04:37 -0700
Subject: [PATCH v2 3/4] crypto: ccp: Fix possible deadlock in SEV init
 failure path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sev_snp_fixes-v2-3-611891b28a86@meta.com>
References: <20260601-sev_snp_fixes-v2-0-611891b28a86@meta.com>
In-Reply-To: <20260601-sev_snp_fixes-v2-0-611891b28a86@meta.com>
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
 Atish Patra <atishp@meta.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259672-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atish.patra@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim]
X-Rspamd-Queue-Id: 14337626327
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Atish Patra <atishp@meta.com>

__sev_platform_init_handle_init_ex_path() called
rmp_mark_pages_firmware() with locked=false but while the parent
function of init_ex_path already acquired the sev_cmd_mutex.
In case of a rmpupdate failure for any page after the first, the cleanup
path would invoke reclaim pages which would result in a deadlock in
sev_do_cmd.

Pass locked=true to honor the lock status of the parent function.

Fixes: 7364a6fbca45 ("crypto: ccp: Handle non-volatile INIT_EX data when SNP is enabled")

Reported-by: Chris Mason <clm@meta.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Atish Patra <atishp@meta.com>
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index d1e9e0ac63b6..3d4793e8e34b 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1557,7 +1557,7 @@ static int __sev_platform_init_handle_init_ex_path(struct sev_device *sev)
 		unsigned long npages;
 
 		npages = 1UL << get_order(NV_LENGTH);
-		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, false)) {
+		if (rmp_mark_pages_firmware(__pa(sev_init_ex_buffer), npages, true)) {
 			dev_err(sev->dev, "SEV: INIT_EX NV memory page state change failed.\n");
 			return -ENOMEM;
 		}

-- 
2.53.0-Meta


