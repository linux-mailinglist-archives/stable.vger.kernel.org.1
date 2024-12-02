Return-Path: <stable+bounces-96084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A209E094B
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9FF0B61297
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1646920D4E8;
	Mon,  2 Dec 2024 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z6ksmz3R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC620CCF6
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152136; cv=none; b=n6C9YrshtlH5WaKKc5Uh9Bcc6Oi7oBt2uEb4YeyUTqr7UaXzEaS/lINNL9dd4rzaQwHHCFgv5ooA4tioAMtXlPR+kPjoBq4aoYCG+zjrQSDKF7hasTtfwR1zYjECR8GVT1Qep6jBtSJVbDDmv962XZJ3//68cp5G1zQvoAnFZpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152136; c=relaxed/simple;
	bh=oEmr8l2E7YGbjUSJnwlKbhPWwbHBV7loQxNLFSXWsDE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z0/ouEIrehBAG6zFi3iZzGrVqb4/UUXROtCMNSCKja+b43FMvE9sNCioJgioQPvo3nz9gmq1Nf26l24TgMZxhDgsnl9z3cp/fKwlwUvG6YPJB5Tj1inH5kvjXW7X7imZYpguHrTcyBRHlTWdpbi3m7r6pE2J5hT+zSzxA7y6obw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z6ksmz3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6878DC4CEEE;
	Mon,  2 Dec 2024 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733152135;
	bh=oEmr8l2E7YGbjUSJnwlKbhPWwbHBV7loQxNLFSXWsDE=;
	h=Subject:To:Cc:From:Date:From;
	b=z6ksmz3RZ1Eu4l8zsix+M+gtepJKESFC8nkQOxJF83nMb169KbheiUa/1GRbQDVGE
	 lAgeMUYpP3Ktlz+XpDKBn5FWYBlM83UDt8dalsOKjufAhkLGcZI8yNZmWcXILlR9k2
	 jQQDxiMzQrjckudl+DggoH4yX+yzuJSDCCyOs3rU=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device" failed to apply to 5.4-stable tree
To: jiangkunkun@huawei.com,jingzhangos@google.com,lishusen2@huawei.com,oliver.upton@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Dec 2024 16:08:52 +0100
Message-ID: <2024120252-submersed-reorder-64c3@gregkh>
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
git cherry-pick -x e9649129d33dca561305fc590a7c4ba8c3e5675a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120252-submersed-reorder-64c3@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e9649129d33dca561305fc590a7c4ba8c3e5675a Mon Sep 17 00:00:00 2001
From: Kunkun Jiang <jiangkunkun@huawei.com>
Date: Thu, 7 Nov 2024 13:41:36 -0800
Subject: [PATCH] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device

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

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 68ba7e2453cd..b77fa99eafed 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1139,9 +1139,11 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
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
@@ -1162,7 +1164,7 @@ static int vgic_its_cmd_handle_mapd(struct kvm *kvm, struct vgic_its *its,
 	 * is an error, so we are done in any case.
 	 */
 	if (!valid)
-		return 0;
+		return vgic_its_write_entry_lock(its, gpa, 0, dte_esz);
 
 	device = vgic_its_alloc_device(its, device_id, itt_addr,
 				       num_eventid_bits);


