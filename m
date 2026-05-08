Return-Path: <stable+bounces-244712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODGILE+n/Wl0ggAAu9opvQ
	(envelope-from <stable+bounces-244712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:05:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B724F4036
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A390301F33A
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC8738737E;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLqs0GVM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655731BCAE;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778231012; cv=none; b=Xv9uo+10hcpvptOZECQvg86GcwmqRzILit1zNOQpyTGzXXH73uNb+OY82WH1yXidzqy70HvkZDlYQiQAC42v4sEIsyw2oJyKDtdIxAgTtkIeUPCZC1ltmtvDLG9Np4JFiO8LxuCOSAE1gMItRDLlCTrP0AstHTovNF3HkktPgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778231012; c=relaxed/simple;
	bh=Syz9agCjo0v7ek7ZUl8IDRv5CIYKzs5t99pAAWh8o7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbSeOr3cAgbAf2DWNvmnHfxjunAZ+9RVZApX1gA2y1ipkHMorHHMkWC14sJDLZY1PaWUlChUDE1G3GcVKjCJ/yWodMX95PnYBq8OvQhErITjdtiUrs9ItGoj/SaZDN0XsNsfimmT/ePVUv4+SFuoTc76Hut40z6qCWXgwGL4XaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLqs0GVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249D2C4AF09;
	Fri,  8 May 2026 09:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778231012;
	bh=Syz9agCjo0v7ek7ZUl8IDRv5CIYKzs5t99pAAWh8o7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLqs0GVMLLCptnQypnTSmCyxArTXWwcl2P94VKpfYL2luahviZpwXjwxm4SVPjFmP
	 n+Nzp8IubS4ZtvPJ7HiXVznR64zW27v/lbtDGAe43dLAF0OxFzzwtaXotCN2yNI1X0
	 wb5Htxsr9VE06+Gzgz/I1ENnXrx31QAmtPH3MIuLrVcL6XJqGLLGzzFpmNuUTMU36U
	 zJqVczTW9NBI/C3abuBtiiPNodbRCsyGqMtmUSUQAp7BdU5Jj0mQJYNc/JmbZqX0kT
	 1QNro4tFaYdUKdNZIGTZ0uQdUYfHgxiC4BBLO/sH7bYJxdQOzxHKqQIlTJPSSPBUKt
	 bjTa6dMQz6UVg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLH7J-00000001ah0-42SO;
	Fri, 08 May 2026 11:03:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v2 1/9] i2c: core: fix irq domain leak on adapter registration failure
Date: Fri,  8 May 2026 11:03:03 +0200
Message-ID: <20260508090311.379333-2-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508090311.379333-1-johan@kernel.org>
References: <20260508090311.379333-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36B724F4036
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244712-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Make sure to tear down the host notify irq domain on adapter
registration failure to avoid leaking it.

This issue was flagged by Sashiko when reviewing another adapter
registration fix.

Fixes: 4d5538f5882a ("i2c: use an IRQ to report Host Notify events, not alert")
Cc: stable@vger.kernel.org	# 4.10
Cc: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 9c46147e3506..abe8341c1d6e 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1574,7 +1574,7 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	if (res) {
 		pr_err("adapter '%s': can't register device (%d)\n", adap->name, res);
 		put_device(&adap->dev);
-		goto out_list;
+		goto err_remove_irq_domain;
 	}
 
 	adap->debugfs = debugfs_create_dir(dev_name(&adap->dev), i2c_debugfs_root);
@@ -1609,6 +1609,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	init_completion(&adap->dev_released);
 	device_unregister(&adap->dev);
 	wait_for_completion(&adap->dev_released);
+err_remove_irq_domain:
+	i2c_host_notify_irq_teardown(adap);
 out_list:
 	mutex_lock(&core_lock);
 	idr_remove(&i2c_adapter_idr, adap->nr);
-- 
2.53.0


