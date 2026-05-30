Return-Path: <stable+bounces-257454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAQmEPYbG2p3/QgAu9opvQ
	(envelope-from <stable+bounces-257454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:18:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1D660F5D0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFEBF306407B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD1395AD8;
	Sat, 30 May 2026 17:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rHZwTqLY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF06A3148DA;
	Sat, 30 May 2026 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161052; cv=none; b=OPGAXg1K3+hm+xl/lZEDLOc3khCGCbVQHRXsmN12T+Qqk2V8PeLA22ZD6SHyNiV63Uh/52PARTuNoyYQOrDg3Jcbf5l8uAdMuB27PN39ZS4ZRqZj5MYinBTnZ7qkpScJXmxxCB874gC1P9eb/3hC7B3YmHdkv7lr4FQh5gikTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161052; c=relaxed/simple;
	bh=eA2LAAmzMx6RFyZEgkxp7f0H0ie/s7KnRMXdJK7tdt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJH6lA86XyMrtKAZs3AqzB6eZtgpkGDOOxL2V4VmQ4LKJyEz1zVEN8CrjhDvScl7PnBDhz4kt/RRwAtFpr5CoOCYGmFCXpvEwxOCMagDfWXsSFKj6vwetzLov24GrUYGt2TsrQ51pxhlItdnWpVHxjhzVmyBj85P5fE4OZDhByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rHZwTqLY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F31F00893;
	Sat, 30 May 2026 17:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161051;
	bh=Uiv9YqIhEdJrf335en/8i5kWcJ0zIWWxUa/Xqf+eOiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rHZwTqLYuXBvjpezU54cVbOpoUspXdENhK3enn2t85oi8rbu2eU7+Pd1SM7q2JqRP
	 jQ6YiiVEQHYzajAFUIod4STrtdpkdkPBZBHpt+1qXRNdetLnU/5CFVU5JJq56gX70C
	 rhVY9qawXd4D6H9T2bVWNkM0Ibmm0+GGsF4oQFmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 512/969] spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
Date: Sat, 30 May 2026 18:00:36 +0200
Message-ID: <20260530160314.475055739@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257454-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CA1D660F5D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit 9f61daf2c2debe9f5cf4e1a4471e56a89a6fe45a ]

The hisi_spi_flush_fifo()'s inner while loop that lacks any timeout
mechanism. Maybe the hardware never becomes empty, the loop will spin
forever, causing the CPU to hang.

Fix this by adding a inner_limit based on loops_per_jiffy. The inner loop
now exits after approximately one jiffy if the FIFO remains non-empty, logs
a ratelimited warning, and breaks out of the outer loop. Additionally, add
a cpu_relax() inside the busy loop to improve power efficiency.

Fixes: c770d8631e18 ("spi: Add HiSilicon SPI Controller Driver for Kunpeng SoCs")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Link: https://patch.msgid.link/d834ce28172886bfaeb9c8ca00cfd9bf1c65d5a1.1773889292.git.xiaopei01@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-hisi-kunpeng.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpeng.c
index 54730e93fba45..06c8893243b7d 100644
--- a/drivers/spi/spi-hisi-kunpeng.c
+++ b/drivers/spi/spi-hisi-kunpeng.c
@@ -198,8 +198,18 @@ static void hisi_spi_flush_fifo(struct hisi_spi *hs)
 	unsigned long limit = loops_per_jiffy << 1;
 
 	do {
-		while (hisi_spi_rx_not_empty(hs))
+		unsigned long inner_limit = loops_per_jiffy;
+
+		while (hisi_spi_rx_not_empty(hs) && --inner_limit) {
 			readl(hs->regs + HISI_SPI_DOUT);
+			cpu_relax();
+		}
+
+		if (!inner_limit) {
+			dev_warn_ratelimited(hs->dev, "RX FIFO flush timeout\n");
+			break;
+		}
+
 	} while (hisi_spi_busy(hs) && limit--);
 }
 
-- 
2.53.0




