Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7653077C061
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjHNTIF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjHNTIC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 15:08:02 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A0E10F7
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 12:08:01 -0700 (PDT)
Received: from mchehab by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <mchehab@linuxtv.org>)
        id 1qVcv0-00HXqo-Hn; Mon, 14 Aug 2023 19:07:58 +0000
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Mon, 14 Aug 2023 18:27:58 +0000
Subject: [git:media_stage/master] media: i2c: ccs: Check rules is non-NULL
To:     linuxtv-commits@linuxtv.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qVcv0-00HXqo-Hn@www.linuxtv.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: i2c: ccs: Check rules is non-NULL
Author:  Sakari Ailus <sakari.ailus@linux.intel.com>
Date:    Sat Jul 29 20:59:25 2023 +0200

Fix the following smatch warning:

drivers/media/i2c/ccs/ccs-data.c:524 ccs_data_parse_rules() warn: address
of NULL pointer 'rules'

The CCS static data rule parser does not check an if rule has been
obtained before checking for other rule types (which depend on the if
rule). In practice this means parsing invalid CCS static data could lead
to dereferencing a NULL pointer.

Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
Fixes: a6b396f410b1 ("media: ccs: Add CCS static data parser library")
Cc: stable@vger.kernel.org # for 5.11 and up
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

 drivers/media/i2c/ccs/ccs-data.c | 101 ++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 45 deletions(-)

---

diff --git a/drivers/media/i2c/ccs/ccs-data.c b/drivers/media/i2c/ccs/ccs-data.c
index 45f2b2f55ec5..08400edf77ce 100644
--- a/drivers/media/i2c/ccs/ccs-data.c
+++ b/drivers/media/i2c/ccs/ccs-data.c
@@ -464,8 +464,7 @@ static int ccs_data_parse_rules(struct bin_container *bin,
 		rule_payload = __rule_type + 1;
 		rule_plen2 = rule_plen - sizeof(*__rule_type);
 
-		switch (*__rule_type) {
-		case CCS_DATA_BLOCK_RULE_ID_IF: {
+		if (*__rule_type == CCS_DATA_BLOCK_RULE_ID_IF) {
 			const struct __ccs_data_block_rule_if *__if_rules =
 				rule_payload;
 			const size_t __num_if_rules =
@@ -514,49 +513,61 @@ static int ccs_data_parse_rules(struct bin_container *bin,
 				rules->if_rules = if_rule;
 				rules->num_if_rules = __num_if_rules;
 			}
-			break;
-		}
-		case CCS_DATA_BLOCK_RULE_ID_READ_ONLY_REGS:
-			rval = ccs_data_parse_reg_rules(bin, &rules->read_only_regs,
-							&rules->num_read_only_regs,
-							rule_payload,
-							rule_payload + rule_plen2,
-							dev);
-			if (rval)
-				return rval;
-			break;
-		case CCS_DATA_BLOCK_RULE_ID_FFD:
-			rval = ccs_data_parse_ffd(bin, &rules->frame_format,
-						  rule_payload,
-						  rule_payload + rule_plen2,
-						  dev);
-			if (rval)
-				return rval;
-			break;
-		case CCS_DATA_BLOCK_RULE_ID_MSR:
-			rval = ccs_data_parse_reg_rules(bin,
-							&rules->manufacturer_regs,
-							&rules->num_manufacturer_regs,
-							rule_payload,
-							rule_payload + rule_plen2,
-							dev);
-			if (rval)
-				return rval;
-			break;
-		case CCS_DATA_BLOCK_RULE_ID_PDAF_READOUT:
-			rval = ccs_data_parse_pdaf_readout(bin,
-							   &rules->pdaf_readout,
-							   rule_payload,
-							   rule_payload + rule_plen2,
-							   dev);
-			if (rval)
-				return rval;
-			break;
-		default:
-			dev_dbg(dev,
-				"Don't know how to handle rule type %u!\n",
-				*__rule_type);
-			return -EINVAL;
+		} else {
+			/* Check there was an if rule before any other rules */
+			if (bin->base && !rules)
+				return -EINVAL;
+
+			switch (*__rule_type) {
+			case CCS_DATA_BLOCK_RULE_ID_READ_ONLY_REGS:
+				rval = ccs_data_parse_reg_rules(bin,
+								rules ?
+								&rules->read_only_regs : NULL,
+								rules ?
+								&rules->num_read_only_regs : NULL,
+								rule_payload,
+								rule_payload + rule_plen2,
+								dev);
+				if (rval)
+					return rval;
+				break;
+			case CCS_DATA_BLOCK_RULE_ID_FFD:
+				rval = ccs_data_parse_ffd(bin, rules ?
+							  &rules->frame_format : NULL,
+							  rule_payload,
+							  rule_payload + rule_plen2,
+							  dev);
+				if (rval)
+					return rval;
+				break;
+			case CCS_DATA_BLOCK_RULE_ID_MSR:
+				rval = ccs_data_parse_reg_rules(bin,
+								rules ?
+								&rules->manufacturer_regs : NULL,
+								rules ?
+								&rules->num_manufacturer_regs : NULL,
+								rule_payload,
+								rule_payload + rule_plen2,
+								dev);
+				if (rval)
+					return rval;
+				break;
+			case CCS_DATA_BLOCK_RULE_ID_PDAF_READOUT:
+				rval = ccs_data_parse_pdaf_readout(bin,
+								   rules ?
+								   &rules->pdaf_readout : NULL,
+								   rule_payload,
+								   rule_payload + rule_plen2,
+								   dev);
+				if (rval)
+					return rval;
+				break;
+			default:
+				dev_dbg(dev,
+					"Don't know how to handle rule type %u!\n",
+					*__rule_type);
+				return -EINVAL;
+			}
 		}
 		__next_rule = __next_rule + rule_hlen + rule_plen;
 	}
