Return-Path: <stable+bounces-256716-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MADIFoLdGWo4zggAu9opvQ
	(envelope-from <stable+bounces-256716-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:40:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3D2607641
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 20:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8806C306F8A7
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E8B43CEC3;
	Fri, 29 May 2026 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Upz+3qUr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI3FInmS"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41669423146
	for <stable@vger.kernel.org>; Fri, 29 May 2026 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079778; cv=none; b=CfZmWfppAPgIe9jsCcZITReR5jlp4Vt355OWB9MKT2oWR7MjWB0zHBww583v6BMykW6QOpLitJwQ2/lqeZxJj0WWVG5vbJPN2gqRbfvgMlqSZTjksG5DiIMtwSc5w+gpX1zczMqmqVKJArFnP/Pmp+7KW2sIutrLbb/vfee8bwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079778; c=relaxed/simple;
	bh=tQ9+tE+DbULo1I89vDeIy9JMoLMUcQfgtStrqd9V650=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m3tAomJeoBGToPihwOn0N7YskcevW8GE4yfQU+DBt0wIpnRGm4tCcQVp/SgBnUK5XyFDLx72ZRo4qRivtLnjVmoDLwm3u+7qpikp7X/8KIyXqU2tQjoYu3wjd5J8ybMKfOCrNN6K5RhFM5KLYpbHVALS3ieB7g6An7Kct+R5/kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Upz+3qUr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI3FInmS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R0u/shZrwVj4PqbRgkkyXanK2+FAoAVtVPTTfQ581C8=;
	b=Upz+3qUru6L6HTlgRck3piMjRoIw1Kn97ZuA/DXiqVHvqYi25HarQlBQegJNL1OKH0031M
	pJWqmlGU/kXkGvRtJ+40Reb/yz/ZXnRigV9jfucPj62tFuKprh2Dof2B97nrs7Angi3/xR
	2h1TSwMEQtuE6PIWzVqet9J+Zxv8OY0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-7YMCXN-nM6-4k1CeX8iJNQ-1; Fri, 29 May 2026 14:36:11 -0400
X-MC-Unique: 7YMCXN-nM6-4k1CeX8iJNQ-1
X-Mimecast-MFC-AGG-ID: 7YMCXN-nM6-4k1CeX8iJNQ_1780079771
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45eec2badc4so1168331f8f.2
        for <stable@vger.kernel.org>; Fri, 29 May 2026 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079770; x=1780684570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0u/shZrwVj4PqbRgkkyXanK2+FAoAVtVPTTfQ581C8=;
        b=gI3FInmSyyh0mZ5QbmzJOwcWEdDuLaNUuOpCUGVsiL4xWLx11BctQ0sHc4aFEDu1s8
         KclzuBNatRgS/y3UnQOwGgWmjslMhI62eBrw0tl0XYQWOzCSGa8k9dsyvcYwN2yHN+GN
         uNE2xfmeX39T2glce1gMUELLs0DbrDkinzFtfRq0KhWELDaUA5caVmqNBcHh9NE8jf0l
         a+KfD0C8Ksxpfyf882jmXRH+7+cgdQyDud7XoMhnYgrRsRPjOd/nPWJALWIuykhBsfNh
         Tx38lru3CssFg6RCNmqaPXeZB/1awxBcQB93zmFMEo4ZP/yar9Z7sylOi/JfRt5IPLFt
         hg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079770; x=1780684570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R0u/shZrwVj4PqbRgkkyXanK2+FAoAVtVPTTfQ581C8=;
        b=DmgRT2EaklcyrG83iAoj8cUow/BEduVCE0H5JWKG6p1cvwFIof1vEdpJabgSy+lFEn
         o4Db5xAG9iyXr1z9ypK5rpCHe/N7WeRg0kQQZ3YZr9eM3wC2UR9QNODc4MJ3Prt+3ykb
         yiqQSV3B4Gj/uJKNktD0Iv/YozdjT4aYvsfahgVk+ZqYs3pwDGRy2EwStRu876DMh3Jt
         DQ9mjEv9+AhakXdABCxEFwbHrYMKEs5SJ4xSd+9qdpIFsd5LPSdEX7UEvPm6ff3lnTPa
         kg8bOBJUZh8IFF5CO4WThRUGA/ks/I87f50GEIMf66Btu9YDEaOYKZA3l2HNsCBB7aNP
         TRBg==
X-Forwarded-Encrypted: i=1; AFNElJ9VWsNxDHIwJFNx883IpZYvJm3GpsrhRu3sU7p3lKrQKZE+ufDroLKFmc71SPYQvBEQ2uxG2ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYrWOwz3wBH2CTlKkisCUptfG8U6U9VPK5QtsqB9XIsC4VJXc
	DSmxzuaeTGR2BjuLEafXwQNhP1x3rfUMl4gsQf2Wltqorw3/MV7ZBgyrpb8F2vb9zoEMr4nNnHs
	ew65OEnaf89bEheoTnQ+KclLUtZvER5PXWRekjrDKRmZP0WsfomoGcRdSNP6LmBlOtQ==
X-Gm-Gg: Acq92OF3a/LZxtezAceNueT3StZd/5YVCwEbwxRICmaddbLmh7EnyiukpeOLLUKQG8P
	UmOQssHOnIJdWMvmCYindP6XKV10dgl1YGT/mrSQY+kfF4dRUDDZPvvpM+A9zrv4DJ1ZaBi39pT
	Z//yRp4tK0itOeohgQYt5R/udVZcYUob5YtvYQaoMyo4KBcnfrQFYFKSBIQnIpkJEJ2qA00i8wR
	Pg1odBktxwAlycUPKnlk4NE6/jMmHy6jSUpO8rZpQLTp1QP+HCAeNF8bUtEWGn/9kF4QGpNUj/8
	c1vm4LsDG9A3uo39CsHQMU8A0rp6H2Smauc/UadocLh3LPuCyzMR5ooB3TrStOR7flopGNPMY6E
	YZ2GompERYckc8nZhQ9soVfCFvL3YiewR0GoT54Kmhgme0u8PMSFGuXod8veGpdsHeYy8gOdeJd
	GMjrjujaNS1eJm/hlj2PUNHQiqx8rL0NE8kq9kpg==
X-Received: by 2002:a5d:698b:0:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-45ef6b3e21cmr1332771f8f.16.1780079770579;
        Fri, 29 May 2026 11:36:10 -0700 (PDT)
X-Received: by 2002:a5d:698b:0:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-45ef6b3e21cmr1332738f8f.16.1780079770148;
        Fri, 29 May 2026 11:36:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34bcc30sm5367936f8f.12.2026.05.29.11.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 08/24] KVM: SEV: Don't explicitly pass PSC buffer to snp_begin_psc()
Date: Fri, 29 May 2026 20:35:33 +0200
Message-ID: <20260529183549.1104619-9-pbonzini@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256716-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: CA3D2607641
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sean Christopherson <seanjc@google.com>

Stop explicitly passing the PSC buffer to snp_begin_psc(): it *must*
be the scratch area.  This will allow fixing a variety of bugs without
further complicating the code.

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-9-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a3e85348ace9..8577451b82b2 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3841,7 +3841,7 @@ struct psc_buffer {
 	struct psc_entry entries[];
 } __packed;
 
-static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc);
+static int snp_begin_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
@@ -3883,7 +3883,6 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct psc_buffer *psc = svm->sev_es.ghcb_sa;
 
 	if (vcpu->run->hypercall.ret) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
@@ -3893,11 +3892,13 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 	__snp_complete_one_psc(svm);
 
 	/* Handle the next range (if any). */
-	return snp_begin_psc(svm, psc);
+	return snp_begin_psc(svm);
 }
 
-static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
+static int snp_begin_psc(struct vcpu_svm *svm)
 {
+	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
+	struct psc_buffer *psc = sev_es->ghcb_sa;
 	struct psc_entry *entries = psc->entries;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct psc_hdr *hdr = &psc->hdr;
@@ -4567,7 +4568,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		if (ret)
 			break;
 
-		ret = snp_begin_psc(svm, svm->sev_es.ghcb_sa);
+		ret = snp_begin_psc(svm);
 		break;
 	case SVM_VMGEXIT_AP_CREATION:
 		ret = sev_snp_ap_creation(svm);
-- 
2.54.0


