Return-Path: <stable+bounces-38632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C358A0F9E
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84952819B6
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D703146A64;
	Thu, 11 Apr 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mx22KWzH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF8E13FD94;
	Thu, 11 Apr 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831140; cv=none; b=JToNzGMPq8bs2b9+melMGWVmawn4p0nOIK2DQ7I5rcusma6x8KRDszDrns0fO/jp07zIGTs2jAKLwHDhkMfgMFr2pU9v64ipbqibLZuRAuL+koJXIuyAHMDh0K11Dg4wazFPumiNde3ThFmKvx6Dw2MxaADLTrMINnJF+gATlKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831140; c=relaxed/simple;
	bh=JCw8ElE2Y3O6/CZ3MV1KBpN6H6E6D2J+rsjXBSIaS/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiM2YnitusLZ60AjCAqj/Sj90qVI12QLDVhYcKgJvGMFTSecKeLfwHnLk/4JUKRRnr5Ax0cv9hSCaJbDeMZqR27KwrYKDFzA0a6FkfXQsIgnbkI0dqpFVeZUPJJE/A6gGzze8l+4iPg5PynIRj6xkncqGwbo+Km3kMmtsbkZVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mx22KWzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0813C433F1;
	Thu, 11 Apr 2024 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831140;
	bh=JCw8ElE2Y3O6/CZ3MV1KBpN6H6E6D2J+rsjXBSIaS/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mx22KWzHDXfa+ktIT/g4BNGA46HRvXaKk452iu1frhGsogx3b9wYA1rLDsGwVabLN
	 1orR3U1N+LnO+NzvkpmPYfznklajx76fcJWO4zfi7XIIcCD3qVC98crdM96jnCIbpD
	 O5IbLrBt0KhV+QOvvXJ6F8NQZs2W2MThnMTrSlsQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Elfring <elfring@users.sourceforge.net>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 005/114] batman-adv: Improve exception handling in batadv_throw_uevent()
Date: Thu, 11 Apr 2024 11:55:32 +0200
Message-ID: <20240411095417.023668264@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095416.853744210@linuxfoundation.org>
References: <20240411095416.853744210@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit 5593e9abf1cf2bf096366d8c7fd933bc69d561ce ]

The kfree() function was called in up to three cases by
the batadv_throw_uevent() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus adjust jump targets.

* Reorder kfree() calls at the end.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Acked-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index e8a4499155667..100e43f5e85aa 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -688,29 +688,31 @@ int batadv_throw_uevent(struct batadv_priv *bat_priv, enum batadv_uev_type type,
 				  "%s%s", BATADV_UEV_TYPE_VAR,
 				  batadv_uev_type_str[type]);
 	if (!uevent_env[0])
-		goto out;
+		goto report_error;
 
 	uevent_env[1] = kasprintf(GFP_ATOMIC,
 				  "%s%s", BATADV_UEV_ACTION_VAR,
 				  batadv_uev_action_str[action]);
 	if (!uevent_env[1])
-		goto out;
+		goto free_first_env;
 
 	/* If the event is DEL, ignore the data field */
 	if (action != BATADV_UEV_DEL) {
 		uevent_env[2] = kasprintf(GFP_ATOMIC,
 					  "%s%s", BATADV_UEV_DATA_VAR, data);
 		if (!uevent_env[2])
-			goto out;
+			goto free_second_env;
 	}
 
 	ret = kobject_uevent_env(bat_kobj, KOBJ_CHANGE, uevent_env);
-out:
-	kfree(uevent_env[0]);
-	kfree(uevent_env[1]);
 	kfree(uevent_env[2]);
+free_second_env:
+	kfree(uevent_env[1]);
+free_first_env:
+	kfree(uevent_env[0]);
 
 	if (ret)
+report_error:
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "Impossible to send uevent for (%s,%s,%s) event (err: %d)\n",
 			   batadv_uev_type_str[type],
-- 
2.43.0




