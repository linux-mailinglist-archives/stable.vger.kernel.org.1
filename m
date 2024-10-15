Return-Path: <stable+bounces-85171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D6199E5F4
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A36D1C2139C
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058EF1E32AF;
	Tue, 15 Oct 2024 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gGlkaaWn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75FE1D90DC;
	Tue, 15 Oct 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992213; cv=none; b=Tb9IN0dIUGUrZqH1VcwnYnjAizzFf63Rdn77iPN23fnsREMCN7sHgSOlUorYOiT5CNV7Q2lwJG8SMuu42TM1Pxb0+356ArtzoousPTI0Oqhlnnj3BH3l+/7QY73WmLAtJ1AK13N86wGrAWK7QrL0M7y2CCc8oVMIqj6IpxZds7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992213; c=relaxed/simple;
	bh=B19RevV27K+Jw08LcshaCxXneUMfB7Vwahk42LkgZ3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcCbHOXP4AEKeQ/uGlEfk3raQN+zlp8YCR1z1PrBcTl1ndHvyrRDvf11c7HxaPL/RgqLkAJC6jn9DegN0Ewo9YqVekzvISAaPLMeDW4bdt+Be9HVejISrtTrTXzdgwxTUNaxhKgrPXKftplB1Ao/xJcfrJT1uH7M0GNNbsuNDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gGlkaaWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95CEC4CEC6;
	Tue, 15 Oct 2024 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992213;
	bh=B19RevV27K+Jw08LcshaCxXneUMfB7Vwahk42LkgZ3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gGlkaaWnFukE6UFyYfgYVqGhBmEBfbVGzD9PcW0PQy/UP4FP+EsKgPa+MroFZwwH3
	 eTJf+UyYBHgmuvf0GTnnw68MpziUDS1H/XzN9wee2KNaJritanVIiW6nVnGnXjPvJn
	 Wn91hRcSVlwCuiJCLhg5SnD65GlfaQK/ci2W6VeQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacky Chou <jacky_chou@aspeedtech.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 052/691] net: ftgmac100: Enable TX interrupt to avoid TX timeout
Date: Tue, 15 Oct 2024 13:20:00 +0200
Message-ID: <20241015112442.411448883@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacky Chou <jacky_chou@aspeedtech.com>

[ Upstream commit fef2843bb49f414d1523ca007d088071dee0e055 ]

Currently, the driver only enables RX interrupt to handle RX
packets and TX resources. Sometimes there is not RX traffic,
so the TX resource needs to wait for RX interrupt to free.
This situation will toggle the TX timeout watchdog when the MAC
TX ring has no more resources to transmit packets.
Therefore, enable TX interrupt to release TX resources at any time.

When I am verifying iperf3 over UDP, the network hangs.
Like the log below.

root# iperf3 -c 192.168.100.100 -i1 -t10 -u -b0
Connecting to host 192.168.100.100, port 5201
[  4] local 192.168.100.101 port 35773 connected to 192.168.100.100 port 5201
[ ID] Interval           Transfer     Bandwidth       Total Datagrams
[  4]   0.00-20.42  sec   160 KBytes  64.2 Kbits/sec  20
[  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
[  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
[  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
[  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
[  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
[  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
[  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
[  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
[  4]  20.42-20.42  sec  0.00 Bytes  0.00 bits/sec  0
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval          Transfer    Bandwidth      Jitter   Lost/Total Datagrams
[  4]   0.00-20.42  sec  160 KBytes 64.2 Kbits/sec 0.000 ms 0/20 (0%)
[  4] Sent 20 datagrams
iperf3: error - the server has terminated

The network topology is FTGMAC connects directly to a PC.
UDP does not need to wait for ACK, unlike TCP.
Therefore, FTGMAC needs to enable TX interrupt to release TX resources instead
of waiting for the RX interrupt.

Fixes: 10cbd6407609 ("ftgmac100: Rework NAPI & interrupts handling")
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
Link: https://patch.msgid.link/20240906062831.2243399-1-jacky_chou@aspeedtech.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/faraday/ftgmac100.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 63b3e02fab16..4968f6f0bdbc 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -84,7 +84,7 @@
 			    FTGMAC100_INT_RPKT_BUF)
 
 /* All the interrupts we care about */
-#define FTGMAC100_INT_ALL (FTGMAC100_INT_RPKT_BUF  |  \
+#define FTGMAC100_INT_ALL (FTGMAC100_INT_RXTX  |  \
 			   FTGMAC100_INT_BAD)
 
 /*
-- 
2.43.0




