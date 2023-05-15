Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496877035CF
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243520AbjEORC6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243438AbjEORCd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBF693ED
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDF1962A44
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:00:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA975C433EF;
        Mon, 15 May 2023 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170030;
        bh=OORrfuUZocx0djOc4uov2tXBCCCru7qy0rWNyvf1UuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mm6jHwW7v8gcmrvOqfp/HqfpZj+VK9IusNrHDkCj6/hSRtQXDP/ZsA3GtuqjkoV5D
         Wza7eRznTGNr7e9WW+cRPE7L35u0aOZA/vzx08As4hoF7lkmjG3xkuMkEWbM3vaugz
         sdgzwwZ1U7b0X9504jJO2imDP7qE2wt+0ZxBxf38=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vlad Buslov <vladbu@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.3 213/246] Revert "net/sched: flower: Fix wrong handle assignment during filter change"
Date:   Mon, 15 May 2023 18:27:05 +0200
Message-Id: <20230515161728.987764060@linuxfoundation.org>
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

From: Vlad Buslov <vladbu@nvidia.com>

commit 5110f3ff6d3c986df9575c8da86630578b7f0846 upstream.

This reverts commit 32eff6bacec2cb574677c15378169a9fa30043ef.

Superseded by the following commit in this series.

Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/cls_flower.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2231,8 +2231,8 @@ static int fl_change(struct net *net, st
 			kfree(fnew);
 			goto errout_tb;
 		}
-		fnew->handle = handle;
 	}
+	fnew->handle = handle;
 
 	err = tcf_exts_init_ex(&fnew->exts, net, TCA_FLOWER_ACT, 0, tp, handle,
 			       !tc_skip_hw(fnew->flags));


