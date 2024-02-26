Return-Path: <stable+bounces-23763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C3A868341
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FC01C24C13
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D703131727;
	Mon, 26 Feb 2024 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G8RVPAyz"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC28C131754
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 21:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708983523; cv=none; b=MLEswTQnpI/EuiqgZfUFmeqoYm1q/rxAZmt83dH5k3O4QjwHTEtbouYdg8Jfa+WQ2AujhhAtAmSU37tDmyFXDd3XTi9gXSyXEwnQv9HQDRdBeLD7bJ/r7/5rXY8XBf/kOuA1MmT38R/drKSm1TvLquYAWx3ycDBnCS8JF3NGMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708983523; c=relaxed/simple;
	bh=SALhXXnd5vWQ9jUC3MSSLS58dVzbuNv4UfJez2X8g7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hz7OVDlZPbfWefR4MJrSNY/Id2fCIX6NiHf1rGUVR9HYIQ76yFVU3yGT2H+8FFnEr3MZploKIk+aPd/75MCBqBrntP4GTgRHJUGjJJHXSuBL1kv/e0aMP3gQRfGOdMa8EvEaOJCp7cyI/dlqte6blK4pjlh8aNSl0qkeA6JbhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G8RVPAyz; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708983519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3SoWUF8jq+V+xL953mR2si44AzQz800VUcWkZt763yU=;
	b=G8RVPAyzJ6U0267hvOziMVnMx1npYv6mwSDG44GK5Hqi1I5f2VUzkVPUlYRQ9nfaig4Q4C
	koG83/cfLeZjC8UXddyQ0u2CNgVlaygIZt+UZk9q90W5hD+uPfXfWDCPgcM1yHkc2+qdRN
	NcqXVQVrX0Jb0xNi/KkZ56hEk54TduU=
From: Oliver Upton <oliver.upton@linux.dev>
To: stable@vger.kernel.org
Cc: maz@kernel.org,
	gregkh@linuxfoundation.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 4.19.y 2/2] KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
Date: Mon, 26 Feb 2024 21:38:22 +0000
Message-ID: <20240226213822.1228736-3-oliver.upton@linux.dev>
In-Reply-To: <20240226213822.1228736-1-oliver.upton@linux.dev>
References: <20240226213822.1228736-1-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

commit 85a71ee9a0700f6c18862ef3b0011ed9dad99aca upstream.

It is possible that an LPI mapped in a different ITS gets unmapped while
handling the MOVALL command. If that is the case, there is no state that
can be migrated to the destination. Silently ignore it and continue
migrating other LPIs.

Cc: stable@vger.kernel.org
Fixes: ff9c114394aa ("KVM: arm/arm64: GICv4: Handle MOVALL applied to a vPE")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20240221092732.4126848-3-oliver.upton@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/vgic/vgic-its.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 30d1809f720b..2fb26bd3106e 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1232,6 +1232,8 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 
 	for (i = 0; i < irq_count; i++) {
 		irq = vgic_get_irq(kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
 
 		update_affinity(irq, vcpu2);
 
-- 
2.44.0.rc1.240.g4c46232300-goog


