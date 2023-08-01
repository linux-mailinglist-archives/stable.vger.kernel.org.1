Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A06376AFD5
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjHAJu3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjHAJuJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A2326AA
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADC27614CF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6C7C433C8;
        Tue,  1 Aug 2023 09:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883383;
        bh=GwYXda8gFtzaTwkZdWNh6hsqFkCq46ZT1qtwIhTLmQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PXwTpheid7ymILC/BiCqXEoampV66DRGFSHY7UKJGcW3heE1Cdr7kzmRDaGQ2rS/3
         BfNZJv6hH9lqXyS5ejsLs3IVcNEIiTIiS0BoI2sTNR/sjLKxuwSsoLBOt9yCj9poI1
         b9BpzYOfGHiJHgSLAwMWQC1LogZrZO5Yc0Sms/0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org
Subject: [PATCH 6.4 189/239] x86/MCE/AMD: Decrement threshold_bank refcount when removing threshold blocks
Date:   Tue,  1 Aug 2023 11:20:53 +0200
Message-ID: <20230801091932.514865662@linuxfoundation.org>
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

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit 3ba2e83334bed2b1980b59734e6e84dfaf96026c upstream.

AMD systems from Family 10h to 16h share MCA bank 4 across multiple CPUs.
Therefore, the threshold_bank structure for bank 4, and its threshold_block
structures, will be initialized once at boot time. And the kobject for the
shared bank will be added to each of the CPUs that share it. Furthermore,
the threshold_blocks for the shared bank will be added again to the bank's
kobject. These additions will increase the refcount for the bank's kobject.

For example, a shared bank with two blocks and shared across two CPUs will
be set up like this:

  CPU0 init
    bank create and add; bank refcount = 1; threshold_create_bank()
      block 0 init and add; bank refcount = 2; allocate_threshold_blocks()
      block 1 init and add; bank refcount = 3; allocate_threshold_blocks()
  CPU1 init
    bank add; bank refcount = 3; threshold_create_bank()
      block 0 add; bank refcount = 4; __threshold_add_blocks()
      block 1 add; bank refcount = 5; __threshold_add_blocks()

Currently in threshold_remove_bank(), if the bank is shared then
__threshold_remove_blocks() is called. Here the shared bank's kobject and
the bank's blocks' kobjects are deleted. This is done on the first call
even while the structures are still shared. Subsequent calls from other
CPUs that share the structures will attempt to delete the kobjects.

During kobject_del(), kobject->sd is removed. If the kobject is not part of
a kset with default_groups, then subsequent kobject_del() calls seem safe
even with kobject->sd == NULL.

Originally, the AMD MCA thresholding structures did not use default_groups.
And so the above behavior was not apparent.

However, a recent change implemented default_groups for the thresholding
structures. Therefore, kobject_del() will go down the sysfs_remove_groups()
code path. In this case, the first kobject_del() may succeed and remove
kobject->sd. But subsequent kobject_del() calls will give a WARNing in
kernfs_remove_by_name_ns() since kobject->sd == NULL.

Use kobject_put() on the shared bank's kobject when "removing" blocks. This
decrements the bank's refcount while keeping kobjects enabled until the
bank is no longer shared. At that point, kobject_put() will be called on
the blocks which drives their refcount to 0 and deletes them and also
decrementing the bank's refcount. And finally kobject_put() will be called
on the bank driving its refcount to 0 and deleting it.

The same example above:

  CPU1 shutdown
    bank is shared; bank refcount = 5; threshold_remove_bank()
      block 0 put parent bank; bank refcount = 4; __threshold_remove_blocks()
      block 1 put parent bank; bank refcount = 3; __threshold_remove_blocks()
  CPU0 shutdown
    bank is no longer shared; bank refcount = 3; threshold_remove_bank()
      block 0 put block; bank refcount = 2; deallocate_threshold_blocks()
      block 1 put block; bank refcount = 1; deallocate_threshold_blocks()
    put bank; bank refcount = 0; threshold_remove_bank()

Fixes: 7f99cb5e6039 ("x86/CPU/AMD: Use default_groups in kobj_type")
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mce/amd.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1259,10 +1259,10 @@ static void __threshold_remove_blocks(st
 	struct threshold_block *pos = NULL;
 	struct threshold_block *tmp = NULL;
 
-	kobject_del(b->kobj);
+	kobject_put(b->kobj);
 
 	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
-		kobject_del(&pos->kobj);
+		kobject_put(b->kobj);
 }
 
 static void threshold_remove_bank(struct threshold_bank *bank)


