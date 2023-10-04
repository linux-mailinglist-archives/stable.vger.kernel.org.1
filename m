Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5116F7B8A46
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244386AbjJDSd6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244395AbjJDSd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:33:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6F9C9
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:33:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B9BC433C9;
        Wed,  4 Oct 2023 18:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444433;
        bh=NyYNO7MV3trmxZQkCuAJk/l2+1MWEJyQGIWqxZObnDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aBF8zgS2ZUdjAaNN6+HXihri0rXqgbU38wS2BjYlIrVrS6336KBj6PTHNN6y5l1p0
         x7xiES0k+5TJwdqEV6/QFrObeIqGg8Y9c6Uwe52E8NVo2rXSfd7z8F4SDa0ZIgzBXM
         l0Wx3UrnqmvBi6IGPZSrqm105FULC7EA8L+s0eAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kai Huang <kai.huang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 6.5 241/321] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG race
Date:   Wed,  4 Oct 2023 19:56:26 +0200
Message-ID: <20231004175240.417880255@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haitao Huang <haitao.huang@linux.intel.com>

commit c6c2adcba50c2622ed25ba5d5e7f05f584711358 upstream.

The SGX EPC reclaimer (ksgxd) may reclaim the SECS EPC page for an
enclave and set secs.epc_page to NULL. The SECS page is used for EAUG
and ELDU in the SGX page fault handler. However, the NULL check for
secs.epc_page is only done for ELDU, not EAUG before being used.

Fix this by doing the same NULL check and reloading of the SECS page as
needed for both EAUG and ELDU.

The SECS page holds global enclave metadata. It can only be reclaimed
when there are no other enclave pages remaining. At that point,
virtually nothing can be done with the enclave until the SECS page is
paged back in.

An enclave can not run nor generate page faults without a resident SECS
page. But it is still possible for a #PF for a non-SECS page to race
with paging out the SECS page: when the last resident non-SECS page A
triggers a #PF in a non-resident page B, and then page A and the SECS
both are paged out before the #PF on B is handled.

Hitting this bug requires that race triggered with a #PF for EAUG.
Following is a trace when it happens.

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:sgx_encl_eaug_page+0xc7/0x210
Call Trace:
 ? __kmem_cache_alloc_node+0x16a/0x440
 ? xa_load+0x6e/0xa0
 sgx_vma_fault+0x119/0x230
 __do_fault+0x36/0x140
 do_fault+0x12f/0x400
 __handle_mm_fault+0x728/0x1110
 handle_mm_fault+0x105/0x310
 do_user_addr_fault+0x1ee/0x750
 ? __this_cpu_preempt_check+0x13/0x20
 exc_page_fault+0x76/0x180
 asm_exc_page_fault+0x27/0x30

Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Cc:stable@vger.kernel.org
Link: https://lore.kernel.org/all/20230728051024.33063-1-haitao.huang%40linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/sgx/encl.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -235,6 +235,21 @@ static struct sgx_epc_page *sgx_encl_eld
 	return epc_page;
 }
 
+/*
+ * Ensure the SECS page is not swapped out.  Must be called with encl->lock
+ * to protect the enclave states including SECS and ensure the SECS page is
+ * not swapped out again while being used.
+ */
+static struct sgx_epc_page *sgx_encl_load_secs(struct sgx_encl *encl)
+{
+	struct sgx_epc_page *epc_page = encl->secs.epc_page;
+
+	if (!epc_page)
+		epc_page = sgx_encl_eldu(&encl->secs, NULL);
+
+	return epc_page;
+}
+
 static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 						  struct sgx_encl_page *entry)
 {
@@ -248,11 +263,9 @@ static struct sgx_encl_page *__sgx_encl_
 		return entry;
 	}
 
-	if (!(encl->secs.epc_page)) {
-		epc_page = sgx_encl_eldu(&encl->secs, NULL);
-		if (IS_ERR(epc_page))
-			return ERR_CAST(epc_page);
-	}
+	epc_page = sgx_encl_load_secs(encl);
+	if (IS_ERR(epc_page))
+		return ERR_CAST(epc_page);
 
 	epc_page = sgx_encl_eldu(entry, encl->secs.epc_page);
 	if (IS_ERR(epc_page))
@@ -339,6 +352,13 @@ static vm_fault_t sgx_encl_eaug_page(str
 
 	mutex_lock(&encl->lock);
 
+	epc_page = sgx_encl_load_secs(encl);
+	if (IS_ERR(epc_page)) {
+		if (PTR_ERR(epc_page) == -EBUSY)
+			vmret = VM_FAULT_NOPAGE;
+		goto err_out_unlock;
+	}
+
 	epc_page = sgx_alloc_epc_page(encl_page, false);
 	if (IS_ERR(epc_page)) {
 		if (PTR_ERR(epc_page) == -EBUSY)


