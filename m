Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006E6726BCE
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbjFGU2a (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjFGU23 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:28:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120681FDB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:28:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8A06448D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4278AC433EF;
        Wed,  7 Jun 2023 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169687;
        bh=1jZkyj7dcY1tIsmYHp9i+CTMFDRX+aHiK+kwr6ALNNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N5a5brcHELe8D50rAbF/QIajF9r0QeJ7j64kQ+1tZi1smneQQhdrh/m50Yfc70aPA
         KV0cfX6OSzpACNS8s1jK6xlSYpuwdOg/odBUsX3ftqiZpDyH/F+CnRC9ACCkGKql7O
         brELvkbSTknkTWYrGxhT1Ir0Fxc8+UxX/070FABs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 176/286] KVM: arm64: vgic: Wrap vgic_its_create() with config_lock
Date:   Wed,  7 Jun 2023 22:14:35 +0200
Message-ID: <20230607200928.870442095@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

[ Upstream commit 9cf2f840c439b6b23bd99f584f2917ca425ae406 ]

vgic_its_create() changes the vgic state without holding the
config_lock, which triggers a lockdep warning in vgic_v4_init():

[  358.667941] WARNING: CPU: 3 PID: 178 at arch/arm64/kvm/vgic/vgic-v4.c:245 vgic_v4_init+0x15c/0x7a8
...
[  358.707410]  vgic_v4_init+0x15c/0x7a8
[  358.708550]  vgic_its_create+0x37c/0x4a4
[  358.709640]  kvm_vm_ioctl+0x1518/0x2d80
[  358.710688]  __arm64_sys_ioctl+0x7ac/0x1ba8
[  358.711960]  invoke_syscall.constprop.0+0x70/0x1e0
[  358.713245]  do_el0_svc+0xe4/0x2d4
[  358.714289]  el0_svc+0x44/0x8c
[  358.715329]  el0t_64_sync_handler+0xf4/0x120
[  358.716615]  el0t_64_sync+0x190/0x194

Wrap the whole of vgic_its_create() with config_lock since, in addition
to calling vgic_v4_init(), it also modifies the global kvm->arch.vgic
state.

Fixes: f00327731131 ("KVM: arm64: Use config_lock to protect vgic state")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230518100914.2837292-3-jean-philippe@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/vgic/vgic-its.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 750e51e3779a3..5fe2365a629f2 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1936,6 +1936,7 @@ void vgic_lpi_translation_cache_destroy(struct kvm *kvm)
 
 static int vgic_its_create(struct kvm_device *dev, u32 type)
 {
+	int ret;
 	struct vgic_its *its;
 
 	if (type != KVM_DEV_TYPE_ARM_VGIC_ITS)
@@ -1945,9 +1946,12 @@ static int vgic_its_create(struct kvm_device *dev, u32 type)
 	if (!its)
 		return -ENOMEM;
 
+	mutex_lock(&dev->kvm->arch.config_lock);
+
 	if (vgic_initialized(dev->kvm)) {
-		int ret = vgic_v4_init(dev->kvm);
+		ret = vgic_v4_init(dev->kvm);
 		if (ret < 0) {
+			mutex_unlock(&dev->kvm->arch.config_lock);
 			kfree(its);
 			return ret;
 		}
@@ -1960,12 +1964,10 @@ static int vgic_its_create(struct kvm_device *dev, u32 type)
 
 	/* Yep, even more trickery for lock ordering... */
 #ifdef CONFIG_LOCKDEP
-	mutex_lock(&dev->kvm->arch.config_lock);
 	mutex_lock(&its->cmd_lock);
 	mutex_lock(&its->its_lock);
 	mutex_unlock(&its->its_lock);
 	mutex_unlock(&its->cmd_lock);
-	mutex_unlock(&dev->kvm->arch.config_lock);
 #endif
 
 	its->vgic_its_base = VGIC_ADDR_UNDEF;
@@ -1986,7 +1988,11 @@ static int vgic_its_create(struct kvm_device *dev, u32 type)
 
 	dev->private = its;
 
-	return vgic_its_set_abi(its, NR_ITS_ABIS - 1);
+	ret = vgic_its_set_abi(its, NR_ITS_ABIS - 1);
+
+	mutex_unlock(&dev->kvm->arch.config_lock);
+
+	return ret;
 }
 
 static void vgic_its_destroy(struct kvm_device *kvm_dev)
-- 
2.39.2



