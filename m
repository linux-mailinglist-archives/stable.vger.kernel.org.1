Return-Path: <stable+bounces-129767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B3EA8016B
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4578823D1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E026A0C2;
	Tue,  8 Apr 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YEQ3QYdC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931BC227BB6;
	Tue,  8 Apr 2025 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111924; cv=none; b=eHBJfbcfbJEckw3c1MyCzSzwuea8aNbNAaw8YDwRp/bpJDhJjiGaq28eo/nsE5+YffuIrCyl85ElUSe4bfrsx8tdn3z1BzbcronE6Ftz1hZAsc/8sw5WueFUNOYagnKtSrh4nxi1oi8bIr8wIJlH44dafxZDyBlDwEluBaaj/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111924; c=relaxed/simple;
	bh=a/nPPtNh50d2tHncdscWgj4qUq5KDNVJAHX6gHBwOOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRrXw1p2qQmiiK+nWhjcSwaozNaDypL7ROUHvpDQMi63XspIGfY6xIdoXBW1/d5VD0w3PTIntgZRmsUWVl+Q1m5veezm0lBFgl0jjzR9rus2okvtXQKIKAbcNoYkpHQNtQOr6Egh40p0Zhu0rh+SLdDYPzGW6vXQI4xLSt3wQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YEQ3QYdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23382C4CEE5;
	Tue,  8 Apr 2025 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111924;
	bh=a/nPPtNh50d2tHncdscWgj4qUq5KDNVJAHX6gHBwOOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YEQ3QYdC2wH8bjSlt2U/l4/WM2ARSGzaXu9QwagRvpkIs8Q4nVccrcAbXLe9f2va3
	 cHAzINfHjF88cnwLLKrzSH4bUSBvJftJFkL6MTt4nTzMiema86nJ6s1IqcdiPgNxzm
	 cATTmvN3+lY+a3Ixk23uiTVjiPeSEkyblRVbRBlM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanislav Fomichev <sdf@fomichev.me>,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 611/731] xsk: Add launch time hardware offload support to XDP Tx metadata
Date: Tue,  8 Apr 2025 12:48:28 +0200
Message-ID: <20250408104928.483268850@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Yoong Siang <yoong.siang.song@intel.com>

[ Upstream commit ca4419f15abd19ba8be1e109661b60f9f5b6c9f0 ]

Extend the XDP Tx metadata framework so that user can requests launch time
hardware offload, where the Ethernet device will schedule the packet for
transmission at a pre-determined time called launch time. The value of
launch time is communicated from user space to Ethernet driver via
launch_time field of struct xsk_tx_metadata.

Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Link: https://patch.msgid.link/20250216093430.957880-2-yoong.siang.song@intel.com
Stable-dep-of: d931cf9b38da ("igc: Fix TX drops in XDP ZC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml      |  4 ++
 Documentation/networking/xsk-tx-metadata.rst | 62 ++++++++++++++++++++
 include/net/xdp_sock.h                       | 10 ++++
 include/net/xdp_sock_drv.h                   |  1 +
 include/uapi/linux/if_xdp.h                  | 10 ++++
 include/uapi/linux/netdev.h                  |  3 +
 net/core/netdev-genl.c                       |  2 +
 net/xdp/xsk.c                                |  3 +
 tools/include/uapi/linux/if_xdp.h            | 10 ++++
 tools/include/uapi/linux/netdev.h            |  3 +
 10 files changed, 108 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index cbb544bd6c848..901b5afb3df0d 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -70,6 +70,10 @@ definitions:
         name: tx-checksum
         doc:
           L3 checksum HW offload is supported by the driver.
+      -
+        name: tx-launch-time-fifo
+        doc:
+          Launch time HW offload is supported by the driver.
   -
     name: queue-type
     type: enum
diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index e76b0cfc32f7d..df53a10ccac34 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -50,6 +50,10 @@ The flags field enables the particular offload:
   checksum. ``csum_start`` specifies byte offset of where the checksumming
   should start and ``csum_offset`` specifies byte offset where the
   device should store the computed checksum.
+- ``XDP_TXMD_FLAGS_LAUNCH_TIME``: requests the device to schedule the
+  packet for transmission at a pre-determined time called launch time. The
+  value of launch time is indicated by ``launch_time`` field of
+  ``union xsk_tx_metadata``.
 
 Besides the flags above, in order to trigger the offloads, the first
 packet's ``struct xdp_desc`` descriptor should set ``XDP_TX_METADATA``
@@ -65,6 +69,63 @@ In this case, when running in ``XDK_COPY`` mode, the TX checksum
 is calculated on the CPU. Do not enable this option in production because
 it will negatively affect performance.
 
+Launch Time
+===========
+
+The value of the requested launch time should be based on the device's PTP
+Hardware Clock (PHC) to ensure accuracy. AF_XDP takes a different data path
+compared to the ETF queuing discipline, which organizes packets and delays
+their transmission. Instead, AF_XDP immediately hands off the packets to
+the device driver without rearranging their order or holding them prior to
+transmission. Since the driver maintains FIFO behavior and does not perform
+packet reordering, a packet with a launch time request will block other
+packets in the same Tx Queue until it is sent. Therefore, it is recommended
+to allocate separate queue for scheduling traffic that is intended for
+future transmission.
+
+In scenarios where the launch time offload feature is disabled, the device
+driver is expected to disregard the launch time request. For correct
+interpretation and meaningful operation, the launch time should never be
+set to a value larger than the farthest programmable time in the future
+(the horizon). Different devices have different hardware limitations on the
+launch time offload feature.
+
+stmmac driver
+-------------
+
+For stmmac, TSO and launch time (TBS) features are mutually exclusive for
+each individual Tx Queue. By default, the driver configures Tx Queue 0 to
+support TSO and the rest of the Tx Queues to support TBS. The launch time
+hardware offload feature can be enabled or disabled by using the tc-etf
+command to call the driver's ndo_setup_tc() callback.
+
+The value of the launch time that is programmed in the Enhanced Normal
+Transmit Descriptors is a 32-bit value, where the most significant 8 bits
+represent the time in seconds and the remaining 24 bits represent the time
+in 256 ns increments. The programmed launch time is compared against the
+PTP time (bits[39:8]) and rolls over after 256 seconds. Therefore, the
+horizon of the launch time for dwmac4 and dwxlgmac2 is 128 seconds in the
+future.
+
+igc driver
+----------
+
+For igc, all four Tx Queues support the launch time feature. The launch
+time hardware offload feature can be enabled or disabled by using the
+tc-etf command to call the driver's ndo_setup_tc() callback. When entering
+TSN mode, the igc driver will reset the device and create a default Qbv
+schedule with a 1-second cycle time, with all Tx Queues open at all times.
+
+The value of the launch time that is programmed in the Advanced Transmit
+Context Descriptor is a relative offset to the starting time of the Qbv
+transmission window of the queue. The Frst flag of the descriptor can be
+set to schedule the packet for the next Qbv cycle. Therefore, the horizon
+of the launch time for i225 and i226 is the ending time of the next cycle
+of the Qbv transmission window of the queue. For example, when the Qbv
+cycle time is set to 1 second, the horizon of the launch time ranges
+from 1 second to 2 seconds, depending on where the Qbv cycle is currently
+running.
+
 Querying Device Capabilities
 ============================
 
@@ -74,6 +135,7 @@ Refer to ``xsk-flags`` features bitmask in
 
 - ``tx-timestamp``: device supports ``XDP_TXMD_FLAGS_TIMESTAMP``
 - ``tx-checksum``: device supports ``XDP_TXMD_FLAGS_CHECKSUM``
+- ``tx-launch-time-fifo``: device supports ``XDP_TXMD_FLAGS_LAUNCH_TIME``
 
 See ``tools/net/ynl/samples/netdev.c`` on how to query this information.
 
diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
index bfe625b55d55d..a58ae7589d121 100644
--- a/include/net/xdp_sock.h
+++ b/include/net/xdp_sock.h
@@ -110,11 +110,16 @@ struct xdp_sock {
  *     indicates position where checksumming should start.
  *     csum_offset indicates position where checksum should be stored.
  *
+ * void (*tmo_request_launch_time)(u64 launch_time, void *priv)
+ *     Called when AF_XDP frame requested launch time HW offload support.
+ *     launch_time indicates the PTP time at which the device can schedule the
+ *     packet for transmission.
  */
 struct xsk_tx_metadata_ops {
 	void	(*tmo_request_timestamp)(void *priv);
 	u64	(*tmo_fill_timestamp)(void *priv);
 	void	(*tmo_request_checksum)(u16 csum_start, u16 csum_offset, void *priv);
+	void	(*tmo_request_launch_time)(u64 launch_time, void *priv);
 };
 
 #ifdef CONFIG_XDP_SOCKETS
@@ -162,6 +167,11 @@ static inline void xsk_tx_metadata_request(const struct xsk_tx_metadata *meta,
 	if (!meta)
 		return;
 
+	if (ops->tmo_request_launch_time)
+		if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+			ops->tmo_request_launch_time(meta->request.launch_time,
+						     priv);
+
 	if (ops->tmo_request_timestamp)
 		if (meta->flags & XDP_TXMD_FLAGS_TIMESTAMP)
 			ops->tmo_request_timestamp(priv);
diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
index 784cd34f5bba5..fe4afb2517197 100644
--- a/include/net/xdp_sock_drv.h
+++ b/include/net/xdp_sock_drv.h
@@ -199,6 +199,7 @@ static inline void *xsk_buff_raw_get_data(struct xsk_buff_pool *pool, u64 addr)
 #define XDP_TXMD_FLAGS_VALID ( \
 		XDP_TXMD_FLAGS_TIMESTAMP | \
 		XDP_TXMD_FLAGS_CHECKSUM | \
+		XDP_TXMD_FLAGS_LAUNCH_TIME | \
 	0)
 
 static inline bool
diff --git a/include/uapi/linux/if_xdp.h b/include/uapi/linux/if_xdp.h
index 42ec5ddaab8dc..42869770776ec 100644
--- a/include/uapi/linux/if_xdp.h
+++ b/include/uapi/linux/if_xdp.h
@@ -127,6 +127,12 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
 
+/* Request launch time hardware offload. The device will schedule the packet for
+ * transmission at a pre-determined time called launch time. The value of
+ * launch time is communicated via launch_time field of struct xsk_tx_metadata.
+ */
+#define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -142,6 +148,10 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+
+			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
+			/* Launch time in nanosecond against the PTP HW Clock */
+			__u64 launch_time;
 		} request;
 
 		struct {
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index e4be227d3ad64..4324e89a80261 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -59,10 +59,13 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is supported
+ *   by the driver.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
 };
 
 enum netdev_queue_type {
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 715f85c6b62ea..7832abc5ca6e2 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -52,6 +52,8 @@ XDP_METADATA_KFUNC_xxx
 			xsk_features |= NETDEV_XSK_FLAGS_TX_TIMESTAMP;
 		if (netdev->xsk_tx_metadata_ops->tmo_request_checksum)
 			xsk_features |= NETDEV_XSK_FLAGS_TX_CHECKSUM;
+		if (netdev->xsk_tx_metadata_ops->tmo_request_launch_time)
+			xsk_features |= NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO;
 	}
 
 	if (nla_put_u32(rsp, NETDEV_A_DEV_IFINDEX, netdev->ifindex) ||
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 89d2bef964698..41093ea63700c 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -742,6 +742,9 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 						goto free_err;
 				}
 			}
+
+			if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
+				skb->skb_mstamp_ns = meta->request.launch_time;
 		}
 	}
 
diff --git a/tools/include/uapi/linux/if_xdp.h b/tools/include/uapi/linux/if_xdp.h
index 42ec5ddaab8dc..42869770776ec 100644
--- a/tools/include/uapi/linux/if_xdp.h
+++ b/tools/include/uapi/linux/if_xdp.h
@@ -127,6 +127,12 @@ struct xdp_options {
  */
 #define XDP_TXMD_FLAGS_CHECKSUM			(1 << 1)
 
+/* Request launch time hardware offload. The device will schedule the packet for
+ * transmission at a pre-determined time called launch time. The value of
+ * launch time is communicated via launch_time field of struct xsk_tx_metadata.
+ */
+#define XDP_TXMD_FLAGS_LAUNCH_TIME		(1 << 2)
+
 /* AF_XDP offloads request. 'request' union member is consumed by the driver
  * when the packet is being transmitted. 'completion' union member is
  * filled by the driver when the transmit completion arrives.
@@ -142,6 +148,10 @@ struct xsk_tx_metadata {
 			__u16 csum_start;
 			/* Offset from csum_start where checksum should be stored. */
 			__u16 csum_offset;
+
+			/* XDP_TXMD_FLAGS_LAUNCH_TIME */
+			/* Launch time in nanosecond against the PTP HW Clock */
+			__u64 launch_time;
 		} request;
 
 		struct {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index e4be227d3ad64..4324e89a80261 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -59,10 +59,13 @@ enum netdev_xdp_rx_metadata {
  *   by the driver.
  * @NETDEV_XSK_FLAGS_TX_CHECKSUM: L3 checksum HW offload is supported by the
  *   driver.
+ * @NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO: Launch time HW offload is supported
+ *   by the driver.
  */
 enum netdev_xsk_flags {
 	NETDEV_XSK_FLAGS_TX_TIMESTAMP = 1,
 	NETDEV_XSK_FLAGS_TX_CHECKSUM = 2,
+	NETDEV_XSK_FLAGS_TX_LAUNCH_TIME_FIFO = 4,
 };
 
 enum netdev_queue_type {
-- 
2.39.5




