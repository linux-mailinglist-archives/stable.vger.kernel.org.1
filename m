Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9FB72BF6F
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjFLKoI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjFLKnv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:43:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6498665B8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:28:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E36BA614F0
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064F6C4339B;
        Mon, 12 Jun 2023 10:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565720;
        bh=vKN0Ci9+WGjDnu/t3A75vI+hx/BXSg1Kpu4xyEQ7Izs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0d/6wsRa9Z+kGTLCrEy8ESQpo6wJTUifsDEaFHeLnEaPvyOhqp7eVHdG0TlXHk1Kh
         b/gRNpS55A0ebExaAL1Alt9o/YF+ci22zko8TrCDKvHyQxVZp/yCe1LLWZxrjVC5cQ
         1G4dGqtBTWk7HYN6VzlbcpQFYB6Z9Tpn1DMI0buc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev
Subject: [PATCH 4.14 02/21] i40e: fix build warnings in i40e_alloc.h
Date:   Mon, 12 Jun 2023 12:25:57 +0200
Message-ID: <20230612101651.160594831@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101651.048240731@linuxfoundation.org>
References: <20230612101651.048240731@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Not upstream as it was fixed in a much larger api change in newer
kernels.

gcc-13 rightfully complains that enum is not the same as an int, so fix
up the function prototypes in i40e_alloc.h to be correct, solving a
bunch of build warnings.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_alloc.h |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -43,16 +43,11 @@ enum i40e_memory_type {
 };
 
 /* prototype for functions used for dynamic memory allocation */
-i40e_status i40e_allocate_dma_mem(struct i40e_hw *hw,
-					    struct i40e_dma_mem *mem,
-					    enum i40e_memory_type type,
-					    u64 size, u32 alignment);
-i40e_status i40e_free_dma_mem(struct i40e_hw *hw,
-					struct i40e_dma_mem *mem);
-i40e_status i40e_allocate_virt_mem(struct i40e_hw *hw,
-					     struct i40e_virt_mem *mem,
-					     u32 size);
-i40e_status i40e_free_virt_mem(struct i40e_hw *hw,
-					 struct i40e_virt_mem *mem);
+int i40e_allocate_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem,
+			  enum i40e_memory_type type, u64 size, u32 alignment);
+int i40e_free_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem);
+int i40e_allocate_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem,
+			   u32 size);
+int i40e_free_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem);
 
 #endif /* _I40E_ALLOC_H_ */


