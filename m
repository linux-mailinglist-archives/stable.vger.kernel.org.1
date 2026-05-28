Return-Path: <stable+bounces-255929-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM2ZOSWnGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255929-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6D5F90EE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64C0830A7C2F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D13B33372A;
	Thu, 28 May 2026 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKuExH3d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E265F32AAD6;
	Thu, 28 May 2026 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000274; cv=none; b=CcwtkOysMF29Uj1BP+OVLhrEk9lJSxsNJcfOJsYfprA01krNXuwfcjNdOS7NfYphf7cbdoYKR26S7NMguGk8ootkNSQbJ4KtnccY8TqtG+k4yiC/ZVgz1PW3vbuLZsX6CGDS05DVpc0KjYDvogg26sK005vBNlvn8uAlUt4yvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000274; c=relaxed/simple;
	bh=H8Idb3fEY63Qf+NiRxVH7zT33G7dAF/yRmYB7NTKdsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqQVinvT7j521omLDoiWUW09cvI04ntSQhxuLRLT3nOcADghITpg4aqM1UcrDZ1GRItjTSxOkPiPFcU+h4miY4quAqzUCx5TYsARF57ic+Vn3QwbSmNt4zFoX/ob2qexzbMKjFRJ/wQnujA/sWuZqMkFPBWbJzHEGqsKKTQtaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hKuExH3d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB171F000E9;
	Thu, 28 May 2026 20:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000273;
	bh=5nXVX0kC1MNV1W3XmJksx8i9OD/DigduBnBM6uCcrUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hKuExH3d9IOv17qIYMG745UFnELwLGbg/IV47xHmwHR5LSKgRS6QBzQEqTAzYI+v3
	 MWxxstxCSxBgnhQDNynJa1TFtoQDUpMAq98oTfqQnq9yzpHHwz73KVgKF+2Or4dPL3
	 /vkTYPwHH5AJ1zt1MNifQhlypaqmfCypzeEKpelA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 365/377] gpio: aggregator: lock device when calling device_is_bound()
Date: Thu, 28 May 2026 21:50:03 +0200
Message-ID: <20260528194648.996612604@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255929-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C8E6D5F90EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 598a2b3e2e0e6aa2e9f7843c96c45b5ea11e0411 ]

The kerneldoc for device_is_bound() says it must be called with the
device lock taken. Add missing synchronization to this driver.

Fixes: 3a27f40b4570 ("gpio: aggregator: stop using dev-sync-probe")
Link: https://patch.msgid.link/20260518-gpio-dev-lock-v1-2-cc4736f3ff0b@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-aggregator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 8cbebcb4bb1f9..17db07cf92d05 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -969,9 +969,12 @@ static int gpio_aggregator_activate(struct gpio_aggregator *aggr)
 	}
 
 	wait_for_device_probe();
-	if (!device_is_bound(&pdev->dev)) {
-		ret = -ENXIO;
-		goto err_unregister_pdev;
+
+	scoped_guard(device, &pdev->dev) {
+		if (!device_is_bound(&pdev->dev)) {
+			ret = -ENXIO;
+			goto err_unregister_pdev;
+		}
 	}
 
 	aggr->pdev = pdev;
-- 
2.53.0




