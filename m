Return-Path: <stable+bounces-236564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBFdO+AX3WnNZwkAu9opvQ
	(envelope-from <stable+bounces-236564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:20:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C13EEA92
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F93B3014686
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09657306B0A;
	Mon, 13 Apr 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBLlc1Pl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9D2F8BC3;
	Mon, 13 Apr 2026 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097231; cv=none; b=I/siK9O+/TArAHsmOQJhc3SmgroYjLaTxlF7UrCAyOSCuFxwS1OmqS3PCH+2AvcUIkdXVG6zAgp9RijX3hlEoQ6ACiAHUiOk0rS2jiIUrBJmMUQlqIIPbrZQ/iaL4RXZQY2gv8Ov5qjlXpL64Ir4ItlvwcuxTnwq3vVysh/PuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097231; c=relaxed/simple;
	bh=2spqMbnKeMqFLUm64bkoO8PFa6rtFe0njrt3+oBvUzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dUdeUOodEg04JquUTP8yfuql9hAk9wR3Fl5xcvpXFQOwL+osZFDl2vnm/6fIKXBCd7tDp05zrzASwz3jqIxeOs/wMirtmgBqBjKVdC/OOngq//Ct1aTIfD3E1mq8rs5QKKIa/hrm4lYDoPJT7SWe+UyEJyJGATO88B/00ZK3ZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBLlc1Pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A38C2BCAF;
	Mon, 13 Apr 2026 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097231;
	bh=2spqMbnKeMqFLUm64bkoO8PFa6rtFe0njrt3+oBvUzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBLlc1Pl6KcO8k2bNYljKU1aw0S2MVDoTQFGbEcJi5Syyn5smLxTjOlkBPpV0oJJe
	 /g9oWEmV/In8F42muQgN0t6UDR0759Jyuhy/N9mp0Gci7GJAYCm5JXzus1qFZh+2ie
	 2F7PErqK8JeoYNJgP8Cp2AEtEh1IgApfuopKB5w4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 024/570] mfd: qcom-pm8xxx: Convert to platform remove callback returning void
Date: Mon, 13 Apr 2026 17:52:35 +0200
Message-ID: <20260413155831.327061914@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236564-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,pengutronix.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B17C13EEA92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 2f2734ba5273e..8831448371290 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -587,19 +587,17 @@ static int pm8xxx_remove_child(struct device *dev, void *unused)
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




