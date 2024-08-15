Return-Path: <stable+bounces-67786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B4952F19
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 15:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 745BA2885E8
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F2519F489;
	Thu, 15 Aug 2024 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bljT1P4I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48911DFFB;
	Thu, 15 Aug 2024 13:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728513; cv=none; b=uTOdij/smyLcng1JbOP+3n8EYmfzpk28t/74SsGMLMKydEWwZzzDsP7DkvGVHlGbYsoRNY0jsgjvLpJ1ubbtegn/PM3z208HbdKm1JOk1YTgR2IjsW9QhdHwFmclf+WZ47rB3iuvKX3AgDfd2ERbvIGjIBcOh8TS93yk+Xgn/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728513; c=relaxed/simple;
	bh=VnQweY/hKSe6dRPdlegpjeLzxegGqPtVMOaklM1NWvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7H6dZt6Svy33440hT6y4a0/8ghf/0DcbP9oUc6VnPP22OkYtcChz6CPb1WH/LweM9iKzzHoYVkH5FfcAuoynrBbgZq4BXXK/AXTHIvV/7ykRW0eZmFrM7YEgxgktY2MNsLfQ2LUbuxT+VBcvfBZSRrjsLxta/ktICRshBRhsvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bljT1P4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A80C32786;
	Thu, 15 Aug 2024 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723728512;
	bh=VnQweY/hKSe6dRPdlegpjeLzxegGqPtVMOaklM1NWvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bljT1P4IIlqCBFl5SqRXPMsQRSDihfpKc/iE8N3LF+N/GOYwFzv0mOzv8mHQSB1LN
	 88m48KDqEbcWBD4i9TjrzLBtD3eobOys3fOunSPtstBtWNU8d5a0+GXds/Mm7z84ft
	 wkg6HmexMQdgsiAMXsfrovy9WqXwftCT2pDehZow=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev, Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s@web.codeaurora.org,
	=20Bence?= <csokas.bence@prolan.hu>, Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 024/196] net: fec: Fix FEC_ECR_EN1588 being cleared on link-down
Date: Thu, 15 Aug 2024 15:22:21 +0200
Message-ID: <20240815131853.010851917@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
References: <20240815131852.063866671@linuxfoundation.org>
User-Agent: quilt/0.67
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Csókás, Bence <csokas.bence@prolan.hu>

[ Upstream commit c32fe1986f27cac329767d3497986e306cad1d5e ]

FEC_ECR_EN1588 bit gets cleared after MAC reset in `fec_stop()`, which
makes all 1588 functionality shut down, and all the extended registers
disappear, on link-down, making the adapter fall back to compatibility
"dumb mode". However, some functionality needs to be retained (e.g. PPS)
even without link.

Fixes: 6605b730c061 ("FEC: Add time stamping code and a PTP hardware clock")
Cc: Richard Cochran <richardcochran@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/netdev/5fa9fadc-a89d-467a-aae9-c65469ff5fe1@lunn.ch/
Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 32775326414b7..29ef84b7c9cc5 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1202,6 +1202,12 @@ fec_stop(struct net_device *ndev)
 		writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
 		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
+
+	if (fep->bufdesc_ex) {
+		val = readl(fep->hwp + FEC_ECNTRL);
+		val |= FEC_ECR_EN1588;
+		writel(val, fep->hwp + FEC_ECNTRL);
+	}
 }
 
 static void
-- 
2.43.0




