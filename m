Return-Path: <stable+bounces-83719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09699BF03
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314821F24C8B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95F617C222;
	Mon, 14 Oct 2024 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ+4Jui6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2E14D439;
	Mon, 14 Oct 2024 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878409; cv=none; b=FU3JfueHxcN/UTdUPrIIuhG15Pd/y6DuTEIzTlG/pRzPtsunVj6F7+Vgee0NYO4+sNxn6ize6MWVsbZT3OQimiEJxc5JmhHSiXou7EBoqjpHh7pu2RIpXv6Cb29RO8zWnr4P2FET1kZSTKo54H4wbpMKHE8aFajgO/gGrx7xUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878409; c=relaxed/simple;
	bh=+WSRXMC+VsIy6Szd1RyGf7gAmCOYidxhPd++XnLVoJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q6MHMO8khHoZuOE+bD8dcpoWTn5XLEWdn0Kff9auUUDNKvg3YozoxRYJF2ISw4kbVpsxMWbx74IcK80qicLRqfXtrj/yL5WTEVZLwP6rLHOMZfVEMIoIGY5nrxRwl3kASN3lpctTy7HVnFnXnoF8nZDBr1ScTAkS6x+o5v+/QyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ+4Jui6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C563AC4CEC3;
	Mon, 14 Oct 2024 04:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878409;
	bh=+WSRXMC+VsIy6Szd1RyGf7gAmCOYidxhPd++XnLVoJE=;
	h=From:To:Cc:Subject:Date:From;
	b=AZ+4Jui6a4YigKq5vfx/EN8eiIfEH6Mp2xRo6LdKSFDcFOufNnTc6KHWoaCMQq5AB
	 ACmGfrnjvJ9AKxNnRnvdJjXnKtbpzPrPNmdYSOdW2uTOwt+yLLebHpMjLVFrZy+qw2
	 8/s8gVXU533FQuDznv5BrjmfPURKujblzd1LpupV+bHkwblu9EZxRE8Ynj5Q8wohd6
	 CaJcgHendJz8wzMnNaBz6hiyQhRRx3KicRehEK9Jpl2zPubx3mOsYmRenvSwWqk3OT
	 /m9vIEGGHMxSjwbiy7rQEku4lTb3+2iBc99sV9cxksU/9Bfc+DeqGYBRW40Dx+cbFX
	 67vm3CJxnUmWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Palmer <daniel@0x0f.com>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	quic_jjohnson@quicinc.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/2] net: amd: mvme147: Fix probe banner message
Date: Mon, 14 Oct 2024 00:00:01 -0400
Message-ID: <20241014040006.2269066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
Content-Transfer-Encoding: 8bit

From: Daniel Palmer <daniel@0x0f.com>

[ Upstream commit 82c5b53140faf89c31ea2b3a0985a2f291694169 ]

Currently this driver prints this line with what looks like
a rogue format specifier when the device is probed:
[    2.840000] eth%d: MVME147 at 0xfffe1800, irq 12, Hardware Address xx:xx:xx:xx:xx:xx

Change the printk() for netdev_info() and move it after the
registration has completed so it prints out the name of the
interface properly.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/mvme147.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/mvme147.c b/drivers/net/ethernet/amd/mvme147.c
index 0a920448522f3..0bb27f4dd6428 100644
--- a/drivers/net/ethernet/amd/mvme147.c
+++ b/drivers/net/ethernet/amd/mvme147.c
@@ -105,10 +105,6 @@ struct net_device * __init mvme147lance_probe(int unit)
 	address = address >> 8;
 	dev->dev_addr[3] = address&0xff;
 
-	printk("%s: MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
-	       dev->name, dev->base_addr, MVME147_LANCE_IRQ,
-	       dev->dev_addr);
-
 	lp = netdev_priv(dev);
 	lp->ram = __get_dma_pages(GFP_ATOMIC, 3);	/* 32K */
 	if (!lp->ram) {
@@ -138,6 +134,9 @@ struct net_device * __init mvme147lance_probe(int unit)
 		return ERR_PTR(err);
 	}
 
+	netdev_info(dev, "MVME147 at 0x%08lx, irq %d, Hardware Address %pM\n",
+		    dev->base_addr, MVME147_LANCE_IRQ, dev->dev_addr);
+
 	return dev;
 }
 
-- 
2.43.0


