Return-Path: <stable+bounces-240303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGQUFZOi6GngOAIAu9opvQ
	(envelope-from <stable+bounces-240303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:27:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D278B444AFD
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 12:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F15B301C97A
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086263CCFB7;
	Wed, 22 Apr 2026 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/HL9pxb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E33CD8BC
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853558; cv=none; b=PqJgXcYxAWDGYeX4OPCxaTd6ZLk4igY2x/Nuv6/zMNmWq20MuA9tZ6A+yWLJlUztS1DKiJFqGCO7tbi70CijN+4JJnpM9zzkx8qnSvjPrspU/pD2ik06HvVad6TrugmGmHVq7CTAaPOpZRJK8rqxSn9UQC23a2012qSkO91HmpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853558; c=relaxed/simple;
	bh=4e9RR3Fkt5ZYKdTIbJ3Mu4JFWKC86taawCJaNBynDdI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aKyFrOv1WciTgXCKDqKHlPyx8A+/TEIFLOOop3pyRwRGCOWqdo6xvTD5N3WeoiTgFH5cwBUDwGNIH4s975Y+CpuP7yC0iDgi2j+UDrgV/uyjBe3hwSuGrJgaFV0Kkhy3J8AL14595Ta+pNb1sSqD3yqUwu6UTsjNgO0EOqEu/L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/HL9pxb; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so3199555f8f.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 03:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776853556; x=1777458356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5zVG8CK37G2H3h+/vsooWmb/JX2s+XnozBdTiycqzLw=;
        b=Q/HL9pxbj9fjfJerdkMdihhSQ2Es3zUJ1UQciZSRFoQZb61cDd/FUUksRrwVpTfZW2
         MVnFlk9zNhCuc1MWIvdwzybRtZ+chsatmizS+7J/RiAhctWKwSqJUZujedxIvGMHY2Ak
         zhJMO7MTafnBGD+UqTKTxwc1MHaHzbcivdxFxDlUdtKwu76EP+ek9JAvQpKoAOZTZEM5
         5pyT2aDaXjgljGYg7YApUPvNFEQZ+E9AaF3e2K7cSp+K4q+7bohbsr8116JAl2x4HHLa
         asO452DorM3KKZCrxL3JKwi6ILU3KpFJ9EPeFpKSuOwNG631TPtQ76luXsFysbkR0RQR
         KT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853556; x=1777458356;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zVG8CK37G2H3h+/vsooWmb/JX2s+XnozBdTiycqzLw=;
        b=Sv5i6O4IRWvs5ek5zZOjkxWpan3xFfQv4UC6gTwHKS/h/2JXajQmQ4CwnJ8OfVowpI
         dl0cAlu1bK85l/2Qt8FYCABDuY+yyWR4z76B8HxmMB/VWMot+1//Kath+IiqvQdaMR5U
         jw0c5GPZqWNaJRkJxJg1p1CssMSIzTlRp3nGYXRFUlE+iXtM4GNCAmzBnEih1FYTDhED
         pCSN76Q1GSvc0kPAGJsSDVEpfLbmLFZhmudKEn5ocZ2kp2OhSFIodkAh75mSzsClmMKc
         EBhx2jjewBdExgZq5hx+6BVtYySYxN0D33L+xmmYcfPFYMbRV+qGXSi6pOQnGVFoTOE4
         wHNA==
X-Forwarded-Encrypted: i=1; AFNElJ8XhWn47lyTx2F4Aw1iSDbJvmbySFuQHX8eAIKWpPiL5F50IEcUdr3RcKh12F1gFootzoOBaB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy2mWs7d+jjh2xtRXUWVMDROWv2Ao9KAZ9oZr/6ZBO8NaDDsEg
	p1jPV0DeZ13xMrEEA4U3BXpfimlxV457H4oKg8UVZmR6RapgeAU4okvLBp8GE6BFOZuZu8KIt23
	Qpm4RXvfR6YJ4z81I6vU2a/pZTiSPmA==
X-Received: from wrnl17.prod.google.com ([2002:adf:e9d1:0:b0:43c:ff2f:44d7])
 (user=sebastianene job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2812:b0:43d:7192:2ca6 with SMTP id ffacd0b85a97d-43fe407e0eemr21607407f8f.16.1776853555738;
 Wed, 22 Apr 2026 03:25:55 -0700 (PDT)
Date: Wed, 22 Apr 2026 10:25:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260422102540.1433704-1-sebastianene@google.com>
Subject: [PATCH] KVM: arm64: Validate the FF-A memory access descriptor placement
From: Sebastian Ene <sebastianene@google.com>
To: maz@kernel.org, oupton@kernel.org, will@kernel.org
Cc: ayrton@google.com, catalin.marinas@arm.com, joey.gouly@arm.com, 
	korneld@google.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	android-kvm@google.com, mrigendra.chaubey@gmail.com, perlarsen@google.com, 
	sebastianene@google.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-240303-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D278B444AFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prevent the pKVM hypervisor from making assumptions that the
endpoint memory access descriptor (EMAD) comes right after the
FF-A memory region header and enforce a strict placement for it
when validating an FF-A memory lend/share transaction.

Prior to FF-A version 1.1 the header of the memory region
didn't contain an offset to the endpoint memory access descriptor.
The layout of a memory transaction looks like this:

  Field name				| Offset
					 -- 0
[ Header (ffa_mem_region)               |__ ep_mem_offset
  EMAD 1 (ffa_mem_region_attributes)	|
]

Reject the host from specifying a memory access descriptor offset
that is different than the size of the memory region header.

Cc: stable@vger.kernel.org
Fixes: 42fb33dde42b ("KVM: arm64: Use FF-A 1.1 with pKVM")
Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index 94161ea1cd60..0703c0ad8dff 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -508,6 +508,12 @@ static void __do_ffa_mem_xfer(const u64 func_id,
 	buf = hyp_buffers.tx;
 	memcpy(buf, host_buffers.tx, fraglen);
 
+	if (FFA_MEM_REGION_HAS_EP_MEM_OFFSET(hyp_ffa_version) &&
+	    buf->ep_mem_offset != sizeof(struct ffa_mem_region)) {
+		ret = FFA_RET_INVALID_PARAMETERS;
+		goto out_unlock;
+	}
+
 	ep_mem_access = (void *)buf +
 			ffa_mem_desc_offset(buf, 0, hyp_ffa_version);
 	offset = ep_mem_access->composite_off;
-- 
2.54.0.rc1.555.g9c883467ad-goog


