Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D43722570
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 14:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjFEMUz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 08:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbjFEMUy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 08:20:54 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B83DF
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 05:20:52 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f624daccd1so1651180e87.0
        for <stable@vger.kernel.org>; Mon, 05 Jun 2023 05:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685967651; x=1688559651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqeY5bs+DmWzjxzftaET35zW0fUGL+nVoWcLOApDUo0=;
        b=GUceVYkewS4eA83dNeuAXQFncXhR3YH77cDA1ge4l7UMy0fIes8EaAQTVKO+pqg813
         0XNnn1z/HznlV7Q+gC+9FLZhgK/T3BK1O9eznG2yJ3wZFNfOIzFYH8jhSmSWTQ4irRto
         OQbN5hVCiDJoPba5IaYARmgXy9Vw8lNRYGGvITO7803uDapU8LjDtZY3VL1p8iJQzuOY
         wMpnraSA2WQwH4yP36WZXnnIUmWmJ5vwp+ZjaclFZn9AoIyMRQIqzBIDZEJhCO6HDoJa
         t/r2GMXO0YcsvvUM/AtWp5XDm4xTPsCeYa1VZgs6JHC2Shn1waBkIosmgefCt4dvoorp
         mnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685967651; x=1688559651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqeY5bs+DmWzjxzftaET35zW0fUGL+nVoWcLOApDUo0=;
        b=WRNVqZzYZmP2K05MSCYxJdeglLp6p5l1ZGReFh39JNhlUoVDix4FWB2x87ZGjdRHva
         KDvBotZGBb5SAIO25h5mAv/ctceOhXLXet4IPN57kc8lr2uo+/cgVveA0zkS8Phvmi4t
         Abwi8dxFYrqBw4KE1mXah8eeU5SDeFClcbOcZHc6pnPIzPd0ZLSlU7VIxggL7Fo/YGKB
         +avHM5e0qzX2o2RslMEX8t3cSfUoae0mnMFo2NP/A20ODqOTZpAwowHUXv/irUnvsw6y
         t84hSua/Q1T6VbC/B55HNNfXUPtzGdi1lmZrwR/h+vBBkCBVi4DUf24Ur55Iqz95UDdm
         ky1Q==
X-Gm-Message-State: AC+VfDzCFL99GiGpWeWqF27pt08xv2kYga1O4h9nNJVP3PhT6cn7g902
        OcQh+yGv4T7XHit5WCa8rLxQAA==
X-Google-Smtp-Source: ACHHUZ5fD8+QgzKrSmdXFVRKBwtF7kMAY7MX8UQf5NTkXe0CMQkNqckaxRvK4Rra4k/1/UBiKw6QAg==
X-Received: by 2002:ac2:51b1:0:b0:4ee:5aeb:e2f2 with SMTP id f17-20020ac251b1000000b004ee5aebe2f2mr5060466lfk.38.1685967651045;
        Mon, 05 Jun 2023 05:20:51 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id e8-20020a056512090800b004f20d0ebe50sm1106952lft.94.2023.06.05.05.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 05:20:50 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc:     kuba@kernel.org, simon.horman@corigine.com, joneslee@google.com,
        oliver@neukum.org, davem@davemloft.net, bay@hackerdom.ru,
        linux-usb@vger.kernel.org, netdev@vger.kernel.or,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH][stable-4.{14,19}.y 2/3] cdc_ncm: Fix the build warning
Date:   Mon,  5 Jun 2023 12:20:44 +0000
Message-ID: <20230605122045.2455888-3-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230605122045.2455888-1-tudor.ambarus@linaro.org>
References: <20230605122045.2455888-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Bersenev <bay@hackerdom.ru>

[ Upstream commit 5d0ab06b63fc9c727a7bb72c81321c0114be540b ]

The ndp32->wLength is two bytes long, so replace cpu_to_le32 with cpu_to_le16.

Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/net/usb/cdc_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 631c32e4bcc3..ae2a44ceb23d 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1175,7 +1175,7 @@ static struct usb_cdc_ncm_ndp32 *cdc_ncm_ndp32(struct cdc_ncm_ctx *ctx, struct s
 		ndp32 = ctx->delayed_ndp32;
 
 	ndp32->dwSignature = sign;
-	ndp32->wLength = cpu_to_le32(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
+	ndp32->wLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_ndp32) + sizeof(struct usb_cdc_ncm_dpe32));
 	return ndp32;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

