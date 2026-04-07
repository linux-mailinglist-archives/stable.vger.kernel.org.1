Return-Path: <stable+bounces-233589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHjUFU761GmgzQcAu9opvQ
	(envelope-from <stable+bounces-233589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:36:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8D93AE7C0
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA1F33024A1A
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620113B47E8;
	Tue,  7 Apr 2026 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZwXHnkl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2613ACA43;
	Tue,  7 Apr 2026 12:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775565232; cv=none; b=uAZrGd6rri2vLpznqe0fHLzfiDxaPjW5UFd5rnCBdLbgC51N5l5fVO76HiXaKgGiVArKkaTIRbl0d6ouvM3WjsLgAnv8KtNgmknKv+ojeEzSfMBUHBSgScugxB4SVEo9kGU2bm8rO4KRI5GcLgdaeICJpO91CtUDHKO0t8QdCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775565232; c=relaxed/simple;
	bh=FwBXecI0p0IB6IN7GC8Y7FHX3sFO5EIumD+xwZduELA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGi4NJ/gwCvz7LxxNERQMY3tmLnuUsvzJQX5xOwgGuicVmaYAGudpxGFPTQNqFkgJATyxgdi7spskcG/7qmoSPsKBUudY+WP8c4NKlsyY21CCO5m2nQhu89pGcgQC1u5jSVAF6Lo5KyMRFl9od6VZYOYN4POlREeHutcSUK8tKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZwXHnkl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D990C116C6;
	Tue,  7 Apr 2026 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775565231;
	bh=FwBXecI0p0IB6IN7GC8Y7FHX3sFO5EIumD+xwZduELA=;
	h=From:To:Cc:Subject:Date:From;
	b=IZwXHnklLNiv72pNVROTtcy/QZDXZwGibnicT5xsE7QxHoGgI5c1aBdBqbdjD85SL
	 qUBHEL5zA6LbM/hNe9nfo3y61DI6TFhRpkmIxgrujrr2E9fTFAGwUnUXT8NrE79Ahf
	 CLUliHMKZ6Zhz8pLiSBmLWCBlyKW5YkVtgYMflJT08UzCTwwOj+POCZmNQ5P7PCExR
	 3PaSgEZvP55UUHquqjLM1zB2xRp/RPs6peIxzQdrdvAQANcH6jVzFXzaePi1UCuna4
	 sZ5oW9AQQtdGfgLi90zrkma+Pt0zh5mTIJtFK2T8UubVWq0kDOzyZinxQxWBpNY1s8
	 BGPQHA+jR4bbQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA5cq-0000000BEVn-3jno;
	Tue, 07 Apr 2026 14:33:48 +0200
From: Johan Hovold <johan@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Dzmitry Sankouski <dsankouski@gmail.com>
Subject: [PATCH v2] power: supply: max17042: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 14:33:38 +0200
Message-ID: <20260407123338.2677375-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,samsung.com,puri.sm,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233589-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CB8D93AE7C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 0cd4f1f77ad4 ("power: supply: max17042: add platform driver variant")
Cc: stable@vger.kernel.org	# 6.14
Cc: Dzmitry Sankouski <dsankouski@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---

Changes in v2:
 - add missing driver name to patch summary prefix


 drivers/power/supply/max17042_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index acea176101fa..914f18ce79b3 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1165,7 +1165,8 @@ static int max17042_platform_probe(struct platform_device *pdev)
 	if (!i2c)
 		return -EINVAL;
 
-	dev->of_node = dev->parent->of_node;
+	device_set_of_node_from_dev(dev, dev->parent);
+
 	id = platform_get_device_id(pdev);
 	irq = platform_get_irq(pdev, 0);
 
-- 
2.52.0


