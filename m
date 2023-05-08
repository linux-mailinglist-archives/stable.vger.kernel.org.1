Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC726FA6B5
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbjEHKXb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjEHKWy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:22:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2A824037
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:22:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 898DD62558
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81543C433EF;
        Mon,  8 May 2023 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541341;
        bh=lE0iVr6vFooUwwIpPU3OVgO1WvMteKCsrak9kTdvJ50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pY/BMjJIFA2sGGvw+id422vLX/Xi9pHhjcD7P6BuIuLYjQxhAqaksUJLaviCTTMmL
         Fz3iRAdtBVjV8oaYnsxo/OL5iP9/1fYizrqRR/A5UxSifHQlUyM/9rv1ljW9ta+xf1
         jvSJGvmhQSsP0sl5nE5SpToU48XfMDioXLu694AE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.2 083/663] KVM: arm64: vgic: Dont acquire its_lock before config_lock
Date:   Mon,  8 May 2023 11:38:29 +0200
Message-Id: <20230508094431.141573455@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oliver Upton <oliver.upton@linux.dev>

commit 49e5d16b6fc003407a33a9961b4bcbb970bd1c76 upstream.

commit f00327731131 ("KVM: arm64: Use config_lock to protect vgic
state") was meant to rectify a longstanding lock ordering issue in KVM
where the kvm->lock is taken while holding vcpu->mutex. As it so
happens, the aforementioned commit introduced yet another locking issue
by acquiring the its_lock before acquiring the config lock.

This is obviously wrong, especially considering that the lock ordering
is well documented in vgic.c. Reshuffle the locks once more to take the
config_lock before the its_lock. While at it, sprinkle in the lockdep
hinting that has become popular as of late to keep lockdep apprised of
our ordering.

Cc: stable@vger.kernel.org
Fixes: f00327731131 ("KVM: arm64: Use config_lock to protect vgic state")
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230412062733.988229-1-oliver.upton@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/vgic/vgic-its.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -1958,6 +1958,16 @@ static int vgic_its_create(struct kvm_de
 	mutex_init(&its->its_lock);
 	mutex_init(&its->cmd_lock);
 
+	/* Yep, even more trickery for lock ordering... */
+#ifdef CONFIG_LOCKDEP
+	mutex_lock(&dev->kvm->arch.config_lock);
+	mutex_lock(&its->cmd_lock);
+	mutex_lock(&its->its_lock);
+	mutex_unlock(&its->its_lock);
+	mutex_unlock(&its->cmd_lock);
+	mutex_unlock(&dev->kvm->arch.config_lock);
+#endif
+
 	its->vgic_its_base = VGIC_ADDR_UNDEF;
 
 	INIT_LIST_HEAD(&its->device_list);
@@ -2752,15 +2762,14 @@ static int vgic_its_ctrl(struct kvm *kvm
 		return 0;
 
 	mutex_lock(&kvm->lock);
-	mutex_lock(&its->its_lock);
 
 	if (!lock_all_vcpus(kvm)) {
-		mutex_unlock(&its->its_lock);
 		mutex_unlock(&kvm->lock);
 		return -EBUSY;
 	}
 
 	mutex_lock(&kvm->arch.config_lock);
+	mutex_lock(&its->its_lock);
 
 	switch (attr) {
 	case KVM_DEV_ARM_ITS_CTRL_RESET:
@@ -2774,9 +2783,9 @@ static int vgic_its_ctrl(struct kvm *kvm
 		break;
 	}
 
+	mutex_unlock(&its->its_lock);
 	mutex_unlock(&kvm->arch.config_lock);
 	unlock_all_vcpus(kvm);
-	mutex_unlock(&its->its_lock);
 	mutex_unlock(&kvm->lock);
 	return ret;
 }


