Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA906703575
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbjEOQ7T (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243318AbjEOQ7R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88A7D92
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:59:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011F662A57
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77B1C433D2;
        Mon, 15 May 2023 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169955;
        bh=/3+bICBJRDiT+GRmkOQXF+bB+THNaZhIcXP1O47jEYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbr/vAbPg1qpFdWyXeaPBfbd62tHR3TXYP7dzFOgHDBq1xOvDYV2QV3lmtou7p9GA
         7Almes2tVRoC+lmDY3pDYw68rMVylR1FIOf3XNucOkRCtKVehFSKrhhjyqCP7Ofdcl
         xJyED1IozQcmYpc17eaX+VT3pXbuGzUnfpzfGiAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.3 225/246] perf/x86: Fix missing sample size update on AMD BRS
Date:   Mon, 15 May 2023 18:27:17 +0200
Message-Id: <20230515161729.340042361@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Namhyung Kim <namhyung@kernel.org>

commit 90befef5a9e820ccccc33181ec14c015980300cc upstream.

It missed to convert a PERF_SAMPLE_BRANCH_STACK user to call the new
perf_sample_save_brstack() helper in order to update the dyn_size.
This affects AMD Zen3 machines with the branch-brs event.

Fixes: eb55b455ef9c ("perf/core: Add perf_sample_save_brstack() helper")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20230427030527.580841-1-namhyung@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d096b04bf80e..9d248703cbdd 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1703,10 +1703,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event)) {
-			data.br_stack = &cpuc->lbr_stack;
-			data.sample_flags |= PERF_SAMPLE_BRANCH_STACK;
-		}
+		if (has_branch_stack(event))
+			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
-- 
2.40.1



