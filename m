Return-Path: <stable+bounces-48001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A08FCAF9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B22288512
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA791199225;
	Wed,  5 Jun 2024 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdpxAXHK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED4195FFD;
	Wed,  5 Jun 2024 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588184; cv=none; b=CozKdkPIkAq0A32TZYwv0i3xH0QkQc+qjzlGBMbElnGiDQkthig6Tlf2yqsUsX6PZFOr48JEEWRk7BIQdCIctWW8khWdgd4MbH+qqh9WhLOyqB0SfhGFU1FlfjtzNBdKDFMZqQQ6iTfGQzlXOHSwxMvrqE6v3g0n4uw2PCbUMx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588184; c=relaxed/simple;
	bh=t0vokvuIvTAMl4gK58qFsQK8Hj3e1FRkIYK+llSr3UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dycT7iG7BZk5xYO9LOZFYWq2xEcLH71e4TPB3wcnytflyhZdUQf5pyjN5A1LdYi/QEIPhiG6gEcYPuZg778VohwZTVDPRyXxKaSivEVHRkAffi9SPrLIo+wkUonvgY/kO/wwOfuCswyBDmjNqoR7fT4LFrkomi3qgACMGPpZV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdpxAXHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ACCC4AF08;
	Wed,  5 Jun 2024 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588184;
	bh=t0vokvuIvTAMl4gK58qFsQK8Hj3e1FRkIYK+llSr3UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdpxAXHK61wCtuzIQOD6PQ4Yibt94dKnas7vuqUSXDlZ7Nc6Bf3bVdOx3lwRwLFZx
	 WYn2FDRGU771mpoGU4uOspbB2xhKVbvh4cVBSjTeMfqB2SYm5eowMeMxX9ZftFL2ht
	 F/36VYerYBcFtCmGd93jPN7mE5B46QY5pew9mCigyjom2YSsN9Tj1OrEWTcNNEZ/IZ
	 9hwVETfmLnwwnIEHBz5ZS1jRH8ENW9ylgGXUM2502Vh+RukbcyHFTuMSKE9yfFG9V0
	 Ac84Y3SZ5qPnO6tX8rnKhqHOuOh/CfaDeOh0VjxDJDXRkzhQGO1G35JrkZp840YTpR
	 6dYGDpaMCNCnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	quic_kriskura@quicinc.com,
	luca.weiss@fairphone.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 08/28] usb: typec: ucsi_glink: drop special handling for CCI_BUSY
Date: Wed,  5 Jun 2024 07:48:37 -0400
Message-ID: <20240605114927.2961639-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 1a395af9d53c6240bf7799abc43b4dc292ca9dd0 ]

Newer Qualcomm platforms (sm8450+) successfully handle busy state and
send the Command Completion after sending the Busy state. Older devices
have firmware bug and can not continue after sending the CCI_BUSY state,
but the command that leads to CCI_BUSY is already forbidden by the
NO_PARTNER_PDOS quirk.

Follow other UCSI glue drivers and drop special handling for CCI_BUSY
event. Let the UCSI core properly handle this state.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240408-qcom-ucsi-fixes-bis-v1-3-716c145ca4b1@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 0e6f837f6c31b..1d0e2d87e9b31 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -176,7 +176,8 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
 	left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
 	if (!left) {
 		dev_err(ucsi->dev, "timeout waiting for UCSI sync write response\n");
-		ret = -ETIMEDOUT;
+		/* return 0 here and let core UCSI code handle the CCI_BUSY */
+		ret = 0;
 	} else if (ucsi->sync_val) {
 		dev_err(ucsi->dev, "sync write returned: %d\n", ucsi->sync_val);
 	}
@@ -243,10 +244,7 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 		ucsi_connector_change(ucsi->ucsi, con_num);
 	}
 
-	if (ucsi->sync_pending && cci & UCSI_CCI_BUSY) {
-		ucsi->sync_val = -EBUSY;
-		complete(&ucsi->sync_ack);
-	} else if (ucsi->sync_pending &&
+	if (ucsi->sync_pending &&
 		   (cci & (UCSI_CCI_ACK_COMPLETE | UCSI_CCI_COMMAND_COMPLETE))) {
 		complete(&ucsi->sync_ack);
 	}
-- 
2.43.0


