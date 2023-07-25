Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E29761714
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjGYLo6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjGYLon (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AFC1FC4
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 781E961654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87587C433C8;
        Tue, 25 Jul 2023 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285481;
        bh=At2OdzTubxNB5ApbVmszxGOc252rO0IjayUST10w99g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JyqSQ+xfB26oegvi/0QSec45RWXQ2/h9hq2nGwCHoaEKAHhq+rcF5RtV1sq+VpsZr
         Nbuk9Tnzm65Ug7PpxYbsdT9EuMxf5B2pjSaoqCoj2aqp+YsckS7IfNpqhnm3Zgsf1R
         nYINuXS0PsNjMQdMGtJJ8tHT30bvwadjyXzRYMBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sherry Sun <sherry.sun@nxp.com>,
        stable <stable@kernel.org>
Subject: [PATCH 5.4 191/313] tty: serial: fsl_lpuart: add earlycon for imx8ulp platform
Date:   Tue, 25 Jul 2023 12:45:44 +0200
Message-ID: <20230725104529.255533632@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sherry Sun <sherry.sun@nxp.com>

commit e0edfdc15863ec80a1d9ac6e174dbccc00206dd0 upstream.

Add earlycon support for imx8ulp platform.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20230619080613.16522-1-sherry.sun@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/fsl_lpuart.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2409,6 +2409,7 @@ static int __init lpuart32_imx_early_con
 OF_EARLYCON_DECLARE(lpuart, "fsl,vf610-lpuart", lpuart_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,ls1021a-lpuart", lpuart32_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx7ulp-lpuart", lpuart32_imx_early_console_setup);
+OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8ulp-lpuart", lpuart32_imx_early_console_setup);
 OF_EARLYCON_DECLARE(lpuart32, "fsl,imx8qxp-lpuart", lpuart32_imx_early_console_setup);
 EARLYCON_DECLARE(lpuart, lpuart_early_console_setup);
 EARLYCON_DECLARE(lpuart32, lpuart32_early_console_setup);


