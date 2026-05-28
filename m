Return-Path: <stable+bounces-256216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMZuDyKtGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE6D5FA132
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F9D430502E1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503592EF652;
	Thu, 28 May 2026 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DdQSQPGR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322BB2E7379;
	Thu, 28 May 2026 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001082; cv=none; b=ZIHXXKERnMyeC3QvOXkJgHDRwoZDqI0mXJUHXuwq8i2qfpgxPrkXBuOYtMA+2UPnK3/zud/8YnGdjZfA2y2p9LkhCNG3bgHmBsMCiC/KkLYH+BnzWoggcVREwal8tUZTLYoUKxf0Eh/e5pLCn7ICjODr7Q1nXHGL/jWEVx2Uhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001082; c=relaxed/simple;
	bh=UxZEHc/J+M9+mu36mFxeBUHrLhGDddjdlaFdLfpJ0lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEcAphe0421npNNujqWmgh1fpROfYGqOCMk2mOMC20dSqz92Nt08o/PDgYTGWsRtwHk14hLWFRx2Q8Ti1oXjomHy7IhUszr5+XgJSgyGC5uVgqNhojUl87x30rpzxLlxw687nXCMrHWqlfUdDvrv3YE/lIpjfQlRJawjR/w7eWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DdQSQPGR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912CC1F000E9;
	Thu, 28 May 2026 20:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001081;
	bh=HMGfyVa8eoUvyG9b/b4MpY7jpKPuxQyTPSalWX2O2sM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DdQSQPGRnbN/1lwpWwlJDVt8f9BhTRC8j2fxulfgaaxp4jgtfB/lRac5Jx+WCkOVW
	 dvrd+a4bg6gel7q+uHRBML+jNt6H7q6l7pS1os+eKudQ0p4GDrhDx71Ojy8s3NqxZB
	 y0fT+zsXmPG3YgsuBg1JxbwfUMMAVgHtQj4o6Mi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver White <oliverjwhite07@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 247/272] platform/surface: aggregator_registry: omit battery & AC nodes on Surface Laptop 7
Date: Thu, 28 May 2026 21:50:21 +0200
Message-ID: <20260528194636.044920802@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256216-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6CE6D5FA132
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver White <oliverjwhite07@gmail.com>

[ Upstream commit 0488073a6c84571dd3cffe581a4a73a5fceb099d ]

Surface Laptop 7 exposes battery and AC status via Qualcomm PMIC GLINK
qcom_battmgr. Registering the standard SSAM battery and AC client
devices on this platform causes duplicate power-supply devices to
appear.

Drop the SSAM battery and AC nodes from the Surface Laptop 7 registry
group so that only the qcom_battmgr power supplies are instantiated.

Fixes: b27622f13172 ("platform/surface: Add OF support")
Signed-off-by: Oliver White <oliverjwhite07@gmail.com>
Link: https://patch.msgid.link/20260409034347.17381-1-oliverjwhite07@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/surface/surface_aggregator_registry.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 25c8aa2131d63..9826feb9c2825 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -295,8 +295,6 @@ static const struct software_node *ssam_node_group_sl6[] = {
 /* Devices for Surface Laptop 7. */
 static const struct software_node *ssam_node_group_sl7[] = {
 	&ssam_node_root,
-	&ssam_node_bat_ac,
-	&ssam_node_bat_main,
 	&ssam_node_tmp_perf_profile_with_fan,
 	&ssam_node_fan_speed,
 	&ssam_node_hid_sam_keyboard,
-- 
2.53.0




