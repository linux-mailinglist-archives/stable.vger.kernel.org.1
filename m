Return-Path: <stable+bounces-242413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCTDBX6c9GloCwIAu9opvQ
	(envelope-from <stable+bounces-242413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:28:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B34AC645
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 14:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8954B302F9AE
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FF43A2560;
	Fri,  1 May 2026 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rTTzLsLI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2703A2540
	for <stable@vger.kernel.org>; Fri,  1 May 2026 12:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638267; cv=none; b=oJjTWfwzswK/zLIlULZOwlP/zUqmvI/Q2znnOwDDI1N30TEpAqKw1uzRLvLSzjyr6zqteE1Hd41Eq1w4Ze3fQxYQmAgTbHw9dT0zWUaxxOFR8/0smzlnxHoFnF2ibqeVzL6D/c7dCzUQS9xC3rxhTPSvrCte24EQLLW89FTpra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638267; c=relaxed/simple;
	bh=1TUB8tS8sj3kSRCdo4wyYFQIPUyrelOMWPP4ca2vJJo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uuEc//p5ZKQ9OFCZj7ryxRt4qsJcmVFl31NeVYYKZDFLZnE7GtELHvUBHyH1v0Af1I/md1AyAu9JO/gnuXU7IKx9/kHSTglYX46UueHsg0meSk2kdYzXuPEc3NBwRlJqGirRnFPguC1F/hso9a/hud36YPCfcuofDq/db10UTW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rTTzLsLI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2AAC2BCB4;
	Fri,  1 May 2026 12:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777638267;
	bh=1TUB8tS8sj3kSRCdo4wyYFQIPUyrelOMWPP4ca2vJJo=;
	h=Subject:To:Cc:From:Date:From;
	b=rTTzLsLIM339JH/rLuBuNYwDiajM/bwVZNt+OIdmz+hjoNLh4wy3Cfn0H7mcvGpUj
	 CXChXM05ALFJbiX4+Lq87JgnQlmYD+5EsnYm/qYnjBpWP7C77ap0jA0K/Zkb0Unxlb
	 +SdbW+gwpPqe6d26CBC7W6aYoDqBN8IVYFEtXVe4=
Subject: FAILED: patch "[PATCH] power: supply: axp288_charger: Do not cancel work before" failed to apply to 5.10-stable tree
To: krzysztof.kozlowski@oss.qualcomm.com,johannes.goede@oss.qualcomm.com,sebastian.reichel@collabora.com,wens@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 14:24:24 +0200
Message-ID: <2026050124-sandstorm-slapstick-e3f8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 701B34AC645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242413-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:dkim,msgid.link:url]


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 658342fd75b582cbb06544d513171c3d645faead
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050124-sandstorm-slapstick-e3f8@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 658342fd75b582cbb06544d513171c3d645faead Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 18:49:39 +0100
Subject: [PATCH] power: supply: axp288_charger: Do not cancel work before
 initializing it

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

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index ac05942e4e6a..ca52c2c82b2c 100644
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
@@ -821,14 +822,6 @@ static int charger_init_hw_regs(struct axp288_chrg_info *info)
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
@@ -911,12 +904,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
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
@@ -926,8 +919,12 @@ static int axp288_charger_probe(struct platform_device *pdev)
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


