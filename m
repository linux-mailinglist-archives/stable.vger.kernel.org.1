Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AF279B172
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbjIKU6o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240111AbjIKOgx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:36:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12683F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:36:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADEAC433C7;
        Mon, 11 Sep 2023 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443008;
        bh=BzJA00J92Jwiu9m1KydN/0SFGT1crpnvXUMxr7XTEcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zDnOhDnAcwG5Ap0dGZ11MPxXCxEd0UT/quYLzrrOtQKPOK//qTQ0NvmTBBmluL4c5
         NqJOfxbLrMJNTOy3vHdehudo7POQQRGHC53vFTxFPyt9BJK103cRoF+7EWLeaCMfW1
         lLuZfOnRxIkfPu15fpstq0j4dRnvJ98GBPCMbJDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yipeng Zou <zouyipeng@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Li Zetao <lizetao1@huawei.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 208/737] selftests/bpf: Fix repeat option when kfunc_call verification fails
Date:   Mon, 11 Sep 2023 15:41:07 +0200
Message-ID: <20230911134656.404158572@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yipeng Zou <zouyipeng@huawei.com>

[ Upstream commit 811915db674f8daf19bb4fcb67da9017235ce26d ]

There is no way where topts.repeat can be set to 1 when tc_test fails.
Fix the typo where the break statement slipped by one line.

Fixes: fb66223a244f ("selftests/bpf: add test for accessing ctx from syscall program type")
Signed-off-by: Yipeng Zou <zouyipeng@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Li Zetao <lizetao1@huawei.com>
Link: https://lore.kernel.org/bpf/20230814031434.3077944-1-zouyipeng@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index a543742cd7bd1..2eb71559713c9 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -173,8 +173,8 @@ static void verify_fail(struct kfunc_test_params *param)
 	case tc_test:
 		topts.data_in = &pkt_v4;
 		topts.data_size_in = sizeof(pkt_v4);
-		break;
 		topts.repeat = 1;
+		break;
 	}
 
 	skel = kfunc_call_fail__open_opts(&opts);
-- 
2.40.1



