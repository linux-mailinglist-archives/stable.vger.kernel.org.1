Return-Path: <stable+bounces-228983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB8aDgNrwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-228983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:32:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A57182F844A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A17D63319C05
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B5B2D9ECB;
	Mon, 23 Mar 2026 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yn/mTf2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156201D63F3;
	Mon, 23 Mar 2026 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277688; cv=none; b=HaRgPsx+h1zbaVL7kffYUG8/NqSywABsRd3xTlehLIojYi4HNmJTn+WhNAD68j9rT7nFd4jE2R1bYxzq/UqEQWpOBYE3G7c4pa5P928O9iMGVPyzAziTurM7KD/cLDNO4RpGOICMmj+JFKQYn1Calxcnl4zY3UsxK5JDQ0Qkw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277688; c=relaxed/simple;
	bh=52nX2W1eqSdpNKJ5wviX8asCxWrOuTWXxteZtxpab6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nczRXXXvg3vcriw3yr45w69w5XzaYckRvrtbnzgsPx7yo+WyyhK8l3qehOMUGugnsJdt7qlCdL+wyr8zhuvECjiPVd1MeWpqLzA/CkPkk5D/wMnRWiX+gI1r40jyOOfgxN02ijhfdvOR/eu3AawvrlopzPKapbdnrLpbCEA+bNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yn/mTf2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C23BC2BC9E;
	Mon, 23 Mar 2026 14:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277688;
	bh=52nX2W1eqSdpNKJ5wviX8asCxWrOuTWXxteZtxpab6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yn/mTf2/DPyfNdXcvsWpd7J9tUZsH8byOOV2x8sGCvBu44mToowyEs+Cniqd19XDX
	 PBWeDe2XAdF+y3z6HCQsW0QyuLu6LMtuTI8tskhXbGdMi9A/VXa6Uc+GDRxbpm3iE8
	 5ObKqBWXoqU8hBkBkIThE40behVbCo1vqhAjM4us=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 071/567] mfd: qcom-pm8xxx: Convert to platform remove callback returning void
Date: Mon, 23 Mar 2026 14:39:51 +0100
Message-ID: <20260323134535.584157152@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228983-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,pengutronix.de:email]
X-Rspamd-Queue-Id: A57182F844A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 19ea1d3953017518d85db35b69b5aea9bc64d630 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231123165627.492259-14-u.kleine-koenig@pengutronix.de
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 27a8acea47a9 ("mfd: qcom-pm8xxx: Fix OF populate on driver rebind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/qcom-pm8xxx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 07c531bd1236e..8b6285f687da5 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -585,19 +585,17 @@ static int pm8xxx_remove_child(struct device *dev, void *unused)
 	return 0;
 }
 
-static int pm8xxx_remove(struct platform_device *pdev)
+static void pm8xxx_remove(struct platform_device *pdev)
 {
 	struct pm_irq_chip *chip = platform_get_drvdata(pdev);
 
 	device_for_each_child(&pdev->dev, NULL, pm8xxx_remove_child);
 	irq_domain_remove(chip->irqdomain);
-
-	return 0;
 }
 
 static struct platform_driver pm8xxx_driver = {
 	.probe		= pm8xxx_probe,
-	.remove		= pm8xxx_remove,
+	.remove_new	= pm8xxx_remove,
 	.driver		= {
 		.name	= "pm8xxx-core",
 		.of_match_table = pm8xxx_id_table,
-- 
2.51.0




