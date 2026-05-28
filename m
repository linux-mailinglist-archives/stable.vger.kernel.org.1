Return-Path: <stable+bounces-255895-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKuWOzqnGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255895-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 746885F9131
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A039430F5D70
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7FB317163;
	Thu, 28 May 2026 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TMrn+pCf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8091EA65;
	Thu, 28 May 2026 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000180; cv=none; b=aP7QrRQFaRKkt4My09GtneBd+5Ce8W172PU0rDb89+5jEIUbaI/yH1/hn5m84RUKUFwuS8Di2ARl4XCVa8wdFa0/rw3yYnZywldoC+74x4G10aeHqpf7qoCL3um3HXxBKGZPpFzlZwoD3wk2wTUjWF7ZTlVDXfIa6wIICdZPh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000180; c=relaxed/simple;
	bh=jtsU0nGGCpMxaHmql99hZsMf1mO8CC+W2QNxQlS72fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+cnJjZBC4pwt6DPqT4m4c6cQOzEk+RW1gaujmXm+mJ/Ah72hAudcFTybAdtJADZnmyv+meovzUxk1xQomDJBnN6jsRQJ/bkkn0W1FskvOA7wUfWtHmu0X44rUg6cKHEQTM4fcnA160crVvGAg/X2zAYx6Kzx+Z/KRy18cQHxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TMrn+pCf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5B11F000E9;
	Thu, 28 May 2026 20:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000178;
	bh=9qJdyN7Ax1oL1ero/jvpOz++zPX2L7R2D9oRFZFipGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TMrn+pCfNuqUvp2ADV6+kSZS+caTphuO101rkHv3n66YSnpHF3RC/Bni3+riOVVWa
	 b2DhMYUCweP4GjGWVIPoPHBKmUmVYBrR4kd35TSDz/juyar4BcMr61bKt426WAHolu
	 SYKTX2/qe/CRiMxCCU8fg+AvHRQZF5wLVDTiQSf8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver White <oliverjwhite07@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 330/377] platform/surface: aggregator_registry: omit battery & AC nodes on Surface Laptop 7
Date: Thu, 28 May 2026 21:49:28 +0200
Message-ID: <20260528194647.962934547@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255895-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 746885F9131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index a594d5fcfcfd1..d29158faba3e8 100644
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




