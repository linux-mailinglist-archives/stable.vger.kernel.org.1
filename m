Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB33F726CD1
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjFGUgs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjFGUgg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:36:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D82708
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F1264580
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C75C4339B;
        Wed,  7 Jun 2023 20:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170172;
        bh=1IVIz9XbsewC6jOdqS//AYGIUJoXfZXMohb6vXnYLLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPdQIBthGB7SbSly6Q2oIJSCZLyJpQ5s7oQ8w3VxH4su7SWTB9sTk3I+4aAPulsbx
         HVlEhMn2uoZNbLRp31d2f5/G0rH3pNrgPf6FgQcs+rzPan5S2hliCn2ncEcZ7wTB7Y
         oYX+f6BhGH6wkJTwiSvOCWTqTGcO7Rcc3ALWbFXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Liska <mliska@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 73/88] eth: sun: cassini: remove dead code
Date:   Wed,  7 Jun 2023 22:16:30 +0200
Message-ID: <20230607200901.517123667@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200854.030202132@linuxfoundation.org>
References: <20230607200854.030202132@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Martin Liška <mliska@suse.cz>

commit 32329216ca1d6ee29c41215f18b3053bb6158541 upstream.

Fixes the following GCC warning:

drivers/net/ethernet/sun/cassini.c:1316:29: error: comparison between two arrays [-Werror=array-compare]
drivers/net/ethernet/sun/cassini.c:3783:34: error: comparison between two arrays [-Werror=array-compare]

Note that 2 arrays should be compared by comparing of their addresses:
note: use ‘&cas_prog_workaroundtab[0] == &cas_prog_null[0]’ to compare the addresses

Signed-off-by: Martin Liska <mliska@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/sun/cassini.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -1337,7 +1337,7 @@ static void cas_init_rx_dma(struct cas *
 	writel(val, cp->regs + REG_RX_PAGE_SIZE);
 
 	/* enable the header parser if desired */
-	if (CAS_HP_FIRMWARE == cas_prog_null)
+	if (&CAS_HP_FIRMWARE[0] == &cas_prog_null[0])
 		return;
 
 	val = CAS_BASE(HP_CFG_NUM_CPU, CAS_NCPUS > 63 ? 0 : CAS_NCPUS);
@@ -3807,7 +3807,7 @@ static void cas_reset(struct cas *cp, in
 
 	/* program header parser */
 	if ((cp->cas_flags & CAS_FLAG_TARGET_ABORT) ||
-	    (CAS_HP_ALT_FIRMWARE == cas_prog_null)) {
+	    (&CAS_HP_ALT_FIRMWARE[0] == &cas_prog_null[0])) {
 		cas_load_firmware(cp, CAS_HP_FIRMWARE);
 	} else {
 		cas_load_firmware(cp, CAS_HP_ALT_FIRMWARE);


