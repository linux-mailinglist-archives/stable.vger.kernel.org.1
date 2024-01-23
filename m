Return-Path: <stable+bounces-12884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6E8378DC
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E428330A
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E1144608;
	Tue, 23 Jan 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QDAvOrvV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574B450E2;
	Tue, 23 Jan 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968278; cv=none; b=oknT+tED3/m4AB8M3rUPXF+ixjFgJ4Qno5LqJzI1og3JmsO8p5bgKNLsDl73qC/cKjHHwgj6LtnCsCGZnmQqHb6N8Js7uv6fSHzL/LcvNZFY0Icc1laEB/ontZAgev7/vgt+lrQIg5WbBA5QL3/Vph7L0BTPOuULo7cnrkZvHek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968278; c=relaxed/simple;
	bh=gN9Bd3fJE0jf+lXJUL4E6nhm4mew5zdiGA5QrfV07UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFlwz/fdJgc2F/Ib14JygLl1Mddg9dfDMWUAT43P0ZXo63kLhxXzmTxyyg0GeW7pKVnbHx38BPZ74VaMe/aFiRTJFRVUxyOY0nzLnG5aA36IKRzFTdtaoBo1SegLYqhwYZDDge2JiTppoPOHVju9rYI5xG6LiQ7ED/WdPOeYZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QDAvOrvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E158FC433A6;
	Tue, 23 Jan 2024 00:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968278;
	bh=gN9Bd3fJE0jf+lXJUL4E6nhm4mew5zdiGA5QrfV07UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDAvOrvVCK7/tCUqGMYm/BVRMbkYjRKLhBddsX8pengS4XbDVRe/XTLUdF0/10BlX
	 JeE4XZGjSju1DPxprq/5Ezbw28aSb28SXrCAKMT7L/c0YwPDamiGas5LjIOVot+Dec
	 FP/RBDIaVQVfd9dXPXoErk50rBb2eZrtmHMRuYu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Delevoryas <peter@pjd.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 068/148] net/ncsi: Fix netlink major/minor version numbers
Date: Mon, 22 Jan 2024 15:57:04 -0800
Message-ID: <20240122235715.147310184@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235712.442097787@linuxfoundation.org>
References: <20240122235712.442097787@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Delevoryas <peter@pjd.dev>

[ Upstream commit 3084b58bfd0b9e4b5e034f31f31b42977db35f12 ]

The netlink interface for major and minor version numbers doesn't actually
return the major and minor version numbers.

It reports a u32 that contains the (major, minor, update, alpha1)
components as the major version number, and then alpha2 as the minor
version number.

For whatever reason, the u32 byte order was reversed (ntohl): maybe it was
assumed that the encoded value was a single big-endian u32, and alpha2 was
the minor version.

The correct way to get the supported NC-SI version from the network
controller is to parse the Get Version ID response as described in 8.4.44
of the NC-SI spec[1].

    Get Version ID Response Packet Format

              Bits
            +--------+--------+--------+--------+
     Bytes  | 31..24 | 23..16 | 15..8  | 7..0   |
    +-------+--------+--------+--------+--------+
    | 0..15 | NC-SI Header                      |
    +-------+--------+--------+--------+--------+
    | 16..19| Response code   | Reason code     |
    +-------+--------+--------+--------+--------+
    |20..23 | Major  | Minor  | Update | Alpha1 |
    +-------+--------+--------+--------+--------+
    |24..27 |         reserved         | Alpha2 |
    +-------+--------+--------+--------+--------+
    |            .... other stuff ....          |

The major, minor, and update fields are all binary-coded decimal (BCD)
encoded [2]. The spec provides examples below the Get Version ID response
format in section 8.4.44.1, but for practical purposes, this is an example
from a live network card:

    root@bmc:~# ncsi-util 0x15
    NC-SI Command Response:
    cmd: GET_VERSION_ID(0x15)
    Response: COMMAND_COMPLETED(0x0000)  Reason: NO_ERROR(0x0000)
    Payload length = 40

    20: 0xf1 0xf1 0xf0 0x00 <<<<<<<<< (major, minor, update, alpha1)
    24: 0x00 0x00 0x00 0x00 <<<<<<<<< (_, _, _, alpha2)

    28: 0x6d 0x6c 0x78 0x30
    32: 0x2e 0x31 0x00 0x00
    36: 0x00 0x00 0x00 0x00
    40: 0x16 0x1d 0x07 0xd2
    44: 0x10 0x1d 0x15 0xb3
    48: 0x00 0x17 0x15 0xb3
    52: 0x00 0x00 0x81 0x19

This should be parsed as "1.1.0".

"f" in the upper-nibble means to ignore it, contributing zero.

If both nibbles are "f", I think the whole field is supposed to be ignored.
Major and minor are "required", meaning they're not supposed to be "ff",
but the update field is "optional" so I think it can be ff. I think the
simplest thing to do is just set the major and minor to zero instead of
juggling some conditional logic or something.

bcd2bin() from "include/linux/bcd.h" seems to assume both nibbles are 0-9,
so I've provided a custom BCD decoding function.

Alpha1 and alpha2 are ISO/IEC 8859-1 encoded, which just means ASCII
characters as far as I can tell, although the full encoding table for
non-alphabetic characters is slightly different (I think).

I imagine the alpha fields are just supposed to be alphabetic characters,
but I haven't seen any network cards actually report a non-zero value for
either.

If people wrote software against this netlink behavior, and were parsing
the major and minor versions themselves from the u32, then this would
definitely break their code.

[1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.0.0.pdf
[2] https://en.wikipedia.org/wiki/Binary-coded_decimal
[2] https://en.wikipedia.org/wiki/ISO/IEC_8859-1

Signed-off-by: Peter Delevoryas <peter@pjd.dev>
Fixes: 138635cc27c9 ("net/ncsi: NCSI response packet handler")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ncsi/internal.h     |  7 +++++--
 net/ncsi/ncsi-netlink.c |  4 ++--
 net/ncsi/ncsi-pkt.h     |  7 +++++--
 net/ncsi/ncsi-rsp.c     | 26 ++++++++++++++++++++++++--
 4 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/net/ncsi/internal.h b/net/ncsi/internal.h
index 176d19df85b3..2477caf9c967 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -69,8 +69,11 @@ enum {
 };
 
 struct ncsi_channel_version {
-	u32 version;		/* Supported BCD encoded NCSI version */
-	u32 alpha2;		/* Supported BCD encoded NCSI version */
+	u8   major;		/* NCSI version major */
+	u8   minor;		/* NCSI version minor */
+	u8   update;		/* NCSI version update */
+	char alpha1;		/* NCSI version alpha1 */
+	char alpha2;		/* NCSI version alpha2 */
 	u8  fw_name[12];	/* Firmware name string                */
 	u32 fw_version;		/* Firmware version                   */
 	u16 pci_ids[4];		/* PCI identification                 */
diff --git a/net/ncsi/ncsi-netlink.c b/net/ncsi/ncsi-netlink.c
index a2f4280e2889..d0169bf0fcce 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -71,8 +71,8 @@ static int ncsi_write_channel_info(struct sk_buff *skb,
 	if (ndp->force_channel == nc)
 		nla_put_flag(skb, NCSI_CHANNEL_ATTR_FORCED);
 
-	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.version);
-	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MINOR, nc->version.alpha2);
+	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.major);
+	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MINOR, nc->version.minor);
 	nla_put_string(skb, NCSI_CHANNEL_ATTR_VERSION_STR, nc->version.fw_name);
 
 	vid_nest = nla_nest_start(skb, NCSI_CHANNEL_ATTR_VLAN_LIST);
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index 91b4b66438df..0bf62b4883d4 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -164,9 +164,12 @@ struct ncsi_rsp_gls_pkt {
 /* Get Version ID */
 struct ncsi_rsp_gvi_pkt {
 	struct ncsi_rsp_pkt_hdr rsp;          /* Response header */
-	__be32                  ncsi_version; /* NCSI version    */
+	unsigned char           major;        /* NCSI version major */
+	unsigned char           minor;        /* NCSI version minor */
+	unsigned char           update;       /* NCSI version update */
+	unsigned char           alpha1;       /* NCSI version alpha1 */
 	unsigned char           reserved[3];  /* Reserved        */
-	unsigned char           alpha2;       /* NCSI version    */
+	unsigned char           alpha2;       /* NCSI version alpha2 */
 	unsigned char           fw_name[12];  /* f/w name string */
 	__be32                  fw_version;   /* f/w version     */
 	__be16                  pci_ids[4];   /* PCI IDs         */
diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index a43c9a44f870..05dea43bbc66 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -20,6 +20,19 @@
 #include "internal.h"
 #include "ncsi-pkt.h"
 
+/* Nibbles within [0xA, 0xF] add zero "0" to the returned value.
+ * Optional fields (encoded as 0xFF) will default to zero.
+ */
+static u8 decode_bcd_u8(u8 x)
+{
+	int lo = x & 0xF;
+	int hi = x >> 4;
+
+	lo = lo < 0xA ? lo : 0;
+	hi = hi < 0xA ? hi : 0;
+	return lo + hi * 10;
+}
+
 static int ncsi_validate_rsp_pkt(struct ncsi_request *nr,
 				 unsigned short payload)
 {
@@ -611,9 +624,18 @@ static int ncsi_rsp_handler_gvi(struct ncsi_request *nr)
 	if (!nc)
 		return -ENODEV;
 
-	/* Update to channel's version info */
+	/* Update channel's version info
+	 *
+	 * Major, minor, and update fields are supposed to be
+	 * unsigned integers encoded as packed BCD.
+	 *
+	 * Alpha1 and alpha2 are ISO/IEC 8859-1 characters.
+	 */
 	ncv = &nc->version;
-	ncv->version = ntohl(rsp->ncsi_version);
+	ncv->major = decode_bcd_u8(rsp->major);
+	ncv->minor = decode_bcd_u8(rsp->minor);
+	ncv->update = decode_bcd_u8(rsp->update);
+	ncv->alpha1 = rsp->alpha1;
 	ncv->alpha2 = rsp->alpha2;
 	memcpy(ncv->fw_name, rsp->fw_name, 12);
 	ncv->fw_version = ntohl(rsp->fw_version);
-- 
2.43.0




