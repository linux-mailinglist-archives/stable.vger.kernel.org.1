Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7DC6FA599
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjEHKLP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjEHKLN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6620A3988D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B29DA623D5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E55C433D2;
        Mon,  8 May 2023 10:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540671;
        bh=qJukvqPquSrirTjGJMUxCsM2M72GFAlS7tjQZ05IVZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shGhZlZHP/QV14Z333OvPhkJozb421ZMRTbYaKbSyWFFS+jxuOt2kIYXmJahls4pw
         SR7vUJEz7YFNaoanpq3dGrPrnXCGRYBqx0eJfrfxvefkHnA+7ufCGxeDDR+urU9Qgi
         cqVmwGl/sYELL0vMAYCmeAYIqtqIowwV4rjRo57I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 422/611] ia64: mm/contig: fix section mismatch warning/error
Date:   Mon,  8 May 2023 11:44:24 +0200
Message-Id: <20230508094435.929499239@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 58deeb4ef3b054498747d0929d94ac53ab90981f ]

alloc_per_cpu_data() is called by find_memory(), which is marked as
__init.  Therefore alloc_per_cpu_data() can also be marked as __init to
remedy this modpost problem.

WARNING: modpost: vmlinux.o: section mismatch in reference: alloc_per_cpu_data (section: .text) -> memblock_alloc_try_nid (section: .init.text)

Link: https://lkml.kernel.org/r/20230223034258.12917-1-rdunlap@infradead.org
Fixes: 4b9ddc7cf272 ("[IA64] Fix section mismatch in contig.c version of per_cpu_init()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/ia64/mm/contig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 24901d8093015..1e9eaa107eb73 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -77,7 +77,7 @@ void *per_cpu_init(void)
 	return __per_cpu_start + __per_cpu_offset[smp_processor_id()];
 }
 
-static inline void
+static inline __init void
 alloc_per_cpu_data(void)
 {
 	size_t size = PERCPU_PAGE_SIZE * num_possible_cpus();
-- 
2.39.2



