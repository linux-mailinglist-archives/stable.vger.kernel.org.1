Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ACA76AD6E
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHAJ3Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjHAJ3A (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1502D421A
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:27:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA3E161503
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68DEC433C9;
        Tue,  1 Aug 2023 09:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882068;
        bh=uGvdWJCsFNbf5m4VfhCqMqS0rCknEsFqq072qKtJ14I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0bW3EzS69dtejm9moQh2tizugJe75xLW4xFLQy1zxi1fqDVqrZOvRxfeQSoFH5Nl
         ag6ZqifBKZOikuIec3+FV6HGdTSGuztCTxmnZqW+o/SKyAFgdP5kBg+e0YXwRLfrhm
         Cl89ZnrqJE7gCH6iaYgXPcrCp8CcABxXbfL7Notg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gilles Buloz <gilles.buloz@kontron.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.15 130/155] hwmon: (nct7802) Fix for temp6 (PECI1) processed even if PECI1 disabled
Date:   Tue,  1 Aug 2023 11:20:42 +0200
Message-ID: <20230801091914.824675703@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gilles Buloz <Gilles.Buloz@kontron.com>

commit 54685abe660a59402344d5045ce08c43c6a5ac42 upstream.

Because of hex value 0x46 used instead of decimal 46, the temp6
(PECI1) temperature is always declared visible and then displayed
even if disabled in the chip

Signed-off-by: Gilles Buloz <gilles.buloz@kontron.com>
Link: https://lore.kernel.org/r/DU0PR10MB62526435ADBC6A85243B90E08002A@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
Fixes: fcdc5739dce03 ("hwmon: (nct7802) add temperature sensor type attribute")
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/nct7802.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -708,7 +708,7 @@ static umode_t nct7802_temp_is_visible(s
 	if (index >= 38 && index < 46 && !(reg & 0x01))		/* PECI 0 */
 		return 0;
 
-	if (index >= 0x46 && (!(reg & 0x02)))			/* PECI 1 */
+	if (index >= 46 && !(reg & 0x02))			/* PECI 1 */
 		return 0;
 
 	return attr->mode;


