Return-Path: <stable+bounces-48028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80688FCB66
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657EE28A68A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E91922CC;
	Wed,  5 Jun 2024 11:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/sxMjPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949819EEDE;
	Wed,  5 Jun 2024 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588278; cv=none; b=ZToUYGvMR73IPaz7NsWOG88flIM/7J2awgxiIRwdra0s8CzSCNzpp1DLX7hK+KBoOSm47esJLnf6XSxKxlOsGHUJbjbuZRP+QE+0Ig2AatDCdxyCSDL2koG7S5P2qoSMsPMRlu+alKan3iAuXDD7J+Yrs4AbQqoebZVkhJwHkY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588278; c=relaxed/simple;
	bh=t0vokvuIvTAMl4gK58qFsQK8Hj3e1FRkIYK+llSr3UA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzmKm8MO7hNnQzIHZVzkgfDma6ypz+urrZulQKZltipzOX2ZMxr8rLIOOKV8/QeJLnUMef3l5qt+KbwDcRC2XYWEiXBY2kK7YRqzyPGQ0MXgVJjdTBg4p9ysu6J+Q/N0JdT6Vzk9ANc6LqcURSZI3b3MpEEIOta0gRismEyIBH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/sxMjPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A56BC3277B;
	Wed,  5 Jun 2024 11:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588277;
	bh=t0vokvuIvTAMl4gK58qFsQK8Hj3e1FRkIYK+llSr3UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/sxMjPYncHTgm3SsljT3Hb+g9r79N9f2jgJjYaNLym+02950tcFPujOvifew2unR
	 FVrzTc3WDa5Ofx3+ww7kof1VXnZRycdAS98aaHKEeJwQujm4zMpIJk5k2HHJjSr/Gu
	 EawNYUuFMXp5MjzjaN3Qz0dDTvGDWAlwe2vM+66iAfiLa8Z0KSUMA7nXqFXj956Okb
	 uGOTbsGJq7iLhkdmODY/8wFb8JU4/39D3pyNoi1QBdcvPr+/AIWKunyLmDgtK+qGZp
	 IoZwNB7rqWnlGuY64t+6oX2nJ0ueuTHAdnxAFe2M2gfXBoafISlcDQf3AnSQrl0g9S
	 bPl+0ACRtjF8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	neil.armstrong@linaro.org,
	johan+linaro@kernel.org,
	robh@kernel.org,
	luca.weiss@fairphone.com,
	quic_kriskura@quicinc.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 07/24] usb: typec: ucsi_glink: drop special handling for CCI_BUSY
Date: Wed,  5 Jun 2024 07:50:17 -0400
Message-ID: <20240605115101.2962372-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115101.2962372-1-sashal@kernel.org>
References: <20240605115101.2962372-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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


