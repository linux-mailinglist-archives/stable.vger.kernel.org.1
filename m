Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49520703396
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242835AbjEOQjA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242827AbjEOQi4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:38:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA56719A5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:38:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7277662858
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:38:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66EAFC433D2;
        Mon, 15 May 2023 16:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168734;
        bh=J9KqHldngAsZFq9DGqTpcL3zgkhC+XFuMoW6LdTsWHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pO8bPltE0zmm/vN3/rSvexi2d490OtPRGzkTqZN4xMtHo7HQ7uq/RTF2f60BhI+BL
         /hS0WmrulWkZw4kD3bVgaOVGpbOzJVhsXc5rHTO6uLPfV+m9rwcM8vEVYiEAo0nhss
         YDBC7uuqdE2NiCy9syuEJf9ZIoaGC7ZFaLWWR9sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 004/191] iio: adc: palmas_gpadc: fix NULL dereference on rmmod
Date:   Mon, 15 May 2023 18:24:01 +0200
Message-Id: <20230515161707.361113275@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Patrik Dahlström <risca@dalakolonin.se>

[ Upstream commit 49f76c499d38bf67803438eee88c8300d0f6ce09 ]

Calling dev_to_iio_dev() on a platform device pointer is undefined and
will make adc NULL.

Signed-off-by: Patrik Dahlström <risca@dalakolonin.se>
Link: https://lore.kernel.org/r/20230313205029.1881745-1-risca@dalakolonin.se
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/palmas_gpadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 7dcd4213d38a0..6b76622b4fbfa 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -633,7 +633,7 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
 
 static int palmas_gpadc_remove(struct platform_device *pdev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(&pdev->dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(&pdev->dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 
 	if (adc->wakeup1_enable || adc->wakeup2_enable)
-- 
2.39.2



