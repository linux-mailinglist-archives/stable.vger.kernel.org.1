Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1828D76AD4F
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjHAJ2U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjHAJ1q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D2269F
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:26:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5422614F5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB77C433C7;
        Tue,  1 Aug 2023 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881998;
        bh=5OuVzdwn1BQzTT9FwN4c1HtEgiOsoCPh1mGjqBIGJMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5abTMP4i9UbgmtUK69Q3VLmvTMX52QkfVKThRFtV2xjb39LSPQUmAsWRFl1vZSG8
         xwUENE/GbbKMfbR4ZfNfG2vd9mFm31DyFDnv05Avj2ZH0y6AV/V5ISpKkT7DgFMaAn
         sMthePuEv/RF9JE8ELepI1CwGPkc/Ma6w6Dx4FqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Zhang <zheng.zhang@email.ucr.edu>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.15 104/155] KVM: Grab a reference to KVM for VM and vCPU stats file descriptors
Date:   Tue,  1 Aug 2023 11:20:16 +0200
Message-ID: <20230801091913.951630144@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

commit eed3013faa401aae662398709410a59bb0646e32 upstream.

Grab a reference to KVM prior to installing VM and vCPU stats file
descriptors to ensure the underlying VM and vCPU objects are not freed
until the last reference to any and all stats fds are dropped.

Note, the stats paths manually invoke fd_install() and so don't need to
grab a reference before creating the file.

Fixes: ce55c049459c ("KVM: stats: Support binary stats retrieval for a VCPU")
Fixes: fcfe1baeddbf ("KVM: stats: Support binary stats retrieval for a VM")
Reported-by: Zheng Zhang <zheng.zhang@email.ucr.edu>
Closes: https://lore.kernel.org/all/CAC_GQSr3xzZaeZt85k_RCBd5kfiOve8qXo7a81Cq53LuVQ5r=Q@mail.gmail.com
Cc: stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Message-Id: <20230711230131.648752-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 virt/kvm/kvm_main.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3804,8 +3804,17 @@ static ssize_t kvm_vcpu_stats_read(struc
 			sizeof(vcpu->stat), user_buffer, size, offset);
 }
 
+static int kvm_vcpu_stats_release(struct inode *inode, struct file *file)
+{
+	struct kvm_vcpu *vcpu = file->private_data;
+
+	kvm_put_kvm(vcpu->kvm);
+	return 0;
+}
+
 static const struct file_operations kvm_vcpu_stats_fops = {
 	.read = kvm_vcpu_stats_read,
+	.release = kvm_vcpu_stats_release,
 	.llseek = noop_llseek,
 };
 
@@ -3826,6 +3835,9 @@ static int kvm_vcpu_ioctl_get_stats_fd(s
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
+
+	kvm_get_kvm(vcpu->kvm);
+
 	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 
@@ -4409,8 +4421,17 @@ static ssize_t kvm_vm_stats_read(struct
 				sizeof(kvm->stat), user_buffer, size, offset);
 }
 
+static int kvm_vm_stats_release(struct inode *inode, struct file *file)
+{
+	struct kvm *kvm = file->private_data;
+
+	kvm_put_kvm(kvm);
+	return 0;
+}
+
 static const struct file_operations kvm_vm_stats_fops = {
 	.read = kvm_vm_stats_read,
+	.release = kvm_vm_stats_release,
 	.llseek = noop_llseek,
 };
 
@@ -4429,6 +4450,9 @@ static int kvm_vm_ioctl_get_stats_fd(str
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
+
+	kvm_get_kvm(kvm);
+
 	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 


