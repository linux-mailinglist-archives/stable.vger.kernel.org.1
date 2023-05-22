Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C0270C9E1
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjEVTwy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbjEVTwh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:52:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766F310C0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:52:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE4B362B2E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCFDC4339E;
        Mon, 22 May 2023 19:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785148;
        bh=htlI4za3gKjBv5m6UvLOQwSbmK4MTdqbzzNeY+eG3TA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxSiPCM8x8RxF7dxDUxj+DkwmOQ5T0k9kYLZtTl+yVFqfx9y7zUFugxH6iPKy96RT
         Ht51+nx3q72j1O/kFRzJ4kZG8dr86zx6FqIqpFZRlWBs7nWd0FpXgmypN7HcovuaK/
         xJc5rvMnYcqDSrIkqQnxF0B8aVhXFaFr7SJ5p23U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Luczaj <mhal@rbox.co>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.3 326/364] KVM: Fix vcpu_array[0] races
Date:   Mon, 22 May 2023 20:10:31 +0100
Message-Id: <20230522190420.924376537@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michal Luczaj <mhal@rbox.co>

commit afb2acb2e3a32e4d56f7fbd819769b98ed1b7520 upstream.

In kvm_vm_ioctl_create_vcpu(), add vcpu to vcpu_array iff it's safe to
access vcpu via kvm_get_vcpu() and kvm_for_each_vcpu(), i.e. when there's
no failure path requiring vcpu removal and destruction. Such order is
important because vcpu_array accessors may end up referencing vcpu at
vcpu_array[0] even before online_vcpus is set to 1.

When online_vcpus=0, any call to kvm_get_vcpu() goes through
array_index_nospec() and ends with an attempt to xa_load(vcpu_array, 0):

	int num_vcpus = atomic_read(&kvm->online_vcpus);
	i = array_index_nospec(i, num_vcpus);
	return xa_load(&kvm->vcpu_array, i);

Similarly, when online_vcpus=0, a kvm_for_each_vcpu() does not iterate over
an "empty" range, but actually [0, ULONG_MAX]:

	xa_for_each_range(&kvm->vcpu_array, idx, vcpup, 0, \
			  (atomic_read(&kvm->online_vcpus) - 1))

In both cases, such online_vcpus=0 edge case, even if leading to
unnecessary calls to XArray API, should not be an issue; requesting
unpopulated indexes/ranges is handled by xa_load() and xa_for_each_range().

However, this means that when the first vCPU is created and inserted in
vcpu_array *and* before online_vcpus is incremented, code calling
kvm_get_vcpu()/kvm_for_each_vcpu() already has access to that first vCPU.

This should not pose a problem assuming that once a vcpu is stored in
vcpu_array, it will remain there, but that's not the case:
kvm_vm_ioctl_create_vcpu() first inserts to vcpu_array, then requests a
file descriptor. If create_vcpu_fd() fails, newly inserted vcpu is removed
from the vcpu_array, then destroyed:

	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
	r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
	kvm_get_kvm(kvm);
	r = create_vcpu_fd(vcpu);
	if (r < 0) {
		xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
		kvm_put_kvm_no_destroy(kvm);
		goto unlock_vcpu_destroy;
	}
	atomic_inc(&kvm->online_vcpus);

This results in a possible race condition when a reference to a vcpu is
acquired (via kvm_get_vcpu() or kvm_for_each_vcpu()) moments before said
vcpu is destroyed.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
Message-Id: <20230510140410.1093987-2-mhal@rbox.co>
Cc: stable@vger.kernel.org
Fixes: c5b077549136 ("KVM: Convert the kvm->vcpus array to a xarray", 2021-12-08)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/kvm_main.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3959,18 +3959,19 @@ static int kvm_vm_ioctl_create_vcpu(stru
 	}
 
 	vcpu->vcpu_idx = atomic_read(&kvm->online_vcpus);
-	r = xa_insert(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, GFP_KERNEL_ACCOUNT);
-	BUG_ON(r == -EBUSY);
+	r = xa_reserve(&kvm->vcpu_array, vcpu->vcpu_idx, GFP_KERNEL_ACCOUNT);
 	if (r)
 		goto unlock_vcpu_destroy;
 
 	/* Now it's all set up, let userspace reach it */
 	kvm_get_kvm(kvm);
 	r = create_vcpu_fd(vcpu);
-	if (r < 0) {
-		xa_erase(&kvm->vcpu_array, vcpu->vcpu_idx);
-		kvm_put_kvm_no_destroy(kvm);
-		goto unlock_vcpu_destroy;
+	if (r < 0)
+		goto kvm_put_xa_release;
+
+	if (KVM_BUG_ON(!!xa_store(&kvm->vcpu_array, vcpu->vcpu_idx, vcpu, 0), kvm)) {
+		r = -EINVAL;
+		goto kvm_put_xa_release;
 	}
 
 	/*
@@ -3985,6 +3986,9 @@ static int kvm_vm_ioctl_create_vcpu(stru
 	kvm_create_vcpu_debugfs(vcpu);
 	return r;
 
+kvm_put_xa_release:
+	kvm_put_kvm_no_destroy(kvm);
+	xa_release(&kvm->vcpu_array, vcpu->vcpu_idx);
 unlock_vcpu_destroy:
 	mutex_unlock(&kvm->lock);
 	kvm_dirty_ring_free(&vcpu->dirty_ring);


