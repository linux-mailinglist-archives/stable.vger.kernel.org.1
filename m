Return-Path: <stable+bounces-96211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7AB9E164F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446AF2815DB
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C83F1DDC0B;
	Tue,  3 Dec 2024 08:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B+ectPvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4071DB527
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215979; cv=none; b=l2fcfEOQi6e4NbA0tstSxVOPY0wYi4B88wZ9QArE0rfWlkG37TXTC94AG31tgfBRxe4VCwKeiOTm6hX31G2lquEYnVn6zXindOSGxqt13mJHguXbIcVVTkMFLIfvGUsj3tPm53+KF5/4HErEPSxJx2XAJ8lSWTZzLLhx23rimgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215979; c=relaxed/simple;
	bh=EEn7tsEFgg4wqQP4BnALVPmlZxWL+9Ew1gsW51jhNi8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qveb31VienyV3gmoDUIUEL/1edbuRj/zmXifJW0PVN3VdlVXWh7crQyyyMIysJGk2igcYWNVx1vhdW328dWDoNUb1+AkHN4ir4/cOqIDMJ8FPHsuZO3rcJCxa1D8cEBjz52JcsOQi/Wodg2VZBhMwZAc/nR5RlEzoFXxHAKiRbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B+ectPvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F36DC4CED8;
	Tue,  3 Dec 2024 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733215978;
	bh=EEn7tsEFgg4wqQP4BnALVPmlZxWL+9Ew1gsW51jhNi8=;
	h=Subject:To:Cc:From:Date:From;
	b=B+ectPvJnBJ+ZIbK2rXfPmrIqxNOYEwe7+Pwg//oP5Msdh2NXF6LPyCnErLAaJydd
	 850iGMUJHC//i4loDmtBNjt3ye0OvQAtxtyittqJfO9SvbwoUuNB1wjbhjCRSsiIL7
	 PsugJ8yyjWTyRhc0P3x/PwG1MJ8Za2uB5U5u3xVA=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device" failed to apply to 5.15-stable tree
To: jiangkunkun@huawei.com,jingzhangos@google.com,lishusen2@huawei.com,oliver.upton@linux.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Dec 2024 09:52:47 +0100
Message-ID: <2024120347-pursuable-garment-d644@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e9649129d33dca561305fc590a7c4ba8c3e5675a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120347-pursuable-garment-d644@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


