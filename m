Return-Path: <stable+bounces-98624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 613139E4954
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283831882ADD
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20811206F27;
	Wed,  4 Dec 2024 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtSBvPEE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EA82066D4;
	Wed,  4 Dec 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354926; cv=none; b=D5HzXRosFqmHeIrJD9zSFgQHq63KuD5MXtGqTqKMgf60piIxK+9zmf5zF1JUnrvptraEDDrXjlP1hU/URb/jPEsokwOM145OfsFiomzCYpI5J2JgO8EEugYGfbHqKaUJKkYm1KsKM23ob7ig0yEGI9FU3iSZ9zHUNB79X99SDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354926; c=relaxed/simple;
	bh=TGuyA9UR05R0EA//8oCib2q+/iAF7KW5tp/fKrg23IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFQrlYYDAsaeAvs2FD5+NkJENMuAUaRjtH97vlcJllWOeHR0raSCOTr/kgbgxHRl8BbDu+Rn/TjbDuhi2mcwP2rsVtQ+Cx/JYe8dUwy1VCE+Ww6OoV+yfI2RD5bQWdc0S5EZtzJ4ZSYdObY30sx7yXrZW8fW4Umn1tBYkadRDtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtSBvPEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A96EC4CECD;
	Wed,  4 Dec 2024 23:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354926;
	bh=TGuyA9UR05R0EA//8oCib2q+/iAF7KW5tp/fKrg23IQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jtSBvPEEQmYvHVQDnZaqb2/YY0N9ZmPseVNRJHHctbWOrjFwScEHT8Xyv8UC5aOP2
	 87WBaQvVkCn4oIleujX1HB/OOjkv1heYmb7AR0O3iXh4O5AhMu/WqzNhnDDBj3QelI
	 P60eOWcWkOZM3uQVmbUh3yxUl5DkbzKtGCC3tPaiPfSQ1n4jwbF9Vfr6XxzHxZE/VL
	 OixR2Y4g8qVV8FP/RoPnBaNCAudisdwdOipeo+tacnmht2hWuKn+Q+ygSsT3nFHeGF
	 2cprZsSzycsIU8k9v6PhgpxNRVuyZY02gHGGVxka0O3vypPCXPEQINm5RsQeBASI3f
	 5jgjW24Sg/mGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shawnguo@kernel.org,
	linux-usb@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 01/15] usb: chipidea: add CI_HDRC_HAS_SHORT_PKT_LIMIT flag
Date: Wed,  4 Dec 2024 17:16:55 -0500
Message-ID: <20241204221726.2247988-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit ec841b8d73cff37f8960e209017efe1eb2fb21f2 ]

Currently, the imx deivice controller has below limitations:

1. can't generate short packet interrupt if IOC not set in dTD. So if one
   request span more than one dTDs and only the last dTD set IOC, the usb
   request will pending there if no more data comes.
2. the controller can't accurately deliver data to differtent usb requests
   in some cases due to short packet. For example: one usb request span 3
   dTDs, then if the controller received a short packet the next packet
   will go to 2nd dTD of current request rather than the first dTD of next
   request.
3. can't build a bus packet use multiple dTDs. For example: controller
   needs to send one packet of 512 bytes use dTD1 (200 bytes) + dTD2
   (312 bytes), actually the host side will see 200 bytes short packet.

Based on these limits, add CI_HDRC_HAS_SHORT_PKT_LIMIT flag and use it on
imx platforms.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240923081203.2851768-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/ci.h          | 1 +
 drivers/usb/chipidea/ci_hdrc_imx.c | 1 +
 drivers/usb/chipidea/core.c        | 2 ++
 include/linux/usb/chipidea.h       | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index 2a38e1eb65466..e4b003d060c26 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -260,6 +260,7 @@ struct ci_hdrc {
 	bool				b_sess_valid_event;
 	bool				imx28_write_fix;
 	bool				has_portsc_pec_bug;
+	bool				has_short_pkt_limit;
 	bool				supports_runtime_pm;
 	bool				in_lpm;
 	bool				wakeup_int;
diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index bdc04ce919f7a..b76e7c3fa2c6e 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -342,6 +342,7 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	struct ci_hdrc_platform_data pdata = {
 		.name		= dev_name(&pdev->dev),
 		.capoffset	= DEF_CAPOFFSET,
+		.flags		= CI_HDRC_HAS_SHORT_PKT_LIMIT,
 		.notify_event	= ci_hdrc_imx_notify_event,
 	};
 	int ret;
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 835bf2428dc6e..5aa16dbfc289c 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1076,6 +1076,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		CI_HDRC_SUPPORTS_RUNTIME_PM);
 	ci->has_portsc_pec_bug = !!(ci->platdata->flags &
 		CI_HDRC_HAS_PORTSC_PEC_MISSED);
+	ci->has_short_pkt_limit = !!(ci->platdata->flags &
+		CI_HDRC_HAS_SHORT_PKT_LIMIT);
 	platform_set_drvdata(pdev, ci);
 
 	ret = hw_device_init(ci, base);
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 5a7f96684ea22..ebdfef124b2bc 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -65,6 +65,7 @@ struct ci_hdrc_platform_data {
 #define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
 #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
 #define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
+#define	CI_HDRC_HAS_SHORT_PKT_LIMIT	BIT(19)
 	enum usb_dr_mode	dr_mode;
 #define CI_HDRC_CONTROLLER_RESET_EVENT		0
 #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
-- 
2.43.0


