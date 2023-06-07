Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72670726F3D
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjFGU4l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjFGU4k (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:56:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B0595
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36CFB64841
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D3EC433EF;
        Wed,  7 Jun 2023 20:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171395;
        bh=1IVIz9XbsewC6jOdqS//AYGIUJoXfZXMohb6vXnYLLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQjzZI4jrGCKS5qGIA5Fg6GBsrTPIzLIN1Rj9qIOFPMbH5l5849Gy8PClej5Y5bcB
         pkNGaTaVm1+ao1rdoQK76nt+0colj+9zZckKneeVjf9Vc4QwukhR1y4ZiDwjTL0Uot
         s8eIQPDk9DlTt43+7bHoczBX86efbhtpyf8CsS2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Liska <mliska@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 77/99] eth: sun: cassini: remove dead code
Date:   Wed,  7 Jun 2023 22:17:09 +0200
Message-ID: <20230607200902.638256910@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
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


