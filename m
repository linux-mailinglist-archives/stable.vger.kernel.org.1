Return-Path: <stable+bounces-57200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA8925B71
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDD41F288DE
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF37A186280;
	Wed,  3 Jul 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yE92vF+R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA48185E76;
	Wed,  3 Jul 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004160; cv=none; b=Hp9/paftKJOniZ5JrUscEIzadsHnVWlbxqPiA+rWIY6Vbc3sSjlDjAL2IayWXbih/dfNhvBEz023kM+y/I6h8SFjOS7CQkLAAQAvzIa/lA2n9xvxalDBJuys1OxV12dw8mzTZMIABSozNeB4/piu9b6LK5MURE8CXfEBVqF3DHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004160; c=relaxed/simple;
	bh=nQolcry3uktjaSecXn1NiDMgPXNlVOlO9YJ6hhUcRT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmBkJqedGOZBsiTRz21+Gm+Vej9JzmZ32d5YTvuVYkEeglfPXfvDA+Z2htxW69pMO9Nss7m3mZbfWsKmEm1mBx1fr52qE+scEizvQY0UEB3rssK7bTywM4Ws2C2eXMmpDeYukpbNvNhdRrlarbqnC0w81N9FvTyJBQzVEzDCccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yE92vF+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40E0C32781;
	Wed,  3 Jul 2024 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004160;
	bh=nQolcry3uktjaSecXn1NiDMgPXNlVOlO9YJ6hhUcRT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yE92vF+RGcoh1/xT7TXW/8StNUiCYotH9UXYGM+vBFp6euYOaebtocZk25Xb0W+Fc
	 FCKQSea/5r3HFefzq6I0bhtxu6UvOtpJt9a/ptu7cvduuvvbCEHOU1ZEg9l6kQpGfL
	 dLQbPGjd2XJQhiyDTn2jVOB5boDOuB++LW/IHs2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tristram Ha <tristram.ha@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 141/189] net: dsa: microchip: fix initial port flush problem
Date: Wed,  3 Jul 2024 12:40:02 +0200
Message-ID: <20240703102846.802156831@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
References: <20240703102841.492044697@linuxfoundation.org>
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

From: Tristram Ha <tristram.ha@microchip.com>

[ Upstream commit ad53f5f54f351e967128edbc431f0f26427172cf ]

The very first flush in any port will flush all learned addresses in all
ports.  This can be observed by unplugging the cable from one port while
additional ports are connected and dumping the fdb entries.

This problem is caused by the initially wrong value programmed to the
REG_SW_LUE_CTRL_1 register.  Setting SW_FLUSH_STP_TABLE and
SW_FLUSH_MSTP_TABLE bits does not have an immediate effect.  It is when
ksz9477_flush_dyn_mac_table() is called then the SW_FLUSH_STP_TABLE bit
takes effect and flushes all learned entries.  After that call both bits
are reset and so the next port flush will not cause such problem again.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Link: https://patch.msgid.link/1718756202-2731-1-git-send-email-Tristram.Ha@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz9477.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index ba2dc01e0f6bf..5b398608f2975 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -206,10 +206,8 @@ static int ksz9477_reset_switch(struct ksz_device *dev)
 			   SPI_AUTO_EDGE_DETECTION, 0);
 
 	/* default configuration */
-	ksz_read8(dev, REG_SW_LUE_CTRL_1, &data8);
-	data8 = SW_AGING_ENABLE | SW_LINK_AUTO_AGING |
-	      SW_SRC_ADDR_FILTER | SW_FLUSH_STP_TABLE | SW_FLUSH_MSTP_TABLE;
-	ksz_write8(dev, REG_SW_LUE_CTRL_1, data8);
+	ksz_write8(dev, REG_SW_LUE_CTRL_1,
+		   SW_AGING_ENABLE | SW_LINK_AUTO_AGING | SW_SRC_ADDR_FILTER);
 
 	/* disable interrupts */
 	ksz_write32(dev, REG_SW_INT_MASK__4, SWITCH_INT_MASK);
-- 
2.43.0




