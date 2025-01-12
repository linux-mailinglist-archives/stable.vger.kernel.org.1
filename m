Return-Path: <stable+bounces-108318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E653AA0A80E
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 10:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223CA7A38D4
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 09:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C07F19F424;
	Sun, 12 Jan 2025 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyiqCQSE"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425501741D2
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736675739; cv=none; b=S5BZKzVF49wSr2X+TZQvLdgrEpvUvKeUGxpFgOVUB1fABs2GuAUVH2jk13iP4bNCZp7LjFIvPIOI3bbsq1g0livKBlZfF5irDJFFkOoekqPQjGzv6OOnFIdPY35D+ABAirBfOHRgTnypfSThkA+Las+lP5HHB4UIx81to2XV1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736675739; c=relaxed/simple;
	bh=zXt8gel/yANsANDIs5B5Mdvh1QFGb9YfZgkI8pbrooQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2XPGjF7mFZtlkit/6zOnzd5CKPvUmKidDKpHa8EpRqkeBgrLM80OYQOZYl9pZWZOXN3gyaGikWWZ8v2Wmgxg+ErWwNepwt/T0Pl8FjrHKHcufiAD7GohHJO5GP4jp/Lc4tIJG9VqZRgpMz91X1rjaGSlNFw7RlX0R3FD5KDuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MyiqCQSE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736675736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2g0sdh+W5glSkagx457PsA9cI+PMduPyER5qBCP9uo=;
	b=MyiqCQSEX9/f5RPFMIV9OXNz4JZLjEaeXiNHzT7FyJVa7aCMW4thttRvgeAr8gNTfrR2fu
	Y3bbIjE+LyEhMZiF2rHFYug+6yDgCWp8HYPgEpfUz1Wp5WbWVLkYXXi+jsXTZUuMSh0/Oc
	BheqC1ZSZiH89PfGCLX1NqY1E2eVca8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-w-p3-Q6rPYyEuiLYj7Uj0g-1; Sun, 12 Jan 2025 04:55:34 -0500
X-MC-Unique: w-p3-Q6rPYyEuiLYj7Uj0g-1
X-Mimecast-MFC-AGG-ID: w-p3-Q6rPYyEuiLYj7Uj0g
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa6a6dcf9a3so246056266b.0
        for <stable@vger.kernel.org>; Sun, 12 Jan 2025 01:55:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736675733; x=1737280533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2g0sdh+W5glSkagx457PsA9cI+PMduPyER5qBCP9uo=;
        b=wXfAex6TEtluLejldSDutuCh2W7REf+ONy0TCqiqFl5aqZ3uLac/sEix3tgvX52uDy
         fFX0rHYzkBqcMOxyyAUdISmgyF8uqDSlHQM6RZWJwc3ED6d/QmOA7dhbuDM8jCD1oQjm
         MZCbmFGIQ2qCvENsqJ3zzgoxTx1bwjuuD/nJwpRqgbImMQGSNAzt4Q1WRJ9bpCAmk65S
         bBa4/V0tpGb05I0wwGaw8s9hujkuxdNo1V7mGin2OGyxXqouD7CZHAwPQuqOYSqd9WpT
         FXGsAyPR3nIY/r3v5yVY8Y/zXu3x71BVI5junoi/Rc6UI8DLJyDi8dOuUxUPIR7qiAjF
         5rEg==
X-Forwarded-Encrypted: i=1; AJvYcCXf4bziguw35x9gINRSwZ+pSbwstvTIeqxYQ97ETZCH3lLHMcPVpqoolVy/KR5r9hW2ps7i+uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW0A6CfHaGn76PVJkOiDKUtu382z3SxQdSnVbQSAqlaU1HRsut
	S2c3G1Tef902rpSYRaoiu8QRmSqRWEwGWMDhjaShhWFDyYayYwL/mz2lkA/uPAjbJsnfuSNuJyk
	242Smkgv8m5tCaPnf/EpTS6tZvqsDu4yF3smwn7Ve6QnPSFJdsFKgMw==
X-Gm-Gg: ASbGnct3CyTTIs3+Rrum9y+xQgPC/8pJDhGE9Oxi9iT7ln9Z60bREbdoQ4BwpwNdyLA
	rVhzWp1vKWjo053z+BYd28/H4id6fiRjiydwW6kdi00WPwMNadeXJjx7/2iumijYHXpsyumHvpF
	PKGE4tpIvZc4t4/Kkc5OGRZeDzq9Tn/PFut/uShmblQtQhoeudzM6caaeUWwIGY7BoXDdjjDazt
	cOCJJXej0Yt4gi9uu5AnBlj3YkFcoArOtJGxgI+OesB/ZPEWDfaenrccJo=
X-Received: by 2002:a17:907:d1b:b0:aac:23f4:f971 with SMTP id a640c23a62f3a-ab2ab70a173mr1753855066b.33.1736675733525;
        Sun, 12 Jan 2025 01:55:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxwq3cSzmX3Sr/t/JxywDCCAqRMgXJsypEs7qUCiLJx2f+d/bQof+BQSWZDWOMCFQMp6aY9A==
X-Received: by 2002:a17:907:d1b:b0:aac:23f4:f971 with SMTP id a640c23a62f3a-ab2ab70a173mr1753853166b.33.1736675733170;
        Sun, 12 Jan 2025 01:55:33 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95647absm352956366b.118.2025.01.12.01.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 01:55:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	linuxppc-dev@lists.ozlabs.org,
	regressions@lists.linux.dev,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/5] KVM: e500: always restore irqs
Date: Sun, 12 Jan 2025 10:55:23 +0100
Message-ID: <20250112095527.434998-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112095527.434998-1-pbonzini@redhat.com>
References: <20250112095527.434998-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index e5a145b578a4..6824e8139801 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -479,7 +479,6 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 		if (pte_present(pte)) {
 			wimg = (pte_val(pte) >> PTE_WIMGE_SHIFT) &
 				MAS2_WIMGE_MASK;
-			local_irq_restore(flags);
 		} else {
 			local_irq_restore(flags);
 			pr_err_ratelimited("%s: pte not present: gfn %lx,pfn %lx\n",
@@ -488,8 +487,9 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 			goto out;
 		}
 	}
+	local_irq_restore(flags);
+
 	writable = kvmppc_e500_ref_setup(ref, gtlbe, pfn, wimg);
-
 	kvmppc_e500_setup_stlbe(&vcpu_e500->vcpu, gtlbe, tsize,
 				ref, gvaddr, stlbe);
 
-- 
2.47.1


