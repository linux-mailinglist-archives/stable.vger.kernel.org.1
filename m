Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F857A3C0B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbjIQU0K (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjIQUZl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:25:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C4D101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:25:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3766AC433C7;
        Sun, 17 Sep 2023 20:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982335;
        bh=iWbii0s3flvRT2s6kXaWpA71BLUFzvWGfmDfRMO6Gck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IenoFqoxRe8Tmv5g6Kk+a54quKQ6//dHlpOwKtjO42WgZIbzh10NlLyiFvVJW+vg9
         z0IJYG4dr4I19v+mjmFZ8/YtDVabJUS74oXSwfZWDsr1gXUCi6SeUfLgR+IGH/shLy
         w6KoGqcld0rBKy18dUuiWBGDOtp15k4/z9pt4MWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 213/511] powerpc/fadump: reset dump area size if fadump memory reserve fails
Date:   Sun, 17 Sep 2023 21:10:40 +0200
Message-ID: <20230917191118.962385794@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sourabh Jain <sourabhjain@linux.ibm.com>

[ Upstream commit d1eb75e0dfed80d2d85b664e28a39f65b290ab55 ]

In case fadump_reserve_mem() fails to reserve memory, the
reserve_dump_area_size variable will retain the reserve area size. This
will lead to /sys/kernel/fadump/mem_reserved node displaying an incorrect
memory reserved by fadump.

To fix this problem, reserve dump area size variable is set to 0 if fadump
failed to reserve memory.

Fixes: 8255da95e545 ("powerpc/fadump: release all the memory above boot memory size")
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230704050715.203581-1-sourabhjain@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/fadump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ad1c4575c61ce..d496dc5151aa1 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -642,6 +642,7 @@ int __init fadump_reserve_mem(void)
 	return ret;
 error_out:
 	fw_dump.fadump_enabled = 0;
+	fw_dump.reserve_dump_area_size = 0;
 	return 0;
 }
 
-- 
2.40.1



