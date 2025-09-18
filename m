Return-Path: <stable+bounces-176179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAD4B36CFD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4BD63BD794
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C30353346;
	Tue, 26 Aug 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QSHO8569"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C7352077;
	Tue, 26 Aug 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218988; cv=none; b=aZr/3rdvM3Oh9GZLtWDNUeZTk6Z5Eq6j+eAvD32dDkzUWoPTTzbRFzMDrc4qekgq4nBEEI6Q/XhuEDZPeD6Fg89H1kZpU8pL3uF/QiqglhVkzJ7+YsHugRg2eIn15opeN7J2VDPTTimHEKpHUt86lApgg8itEw8AMraNM+ZnHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218988; c=relaxed/simple;
	bh=CsPCV7L8OYFxUqPv2yl/EsEGg4xwEscNOVySSKpAzvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/h+gwGRked6NeeXGWgnP+1ofTAUtSe3RoRX5tAU8MotZO04NKPMZYSPUYGj8UIc0+hqQiQIZWFuQiUXgTb+NV2WVZ/UgKTtgFQ1v0cuzfZPIcOw0DL7hJiTjcKvJnlbkdZrUQE2eOtFP+i59fx6WGeJuq+L/ZylKyPcClyDQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QSHO8569; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7D7C4CEF1;
	Tue, 26 Aug 2025 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756218987;
	bh=CsPCV7L8OYFxUqPv2yl/EsEGg4xwEscNOVySSKpAzvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSHO856960kSWxBUJiQWlUSm1ZjKpFohXevGEnKuWBiHjVpcqoJPZq0vsRHfMGaIH
	 NxbrsY09ytbg/zxA5AaGnDsVNzg/FIwKwt5C5nuUH87gHJT5fam2Pe6DawbCz2OlTn
	 pOG4KordRvzk6vavQU9157KYaUGSdy5qzJSShaG8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 209/403] be2net: Use correct byte order and format string for TCP seq and ack_seq
Date: Tue, 26 Aug 2025 13:08:55 +0200
Message-ID: <20250826110912.619249275@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit 4701ee5044fb3992f1c910630a9673c2dc600ce5 ]

The TCP header fields seq and ack_seq are 32-bit values in network
byte order as (__be32). these fields were earlier printed using
ntohs(), which converts only 16-bit values and produces incorrect
results for 32-bit fields. This patch is changeing the conversion
to ntohl(), ensuring correct interpretation of these sequence numbers.

Notably, the format specifier is updated from %d to %u to reflect the
unsigned nature of these fields.

improves the accuracy of debug log messages for TCP sequence and
acknowledgment numbers during TX timeouts.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250717193552.3648791-1-alok.a.tiwari@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/emulex/benet/be_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 4b9380003c85..ce235def334f 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1467,10 +1467,10 @@ static void be_tx_timeout(struct net_device *netdev)
 						 ntohs(tcphdr->source));
 					dev_info(dev, "TCP dest port %d\n",
 						 ntohs(tcphdr->dest));
-					dev_info(dev, "TCP sequence num %d\n",
-						 ntohs(tcphdr->seq));
-					dev_info(dev, "TCP ack_seq %d\n",
-						 ntohs(tcphdr->ack_seq));
+					dev_info(dev, "TCP sequence num %u\n",
+						 ntohl(tcphdr->seq));
+					dev_info(dev, "TCP ack_seq %u\n",
+						 ntohl(tcphdr->ack_seq));
 				} else if (ip_hdr(skb)->protocol ==
 					   IPPROTO_UDP) {
 					udphdr = udp_hdr(skb);
-- 
2.39.5




