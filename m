Return-Path: <stable+bounces-247258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPsGHp8IBmrFdwIAu9opvQ
	(envelope-from <stable+bounces-247258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:38:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D69BC545659
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BBB530773CA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027CD33120E;
	Thu, 14 May 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3cf8Mr9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DEA392C32
	for <stable@vger.kernel.org>; Thu, 14 May 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780219; cv=none; b=tLef4o/TJ6JBDzXKpaI+14W5hE6j+qJaglW2njsKT3uKej+QI0WfXXBGCXhGnb0zCw3gimPkCE3VQqNjyB7mydYTt/iQCmDhn/mM1JRIZ8wnUXwGECYZPKydJ/n5F9WoWAYfecRn/2bepAiKR6UeGJUqb486ZBBf4iRK0AwgEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780219; c=relaxed/simple;
	bh=aUuQm/h/TUPimZd5XY1jIkt7LbBc2oh13i9KwiogPLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdBfxyQBH5e9FkCx+BEWLU47WAbEqHASLBBSLejo37K8g8GER3h+57Hc1tv5flTtXgUeB5glXGkHphi6DGt7/3J8sx2J9zcJB8gExZpa2OMBxrH+ZPnaeb9Tp5PJqty7mdksQ+dv+3nPZWmW2oZTnewPy37nXalpmIjET2oJpT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3cf8Mr9; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so4419224f8f.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780215; x=1779385015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzOXpklejgsU43guiJHt9ocv4/DBH4gkj5ecH1UKTFA=;
        b=C3cf8Mr9DrGbRgUehJA+1QjDMcn8P4alN5mTj8TU2IR05gSJb5ZN98PcNirz5jsMIE
         BdaqQ75kMsWaITXo6Fk3bo7+Wlbe83aYZuhRTvrmkjyqQM+MVsxDlCicBROwvLSukEjF
         yEImuGaepOmXK9kBEKHv+9hArql47rj4uM99FmWR3khpyBG5nCwpY+M0QCBo9UZR7kav
         6ccs6PheILKXHLVOnk+1tah+Uo2Y5rbRIsLOmNsktym/t775CE61uYZ+k30EdnIp/BiT
         IRb+15GPUi8vgV8DFwpYm8eRk11wGlTOm8nPyL7qb+sPOkp2etYvjUBoIFb9oew1LBlC
         9msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780215; x=1779385015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mzOXpklejgsU43guiJHt9ocv4/DBH4gkj5ecH1UKTFA=;
        b=Qv5zOjhVppzgNMim/ZudGQDynr078Wv/Z4gG4ghjzbE5xEqpdWX+1+a3LLHyJrYTNc
         W6P5dbhpDZ5jcKu9G3JUlib0fm4igSvPRF7nSpXcT86vHGRGBP47JCJTM07ZIl2FTm+g
         70gQOC3EB5PR5eqTgcW/hyozV9MAZMbUdex+KWRB7PmgBLV2D/rgWnqi9NS9iznSaTuz
         V89iph5mBgySGH5QDOI/UyCOaCp9QhBxgey3VqU4ZAxbZsd5mHafwADxvHhvfNJVBCci
         Akge7gFPXHVwa6IV552YsyRTi/LVFAl1C5IRq7ul10Pd+zcgWl+Yd0zx0LIQqpr+jid3
         V0Fg==
X-Forwarded-Encrypted: i=1; AFNElJ+G5/R7dna/ooEu4B1fzu294HhXfxQ/M6X/jse6FuH+zcnSAFMkAn1DWmb+8GaQaesiZNWl0a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylDL9A7rq1DCRlaupoPcepzBVVEGi1FZPMWoWPchVF8rsXO2Gm
	9WU3SQ2duUNQsLE2kZPbRJcgP7RxheLh+EOE3uIHVA8/sYksC3U/RfWY
X-Gm-Gg: Acq92OHfagQJaiPM7rJbtdQyu1sxPiVUeFUyzWWfeum9AbLobjsFcSAgiKqU89wanBm
	HF9K9rsSPha5XLIJDu6F0wWHxYI3IZjHrodNzkiDR2mlrz0fOOvNHifJa05vd9g0ioSjyMIOoA3
	5CX0W+jhLMy53fn8Y7d5a91wey4UqiR45b7NKZe2mMkq00uLoOvz00ExknIinxEJUkbJ2E/2OXO
	CjreYW/h95uNoV2ceS0QMsCNvdezyYVhf/VKzLUl0RaWLGN5xn3i1dFAmWhbxoaIxcS6MfJjlph
	cRWCjX6aqmIBaG+Lk/5wf66TUYus5xHMy6wlMApZ2viKdwvSqIgEP5m42D09DmfUlhSu/dLTgwD
	UpyWn6AbwpkoKB2el9vx+WoQQgrVkG0+7IaUcGwPZgnOElL65euO7FlBBlzEpMZnzoeumd8QlHV
	IpfixY4mahx0pQSpxvZ0v9hCeuClm8hRQRU9THnW1/0UlDN1T91pueuHYIDKEA
X-Received: by 2002:a05:6000:2f83:b0:43d:7883:87ce with SMTP id ffacd0b85a97d-45e5c595a6fmr80251f8f.34.1778780215294;
        Thu, 14 May 2026 10:36:55 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:4f8c:d716:5699:930b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe222bsm6575063f8f.27.2026.05.14.10.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:36:54 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] riscv: kvm: return SBI_ERR_FAILURE for pmu_event_info OOM
Date: Thu, 14 May 2026 19:36:41 +0200
Message-ID: <20260514173642.41448-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514173642.41448-1-osama.abdelkader@gmail.com>
References: <20260514173642.41448-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D69BC545659
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
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247258-lists,stable=lfdr.de];
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

kvm_riscv_vcpu_pmu_event_info() returned -ENOMEM from the
SBI extension handler, which caused kvm_riscv_vcpu_sbi_ecall()
to abort KVM_RUN and surface the error to userspace instead of
completing the ECALL with a negative SBI error in a0.
Use SBI_ERR_FAILURE and the normal retdata path, matching other PMU
handlers and kvm_sbi_ext_pmu_handler comment.

Fixes: e309fd113b9f ("RISC-V: KVM: Implement get event info function")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 91aa0155a420..bb46dcbfb24d 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -501,8 +501,10 @@ int kvm_riscv_vcpu_pmu_event_info(struct kvm_vcpu *vcpu, unsigned long saddr_low
 	}
 
 	einfo = kzalloc(shmem_size, GFP_KERNEL);
-	if (!einfo)
-		return -ENOMEM;
+	if (!einfo) {
+		ret = SBI_ERR_FAILURE;
+		goto out;
+	}
 
 	ret = kvm_vcpu_read_guest(vcpu, shmem, einfo, shmem_size);
 	if (ret) {
-- 
2.43.0


