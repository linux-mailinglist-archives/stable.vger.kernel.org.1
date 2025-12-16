Return-Path: <stable+bounces-201953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 74672CC29D8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34338302ED98
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD9347FEA;
	Tue, 16 Dec 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bc8P/RfO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE534844C;
	Tue, 16 Dec 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886345; cv=none; b=tJvbQJ6roa7Eq/eqEjCGl4stW8ImYvM/IyLBiOXFca9I3M8yJb4Wy/soI1ugkMQ1ha6OqWUw+CvZ4UeIU8WCUjxQ3G1wdpGyZqZAOQFT3SEinHCAH2zRf5hYg6Z+zHZG0P25Ne+JYs+FfCLpWZJ6w6nTNVa3UWS6arhjRA01kpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886345; c=relaxed/simple;
	bh=jUAiEzkrjiD3BNAm4S5toS2wLLstAQl8nnBq7iFP+DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WvdWJTLK8buf0mNnJuO/dMOOcIiTuJ2h0ROuCKrdSW7Ka1ec47YT3V2QEhl44M/wp9GghzGdLOVheDh70QP3TY/EAUpM265BzNEbIrMNuJRoArsh2xAYzbM38sL+XUqwcZV3cNUDi2FEEKi71cEHxUd6WhFIsVVdZIKVw+xLLa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bc8P/RfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F648C4CEF5;
	Tue, 16 Dec 2025 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886344;
	bh=jUAiEzkrjiD3BNAm4S5toS2wLLstAQl8nnBq7iFP+DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bc8P/RfOeqUhRxyLHaRE1Lm71hkrykntUpuFk38tRLhHCAOVLt2z35Yf4mr8BcgsO
	 6Fu6sGSqraVUw1lHJyR5J93XPeLBAZy4t16OV6p/W0fdknjVmZXQNsAWJOHRLEKKH6
	 XdwB0mguv8vkD3sKZGRJviP8dT/U4JjmZ6BuZwCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 409/507] net: dsa: b53: fix VLAN_ID_IDX write size for BCM5325/65
Date: Tue, 16 Dec 2025 12:14:10 +0100
Message-ID: <20251216111400.281046213@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 6f268e275c74dae0536e0b61982a8db25bcf4f16 ]

Since BCM5325 and BCM5365 only support up to 256 VLANs, the VLAN_ID_IDX
register is only 8 bit wide, not 16 bit, so use an appropriate accessor.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Álvaro Fernández Rojas <noltari@gmail.com>
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://patch.msgid.link/20251128080625.27181-2-jonas.gorski@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index eb767edc4c135..a09ed32dccc07 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1924,8 +1924,12 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 
 	/* Perform a read for the given MAC and VID */
 	b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
-	if (!is5325m(dev))
-		b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	if (!is5325m(dev)) {
+		if (is5325(dev) || is5365(dev))
+			b53_write8(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+		else
+			b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	}
 
 	/* Issue a read operation for this MAC */
 	ret = b53_arl_rw_op(dev, 1);
-- 
2.51.0




