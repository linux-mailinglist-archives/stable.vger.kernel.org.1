Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161AD7CAC66
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjJPOyH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjJPOyG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:54:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451FCD9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:54:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDCBC433CA;
        Mon, 16 Oct 2023 14:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468044;
        bh=keGMwBChcctvJKXNnHiG7p1O4BKbwInx2+3M/kfTSco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CaHuU/qR1SjTLwElM8QUr+Te47YopgK30T6E6ihs/WLXRQQiA6RYqx5ORsmKuouJV
         +jeZg+AV0PjtBY0XQxQQlqfhSkxcFJT7p8m2UnzRw9eZJQvMZN8w1mXwyhT0nmhOYX
         wfyqbGImh9CRT4hWhNuI5Q2W3m5mZaA0mc2xvPGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.5 114/191] iio: admv1013: add mixer_vgate corner cases
Date:   Mon, 16 Oct 2023 10:41:39 +0200
Message-ID: <20231016084018.045249575@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit 287d998af24326b009ae0956820a3188501b34a0 upstream.

Include the corner cases in the computation of the MIXER_VGATE register
value.

According to the datasheet: The MIXER_VGATE values follows the VCM such
as, that for a 0V to 1.8V VCM, MIXER_VGATE = 23.89 VCM + 81, and for a >
1.8V to 2.6V VCM, MIXER_VGATE = 23.75 VCM + 1.25.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230807143806.6954-1-antoniu.miclaus@analog.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/frequency/admv1013.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -351,9 +351,9 @@ static int admv1013_update_mixer_vgate(s
 	if (vcm < 0)
 		return vcm;
 
-	if (vcm < 1800000)
+	if (vcm <= 1800000)
 		mixer_vgate = (2389 * vcm / 1000000 + 8100) / 100;
-	else if (vcm > 1800000 && vcm < 2600000)
+	else if (vcm > 1800000 && vcm <= 2600000)
 		mixer_vgate = (2375 * vcm / 1000000 + 125) / 100;
 	else
 		return -EINVAL;


