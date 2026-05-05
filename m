Return-Path: <stable+bounces-244168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFgnEO3/+WljHAMAu9opvQ
	(envelope-from <stable+bounces-244168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:34:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 041AB4CF814
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48DF030882BF
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0160480946;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="scsN70i/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE01480331;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991314; cv=none; b=TIcyUrb43AKvXXoER5iHji6T7qz5aTmghOb+YHu+AD0JBGxxfmO1tNRnY+2wjpsBuoN+bX9c5qdxRhrr2RKe7+cQEvKObLmh8bkLbH6Wwh00YNktKcZsuGRNFmPjWXdicdOS7Kt+aa8IqNIJlkU3lz0DX+NegEJ41YCPpCatHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991314; c=relaxed/simple;
	bh=JIUw3NRme++76CpTBzA3sK9Ldz5NlkeSMePNeiX4fp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7fl2nt1kO2qfP1nWPcXWFpBCZ6oRZjKXzxFTdNufJsGvJmAQi7wp/fRvN3tI8VKKgeAQlGtn7+d3SHxgPfSyLWNw/5vpMOIW/E9wdXRZMmObXisQOE0qKCvW9d9J79osV4ji1s6yLxhKkQpMdjlXXnGgaWFCTiSFpyd1nmeBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=scsN70i/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A07AC2BCFA;
	Tue,  5 May 2026 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777991314;
	bh=JIUw3NRme++76CpTBzA3sK9Ldz5NlkeSMePNeiX4fp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=scsN70i/yNeeY8COd38hlOlKRMGgCWqnqo08L3yIp/6JkltOasEKsdP0RZhu9ndkM
	 gyuE3jEps2KOQav2YZRjeY1qYMH1XUOBwrpJzH5QlSFSoPFruapY0/R0L2BZDUpKC9
	 Lx3rSiNZCQTTMzEqY8++zAqSc3O6AWrnr/dhOqhlOYNXzzZok7Vi64+CRooqmKO+PV
	 NRDjwyWa/TP0Y4zdUhA3pfpikPpC8wFPBUXLp27h+Jz+L7MrsDykC7vvJEklXP5mn7
	 MshypMnADhPHAUBOYxlkGUVuNAgo67eX6Al+aOWux0jbagG1jpiml8fNro+iarjziY
	 wAqlqhq8RaOOA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wKGlE-00000003Ksu-0SGM;
	Tue, 05 May 2026 16:28:32 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 2/8] i2c: core: fix adapter probe deferral loop
Date: Tue,  5 May 2026 16:25:41 +0200
Message-ID: <20260505142547.795054-3-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505142547.795054-1-johan@kernel.org>
References: <20260505142547.795054-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 041AB4CF814
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244168-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,microchip.com:email]

Drivers must not probe defer after having registered devices as that
will trigger a probe loop if the devices bind to a driver (cf. commit
fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")).

Move the recovery initialisation, where the GPIO lookup may fail, before
registering the adapter to prevent this.

Fixes: 75820314de26 ("i2c: core: add generic I2C GPIO recovery")
Cc: stable@vger.kernel.org	# 5.9
Cc: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 7cec3f276e13..2832e1aa0ca3 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1562,6 +1562,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	adap->dev.type = &i2c_adapter_type;
 	device_initialize(&adap->dev);
 
+	res = i2c_init_recovery(adap);
+	if (res == -EPROBE_DEFER)
+		goto err_put_adap;
+
 	/*
 	 * This adapter can be used as a parent immediately after device_add(),
 	 * setup runtime-pm (especially ignore-children) before hand.
@@ -1574,8 +1578,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	res = device_add(&adap->dev);
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
-		put_device(&adap->dev);
-		goto out_list;
+		goto err_put_adap;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1584,10 +1587,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res)
 		goto out_reg;
 
-	res = i2c_init_recovery(adap);
-	if (res == -EPROBE_DEFER)
-		goto out_reg;
-
 	dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);
 
 	/* create pre-declared device nodes */
@@ -1608,8 +1607,10 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 out_reg:
 	i2c_deregister_clients(adap);
 	debugfs_remove_recursive(adap->debugfs);
+	device_del(&adap->dev);
+err_put_adap:
 	init_completion(&adap->dev_released);
-	device_unregister(&adap->dev);
+	put_device(&adap->dev);
 	wait_for_completion(&adap->dev_released);
 out_list:
 	mutex_lock(&core_lock);
-- 
2.53.0


