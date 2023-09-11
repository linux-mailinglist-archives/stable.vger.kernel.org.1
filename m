Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52D679B36B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243485AbjIKVH6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240899AbjIKO4x (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:56:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D70E4D
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:56:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F807C433C7;
        Mon, 11 Sep 2023 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444208;
        bh=lLtKGAFVMMwu5M6NKu5TL0MyoXDLpOHT2Ure+O4Y1G4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yjhW4x91otZzbf71lvbQ8Np1qtCvVs1HgBf0Lm6mxiyXaAIQ0VZvh1WHYOwpDtXiv
         R5Sn54cFn4/GZ2dDrrWjEaYd+rFYqtNBCACZEAwjwcIBaWHMFbVo8aZKc2cR6Nxdn8
         6vvPMoDaUAwRiAkNrvasfg75I4BSAZ/T0vBoyve8=
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
Subject: [PATCH 6.4 649/737] mm/vmalloc: add a safer version of find_vm_area() for debug
Date:   Mon, 11 Sep 2023 15:48:28 +0200
Message-ID: <20230911134708.660099582@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4228,14 +4228,32 @@ void pcpu_free_vm_areas(struct vm_struct
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


