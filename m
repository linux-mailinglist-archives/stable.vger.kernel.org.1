Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A06FA7D0
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbjEHKfG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbjEHKek (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:34:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323124A84
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:33:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D1AC62733
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:33:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359FAC433EF;
        Mon,  8 May 2023 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542035;
        bh=tBEsfSGHhI9epTkF+rTI6LdLgXaVZP+rMsYaJA8G0Po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzt8XcV8KEKJxn0yNb+Fhv47YShzJjhmLoD5smlaOWnjYXr+z4Fwen0MLd2T5tRPN
         NEZceJAetoGDRjCyCs+QIpmFGduVaKnNvBCrwjPl7mSUoq5LzU5Tfn6+JqmaGKvELv
         3PUcfwpuyg/hS0x7nkzvUdCfiGxOLX2LVe/H0Uwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 305/663] net: dsa: qca8k: remove assignment of an_enabled in pcs_get_state()
Date:   Mon,  8 May 2023 11:42:11 +0200
Message-Id: <20230508094438.081772843@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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
index 2f224b166bbb3..f7944fe2e0ba7 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1427,7 +1427,6 @@ static void qca8k_pcs_get_state(struct phylink_pcs *pcs,
 
 	state->link = !!(reg & QCA8K_PORT_STATUS_LINK_UP);
 	state->an_complete = state->link;
-	state->an_enabled = !!(reg & QCA8K_PORT_STATUS_LINK_AUTO);
 	state->duplex = (reg & QCA8K_PORT_STATUS_DUPLEX) ? DUPLEX_FULL :
 							   DUPLEX_HALF;
 
-- 
2.39.2



