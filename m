Return-Path: <stable+bounces-13050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1EB837A51
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2571C22374
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D145312BF19;
	Tue, 23 Jan 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WA8SZRId"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9191F12A17F;
	Tue, 23 Jan 2024 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968894; cv=none; b=nShppY9u3OZQq/wphqUI2OgJxRUWmjWRHTOzTEDYfnwx0a0l7NmowT7s5qTtaYxdi+oOaSXwbMT33hcqE9ghF7SpS6X4EOhjiid9OywtN8YUNhwa/WeehFPEa6TI3BaOeN044sgXH2C05lSw+UZnzBjJcXnZEjfnM+dLEctw8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968894; c=relaxed/simple;
	bh=JnvvjfI/7i6Ih+4dNfteH08m/y7BL1ISiJ2YHlLb8wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMAkRJBPrioHzJxjs8uXfcE7YD63ZsNpyISXh0+Cvrr50ZneQWMWIqGo0U0VvMmZYeHr68+MlbEML0vgAOx3vS8PEaEDq7uUKOMBDj6ksAniLczUSkUs8gt0mQWebfhY4TsgHw8JqQN+KI2HcyP50Gdqvj9n2XEr2bUqyfjU1hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WA8SZRId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D7EC43390;
	Tue, 23 Jan 2024 00:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968894;
	bh=JnvvjfI/7i6Ih+4dNfteH08m/y7BL1ISiJ2YHlLb8wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WA8SZRId0b5ZQfZF2FWvbVP3CXXiJf+EAEcmun2htqyxn9br0yAIyougEogBuEZae
	 O7hxEga4JWEX9RTS0B2sTSp51kfINFhLFvz4yqXZQ+Xkf8TtUaa9DbPN7zbodCZYiW
	 NXt/BOgh4XZGLB9EZS0YmtSAhbBhxEJ89+ztj4N0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Delevoryas <peter@pjd.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 085/194] net/ncsi: Fix netlink major/minor version numbers
Date: Mon, 22 Jan 2024 15:56:55 -0800
Message-ID: <20240122235722.894087388@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 9b2bfb87c289..1dde6dc841b8 100644
--- a/net/ncsi/internal.h
+++ b/net/ncsi/internal.h
@@ -81,8 +81,11 @@ enum {
 
 
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
index 27700887c321..feb0b422d193 100644
--- a/net/ncsi/ncsi-netlink.c
+++ b/net/ncsi/ncsi-netlink.c
@@ -71,8 +71,8 @@ static int ncsi_write_channel_info(struct sk_buff *skb,
 	if (nc == nc->package->preferred_channel)
 		nla_put_flag(skb, NCSI_CHANNEL_ATTR_FORCED);
 
-	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.version);
-	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MINOR, nc->version.alpha2);
+	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MAJOR, nc->version.major);
+	nla_put_u32(skb, NCSI_CHANNEL_ATTR_VERSION_MINOR, nc->version.minor);
 	nla_put_string(skb, NCSI_CHANNEL_ATTR_VERSION_STR, nc->version.fw_name);
 
 	vid_nest = nla_nest_start_noflag(skb, NCSI_CHANNEL_ATTR_VLAN_LIST);
diff --git a/net/ncsi/ncsi-pkt.h b/net/ncsi/ncsi-pkt.h
index 80938b338fee..3fbea7e74fb1 100644
--- a/net/ncsi/ncsi-pkt.h
+++ b/net/ncsi/ncsi-pkt.h
@@ -191,9 +191,12 @@ struct ncsi_rsp_gls_pkt {
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
index e1c6bb4ab98f..876622e9a5b2 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -19,6 +19,19 @@
 #include "ncsi-pkt.h"
 #include "ncsi-netlink.h"
 
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
@@ -755,9 +768,18 @@ static int ncsi_rsp_handler_gvi(struct ncsi_request *nr)
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




