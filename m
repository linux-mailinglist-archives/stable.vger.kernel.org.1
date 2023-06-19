Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20247352AF
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjFSKhX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjFSKhE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CAD10C8
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98D3E60B51
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6708C433CA;
        Mon, 19 Jun 2023 10:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171022;
        bh=LX0GQvJ/fAh+JVfDm0XTrda5Tu99gZs3gZ7M11qm2bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkupi2gKe7WiyV5Djv0liSTicwyfrb2hOS7kaQKjSypPgCyFprHqyMkhnw11sn3t8
         3j0SlTc9GyD96xnmgaxPMd6c4Usyjpts5w/2nCBa1ZkZrnJpWofw4b2WanJ3wJVKAS
         85JhN7wNyEUGdqBeYZAiSVYLL06cYDDQSbSg7ApM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michal Schmidt <mschmidt@redhat.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH 6.3 119/187] ice: do not busy-wait to read GNSS data
Date:   Mon, 19 Jun 2023 12:28:57 +0200
Message-ID: <20230619102203.305540672@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 2f8fdcb0a73a1831cc4f205f23493a17c0e5536f ]

The ice-gnss-<dev_name> kernel thread, which reads data from the u-blox
GNSS module, keep a CPU core almost 100% busy. The main reason is that
it busy-waits for data to become available.

A simple improvement would be to replace the "mdelay(10);" in
ice_gnss_read() with sleeping. A better fix is to not do any waiting
directly in the function and just requeue this delayed work as needed.
The advantage is that canceling the work from ice_gnss_exit() becomes
immediate, rather than taking up to ~2.5 seconds (ICE_MAX_UBX_READ_TRIES
* 10 ms).

This lowers the CPU usage of the ice-gnss-<dev_name> thread on my system
from ~90 % to ~8 %.

I am not sure if the larger 0.1 s pause after inserting data into the
gnss subsystem is really necessary, but I'm keeping that as it was.

Of course, ideally the driver would not have to poll at all, but I don't
know if the E810 can watch for GNSS data availability over the i2c bus
by itself and notify the driver.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: 05a1308a2e08 ("ice: Don't dereference NULL in ice_gnss_read error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_gnss.c | 42 ++++++++++-------------
 drivers/net/ethernet/intel/ice/ice_gnss.h |  3 +-
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.c b/drivers/net/ethernet/intel/ice/ice_gnss.c
index 12086aafb42fb..bd0ed155e11b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.c
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.c
@@ -85,6 +85,7 @@ static void ice_gnss_read(struct kthread_work *work)
 {
 	struct gnss_serial *gnss = container_of(work, struct gnss_serial,
 						read_work.work);
+	unsigned long delay = ICE_GNSS_POLL_DATA_DELAY_TIME;
 	unsigned int i, bytes_read, data_len, count;
 	struct ice_aqc_link_topo_addr link_topo;
 	struct ice_pf *pf;
@@ -104,11 +105,6 @@ static void ice_gnss_read(struct kthread_work *work)
 		return;
 
 	hw = &pf->hw;
-	buf = (char *)get_zeroed_page(GFP_KERNEL);
-	if (!buf) {
-		err = -ENOMEM;
-		goto exit;
-	}
 
 	memset(&link_topo, 0, sizeof(struct ice_aqc_link_topo_addr));
 	link_topo.topo_params.index = ICE_E810T_GNSS_I2C_BUS;
@@ -119,25 +115,24 @@ static void ice_gnss_read(struct kthread_work *work)
 	i2c_params = ICE_GNSS_UBX_DATA_LEN_WIDTH |
 		     ICE_AQC_I2C_USE_REPEATED_START;
 
-	/* Read data length in a loop, when it's not 0 the data is ready */
-	for (i = 0; i < ICE_MAX_UBX_READ_TRIES; i++) {
-		err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
-				      cpu_to_le16(ICE_GNSS_UBX_DATA_LEN_H),
-				      i2c_params, (u8 *)&data_len_b, NULL);
-		if (err)
-			goto exit_buf;
+	err = ice_aq_read_i2c(hw, link_topo, ICE_GNSS_UBX_I2C_BUS_ADDR,
+			      cpu_to_le16(ICE_GNSS_UBX_DATA_LEN_H),
+			      i2c_params, (u8 *)&data_len_b, NULL);
+	if (err)
+		goto requeue;
 
-		data_len = be16_to_cpu(data_len_b);
-		if (data_len != 0 && data_len != U16_MAX)
-			break;
+	data_len = be16_to_cpu(data_len_b);
+	if (data_len == 0 || data_len == U16_MAX)
+		goto requeue;
 
-		mdelay(10);
-	}
+	/* The u-blox has data_len bytes for us to read */
 
 	data_len = min_t(typeof(data_len), data_len, PAGE_SIZE);
-	if (!data_len) {
+
+	buf = (char *)get_zeroed_page(GFP_KERNEL);
+	if (!buf) {
 		err = -ENOMEM;
-		goto exit_buf;
+		goto requeue;
 	}
 
 	/* Read received data */
@@ -151,7 +146,7 @@ static void ice_gnss_read(struct kthread_work *work)
 				      cpu_to_le16(ICE_GNSS_UBX_EMPTY_DATA),
 				      bytes_read, &buf[i], NULL);
 		if (err)
-			goto exit_buf;
+			goto free_buf;
 	}
 
 	count = gnss_insert_raw(pf->gnss_dev, buf, i);
@@ -159,10 +154,11 @@ static void ice_gnss_read(struct kthread_work *work)
 		dev_warn(ice_pf_to_dev(pf),
 			 "gnss_insert_raw ret=%d size=%d\n",
 			 count, i);
-exit_buf:
+	delay = ICE_GNSS_TIMER_DELAY_TIME;
+free_buf:
 	free_page((unsigned long)buf);
-	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work,
-				   ICE_GNSS_TIMER_DELAY_TIME);
+requeue:
+	kthread_queue_delayed_work(gnss->kworker, &gnss->read_work, delay);
 exit:
 	if (err)
 		dev_dbg(ice_pf_to_dev(pf), "GNSS failed to read err=%d\n", err);
diff --git a/drivers/net/ethernet/intel/ice/ice_gnss.h b/drivers/net/ethernet/intel/ice/ice_gnss.h
index d95ca3928b2ea..d206afe550a56 100644
--- a/drivers/net/ethernet/intel/ice/ice_gnss.h
+++ b/drivers/net/ethernet/intel/ice/ice_gnss.h
@@ -5,6 +5,7 @@
 #define _ICE_GNSS_H_
 
 #define ICE_E810T_GNSS_I2C_BUS		0x2
+#define ICE_GNSS_POLL_DATA_DELAY_TIME	(HZ / 100) /* poll every 10 ms */
 #define ICE_GNSS_TIMER_DELAY_TIME	(HZ / 10) /* 0.1 second per message */
 #define ICE_GNSS_TTY_WRITE_BUF		250
 #define ICE_MAX_I2C_DATA_SIZE		FIELD_MAX(ICE_AQC_I2C_DATA_SIZE_M)
@@ -20,8 +21,6 @@
  * passed as I2C addr parameter.
  */
 #define ICE_GNSS_UBX_WRITE_BYTES	(ICE_MAX_I2C_WRITE_BYTES + 1)
-#define ICE_MAX_UBX_READ_TRIES		255
-#define ICE_MAX_UBX_ACK_READ_TRIES	4095
 
 /**
  * struct gnss_serial - data used to initialize GNSS TTY port
-- 
2.39.2



