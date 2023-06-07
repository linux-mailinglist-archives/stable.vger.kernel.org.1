Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD40726DAF
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbjFGUon (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjFGUok (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:44:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1F126A1
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6E2364659
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0276CC433D2;
        Wed,  7 Jun 2023 20:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170632;
        bh=USqT1BCcfvxUUETFEoZgbk+sL8dWQf8GU16zKNoZJEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USO1iEQwSaAmJoY2r3IdIlplIH+CmClw59H4npjDX26uqQqaovPSfz1HPbXR9/j0N
         dnKFrec4f82hyeazor/6Ine35DYfwZTw1s/vkd7qDD//CIwxBi3fW3o/zDYpL2UwrC
         2dolzBsQt0tAH1woE+OdCPkMxkjwNNEYzZxlPJ6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nuno Sa <nuno.sa@analog.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.1 151/225] iio: addac: ad74413: fix resistance input processing
Date:   Wed,  7 Jun 2023 22:15:44 +0200
Message-ID: <20230607200919.351771058@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 24febc99ca725dcf42d57168a2f4e8a75a5ade92 upstream.

On success, ad74413r_get_single_adc_result() returns IIO_VAL_INT aka
1. So currently, the IIO_CHAN_INFO_PROCESSED case is effectively
equivalent to the IIO_CHAN_INFO_RAW case, and we never call
ad74413r_adc_to_resistance_result() to convert the adc measurement to
ohms.

Check ret for being negative rather than non-zero.

Fixes: fea251b6a5dbd (iio: addac: add AD74413R driver)
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230503095817.452551-1-linux@rasmusvillemoes.dk
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/addac/ad74413r.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -973,7 +973,7 @@ static int ad74413r_read_raw(struct iio_
 
 		ret = ad74413r_get_single_adc_result(indio_dev, chan->channel,
 						     val);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ad74413r_adc_to_resistance_result(*val, val);


