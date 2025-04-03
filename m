Return-Path: <stable+bounces-127815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50578A7ABE7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 21:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A02C1888CBA
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 19:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9602686B8;
	Thu,  3 Apr 2025 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtrqLU3j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F942686AC;
	Thu,  3 Apr 2025 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707149; cv=none; b=qywDmHrk7mzr/i3qcQbt3uaVNqd2uiltGqE8WkGp51A5EKaDaYhbljkBzto5aSUKYK43vAcQ4oAOkOa3IlXK/aJAKEL4kt7AEy1vQGBHtmlZFD64OiWFUCVyI8lyqaVNpe/3ub3n8zCXv+5PlL0vQ6SxzxdpSHwZIE3YtdT31tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707149; c=relaxed/simple;
	bh=YnETe39muBuqkBKv451bTFeJkeJSfE4QPwZTQ4mc+Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pO50J4xFOSesqaweKIq8YV/Jhf1nc90Uqrnli7idjx9jB46VJq3WgDIu9qE0iHW8uTs1sH43Jiu6R+WIFe2YQhhpbHMBduylfpf7r3cKkJ9OqOSiB6eIsIzPKTgulngJD2ny6YSkFXVlK6Pm6QlYiurTEQyed/kGkH10aFbsXWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtrqLU3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32B2C4CEE9;
	Thu,  3 Apr 2025 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707148;
	bh=YnETe39muBuqkBKv451bTFeJkeJSfE4QPwZTQ4mc+Yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jtrqLU3juUk10kluWbHG0ihMbLNNmdB4nbOW/7lsSouy9RCMNKlB6MpQg+joiDly/
	 nttjaFpSuag7lxwRyf6Zmq67dA9AutvjIldJhNZNUmER2Pk4/d2dyY0Wu6IKI6jpQD
	 AQ47qtNBkMmEtUaqLFANqcqPsgcMlFJ3XmELvyq4kYA9fu4iCNHfi+Pbh2Oq4VW4Ht
	 u4dpeI/eT+fPqnevefnZ42oQjwZ/qP+TbeqeVoJ2hvdxSpzbzeZ4YCSiS/RDdmYa9c
	 MWZe+pqnP1i667LnuVyyjz3tkVupXnFDf5+9bU1no5VrCoVUv+8UmmesZRMSqE5vNw
	 sz4u9iMHhUUsA==
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
Subject: [PATCH AUTOSEL 6.13 46/49] Bluetooth: hci_qca: use the power sequencer for wcn6750
Date: Thu,  3 Apr 2025 15:04:05 -0400
Message-Id: <20250403190408.2676344-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190408.2676344-1-sashal@kernel.org>
References: <20250403190408.2676344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 37129e6cb0eb1..fbf8840fa534e 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2346,6 +2346,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+	case QCA_WCN6750:
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the
@@ -2365,7 +2366,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-	case QCA_WCN6750:
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);
-- 
2.39.5


