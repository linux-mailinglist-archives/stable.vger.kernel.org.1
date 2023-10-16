Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E727CA381
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 11:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjJPJHN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 05:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjJPJHM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 05:07:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94526AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 02:07:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89DEC433C8;
        Mon, 16 Oct 2023 09:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697447230;
        bh=hfZkHKXXii5cxgIXtSs3l1Vm7f3M9u27i7YY70+wzHw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHLfQ3ZYU1xScGvUHpx1879FIqZ3qLZF8p1tTdeaV8B9clIQc+3Bg3ZUpm7TYPY6u
         gFYzx05Ds9iOfv9DqW3PN9VUVFWoLkUcxDK/z63H3CMiU+oHmgn86wotGWqTa0r5r3
         xknb4iFPNTj6nh8yvfSPahp2IGXRUx2H4C7OPaAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ondrej Zary <linux@zary.sk>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 6.5 014/191] ata: pata_parport: fix pata_parport_devchk
Date:   Mon, 16 Oct 2023 10:39:59 +0200
Message-ID: <20231016084015.735756664@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Zary <linux@zary.sk>

commit b555aa66760f17df4a0a5e4b440816e390311a38 upstream.

There's a 'x' missing in 0x55 in pata_parport_devchk(), causing the
detection to always fail. Fix it.

Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")
Cc: stable@vger.kernel.org
Signed-off-by: Ondrej Zary <linux@zary.sk>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/pata_parport/pata_parport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -64,7 +64,7 @@ static bool pata_parport_devchk(struct a
 	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
 	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
 
-	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
+	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
 	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0xaa);
 
 	nsect = pi->proto->read_regr(pi, 0, ATA_REG_NSECT);


