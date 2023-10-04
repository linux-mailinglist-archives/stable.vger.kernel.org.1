Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B407B877B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243801AbjJDSFv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbjJDSFv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:05:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76F9C4
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:05:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A66FC433C7;
        Wed,  4 Oct 2023 18:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442747;
        bh=Wxa5SbyvzM4aqoIrT+W4jk1eoX8DEEtGSlO6Q+ZkzI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oM3R8YGICpvURm0IOWGQlmPWkNLw1NFSVSLudN+VCWNb/I/vir4PapJSExTi4tPWt
         VdaUw+Bhk0ZPOzGfrjUzZRcAO9ArgERkzix9mrPTP4HY6bHAamYPHiHgRGbwZULIvH
         e2rN1pz7fBhNyRwqv366S6oBgdJRAHz+/qeHJcv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 067/183] Fix up backport of 136191703038 ("interconnect: Teach lockdep about icc_bw_lock order")
Date:   Wed,  4 Oct 2023 19:54:58 +0200
Message-ID: <20231004175206.667866923@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

Add a missing include to fix the following build error:

drivers/interconnect/core.c: In function 'icc_init':
drivers/interconnect/core.c:1148:9: error: implicit declaration of function 'fs_reclaim_acquire' [-Werror=implicit-function-declaration]
 1148 |         fs_reclaim_acquire(GFP_KERNEL);
      |         ^~~~~~~~~~~~~~~~~~
drivers/interconnect/core.c:1150:9: error: implicit declaration of function 'fs_reclaim_release' [-Werror=implicit-function-declaration]
 1150 |         fs_reclaim_release(GFP_KERNEL);
      |         ^~~~~~~~~~~~~~~~~~

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index ab654b33f5d24..b7c41bd7409cd 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -13,6 +13,7 @@
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-- 
2.40.1



