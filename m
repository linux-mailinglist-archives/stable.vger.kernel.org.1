Return-Path: <stable+bounces-98551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1609E459A
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AECF2811B0
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDD31F03CD;
	Wed,  4 Dec 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bcm68+S9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90D1C3BF5
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343808; cv=none; b=lBbHBZMlvkOHGYOdBrBAqMK39C8qblICKohrAnFSyNUvdzsXezueYcAStC1RMdD+LI11Iy9KCr993ka0eTgpswjhVdCqnI4GA70kqQPWeuHmTePqSe5+xdB22gRmNwY8t4gxlvnW5/CY5qcNGet/hchkppTVggq4TFdjJ1Txt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343808; c=relaxed/simple;
	bh=1cRq1bTDWam/DSH7uVsi0GqSW/HivMGub22eXa5AHK4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JP2Uv3GnlPNMLY8tXKScEMg3I7vL+ZfeCz2sVMmDZFoGT/bvq+4dGqoDlI4ElwlgyHAlSw2Wi2U2aik/3a1DOROt83Vt8agN02oVhbT+Sa2IBZ5gDBVqBMEWs7hcE9nJECbIfHwnd8lRzBe+wbF+6HYv5KXpzr/HGvmC+y9fi1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bcm68+S9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fc2dc586eeso143202a12.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343806; x=1733948606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F87iP7NIAS6ITcl80okrI4ayijM7cLsa2hAh8vq9ZPk=;
        b=Bcm68+S99bN0JNGt0c4B+z2dHnurM4bcvIpG4LOYrSiuv9lHxyetBsqZU36YTI1fS7
         asKkPAYyeTLJkT0QF0HCCkSxHcnS3c3kliKmi7vy6FarnA++c0F7sbzm+jOqp9ewtwf3
         FR6+fonv8PbY9kTTXp66DfvkeZ+aXnA0MHma7Hxl5/j46f8+MqLeCYwmTC/29MaCGKa2
         eq7q4Kaq99cutrH1YugN3wdqk2oGwJgZkhAqTyTZReflMU6xj4kjmU1EeDIEkdIbKjsy
         orQB5l3f6ttVb9ZTJIQTYgeBIVWtDS3aAiL/dF8vPJXDc0+4UraiftgKqD/Ts+hs6W/m
         HkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343806; x=1733948606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F87iP7NIAS6ITcl80okrI4ayijM7cLsa2hAh8vq9ZPk=;
        b=ZWRlN8zpRIUJfnEdNnTh/plIw6ZYOWhq9X1Y4Zpug48RecPv4pJkRNgy61kO5rx9go
         HKNKccw4+uALksOGgBs0t0k7qh+utNr8aQ7SA10ZSiz+bHarTiVk5S74ogROko+XAX8K
         6RGw3qZn1Ix7b8rYa9lj5hs8gX/gml1Oqphfh1qhYbTCV8UhTWS4YOiRmG1xOz7UIBxd
         lEMT02UCpHhRWIbB/e1qIo8O/bd6a15qEsqNLbNiaPFox6dMjlAQ7J9Vi/g1RDlAsoaQ
         6cH4c65lLIOriZXy8CEcvukQgcPUL41A4ufDh0AMy390SPPIvKqwP6+/a47kw2OtdfbT
         LOGg==
X-Gm-Message-State: AOJu0Yy3cYdLvZG+1hkEE75Tw4kLJf3v8qXqoyO/Z/HHaE5Qh0gm/meM
	nmGzuuEAv7oarObyZMPmJ5kUoMLEOk75QGrccWfZCRMKyhmuyMXNlUO49RomCej450CwOTyCJi3
	YMWGxMa2yDRQxj1qO8KHm3/eASJQIbP7iiJ7ND/6w7/FlU8XhXJ6dOlmo/OxX8GjAY9wA7OJQ9F
	+s4+ZCcCAYqbP5rRCgQGRCLQm0b4VFZhoCPCTFbSuh8jK1CCb5jSp7LkYbxlo=
X-Google-Smtp-Source: AGHT+IHZjgkwaLDUH/yqzljTkVCOOrWcbLCJ70Rxm+qs0SCMmKs8KDDbAm+hMZemqxlRBJ5ceSOxCBWh09GDeIr5oQ==
X-Received: from pfbcj7.prod.google.com ([2002:a05:6a00:2987:b0:71e:6f0e:472])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:788c:b0:1e0:d4c4:f734 with SMTP id adf61e73a8af0-1e1653f241cmr11350589637.34.1733343806447;
 Wed, 04 Dec 2024 12:23:26 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:17 -0800
In-Reply-To: <20241204202318.2716633-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202318.2716633-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202318.2716633-2-jingzhangos@google.com>
Subject: [PATCH 5.10.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
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
 arch/arm64/kvm/vgic/vgic-its.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index d3ea81d947b7..baee36a907d1 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1182,9 +1182,11 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
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
@@ -1205,7 +1207,7 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	 * is an error, so we are done in any case.
 	 */
 	if (!valid)
-		return 0;
+		return vgic_its_write_entry_lock(its, gpa, 0, dte_esz);
 
 	device = vgic_its_alloc_device(its, device_id, itt_addr,
 				       num_eventid_bits);
-- 
2.47.0.338.g60cca15819-goog


