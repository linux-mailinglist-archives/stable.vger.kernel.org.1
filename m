Return-Path: <stable+bounces-256717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILMUJ5XdGWo4zggAu9opvQ
	(envelope-from <stable+bounces-256717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:40:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 422F3607662
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B3473077000
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C65436371;
	Fri, 29 May 2026 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+qttPKx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGH+xCF4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CAA42316F
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079779; cv=none; b=Z0XNlzj5QOd/Rz9LqSHyjIhHQ50DhnNv5Zt3WtiyGOu8Wl76HD/4Xd6pQb/STyapS/c8BwMuvlA7JYLROnCGuKFwuioWCDX+AHP6NPiy0emktz2QB0DU//ysYHwRqmXzncwfvUT16erSrIzYGdD3bJ5VVCq1olywVXrO1yd66cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079779; c=relaxed/simple;
	bh=ocrp7UiS1WanCwFhsgzTGR2ip9lAk7udP5dDEIw2HFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFpuZ4wFPn/hxHo2zRwDR0yrisjMerrUboLFsXAHy7P/GZYmrqF+21jqjBiKuhUD0YwFvNCCfaI6FVJ6kSv6ooqr7melOvyWmFyPQa+/kB9XiG7v6qzwad5XLSu4JnQZwBphkC/qU9TOD+PDp3xZCCohTnNX1Mx/pUA/Cy8j8H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+qttPKx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGH+xCF4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ku/ngyswLIZ+ZhY/zg7dChYo6WlT7EL2y3Avs5NIsP0=;
	b=e+qttPKxT3DW7pTEWTJxL80biBALNS+OPOwi84PGMCjZZOVyz2c2jMAZXtDuTzOkUvcqx0
	dnIZhHpy4jeKlGsV6OniCCfc7AZ5pdGKlaTS8H93ZlLRME6SfW/3FilKX4GZknevqaXSpo
	OJ0NQ8++qG976U/nej7zxP8JaPqSm6k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-Bcw0-N6HOsuI1kSJmSftGA-1; Fri, 29 May 2026 14:36:14 -0400
X-MC-Unique: Bcw0-N6HOsuI1kSJmSftGA-1
X-Mimecast-MFC-AGG-ID: Bcw0-N6HOsuI1kSJmSftGA_1780079773
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-449b2a183d3so8947836f8f.0
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079773; x=1780684573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku/ngyswLIZ+ZhY/zg7dChYo6WlT7EL2y3Avs5NIsP0=;
        b=NGH+xCF4jFJnHxhlOunyscmGKYEc7DaPRYcJnSW9J5nzB04PqiFqprrTaTDMB/6Xyw
         9frEclL06kyjdRtgzhiNPBgtsSEOulkatCPrxI08ETs+Hyuu4CSFS/XAELyfBnWJcbwc
         rBZyE0TjD4eCGbtPxFkGLPCcZpkWgv2r8E4f5MtG1Zp4zcyVzvTQitjWoOFKkWAJZUip
         dk0MsMY+kkWj+4A0zXxx8H0SGqTtvyakYWqg9O9DG7XaCjaRb0oKpAZH2eLXo5VZnvAd
         Hl6UKNnLog8kcp5XMUHW7nRLXL29XblFZkb8NLbPAksgqX4ara1kJ8CItlwOVb6Nbzfh
         xNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079773; x=1780684573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ku/ngyswLIZ+ZhY/zg7dChYo6WlT7EL2y3Avs5NIsP0=;
        b=JjGsxHKRAicpe4pJoiE3B8rIzZvOCppsZo9dcuOm2LFJWkw+4Pi1hE5+Hos2Yu86T3
         vEXjXlOEbswgc9rorFN41D+lPGrPaOEhC3F5HKTSlzUtCd9YvBrygHutcEW9oFQ4/dsF
         jX3HmrHqaT0v4TJ/GKaf0o6xHTgZ8cPUDhHVeSHfsgQPYt4q2/KNweoaDIQID4spu94I
         8ffrYjttOfF7aoshq1La7kdHyyVTLtkHRDcuJx5wde5MOAPRamrb70Wx3n0bO560H3ID
         WrisKbryFQEe/ZJN94BeZHecKtxZXSES41oW99zxlwB/ivJmrT7PDEZE54Xa7QfRC+TX
         gH7w==
X-Forwarded-Encrypted: i=1; AFNElJ/xuIk85xH7LqSl4XBn5QohjZz7DAPblUNxnBrSxnj3g52U1ZLjq96aoTK5wkohVoWkhPLkEn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7NOY4e6Us26aDMc9Sx+o3yWD3yUR/3GrDsGkbxcXghAdMyCBm
	4nwYUT+0ErdNscvr7bB+8pyu9MlHzZ6oyyYCBls5cbILAq+EQfFIF6v0vdxbKywgJbRqlf2n33+
	lRTz8yXYwF6RbcUy7/MyxtfLRsBC1b4HLZ/MA+4z4GX2it2p4uZrpU4ykFw==
X-Gm-Gg: Acq92OHy9eEMqk9vF1Vh80f3Y13+GcBPi3PhhT9bRUSLCnkecMpA8s2EZ2fJ4GN9D+W
	xlhKZCEw8udiZdmiiXBZxulVRXp7bsgLnVXI5zJ1aMevCqWWHKn4pr6hhn3LF6KgJJcWDfwvFk5
	NEZephS24vUhiUoZCHYgcMA94tQHJW+/DFXrV1Ic6hZ0s7Pk+wqg40K0xroncs5/YS6a4Ld3o9n
	VzGNjlS3z0u8UpgEp+cZ9JPB74XxrTOgVcED7T/2EiZLUGYm5eTaqr1clF5Xrd3bd0tLJUlalfU
	3OX9Azj5yTB5YcJ7PuU0zScZq6BAF/cJ/ND4gmPByEOxb6pg841kcCSCG4/IdVLGZR8ToYpDvLX
	5yCGLPXCQz1FYOrogWHY9PE5R4rdRQZGFTo/aHvZjkqQ1ypqxBEZQ1mwuNFD+s15uNavm1ULFCx
	imSXdG1zD5EELgGU333Jd9nmHcQTMgqwEdXDs6eA==
X-Received: by 2002:a05:6000:40c5:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-45ef13794fcmr7447993f8f.16.1780079772766;
        Fri, 29 May 2026 11:36:12 -0700 (PDT)
X-Received: by 2002:a05:6000:40c5:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-45ef13794fcmr7447963f8f.16.1780079772417;
        Fri, 29 May 2026 11:36:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354b7edsm5207945f8f.22.2026.05.29.11.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 09/24] KVM: SEV: Check PSC request indices against the actual size of the buffer
Date: Fri, 29 May 2026 20:35:34 +0200
Message-ID: <20260529183549.1104619-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
References: <20260529183549.1104619-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256717-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: 422F3607662
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

When processing Page State Change (PSC) requests, validate the PSC buffer
against the effective size of the scratch area, which could be less than
the maximum size if the guest provided a pointer that isn't exactly at the
start of the GHCB shared buffer.

Fixes: 9b54e248d264 ("KVM: SEV: Add support to handle Page State Change VMGEXIT")
Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-10-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8577451b82b2..6e8cbae2135a 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3903,7 +3903,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct psc_hdr *hdr = &psc->hdr;
 	struct psc_entry entry_start;
-	u16 idx, idx_start, idx_end;
+	u16 idx, idx_start, idx_end, max_nr_entries;
 	int npages;
 	bool huge;
 	u64 gfn;
@@ -3913,6 +3913,19 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 		return 1;
 	}
 
+	/*
+	 * GHCB v2 requires the scratch area to reside within the GHCB itself,
+	 * and PSC requests are only supported for GHCB v2+.  Thus it should be
+	 * impossible to exceed the max PSC entry count (which is derived from
+	 * the size of the shared GHCB buffer).
+	 */
+	max_nr_entries = (sev_es->ghcb_sa_len - sizeof(struct psc_hdr)) /
+			 sizeof(struct psc_entry);
+	if (WARN_ON_ONCE(max_nr_entries > VMGEXIT_PSC_MAX_COUNT)) {
+		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
+		return 1;
+	}
+
 next_range:
 	/* There should be no other PSCs in-flight at this point. */
 	if (WARN_ON_ONCE(svm->sev_es.psc_inflight)) {
@@ -3928,7 +3941,7 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	idx_start = hdr->cur_entry;
 	idx_end = hdr->end_entry;
 
-	if (idx_end >= VMGEXIT_PSC_MAX_COUNT) {
+	if (idx_end >= max_nr_entries) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
 		return 1;
 	}
-- 
2.54.0


