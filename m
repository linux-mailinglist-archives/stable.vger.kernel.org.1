Return-Path: <stable+bounces-48051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7138FCBC4
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244001C23710
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF101ABCD9;
	Wed,  5 Jun 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4hGva/k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481AD1ABCD4;
	Wed,  5 Jun 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588358; cv=none; b=JGo7oEWGNECT/33ot07+Q/Jm9tStGFX7vP1TeX7Qak7y+es47C3gubngtutYcfGUJOu6oE2ZGRkNIidbT1NjW12M9bmXfsANu4UCpmWMAMX9LPY9lgJiRX1rU1tlPRJZPs0zaix8/2DTd/xi8U6niNw65DpE+K85slWkeXyDA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588358; c=relaxed/simple;
	bh=OsickX/htmlX0C8mCIZ80mo7em2WxoqTyOV3m747KWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WsNWex2bGtZYy+qXAnkX1FsTxK8RKEKjouWvfeoSvePWCDwBbxlQesAVQDrco5z68KDACXblkD8XbrrRfOb3H+UVet3K6EbqhBapc+h0LXdtPdUIG++GoF+3KIC/uZzxqzMn7QieyBA0GMhtuLeMDjV3sR3iKsyVIFmdIrVY0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4hGva/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE16C3277B;
	Wed,  5 Jun 2024 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588358;
	bh=OsickX/htmlX0C8mCIZ80mo7em2WxoqTyOV3m747KWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4hGva/kQnHcakpQ+3yAMVqby3j4qQ3WQ3yVB2X6HWAieLRQ424hDX7pl7lA+/Wyd
	 GUJaXOKvKOjk4I+t2lD79HsCmlH5yAmSrEaHUpNXJAA0fqp+GjMnDmM5LM42lxih9Q
	 KqG1W0mSGFmsVzfyf7MzV/UPAitWeX7TgmKa4t7Ru500iKYG6CeWhh8EEeg9kNC1b1
	 +1ggWzvQQ8Jbhf1imUaUXbP1HygE4FLa1ivLLWZJSgVQ1dL4FwM3KBXcVuY0JZRTmP
	 BRNEPyLzSOQxVfk0tfd2uLenc3g7G4tLn6T/hYgUEn88V7IQ+13eGgTfXsKiJirqjm
	 NPK3B6SEzeR1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	robh@kernel.org,
	johan+linaro@kernel.org,
	quic_kriskura@quicinc.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/20] usb: typec: ucsi_glink: drop special handling for CCI_BUSY
Date: Wed,  5 Jun 2024 07:51:49 -0400
Message-ID: <20240605115225.2963242-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 894622b6556a6..ee239a6b8f61a 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -175,7 +175,8 @@ static int pmic_glink_ucsi_sync_write(struct ucsi *__ucsi, unsigned int offset,
 	left = wait_for_completion_timeout(&ucsi->sync_ack, 5 * HZ);
 	if (!left) {
 		dev_err(ucsi->dev, "timeout waiting for UCSI sync write response\n");
-		ret = -ETIMEDOUT;
+		/* return 0 here and let core UCSI code handle the CCI_BUSY */
+		ret = 0;
 	} else if (ucsi->sync_val) {
 		dev_err(ucsi->dev, "sync write returned: %d\n", ucsi->sync_val);
 	}
@@ -242,10 +243,7 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
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


