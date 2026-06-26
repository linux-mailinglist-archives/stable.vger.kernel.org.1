Return-Path: <stable+bounces-268827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ysyrHv9hPmrjEwkAu9opvQ
	(envelope-from <stable+bounces-268827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:26:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A686CC6BC
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 13:26:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=hG9H+B52;
	dkim=pass header.d=redhat.com header.s=google header.b=I6sqm5YS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268827-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268827-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F6233086350
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF85A3F39CF;
	Fri, 26 Jun 2026 11:26:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC923E5A11
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473175; cv=none; b=h6tzAt0lnYX2bJeepJ+KBSmLPGndd3v4lbqW0Vd+ZDLOhhF+JcC6d/rtiEdL6mlLsxojigJeRrAKSpRaOPofXOIjNWwGEs6lyzhIUrzqozZfSm5b92sISktyyCrkb4jeZgqxNqBw5XFNEMX9q5SToTY/1OUTqDcl3LyywcOEpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473175; c=relaxed/simple;
	bh=/YwwEQLmxSbJMl1fdqSKJOWSf27TYniYxmWG9YBC5ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezkpuUGWLt+Lk4UKEURATZ0Ej7w0owvvyZ/khzLsdIgPu26/YWn904eakX7RJdGteAxNUCmIK1Y3bblwfD7bpUfKknavcmrmCPl5yMVtUTgpTNIZsgR0qiF9+AzsRW7zLFucS7nf7Rd3u9Q6kBLW3boPit3ow876n6ON2d7H1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hG9H+B52; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6sqm5YS; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
	b=hG9H+B52dQ8Cg43BhQTgkXXWmu2sztMNZJ0JsdpxgfkL9wAJt4xLBJYBaPoEvMO1wkgP5O
	AGZSpZ0W1VzZ0Bxrco9rwaUngOmTAnXHzzbgzMeOyYKtL75zPveL/DLFowQSSf9hMVTMKY
	IxKPNDdMOzB1oaA5WoAtgpzfGKyfOcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-kKiVSMGrPwuCVj8KeKKwXA-1; Fri, 26 Jun 2026 07:26:11 -0400
X-MC-Unique: kKiVSMGrPwuCVj8KeKKwXA-1
X-Mimecast-MFC-AGG-ID: kKiVSMGrPwuCVj8KeKKwXA_1782473170
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49260d6eaadso5027335e9.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473170; x=1783077970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
        b=I6sqm5YS4kVTADWM5MN+oH5JcXymFQq+OQzFQi4BWFPUWEiViBUOZG7HVW1zm5Liig
         3UY2OyjZcyF3iOxEvQTy7i16Z+6z65UWQG2FWnTgAoflgoPk04vu5lEC2TCpIKHoD4JJ
         GUmNd8yggmTkbU0w6Jj0jZX9mkh1dsOJ/dwaxWC3mJCTOx9SAXrZpLTyJgB2C1noAGrt
         c7ENvJWYyxKc3pR0Mjh2NEvDhRpo3/Jp3AH885NiDdA2DW+9DTz/Z4CMT1UUQcxS/ovj
         NqzH15CyU5cWhOf0GLsL5C2Y417OrSd7eSHGp8dLzKLIRHj5/HETaZY2KoDJj8PugVSR
         BP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473170; x=1783077970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
        b=SwWjXQKWrBoLKO6qDKHIK3ZHkAp3pbhI6NT26l1xg6Msjods0eqc4cAi0h99+gkbOo
         aJi+7WSaW/59TrE3I0+l5VPrFEVAvLPJLgnM+T6XunCpz5yL3u+jv6rAktPPfquwF8Pq
         IAocBd9HGFihCklHoedrgttb1ht+9v+Ta4RvRmCsK05wehjK9blUBczx24x9v31eHIs2
         eoYsnyqrpdg8MQfCbp7FwXMFu6D98NBu3uLzCdOWCAhmeL2Of24VUIVOoSl7kyeE+BHU
         2ZLLVLaaom1W1nTRvQWRPO6vUPejET/+SeBeWPCcAM12t40w9UUed+VBkH89d2vB0tAO
         VWsQ==
X-Forwarded-Encrypted: i=1; AFNElJ959I3JVw99HaVzdbBtz8GhNMFdB8ak8mbvCaOvOHD17Z4myIpjtJpX/pvjjbrL33Zz9NYBtgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBMi2p1jkpprctppNR9JuEH9q1tTv3ZVETZ2KRL7L5rpou40qG
	SqYJMsQNHSta6wKmqoonfwocMxWYNaaq9FL9t5uPdc3tpNASYrCl/39rMOFuGrCfCGInqjQWOhN
	4f3D1UlFBRG6KbEq73fYFLKDzNZvX8Gat3/vYIHmZMrP2seUzwE6g7+Z8SA==
X-Gm-Gg: AfdE7cnS7YRftKHHQ9BFV/GEF3iCdUAukOzlu94N+sM+iQQkSKEt80sjSYa+uqNxS6M
	K1s4AOpnZ/v6blzejSOWcuGbCvpI+eSad1ZVnOX5zf2KYP79X367zcpfvFNdZ3PTHnr0rxBghPr
	Dsszl/VXf8G2k2AZ/VRTOfIdrNdm16RB8JLuzb0NVD/8gXE76vrXQZy3PiC/rE+UkmIKnMnBIEO
	3Q9YRnxfY47Yu3kGNbdU9ruX8g1ZfIjiEYwHubMpTayHgqB35sVxy/X1Z0mOwejAjTumLKwo87k
	iXy/qUxT+e0mTEjl28p+ejEGFECXA7W3Wxh3ltt4bIrFtrB2HvuNja6IzMuiS8Ff6CLUohvZrV0
	gK/2fHsXjrJbEZUhkgg6PoMR/XecyQabXpUzwthMrzo8bYhwGjNM39IED+1KVa0FiEX2lt96sRZ
	v5oqZnDxFzzdIA4zb7
X-Received: by 2002:a05:600c:4455:b0:492:66f9:3bbe with SMTP id 5b1f17b1804b1-4926fc2f4a6mr5465925e9.3.1782473170474;
        Fri, 26 Jun 2026 04:26:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4455:b0:492:66f9:3bbe with SMTP id 5b1f17b1804b1-4926fc2f4a6mr5465195e9.3.1782473169939;
        Fri, 26 Jun 2026 04:26:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28673dsm44564745e9.2.2026.06.26.04.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15.y 1/8] KVM: x86/mmu: Use a bool for direct
Date: Fri, 26 Jun 2026 13:25:59 +0200
Message-ID: <20260626112606.1778248-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112606.1778248-1-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268827-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:dmatlack@google.com,m:jiangshanlai@gmail.com,m:seanjc@google.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36A686CC6BC

From: David Matlack <dmatlack@google.com>

commit 27a59d57f073f21f029df1517c2c0a1abea5b0ce upstream.

The parameter "direct" can either be true or false, and all of the
callers pass in a bool variable or true/false literal, so just use the
type bool.

No functional change intended.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-3-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e4813964bfa0..c03c4341a87f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1737,7 +1737,7 @@ static void drop_parent_pte(struct kvm_mmu_page *sp,
 	mmu_spte_clear_no_track(parent_pte);
 }
 
-static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct)
+static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, bool direct)
 {
 	struct kvm_mmu_page *sp;
 
@@ -2074,7 +2074,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     gfn_t gfn,
 					     gva_t gaddr,
 					     unsigned level,
-					     int direct,
+					     bool direct,
 					     unsigned int access)
 {
 	bool direct_mmu = vcpu->arch.mmu->direct_map;
-- 
2.54.0


