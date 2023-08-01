Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8585D76AE9C
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjHAJkT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbjHAJjz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87518D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:37:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70264614B2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:37:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C808C433C9;
        Tue,  1 Aug 2023 09:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882660;
        bh=Jox5gd+Qaq5+/DbN/eI13CvmA860wSs3BcXSfv69Pus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PsI5Raxd8z8tAJnpX0LF+L0jMyTlwnoH/fE9e4fBRZqfGLvOtum7aUHH2yMIit5Pz
         i8fhaP93atxl2AwVr76VXSbFaxnmJk0oTINOmNmnqJsqxglituA/CVtSVyZ5AjHbv8
         YWsAlbpSzPP0BNtbU5nIcKSi3txq40IpuPgpGkXY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org
Subject: [PATCH 6.1 186/228] x86/MCE/AMD: Decrement threshold_bank refcount when removing threshold blocks
Date:   Tue,  1 Aug 2023 11:20:44 +0200
Message-ID: <20230801091929.580958007@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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
@@ -1265,10 +1265,10 @@ static void __threshold_remove_blocks(st
 	struct threshold_block *pos = NULL;
 	struct threshold_block *tmp = NULL;
 
-	kobject_del(b->kobj);
+	kobject_put(b->kobj);
 
 	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
-		kobject_del(&pos->kobj);
+		kobject_put(b->kobj);
 }
 
 static void threshold_remove_bank(struct threshold_bank *bank)


