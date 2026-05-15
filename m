Return-Path: <stable+bounces-247589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBz/HC3eBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:49:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C14B54BB78
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E4B82305CAC2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1584219E7;
	Fri, 15 May 2026 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YtuEbDsK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5E407599
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834409; cv=none; b=ngHx5m9a5x9yIycbriQbO5NSlTt005kCMIb4RaZTBuKE3qN307FbE1DppOoK93qHIZqDEs48VwW1wUchEc+zSK7Oq39xJdrj15RHqrC2VoeJaf7Vla5EGHnxa2pLdC8mfoBq4Bw/ZMqHjs/o/lrksXiYIspejPyTEwRvM6dPPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834409; c=relaxed/simple;
	bh=M8HtDGtwyar1YaVFxgG+10VMOwyig0GZXg0avrm1TLk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mr1RcIEgI/vfY/MNSRpu/ZaK4pd2QILOCP6lq81sBAX80tN6xEuwMs3mmnqTY33v2DrT2qvXZxzmck3mnXiIs24FlxzWlVV5vqaX6GPQ47UqBcHBI9uCUvcf6EyQQWIwBmX6v/YyKIkDEy6dA5WOTvMWYSjYKwKPBUaA48jsJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YtuEbDsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48B2C2BCB0;
	Fri, 15 May 2026 08:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834409;
	bh=M8HtDGtwyar1YaVFxgG+10VMOwyig0GZXg0avrm1TLk=;
	h=Subject:To:Cc:From:Date:From;
	b=YtuEbDsKEnyt3cSThCky4R/7bWtPzW4ZlN9emmQlWbjdfhYiIheEV//dMPOVqbRYc
	 3v6+99UBPgal944rsI0UPHYOsqN37jLzrRVS8CsaJQ9EueCPhkXuA+TPDW04zZFJZl
	 YE20iK3EHi7ldCBZzN6SohiaTJFFwJdKpX9sQy/4=
Subject: FAILED: patch "[PATCH] drm/exynos: remove bridge when component_add fails" failed to apply to 5.15-stable tree
To: osama.abdelkader@gmail.com,luca.ceresoli@bootlin.com,rgallaispou@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:40:02 +0200
Message-ID: <2026051502-causation-unmanned-f1e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C14B54BB78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247589-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,bootlin.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:email,msgid.link:url,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 26f6654a9a60eb4d241f42a0ec85412e8821480b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051502-causation-unmanned-f1e5@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26f6654a9a60eb4d241f42a0ec85412e8821480b Mon Sep 17 00:00:00 2001
From: Osama Abdelkader <osama.abdelkader@gmail.com>
Date: Thu, 23 Apr 2026 22:06:20 +0200
Subject: [PATCH] drm/exynos: remove bridge when component_add fails
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use devm_drm_bridge_add() so the bridge is released if probe fails after
registration, and drop the manual drm_bridge_remove() in remove().

Check the return value of devm_drm_bridge_add().

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: 576d72fbfb45 ("drm/exynos: mic: add a bridge at probe")
Cc: stable@vger.kernel.org
Reviewed-by: Raphaël Gallais-Pou <rgallaispou@gmail.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Link: https://patch.msgid.link/20260423200622.325076-2-osama.abdelkader@gmail.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 29a8366513fa..e68c954ec3e6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -423,7 +423,9 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 	mic->bridge.of_node = dev->of_node;
 
-	drm_bridge_add(&mic->bridge);
+	ret = devm_drm_bridge_add(dev, &mic->bridge);
+	if (ret)
+		goto err;
 
 	pm_runtime_enable(dev);
 
@@ -443,12 +445,8 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 static void exynos_mic_remove(struct platform_device *pdev)
 {
-	struct exynos_mic *mic = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &exynos_mic_component_ops);
 	pm_runtime_disable(&pdev->dev);
-
-	drm_bridge_remove(&mic->bridge);
 }
 
 static const struct of_device_id exynos_mic_of_match[] = {


