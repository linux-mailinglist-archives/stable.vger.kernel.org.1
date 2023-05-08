Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644306FA8A7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjEHKoB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbjEHKn0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905212A850
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7056E6282E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8942AC433D2;
        Mon,  8 May 2023 10:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542534;
        bh=qJukvqPquSrirTjGJMUxCsM2M72GFAlS7tjQZ05IVZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvQ0JOHPFNMAGlaR75PBGU1PDeiojG9yyuUqQ14vMWwTA2s3xRr56zJzrFdS+AKku
         TPUHs3e58qlrc8xvjxmJdkwJ4shEhx8dpNP3KfFvTk5FTYLR1dByFxPnFf2tShOjSA
         zRFYQcEjCfuS2pMZrYFyESCwsOPYAOkNG5fHs9PM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 467/663] ia64: mm/contig: fix section mismatch warning/error
Date:   Mon,  8 May 2023 11:44:53 +0200
Message-Id: <20230508094443.358600977@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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



