Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41C47D31F8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjJWLPR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233702AbjJWLPP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:15:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161FC2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:15:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F89C433C7;
        Mon, 23 Oct 2023 11:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059713;
        bh=v+8iHwjLJjDx0lG2Dm4kMWvqzgUdm7h2wdCrcQ0xjWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpgZYSZrLQR0JD6pj5TTBx34x9GsdRcreXFISbUDrOsuHiYkB9kDw8O4vsix/Muqm
         JeZFblkBORpcX2UH/Jw12UDJ1hifS7q1a4g44eAqaH0xFR6FI7izwi0leyr9wZVv8v
         GO1+t+jxAJtzPnGnGaODpLYOkqroHGDnBOPW6Hbk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Zangerl <az@breathe-safe.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 27/98] iio: pressure: ms5611: ms5611_prom_is_valid false negative bug
Date:   Mon, 23 Oct 2023 12:56:16 +0200
Message-ID: <20231023104814.543806837@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104813.580375891@linuxfoundation.org>
References: <20231023104813.580375891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Zangerl <az@breathe-safe.com>

commit fd39d9668f2ce9f4b05ad55e8c8d80c098073e0b upstream.

The ms5611 driver falsely rejects lots of MS5607-02BA03-50 chips
with "PROM integrity check failed" because it doesn't accept a prom crc
value of zero as legitimate.

According to the datasheet for this chip (and the manufacturer's
application note about the PROM CRC), none of the possible values for the
CRC are excluded - but the current code in ms5611_prom_is_valid() ends with

return crc_orig != 0x0000 && crc == crc_orig

Discussed with the driver author (Tomasz Duszynski) and he indicated that
at that time (2015) he was dealing with some faulty chip samples which
returned blank data under some circumstances and/or followed example code
which indicated CRC zero being bad.

As far as I can tell this exception should not be applied anymore; We've
got a few hundred custom boards here with this chip where large numbers
of the prom have a legitimate CRC value 0, and do work fine, but which the
current driver code wrongly rejects.

Signed-off-by: Alexander Zangerl <az@breathe-safe.com>
Fixes: c0644160a8b5 ("iio: pressure: add support for MS5611 pressure and temperature sensor")
Link: https://lore.kernel.org/r/2535-1695168070.831792@Ze3y.dhYT.s3fx
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/pressure/ms5611_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -79,7 +79,7 @@ static bool ms5611_prom_is_valid(u16 *pr
 
 	crc = (crc >> 12) & 0x000F;
 
-	return crc_orig != 0x0000 && crc == crc_orig;
+	return crc == crc_orig;
 }
 
 static int ms5611_read_prom(struct iio_dev *indio_dev)


