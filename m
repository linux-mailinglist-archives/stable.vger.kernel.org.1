Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39E67302A1
	for <lists+stable@lfdr.de>; Wed, 14 Jun 2023 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245688AbjFNPBm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245737AbjFNPBf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 11:01:35 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB934270C
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 08:01:12 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EDSNGC013512
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 11:01:12 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r4k16hkqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 11:01:10 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 35EF187Z026517
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 11:01:08 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Jun 2023 11:01:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 14 Jun 2023 11:01:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 14 Jun 2023 11:01:07 -0400
Received: from dariana.ad.analog.com ([10.48.65.197])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 35EF0xVP019133;
        Wed, 14 Jun 2023 11:01:01 -0400
From:   Alisa Roman <alisa.roman@analog.com>
To:     <alisa.roman@analog.com>
CC:     <stable@vger.kernel.org>
Subject: [PATCH] iio: adc: ad7192: fix ac excitation feature
Date:   Wed, 14 Jun 2023 18:00:53 +0300
Message-ID: <20230614150053.150673-1-alisa.roman@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: F6p3ufW5HjTbExKV9qh6KicZj9eTyQ6M
X-Proofpoint-ORIG-GUID: F6p3ufW5HjTbExKV9qh6KicZj9eTyQ6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_10,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=987
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306140130
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

In the AD7195 documentation, the AC excitation enable bit is on position
22 in the Configuration register.

Note that the fix tag is for the commit that moved the driver out of
staging.

Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of staging")
Signed-off-by: Alisa Roman <alisa.roman@analog.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/adc/ad7192.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8685e0b58a83..7bc3ebfe8081 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -62,7 +62,6 @@
 #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
 #define AD7192_MODE_CLKSRC(x)	(((x) & 0x3) << 18) /* Clock Source Select */
 #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
-#define AD7192_MODE_ACX		BIT(14) /* AC excitation enable(AD7195 only)*/
 #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
 #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
 #define AD7192_MODE_SCYCLE	BIT(11) /* Single cycle conversion */
@@ -91,6 +90,7 @@
 /* Configuration Register Bit Designations (AD7192_REG_CONF) */
 
 #define AD7192_CONF_CHOP	BIT(23) /* CHOP enable */
+#define AD7192_CONF_ACX		BIT(22) /* AC excitation enable(AD7195 only) */
 #define AD7192_CONF_REFSEL	BIT(20) /* REFIN1/REFIN2 Reference Select */
 #define AD7192_CONF_CHAN(x)	((x) << 8) /* Channel select */
 #define AD7192_CONF_CHAN_MASK	(0x7FF << 8) /* Channel select mask */
@@ -472,7 +472,7 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7192_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->mode & AD7192_MODE_ACX));
+	return sysfs_emit(buf, "%d\n", !!(st->conf & AD7192_CONF_ACX));
 }
 
 static ssize_t ad7192_show_bridge_switch(struct device *dev,
@@ -513,13 +513,13 @@ static ssize_t ad7192_set(struct device *dev,
 
 		ad_sd_write_reg(&st->sd, AD7192_REG_GPOCON, 1, st->gpocon);
 		break;
-	case AD7192_REG_MODE:
+	case AD7192_REG_CONF:
 		if (val)
-			st->mode |= AD7192_MODE_ACX;
+			st->conf |= AD7192_CONF_ACX;
 		else
-			st->mode &= ~AD7192_MODE_ACX;
+			st->conf &= ~AD7192_CONF_ACX;
 
-		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+		ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
 		break;
 	default:
 		ret = -EINVAL;
@@ -579,12 +579,11 @@ static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 
 static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       ad7192_show_ac_excitation, ad7192_set,
-		       AD7192_REG_MODE);
+		       AD7192_REG_CONF);
 
 static struct attribute *ad7192_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
-	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
 };
 
@@ -595,6 +594,7 @@ static const struct attribute_group ad7192_attribute_group = {
 static struct attribute *ad7195_attributes[] = {
 	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
+	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
 };
 
-- 
2.34.1

