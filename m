Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA076AF83
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbjHAJsa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjHAJsM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7751030D0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9466C614FD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CE3C433C8;
        Tue,  1 Aug 2023 09:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883188;
        bh=3aLo/OWMW8M+kIMBorP4UWShjcCcFTohr5qVaqdxiYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFYgN3ou1UaWz1Ai8B3b2J9h9AXjMzybdlF4UCwx+jaw6r8jj7gg89dNICHPZIhp8
         CBwmds2dtjtxTgaC+v9VizMkiaHj5zFrexOVtisIDLDBwErOXiMzZ71bq+1ceaWTr/
         Zz1N0gBj2BvrPPklHzDi5p4UioL6XWk1B2/KHzZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Zhang <zheng.zhang@email.ucr.edu>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6.4 146/239] KVM: Grab a reference to KVM for VM and vCPU stats file descriptors
Date:   Tue,  1 Aug 2023 11:20:10 +0200
Message-ID: <20230801091930.927808003@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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
@@ -4047,8 +4047,17 @@ static ssize_t kvm_vcpu_stats_read(struc
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
 
@@ -4069,6 +4078,9 @@ static int kvm_vcpu_ioctl_get_stats_fd(s
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
+
+	kvm_get_kvm(vcpu->kvm);
+
 	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 
@@ -4712,8 +4724,17 @@ static ssize_t kvm_vm_stats_read(struct
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
 
@@ -4732,6 +4753,9 @@ static int kvm_vm_ioctl_get_stats_fd(str
 		put_unused_fd(fd);
 		return PTR_ERR(file);
 	}
+
+	kvm_get_kvm(kvm);
+
 	file->f_mode |= FMODE_PREAD;
 	fd_install(fd, file);
 


