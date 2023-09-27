Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013BB7AFBC5
	for <lists+stable@lfdr.de>; Wed, 27 Sep 2023 09:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjI0HQe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 27 Sep 2023 03:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjI0HQd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 27 Sep 2023 03:16:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF9D10E;
        Wed, 27 Sep 2023 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695798993; x=1727334993;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HnwmIUpF4rR+iQji+SOxSN+MPrsMRnb5JliJdurMx9U=;
  b=ZoTDX1X3gmAGglEEHQQ6vs8JN7LFNRUCyDsll27iZ10hKah7DTbNRDNS
   M1hfcLDg81HEEn1aoXxJ8gOGiI4qhlR/w0OjyC3hMgFAAYfvtihRlJ0hO
   cqja8FkTtr2in6xtlCfBg/y01QBb6H+GxjoWToICerk+oeuYLhSeNfmqW
   KEtLg58NUnp2E/BDLUyo4KK1SWpNySM4Lzh1c2yhddThXrIWNWKej6qxB
   4sH3S2BVryc65H97vnA/Xf/jA41pRuccghcWNSghTW4gNuwXsZBJyqo75
   nKNgcbNFS5hyEryE+q99iSQESE42tZQGY5O7jRGD8XvleBuPYFshfUzxG
   Q==;
X-CSE-ConnectionGUID: rCzh9KPAQp+j4XJ2F4emjw==
X-CSE-MsgGUID: DtJUjY3XTquPZNS3V+E7qQ==
X-IronPort-AV: E=Sophos;i="6.03,179,1694707200"; 
   d="scan'208";a="357153112"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2023 15:16:30 +0800
IronPort-SDR: PlpGxjWo7XvhnCZPoTjKUkR+/AxYSl8IhOXr2svbg9ouUnPa6jG5Lgy1S5Uq3H+5Rwy7UgJ3BM
 jlEjc8LTKTPgjCiNX+XNutOAXo4ky7hOAS03+9gGS0qZzaoSEHe2mc+7G90w2Ofxtvn4pselgB
 aXNZEDLRXc2Rv102DD22mEEXzH0K2Qmiy2NRdS5aYjwVSLyfoy2QvwdFncPAwZ7MZg2xfo1uad
 GsZBFP/UOvaBAD/SssvxhdKOZAzNlHvu/YepdJVRivmawMhdYnx4/6LQnOaEXKDoOlH0Bjil7G
 Ebg=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Sep 2023 23:28:56 -0700
IronPort-SDR: jYkYDNv7x7FE2qM3g3s0uNitSWQKFqLilVnHPnrEmK+sc5FRKFEZ18deR8ciSxfRZqEVQtieFw
 JvT+c+p7Ot0cYyBc23RCx5amS8il6G66AfJfDgETkOWVoZZetF1R0fVsktyTsJEp7swricf2Hx
 VtsxQiKzrTM3xmYYzZ599FL843fJYjidMT2R16kk411YsRUsP4hoQqVPGwk0bgxl1+0wmPvhhc
 IdRY/Ck7rv/q/gh7NDGW2iu9MKzblL2vn7D+KXjN67Odx7h/JTfbPdc1WC3GkbknctWJ8lebrK
 u8Y=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 27 Sep 2023 00:16:27 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Alex Fetters <Alex.Fetters@garmin.com>,
        Avri Altman <avri.altman@wdc.com>, stable@vger.kernel.org
Subject: [PATCH v2] mmc: Capture correct oemid
Date:   Wed, 27 Sep 2023 10:15:00 +0300
Message-Id: <20230927071500.1791882-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The OEMID is an 8-bit binary number that identifies the Device OEM
and/or the Device contents (when used as a distribution media either on
ROM or FLASH Devices).  It occupies bits [111:104] in the CID register:
see the eMMC spec JESD84-B51 paragraph 7.2.3.

So it is 8 bits, and has been so since ever - this bug is so ancients I
couldn't even find its source.  The furthest I could go is to commit
335eadf2ef6a (sd: initialize SD cards) but its already was wrong.  Could
be because in SD its indeed 16 bits (a 2-characters ASCII string).
Another option as pointed out by Alex (offlist), it seems like this
comes from the legacy MMC specs (v3.31 and before).

It is important to fix it because we are using it as one of our quirk's
token, as well as other tools, e.g. the LVFS
(https://github.com/fwupd/fwupd/).

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Cc: stable@vger.kernel.org
---
Changelog:

v1--v2:
Add Alex's note of the possible origin of this bug.
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89cd48fcec79..4a4bab9aa726 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -104,7 +104,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
-- 
2.42.0

