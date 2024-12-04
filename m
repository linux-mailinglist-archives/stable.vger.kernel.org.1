Return-Path: <stable+bounces-98555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7827A9E459E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CB7164520
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60F1F540E;
	Wed,  4 Dec 2024 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sl1X0Vt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239AF1F5403
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343828; cv=none; b=Wapu8b9HmAuYYXPAUMqGsdm9rD/4JDPFsSrV3xw0lTPhSCFx2JorfQmwzEWAIT09aM+ZN/L+Oyu5/tIoOshlhsbxa/w9t5dNjCBAXu5S8tP3sKKdw5E4QZDsnGFOsHptUb8w7vsvu6vOZj0H0Db1+LZmnASx3LvBCZoYnfD9kEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343828; c=relaxed/simple;
	bh=sjzAbvHogZfQMQ9KrY13V8NM51wdEUhPnNs9RaACGS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aQfrTGpQGCaAhYMpGX/loHsAOxUjtOeY4t6boK+O2VfPEggKZS6qhecEFDVopoNQmLhcs7mK0zo2HkwOOThNpJJTPA2lE14rZ6EzqdUDx4WC95HUinbXpsSHVWBjIWPIuZ0zTuiTd7WJr7Xp5X0ozW8B8hnyX+7y1Cj+/zcVuKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sl1X0Vt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-215699398bdso1130185ad.0
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343826; x=1733948626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LtsxPe7Uo19KCmG5tLH6s0KEhsR90pRKPlyHOv5KBv4=;
        b=1sl1X0VtmbCTpx5L10JJqxHfCcEvl8Q5D9JE11LWsA8YEIK8plMw0Et/kLpzk7SL/X
         SlccQQSqDOhtj1x0r3YoHxrkvoUVd3K5R6MVEdF4aBTN1vNx6sQU//we2DV8qXX3Da/P
         aocl0osfum12doVYZ27xmiLGcIY6ISPSlMcIca2A8aoOajxtC3RR6kkMJkAi1QhL9u7Y
         vH99WWjDyHFHGMOSbspxCKW3e/3Xe7QMsGA31HEIZ4XyUYD0wMzeQWfwdx8ea7PvRNba
         Tqx4/kb5aPZH3EI9/WgXKy7zifLpRGFGL5PJPVc7fk0sinfM17RP6p6tVMIP3S7ahsmK
         bKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343826; x=1733948626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtsxPe7Uo19KCmG5tLH6s0KEhsR90pRKPlyHOv5KBv4=;
        b=i2qFf33wQjoOO165AlFUozQYOFw/dulCKaN6i1mTB2iPeB2ZkzNGbWLDgSqmDrs++f
         wA2FMgF1kXVx3Vjs/2cmH+67JXYm/M6JS/n6vmvgxNiBf76mviDlU2eeXEmwOXN1q3Aj
         hO3191sOtHXHpy+pO7Yzs42pAZuhk6Wr5WllYGz7CerUnMRF8txDmEDwok27QcYd0a98
         gEkZDDw7z555bvZzsF+8S2+Y2gUM3wOti5FO0iZU9jgssHkmo3eosOHjKYPlKqf9PbPT
         Xu3HrKUXd5kcBJ85aVq8cgzxh7+ykWjPzcom1iFS3D2TIpNDmX/B0CyK2a2Tx3iIufQg
         wAQw==
X-Gm-Message-State: AOJu0YxxU5lxpF2WF0hxYtHI/LFWrT1bbC56jc53o+WnvkfPstcZuRAU
	kWcnwezdz6JTGBUnLk6JhXbu8vwWRJiFYDD7BdTW6bdZNacoRg0cM/qLbyhUdrtVIDDYuPb1XAD
	dBLGIW0VxFTxV8LjqPc1hX4wCAidJUKEbPYaNJa1WCay3Mzko5Fa4Mk9mwYoN2kif9cvwygy1UG
	gqHuWTxoOFLuDYC6oi+/MQ1SH3Qi+ndCVNHL7Y8mYj9kxxqxDN4JjAd/CXV40=
X-Google-Smtp-Source: AGHT+IHWvoGz5ooGXXFOYdonzDlHll1CeqIv9Iyd3hWtt9r4jUsi0U8PGLsmKbFSvVS3/qvHeAM2g0Zh22kEpKZcUA==
X-Received: from pfbbw10.prod.google.com ([2002:a05:6a00:408a:b0:725:27e9:c4e7])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e801:b0:212:996:3536 with SMTP id d9443c01a7336-215d002bc0cmr75336355ad.10.1733343826416;
 Wed, 04 Dec 2024 12:23:46 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:40 -0800
In-Reply-To: <20241204202340.2717420-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202340.2717420-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202340.2717420-3-jingzhangos@google.com>
Subject: [PATCH 5.15.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees
 an ITE
From: Jing Zhang <jingzhangos@google.com>
To: stable@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Kunkun Jiang <jiangkunkun@huawei.com>, Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Kunkun Jiang <jiangkunkun@huawei.com>

commit 7602ffd1d5e8927fadd5187cb4aed2fdc9c47143 upstream.

When DISCARD frees an ITE, it does not invalidate the
corresponding ITE. In the scenario of continuous saves and
restores, there may be a situation where an ITE is not saved
but is restored. This is unreasonable and may cause restore
to fail. This patch clears the corresponding ITE when DISCARD
frees an ITE.

Cc: stable@vger.kernel.org
Fixes: eff484e0298d ("KVM: arm64: vgic-its: ITT save and restore")
Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
[Jing: Update with entry write helper]
Signed-off-by: Jing Zhang <jingzhangos@google.com>
Link: https://lore.kernel.org/r/20241107214137.428439-6-jingzhangos@google.com
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/kvm/vgic/vgic-its.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index e1b2bbfe1fef..4890131c87ef 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -855,6 +855,9 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 
 	ite = find_ite(its, device_id, event_id);
 	if (ite && its_is_collection_mapped(ite->collection)) {
+		struct its_device *device = find_its_device(its, device_id);
+		int ite_esz = vgic_its_get_abi(its)->ite_esz;
+		gpa_t gpa = device->itt_addr + ite->event_id * ite_esz;
 		/*
 		 * Though the spec talks about removing the pending state, we
 		 * don't bother here since we clear the ITTE anyway and the
@@ -863,7 +866,8 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 		vgic_its_invalidate_cache(kvm);
 
 		its_free_ite(kvm, ite);
-		return 0;
+
+		return vgic_its_write_entry_lock(its, gpa, 0, ite_esz);
 	}
 
 	return E_ITS_DISCARD_UNMAPPED_INTERRUPT;
-- 
2.47.0.338.g60cca15819-goog


