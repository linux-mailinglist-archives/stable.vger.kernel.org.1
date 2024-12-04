Return-Path: <stable+bounces-98545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DD49E458A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED351682AE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E851F03E6;
	Wed,  4 Dec 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f00DDHx1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98A1F03C8
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343668; cv=none; b=E8sNzjYCjc83Au6+I/qd6GpbI8P16hQEa2thPmOljnQCqI9cH2wGRL9TnYPO65rjeHjVegutnUetuZeoZukidDxm1iNfP6imFacE1lrEpEdkh+9U5cDpKk5ohQfzJJg7p7DQZ5ghJNVkgVScZ+GPisbLLlPf1D+AcIluUuYKXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343668; c=relaxed/simple;
	bh=8dZRsuYu1zmtlFhenxXJ5xpljjqT5d/zc6Oc2WncoXc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kNJWSkZ/IyDKDZSM5FEl6bHk9eVfWKM3WvNbWKRvJYDiMjH0xr1Rpl5R1E3+Q1iPiIF9yOy4HpGVNHV0D5/NYNmk2FbAs0qUqr0UXdR/LxSwhaUzxFqp6Fb+aqYlZsUR/2YO98VI2gpc/ZUyTOaEAiy5ffRwvpEFXoCZungNmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f00DDHx1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fcd0eff40cso142412a12.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343667; x=1733948467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3U+2IR4ectl1N4fqSAGYoJpdQdS/W+F/z/+40EA1a4U=;
        b=f00DDHx14lpK9jqp8sBkC1G77wWdF/qQZPNRoCwTbMBAtgbHUgc6HRstgWtL5/mbX6
         8alQ1ao2A6q4QiJZonHURN0FQehvnq+ssz8KoMa9f30ArDDPcWLqtFsr4pAf21AAnjGs
         IEz9+wwcqAtbnhplLD5rd4quKLeCavN37jCnT7luJ7o+C2ddzjUVnCMPi8j1Lo+kFcze
         5eyAO3TEy+qyUweKZgwfMldYYCkfDTGrpV7x9v+hAKscLspD+BcpgKypuCq1C6M87jqr
         qYvWAiOM5X5bumAAxNW2hvabOC2jBgvIXSFvo4wrlbhnOoGy2taHuFgIIPnJ5gZ+9yJg
         wftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343667; x=1733948467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3U+2IR4ectl1N4fqSAGYoJpdQdS/W+F/z/+40EA1a4U=;
        b=Wy4gAotcMzJdvVCmytLEqcIrVMA5Rq13ySm5wmXJUkQmBYA4s6nkF0XdpgK80IFhDW
         a9R4Zf2Rogr4cj9FaAT3P+xpQi0EESQSi5XjgGKHBFqYZPufixq9YOERSLQpqMb8a2h8
         0cHceJaFW+hvvlXpO8YsQR4AGga6Ef+j+3RwfpFaD+zgQ3JRi6gy76WwthZ9mOdH2u9P
         DBSeT23GheqqMfA183VayI5VNdzmz9JS/xLMbjwDe6dk8A0tDVu6LLp1Nrl7GTDQzb3s
         e2BRWUM3llpsQQw6jC4s9uLKRzPGnjxlU77FGo/zNDMRsacJB4X5BKblFQA7kzWuIxEg
         m1KQ==
X-Gm-Message-State: AOJu0YyKGqN6cKFPvB1UdGFYm34qJ8VvIAcGWHPqbEpXl3ehJHK3sHop
	SFfxhg3jQ3llSkrENgn3mlzUhCJ1rQNF4BorA2ZMNqbantieVznQPzMlxcoCYKedxwFL6Y95N+O
	i1vGqgU1pDMmeQj8rmbtnOJXJZcOViIM8rg5QhNP6nXJO+UIARKkvdXrzoOdgsPyGazO4pk3362
	5H3xXAnlElUDHHh35sKlkDcy+ZNN72rJedpc9cQknBAwUSQbJc/UAUhMGPjKw=
X-Google-Smtp-Source: AGHT+IERhRgCmQ1YM2zxJYcuekBoWdqTx9OaLwB5hK9+78Knaqg7pfbtv+0GGgMW+lfqPoezSYdgKlY5uRCXtmCFxw==
X-Received: from pfbcw27.prod.google.com ([2002:a05:6a00:451b:b0:725:325e:59d5])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6da6:b0:1db:de98:28fd with SMTP id adf61e73a8af0-1e16bef0ab0mr9517613637.37.1733343666661;
 Wed, 04 Dec 2024 12:21:06 -0800 (PST)
Date: Wed,  4 Dec 2024 12:20:37 -0800
In-Reply-To: <20241204202038.2714140-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202038.2714140-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202038.2714140-2-jingzhangos@google.com>
Subject: [PATCH 4.19.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
From: Jing Zhang <jingzhangos@google.com>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Kunkun Jiang <jiangkunkun@huawei.com>, Shusen Li <lishusen2@huawei.com>, 
	Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kunkun Jiang <jiangkunkun@huawei.com>

commit e9649129d33dca561305fc590a7c4ba8c3e5675a upstream.

vgic_its_save_device_tables will traverse its->device_list to
save DTE for each device. vgic_its_restore_device_tables will
traverse each entry of device table and check if it is valid.
Restore if valid.

But when MAPD unmaps a device, it does not invalidate the
corresponding DTE. In the scenario of continuous saves
and restores, there may be a situation where a device's DTE
is not saved but is restored. This is unreasonable and may
cause restore to fail. This patch clears the corresponding
DTE when MAPD unmaps a device.

Cc: stable@vger.kernel.org
Fixes: 57a9a117154c ("KVM: arm64: vgic-its: Device table save/restore")
Co-developed-by: Shusen Li <lishusen2@huawei.com>
Signed-off-by: Shusen Li <lishusen2@huawei.com>
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
[Jing: Update with entry write helper]
Signed-off-by: Jing Zhang <jingzhangos@google.com>
Link: https://lore.kernel.org/r/20241107214137.428439-5-jingzhangos@google.com
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 virt/kvm/arm/vgic/vgic-its.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 7fcf903fa5b0..a7895be3866d 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1038,9 +1038,11 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	bool valid = its_cmd_get_validbit(its_cmd);
 	u8 num_eventid_bits = its_cmd_get_size(its_cmd);
 	gpa_t itt_addr = its_cmd_get_ittaddr(its_cmd);
+	int dte_esz = vgic_its_get_abi(its)->dte_esz;
 	struct its_device *device;
+	gpa_t gpa;
 
-	if (!vgic_its_check_id(its, its->baser_device_table, device_id, NULL))
+	if (!vgic_its_check_id(its, its->baser_device_table, device_id, &gpa))
 		return E_ITS_MAPD_DEVICE_OOR;
 
 	if (valid && num_eventid_bits > VITS_TYPER_IDBITS)
@@ -1061,7 +1063,7 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	 * is an error, so we are done in any case.
 	 */
 	if (!valid)
-		return 0;
+		return vgic_its_write_entry_lock(its, gpa, 0, dte_esz);
 
 	device = vgic_its_alloc_device(its, device_id, itt_addr,
 				       num_eventid_bits);
-- 
2.47.0.338.g60cca15819-goog


