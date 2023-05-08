Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28E26FAB46
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjEHLLO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbjEHLLN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:11:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D579A34E12
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61C8D62B71
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F8FC433EF;
        Mon,  8 May 2023 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544271;
        bh=Q175l7yiLH7joxotR7q5mH+YUHJDYICx8eeUVLs8vE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Ts44TKAmx2qc8xyHExf9uo6ZObwCZKnaOO+5qj5lBQ4iqEjtjAY3Nm+AKBH4Kk1E
         SnmvsILyEBbeyekKftkIQOHfyJJfum1p4bZs3ZfAZi+sgyiAx3KUZVB0fYEwOubYy9
         Z0vaHbafw8FWCeF2DJ04/kU0a63kZgcsCY3jS7Do=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 357/694] net: dsa: qca8k: remove assignment of an_enabled in pcs_get_state()
Date:   Mon,  8 May 2023 11:43:12 +0200
Message-Id: <20230508094444.237135251@linuxfoundation.org>
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

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

[ Upstream commit 9ef70d0130f282638b28cfce24222f71ada00c9c ]

pcs_get_state() implementations are not supposed to alter an_enabled.
Remove this assignment.

Fixes: b3591c2a3661 ("net: dsa: qca8k: Switch to PHYLINK instead of PHYLIB")
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/E1pdsE5-00Dl2l-8F@rmk-PC.armlinux.org.uk
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index 55df4479ea30b..62810903f1b31 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1483,7 +1483,6 @@ static void qca8k_pcs_get_state(struct phylink_pcs *pcs,
 
 	state->link = !!(reg & QCA8K_PORT_STATUS_LINK_UP);
 	state->an_complete = state->link;
-	state->an_enabled = !!(reg & QCA8K_PORT_STATUS_LINK_AUTO);
 	state->duplex = (reg & QCA8K_PORT_STATUS_DUPLEX) ? DUPLEX_FULL :
 							   DUPLEX_HALF;
 
-- 
2.39.2



