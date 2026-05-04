Return-Path: <stable+bounces-243734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOPLHHyt+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:30:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D49114BF925
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4F2530309D4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEBA3E0232;
	Mon,  4 May 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FUyQ08Zq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5753DE43C;
	Mon,  4 May 2026 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904641; cv=none; b=Xi8Cp21uxP+5Tv2l9q3PaW4XJy1odW+88QckXk1/2lSNH79qSmxphDuG6PfpSk72hZmsjncqjcOTsCPk0ktDXzAF3hZ+3f5jO1MqDYYO3BuQBRzqj75s4IXd9L8jbQb3uLdMEhWD6a0NdXNH1uwf23ao56OrS8YDmzFVP9GjvFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904641; c=relaxed/simple;
	bh=uB0HQF/Lu+22X/VV4jrzU5LsyOf5ldSgWw3aoBNN5J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=az0L7WYLRBN/Ig3iWbZceE1f7g++t0KdDzqk+XeHG5TfRyTrSmZHO62w7QyeONwRIqTItXHoplKpLt+/tBPH06nTE2xTr319poV4dwC7sBR0m20dab2cAafysRM6kOgeI5VXGX7X9irx3wCCOwFAPnEC7/wJQLxw9jAoo8pN5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FUyQ08Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929DBC2BCF4;
	Mon,  4 May 2026 14:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904640;
	bh=uB0HQF/Lu+22X/VV4jrzU5LsyOf5ldSgWw3aoBNN5J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUyQ08ZqmS9vBX/IobiDSoUXwMzc8BQFcp1vJTAMAVK0sUj1TIiSYlwPiW6MYjhQp
	 tx94nl+PXSnilx6PZUFI5rnTqR3tlSVXKZ2Vz6AVlXpXjDOyiR4foFKW59UYoXCTFa
	 5XXx3/lDXsuWzDc4UbQ9fK8dAuVg8ItWvttLyLk4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.12 100/215] power: supply: axp288_charger: Do not cancel work before initializing it
Date: Mon,  4 May 2026 15:51:59 +0200
Message-ID: <20260504135133.807353878@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D49114BF925
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243734-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,qualcomm.com:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

commit 658342fd75b582cbb06544d513171c3d645faead upstream.

Driver registered devm handler to cancel_work_sync() before even the
work was initialized, thus leading to possible warning from
kernel/workqueue.c on (!work->func) check, if the error path was hit
before the initialization happened.

Use devm_work_autocancel() on each work item independently, which
handles the initialization and handler to cancel work.

Fixes: 165c2357744e ("power: supply: axp288_charger: Properly stop work on probe-error / remove")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Link: https://patch.msgid.link/20260220174938.672883-5-krzysztof.kozlowski@oss.qualcomm.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/axp288_charger.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
+#include <linux/devm-helpers.h>
 #include <linux/device.h>
 #include <linux/regmap.h>
 #include <linux/workqueue.h>
@@ -821,14 +822,6 @@ static int charger_init_hw_regs(struct a
 	return 0;
 }
 
-static void axp288_charger_cancel_work(void *data)
-{
-	struct axp288_chrg_info *info = data;
-
-	cancel_work_sync(&info->otg.work);
-	cancel_work_sync(&info->cable.work);
-}
-
 static int axp288_charger_probe(struct platform_device *pdev)
 {
 	int ret, i, pirq;
@@ -911,12 +904,12 @@ static int axp288_charger_probe(struct p
 	}
 
 	/* Cancel our work on cleanup, register this before the notifiers */
-	ret = devm_add_action(dev, axp288_charger_cancel_work, info);
+	ret = devm_work_autocancel(dev, &info->cable.work,
+				   axp288_charger_extcon_evt_worker);
 	if (ret)
 		return ret;
 
 	/* Register for extcon notification */
-	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
 	info->cable.nb.notifier_call = axp288_charger_handle_cable_evt;
 	ret = devm_extcon_register_notifier_all(dev, info->cable.edev,
 						&info->cable.nb);
@@ -926,8 +919,12 @@ static int axp288_charger_probe(struct p
 	}
 	schedule_work(&info->cable.work);
 
+	ret = devm_work_autocancel(dev, &info->otg.work,
+				   axp288_charger_otg_evt_worker);
+	if (ret)
+		return ret;
+
 	/* Register for OTG notification */
-	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
 	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
 	if (info->otg.cable) {
 		ret = devm_extcon_register_notifier(dev, info->otg.cable,



