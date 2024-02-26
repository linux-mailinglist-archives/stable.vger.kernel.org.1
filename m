Return-Path: <stable+bounces-23770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF2868360
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 22:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DFF1F21180
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 21:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B2A131E23;
	Mon, 26 Feb 2024 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YTZLQiE1"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A013175B
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708984588; cv=none; b=nzxgocbV31D73wF3C3dtoWMOPfA4ayrALYqwySjQjDI00fXijDcuJ6UuasjVejknJaiA1H465KvYEKbOfP/d5pk8ZAhDuMsT54iX8MdDRH/6cY/N9IOB4BbJ5lkxtvAxJnv+Drq7w04tF6AOuG+V+GxcyLTCvVHtWL/8axeCrLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708984588; c=relaxed/simple;
	bh=61DZCO0edfaDK2pNxlBJ0aVNdKdrg9WguZnEXA7F3Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsdRS6KES59gH+WbOXMbWziMEh+EtY1sw0yCEiXEfL1PwblFjvd9s/+x2rpNIm5/HAxiSSqAZ/5QYVFYsoXLtHpYDEo/S3msgYNNo1eJGlwdbzEe7vXIfSDLSss3P8ZIPeH6IO//6kA7imYgLvqVBs5tGJi+Ee18RnQPbnv8WTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YTZLQiE1; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708984584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnZBp/7YGm5Ih6NpmkpJDkT8PIzBH7s4LHi040AeSFg=;
	b=YTZLQiE1ZvGzw44uwS4F/I3/8B52DPDySJIxa74xJNhpJJdTScKMi92I5mPxnTeI7k2KfP
	Dkm3JgQJw1v1WFwXrQ9zdminZf9D+nDADkN0hgglWzTjoZ5rRd3fco5AH5sg9V6ljS5xpp
	mdU5Sh3OGqROxRGvH5nmZ8BAf+OX4nk=
From: Oliver Upton <oliver.upton@linux.dev>
To: stable@vger.kernel.org
Cc: maz@kernel.org,
	gregkh@linuxfoundation.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: [PATCH 5.4.y 2/2] KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
Date: Mon, 26 Feb 2024 21:56:12 +0000
Message-ID: <20240226215612.1387774-3-oliver.upton@linux.dev>
In-Reply-To: <20240226215612.1387774-1-oliver.upton@linux.dev>
References: <20240226215612.1387774-1-oliver.upton@linux.dev>
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
index 0589dfbc7685..f4ce08c0d0be 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -1376,6 +1376,8 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 
 	for (i = 0; i < irq_count; i++) {
 		irq = vgic_get_irq(kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
 
 		update_affinity(irq, vcpu2);
 
-- 
2.44.0.rc1.240.g4c46232300-goog


