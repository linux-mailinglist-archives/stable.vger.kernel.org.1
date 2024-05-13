Return-Path: <stable+bounces-43665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE58C429A
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D601F221F4
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1241153572;
	Mon, 13 May 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bIgylEqi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866A914EC7A
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608596; cv=none; b=m0cdJh8TnUD567zFxe3SQ7GQzOVzmmfSShvS9YNLnexflQlZJdZSK3VtBJyVELIGY811fOd7PDzeiP3Nvo9Bd2hlhtEbpO67ABQnwOu0VGBOKcpwzNcj+wzMhiKQodNAvTwRK3Ueiia6RjzS6U93yUYow2iNrmSvHMGwzllSS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608596; c=relaxed/simple;
	bh=EP2ibceGt3xljgRritR1HTq3zqSf3rK2F0lzbe/LG4M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uM5OLggNJJ98TT1gRFPSEMjEjeuMLZFYdFVqejLIHYtJm+OVg2II2akz/4nSUl2+cS37TklPrAKspBPUYiwD7r6Y700osyk+Lnj8IO6rlzroLfy4GOBTSneuYFstpGtMcim0bhNFMQmn4Zby58fSZBMog+zNKvrOAr1kDhLmQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bIgylEqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6280C113CC;
	Mon, 13 May 2024 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715608596;
	bh=EP2ibceGt3xljgRritR1HTq3zqSf3rK2F0lzbe/LG4M=;
	h=Subject:To:Cc:From:Date:From;
	b=bIgylEqi2SVlA0ErnOq6X3aBD6XlSXZ2U/yhAZ15Lyz/D+giuOoTafJQ0Co9hSLCC
	 xOfUTj0WMgLRGjcT9X8ToKfrREEPfaKcYoDeIhI/ZgnRHl0ne8gTxwO1Hy8KH5v98v
	 U06kzD80MVOvqfI3eVISsNzsttQGpHE4vt1OByTE=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-v2: Check for non-NULL vCPU in" failed to apply to 5.4-stable tree
To: oliver.upton@linux.dev,glider@google.com,maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:56:32 +0200
Message-ID: <2024051331-relieving-showcase-24cd@gregkh>
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
git cherry-pick -x 6ddb4f372fc63210034b903d96ebbeb3c7195adb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051331-relieving-showcase-24cd@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

6ddb4f372fc6 ("KVM: arm64: vgic-v2: Check for non-NULL vCPU in vgic_v2_parse_attr()")
4e7728c81a54 ("KVM: arm64: vgic-v2: Use cpuid from userspace as vcpu_id")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ddb4f372fc63210034b903d96ebbeb3c7195adb Mon Sep 17 00:00:00 2001
From: Oliver Upton <oliver.upton@linux.dev>
Date: Wed, 24 Apr 2024 17:39:58 +0000
Subject: [PATCH] KVM: arm64: vgic-v2: Check for non-NULL vCPU in
 vgic_v2_parse_attr()

vgic_v2_parse_attr() is responsible for finding the vCPU that matches
the user-provided CPUID, which (of course) may not be valid. If the ID
is invalid, kvm_get_vcpu_by_id() returns NULL, which isn't handled
gracefully.

Similar to the GICv3 uaccess flow, check that kvm_get_vcpu_by_id()
actually returns something and fail the ioctl if not.

Cc: stable@vger.kernel.org
Fixes: 7d450e282171 ("KVM: arm/arm64: vgic-new: Add userland access to VGIC dist registers")
Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20240424173959.3776798-2-oliver.upton@linux.dev
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

diff --git a/arch/arm64/kvm/vgic/vgic-kvm-device.c b/arch/arm64/kvm/vgic/vgic-kvm-device.c
index f48b8dab8b3d..1d26bb5b02f4 100644
--- a/arch/arm64/kvm/vgic/vgic-kvm-device.c
+++ b/arch/arm64/kvm/vgic/vgic-kvm-device.c
@@ -338,12 +338,12 @@ int kvm_register_vgic_device(unsigned long type)
 int vgic_v2_parse_attr(struct kvm_device *dev, struct kvm_device_attr *attr,
 		       struct vgic_reg_attr *reg_attr)
 {
-	int cpuid;
+	int cpuid = FIELD_GET(KVM_DEV_ARM_VGIC_CPUID_MASK, attr->attr);
 
-	cpuid = FIELD_GET(KVM_DEV_ARM_VGIC_CPUID_MASK, attr->attr);
-
-	reg_attr->vcpu = kvm_get_vcpu_by_id(dev->kvm, cpuid);
 	reg_attr->addr = attr->attr & KVM_DEV_ARM_VGIC_OFFSET_MASK;
+	reg_attr->vcpu = kvm_get_vcpu_by_id(dev->kvm, cpuid);
+	if (!reg_attr->vcpu)
+		return -EINVAL;
 
 	return 0;
 }


