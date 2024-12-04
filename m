Return-Path: <stable+bounces-98548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9F9E4597
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F7B2811CE
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24931F5411;
	Wed,  4 Dec 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Tw3yV/s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361EA1F5409
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343788; cv=none; b=QGlJSJBt8ywbIA6D+2Duq8qJw8UpCWmCjXwzflQhbnyIMmxxju8ZwJ1JQAUm+t1BOhQyC47Gcvj4SE3qgKoQRuas2b6P0NHUXJl6vgKvhm6A3bUAvBz2XY7JAVJnZhi3de4HfvCg6bosP2rIuaCCpdsg0z3b3xjJc7GTb1cLSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343788; c=relaxed/simple;
	bh=RqOpM7Qi+EEv8s6PIA6LJfzecepQaKid+qE5Zy9UOgo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q8bCwkABhbrBqxYXg/wougnF7oB2MvdatD+9kOqPTPOxK3DnrCMV06PoekpnlN4nZ3NkYuRhCBM1fiiYKA0zQ/Qj30xLUujQnvvmluXwO8fky86ikUv5JblWRVBg+bDyADfxuTAGAJWi7yXbJULd9Hxbe7zlJCHxTop3ZJ/sJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Tw3yV/s; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724e57da443so280761b3a.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343786; x=1733948586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZdvvDkMgzs7OKJYia+LTozmIVXYEEkUBz9PhB3EEKY=;
        b=0Tw3yV/s8Sp9SQmpJ+HkfDTY4F4FuUWsUNTs9s+IFT902u7juIzuWBo/9wzzJEDAe8
         kzADutlpAHiUKiuMY26jHiaAr747wPIjIRQBnUJOqEabSvVQD9tPUPqq+zjE15P7USpB
         FvP1ynjk8y+EyT972yOPvGsq1pvelPdR1dOCHq7URHyyCeuc5mNpTLIULHKy6Nh7WPRz
         7yXi4DFzwaqJQd8BZkr3bCCX6ATt3llhWTPbvSJn4zZRo1J6Mdnfz/R3eewBO7rFObvj
         14csZK9uMxrzvcXx4xDgf90K7t72YDAbQV+H2dPvc3RllhxVjQIwLMfm9KlsyshtoqL0
         TURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343786; x=1733948586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZdvvDkMgzs7OKJYia+LTozmIVXYEEkUBz9PhB3EEKY=;
        b=gqXGOJPI+q5FMrt1jy0/Y/o1X9BGv6gPelyGZXqLGm+nSwADF0j8sl8bedmNfRTePG
         w800ZJP2RRvcC62kYFCrqyLMzBclExiHw7zxGqQZT5DFDD811UZmnyOtKuu2905RnlFJ
         bGAClEO0VkUH9n/+KA7KavrKGIIErCRj2WaSc3c/GK+Gbu1FJfURB67uoqBSKfZB2lVJ
         HaAM7Vx8i6O+ZeocAw51kOAnhtcgcPAeHuoEajkFJf/Dqspm7PinWkugSJBBbntW+ZP7
         ALmY/nxI0Pn6iVT1OrPpt32Q8VLvZqVGGX2GNDeEBBRmnRENwmA0FfyyQDtNC8VoPahE
         b3uQ==
X-Gm-Message-State: AOJu0YyHRBiE8McIkoDnLm9W9E1az+52feLTbTPlSGu0/hXDSwGcWXqW
	C76I5gGNytjZQBtvf5/JsOW9lA26moNR4EfvnQT3nTBgRwaAXU9F7NwxjDbgLByRSsJck5CQEe2
	Q+CNJse7U6CRmy0BhvZnUCqrb4EEly9dFiQuzxzck8XV6UfbgM+53L2C0t6ZJxASIxSiYfjTofn
	v+VRftC6HqmM0Q5pF+rWA+Y6cx4tgWDFSs0p+wKsVCApUc9u6WPV0jdI+7xXA=
X-Google-Smtp-Source: AGHT+IEldDIdIMOi71vz8444Ja+uk/WIsl5Pb17a544wmtjfkoDIjMX8XmVz4b8iX7/1/W9/vAp4rtSLRrCxVUs4Yg==
X-Received: from pfwy8.prod.google.com ([2002:a05:6a00:1c88:b0:724:e32d:ab5])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:80e:b0:71e:6f4d:1fa4 with SMTP id d2e1a72fcca58-7257fa611camr12684742b3a.10.1733343786323;
 Wed, 04 Dec 2024 12:23:06 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:00 -0800
In-Reply-To: <20241204202301.2715933-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202301.2715933-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202301.2715933-2-jingzhangos@google.com>
Subject: [PATCH 5.4.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
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
index f091d4c9120a..682ff15e3eb8 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1181,9 +1181,11 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
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
@@ -1204,7 +1206,7 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	 * is an error, so we are done in any case.
 	 */
 	if (!valid)
-		return 0;
+		return vgic_its_write_entry_lock(its, gpa, 0, dte_esz);
 
 	device = vgic_its_alloc_device(its, device_id, itt_addr,
 				       num_eventid_bits);
-- 
2.47.0.338.g60cca15819-goog


