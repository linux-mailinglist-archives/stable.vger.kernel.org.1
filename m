Return-Path: <stable+bounces-7383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FDD81724D
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A164B23265
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8795142365;
	Mon, 18 Dec 2023 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J69AW12X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052337884;
	Mon, 18 Dec 2023 14:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E78C433C7;
	Mon, 18 Dec 2023 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908322;
	bh=91zZPdVcqptxp+QoCMFuBC6p8rZ8R0amXAfGtEUxBCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J69AW12XgCsLqo0ulAsfsaIaZhYVbrpt5pFZs4BTqLMET+bT8MHSwjDxP9pyyuFl3
	 tssSIjnnhcFgPdCiI4+ZtS3FUU649R+YbXLvWOcoh2JBR7b6dpPCHtWTATz2Wh8IDr
	 tXkCi/zgwRqPabTrXO8kXAGaCSHa20AUvQE3e4lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	kernel test robot <lkp@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 6.6 135/166] dmaengine: stm32-dma: avoid bitfield overflow assertion
Date: Mon, 18 Dec 2023 14:51:41 +0100
Message-ID: <20231218135111.131395020@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

commit 54bed6bafa0f38daf9697af50e3aff5ff1354fe1 upstream.

stm32_dma_get_burst() returns a negative error for invalid input, which
gets turned into a large u32 value in stm32_dma_prep_dma_memcpy() that
in turn triggers an assertion because it does not fit into a two-bit field:
drivers/dma/stm32-dma.c: In function 'stm32_dma_prep_dma_memcpy':
include/linux/compiler_types.h:354:38: error: call to '__compiletime_assert_282' declared with attribute error: FIELD_PREP: value too large for the field
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                         ^
   include/linux/compiler_types.h:335:4: note: in definition of macro '__compiletime_assert'
       prefix ## suffix();    \
       ^~~~~~
   include/linux/compiler_types.h:354:2: note: in expansion of macro '_compiletime_assert'
     _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
     ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                        ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:3: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
      ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:114:3: note: in expansion of macro '__BF_FIELD_CHECK'
      __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
      ^~~~~~~~~~~~~~~~
   drivers/dma/stm32-dma.c:1237:4: note: in expansion of macro 'FIELD_PREP'
       FIELD_PREP(STM32_DMA_SCR_PBURST_MASK, dma_burst) |
       ^~~~~~~~~~

As an easy workaround, assume the error can happen, so try to handle this
by failing stm32_dma_prep_dma_memcpy() before the assertion. It replicates
what is done in stm32_dma_set_xfer_param() where stm32_dma_get_burst() is
also used.

Fixes: 1c32d6c37cc2 ("dmaengine: stm32-dma: use bitfield helpers")
Fixes: a2b6103b7a8a ("dmaengine: stm32-dma: Improve memory burst management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311060135.Q9eMnpCL-lkp@intel.com/
Link: https://lore.kernel.org/r/20231106134832.1470305-1-amelie.delaunay@foss.st.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/stm32-dma.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1249,8 +1249,8 @@ static struct dma_async_tx_descriptor *s
 	enum dma_slave_buswidth max_width;
 	struct stm32_dma_desc *desc;
 	size_t xfer_count, offset;
-	u32 num_sgs, best_burst, dma_burst, threshold;
-	int i;
+	u32 num_sgs, best_burst, threshold;
+	int dma_burst, i;
 
 	num_sgs = DIV_ROUND_UP(len, STM32_DMA_ALIGNED_MAX_DATA_ITEMS);
 	desc = kzalloc(struct_size(desc, sg_req, num_sgs), GFP_NOWAIT);
@@ -1268,6 +1268,10 @@ static struct dma_async_tx_descriptor *s
 		best_burst = stm32_dma_get_best_burst(len, STM32_DMA_MAX_BURST,
 						      threshold, max_width);
 		dma_burst = stm32_dma_get_burst(chan, best_burst);
+		if (dma_burst < 0) {
+			kfree(desc);
+			return NULL;
+		}
 
 		stm32_dma_clear_reg(&desc->sg_req[i].chan_reg);
 		desc->sg_req[i].chan_reg.dma_scr =



