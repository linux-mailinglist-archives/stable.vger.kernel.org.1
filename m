Return-Path: <stable+bounces-98554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888C9E459D
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 21:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A8D280D6C
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC21F5409;
	Wed,  4 Dec 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKSxe9P9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840581F03C8
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343826; cv=none; b=QEO/ln9q5ay1QeQUw7zd8scSghGfxSGbuxOUdKdszEeIBVywf/9ssu6OR/yLSIFEdAFDl56MYVhNLiRumSum9cRoXlplYP8cJouPmS6Owq6EdzQuv0QEFmzittgKo2PyzlqKgX2PIQZIQ7pFvkvr04Kf/YcN9gAy//PbCAtcHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343826; c=relaxed/simple;
	bh=fEr7Re5mBkXhYIuk1omBLNvCsaNSYYkVYPunw9Obucg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lw+ETwA64eqzNj+lOZ7GroDGIGjVVJMqQAm2pDHM5DjavfWAWIJlBOau3VKS6joSdUFXxwGfEdFaFUmsr/OTdcQAim+iOHvjTRPG/BhizpP92U590jUVUbDq8qxen/2RbLmGVxexd54eo26eQY/Svbl1o7WBL2s2tUxq5YtsmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKSxe9P9; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jingzhangos.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-724f1b16bf8so226945b3a.2
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 12:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733343825; x=1733948625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c52XtLQ3+Z2TbzJJOWyGvFukDF9iTbt/2z2Ht0baPSo=;
        b=hKSxe9P9iKTQYWERjRk3ltjUFI3dqmmZeXqqJeGUb6gSyuonzPjcQttScNALt3tQUJ
         95yj5oHBPigDHrP5RTHjl8tZMA74rir+iHLac3y3dzppdGs+/UZh7oohrPuG8VKAW8+9
         U1KJ7zsWltLi+W1LV7Dnf2Ijku5QDxzJq7i3/Aw1FsPY29KqbH0Z80zjL+Q43QmQ7LJj
         9XbN5xQbbMknkgTwk1tn6rQwrqYvK8C8kVg1EN9i9VpUUzp0dwcGVhGWRl1/+iw0rAWr
         7jbAj3KQmq1irwbwgZE2jmXr5FLc2Vh7L4to6z+Ed0whamfSYQB/so0ttP1Rn8hWFPT7
         H2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733343825; x=1733948625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c52XtLQ3+Z2TbzJJOWyGvFukDF9iTbt/2z2Ht0baPSo=;
        b=glVxgUGejObU+NQ7sdBu5Ph8qca8AnGpJG6FweYR++ehVBG5CyJD+Y0uqY4EYyKiCW
         +qsZ9yLAfmKHIHSvT8RxNV9jgWWyitvHKYFa41qKf/caZkFtTZwIfFTj1kje5guHzHUV
         56Nxox8kYA28hbl8hEHAcN1K+oDgjTPEdd88QGp+NwerwhIej0ZeTmI+xVdedUDaaVwq
         jcZTJaXJ/a537CwXMw0dNKBv2WE+jE6LlaZDqPkkhMtA+/e5qvRWTPmpXs6U2Askgpz7
         +E1F7J6DXvJUMqkbPiQD/hjoROs9Ys+BBCbluKje68kr6dpuYYM9gZjHQ6Xq/b4t+TY1
         bYLw==
X-Gm-Message-State: AOJu0Ywj3fKPVHDAXwtvSvqJksI3mPDhpVdAXoM3gATJfe2AzYa9O4lh
	zAZxPz78Vmt/Wi6dCXmS09EFkMUUNVgqzParFeC3WB2gXYFczHNMwV2lXgRwxUikqp9Etq8WocL
	hok/fxeGq6eAyjLjV0Nuy8lOmUPkLgokDFVlu3yDT71ZUP1l0oiO1Fm/AsO8cm0OOTA2IVFSzRD
	sn7W8o/PFsNHRfVeXtTZsc/mt3mRTqVkT5TkIwelsnhHDlwZDoL2bXsAzSFAY=
X-Google-Smtp-Source: AGHT+IHennTz75ChdPMO2um3rd+PN+M7S6mGuW4FHgqqjQUylbskVBkSPFIQumI35UsdQIkptE7IMKLzViFSBEF6Ww==
X-Received: from pfbbw14.prod.google.com ([2002:a05:6a00:408e:b0:720:426b:45fb])
 (user=jingzhangos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:a15:b0:724:e506:5e4e with SMTP id d2e1a72fcca58-7257fcc3ed5mr10930389b3a.25.1733343824755;
 Wed, 04 Dec 2024 12:23:44 -0800 (PST)
Date: Wed,  4 Dec 2024 12:23:39 -0800
In-Reply-To: <20241204202340.2717420-1-jingzhangos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241204202340.2717420-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204202340.2717420-2-jingzhangos@google.com>
Subject: [PATCH 5.15.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
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
index bff7c49dfda5..e1b2bbfe1fef 100644
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


