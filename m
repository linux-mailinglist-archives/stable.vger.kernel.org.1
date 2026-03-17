Return-Path: <stable+bounces-226735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFxLIQGOuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:23:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B012AF75B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2571306A967
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB07330D54;
	Tue, 17 Mar 2026 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOdMyEz6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC21320CCF
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767999; cv=none; b=CcLqCziFr+dPm6BpXnmqjlaFDu15CVnzSOlmGgi+I9gDE3GRK4yJPAryJ6wAcy6n60qBhOdkbgWwgvc3XRBKrIE+ezHmGGGm2LsJvU22ncnCZNrVCSOyIMSnq+zQTnKSz+SMUrFSx5k+h5E1mOZ2QmeDaBF050K6Ybh9vI+Fw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767999; c=relaxed/simple;
	bh=ss/Qngy1P6Vk4x/kJM955ZcmINXBUTtvYvfKjqAR/cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0xT48FnJTELhiyW0hkqmebtn3L6xfoWTc1MTYu5p6Wx/qICI/QLn1FKBPw5wJxCelarIQTZTM6cc2D15I7C7XWslCkWrXTPRryUiAvh6wEdZx8SIc0l63P2MieVjnssSpQdO+RkL6OJ9zS96xzGU75NgIhDTB2fszYxkwB97V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOdMyEz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD4EC19424;
	Tue, 17 Mar 2026 17:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773767999;
	bh=ss/Qngy1P6Vk4x/kJM955ZcmINXBUTtvYvfKjqAR/cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bOdMyEz6mbOEOaRCTbHZnwpzEdl47Fp2etLy34uS1MUQ8rwABCTs4D8+6KMHLaT+d
	 uk5PcydT4eCuAbbQ/Lqu1TNFQpowD1Iu7AQgf4Pry/6gYrCvftDZDqOL+vj0VXi3FT
	 UaPkc4Ud8+PgiIfLEuwyxua3QdJFLhcjURiyR6GKjzbcW2k/rZDJ1nqeOWZHWLgJUA
	 1osrtwc5/LZBrKQK/A9Mc+SXLMNdK0w4ccUzGwJJVcKk8FPIO3Mb7pf7kXumkmrowk
	 +U8Y4++/Tl3rLtkr06K/Ex5UlvGMxJJ7s/Aa0usGzIpoa7KDh3cw52WGHiUFphzcQC
	 Y7li2FmOgd6+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/8] device property: Retrieve fwnode from of_node via accessor
Date: Tue, 17 Mar 2026 13:19:49 -0400
Message-ID: <20260317171954.238398-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317171954.238398-1-sashal@kernel.org>
References: <2026031703-caravan-bladder-c63a@gregkh>
 <20260317171954.238398-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226735-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21B012AF75B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andy Shevchenko <andy.shevchenko@gmail.com>

[ Upstream commit 3cd8015040d7537a6b88e26f36768a90d9247829 ]

OF provides a specific accessor to retrieve fwnode handle.
Use it instead of direct dereferencing.

Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 2692c614f8f0 ("device property: Allow secondary lookup in fwnode_get_next_child_node()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/property.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 80686d4a2bb35..f8d9b9056d9c7 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -21,7 +21,7 @@
 struct fwnode_handle *dev_fwnode(const struct device *dev)
 {
 	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
-		&dev->of_node->fwnode : dev->fwnode;
+		of_fwnode_handle(dev->of_node) : dev->fwnode;
 }
 EXPORT_SYMBOL_GPL(dev_fwnode);
 
@@ -763,7 +763,7 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 	struct fwnode_handle *fwnode = NULL, *next;
 
 	if (dev->of_node)
-		fwnode = &dev->of_node->fwnode;
+		fwnode = of_fwnode_handle(dev->of_node);
 	else if (adev)
 		fwnode = acpi_fwnode_handle(adev);
 
-- 
2.51.0


