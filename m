Return-Path: <stable+bounces-24973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F486971E
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0591C23513
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8013B7AB;
	Tue, 27 Feb 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZMZNt05"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1B78B61;
	Tue, 27 Feb 2024 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043503; cv=none; b=d5+8ub/4ujL3Le10XuskkASQ/FmOa0Z35iF1nNObWRJaxRFnn14pPlN+gzL+Hm7dQPONjon3P8ojwDdgM3JwsQLqeOp1HywMHsN3r/+Ifr0wSY+lz/TgVV9VJN6iJ30FoBCDe6R/lY394NxyYioRjmn1LWrjXOgPoF5LnXd3Wmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043503; c=relaxed/simple;
	bh=YGOGOugIRKX05hv9RZ/X0jtQFGfYr7fNye3QJCjQewI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa3AxsqsDRMwyYKE1TE6XiukiIe2d6mS/AE0Cd31Uq9eRrwtNmgqI3giAsJ3jS8ar7OUCCvaW9j5PRXLy8Sv4uZ9AwXEytkIEx4DPve+Bkbqk9CtVssmqslj0r+4G1boYrU2SfiMIsPMdG2DR9lqZJCSadciA5eJPuJtErTKm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZMZNt05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9897C433C7;
	Tue, 27 Feb 2024 14:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043503;
	bh=YGOGOugIRKX05hv9RZ/X0jtQFGfYr7fNye3QJCjQewI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XZMZNt05x/Tt91JTG8bw3SkHgQL3buUCzBkWroAWNHvs1YXEg9QB60K9fXj9MyWqi
	 gL//ovBbyl7PIacBTsxNRELkP5khslu3yFQNl5PNDs0UwLOtgjd9smYcd9Etb5C0hm
	 OJxXMD20O8lyGYQUqc233U+oElOWDQItfXK1Dhvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Upton <oliver.upton@linux.dev>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.1 103/195] KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler
Date: Tue, 27 Feb 2024 14:26:04 +0100
Message-ID: <20240227131613.871883250@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Upton <oliver.upton@linux.dev>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/vgic/vgic-its.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1427,6 +1427,8 @@ static int vgic_its_cmd_handle_movall(st
 
 	for (i = 0; i < irq_count; i++) {
 		irq = vgic_get_irq(kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
 
 		update_affinity(irq, vcpu2);
 



