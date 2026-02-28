Return-Path: <stable+bounces-220475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLn1OStLo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:08:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD031C7EEF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EA3130F00EA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E863C1534;
	Sat, 28 Feb 2026 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/CJO61a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE523C152C;
	Sat, 28 Feb 2026 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300362; cv=none; b=u/VVV8ZnYx01kFwG6GPpi+AbpZVymt6UGnY1Fr2I2EKiCBbc2xCfqwmLu+vloU0YGzVRTLerZ5Fjtqwv/kK91MQhCKvppLt7p3IifIbHuSpsrEfk8MVhjl0vubQmBeo26uFJ+z8lu6hK7cCZl6UURYIguvSyKpH16e56g7MAcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300362; c=relaxed/simple;
	bh=2HlZxEimLJFMScH+05ZMokGzWzkMwOJYBPTUJDQQWwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EffWWE6XL92m6whZT/fQ2k+jVsHb2Nr8XHn9doTEC8qoNYRRLEm42GIYHp44taDx6CQDLMl6h3sbMq63jZazTdyjBbpMQRhl/YJID8CwL3Vof2HQ2efLKsoeyLWFk5dtRRVveYNc+AuvbD3sKCbZB6d149Wr8HTdwjExSDrKDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/CJO61a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5A0C19425;
	Sat, 28 Feb 2026 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300361;
	bh=2HlZxEimLJFMScH+05ZMokGzWzkMwOJYBPTUJDQQWwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U/CJO61anMXotQ9DlMrEl/0BDlhJsQ+YgGz8nEzsbyasgigpIHc9HquepQ/8Ldtzb
	 WbNk4zk9iyL12yBIv7aI60dSJExN1CdOScKZBxJvzx0kzP6+F//f/W4tIyaySrsWj/
	 7Gw1iMRNp2m7TPRc5RZvz77DDN+lyOv6RDSB/1VLVzGWgzFe2u49NJ08R+BFNOCgtD
	 OKrM7ysPmFc9Sk6Ty8jVBIRfP/7fN/vf7Ergw9PKOq/7EGMxpCjwEcUfXiPpH+b6q/
	 sjMdkLmBGxfCACPGVbQ7yllumaBkvV9BwFbv3nsp9II9DlYxlb3ik8qP0QMIYiU7bf
	 4Mah+Do0cBzQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 396/844] phy: fsl-imx8mq-usb: disable bind/unbind platform driver feature
Date: Sat, 28 Feb 2026 12:25:09 -0500
Message-ID: <20260228173244.1509663-397-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220475-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 2AD031C7EEF
X-Rspamd-Action: no action

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit 27ee0869d77b2cb404770ac49bdceae3aedf658b ]

Disabling PHYs in runtime usually causes the client with external abort
exception or similar issue due to lack of API to notify clients about PHY
removal. This patch removes the possibility to unbind i.MX PHY drivers in
runtime.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260120111712.3159782-1-xu.yang_2@nxp.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index 91b3e62743d3a..b30d01f345d20 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -730,6 +730,7 @@ static struct platform_driver imx8mq_usb_phy_driver = {
 	.driver = {
 		.name	= "imx8mq-usb-phy",
 		.of_match_table	= imx8mq_usb_phy_of_match,
+		.suppress_bind_attrs = true,
 	}
 };
 module_platform_driver(imx8mq_usb_phy_driver);
-- 
2.51.0


