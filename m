Return-Path: <stable+bounces-98618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 802CB9E493E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CE61883CBB
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCF2211716;
	Wed,  4 Dec 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI1OWgGs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74342206F19;
	Wed,  4 Dec 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354890; cv=none; b=tQVRfO1Y+H0lykS0dOHX3GLSc0kiQWH57SPj8DwCasmcObPRGU1ccTNiNMfdU++gf4fpFXvml4eH3lpbwvb4/2w8bq9PhQWCecWJWfxMbYiAwKC4SP33idwK0A6HEZpYE1ROowVQft6iEl3BOX9FqAYErN9tl4tmAklRXE0qQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354890; c=relaxed/simple;
	bh=qHhAUuyhQXNQrTTjUNmUBsCanrlnuEay1E2XfKz3Vpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pN3LTWREyH8HFUqD6PRb0/9q8ZdgSyKJl4ytmKAO++TLDRwlnA//g0mls/vOJJ0EWRzSpPrdar5nWsZdadF4dXi+L/kxLpfztz6RHtNQ/uMJH/lZjPyYF6E2l9UYBj/9XrHvq1hEwScVB9z6pFmFnGDbPjGslnBR4tAApLl6z30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI1OWgGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E63C4CED2;
	Wed,  4 Dec 2024 23:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354889;
	bh=qHhAUuyhQXNQrTTjUNmUBsCanrlnuEay1E2XfKz3Vpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aI1OWgGstTG8P9AVoGPy4fb5DUov6N3bJFGiugd1155SdJkFRq8z6N2xSprk3qMXY
	 zT3iJpxfOAHd8Qr3y+/PJwM11sDCTnxrYt5RYkpOrB1oBMZ1n6GPmt/F75/Htaog54
	 qXnoMU7UmeBjxQ7Q6drYmsW/YZBDXpLfQiB8JyI7N7vyDQaWP/WRNDJsAtk6qQ+urN
	 0zpCvQxeFHnw2KfMUKm63/pLl7mG/DJuOMRmDGBHSupfXCicgoz3ngbuF/H7eV0UXS
	 S9KUYtoAPQnr7UfCqTqs0UH/SLcK0Wbzrwgolh+OQYIqZtc153MimRbATZihu953hk
	 QJTYes5fnq2qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	heikki.krogerus@linux.intel.com,
	quic_bjorande@quicinc.com,
	javier.carrasco.cruz@gmail.com,
	quic_kriskura@quicinc.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 10/15] usb: typec: ucsi: glink: be more precise on orientation-aware ports
Date: Wed,  4 Dec 2024 17:16:04 -0500
Message-ID: <20241204221627.2247598-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221627.2247598-1-sashal@kernel.org>
References: <20241204221627.2247598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit de9df030ccb5d3e31ee0c715d74cd77c619748f8 ]

Instead of checking if any of the USB-C ports have orientation GPIO and
thus is orientation-aware, check for the GPIO for the port being
registered. There are no boards that are affected by this change at this
moment, so the patch is not marked as a fix, but it might affect other
boards in future.

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20241109-ucsi-glue-fixes-v2-2-8b21ff4f9fbe@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 03c0fa8edc8db..50a23578d0f26 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -172,12 +172,12 @@ static int pmic_glink_ucsi_async_control(struct ucsi *__ucsi, u64 command)
 static void pmic_glink_ucsi_update_connector(struct ucsi_connector *con)
 {
 	struct pmic_glink_ucsi *ucsi = ucsi_get_drvdata(con->ucsi);
-	int i;
 
-	for (i = 0; i < PMIC_GLINK_MAX_PORTS; i++) {
-		if (ucsi->port_orientation[i])
-			con->typec_cap.orientation_aware = true;
-	}
+	if (con->num > PMIC_GLINK_MAX_PORTS ||
+	    !ucsi->port_orientation[con->num - 1])
+		return;
+
+	con->typec_cap.orientation_aware = true;
 }
 
 static void pmic_glink_ucsi_connector_status(struct ucsi_connector *con)
-- 
2.43.0


