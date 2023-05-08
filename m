Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DA06FABFC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjEHLTb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235438AbjEHLTa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D937C61
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00E1562C57
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1199DC433D2;
        Mon,  8 May 2023 11:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544765;
        bh=vFyCSdljTu/Y0nlj6oYfKB7YFGtG6OIHEB/8OnmH2r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xCOX+UujM1RnxoJRMZYuXWSA62JaqCl3M2ib9yAJZUspolC83HGvae4wVNKJIQ42x
         /MkmxUeVfISFAvbx9S8tX+GBypwZD7b6b3wGjwkNBtBYMDpdbAoNT6LocxPXagOcbb
         tY3yxLHGU3kaw8RRliydfB0zHeMy/NXbOIaGuiuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ivan Vecera <ivecera@redhat.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 476/694] net/sched: cls_api: Initialize miss_cookie_node when action miss is not used
Date:   Mon,  8 May 2023 11:45:11 +0200
Message-Id: <20230508094449.278615236@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 2cc8a008d62f3c04eeb7ec6fe59e542802bb8df3 ]

Function tcf_exts_init_ex() sets exts->miss_cookie_node ptr only
when use_action_miss is true so it assumes in other case that
the field is set to NULL by the caller. If not then the field
contains garbage and subsequent tcf_exts_destroy() call results
in a crash.
Ensure that the field .miss_cookie_node pointer is NULL when
use_action_miss parameter is false to avoid this potential scenario.

Fixes: 80cd22c35c90 ("net/sched: cls_api: Support hardware miss to tc action")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230420183634.1139391-1-ivecera@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 35785a36c8029..3c3629c9e7b65 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3211,6 +3211,7 @@ int tcf_exts_init_ex(struct tcf_exts *exts, struct net *net, int action,
 #ifdef CONFIG_NET_CLS_ACT
 	exts->type = 0;
 	exts->nr_actions = 0;
+	exts->miss_cookie_node = NULL;
 	/* Note: we do not own yet a reference on net.
 	 * This reference might be taken later from tcf_exts_get_net().
 	 */
-- 
2.39.2



