Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A8787281
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241850AbjHXOyh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 10:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241867AbjHXOyL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 10:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27211995
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 07:54:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814DD6490C
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 14:54:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958A2C433C9;
        Thu, 24 Aug 2023 14:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692888849;
        bh=zGdA1SJhcSeZpesN8jQB2MWJ+Ge2OgI12vPaRP9Swug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8wU6YWdrn9iG5ucunv4y6BY318iGOdn1LVIrYYsXjnAdUNcqG4Ll3QcdfIRkdfa8
         OmfwqpYHSesA+zQ3XJC5mRHIgl6XfhWkE+M53ySWIVBUOQCRE60d/idJmDeTxT2w9r
         zCETbP7aHu+kJizH/u8oVcv6SIxk8trWe+2ByKzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Naama Meir <naamax.meir@linux.intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 046/139] igc: read before write to SRRCTL register
Date:   Thu, 24 Aug 2023 16:49:29 +0200
Message-ID: <20230824145025.610030754@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
References: <20230824145023.559380953@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Song Yoong Siang <yoong.siang.song@intel.com>

[ Upstream commit 3ce29c17dc847bf4245e16aad78a7617afa96297 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_base.h | 11 ++++++++---
 drivers/net/ethernet/intel/igc/igc_main.c |  7 +++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_base.h b/drivers/net/ethernet/intel/igc/igc_base.h
index ce530f5fd7bda..52849f5e8048d 100644
--- a/drivers/net/ethernet/intel/igc/igc_base.h
+++ b/drivers/net/ethernet/intel/igc/igc_base.h
@@ -85,8 +85,13 @@ union igc_adv_rx_desc {
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
index a47dce10d3a78..a8c24a1c12b43 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -674,8 +674,11 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
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
-- 
2.40.1



