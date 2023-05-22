Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F62A70CA12
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjEVTyk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjEVTyj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9778599
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D9D262B6B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EEEC433D2;
        Mon, 22 May 2023 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785276;
        bh=pTB2crwC1cHJYOGMLJrzpKch14Nvu3b5igGgPiZutfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yETI99uInEnDpcrbTeDf4YDNOdzBsH3/0jINdOOs+kghin68B2xjTLRtB579yIyq3
         YqhG+OaBvX/5CREsAqdH7lykUIbJpew8AqFIn2hgoMTFZEo97wU3FtWllm6dhtp6ET
         A+EuAbgx5YNWQRhSfm/LcvGu3/TDJnOVxved+iMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Huayu Chen <huayu.chen@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.3 350/364] nfp: fix NFP_NET_MAX_DSCP definition error
Date:   Mon, 22 May 2023 20:10:55 +0100
Message-Id: <20230522190421.534393266@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Huayu Chen <huayu.chen@corigine.com>

commit de9c1a23add9e7842ce63ce6f498a05c66344311 upstream.

The patch corrects the NFP_NET_MAX_DSCP definition in the main.h file.

The incorrect definition result DSCP bits not being mapped properly when
DCB is set. When NFP_NET_MAX_DSCP was defined as 4, the next 60 DSCP
bits failed to be set.

Fixes: 9b7fe8046d74 ("nfp: add DCB IEEE support")
Cc: stable@vger.kernel.org
Signed-off-by: Huayu Chen <huayu.chen@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nic/main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nic/main.h b/drivers/net/ethernet/netronome/nfp/nic/main.h
index 094374df42b8..38b8b10b03cd 100644
--- a/drivers/net/ethernet/netronome/nfp/nic/main.h
+++ b/drivers/net/ethernet/netronome/nfp/nic/main.h
@@ -8,7 +8,7 @@
 
 #ifdef CONFIG_DCB
 /* DCB feature definitions */
-#define NFP_NET_MAX_DSCP	4
+#define NFP_NET_MAX_DSCP	64
 #define NFP_NET_MAX_TC		IEEE_8021QAZ_MAX_TCS
 #define NFP_NET_MAX_PRIO	8
 #define NFP_DCB_CFG_STRIDE	256
-- 
2.40.1



