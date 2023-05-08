Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F496FA5E2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjEHKOK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjEHKN4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:13:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421153A2A8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE54F6241D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E218C433D2;
        Mon,  8 May 2023 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540829;
        bh=SC9y+pEQHlJguhFZnc3o3pY1UeyVIR8hohLDH+7tbHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UeTKz/exMkuJgY6fcFTglwfTR+Jl9DbCC7FU8UUCq27r2m8MFnUI2iooYLVV6uilV
         qMBizDmN2jr/zMtvmIkPRcqqKutlQpf4uOFJZZuD7+3lJrzcQIH920wCqzsln3+tF6
         zezunN3OA3cg38bL+DAn6lq3PwXtJ0G6atMr1ZpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Kelley <mikelley@microsoft.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 513/611] swiotlb: fix debugfs reporting of reserved memory pools
Date:   Mon,  8 May 2023 11:45:55 +0200
Message-Id: <20230508094438.721712830@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 5499d01c029069044a3b3e50501c77b474c96178 ]

For io_tlb_nslabs, the debugfs code reports the correct value for a
specific reserved memory pool.  But for io_tlb_used, the value reported
is always for the default pool, not the specific reserved pool. Fix this.

Fixes: 5c850d31880e ("swiotlb: fix passing local variable to debugfs_create_ulong()")
Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/swiotlb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index bf1ed08ec541f..7f4ad5e70b40c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -919,7 +919,9 @@ EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
 static int io_tlb_used_get(void *data, u64 *val)
 {
-	*val = mem_used(&io_tlb_default_mem);
+	struct io_tlb_mem *mem = data;
+
+	*val = mem_used(mem);
 	return 0;
 }
 DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_used, io_tlb_used_get, NULL, "%llu\n");
@@ -932,7 +934,7 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 		return;
 
 	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
-	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, NULL,
+	debugfs_create_file("io_tlb_used", 0400, mem->debugfs, mem,
 			&fops_io_tlb_used);
 }
 
-- 
2.39.2



