Return-Path: <stable+bounces-255559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAy9GuajGGrClggAu9opvQ
	(envelope-from <stable+bounces-255559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:21:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61C5F8789
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B41C31FFE5F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A77E3FE37C;
	Thu, 28 May 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BKdRsS3X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97A352019;
	Thu, 28 May 2026 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999253; cv=none; b=STbVM5dQXNUyMSG76CKatPjOvpUv50eP1s1QsoRTDN293b7ZvZTzeDFyd4DNYp0dYQ6/jWrU82rnPrWf7eZHB79en0rlimf4YTwLSkd7uLXPLhZZZjVK/wr0Qo2F74eSGc0Ej0BX795+ehRgsCrdxhhAjMzQCO2LR0JrWCS0Olc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999253; c=relaxed/simple;
	bh=6mTwy76fpBh6UuIn4eejvgyVthyX19YcQ5SoSP2crN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7VXWZfoHI1H3QUABLX4qNbfA2bsSrXOQxn7ZcO7bFqdoaRC7R5kUVVxcVdRJ7GFGl+6kZfdGj1SMYTQ5MtM8WjxxDl0sw57EtA9PTyIDtp4CTYzFjfex89AwkYCee3/Kj2SSxRU3obzQXkW9x3NAeGGOm67A6wyzs7AdCqa9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BKdRsS3X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F73A1F000E9;
	Thu, 28 May 2026 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999252;
	bh=vOerbDvCwqOYuMf7f9SZDakQS5pf8daQJPUtG9xHp3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BKdRsS3XcfMNou6Q8NLrfyDjmNEuA/zrnREX+YUk7nYMzr1u0WujxmyVDyBBNCCX6
	 HcSbLmIcYofA5gxYnZ1LhOKcl8QMYH1GZo9QGNVCR6C9C1iiyk7i0eK1mk0dgGoFW2
	 1Shs7Vaomo9S+GXW2320L/QLaPJPFDIrrLBcgEug=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Werner Sembach <wse@tuxedocomputers.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 461/461] platform/x86: uniwill-laptop: Do not enable the charging limit even when forced
Date: Thu, 28 May 2026 21:49:50 +0200
Message-ID: <20260528194700.884532996@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,tuxedocomputers.com,linux.intel.com,gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255559-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,tuxedocomputers.com:email,reddit.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email]
X-Rspamd-Queue-Id: EA61C5F8789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 26cbe119f99c86dcb4a0136d2bc73c0c716d80e4 ]

It seems that on some older models (~2020) the battery charging limit
can permanently damage the battery. Prevent users from enabling this
feature thru the "force" module parameter to avoid causing permanent
hardware damage on such devices.

Fixes: d050479693bb ("platform/x86: Add Uniwill laptop driver")
Link: https://www.reddit.com/r/XMG_gg/comments/ld9yyf/battery_limit_hidden_function_discovered_on/
Reviewed-by: Werner Sembach <wse@tuxedocomputers.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/20260512232145.329260-5-W_Armin@gmx.de
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/laptops/uniwill-laptop.rst | 10 ++++++++++
 drivers/platform/x86/uniwill/uniwill-acpi.c          |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/laptops/uniwill-laptop.rst b/Documentation/admin-guide/laptops/uniwill-laptop.rst
index 561334865feb7..1f3ca84c7d88b 100644
--- a/Documentation/admin-guide/laptops/uniwill-laptop.rst
+++ b/Documentation/admin-guide/laptops/uniwill-laptop.rst
@@ -43,6 +43,11 @@ Support for changing the platform performance mode is currently not implemented.
 Battery Charging Control
 ------------------------
 
+.. warning:: Some devices do not properly implement the charging threshold interface. Forcing
+             the driver to enable access to said interface on such devices might damage the
+             battery [1]_. Because of this the driver will not enable said feature even when
+             using the ``force`` module parameter.
+
 The ``uniwill-laptop`` driver supports controlling the battery charge limit. This happens over
 the standard ``charge_control_end_threshold`` power supply sysfs attribute. All values
 between 1 and 100 percent are supported.
@@ -70,3 +75,8 @@ The ``uniwill-laptop`` driver allows to set the configurable TGP for devices wit
 allow it.
 
 See Documentation/ABI/testing/sysfs-driver-uniwill-laptop for details.
+
+References
+==========
+
+.. [1] https://www.reddit.com/r/XMG_gg/comments/ld9yyf/battery_limit_hidden_function_discovered_on/
diff --git a/drivers/platform/x86/uniwill/uniwill-acpi.c b/drivers/platform/x86/uniwill/uniwill-acpi.c
index 540604c297715..bcd25d08f56b0 100644
--- a/drivers/platform/x86/uniwill/uniwill-acpi.c
+++ b/drivers/platform/x86/uniwill/uniwill-acpi.c
@@ -2207,8 +2207,8 @@ static int __init uniwill_init(void)
 	}
 
 	if (force) {
-		/* Assume that the device supports all features */
-		device_descriptor.features = UINT_MAX;
+		/* Assume that the device supports all features except the charge limit */
+		device_descriptor.features = UINT_MAX & ~UNIWILL_FEATURE_BATTERY;
 		pr_warn("Enabling potentially unsupported features\n");
 	}
 
-- 
2.53.0




