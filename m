Return-Path: <stable+bounces-120445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D4A502CB
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 15:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186CE3B1158
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 14:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F40A24A067;
	Wed,  5 Mar 2025 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSAfo7+7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A51DFDAE
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186186; cv=none; b=QEJuulqKOJmbbh7//DLDL9+8qMZ44ReFmndTpfY+xxH8y5+x4uLRkb4IQQWolM87haM1cyM6szvYjnl2gDkLfIggBHSD0zhhPsrEO+gtH937mUS/sq8u68e54m0lyKhTVFlW1FlT6VAm0moq0kWgcJ9owtoBShFP6/XJc9kMOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186186; c=relaxed/simple;
	bh=x29h9M6n8nq7NdPnqRKffAT+4udR1rBlR+7/BBJPG6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCgAnPdgbHSBw9NA3BrEZjKVld4/oepNYMz5PlY0WU++kN4huWDubY5JaD943WIQTTHVAIlJHbNaaNAbJ4BDrC2OqGVW02iYVzkuiUY7RTseaGzbKeas8X35e6gUrZftFKe8mvzp8YKiM3Be2lzyP7zjKO0CmZ6yQ+91W8vdRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSAfo7+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741186183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YM84sfhKyVCM1WHnPi0ugQYCezGBxRCWusGn++RPss0=;
	b=QSAfo7+7LuRPUhfqQNWhMzhC63e5ic6X16RP/kLgOABKXcLnpapr4qkOETKZSkwgiEmxaO
	HqWxRrMjrZSOfzEAoJghQhFaA9VjcBj2GMWsKIyuig+YGv24lognoBTf+Ue908uWBOcisD
	w3RhOyE1o1mCLrcJ6VqzFhjm1KKaUb4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-6Pey5zYQNq-rSxVR1Go-2Q-1; Wed, 05 Mar 2025 09:49:41 -0500
X-MC-Unique: 6Pey5zYQNq-rSxVR1Go-2Q-1
X-Mimecast-MFC-AGG-ID: 6Pey5zYQNq-rSxVR1Go-2Q_1741186181
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390df5962e1so461236f8f.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 06:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186180; x=1741790980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YM84sfhKyVCM1WHnPi0ugQYCezGBxRCWusGn++RPss0=;
        b=JAMdqcT3a8qYPlkZoC2aECZsF4XkuvR6PV783UpHHU9jBcYz4w67RkmWMEKrcVxAlM
         zyTx/EBRxZHcnN11AVnf2vIS7ZcLyyD2J9FjHLc2ry9UtNLSMGnGUAlGXcbUgPe26l0q
         gyYR2u0/JuT9ISQcKCRtoJAwFnv6ZlUaiUphCtY/v2rJe/8rA2xe/EUK6ss4kgPUg1TH
         ZAFGPTibCAtcjMiIw4AHN9UUQVsaUMiVKE4rbJAZCgPVBaTdFCc+AZN9Z7fdgA9BAAQ/
         wJFfOn+GZWmtDHHp/8S+25YH49IYBQiuqtaZVWubvG1ZMY+0hits7mkUNFwXcNUfvfmq
         FS2A==
X-Gm-Message-State: AOJu0Yzh2lXGMwjc7wwIt1c3mYtzZ6e4vb2H2RccS+pLhppCHaaS+JHJ
	W30eHgYw18Mgd2gKm45q2zbEWQLqJ7EGCS/Alr2HIwYjRSe3b1rdbTeBIkrbFQGKb1aRuA9uF24
	zamOPTgKziD1rsQmoBaDRx3vJxnfaVZcSTiC6SY19txWGv/522kDAd5YssyRk/wH5N20=
X-Gm-Gg: ASbGncthao1S9uSHSVdZmVCxKrEIzE1BwyJpJYynOWNHlaBBc1nByWDY2y0jwxktGnm
	sNmy1PKbp8nW1Q7UdCf02ib0SoXt+6OxeUax04hsnqmoRxwgNFFsoeF0g2gWtdyyop5//niDOqt
	WjpkLs9NxO4xSyYTVEbUahyqYgg7J7OfdaEiXDForuRw4L8I2bT5DMvF+eBSqPyeyJY7zZxqCIA
	vQsxFJKiXmwMJe9FRc0yLzdOr7W30bsLzx3V90D0knSib3LOBADOOrej3zQ/Eh+1K8tDd2iGTqb
	IZkfI6e0OD9jTg+ch8wHF1KqUX3y7A8ZEFaDqjGS8W0530Q=
X-Received: by 2002:adf:e183:0:b0:391:22e2:ccd2 with SMTP id ffacd0b85a97d-39122e2d080mr1812868f8f.3.1741186180342;
        Wed, 05 Mar 2025 06:49:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpZB4BYpB9A76P4a45l7m/RU6UnuwhTcw/rRDIfT7W5uDFJhJmK1bfyR7MVaBtIvxiEQk6Ng==
X-Received: by 2002:adf:e183:0:b0:391:22e2:ccd2 with SMTP id ffacd0b85a97d-39122e2d080mr1812850f8f.3.1741186180022;
        Wed, 05 Mar 2025 06:49:40 -0800 (PST)
Received: from [192.168.224.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479609asm20954791f8f.2.2025.03.05.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:49:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.12] KVM: e500: always restore irqs
Date: Wed,  5 Mar 2025 15:49:38 +0100
Message-ID: <20250305144938.212918-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 87ecfdbc699cc95fac73291b52650283ddcf929d ]

If find_linux_pte fails, IRQs will not be restored.  This is unlikely
to happen in practice since it would have been reported as hanging
hosts, but it should of course be fixed anyway.

Cc: stable@vger.kernel.org
Reported-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/powerpc/kvm/e500_mmu_host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index c664fdec75b1..3708fa48bee9 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -481,7 +481,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		if (pte_present(pte)) {
 			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
 				MAS2_WIMGE_MASK;
-			local_irq_restore(flags);
 		} else {
 			local_irq_restore(flags);
 			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
@@ -490,8 +489,9 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 			goto out;
 		}
 	}
+	local_irq_restore(flags);
+
 	kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
-
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
 
-- 
2.48.1


