Return-Path: <stable+bounces-41996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25F8B70D3
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4041C21B20
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1712C46B;
	Tue, 30 Apr 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YB6w+5M7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCB812C48F;
	Tue, 30 Apr 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474217; cv=none; b=c9IuLRl7Som4ZireL8YLqvDAjrXbhY6b8h7vEePzxNUI+EK7+65xZYyBJi1nuIXeyxrEccOk7t6bo2PuydXK3Z88IsFDlpxssovQOiv2p7L4Dme8kgpHyrvnmouRxKmMdfix0IYwTmacJTv8nbpPA0x4tNuD8SoWr30DFbFkSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474217; c=relaxed/simple;
	bh=uVE7egw5XoMWpUm7YqbBkRX0ESd5kJVR984LXkCtGjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmEAaXcAWsHRPaAESc+zjzKFJaDdZwopMuC4ZZ9owuDjubHP5QkLBTEwxNFnZGcL2h08stJSbV1ME89cJfeSnIU9P9bwyOvV4eCFoljkX79VU42zqIQ6412O5EAa9TzKG2lzZ6glbonEQdHq1BQ4PN5xUWscQHyltbsuAV9LFXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YB6w+5M7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF31C4AF19;
	Tue, 30 Apr 2024 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474217;
	bh=uVE7egw5XoMWpUm7YqbBkRX0ESd5kJVR984LXkCtGjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YB6w+5M7S2noMpqd/uJjWyyvmjPMx4Tmox1kbImlyHsEroI4vmB1LyUSQ56sN+Qek
	 hQjPqnGxCs4Oks02+M0abvKaBdZwTcZHRFcjDVgnXZ4DkrXSPizJFT7w0qgdvPjVrE
	 xl6AUqAIBalrczMw5WNbxXs21uRN138Xnm2QBdYo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wren Turkal <wt@penguintechs.org>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 091/228] Bluetooth: qca: set power_ctrl_enabled on NULL returned by gpiod_get_optional()
Date: Tue, 30 Apr 2024 12:37:49 +0200
Message-ID: <20240430103106.429305038@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 3d05fc82237aa97162d0d7dc300b55bb34e91d02 ]

Any return value from gpiod_get_optional() other than a pointer to a
GPIO descriptor or a NULL-pointer is an error and the driver should
abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
power_ctrl_enabled on NULL-pointer returned by
devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
While at it: also bail-out on error returned when trying to get the
"swctrl" GPIO.

Reported-by: Wren Turkal <wt@penguintechs.org>
Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Wren Turkal <wt@penguintechs.org>
Reported-by: Wren Turkal <wt@penguintechs.org>
Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index ecbc52eaf1010..2f7ae38d85eb0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2329,16 +2329,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855)) {
 			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
-			power_ctrl_enabled = false;
+			return PTR_ERR(qcadev->bt_en);
 		}
 
+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
 		if (IS_ERR(qcadev->sw_ctrl) &&
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
-		     data->soc_type == QCA_WCN7850))
-			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+		     data->soc_type == QCA_WCN7850)) {
+			dev_err(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
+			return PTR_ERR(qcadev->sw_ctrl);
+		}
 
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
@@ -2357,10 +2362,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR(qcadev->bt_en)) {
-			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
-			power_ctrl_enabled = false;
+			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
+			return PTR_ERR(qcadev->bt_en);
 		}
 
+		if (!qcadev->bt_en)
+			power_ctrl_enabled = false;
+
 		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
 			dev_warn(&serdev->dev, "failed to acquire clk\n");
-- 
2.43.0




