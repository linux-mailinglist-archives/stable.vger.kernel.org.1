Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC007A3C85
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbjIQUcd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241080AbjIQUcJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:32:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687BC18E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:31:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B05C433C8;
        Sun, 17 Sep 2023 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982704;
        bh=VT+JettthjOJVd/LFdj1iSMRahPraAdV6eGTonwzz5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hz0R6TujQ+7MpMkqEWOU9p+jQUaZ80BFA6jv7bR34neENoIRJbpKfcWdh+2ddOOmM
         8TQaDxvyYeORUmkKR8TKoXxZk6TN97RDfBIBp6Z6tmF0mO/VjcYbkE5uF53sAbRnO6
         q9nnwz7eG1LjMpCGr8THtBWMi+pUc/YnKihw6RtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 5.15 328/511] media: i2c: ccs: Check rules is non-NULL
Date:   Sun, 17 Sep 2023 21:12:35 +0200
Message-ID: <20230917191121.737715611@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 607bcc4213d998d051541d8f10b5bbb7d546c0be upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ccs/ccs-data.c |  101 +++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 45 deletions(-)

--- a/drivers/media/i2c/ccs/ccs-data.c
+++ b/drivers/media/i2c/ccs/ccs-data.c
@@ -464,8 +464,7 @@ static int ccs_data_parse_rules(struct b
 		rule_payload = __rule_type + 1;
 		rule_plen2 = rule_plen - sizeof(*__rule_type);
 
-		switch (*__rule_type) {
-		case CCS_DATA_BLOCK_RULE_ID_IF: {
+		if (*__rule_type == CCS_DATA_BLOCK_RULE_ID_IF) {
 			const struct __ccs_data_block_rule_if *__if_rules =
 				rule_payload;
 			const size_t __num_if_rules =
@@ -514,49 +513,61 @@ static int ccs_data_parse_rules(struct b
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


