Return-Path: <stable+bounces-127862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF72CA7ACA2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E262616AB4C
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3432E27C84F;
	Thu,  3 Apr 2025 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckjsT2yO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD8E2580CB;
	Thu,  3 Apr 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707260; cv=none; b=J+2/R9x/u4NgoqZvBFMfkKpWQ7hA05LGWAvnQqiUrxCZKlITslKV88AuOcjc6ezChldRQah6zPW0jQjmDxuwHJXtca4RTKxACH+HoxuJITEsyP7t5G+U8ncwDR1joDtNJS4qVAI/UBnQQCxIEH+CWMz9wuWQmnZ2BCvJssshQMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707260; c=relaxed/simple;
	bh=zF9eEORkdJMeHZQkUZfoMF4KcJbfROFA6E4/AVtZC78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgmAXWxkqASxbiGV5MrWtvRRm+5ASmHm2jtLBAFSTg6NnYsz6/Mcdx19OcYvfhYd8mXhrR/7zt1H/OtNJ0nYII7M1yK5V7GxWJfVxOdOhqqt9l8UGVe8McHwK+Xebv36AXchLip/tUJMxIv9VhyoWimt2EbMaZonpJAmESJ5ps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckjsT2yO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72248C4CEE8;
	Thu,  3 Apr 2025 19:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707259;
	bh=zF9eEORkdJMeHZQkUZfoMF4KcJbfROFA6E4/AVtZC78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckjsT2yOmiJlfkJZijv3W8oBl3z58ncgVM0s2e56E0zzymNd7d5sY63dTSwHz7ve8
	 5Q9dnMJAYbc36M5d+D9SYrj3ZK41LNQPlkJBCeFGRp1Ws16P5LyqhHQfJ1tcnAZTVa
	 pYQIA/xZL6K5SWIcvSwDrvrGymUoVpnMKtaDxoeUig+MjQZsevLKXQVQVeVmlOm+9+
	 G3LM6mOoGFr0O07eCG535nc4dblDMZzdMfTB93+tB21j2nA2E6Fp8moR9RpfbyxAh2
	 RbCeMjBM9b1rq/AjqAd5S1t0j39hccOT0JZOUm1H3FlIRtsKIXpflUlrCKugQALoZA
	 LgummlOYMVCjQ==
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
Subject: [PATCH AUTOSEL 6.12 44/47] Bluetooth: hci_qca: use the power sequencer for wcn6750
Date: Thu,  3 Apr 2025 15:05:52 -0400
Message-Id: <20250403190555.2677001-44-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
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
index 37fddf6055beb..1837622ea625a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2353,6 +2353,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_WCN6750:
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
@@ -2372,7 +2373,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-	case QCA_WCN6750:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
-- 
2.39.5


