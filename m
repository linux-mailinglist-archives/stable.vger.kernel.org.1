Return-Path: <stable+bounces-228931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPXTOOZWwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-228931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:06:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6992E2F5C68
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C1C4312C226
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541172727E2;
	Mon, 23 Mar 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a/erM12K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1541E235045;
	Mon, 23 Mar 2026 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277523; cv=none; b=qvQmXspoa13KsPzc9ywhLvgrILylstAJfcX9v61ppDrBsL62KKSegbRg/GBTgpXwoRj/EWlJIPCaJndiIVAa+ccB2EMC+pj/haxTQgydCZjIgnSwIP1PDooJHoy0UgNxYXThdIT7d5RKGIetfMFBmckMfOA2Ys2Qzt7PmTv5Y3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277523; c=relaxed/simple;
	bh=Vb+Ht5E1kb/6aMGr6DP9TZwHY+1E+szjSw4Upw69wk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elDGJ++7HWE0jJMX9ZD8LcI3aV8KPtqdtgSh038Ks5hRjNo31tsbLPGxPwYsa2461zElH2iJQPh30L6csG5iyHa4yEOj1ebGFWUhcBXcG0RjbtHMkKX3W0I7Hdf04OMjiI9AgJxkBEEsFtjxWUwVN4waDGcjXxx+Wz+LjG3dJJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a/erM12K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5E9C4CEF7;
	Mon, 23 Mar 2026 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277523;
	bh=Vb+Ht5E1kb/6aMGr6DP9TZwHY+1E+szjSw4Upw69wk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/erM12KYDFBK9odkyflcy0zFrOSKUHS1laBcI5sajTw5XwOeJZ3P2O2LSyADLbVp
	 1UamvjAKRNJFlbO3auyzp5V8ywE2YIACSVzSZHhH5pTs9guzFDQxSDFm4H8x2RGdPP
	 hwjM1EeadI8vTCkqClBlQF82ohqaRaj4WLPVYRCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 017/481] memory: mtk-smi: Convert to platform remove callback returning void
Date: Mon, 23 Mar 2026 14:39:59 +0100
Message-ID: <20260323134525.667346623@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228931-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 6992E2F5C68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 08c1aeaa45ce0fd18912e92c6705586c8aa5240f ]

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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/5c35a33cfdc359842e034ddd2e9358f10e91fa1f.1702822744.git.u.kleine-koenig@pengutronix.de
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Stable-dep-of: 6cfa038bddd7 ("memory: mtk-smi: fix device leaks on common probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/mtk-smi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 5a9754442bc75..c9c444d4a64ab 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -566,14 +566,13 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mtk_smi_larb_remove(struct platform_device *pdev)
+static void mtk_smi_larb_remove(struct platform_device *pdev)
 {
 	struct mtk_smi_larb *larb = platform_get_drvdata(pdev);
 
 	device_link_remove(&pdev->dev, larb->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
 	component_del(&pdev->dev, &mtk_smi_larb_component_ops);
-	return 0;
 }
 
 static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
@@ -616,7 +615,7 @@ static const struct dev_pm_ops smi_larb_pm_ops = {
 
 static struct platform_driver mtk_smi_larb_driver = {
 	.probe	= mtk_smi_larb_probe,
-	.remove	= mtk_smi_larb_remove,
+	.remove_new = mtk_smi_larb_remove,
 	.driver	= {
 		.name = "mtk-smi-larb",
 		.of_match_table = mtk_smi_larb_of_ids,
@@ -789,14 +788,13 @@ static int mtk_smi_common_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_smi_common_remove(struct platform_device *pdev)
+static void mtk_smi_common_remove(struct platform_device *pdev)
 {
 	struct mtk_smi *common = dev_get_drvdata(&pdev->dev);
 
 	if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
 		device_link_remove(&pdev->dev, common->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
 
 static int __maybe_unused mtk_smi_common_resume(struct device *dev)
@@ -836,7 +834,7 @@ static const struct dev_pm_ops smi_common_pm_ops = {
 
 static struct platform_driver mtk_smi_common_driver = {
 	.probe	= mtk_smi_common_probe,
-	.remove = mtk_smi_common_remove,
+	.remove_new = mtk_smi_common_remove,
 	.driver	= {
 		.name = "mtk-smi-common",
 		.of_match_table = mtk_smi_common_of_ids,
-- 
2.51.0




