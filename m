Return-Path: <stable+bounces-259921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4MxYEgJcH2ovlAAAu9opvQ
	(envelope-from <stable+bounces-259921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 00:41:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD5E632808
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 00:41:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ff25GIZm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259921-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-259921-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 249BD303ABEA
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 22:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95913C8723;
	Tue,  2 Jun 2026 22:37:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C433A6B6F
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 22:37:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439822; cv=none; b=WbNvX4WvWE/AOpmELUG05FaP0I9poFz2MCcDlAVx4vh/Y2zTF6Z0Tl1GxdT6024m8lVwhpOh153c7lC+yhmSRFnVW7QOSKxlXl1LwO2L8l7uTo8TtsjWI07lt4usuYZ2PJg1DUTG6hJ5eebITL+JnfK3zfMpTvkMP8Ht4G+00+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439822; c=relaxed/simple;
	bh=9hq6zdSwsjyPBSgr32Ip1dWxtQ83+EJXhKVsLpA1Ebg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5EhNIEFl1XJlT7AsRTT43mKgo63Tekrb1l+IxI1ZpeAwl7omWCbP17yvSW+37p2q1mVePPGQNLssNKl7JAotb45tHaQ2CuX8HFgYyp8l64OjOUu00+N4B2j0XMuU5Kmm1uWVs8iUCWKE6NxpWkNIbOSGLz63AUtyn5OgtVZH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ff25GIZm; arc=none smtp.client-ip=95.215.58.187
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780439818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+027DcSYo9NyoKNOAow6QM7b5wUq0wevIvgDFOXMNA=;
	b=ff25GIZmC7IEb4xhl/jlEAtYkb95u2yCf1hjmu/CjcErN57NqZrLttc7G4+/o133PrzYBC
	9oyu3wbX4G4IzZ+9uF+2ASpfETT5HEDfmKh0uVAQaT1kS7ZBqhRsn0oyxnLXfpsenv2JMn
	CcQjFcQ9cbKNW7E8meUf+WfbuXJi2Y8=
From: Atish Patra <atish.patra@linux.dev>
Date: Tue, 02 Jun 2026 15:36:34 -0700
Subject: [PATCH v3 3/4] crypto: ccp: Fix possible deadlock in SEV init
 failure path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-sev_snp_fixes-v3-3-24bfd3ae047c@meta.com>
References: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
In-Reply-To: <20260602-sev_snp_fixes-v3-0-24bfd3ae047c@meta.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:seanjc@google.com,m:pbonzini@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:thomas.lendacky@amd.com,m:pgonda@google.com,m:brijesh.singh@amd.com,m:youngjaelee@meta.com,m:ashish.kalra@amd.com,m:michael.roth@amd.com,m:john.allen@amd.com,m:herbert@gondor.apana.org.au,m:clm@meta.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:stable@vger.kernel.org,m:atishp@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[atish.patra@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-259921-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:mid,meta.com:email,amd.com:email,linux.dev:from_mime,linux.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CD5E632808

From: Atish Patra <atishp@meta.com>

__sev_platform_init_handle_init_ex_path() calls
rmp_mark_pages_firmware() with locked=false while the parent
function of init_ex_path already acquired the sev_cmd_mutex.
In the case of an RMPUPDATE failure for any page after the first, the cleanup
path would invoke reclaim pages which would result in a deadlock in
sev_do_cmd.

Pass locked=true to honor the lock status of the parent function.

Fixes: 7364a6fbca45 ("crypto: ccp: Handle non-volatile INIT_EX data when SNP is enabled")

Reported-by: Chris Mason <clm@meta.com>
Assisted-by: Claude:claude-opus-4-6
Fixes: 7364a6fbca45 ("crypto: ccp: Handle non-volatile INIT_EX data when SNP is enabled")
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
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


