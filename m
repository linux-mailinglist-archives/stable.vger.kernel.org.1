Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0379270C6A4
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjEVTUd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjEVTUc (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:20:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2DA3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBFEC6281C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED492C433EF;
        Mon, 22 May 2023 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783230;
        bh=LWKYDZPw56ysd+OlgRNoVjRw+jbHYGUeWBgLsS8860g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWoXXVu5/pICLdbreR/JHBH5k+45PBMkbQzq38x8c7LM2jODRd/4prlls/DmBT1qG
         bE4mbRU23yH5Yt/56sQuQpLPboN7rDBuzeKvwrXz0pdEaHd0EmIIepaEpb0ItPeOz4
         LjOq22ChC+7AhuB03LQbM8C+Lmiocx/vY/ClqFp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 154/203] cassini: Fix a memory leak in the error handling path of cas_init_one()
Date:   Mon, 22 May 2023 20:09:38 +0100
Message-Id: <20230522190359.240149248@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 412cd77a2c24b191c65ea53025222418db09817c ]

cas_saturn_firmware_init() allocates some memory using vmalloc(). This
memory is freed in the .remove() function but not it the error handling
path of the probe.

Add the missing vfree() to avoid a memory leak, should an error occur.

Fixes: fcaa40669cd7 ("cassini: use request_firmware")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sun/cassini.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 6472425539e15..21e4df8466c91 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -5123,6 +5123,8 @@ static int cas_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		cas_shutdown(cp);
 	mutex_unlock(&cp->pm_mutex);
 
+	vfree(cp->fw_data);
+
 	pci_iounmap(pdev, cp->regs);
 
 
-- 
2.39.2



