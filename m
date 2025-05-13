Return-Path: <stable+bounces-144085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8972AAB49CB
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 04:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B9E8C273B
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 02:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C861D63EE;
	Tue, 13 May 2025 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJSTfGuB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEE01B3950;
	Tue, 13 May 2025 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105169; cv=none; b=fFmD4/YtLbWqJB1RP6bC2EkdxYWKc1e2DXBoHoaRBo7j4aQq8xP3Yba4Qgzc4EWBKkY+qRgIwhL0oIe2QuSY05dxGvwjXegrGoQ4WiYEEbOw0+hLGure/Q8sPNOwPjH+AfdbD84ULijigMkWBi9YwoOZFviyxav7TwafxGUMNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105169; c=relaxed/simple;
	bh=xnBuJ33IjmxKii5QXnuU99dRaHGsgayvZv3tVyw/OB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gd/35j0gNFB9X2xw8+rqM9d12qG4/u+aFjZSlWMF/ykh9UfF37o7essYGtdzGJ7flHtbtp6YqV79EcB7n2NsHHUMlfBXRRWsRcSFPxTzCp+FFtyEjjOqoiXkVvXHIm9JnQrs+SLjJw40UFz3pAbuZf9hE9RAkWqRwLCkgXt0DM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJSTfGuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F84AC4CEEE;
	Tue, 13 May 2025 02:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747105169;
	bh=xnBuJ33IjmxKii5QXnuU99dRaHGsgayvZv3tVyw/OB4=;
	h=From:To:Cc:Subject:Date:From;
	b=cJSTfGuB7W6s0Ho/oDcxqTuuosSul45OM5now9iXhf+0TnRTTRjISmJsH98ckeTeO
	 4mXFgWqyXel6VNHoOF7QpyBkJKe6bTMlXOkSjA/9qGxg9DcTzmvFCBhWhr1Wsr7LMB
	 wYaPLHfuO2o8K8ZoVrOS20yMvH4vRjOaVCykU85PqjNXYNPKSE6o6ehjhEykBLZIsp
	 dMGB6U0jnP1/lT0qLSEbsoDPVrac4lY28SZmhhwTcrYibea5lBnhfkeg5HY6LtTHSz
	 NCbNFQ+grb5Y2PJ+c4XEc21tiW+3gpBW6CDEDJw9LfOj2H2MQxtksQn54D8llpx7gU
	 reFJjz/akrrRg==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
Date: Mon, 12 May 2025 19:58:39 -0700
Message-ID: <20250513025839.495755-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Fix several build errors when CONFIG_MODULES=n, including the following:

../arch/x86/kernel/alternative.c:195:25: error: incomplete definition of type 'struct module'
  195 |         for (int i = 0; i < mod->its_num_pages; i++) {

Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/kernel/alternative.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 48fd04e90114..45bcff181cba 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -131,11 +131,13 @@ const unsigned char * const x86_nops[ASM_NOP_MAX+1] =
 static bool cfi_paranoid __ro_after_init;
 #endif
 
 #ifdef CONFIG_MITIGATION_ITS
 
+#ifdef CONFIG_MODULES
 static struct module *its_mod;
+#endif
 static void *its_page;
 static unsigned int its_offset;
 
 /* Initialize a thunk with the "jmp *reg; int3" instructions. */
 static void *its_init_thunk(void *thunk, int reg)
@@ -169,10 +171,11 @@ static void *its_init_thunk(void *thunk, int reg)
 	bytes[i++] = 0xcc;
 
 	return thunk + offset;
 }
 
+#ifdef CONFIG_MODULES
 void its_init_mod(struct module *mod)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_INDIRECT_THUNK_ITS))
 		return;
 
@@ -207,18 +210,20 @@ void its_free_mod(struct module *mod)
 		void *page = mod->its_page_array[i];
 		execmem_free(page);
 	}
 	kfree(mod->its_page_array);
 }
+#endif /* CONFIG_MODULES */
 
 static void *its_alloc(void)
 {
 	void *page __free(execmem) = execmem_alloc(EXECMEM_MODULE_TEXT, PAGE_SIZE);
 
 	if (!page)
 		return NULL;
 
+#ifdef CONFIG_MODULES
 	if (its_mod) {
 		void *tmp = krealloc(its_mod->its_page_array,
 				     (its_mod->its_num_pages+1) * sizeof(void *),
 				     GFP_KERNEL);
 		if (!tmp)
@@ -227,10 +232,11 @@ static void *its_alloc(void)
 		its_mod->its_page_array = tmp;
 		its_mod->its_page_array[its_mod->its_num_pages++] = page;
 
 		execmem_make_temp_rw(page, PAGE_SIZE);
 	}
+#endif /* CONFIG_MODULES */
 
 	return no_free_ptr(page);
 }
 
 static void *its_allocate_thunk(int reg)

base-commit: 627277ba7c2398dc4f95cc9be8222bb2d9477800
-- 
2.49.0


