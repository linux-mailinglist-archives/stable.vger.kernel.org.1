Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976717B87D5
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243872AbjJDSJx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243712AbjJDSJx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:09:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF628C1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:09:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5A1C433C7;
        Wed,  4 Oct 2023 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442989;
        bh=p5Pdio2IfQp9qzPwFIUG48EpuN3yCWrjGvyAV+0jDoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n4P2WmlfFWbMlSBi5It9+/iH9pIZ+yk+TU52Hz1R2UE+kyiyqDhqe+vwQO8TqwfPc
         ps0QjoCfYhN35BBiEwbsVQ5Jlxo4WdJ08f4P9jmsETyyuyJpuW3fr0AQdUxuF2x2w2
         PdovdqM2BX4F9l+5npk5G/uI7xlnx8+ewEkSOJo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 5.15 180/183] ata: libata-sata: increase PMP SRST timeout to 10s
Date:   Wed,  4 Oct 2023 19:56:51 +0200
Message-ID: <20231004175211.624491076@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

From: Matthias Schiffer <mschiffer@universe-factory.net>

commit 753a4d531bc518633ea88ac0ed02b25a16823d51 upstream.

On certain SATA controllers, softreset fails after wakeup from S2RAM with
the message "softreset failed (1st FIS failed)", sometimes resulting in
drives not being detected again. With the increased timeout, this issue
is avoided. Instead, "softreset failed (device not ready)" is now
logged 1-2 times; this later failure seems to cause fewer problems
however, and the drives are detected reliably once they've spun up and
the probe is retried.

The issue was observed with the primary SATA controller of the QNAP
TS-453B, which is an "Intel Corporation Celeron/Pentium Silver Processor
SATA Controller [8086:31e3] (rev 06)" integrated in the Celeron J4125 CPU,
and the following drives:

- Seagate IronWolf ST12000VN0008
- Seagate IronWolf ST8000NE0004

The SATA controller seems to be more relevant to this issue than the
drives, as the same drives are always detected reliably on the secondary
SATA controller on the same board (an ASMedia 106x) without any "softreset
failed" errors even without the increased timeout.

Fixes: e7d3ef13d52a ("libata: change drive ready wait after hard reset to 5s")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/libata.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -301,7 +301,7 @@ enum {
 	 * advised to wait only for the following duration before
 	 * doing SRST.
 	 */
-	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
+	ATA_TMOUT_PMP_SRST_WAIT	= 10000,
 
 	/* When the LPM policy is set to ATA_LPM_MAX_POWER, there might
 	 * be a spurious PHY event, so ignore the first PHY event that


