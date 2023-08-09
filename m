Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D4F775DB2
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjHILkX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjHILkX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C348173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E69FF63631
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC80AC433C8;
        Wed,  9 Aug 2023 11:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581221;
        bh=kewrziL5Hub/1PIVYSkHs63X2ux0ZmyLeNffAsgNFTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mZdqoCxlp//KroGVQGj2s1B04rb3fnqD4ZH8l6wnma6dxlVNB8+93b4nmohsa5Zoz
         EpGmKuR0pS8SQnFWwwTIsGBkLs8+fTHUOzgs/poY3KjLeSTXxyh7VdkEo5qZVaIKnk
         UyWTlceEE+C6AKzAMB/ZMxB2GJBpd0H28ZPwIiug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Li Huafei <lihuafei1@huawei.com>
Subject: [PATCH 5.10 119/201] x86/kprobes: Move inline to the beginning of the kprobe_is_ss() declaration
Date:   Wed,  9 Aug 2023 12:42:01 +0200
Message-ID: <20230809103647.749163395@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 2304d14db6595bea5292bece06c4c625b12d8f89 ]

Address this GCC warning:

  arch/x86/kernel/kprobes/core.c:940:1:
   warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
    940 | static int nokprobe_inline kprobe_is_ss(struct kprobe_ctlblk *kcb)
        | ^~~~~~

[ mingo: Tidied up the changelog. ]

Fixes: 6256e668b7af: ("x86/kprobes: Use int3 instead of debug trap for single-step")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20210324144502.1154883-1-weiyongjun1@huawei.com
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/kprobes/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -944,7 +944,7 @@ static int reenter_kprobe(struct kprobe
 }
 NOKPROBE_SYMBOL(reenter_kprobe);
 
-static int nokprobe_inline kprobe_is_ss(struct kprobe_ctlblk *kcb)
+static nokprobe_inline int kprobe_is_ss(struct kprobe_ctlblk *kcb)
 {
 	return (kcb->kprobe_status == KPROBE_HIT_SS ||
 		kcb->kprobe_status == KPROBE_REENTER);


