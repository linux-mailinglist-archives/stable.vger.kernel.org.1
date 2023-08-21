Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B7778332D
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjHUUG7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjHUUG6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873FDF
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC09564983
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC537C433C7;
        Mon, 21 Aug 2023 20:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648416;
        bh=W0khI8sjnjKE0kabBNw9JkXiuxXzoqsG9WbTcbN1TA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdjZE0OBq2DcjNbWJa88EXUNkATLT0YDhbghhkNGuAiTaQ6C+jkDRivgCjlduxP3s
         10iE6eWZMc2v1LWV2WMcYOeS6DGeC90vqE9yrgZO+2403EAkUw+BuU4TWQEZmuQ9+k
         rjRWZ2idgg+PsKj/oupOE5yzoptzzFWw5f9PsWCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Piotr Gardocki <piotrx.gardocki@intel.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 168/234] iavf: fix FDIR rule fields masks validation
Date:   Mon, 21 Aug 2023 21:42:11 +0200
Message-ID: <20230821194136.261296563@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
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

From: Piotr Gardocki <piotrx.gardocki@intel.com>

[ Upstream commit 751969e5b1196821ef78f0aa664a8a97c92c9057 ]

Return an error if a field's mask is neither full nor empty. When a mask
is only partial the field is not being used for rule programming but it
gives a wrong impression it is used. Fix by returning an error on any
partial mask to make it clear they are not supported.
The ip_ver assignment is moved earlier in code to allow using it in
iavf_validate_fdir_fltr_masks.

Fixes: 527691bf0682 ("iavf: Support IPv4 Flow Director filters")
Fixes: e90cbc257a6f ("iavf: Support IPv6 Flow Director filters")
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 10 +++
 drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 77 ++++++++++++++++++-
 drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  2 +
 3 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 460ca561819a9..a34303ad057d0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1289,6 +1289,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.src_port = fsp->m_u.tcp_ip4_spec.psrc;
 		fltr->ip_mask.dst_port = fsp->m_u.tcp_ip4_spec.pdst;
 		fltr->ip_mask.tos = fsp->m_u.tcp_ip4_spec.tos;
+		fltr->ip_ver = 4;
 		break;
 	case AH_V4_FLOW:
 	case ESP_V4_FLOW:
@@ -1300,6 +1301,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.v4_addrs.dst_ip = fsp->m_u.ah_ip4_spec.ip4dst;
 		fltr->ip_mask.spi = fsp->m_u.ah_ip4_spec.spi;
 		fltr->ip_mask.tos = fsp->m_u.ah_ip4_spec.tos;
+		fltr->ip_ver = 4;
 		break;
 	case IPV4_USER_FLOW:
 		fltr->ip_data.v4_addrs.src_ip = fsp->h_u.usr_ip4_spec.ip4src;
@@ -1312,6 +1314,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.l4_header = fsp->m_u.usr_ip4_spec.l4_4_bytes;
 		fltr->ip_mask.tos = fsp->m_u.usr_ip4_spec.tos;
 		fltr->ip_mask.proto = fsp->m_u.usr_ip4_spec.proto;
+		fltr->ip_ver = 4;
 		break;
 	case TCP_V6_FLOW:
 	case UDP_V6_FLOW:
@@ -1330,6 +1333,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.src_port = fsp->m_u.tcp_ip6_spec.psrc;
 		fltr->ip_mask.dst_port = fsp->m_u.tcp_ip6_spec.pdst;
 		fltr->ip_mask.tclass = fsp->m_u.tcp_ip6_spec.tclass;
+		fltr->ip_ver = 6;
 		break;
 	case AH_V6_FLOW:
 	case ESP_V6_FLOW:
@@ -1345,6 +1349,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		       sizeof(struct in6_addr));
 		fltr->ip_mask.spi = fsp->m_u.ah_ip6_spec.spi;
 		fltr->ip_mask.tclass = fsp->m_u.ah_ip6_spec.tclass;
+		fltr->ip_ver = 6;
 		break;
 	case IPV6_USER_FLOW:
 		memcpy(&fltr->ip_data.v6_addrs.src_ip, fsp->h_u.usr_ip6_spec.ip6src,
@@ -1361,6 +1366,7 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		fltr->ip_mask.l4_header = fsp->m_u.usr_ip6_spec.l4_4_bytes;
 		fltr->ip_mask.tclass = fsp->m_u.usr_ip6_spec.tclass;
 		fltr->ip_mask.proto = fsp->m_u.usr_ip6_spec.l4_proto;
+		fltr->ip_ver = 6;
 		break;
 	case ETHER_FLOW:
 		fltr->eth_data.etype = fsp->h_u.ether_spec.h_proto;
@@ -1371,6 +1377,10 @@ iavf_add_fdir_fltr_info(struct iavf_adapter *adapter, struct ethtool_rx_flow_spe
 		return -EINVAL;
 	}
 
+	err = iavf_validate_fdir_fltr_masks(adapter, fltr);
+	if (err)
+		return err;
+
 	if (iavf_fdir_is_dup_fltr(adapter, fltr))
 		return -EEXIST;
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
index 505e82ebafe47..03e774bd2a5b4 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.c
@@ -18,6 +18,79 @@ static const struct in6_addr ipv6_addr_full_mask = {
 	}
 };
 
+static const struct in6_addr ipv6_addr_zero_mask = {
+	.in6_u = {
+		.u6_addr8 = {
+			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+		}
+	}
+};
+
+/**
+ * iavf_validate_fdir_fltr_masks - validate Flow Director filter fields masks
+ * @adapter: pointer to the VF adapter structure
+ * @fltr: Flow Director filter data structure
+ *
+ * Returns 0 if all masks of packet fields are either full or empty. Returns
+ * error on at least one partial mask.
+ */
+int iavf_validate_fdir_fltr_masks(struct iavf_adapter *adapter,
+				  struct iavf_fdir_fltr *fltr)
+{
+	if (fltr->eth_mask.etype && fltr->eth_mask.etype != htons(U16_MAX))
+		goto partial_mask;
+
+	if (fltr->ip_ver == 4) {
+		if (fltr->ip_mask.v4_addrs.src_ip &&
+		    fltr->ip_mask.v4_addrs.src_ip != htonl(U32_MAX))
+			goto partial_mask;
+
+		if (fltr->ip_mask.v4_addrs.dst_ip &&
+		    fltr->ip_mask.v4_addrs.dst_ip != htonl(U32_MAX))
+			goto partial_mask;
+
+		if (fltr->ip_mask.tos && fltr->ip_mask.tos != U8_MAX)
+			goto partial_mask;
+	} else if (fltr->ip_ver == 6) {
+		if (memcmp(&fltr->ip_mask.v6_addrs.src_ip, &ipv6_addr_zero_mask,
+			   sizeof(struct in6_addr)) &&
+		    memcmp(&fltr->ip_mask.v6_addrs.src_ip, &ipv6_addr_full_mask,
+			   sizeof(struct in6_addr)))
+			goto partial_mask;
+
+		if (memcmp(&fltr->ip_mask.v6_addrs.dst_ip, &ipv6_addr_zero_mask,
+			   sizeof(struct in6_addr)) &&
+		    memcmp(&fltr->ip_mask.v6_addrs.dst_ip, &ipv6_addr_full_mask,
+			   sizeof(struct in6_addr)))
+			goto partial_mask;
+
+		if (fltr->ip_mask.tclass && fltr->ip_mask.tclass != U8_MAX)
+			goto partial_mask;
+	}
+
+	if (fltr->ip_mask.proto && fltr->ip_mask.proto != U8_MAX)
+		goto partial_mask;
+
+	if (fltr->ip_mask.src_port && fltr->ip_mask.src_port != htons(U16_MAX))
+		goto partial_mask;
+
+	if (fltr->ip_mask.dst_port && fltr->ip_mask.dst_port != htons(U16_MAX))
+		goto partial_mask;
+
+	if (fltr->ip_mask.spi && fltr->ip_mask.spi != htonl(U32_MAX))
+		goto partial_mask;
+
+	if (fltr->ip_mask.l4_header &&
+	    fltr->ip_mask.l4_header != htonl(U32_MAX))
+		goto partial_mask;
+
+	return 0;
+
+partial_mask:
+	dev_err(&adapter->pdev->dev, "Failed to add Flow Director filter, partial masks are not supported\n");
+	return -EOPNOTSUPP;
+}
+
 /**
  * iavf_pkt_udp_no_pay_len - the length of UDP packet without payload
  * @fltr: Flow Director filter data structure
@@ -263,8 +336,6 @@ iavf_fill_fdir_ip4_hdr(struct iavf_fdir_fltr *fltr,
 		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, IPV4, DST);
 	}
 
-	fltr->ip_ver = 4;
-
 	return 0;
 }
 
@@ -309,8 +380,6 @@ iavf_fill_fdir_ip6_hdr(struct iavf_fdir_fltr *fltr,
 		VIRTCHNL_ADD_PROTO_HDR_FIELD_BIT(hdr, IPV6, DST);
 	}
 
-	fltr->ip_ver = 6;
-
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.h b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
index 33c55c366315b..9eb9f73f6adf3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_fdir.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_fdir.h
@@ -110,6 +110,8 @@ struct iavf_fdir_fltr {
 	struct virtchnl_fdir_add vc_add_msg;
 };
 
+int iavf_validate_fdir_fltr_masks(struct iavf_adapter *adapter,
+				  struct iavf_fdir_fltr *fltr);
 int iavf_fill_fdir_add_msg(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
 void iavf_print_fdir_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
 bool iavf_fdir_is_dup_fltr(struct iavf_adapter *adapter, struct iavf_fdir_fltr *fltr);
-- 
2.40.1



