Return-Path: <stable+bounces-156019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFC5AE44BC
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495E04A28F6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3751254AE7;
	Mon, 23 Jun 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gUcIah7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBAD347DD;
	Mon, 23 Jun 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685938; cv=none; b=VfYeJfHaaMH2rFhRLIHCXUipA7IK0G9idlI5aRo2CDzEf8acC7QJMIZBFIUECVH+nyxPCkGN6/2DViAo/hSqaptUCKobbiGGJao9uznux5iSugoOJTHcSo3C+hZWK5eSMbLE+z+CJI4wgSHePP4ER2gkdmAhEhFKM5dzpSVMRCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685938; c=relaxed/simple;
	bh=yD/hOhY2zjhmB6g+FEZkB/otTa2/HakNQZgaZi2+bCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMwOl8UsmsPyGM2zTEDOZhdNoPsl8YSoQ3/77YWmQ+tH6f3TBGUIpbRsQ6MuLFTd0NYScObjwdzJL6bm44/tGSW99HgnZYoaZLKegWH9LZwwK+D1zG6vjvV6Mn9arLwYR+XBvWYcea6ZnrxXauGBX+v/byOQhiZHJ2BcTJ4OE0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gUcIah7K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251F7C4CEEA;
	Mon, 23 Jun 2025 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685938;
	bh=yD/hOhY2zjhmB6g+FEZkB/otTa2/HakNQZgaZi2+bCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gUcIah7KJnJzsSdONOvYRjZ5FOgxQJnFjvCSuRGtUJIcx93cW3L2KUZSXu1NPxpqq
	 ALo8RRMx2BOi+3I78Esp39UECB0YQ8wbjn6UrfkpSnjeTI/fUWMY2T2Ipei+HZsYAx
	 yrWwpZGJ2AO4I0DHRI4HJfXt7cg3+zGkIp7JZR9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Robert Morris <rtm@mit.edu>,
	Christian Lamparter <chunkeey@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.6 013/290] wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()
Date: Mon, 23 Jun 2025 15:04:34 +0200
Message-ID: <20250623130627.381063139@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@gmail.com>

commit da1b9a55ff116cb040528ef664c70a4eec03ae99 upstream.

Robert Morris reported:

|If a malicious USB device pretends to be an Intersil p54 wifi
|interface and generates an eeprom_readback message with a large
|eeprom->v1.len, p54_rx_eeprom_readback() will copy data from the
|message beyond the end of priv->eeprom.
|
|static void p54_rx_eeprom_readback(struct p54_common *priv,
|                                   struct sk_buff *skb)
|{
|        struct p54_hdr *hdr = (struct p54_hdr *) skb->data;
|        struct p54_eeprom_lm86 *eeprom = (struct p54_eeprom_lm86 *) hdr->data;
|
|        if (priv->fw_var >= 0x509) {
|                memcpy(priv->eeprom, eeprom->v2.data,
|                       le16_to_cpu(eeprom->v2.len));
|        } else {
|                memcpy(priv->eeprom, eeprom->v1.data,
|                       le16_to_cpu(eeprom->v1.len));
|        }
| [...]

The eeprom->v{1,2}.len is set by the driver in p54_download_eeprom().
The device is supposed to provide the same length back to the driver.
But yes, it's possible (like shown in the report) to alter the value
to something that causes a crash/panic due to overrun.

This patch addresses the issue by adding the size to the common device
context, so p54_rx_eeprom_readback no longer relies on possibly tampered
values... That said, it also checks if the "firmware" altered the value
and no longer copies them.

The one, small saving grace is: Before the driver tries to read the eeprom,
it needs to upload >a< firmware. the vendor firmware has a proprietary
license and as a reason, it is not present on most distributions by
default.

Cc: <stable@kernel.org>
Reported-by: Robert Morris <rtm@mit.edu>
Closes: https://lore.kernel.org/linux-wireless/28782.1747258414@localhost/
Fixes: 7cb770729ba8 ("p54: move eeprom code into common library")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Link: https://patch.msgid.link/20250516184107.47794-1-chunkeey@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intersil/p54/fwio.c |    2 ++
 drivers/net/wireless/intersil/p54/p54.h  |    1 +
 drivers/net/wireless/intersil/p54/txrx.c |   13 +++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -231,6 +231,7 @@ int p54_download_eeprom(struct p54_commo
 
 	mutex_lock(&priv->eeprom_mutex);
 	priv->eeprom = buf;
+	priv->eeprom_slice_size = len;
 	eeprom_hdr = skb_put(skb, eeprom_hdr_size + len);
 
 	if (priv->fw_var < 0x509) {
@@ -253,6 +254,7 @@ int p54_download_eeprom(struct p54_commo
 		ret = -EBUSY;
 	}
 	priv->eeprom = NULL;
+	priv->eeprom_slice_size = 0;
 	mutex_unlock(&priv->eeprom_mutex);
 	return ret;
 }
--- a/drivers/net/wireless/intersil/p54/p54.h
+++ b/drivers/net/wireless/intersil/p54/p54.h
@@ -258,6 +258,7 @@ struct p54_common {
 
 	/* eeprom handling */
 	void *eeprom;
+	size_t eeprom_slice_size;
 	struct completion eeprom_comp;
 	struct mutex eeprom_mutex;
 };
--- a/drivers/net/wireless/intersil/p54/txrx.c
+++ b/drivers/net/wireless/intersil/p54/txrx.c
@@ -496,14 +496,19 @@ static void p54_rx_eeprom_readback(struc
 		return ;
 
 	if (priv->fw_var >= 0x509) {
-		memcpy(priv->eeprom, eeprom->v2.data,
-		       le16_to_cpu(eeprom->v2.len));
+		if (le16_to_cpu(eeprom->v2.len) != priv->eeprom_slice_size)
+			return;
+
+		memcpy(priv->eeprom, eeprom->v2.data, priv->eeprom_slice_size);
 	} else {
-		memcpy(priv->eeprom, eeprom->v1.data,
-		       le16_to_cpu(eeprom->v1.len));
+		if (le16_to_cpu(eeprom->v1.len) != priv->eeprom_slice_size)
+			return;
+
+		memcpy(priv->eeprom, eeprom->v1.data, priv->eeprom_slice_size);
 	}
 
 	priv->eeprom = NULL;
+	priv->eeprom_slice_size = 0;
 	tmp = p54_find_and_unlink_skb(priv, hdr->req_id);
 	dev_kfree_skb_any(tmp);
 	complete(&priv->eeprom_comp);



