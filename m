Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A0B7A7A98
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbjITLoC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjITLoB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:44:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3AAB0
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:43:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76204C433C7;
        Wed, 20 Sep 2023 11:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210235;
        bh=y5bo3q4hiS6F1vqDF9scD4Q1ya8pAzkLO+8El/qj+1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byl7Vlnhodr8nMFxcn8DDYcXSe4DPVyFRbSPlNR79L2+7lTaObwohsVyu2WL2dupL
         Fp40Em0jxZJuZ3DzF1fMKhjZYz5cXOOwVd/usgnEQ+KgIkHy2MLOp+he7BVzD5+dNh
         FRIQB3N3Gvtc1RUWk/AQ1gmQhg3R1DnAOMjEnCNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 015/211] kselftest/arm64: fix a memleak in zt_regs_run()
Date:   Wed, 20 Sep 2023 13:27:39 +0200
Message-ID: <20230920112846.294300219@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

[ Upstream commit 46862da15e37efedb7d2d21e167f506c0b533772 ]

If memcmp() does not return 0, "zeros" need to be freed to prevent memleak

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Link: https://lore.kernel.org/r/20230815074915.245528-1-dingxiang@cmss.chinamobile.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/zt_regs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/zt_regs.c b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
index e1eb4d5c027ab..2e384d731618b 100644
--- a/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
@@ -65,6 +65,7 @@ int zt_regs_run(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
 	if (memcmp(zeros, (char *)zt + ZT_SIG_REGS_OFFSET,
 		   ZT_SIG_REGS_SIZE(zt->nregs)) != 0) {
 		fprintf(stderr, "ZT data invalid\n");
+		free(zeros);
 		return 1;
 	}
 
-- 
2.40.1



