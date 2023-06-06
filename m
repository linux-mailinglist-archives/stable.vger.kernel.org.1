Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B1A724160
	for <lists+stable@lfdr.de>; Tue,  6 Jun 2023 13:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjFFL57 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 6 Jun 2023 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjFFL56 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Jun 2023 07:57:58 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F38101;
        Tue,  6 Jun 2023 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686052678; x=1717588678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D957/RahnUEiCF+cfoojIwT99d/e0nuiAb7ylwuaYOk=;
  b=RBdEursTmBiabh3Il1quDH0VV6TM9eW+j5YklWPE0XVX0uBUYBiN48KS
   +DTz1MUJ8qSzC1z9hK0dDTkuspbMArHnKLwcGALTh5nEB83EMbYsLIWVf
   /oz9s95UA6BsPhJ1rxqyyH1LKMIIs4aiw6005E7GZ5ui1pBk48jFr0Thl
   z70z8ACn7zlBrBVRYv9PH2XaW0o/iWZ1TUoJUrdQaWxp/ziVq83R97rTp
   YvKlvROgyrQROZWTecEPqBuv/E9VSFDcXHabNn1TLGPr5Hzi2nw+V0SMQ
   quoiUcoIHiHpcNCrFmGbXCPyx55+L9czR5sI6zVaO0hb+ysTeZjPSkMUD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="355502078"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="355502078"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 04:57:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="853397494"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="853397494"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jun 2023 04:57:55 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Stephan Bolten <stephan.bolten@gmx.net>,
        stable@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Fix command cancellation
Date:   Tue,  6 Jun 2023 14:58:02 +0300
Message-Id: <20230606115802.79339-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The Cancel command was passed to the write callback as the
offset instead of as the actual command which caused NULL
pointer dereference.

Reported-by: Stephan Bolten <stephan.bolten@gmx.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217517
Fixes: 094902bc6a3c ("usb: typec: ucsi: Always cancel the command if PPM reports BUSY condition")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 2b472ec01dc42..b664ecbb798be 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -132,10 +132,8 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	if (ret)
 		return ret;
 
-	if (cci & UCSI_CCI_BUSY) {
-		ucsi->ops->async_write(ucsi, UCSI_CANCEL, NULL, 0);
-		return -EBUSY;
-	}
+	if (cmd != UCSI_CANCEL && cci & UCSI_CCI_BUSY)
+		return ucsi_exec_command(ucsi, UCSI_CANCEL);
 
 	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
@@ -149,6 +147,11 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 		return ucsi_read_error(ucsi);
 	}
 
+	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
+		ret = ucsi_acknowledge_command(ucsi);
+		return ret ? ret : -EBUSY;
+	}
+
 	return UCSI_CCI_LENGTH(cci);
 }
 
-- 
2.39.2

