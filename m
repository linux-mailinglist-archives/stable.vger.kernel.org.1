Return-Path: <stable+bounces-247257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDj4EVIIBmrFdwIAu9opvQ
	(envelope-from <stable+bounces-247257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:37:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1FC54562B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8CF4300952B
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE133438F;
	Thu, 14 May 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXQIOksv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995A30FF27
	for <stable@vger.kernel.org>; Thu, 14 May 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780215; cv=none; b=j8sHlacsw7zEz3nxe419LRPZwhRf6xvKhn1uurxwCFu4yTN0nUOGzCwsuzM3uPw6h6bkbDfgJdzJiL6aMrTX5YsK3tmRd3MK39o9TBsL3UwRrBRA6Y8JqDI5Av0DxSR9HtAQElruGaHwMioMzb3HOdEuHGETla1/fbSsCz9Y6sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780215; c=relaxed/simple;
	bh=G5RGhVPalTj2Mk16HxwUUdgZI4Tel7YfUCAHpPi9Ub8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZTBBB8u3x8bo9HWX+lmipAWqy9oeMzIr/IyrIBOwHU+TGC5ZzD3R1GCgsZzg8fxWIzEYyLwikYpu2xjqewDVnirEV4hT8DZ2WTbHD304nKvpbZDxkwq9sdMelPWf7ZQxsIpNynDWFuqD4aaqTAb7IsHU9pL+WNchn4Kme32lEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXQIOksv; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d7e23defbso4942412f8f.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780213; x=1779385013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KChkhZSF5dUBGW1dpwhtz2Nd2WW6tFTUrsIGPgeyre0=;
        b=AXQIOksvaBd8G+gzaIURAdzdOE7GXn1spLQ5EklMkyA0+A0shNvjvaRdpnxDuveiL8
         3pwA2JpPcF/0JZ1d/BpXSoe7fYrXajk4sNTIU7bCg/9weZFsnOVonu0h5EvEl3TJojpR
         4TQ/d7KA+iPiWwxa0DZAGueKsByZTaFzEkStOmkX6vcxABuZYxYZzZ6PFfXzgQfI7rqe
         rVzwp0BV816hmY4BauUKJVf3au9PRj2wm1sOuqaW2ZC6vT5G6MxHD73isuK05XlxNVFx
         Q4rlerUYvYc+2KPvflT+m2f0PlX3mFXVQ2pb2hXHenuinhd6U/DUZOMKIfPfeeREVOYQ
         NKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780213; x=1779385013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KChkhZSF5dUBGW1dpwhtz2Nd2WW6tFTUrsIGPgeyre0=;
        b=hPWp74z/Kgdl8RxJPc/rhScWhS9jB3bdjTwZ1Q5ExBXL8mPAJPBi9ijiTcuLAuDO/u
         UqG+3b8eYdDECErrDX1RrwLXRR9ou2sVE9pyDH1sqT5+fy6T8/xfazSQi56HHXVd5y9v
         dZu9JKtUqEkXrwtyIH2aDYv8546Izb7fVTT3okhP2EjmSOBQQaUp5QpnaIH1T4KnXF+X
         J0GBaqSji4psU+RW1qRrSgW68mF5W8XPnoL5a9aA7AbXhgz5wKA9kgivvraPWQswvlTm
         M5OKzeF5avQT9YvDZHdCm8/qCIH6KlK5NZ3qdsF9Y5xsgX5ccO982egD8nrDoa6aI/mc
         wMcw==
X-Forwarded-Encrypted: i=1; AFNElJ9epHgCvSGja0+YoNPa36ddOxtcxBZfY38UXiYIArD4YVYkVM3eujUDFgR1XXFh6NqNfYPJox0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IAqXfhRmFQ0ZvWRmCJ/Egpz04cRX4xSMo3KtCIuI5jIyA3DO
	AIYbeqpMG1kUT+q+QCQ3igVAb/HMeyzpzrL7Npwz5gykcEx5XMno3VgF
X-Gm-Gg: Acq92OGROvz2VXqQ/RD3+1JJBEhFsze36xhxP2V5csYM81pcpsR0NQKx0gPfBATBYfz
	E1cbcE0/LBzql0ZLzu/6JVzkf1xxiOg0trC1bSkZNY55EoBeIcg3H6Bf7pP3lzhhD+1j39sB7wY
	rbS6l+fW2nq1PxyTWNRiLoaEaes/BSnSKIgXKX0TMvWNxm3GpO37WlABpKhwdSZxsKxqGdFHqlN
	6vpglYYEJETvPn/p8drr0ZvFuwxlYn6hO9uc0QczUWeqw6se7aezQCeqa1tCOsv0AIZm9JoJw9g
	tG75Px+73W1sLBcPTZPAMDFgYRiCE+UiBBQ4Q0WPXYv0bP2XaKlo8E7onHePfEcg7Im85pKcgQV
	BedrSkA9k0Lh1VQ4XKovOVuu/j9divkEeNi5oFUApV1dVoTNXXEksR8QATcOLkZhRnKeoIfsY5W
	lG/5Mfjd7UbvM6jN9NRplrd2m+yPUuQpIgjvMnv/d/BJECJBNZQIHfpy8664Th
X-Received: by 2002:a05:6000:220c:b0:45b:d891:4ef1 with SMTP id ffacd0b85a97d-45e5c60497emr19791f8f.34.1778780212640;
        Thu, 14 May 2026 10:36:52 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:4f8c:d716:5699:930b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe222bsm6575063f8f.27.2026.05.14.10.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:36:52 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <ajones@ventanamicro.com>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] riscv: kvm: return SBI_ERR_FAILURE for pmu_snapshot_set_shmem OOM
Date: Thu, 14 May 2026 19:36:40 +0200
Message-ID: <20260514173642.41448-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D1FC54562B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247257-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

kvm_riscv_vcpu_pmu_snapshot_set_shmem() returned -ENOMEM from the
SBI extension handler, which caused kvm_riscv_vcpu_sbi_ecall() to
abort KVM_RUN and surface the error to userspace instead of
ompleting the ECALL with a negative SBI error in a0.
Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
handlers and kvm_sbi_ext_pmu_handler comment.

Fixes: c2f41ddbcdd7 ("RISC-V: KVM: Implement SBI PMU Snapshot feature")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index a935ed96bc17..91aa0155a420 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -453,8 +453,10 @@ int kvm_riscv_vcpu_pmu_snapshot_set_shmem(struct kvm_vcpu *vcpu, unsigned long s
 	}
 
 	kvpmu->sdata = kzalloc(snapshot_area_size, GFP_ATOMIC);
-	if (!kvpmu->sdata)
-		return -ENOMEM;
+	if (!kvpmu->sdata) {
+		sbiret = SBI_ERR_FAILURE;
+		goto out;
+	}
 
 	/* No need to check writable slot explicitly as kvm_vcpu_write_guest does it internally */
 	if (kvm_vcpu_write_guest(vcpu, saddr, kvpmu->sdata, snapshot_area_size)) {
-- 
2.43.0


