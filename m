Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016727BEC2D
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 23:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377082AbjJIVBI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjJIVBH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 17:01:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8B49E
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 14:01:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so9052597b3.0
        for <stable@vger.kernel.org>; Mon, 09 Oct 2023 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696885263; x=1697490063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qyOEdilfHw6B6k4i/Hrpjck7dAiRB3VXEglYZeWU0vY=;
        b=RDqhhdTFJzDEWkrgAFSXv2TAkzjlNIv0utTHzAf1vat4jLqL467f1eyWhCms0hrpuU
         XeEDnmllu4x+r0VCYVazUpQToTfOagFhQ2g8pPIlNkW0clkiws5TjjVYWFy8mr4gGAUv
         gjRPZTJedhMwI12slCQP7JwNwLTHqalGIfkJtm0eSwLTEvJsIfSpJ36R60m+AWeeH3Vq
         1wEEd5dlMghdsNwAMjhpG55/sE2VptzL0BOHG1fbk9f+TYVR6/JUpw148RAzCYGdr0L7
         SHb2p5N2sg+JzUMVZZwRvIO1Rj2/shaTkqPbgeW2JoXyD4+htb4qoMnd/0OLaQRUDcNW
         bW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696885263; x=1697490063;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qyOEdilfHw6B6k4i/Hrpjck7dAiRB3VXEglYZeWU0vY=;
        b=DpkUvG+eFOy2w+lJJ9gdswOboOyBAzPmaAodDW5wmZe/ZrKcl0Dh/7yQI+92c+Q9uv
         NNEYXsTrN/Cb1Ra4Ko+O11cDIcu3e/BhAF/sgyXJqflWibUSf7MbC/x/x63EeHqmVVyE
         qqzHvTq86v/yZ/XWiwaRC9RzHYQuEPhlXWk5c6jp4ufyjXc4WR0y0B797TCg7OzZIpis
         kKm15E26MQobupz9enn3p/zkhAxkbEbUBwhJfJJOOnXhaepJg+HD02pS6ewEwuUm8xAG
         l4eseuyd+eccLZhVBUZ58BE/tGBYVBJ4T4DH2dRZ8WE51GbzK7eS0N7O5U3q/uiXYGL7
         hu4Q==
X-Gm-Message-State: AOJu0Yws/FdXFuvJWKZNAuQ8bLzIOpMIhfmNcOPxFemZF/AHcPBDV79W
        3j3/M0RJ+zPpEP4W+Yb7J8F07zH8WBJZ2Q0=
X-Google-Smtp-Source: AGHT+IEDyvZJwdqY9Oc+PsWnDK52oMqUDJXq0wl9ww7b4zK4S7kU9Z8dwTPjMN33xEoBDyZKGPNLrxqnaLEgeN4=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a81:c14a:0:b0:5a7:aab1:96a9 with SMTP id
 e10-20020a81c14a000000b005a7aab196a9mr37078ywl.6.1696885262787; Mon, 09 Oct
 2023 14:01:02 -0700 (PDT)
Date:   Mon,  9 Oct 2023 21:00:58 +0000
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1373; i=rdbabiera@google.com;
 h=from:subject; bh=naOIDwmSOXGmB0NeKgkfBkGNyY1AcsJZAkoLxfJAvY4=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKkqWZyV4e0cCiJFf8M0b/3MzIv2XfV/aa2ZucelhMbUB
 WwzXh/qKGVhEONgkBVTZNH1zzO4cSV1yxzOGmOYOaxMIEMYuDgFYCIcnAx/ZSSaD5g46di9/9R0
 r/b1VJ44i2ydZaw3Ezd4Scww9pqqzvBP80lb4eKKcJsTypG9fPO5bv/dMcWJ/2LbyudhXJz6PSb cAA==
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231009210057.3773877-2-rdbabiera@google.com>
Subject: [PATCH v1] usb: typec: altmodes/displayport: Signal hpd low when
 exiting mode
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Upon receiving an ACK for a sent EXIT_MODE message, the DisplayPort
driver currently resets the status and configuration of the port partner.
The hpd signal is not updated despite being part of the status, so the
Display stack can still transmit video despite typec_altmode_exit placing
the lanes in a Safe State.

Set hpd to low when a sent EXIT_MODE message is ACK'ed.

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 drivers/usb/typec/altmodes/displayport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index f503cb4cd721..718da02036d8 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -307,6 +307,11 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 			typec_altmode_update_active(alt, false);
 			dp->data.status = 0;
 			dp->data.conf = 0;
+			if (dp->hpd) {
+				drm_connector_oob_hotplug_event(dp->connector_fwnode);
+				dp->hpd = false;
+				sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
+			}
 			break;
 		case DP_CMD_STATUS_UPDATE:
 			dp->data.status = *vdo;

base-commit: 1053c4a4b8fcbd28386e80347e7c82d4d617e352
-- 
2.42.0.609.gbb76f46606-goog

