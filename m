Return-Path: <stable+bounces-44652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E018C53D1
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05251C2161A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084E13C692;
	Tue, 14 May 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/E9lBSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6DB12F591;
	Tue, 14 May 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686780; cv=none; b=abocaiE7x4V+FFJkC7lbCFGpq9CODms0MvlR8Wq63/9U4/rsZWxFvn3qHCycn8SZnh/a5HEsed2WxusfAbg9SLXiQszckpXZ+J0/NocHk56zj2ORB2JDxu5qF3PpvsaFPo8JFKoa0KNnLM4dfey1tvT7XKZfyc2h5kb6L9Vr74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686780; c=relaxed/simple;
	bh=NL8x7VmPX/MLjUGbAf8M09tKmppInV5TgTJgTnDwlms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvH80X8v4NwhCXSujyDqFVQYFk+PfKhlodxZwfR0TkkXQ0SWlWbyolMhYDVuHSozF5x5N2CiWP4DGumiUZndQel/1wodzUwdKXUJbHWnCijiNK56fZ3n5X+jh1khv6G9A0+Aysj1TeW4RdUnj8X2klZB7DpIYAL035v5bEADwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/E9lBSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151AFC2BD10;
	Tue, 14 May 2024 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686780;
	bh=NL8x7VmPX/MLjUGbAf8M09tKmppInV5TgTJgTnDwlms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/E9lBSKkoYEHaY8QFGXhM2m+aJqGWlW2QLUrCd+4IAEZMj4lB9GY0seF4iz8b35g
	 c8Wy2z+h6arg5FWBVLNZ2Giy/YRpNO0KjgaQHyHpFVdAx8St3ES7R0cBAkdffFGLJY
	 tWvG0qYOU1zrhQzXCUvaV/wDqh3F3v4OFViQdkTA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Shannon Nelson <snelson@pensando.io>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/63] ethernet: add a helper for assigning port addresses
Date: Tue, 14 May 2024 12:19:28 +0200
Message-ID: <20240514100948.292158679@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514100948.010148088@linuxfoundation.org>
References: <20240514100948.010148088@linuxfoundation.org>
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit e80094a473eefad9d856ce3ab0d7afdbb64800c4 ]

We have 5 drivers which offset base MAC addr by port id.
Create a helper for them.

This helper takes care of overflows, which some drivers
did not do, please complain if that's going to break
anything!

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Shannon Nelson <snelson@pensando.io>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 6e159fd653d7 ("ethernet: Add helper for assigning packet type when dest address does not match device address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/etherdevice.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 2932a40060c1d..fef4bb77f7590 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -522,6 +522,27 @@ static inline unsigned long compare_ether_header(const void *a, const void *b)
 #endif
 }
 
+/**
+ * eth_hw_addr_gen - Generate and assign Ethernet address to a port
+ * @dev: pointer to port's net_device structure
+ * @base_addr: base Ethernet address
+ * @id: offset to add to the base address
+ *
+ * Generate a MAC address using a base address and an offset and assign it
+ * to a net_device. Commonly used by switch drivers which need to compute
+ * addresses for all their ports. addr_assign_type is not changed.
+ */
+static inline void eth_hw_addr_gen(struct net_device *dev, const u8 *base_addr,
+				   unsigned int id)
+{
+	u64 u = ether_addr_to_u64(base_addr);
+	u8 addr[ETH_ALEN];
+
+	u += id;
+	u64_to_ether_addr(u, addr);
+	eth_hw_addr_set(dev, addr);
+}
+
 /**
  * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
  * @skb: Buffer to pad
-- 
2.43.0




