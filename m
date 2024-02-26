Return-Path: <stable+bounces-23660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9008671C7
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 11:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB5BB32035
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B01F1D52C;
	Mon, 26 Feb 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ArKVQKV6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5AC1D524
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943601; cv=none; b=lI/lhyKk/NcI0CROh1uY6iFMnB80ZZ798FblA6+yeOw71GfR0iXMAnngTzkG+GNVeTvzseDgRyVCyUsCyeAw8useQCR6550IeoHg2qWPyIqDQNWNWLplBNcFSYH3tPexnKLgzJxLS8XRXlKeDMjgV+uVBioi28HViztUG11qO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943601; c=relaxed/simple;
	bh=gp2CXt67jXPSwpZVYevvXpiEjGZCA+kf6zUkKZjH+dA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W5rqBTa4iY15zeTaEVCfnMwRqVWytlyjWMJdGN5k8Im6nQEogQ0q7sGO5qzrvhtWhGQf8kF9Dvz0KCqjdxYeUqmD09U+cjDnfe3DCZoRIW41aFtJqk3jdkBM1OkyUF56dbHzsWc/0fdIwyStwybSNeh0OSvtCM+wPdTIF9oaiLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ArKVQKV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECF5C433B2;
	Mon, 26 Feb 2024 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708943600;
	bh=gp2CXt67jXPSwpZVYevvXpiEjGZCA+kf6zUkKZjH+dA=;
	h=Subject:To:Cc:From:Date:From;
	b=ArKVQKV6V90s1jacqPnkOX+E64G40ytklOJg8M0+79prBnuWLhDXhnqZGFfSCLmAy
	 XIH1oZFbS+qGwXyac0lTWEsZ9birQG1mzGC7VfM3epIPUVA1OPT3A0ymBTNWasUGJG
	 ftb/Z3GNXhfuanzlJfsJTXBo7JK8ihOR03W5xYOk=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler" failed to apply to 5.4-stable tree
To: oliver.upton@linux.dev,maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 26 Feb 2024 11:33:18 +0100
Message-ID: <2024022618-maternal-runny-28b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 85a71ee9a0700f6c18862ef3b0011ed9dad99aca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024022618-maternal-runny-28b5@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

85a71ee9a070 ("KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 85a71ee9a0700f6c18862ef3b0011ed9dad99aca Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Wed, 21 Feb 2024 09:27:32 +0000
Subject: [PATCH] KVM: arm64: vgic-its: Test for valid IRQ in MOVALL handler

It is possible that an LPI mapped in a different ITS gets unmapped while
handling the MOVALL command. If that is the case, there is no state that
can be migrated to the destination. Silently ignore it and continue
migrating other LPIs.

Cc: stable@vger.kernel.org
Fixes: ff9c114394aa ("KVM: arm/arm64: GICv4: Handle MOVALL applied to a vPE")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Link: https://lore.kernel.org/r/20240221092732.4126848-3-oliver.upton@linux.dev
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 082448de27ed..28a93074eca1 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1435,6 +1435,8 @@ static int vgic_its_cmd_handle_movall(struct kvm *kvm, struct vgic_its *its,
 
 	for (i = 0; i < irq_count; i++) {
 		irq = vgic_get_irq(kvm, NULL, intids[i]);
+		if (!irq)
+			continue;
 
 		update_affinity(irq, vcpu2);
 


