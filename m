Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85260791CC6
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjIDSbY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbjIDSbY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:31:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C128B2
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:31:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA220B80EF4
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3570FC433CA;
        Mon,  4 Sep 2023 18:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852278;
        bh=fYPMrGGZhW6UK/qAMnqpY2Za9OJy+JxpK4Q0JLbLRR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D5wb1jZyLJra28y3irYAouaiHtHt5tS91XSlzdSEXXXH1pTSaWXmQeb4m47rMh99u
         KZYcyQx/C2vJtfJqPT1gmKxZW5jp3ISk9ZVrmT/ICdCkaPJ5b5uPbCwctwMYQSB9At
         hij/N33XA0BXMhrMka/5PE8IOxwJG/fw5uhJLMnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Joshua Kinard <kumba@gentoo.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.5 10/34] rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
Date:   Mon,  4 Sep 2023 19:29:57 +0100
Message-ID: <20230904182949.062298527@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
References: <20230904182948.594404081@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

commit 95e7ebc6823170256a8ce19fad87912805bfa001 upstream.

ds1685_rtc_poweroff is only used externally via symbol_get, which was
only ever intended for very internal symbols like this one.  Use
EXPORT_SYMBOL_GPL for it so that symbol_get can enforce only being used
on EXPORT_SYMBOL_GPL symbols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Joshua Kinard <kumba@gentoo.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-ds1685.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -1432,7 +1432,7 @@ ds1685_rtc_poweroff(struct platform_devi
 		unreachable();
 	}
 }
-EXPORT_SYMBOL(ds1685_rtc_poweroff);
+EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
 /* ----------------------------------------------------------------------- */
 
 


