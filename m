Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C78C73FBAE
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjF0MGJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 27 Jun 2023 08:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjF0MGH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Jun 2023 08:06:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C265173C;
        Tue, 27 Jun 2023 05:06:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f954d78bf8so6269823e87.3;
        Tue, 27 Jun 2023 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687867564; x=1690459564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+M3NXPsx45UfjIfs1rUQSv4UcGmUhSpn+D7x2X92Y5o=;
        b=QVXvpiPjbiJFFCL4yOuXURwwSJsFzIdGVCKvku+kqCU8/WDEY3Rq2fAMBk9A7xrCAY
         kouTIJxKnV9HftD9ixVxSFqxHj798JkNOxSOxf6+lKj1S/p3ejhf0ZAWp/+iPQ1KGmfW
         PTR+fpNplsU7zyCXjzz4zjcnzT30PZwfDCv9WSD8R/0Mu6Wii9hcxpBc4fR6W+mfq2r0
         Vu/MAd/G/kxuLngDyG0uWXqz9ohBfWovsHB+8N6/mJgq3t04+G40LQhINxQdkiuqVwOg
         hMWiDyBnw0sEiOI6P2FlHyu8UNyMPvQZB1Q6ilmdMj8zd5kHp1MddqpTc5mqBrfwGDQl
         m3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687867564; x=1690459564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+M3NXPsx45UfjIfs1rUQSv4UcGmUhSpn+D7x2X92Y5o=;
        b=gwj6z4nVGFCxSSd7dPRprTdt+4ajyF7Y+bCnN4K9Y+nwKOueZc6/6PT6PFOvIWhJjd
         xHimRS5fTvlYOnDFFlKcBNsgaNhqUayx2qMwKeC4PRGdTbxP+FgYd4/8vE2t7UJjJKu1
         4RCZnC8wFDCJwjdXMxTopgoQT1eAFRHPoEuH0hbyI0tah2q13whuUo3fNKqKuRFuuRNv
         K0nEVCU0AjLPKlAhNS20D6Fao62dxnsuk5GLcAsbV+g9P2rAJwpS5alB2LxlFDGqiDeW
         vQH1qjs6oaWrKCiFo+vPRawDStkocubKNerxyFisHy5a6Yq3RAt1d3FiGqUVfspiElsm
         Rrkg==
X-Gm-Message-State: AC+VfDzBRQg48GXqlaFVEWoXxPGUtq1EW5Tu90COrDlfVpKBTm+2nBhj
        ShlQNiqHJIk148lGWuNW6f5GWJTAO14=
X-Google-Smtp-Source: ACHHUZ6mIukkgHhmP/8KDJzcpRgaK4+DpT2UKABHTVa6xvx+z0Vr6B/HBPlCedBPGV6SktvFQCcoOg==
X-Received: by 2002:a19:2d01:0:b0:4f8:7568:e94b with SMTP id k1-20020a192d01000000b004f87568e94bmr13356375lfj.56.1687867563265;
        Tue, 27 Jun 2023 05:06:03 -0700 (PDT)
Received: from saproj-Latitude-5501.yandex.net ([2a02:6b8:0:51e:5298:c58:431:de13])
        by smtp.gmail.com with ESMTPSA id q13-20020ac2514d000000b004fb771a5b2dsm701924lfd.1.2023.06.27.05.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 05:06:02 -0700 (PDT)
From:   Sergei Antonov <saproj@gmail.com>
To:     linux-mmc@vger.kernel.org
Cc:     Sergei Antonov <saproj@gmail.com>,
        Jonas Jensen <jonas.jensen@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] mmc: moxart: read scr register without changing byte order
Date:   Tue, 27 Jun 2023 15:05:49 +0300
Message-Id: <20230627120549.2400325-1-saproj@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Conversion from big-endian to native is done in a common function
mmc_app_send_scr(). Converting in moxart_transfer_pio() is extra.
Double conversion on a LE system returns an incorrect SCR value,
leads to errors:

mmc0: unrecognised SCR structure version 8

Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")
Signed-off-by: Sergei Antonov <saproj@gmail.com>
Cc: Jonas Jensen <jonas.jensen@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/moxart-mmc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 2d002c81dcf3..d0d6ffcf78d4 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -338,13 +338,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 				return;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
-				/* SCR data must be read in big endian. */
-				if (data->mrq->cmd->opcode == SD_APP_SEND_SCR)
-					*sgp = ioread32be(host->base +
-							  REG_DATA_WINDOW);
-				else
-					*sgp = ioread32(host->base +
-							REG_DATA_WINDOW);
+				*sgp = ioread32(host->base + REG_DATA_WINDOW);
 				sgp++;
 				len += 4;
 			}
-- 
2.37.2

