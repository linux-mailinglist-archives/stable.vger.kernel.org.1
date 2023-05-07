Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66136F9736
	for <lists+stable@lfdr.de>; Sun,  7 May 2023 08:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjEGGpH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 7 May 2023 02:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjEGGpF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 7 May 2023 02:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7411876A5
        for <stable@vger.kernel.org>; Sat,  6 May 2023 23:45:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED0126156E
        for <stable@vger.kernel.org>; Sun,  7 May 2023 06:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC12AC433EF;
        Sun,  7 May 2023 06:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683441903;
        bh=6Ec2BHR+RALo4CCytNf/ig+CTszMJjXoeplFPj+LMUs=;
        h=Subject:To:Cc:From:Date:From;
        b=bK7xkCJxyRUCGVxSMus29O5KwVSfZ4R8WAYpGVA3ALEDmYGBrk2XLCDWgH0Z+k+3T
         CZRSiZ/KwJA8IjFM2vV/xtvi4fgMCongwoSsGdL/+zh0Gw/zIyHd7aZ18Kvrm+jdOM
         nY4NNBm0vzf1KqDoQP/C4ZnylgmZ5DknWsJJOfDk=
Subject: FAILED: patch "[PATCH] igc: read before write to SRRCTL register" failed to apply to 6.2-stable tree
To:     yoong.siang.song@intel.com, anthony.l.nguyen@intel.com,
        brouer@redhat.com, davem@davemloft.net, jacob.e.keller@intel.com,
        leonro@nvidia.com, naamax.meir@linux.intel.com,
        stable@vger.kernel.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 07 May 2023 08:44:52 +0200
Message-ID: <2023050751-activity-marbling-37b1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.2.y
git checkout FETCH_HEAD
git cherry-pick -x 3ce29c17dc847bf4245e16aad78a7617afa96297
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023050751-activity-marbling-37b1@gregkh' --subject-prefix 'PATCH 6.2.y' HEAD^..

Possible dependencies:

3ce29c17dc84 ("igc: read before write to SRRCTL register")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ce29c17dc847bf4245e16aad78a7617afa96297 Mon Sep 17 00:00:00 2001
From: Song Yoong Siang <yoong.siang.song@intel.com>
Date: Tue, 2 May 2023 08:48:06 -0700
Subject: [PATCH] igc: read before write to SRRCTL register

igc_configure_rx_ring() function will be called as part of XDP program
setup. If Rx hardware timestamp is enabled prio to XDP program setup,
this timestamp enablement will be overwritten when buffer size is
written into SRRCTL register.

Thus, this commit read the register value before write to SRRCTL
register. This commit is tested by using xdp_hw_metadata bpf selftest
tool. The tool enables Rx hardware timestamp and then attach XDP program
to igc driver. It will display hardware timestamp of UDP packet with
port number 9092. Below are detail of test steps and results.

Command on DUT:
  sudo ./xdp_hw_metadata <interface name>

Command on Link Partner:
  echo -n skb | nc -u -q1 <destination IPv4 addr> 9092

Result before this patch:
  skb hwtstamp is not found!

Result after this patch:
  found skb hwtstamp = 1677800973.642836757

Optionally, read PHC to confirm the values obtained are almost the same:
Command:
  sudo ./testptp -d /dev/ptp0 -g
Result:
  clock time: 1677800973.913598978 or Fri Mar  3 07:49:33 2023

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Cc: <stable@vger.kernel.org> # 5.14+
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Jesper Dangaard Brouer <brouer@redhat.com>
Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index 7a992befca24..9f3827eda157 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -87,8 +87,13 @@ union igc_adv_rx_desc {
 #define IGC_RXDCTL_SWFLUSH		0x04000000 /* Receive Software Flush */
 
 /* SRRCTL bit definitions */
-#define IGC_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
-#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
-#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	0x02000000
+#define IGC_SRRCTL_BSIZEPKT_MASK	GENMASK(6, 0)
+#define IGC_SRRCTL_BSIZEPKT(x)		FIELD_PREP(IGC_SRRCTL_BSIZEPKT_MASK, \
+					(x) / 1024) /* in 1 KB resolution */
+#define IGC_SRRCTL_BSIZEHDR_MASK	GENMASK(13, 8)
+#define IGC_SRRCTL_BSIZEHDR(x)		FIELD_PREP(IGC_SRRCTL_BSIZEHDR_MASK, \
+					(x) / 64) /* in 64 bytes resolution */
+#define IGC_SRRCTL_DESCTYPE_MASK	GENMASK(27, 25)
+#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	FIELD_PREP(IGC_SRRCTL_DESCTYPE_MASK, 1)
 
 #endif /* _IGC_BASE_H */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ba49728be919..1c4676882082 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -640,8 +640,11 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
 	else
 		buf_size = IGC_RXBUFFER_2048;
 
-	srrctl = IGC_RX_HDR_LEN << IGC_SRRCTL_BSIZEHDRSIZE_SHIFT;
-	srrctl |= buf_size >> IGC_SRRCTL_BSIZEPKT_SHIFT;
+	srrctl = rd32(IGC_SRRCTL(reg_idx));
+	srrctl &= ~(IGC_SRRCTL_BSIZEPKT_MASK | IGC_SRRCTL_BSIZEHDR_MASK |
+		    IGC_SRRCTL_DESCTYPE_MASK);
+	srrctl |= IGC_SRRCTL_BSIZEHDR(IGC_RX_HDR_LEN);
+	srrctl |= IGC_SRRCTL_BSIZEPKT(buf_size);
 	srrctl |= IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
 
 	wr32(IGC_SRRCTL(reg_idx), srrctl);

