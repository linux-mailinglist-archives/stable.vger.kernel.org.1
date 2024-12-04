Return-Path: <stable+bounces-98552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BAA9E459B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A88D161A90
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965151F540E;
	Wed,  4 Dec 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+n09/MD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F310D1F540A
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343810; cv=none; b=jZxrHKbiJPK75N962J2LwRwXZ7lTXDC0Fbpfu9+TTJ7ibEf7UAte2l9O7TZmYSMe4CO5HFVi4FMVAwTOqCE7vIIrCBJYjoJomPVNvJFYTTt1EizassujxiI5GUEJOrabsRvDKTyUH+uSttI4+I2eYjA6C+k/s7SKtX/u7iwx+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343810; c=relaxed/simple;
	bh=9pOT5Iq31OcqUJjAPBIagVwN/TRSDILL80YOUTF7cGE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lVKsLyQCLhmLbBhQ6fOnlF6uHhh8/xyuiiaT4bjnQP84/zK7x+8J09XxEJ6HChcYbwlH5Fiu5+9W+UC8INFPS6rXy9QJ562XSv0iXBhWIxhd6DxA1qpfUue0Vg0Q+aQ4sb8cQAUEDIxqcabHHXfMn+r/EDv127qDA7wuQWyE5jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+n09/MD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eaac1e95ffso167755a12.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343808; x=1733948608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HiI7F27hoOGofmPcO+KZFSgkut9JKegHYpmF/bYEILY=;
        b=K+n09/MDoVErgm3wweGvRK+7MMqhtapNcf9zM0xfL4UBKNJ4J9ZiHAPf54tWJt6n09
         Wf/4vXvKfwH0RgmIgf6U/JzvO4iMYTHc//cm7Gm/2O97eRdHbAMR1+oSzDEvL5qLjQPR
         PCuK+z6tsmFXz+yR2zWqs7sslMBhgxz6iPbkLgq+dc89xjBF88tvDBt1mI9qb85BhZJI
         y4ixfWB9PL/M0KGPhLXPYzfAf2AxjQHSLD3RTsCxZXS8xgJuXNXnbg5VvBqKCDhD6RRk
         WDYiTBFAxHiu0PCWwkiDQ1Lr+C9Cia9l8ns3EsBqMr/sydZP6u3lbIXUjTCKF9Ghl7o3
         RmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343808; x=1733948608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiI7F27hoOGofmPcO+KZFSgkut9JKegHYpmF/bYEILY=;
        b=BJmrV6f/l69bHcqL0/BAdNOF/L/IMHBdsxSDR9iOLU35IuEH8VWZZRkcW9fZCfh+aw
         km8L5KmaCZkrFwpCkKPT6163T0LR7rGRuJpgt1vj0KpQ3j/y8iMRwijPrUitoEJveIBf
         463iO9As0Gz+kpovpZaCD8X4sGJMjZvWYEwRParHxCqy+uolfTbAvpK1UmKCrDN9LmEF
         W+wYLuPmRhtYp9YfCg7p5amoJoAISZ7VkjjQJsQySxMbdRdcEmteDbd8xAa8gXSmUATp
         xh4jLhjcu1hAx0+5sPmfDPnwuc02LcDOZFbkqIFL5zuwGnMziCMg0gmcO5rXZej+EiSo
         awTg==
X-Gm-Message-State: AOJu0Yzqli0fk4IVOaG/+T/ookousq4KTAtcWAE/ASmye8C/akeD25Dw
	JO7MwrLmV6rEK2Q36hniVAqoi2lrq2GL9vGujDhm7H5Ffsxg7Ny/fbSDtvX4MkllTxMvCNmBo7f
	N2NxCIe3loC7knq1VybUq6DCCRKumSfDmHH/wRX+h6yX/ulYn8s36IY8GxjKUzN0CXJnqZDCPOm
	8yTev/qsVh0zsdokNAOiZINj3jljoO8l10YIe3f9g0hsDdCdzN9sl71p4tF+M=
X-Google-Smtp-Source: AGHT+IEYlhC4TUGanvx1ga6KeEf5l2t9TLUqYfW2w3v40wscnn6VyotzhXbnhI5eYhguErPBO8BAz2B1b/leaSzdVw==
X-Received: from pfbbw14.prod.google.com ([2002:a05:6a00:408e:b0:720:426b:45fb])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a28:b0:1db:f960:bda8 with SMTP id adf61e73a8af0-1e1653f3d25mr11368372637.34.1733343808165;
 Wed, 04 Dec 2024 12:23:28 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:18 -0800
In-Reply-To: <20241204202318.2716633-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202318.2716633-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202318.2716633-3-jingzhangos@google.com>
Subject: [PATCH 5.10.y 3/3] KVM: arm64: vgic-its: Clear ITE when DISCARD frees
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
index baee36a907d1..399f70b60dcb 100644
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


