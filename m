Return-Path: <stable+bounces-98633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C709E4952
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C12286AE0
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29652163A3;
	Wed,  4 Dec 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8j3prPo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D841206F37;
	Wed,  4 Dec 2024 23:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354949; cv=none; b=UpkYYRuNKtIG44dUS61MSOgxfC8sl9mLkHi4UtpDhWmdwGWd5mtcG9AH+hYwXRLs+wUtaRJAaAd5EQ6l7lFyiHkpSt2k9E6jp+7Fn/C8jiz61SHQ653YNHFDahR9ZcJMhRi5UNGm/t734pGXtaDIJSjgxsI0xcKw2rNJeLpv/3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354949; c=relaxed/simple;
	bh=0eDEW6i6XtbVsACgcLGCE4SB5PmCXHG3CZLfi4lBKHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ldq/GLA2NOJVGlb8px91Co1P+0Y5csxjbL2EiEdYRofMTP6ZruzFVKYhnIevgv0tYjmEHdVJROWGjaU7tCdZ0lh+4f0rFQ/OI4uO+1k1+5YM7wH+wJL2Nq6ZCPSJ8kSu1HtSACUJI/1I/N/PFe8T5WdZxa1xD7T4tanC5Phw5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8j3prPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B14C4CEE0;
	Wed,  4 Dec 2024 23:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354949;
	bh=0eDEW6i6XtbVsACgcLGCE4SB5PmCXHG3CZLfi4lBKHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8j3prPoKJxpe+mpo6cynqOe8uqb74/6ybWR0ZetM5RTqsEV/ELBJhdYYxhRJQ2ZS
	 jHB3ZauvesUQa6C7BIxwRBaHRv2gDosjSBvmPo1Q5kYhIoEcJq6D2+WL78A9Up2VgG
	 TGb3bmOB+KO1RxfhltOU/pzrNhD5ePfDx3ZFp56WpLjg2vBVcI5tawe/gt3A0ifNCY
	 jPSaxkKMhM1fkxWlEN9UsmHSNONmNfqcHSdQlbwdr/x483MrxhVz7juXuFrCaviSGo
	 o6javOlSdDcZdyjf2RT05Nt6TxBlel2992AvkflMaI6F1JiqbwClqHfK9rWAvKAweX
	 0UWe2uZDIWVBQ==
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
Subject: [PATCH AUTOSEL 6.11 10/15] usb: typec: ucsi: glink: be more precise on orientation-aware ports
Date: Wed,  4 Dec 2024 17:17:04 -0500
Message-ID: <20241204221726.2247988-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221726.2247988-1-sashal@kernel.org>
References: <20241204221726.2247988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 6aace19d595bc..ad0bc7804939b 100644
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


