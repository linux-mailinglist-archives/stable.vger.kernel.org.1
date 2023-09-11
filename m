Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16BB79BAF0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378866AbjIKWhm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbjIKOVt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:21:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF52EDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:21:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFF2C433C7;
        Mon, 11 Sep 2023 14:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442104;
        bh=alv9pXKHkadZbXb9Ev0JpZm2ku/B35WJ/qnAVzxFvSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+2oTDGMDLjuq3ke6xjLJ6Yu8MD80QC6MttBDLA0pC/bt080ThEX3EUrntvQvgaS1
         nKKqfP2or0prA2t0EsbvBVvDArNyBvPp8Cy0bMIGNsemHB6Ay0ckeYdFgnGi/FOjyx
         69i5/rYb6Dr/ADXlGVi5K9zE+ZVayTa9Wh+Mq/z0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.5 648/739] mm/vmalloc: add a safer version of find_vm_area() for debug
Date:   Mon, 11 Sep 2023 15:47:27 +0200
Message-ID: <20230911134709.205569262@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Fernandes (Google) <joel@joelfernandes.org>

commit 0818e739b5c061b0251c30152380600fb9b84c0c upstream.

It is unsafe to dump vmalloc area information when trying to do so from
some contexts.  Add a safer trylock version of the same function to do a
best-effort VMA finding and use it from vmalloc_dump_obj().

[applied test robot feedback on unused function fix.]
[applied Uladzislau feedback on locking.]
Link: https://lkml.kernel.org/r/20230904180806.1002832-1-joel@joelfernandes.org
Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>
Cc: <stable@vger.kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmalloc.c |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4278,14 +4278,32 @@ void pcpu_free_vm_areas(struct vm_struct
 #ifdef CONFIG_PRINTK
 bool vmalloc_dump_obj(void *object)
 {
-	struct vm_struct *vm;
 	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
+	const void *caller;
+	struct vm_struct *vm;
+	struct vmap_area *va;
+	unsigned long addr;
+	unsigned int nr_pages;
+
+	if (!spin_trylock(&vmap_area_lock))
+		return false;
+	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
+	if (!va) {
+		spin_unlock(&vmap_area_lock);
+		return false;
+	}
 
-	vm = find_vm_area(objp);
-	if (!vm)
+	vm = va->vm;
+	if (!vm) {
+		spin_unlock(&vmap_area_lock);
 		return false;
+	}
+	addr = (unsigned long)vm->addr;
+	caller = vm->caller;
+	nr_pages = vm->nr_pages;
+	spin_unlock(&vmap_area_lock);
 	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
-		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
+		nr_pages, addr, caller);
 	return true;
 }
 #endif


