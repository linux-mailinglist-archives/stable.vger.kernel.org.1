Return-Path: <stable+bounces-237679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKJbAwF53WnbegkAu9opvQ
	(envelope-from <stable+bounces-237679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:15:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3D93F4376
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 01:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 613A7301490E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 23:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209801F0E25;
	Mon, 13 Apr 2026 23:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="o+8Hx4NZ"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2135B658
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776122103; cv=none; b=V0Gq/yj39K4jIqb0TOeU9g9XL+XTGu229GAicGpH2FlT2JFFd2xMKs+rC3pkeQ9uEXip5IYBxrdi6QGW+g2zNdEwcU2Pz7G5ehau9uSiRBSRBXq+i4fzA8+Y6SH7OZRB3pTyJ6K67qciecZjJoXGCP5hKmAIZEiZiMLCWxrJVF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776122103; c=relaxed/simple;
	bh=L+KXAt1BEm1BCbjLX8NoBUGMwgdnGZCaPhmuXpd1h50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN+/iSV4USY5UwkEAqemrBFU1aDls+1kxN7BIJD9B4JCsnn6Au32Wl9UXQaMrhqi1LENYoBoKWKQ7MjYyYlb+02Bn4Lmizi4l14Bb/hJExFG1dGOZofnP64F7MqUwXclHsBERItRqPkqEhSU1ti1Oji1Wc/xevu7uJL0a2lF2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=o+8Hx4NZ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VvVWMTYSQZJEZNOz9VTaK0EIlQVGljoOfDMpFfmNcf8=; b=o+8Hx4NZuP54mkntXMkmAy5fKX
	W9kwvUz6dNDAp7r9Z3wJYNAu6D4SOBfCzqLR/mNfSbAAo1p2eJr3LBtr2Ru5EIMMAJ9cInL7pQ+Zw
	laywQHgAwzj56fhw7WB8J+hDq+jcyMHclhqU39si0+rnDi0yeY+VLo1tADSU22XahrU6WZaJ8e1L2
	g5Q601GAJ2Dbvx/27u55sC+zsisiK/sKaLrfJnlRVNAy2nJc1+9duq7EqT2VZcydChO1NkWOU2JaA
	Ts5Ij/kcbAKUywxIe/YZ6E0jYGGYwm6KdwDc+YDScHDuF4ncuqmIGPBACPmtpr0SmxjRcFfii+nEO
	ecXz6vpA==;
Received: from 186-249-145-49.shared.desktop.com.br ([186.249.145.49] helo=t470)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wCQUc-00Fdt7-3P; Tue, 14 Apr 2026 01:14:58 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 6.12.y 1/2] thermal: core: Mark thermal zones as exiting before unregistration
Date: Mon, 13 Apr 2026 20:14:50 -0300
Message-ID: <20260413231451.357918-2-mfo@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413231451.357918-1-mfo@igalia.com>
References: <2026040820-overpass-barrette-bf09@gregkh>
 <20260413231451.357918-1-mfo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237679-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mfo@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.218];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,msgid.link:url,arm.com:email]
X-Rspamd-Queue-Id: 0A3D93F4376
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 1dae3e70b473adc32f81ca1be926440f9b1de9dc ]

In analogy with a previous change in the thermal zone registration code
path, to ensure that __thermal_zone_device_update() will return early
for thermal zones that are going away, introduce a thermal zone state
flag representing the "exit" state and set it while deleting the thermal
zone from thermal_tz_list.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/4394176.ejJDZkT8p0@rjwysocki.net
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
[ mfo: this commit is a dependency/helper for backporting next commit. ]
Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 drivers/thermal/thermal_core.c | 3 +++
 drivers/thermal/thermal_core.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index aa302ac62b2e..4663ca7a587c 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1614,7 +1614,10 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	}
 
 	mutex_lock(&tz->lock);
+
+	tz->state |= TZ_STATE_FLAG_EXIT;
 	list_del(&tz->node);
+
 	mutex_unlock(&tz->lock);
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 163871699a60..007990ce139d 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -65,6 +65,7 @@ struct thermal_governor {
 #define	TZ_STATE_FLAG_SUSPENDED	BIT(0)
 #define	TZ_STATE_FLAG_RESUMING	BIT(1)
 #define	TZ_STATE_FLAG_INIT	BIT(2)
+#define	TZ_STATE_FLAG_EXIT	BIT(3)
 
 #define TZ_STATE_READY		0
 
-- 
2.51.0


