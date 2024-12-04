Return-Path: <stable+bounces-98557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E98E9E45A0
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A53F2811D1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163541F540A;
	Wed,  4 Dec 2024 20:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucwqyprZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA21F03CD
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343843; cv=none; b=qH0g/N9K0KOCZ6i9urVAeQanPcxrCQOiw3oa2Hy7rJAi9U0R4mrelHDTe7kSjcduQ09mS9RnCdYy15r7FizAoa8bkyrlS4ZA26/AQdjamWdfIv0owxrA/EA5rQ8auS+FL0ilTwfix61MSUJZ+GQn94ajlCmfyrd7IgyHwJUVBhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343843; c=relaxed/simple;
	bh=DnaJnsp6a9GG0PCix2hVjXGspGLBp5oKo1nt8BHlpLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UfNhbC7Uy0Xaj1LOVP/RDUEq+u7927W4GQDM4SQ4OYEgjh1l/uaYhhjMQefwUPz/xMN7pZ+xFLNdmoluujFcrhTdl5jRZ6UDg5gddCI2PWZbiGdAFkNtDtIpSQKCR5BLhPPjOofaRvhkSh8+j7feum/P5mftAFE7KG74yMgjHRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ucwqyprZ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724e7c48678so177822b3a.1
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343842; x=1733948642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Go/+G4taq9inK40OpGWphjixtCAL2cvGQGjkiyS65M=;
        b=ucwqyprZm4sorRMQsVEotsX4W/cTEA64qt5QguT9Y/nXe6e1biZrs4JYkcWkT20Bz4
         CIpmzMVvFBR6TxhLVlJvyUK8FBlV2O8HjTinrpLFManVpQmk85nCCuOAxETXQInza1ap
         j5t1CzHdas7R+GG9bx4Cy0B46O3VpkJYzq9bQsMCrY6a8DOaUCk8G1Ry0Xs9LObe5QCU
         1Ukcd+3dZkFJL3icYR5jfScnY+6YvT8hmoTcvPvpS7MTPFQ8Qcwesx6ngdcEriQpesXR
         g31c9Ss7MiCx2jziy14C6Lf81K54KDAMERenatJH2CEJoCXtRi/G7Bn5ZgwohEpIGBYn
         ig/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343842; x=1733948642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Go/+G4taq9inK40OpGWphjixtCAL2cvGQGjkiyS65M=;
        b=Ovc2/36fSgQftEDakdfyahp2W6BY0lXvj7IuH/BGbet94dMDz2Npu0+tg/fLRsp8ck
         ayBl/ni/4Ww5UjFL/81lqeidbIvCCsF2q92xgLm9OQNYaqpq/htSy6yvnTNnoS46DbVU
         qpLeLOcuQ4Br5iKyx7CiQWw+2RB9WJ+jJ4jmUtOU6eVtX/zrpbrdPzDfRcI+PLCAjJ5h
         RMGmlm+gWB7T3+G1oOn1yC5jtiWheiK5cNaOdwNeqdA2ESCTFyeyknmk3XwV0IToTQZY
         OVihZbCGLJlsCjIr8c3Qy0Fa+S+WTOOYEw4aCm14Ffcu3TDmQiL4j72HbpiuycxeZPAm
         d+vg==
X-Gm-Message-State: AOJu0YzzL90BDJhXVacgujf4dWYBapDsn7uJdJoPWKG+4mnbZYegDNt4
	tItdoFfk1b9XWbOImrNbolaKqsseh9SPJk9Yw9Oh75SVP9CAkzoENqneBeBt3v5Q/uggDqb20a8
	RmeS5iYl1Ed9uofJuWqER/r8l2GXVYkaCs1abrk4Xtr5SRjqaNrt9xNGPPLZAGoPzWSyPwRqCKz
	i1RsmsxisnFOxfy28ytacjILwbVvdK36btL+Ujs/r3BK4/UK/1ZwkctY2oiSU=
X-Google-Smtp-Source: AGHT+IFVGl9GqTmMgN0cCF9ZtjPrzXeJxJ50AmlyI9JX157YbehKoH/6mRlWGnyptjwrCLsKk9UKl5USUhLPwTonng==
X-Received: from pfbch8.prod.google.com ([2002:a05:6a00:2888:b0:724:c2af:f58b])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1252:b0:725:41b3:8421 with SMTP id d2e1a72fcca58-7259d587434mr1235051b3a.1.1733343841916;
 Wed, 04 Dec 2024 12:24:01 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:56 -0800
In-Reply-To: <20241204202357.2718096-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202357.2718096-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202357.2718096-2-jingzhangos@google.com>
Subject: [PATCH 6.1.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
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
index 84499545bd8d..7a1569b9d10e 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1211,9 +1211,11 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
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
@@ -1234,7 +1236,7 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	 * is an error, so we are done in any case.
 	 */
 	if (!valid)
-		return 0;
+		return vgic_its_write_entry_lock(its, gpa, 0, dte_esz);
 
 	device = vgic_its_alloc_device(its, device_id, itt_addr,
 				       num_eventid_bits);
-- 
2.47.0.338.g60cca15819-goog


