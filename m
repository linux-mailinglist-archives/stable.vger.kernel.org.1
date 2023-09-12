Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77E79B44B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbjIKWjg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242259AbjIKP0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:26:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBC2D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:26:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557CCC433C8;
        Mon, 11 Sep 2023 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445965;
        bh=LYH8IDTP7evmP/HHH/BHdh798vYVT+Y7WOinTRkyrf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LmlwCwKPEH42wmyh8jIJ+Uf1FbDlsGCkHqFaQVC339sWIwYXnedugkl5dXhP4d5QI
         Vbk9PRfNlKpSq+VUm6yYxwoxqv7n9Qwo5/RBJjJeEHAPbMhiIQPUklPB73x4o5icUv
         BnsbTKXRttoz6ZPxUDKMoNWVnK0jldRJsDRwlGBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yi Yang <yiyang13@huawei.com>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Corey Minyard <minyard@acm.org>, GONG@vger.kernel.org
Subject: [PATCH 6.1 534/600] ipmi_si: fix a memleak in try_smi_init()
Date:   Mon, 11 Sep 2023 15:49:27 +0200
Message-ID: <20230911134649.390164331@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yi Yang <yiyang13@huawei.com>

commit 6cf1a126de2992b4efe1c3c4d398f8de4aed6e3f upstream.

Kmemleak reported the following leak info in try_smi_init():

unreferenced object 0xffff00018ecf9400 (size 1024):
  comm "modprobe", pid 2707763, jiffies 4300851415 (age 773.308s)
  backtrace:
    [<000000004ca5b312>] __kmalloc+0x4b8/0x7b0
    [<00000000953b1072>] try_smi_init+0x148/0x5dc [ipmi_si]
    [<000000006460d325>] 0xffff800081b10148
    [<0000000039206ea5>] do_one_initcall+0x64/0x2a4
    [<00000000601399ce>] do_init_module+0x50/0x300
    [<000000003c12ba3c>] load_module+0x7a8/0x9e0
    [<00000000c246fffe>] __se_sys_init_module+0x104/0x180
    [<00000000eea99093>] __arm64_sys_init_module+0x24/0x30
    [<0000000021b1ef87>] el0_svc_common.constprop.0+0x94/0x250
    [<0000000070f4f8b7>] do_el0_svc+0x48/0xe0
    [<000000005a05337f>] el0_svc+0x24/0x3c
    [<000000005eb248d6>] el0_sync_handler+0x160/0x164
    [<0000000030a59039>] el0_sync+0x160/0x180

The problem was that when an error occurred before handlers registration
and after allocating `new_smi->si_sm`, the variable wouldn't be freed in
the error handling afterwards since `shutdown_smi()` hadn't been
registered yet. Fix it by adding a `kfree()` in the error handling path
in `try_smi_init()`.

Cc: stable@vger.kernel.org # 4.19+
Fixes: 7960f18a5647 ("ipmi_si: Convert over to a shutdown handler")
Signed-off-by: Yi Yang <yiyang13@huawei.com>
Co-developed-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
Signed-off-by: GONG, Ruiqi <gongruiqi@huaweicloud.com>
Message-Id: <20230629123328.2402075-1-gongruiqi@huaweicloud.com>
Signed-off-by: Corey Minyard <minyard@acm.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -2082,6 +2082,11 @@ static int try_smi_init(struct smi_info
 		new_smi->io.io_cleanup = NULL;
 	}
 
+	if (rv && new_smi->si_sm) {
+		kfree(new_smi->si_sm);
+		new_smi->si_sm = NULL;
+	}
+
 	return rv;
 }
 


