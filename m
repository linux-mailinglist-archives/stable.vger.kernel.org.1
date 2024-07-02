Return-Path: <stable+bounces-56389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89031924428
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19957B21DD0
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EE61BE236;
	Tue,  2 Jul 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pmhge1v9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C01BE232;
	Tue,  2 Jul 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940023; cv=none; b=Cw2GUGk13w/TV5l8SbcQQZsb1sxIPDf2bF0JZuQ71t40j0Wy6rCRFX52s/6Ovtk1bhLdLXZ6Y50JDoZA5ERh3N0/oXfB2SUYzdXWbsDOQiEC9ke/LAgbk7ofTjdsB13t/sosDvWct3L44zAEfOjMOr/x1zfxstwK0kkqpmJhRt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940023; c=relaxed/simple;
	bh=t6kwL9sVYM2PMPtDTJYRMk6i40lLhsA0A6gcTrGGYZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Umbkr9QoGORxe7j5B/DFnKZ7LvaDh8Qtq4XxpmqabahhaOhyyBObo8fwUrWmdqHl2PoZ85/W48eauE0q/wM9qOrxXJ0T7wXYPlz/yS9IYEB32xnxa0epdgjgSSKJFg4+T4P9uYDizHDg8opMx8qJw7MRBSzaTweDd6s+Pd10JQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pmhge1v9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF82EC4AF0A;
	Tue,  2 Jul 2024 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719940023;
	bh=t6kwL9sVYM2PMPtDTJYRMk6i40lLhsA0A6gcTrGGYZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pmhge1v9aeoHgbp5saW29wFwSEUXxkNwKI8bYORwJv+BLq5Xs9zEnIKjdLNf+vpvJ
	 7X4JfzUm3pE0hX9gaeNCrr3u/AJrwwRj6Yokc3K7RuivncccrCNT7iqhjg8wijVCEt
	 HyA4COvxGJnXIxfRxQE9AfTKRMRyQYrwmB71s7x8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tristram Ha <tristram.ha@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 030/222] net: dsa: microchip: fix initial port flush problem
Date: Tue,  2 Jul 2024 19:01:08 +0200
Message-ID: <20240702170245.130112276@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
References: <20240702170243.963426416@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

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
index 7f745628c84d1..05767d3025f77 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -355,10 +355,8 @@ int ksz9477_reset_switch(struct ksz_device *dev)
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




