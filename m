Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD06F16BD
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbjD1LaG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345752AbjD1LaC (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279675B92
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7221642F9
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4CFC433EF;
        Fri, 28 Apr 2023 11:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681401;
        bh=aaOGD4lC/ZWuwEA1UtJFvUBnGv7OR6jHFa8LwnIj1Xo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gSbIOBA4W48Lb2hzehVj3E3CBffn0HJG/F74HQAlb71Ukm4OM6D3Ug27+BU+J35zz
         gMFr1Xt/YQK1TpKkOsBcroZEh9Hgq21nTXU0SDwZQ01aNf2+Se/R4xuPIVmJdHaY9V
         FjLSi27973BfUrhOp3yEVkjJUd7HRcgowGRvyAnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Steven Price <steven.price@arm.com>,
        Eric Auger <eric.auger@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.15 04/13] KVM: arm64: Fix buffer overflow in kvm_arm_set_fw_reg()
Date:   Fri, 28 Apr 2023 13:28:08 +0200
Message-Id: <20230428112039.297451207@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
References: <20230428112039.133978540@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

commit a25bc8486f9c01c1af6b6c5657234b2eee2c39d6 upstream.

The KVM_REG_SIZE() comes from the ioctl and it can be a power of two
between 0-32768 but if it is more than sizeof(long) this will corrupt
memory.

Fixes: 99adb567632b ("KVM: arm/arm64: Add save/restore support for firmware workaround state")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/4efbab8c-640f-43b2-8ac6-6d68e08280fe@kili.mountain
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
[will: kvm_arm_set_fw_reg() lives in psci.c not hypercalls.c]
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/psci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/kvm/psci.c
+++ b/arch/arm64/kvm/psci.c
@@ -508,6 +508,8 @@ int kvm_arm_set_fw_reg(struct kvm_vcpu *
 	u64 val;
 	int wa_level;
 
+	if (KVM_REG_SIZE(reg->id) != sizeof(val))
+		return -ENOENT;
 	if (copy_from_user(&val, uaddr, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
 


