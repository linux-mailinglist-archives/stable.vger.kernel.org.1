Return-Path: <stable+bounces-255926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHxPICGnGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 257A55F90C9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6DD2130A6228
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B333987F;
	Thu, 28 May 2026 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G4jeEsF0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400825F7B9;
	Thu, 28 May 2026 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000266; cv=none; b=ZSgUk348PXGAKpiYz7MxCowqIEi3HGQzMrbp8EQa9BAv9GaXzGPeEi9VxutrdRgBRNUriY9C3v3qdck8/c88MIyMWyxCr3aA4Cphxh/uRzkiXv5RA+2VVfnkUY8QTf63C+6QYtCwin00rrmfw8/Ndyppo0SqdLvoUohZFo2/4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000266; c=relaxed/simple;
	bh=dvM8buglQIGoxblMRDfq+AwGg4FuSDpnls7mIzlxn3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tW7keu+BVR6/qSfWMpY81ynKHrWMqoXi0iQ/+GWUFPODbBRBfhtCiUi299uSLeuF3E8+BuY2zQAd5Bja2H1H+g0U1gv7Hc/Ja2aOPhpWZjuYd7h42G6lqyQX213B9EvykIERbp0RTG6jg5YrjBkjm+NwWcQtQkiYfhO8l0WkCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G4jeEsF0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABDE1F000E9;
	Thu, 28 May 2026 20:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000265;
	bh=iYfG5j1bWAjBaSE5fJo5LW3nhf2OuL1k9k+EoFkyl28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4jeEsF0AkroZTJqPK1NpAFqcZ1bdQBzyRWJSq6KjKLeGft6qY4BkLSXTFnnsXrGK
	 uNQcXm7fv7xsV0PYUHUGKfwPemAk5d6iqoYeKwRkCJpYRTeAFlOD6Ce1Ccj7JvcFQo
	 e0zdpZLLJnHRD4W8hsmGtnyzpgembB37NVgOT/Rc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 362/377] gpio: aggregator: fix a potential use-after-free
Date: Thu, 28 May 2026 21:50:00 +0200
Message-ID: <20260528194648.911107873@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255926-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,glider.be:email]
X-Rspamd-Queue-Id: 257A55F90C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 30c073cab97afb31901f94de9605177b6b84367e ]

On error we free aggr->lookups->dev_id before removing the entry from
the lookup table. If a concurrent thread calls gpiod_find() before we
remove the entry, it could iterate over the list and call
gpiod_match_lookup_table() which unconditionally dereferences dev_id
when calling strcmp(). Reverse the order of cleanup.

Fixes: 86f162e73d2d ("gpio: aggregator: introduce basic configfs interface")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260520084911.27938-1-bartosz.golaszewski@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-aggregator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 416f265d09d07..a68665700733d 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -970,8 +970,8 @@ static int gpio_aggregator_activate(struct gpio_aggregator *aggr)
 	return 0;
 
 err_remove_lookup_table:
-	kfree(aggr->lookups->dev_id);
 	gpiod_remove_lookup_table(aggr->lookups);
+	kfree(aggr->lookups->dev_id);
 err_remove_swnode:
 	fwnode_remove_software_node(swnode);
 err_remove_lookups:
-- 
2.53.0




