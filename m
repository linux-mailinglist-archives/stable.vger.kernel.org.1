Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E785D6FA8CD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjEHKpb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjEHKpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E560E26EA6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75E3662870
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:44:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74219C433EF;
        Mon,  8 May 2023 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542643;
        bh=pDdmsu5ZjSXezq895JcYOi7Dqz1tJtBcR0O+CujJIUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WGpvaMTplXVuPl/yT8dHdNlcmRjQiN+k3Cch7XxMnfgx/+HF65uA4SNZdqL2rQxrv
         QfOKdcm+bl65eHDiEesypjU6UKxmnKjdibAxTsGPwvlS6d9yVUC5jieaLnezJ9GRQ0
         xMkpcWDGK9L2Qt/UuaZVuRMLlDYeJuPrfel8t9hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, David Binderman <dcb314@hotmail.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 502/663] selftests/powerpc/pmu: Fix sample field check in the mmcra_thresh_marked_sample_test
Date:   Mon,  8 May 2023 11:45:28 +0200
Message-Id: <20230508094444.853759790@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Kajol Jain <kjain@linux.ibm.com>

[ Upstream commit 8a32341cf04ba05974931b4664683c2c9fb84e56 ]

The testcase verifies the setting of different fields in Monitor Mode
Control Register A (MMCRA). In the current code, EV_CODE_EXTRACT macro
is used to extract the "sample" field, which then needs to be further
processed to fetch rand_samp_elig and rand_samp_mode bits. But the
current code is not passing valid sample field to EV_CODE_EXTRACT
macro. Patch addresses this by fixing the input for EV_CODE_EXTRACT.

Fixes: 29cf373c5766 ("selftests/powerpc/pmu: Add interface test for mmcra register fields")
Reported-by: David Binderman <dcb314@hotmail.com>
Link: https://lore.kernel.org/r/DB6P189MB0568CF002762C6C43AF6DF169CA89@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230301170918.69176-1-kjain@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../pmu/sampling_tests/mmcra_thresh_marked_sample_test.c      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c
index 022cc1655eb52..75527876ad3c1 100644
--- a/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c
+++ b/tools/testing/selftests/powerpc/pmu/sampling_tests/mmcra_thresh_marked_sample_test.c
@@ -63,9 +63,9 @@ static int mmcra_thresh_marked_sample(void)
 			get_mmcra_thd_stop(get_reg_value(intr_regs, "MMCRA"), 4));
 	FAIL_IF(EV_CODE_EXTRACT(event.attr.config, marked) !=
 			get_mmcra_marked(get_reg_value(intr_regs, "MMCRA"), 4));
-	FAIL_IF(EV_CODE_EXTRACT(event.attr.config, sample >> 2) !=
+	FAIL_IF((EV_CODE_EXTRACT(event.attr.config, sample) >> 2) !=
 			get_mmcra_rand_samp_elig(get_reg_value(intr_regs, "MMCRA"), 4));
-	FAIL_IF(EV_CODE_EXTRACT(event.attr.config, sample & 0x3) !=
+	FAIL_IF((EV_CODE_EXTRACT(event.attr.config, sample) & 0x3) !=
 			get_mmcra_sample_mode(get_reg_value(intr_regs, "MMCRA"), 4));
 	FAIL_IF(EV_CODE_EXTRACT(event.attr.config, sm) !=
 			get_mmcra_sm(get_reg_value(intr_regs, "MMCRA"), 4));
-- 
2.39.2



