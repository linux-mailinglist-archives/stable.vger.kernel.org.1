Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDF9791D3F
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237859AbjIDSgn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243526AbjIDSgn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:36:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6168CD4
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:36:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 401F8CE0D97
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9FFC433C8;
        Mon,  4 Sep 2023 18:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852596;
        bh=eRnKhddAfcuElZ5RQs2x0N3OEHz2nXw50goaE5ZKTKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K25ifClGmq0UiBIH0LZGLzqX3W7EARaDg1A0GVzSz8pY1cHeLc/hHj7halNOaQt1Y
         5sPXgcsepydqBWjn44Erfy/lrMIenKN2xZHIT2erwAEbJ9bEYJTY4zAorMzX9bnoLL
         f4XfrUttEPgFstnEdD/0rw5OiOFGq4nAhPpzK8Rs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Joshua Kinard <kumba@gentoo.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 5.15 07/28] rtc: ds1685: use EXPORT_SYMBOL_GPL for ds1685_rtc_poweroff
Date:   Mon,  4 Sep 2023 19:30:38 +0100
Message-ID: <20230904182945.528481821@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
References: <20230904182945.178705038@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1438,7 +1438,7 @@ ds1685_rtc_poweroff(struct platform_devi
 		unreachable();
 	}
 }
-EXPORT_SYMBOL(ds1685_rtc_poweroff);
+EXPORT_SYMBOL_GPL(ds1685_rtc_poweroff);
 /* ----------------------------------------------------------------------- */
 
 


