Return-Path: <stable+bounces-216196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBkrEG8tj2kPKwEAu9opvQ
	(envelope-from <stable+bounces-216196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:55:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD41B136BF7
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B60913014433
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C06360720;
	Fri, 13 Feb 2026 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gSSW0zW1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9335FF61;
	Fri, 13 Feb 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990957; cv=none; b=mzIorrwi7GZ07/4wpP885ExW0Nby+ssXUrY2OHgbIN1zwN0gIUZosP5mN3bcMXt02bkRM19rFS4uuBshlF+bpVqUdv4/gpkWCioOf6PIDB7p7N1z0THcxjC9g1zzT9MJ27YxPT1gsQzVrRqLFesyfW3JNsp0yA8Wa4QLNf6zarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990957; c=relaxed/simple;
	bh=iXmeXW1BQ5zVv6CIpBwnj+uYTl3/oNqGr1gUmjSKlCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pS88DVjID8nUNxazFTdZLeIEWcX3Pel/6TisM58gzcVClv0FxWlqQ21CLSHcFx89MB/rjt6TQ8sTXpxINjln36ase9MZoSUccLWobi3IvCYLtNsoFbjEcRCj/pqNl4PK6tTlC7GY7eQZ2rVAGVSl1v9e0onMk4GLcgnIJWBZes4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gSSW0zW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D61BC116C6;
	Fri, 13 Feb 2026 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990956;
	bh=iXmeXW1BQ5zVv6CIpBwnj+uYTl3/oNqGr1gUmjSKlCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSSW0zW1t6LVTcYd57jB4hGCSY4NrXFc0DubRdv4o4jklbvdCHzb/zpz+H0YaS+Yv
	 xFqa3rFN1bH4n1CA+A/hEWPHMhRKqaUH6MSY81p5QN4bo2KeNEK2H1C3MIQtxuP5Id
	 ERIQ9qIn4wzI625R6q2yhkgrxTQf5fZkXgCZ2g24=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.12 24/24] gpio: omap: do not register driver in probe()
Date: Fri, 13 Feb 2026 14:48:43 +0100
Message-ID: <20260213134705.605254012@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134704.728003077@linuxfoundation.org>
References: <20260213134704.728003077@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216196-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: CD41B136BF7
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

commit 730e5ebff40c852e3ea57b71bf02a4b89c69435f upstream.

Commit 11a78b794496 ("ARM: OMAP: MPUIO wake updates") registers the
omap_mpuio_driver from omap_mpuio_init(), which is called from
omap_gpio_probe().

However, it neither makes sense to register drivers from probe()
callbacks of other drivers, nor does the driver core allow registering
drivers with a device lock already being held.

The latter was revealed by commit dc23806a7c47 ("driver core: enforce
device_lock for driver_match_device()") leading to a potential deadlock
condition described in [1].

Additionally, the omap_mpuio_driver is never unregistered from the
driver core, even if the module is unloaded.

Hence, register the omap_mpuio_driver from the module initcall and
unregister it in module_exit().

Link: https://lore.kernel.org/lkml/DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org/ [1]
Fixes: dc23806a7c47 ("driver core: enforce device_lock for driver_match_device()")
Fixes: 11a78b794496 ("ARM: OMAP: MPUIO wake updates")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Link: https://patch.msgid.link/20260127201725.35883-1-dakr@kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-omap.c |   22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -799,10 +799,13 @@ static struct platform_device omap_mpuio
 
 static inline void omap_mpuio_init(struct gpio_bank *bank)
 {
-	platform_set_drvdata(&omap_mpuio_device, bank);
+	static bool registered;
 
-	if (platform_driver_register(&omap_mpuio_driver) == 0)
-		(void) platform_device_register(&omap_mpuio_device);
+	platform_set_drvdata(&omap_mpuio_device, bank);
+	if (!registered) {
+		(void)platform_device_register(&omap_mpuio_device);
+		registered = true;
+	}
 }
 
 /*---------------------------------------------------------------------*/
@@ -1572,13 +1575,24 @@ static struct platform_driver omap_gpio_
  */
 static int __init omap_gpio_drv_reg(void)
 {
-	return platform_driver_register(&omap_gpio_driver);
+	int ret;
+
+	ret = platform_driver_register(&omap_mpuio_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&omap_gpio_driver);
+	if (ret)
+		platform_driver_unregister(&omap_mpuio_driver);
+
+	return ret;
 }
 postcore_initcall(omap_gpio_drv_reg);
 
 static void __exit omap_gpio_exit(void)
 {
 	platform_driver_unregister(&omap_gpio_driver);
+	platform_driver_unregister(&omap_mpuio_driver);
 }
 module_exit(omap_gpio_exit);
 



