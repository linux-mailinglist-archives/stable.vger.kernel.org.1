Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AB978AC4B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbjH1Ki4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjH1Ki3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A9618D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E41A63F91
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D988C433C9;
        Mon, 28 Aug 2023 10:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219104;
        bh=OQI1L7703gR+Yz2xJkZ3RQxTOjSNU4v6/n5JMhD+TWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNYVD+cxx0vnmw2A/5acujOZaFQQ1t2W7p9zi6oboD/8F7C10ru2kqPiviXuw0vSO
         O1m22CJiMiT55gfXjkol+VYlAtJftL38NDqD1NhuwjiZ5RBtfEMoMc6qKmWDPbzDoc
         Y2i2AGIHzgMuUmElxLrLr9xtGPFyEa/4BXV5AN1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 075/158] bus: ti-sysc: Improve reset to work with modules with no sysconfig
Date:   Mon, 28 Aug 2023 12:12:52 +0200
Message-ID: <20230828101159.808470237@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit ab4d309d8708035bd323b2e2446eb68cda5e61e5 ]

At least display susbsystem (DSS) has modules with no sysconfig registers
and rely on custom function for module reset handling. Let's make reset
work with that too.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Stable-dep-of: 34539b442b3b ("bus: ti-sysc: Flush posted write on enable before reset")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/ti-sysc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 44aeceaccfa48..c2808d118568e 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1809,7 +1809,7 @@ static int sysc_reset(struct sysc *ddata)
 
 	sysc_offset = ddata->offsets[SYSC_SYSCONFIG];
 
-	if (ddata->legacy_mode || sysc_offset < 0 ||
+	if (ddata->legacy_mode ||
 	    ddata->cap->regbits->srst_shift < 0 ||
 	    ddata->cfg.quirks & SYSC_QUIRK_NO_RESET_ON_INIT)
 		return 0;
@@ -1819,9 +1819,11 @@ static int sysc_reset(struct sysc *ddata)
 	if (ddata->pre_reset_quirk)
 		ddata->pre_reset_quirk(ddata);
 
-	sysc_val = sysc_read_sysconfig(ddata);
-	sysc_val |= sysc_mask;
-	sysc_write(ddata, sysc_offset, sysc_val);
+	if (sysc_offset >= 0) {
+		sysc_val = sysc_read_sysconfig(ddata);
+		sysc_val |= sysc_mask;
+		sysc_write(ddata, sysc_offset, sysc_val);
+	}
 
 	if (ddata->cfg.srst_udelay)
 		usleep_range(ddata->cfg.srst_udelay,
-- 
2.40.1



