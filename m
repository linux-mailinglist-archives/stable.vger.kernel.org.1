Return-Path: <stable+bounces-127765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE97A7AB2A
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693E417287E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB825DCFB;
	Thu,  3 Apr 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huPGJh3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B705254B11;
	Thu,  3 Apr 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707040; cv=none; b=pGLZ2t+Fm/HC4I7yvxhuGGp+GYUMK7kAvdNDFC25kdgMe+2b3OKWarr935XJHHBGTWML+jVLK+tiD50lRdaRm+VKGcvR8T7Z7Vspqton4kerR1ItHR6LZhFpZW5tisUjXrd6m6Cnr09/gvaT4StXN/yXPr8va+9qWP6EnK0exZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707040; c=relaxed/simple;
	bh=RyMTmU1OPq0djL736PFY/rdS3rZ1vG6PTHsM/WGCJU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZpeWW6h12KrizpG/76OtK45aKJMrmQu8EBYZH4x0Egp7rLTi0Y7P8nrphZb7it+ywRxybjq1b1tSrvXLhuD4U/xLTr/Od1wEZum++RMgz8eTytxaYWheWEOIkiO+a0ay4dQgofWwecaVkJKpbgQnb/G6CE66B7aJ7pGnwju99s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huPGJh3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B96C4CEE9;
	Thu,  3 Apr 2025 19:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707040;
	bh=RyMTmU1OPq0djL736PFY/rdS3rZ1vG6PTHsM/WGCJU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huPGJh3T0y8E3UoSb0u3W78em65+gl0WBLsb7YYTxU8YaZQWcLJH43CX+R/+FxtFE
	 z5AbkdNnHY2khAnrgX2MzGD34GBo/yJ6wMbMSZSvshDVhR5YyNrVBLOgPCfOift9a6
	 U6BrZcO4fsHfVWbgu2Oegoy0ZAliHvznX1y9OtmV+uqEOZ/5eyxti137j6jij9O6XT
	 R31YCg9g+hpnGdNfG8Rm2s9Rqo1nJj6nQ1bg/EsZYAXeXHZEB1nGHJCNkDB5lzzpKX
	 38QtKQDPLnKmqQbghcm0BpPed0/r12fDachgsB2OYEmNxwIePb5muoyRxrue6z8gBY
	 5eOYEG6Tgzjig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 50/54] Bluetooth: hci_qca: use the power sequencer for wcn6750
Date: Thu,  3 Apr 2025 15:02:05 -0400
Message-Id: <20250403190209.2675485-50-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190209.2675485-1-sashal@kernel.org>
References: <20250403190209.2675485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>

[ Upstream commit 852cfdc7a5a5af54358325c1e0f490cc178d9664 ]

Older boards are having entry "enable-gpios" in dts, we can safely assume
latest boards which are supporting PMU node enrty will support power
sequencer.

Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0ac2168f1dc4f..d2fd08aceb179 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2359,6 +2359,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_WCN6750:
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
@@ -2378,7 +2379,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-	case QCA_WCN6750:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
-- 
2.39.5


