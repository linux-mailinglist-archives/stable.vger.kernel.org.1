Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B3F787318
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241956AbjHXPAF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242024AbjHXO7y (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2043BC7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3AF5670C1
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C548BC433C8;
        Thu, 24 Aug 2023 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889192;
        bh=jtzxm85/7FGHSl1UcsSqflXZbGwlIKrqYPKTjC4haQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgnyhdqKCaUXi4aty3A2cMw79+pWTltOAxQAHTkkvL1ARe3p8nW9Zic8RyIkymQQz
         1rvVogWMC1K9tKRQPTsXzcyuZR4MFmODbnpnR7iTratJDSAuFOlGMcmCBxisjlz53Z
         xgjQXb8Oco5/Tuw53IjLPeV3be+gAtkR+NKgmQxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        William Breathitt Gray <william.gray@linaro.org>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 047/135] iio: addac: stx104: Fix race condition when converting analog-to-digital
Date:   Thu, 24 Aug 2023 16:49:50 +0200
Message-ID: <20230824145028.972189144@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: William Breathitt Gray <william.gray@linaro.org>

[ Upstream commit 4f9b80aefb9e2f542a49d9ec087cf5919730e1dd ]

The ADC conversion procedure requires several device I/O operations
performed in a particular sequence. If stx104_read_raw() is called
concurrently, the ADC conversion procedure could be clobbered. Prevent
such a race condition by utilizing a mutex.

Fixes: 4075a283ae83 ("iio: stx104: Add IIO support for the ADC channels")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/r/2ae5e40eed5006ca735e4c12181a9ff5ced65547.1680790580.git.william.gray@linaro.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/stx104.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index e110a910235ff..b658a75d4e3a8 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -117,6 +117,8 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT;
 		}
 
+		mutex_lock(&priv->lock);
+
 		/* select ADC channel */
 		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
 
@@ -127,6 +129,8 @@ static int stx104_read_raw(struct iio_dev *indio_dev,
 		while (ioread8(&reg->cir_asr) & BIT(7));
 
 		*val = ioread16(&reg->ssr_ad);
+
+		mutex_unlock(&priv->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-- 
2.40.1



