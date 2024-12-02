Return-Path: <stable+bounces-96083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3449D9E07A0
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 16:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0B1AB3DAC4
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30907204F6D;
	Mon,  2 Dec 2024 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pWd1uqGS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D442040BB
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151996; cv=none; b=RmRtcy2GYR65G7gaaWUaOBXaUDmTGVvd1n7wTX0nVQvJ9JZjWo9f1c4NK/VpPBEtjxNu0X5XZm5MvbESaSNESOL1ScnHcEzSFkyqo7LPTKmbRe++opMCnkqVumb/bV6DJG3jjuvNLWl9qWd4SllGyjg4AgpSND7opXXU9LZGWFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151996; c=relaxed/simple;
	bh=N3mGuRqqwSc4PubXq84LYEbk4E7Mq8PeutrxOJYa3HE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZCfuuQmyiosAuxmbN/yOtqorlzRBVszRrfrOFO/aw3Y+q5Ac+cmNX8DxBRaTpL7kcb6s3dOlWYnjQaYqAATz/KYrwGr0VT9+I0cBMpTc69ZveuJjauv/JkY4P5RdJ1z7fa3mk7oicQIJB4CswlqNzXWEM8iNeQCLMjXtBoCzTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pWd1uqGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52998C4CED1;
	Mon,  2 Dec 2024 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733151995;
	bh=N3mGuRqqwSc4PubXq84LYEbk4E7Mq8PeutrxOJYa3HE=;
	h=Subject:To:Cc:From:Date:From;
	b=pWd1uqGS9xVNSSIjFDDeLeuBEWQrS21UsAiuZQnVw4ZlCPkASgbCsUeitYUDjgIiS
	 bQ/vL9x80hqgDBoAQag1Q3Mt55GY5qEDIwl27Jxs72vgLHdv7PNZ1QKCVgtzeH1Fxq
	 NYrJ2jmMNOXgMlT2zPR/2VPV8WtnfKAlPuaoxM6I=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE" failed to apply to 4.19-stable tree
To: jiangkunkun@huawei.com,jingzhangos@google.com,oliver.upton@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:06:30 +0100
Message-ID: <2024120229-transfer-capped-7af1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 7602ffd1d5e8927fadd5187cb4aed2fdc9c47143
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120229-transfer-capped-7af1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7602ffd1d5e8927fadd5187cb4aed2fdc9c47143 Mon Sep 17 00:00:00 2001
From: Kunkun Jiang <jiangkunkun@huawei.com>
Date: Thu, 7 Nov 2024 13:41:37 -0800
Subject: [PATCH] KVM: arm64: vgic-its: Clear ITE when DISCARD frees an ITE

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

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index b77fa99eafed..198296933e7e 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -782,6 +782,9 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 
 	ite = find_ite(its, device_id, event_id);
 	if (ite && its_is_collection_mapped(ite->collection)) {
+		struct its_device *device = find_its_device(its, device_id);
+		int ite_esz = vgic_its_get_abi(its)->ite_esz;
+		gpa_t gpa = device->itt_addr + ite->event_id * ite_esz;
 		/*
 		 * Though the spec talks about removing the pending state, we
 		 * don't bother here since we clear the ITTE anyway and the
@@ -790,7 +793,8 @@ static int vgic_its_cmd_handle_discard(struct kvm *kvm, struct vgic_its *its,
 		vgic_its_invalidate_cache(its);
 
 		its_free_ite(kvm, ite);
-		return 0;
+
+		return vgic_its_write_entry_lock(its, gpa, 0, ite_esz);
 	}
 
 	return E_ITS_DISCARD_UNMAPPED_INTERRUPT;


