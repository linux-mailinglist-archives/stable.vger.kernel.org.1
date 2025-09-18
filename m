Return-Path: <stable+bounces-168281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB4BB23442
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD18316A6C3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD20E2FDC49;
	Tue, 12 Aug 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PvqWAIzp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7F961FFE;
	Tue, 12 Aug 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023649; cv=none; b=u64M/hYbIEjVVos1K1WJHvsDEDonBMMHLfTODznl9zX2XQ2tqrsjiwjEXACd2mFIcckva7zZPht/lYVYIjTiKQK5+faGLS3meogw+puEm6kwdHnrxeKyf2w7Q6mNYuTXQMMsrHb6I9cXzz0htbvx8d7WZGijMYthSFqhgHGYlFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023649; c=relaxed/simple;
	bh=nqca+J8qgEXaxDimDu6VJDH/P0UXQzTv+XXgncqKHrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSCg7J1IXy7Tfj32u5gSONcW6hYE1BTo77F2AQCP7sM9kH2d97/pI+n6hwxHsu654Gb4w+HCFXApQcZ8vbqpfgH1wBBlh+v2YCEWCBtQ63Wxg96KtEMj/xtA3xVdqX/zmOZw+QuoQdvMOsorWUjc4y2mphyEyre3wecxxBYken0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PvqWAIzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E56FC4CEF0;
	Tue, 12 Aug 2025 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023649;
	bh=nqca+J8qgEXaxDimDu6VJDH/P0UXQzTv+XXgncqKHrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PvqWAIzpPkCEITMmxBJFxpFM3WTCp/Ni5QuUB9lDKzYyXoSpCXVxbs7O+dUQDn5Y2
	 M0deBEiyLE/1mwlWdF11W80GB+pnV7dzjBYd+AgvmPOPCeMobsqjPKNGvGPSY5xb7b
	 2Cf4XzvO5zWeKX0jv81VAaJzGkgZ/XAZTVatf9wE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 142/627] netconsole: Only register console drivers when targets are configured
Date: Tue, 12 Aug 2025 19:27:17 +0200
Message-ID: <20250812173424.697472914@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit bc0cb64db1c765a81f69997d5a28f539e1731bc0 ]

The netconsole driver currently registers the basic console driver
unconditionally during initialization, even when only extended targets
are configured. This results in unnecessary console registration and
performance overhead, as the write_msg() callback is invoked for every
log message only to return early when no matching targets are found.

Optimize the driver by conditionally registering console drivers based
on the actual target configuration. The basic console driver is now
registered only when non-extended targets exist, same as the extended
console. The implementation also handles dynamic target creation through
the configfs interface.

This change eliminates unnecessary console driver registrations,
redundant write_msg() callbacks for unused console types, and associated
lock contention and target list iterations. The optimization is
particularly beneficial for systems using only the most common extended
console type.

Fixes: e2f15f9a79201 ("netconsole: implement extended console support")
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20250609-netcons_ext-v3-1-5336fa670326@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netconsole.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 176935a8645f..a35b1fd4337b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -86,10 +86,10 @@ static DEFINE_SPINLOCK(target_list_lock);
 static DEFINE_MUTEX(target_cleanup_list_lock);
 
 /*
- * Console driver for extended netconsoles.  Registered on the first use to
- * avoid unnecessarily enabling ext message formatting.
+ * Console driver for netconsoles.  Register only consoles that have
+ * an associated target of the same type.
  */
-static struct console netconsole_ext;
+static struct console netconsole_ext, netconsole;
 
 struct netconsole_target_stats  {
 	u64_stats_t xmit_drop_count;
@@ -97,6 +97,11 @@ struct netconsole_target_stats  {
 	struct u64_stats_sync syncp;
 };
 
+enum console_type {
+	CONS_BASIC = BIT(0),
+	CONS_EXTENDED = BIT(1),
+};
+
 /* Features enabled in sysdata. Contrary to userdata, this data is populated by
  * the kernel. The fields are designed as bitwise flags, allowing multiple
  * features to be set in sysdata_fields.
@@ -491,6 +496,12 @@ static ssize_t enabled_store(struct config_item *item,
 		if (nt->extended && !console_is_registered(&netconsole_ext))
 			register_console(&netconsole_ext);
 
+		/* User might be enabling the basic format target for the very
+		 * first time, make sure the console is registered.
+		 */
+		if (!nt->extended && !console_is_registered(&netconsole))
+			register_console(&netconsole);
+
 		/*
 		 * Skip netpoll_parse_options() -- all the attributes are
 		 * already configured via configfs. Just print them out.
@@ -1690,8 +1701,8 @@ static int __init init_netconsole(void)
 {
 	int err;
 	struct netconsole_target *nt, *tmp;
+	u32 console_type_needed = 0;
 	unsigned int count = 0;
-	bool extended = false;
 	unsigned long flags;
 	char *target_config;
 	char *input = config;
@@ -1707,9 +1718,10 @@ static int __init init_netconsole(void)
 			}
 			/* Dump existing printks when we register */
 			if (nt->extended) {
-				extended = true;
+				console_type_needed |= CONS_EXTENDED;
 				netconsole_ext.flags |= CON_PRINTBUFFER;
 			} else {
+				console_type_needed |= CONS_BASIC;
 				netconsole.flags |= CON_PRINTBUFFER;
 			}
 
@@ -1728,9 +1740,10 @@ static int __init init_netconsole(void)
 	if (err)
 		goto undonotifier;
 
-	if (extended)
+	if (console_type_needed & CONS_EXTENDED)
 		register_console(&netconsole_ext);
-	register_console(&netconsole);
+	if (console_type_needed & CONS_BASIC)
+		register_console(&netconsole);
 	pr_info("network logging started\n");
 
 	return err;
@@ -1760,7 +1773,8 @@ static void __exit cleanup_netconsole(void)
 
 	if (console_is_registered(&netconsole_ext))
 		unregister_console(&netconsole_ext);
-	unregister_console(&netconsole);
+	if (console_is_registered(&netconsole))
+		unregister_console(&netconsole);
 	dynamic_netconsole_exit();
 	unregister_netdevice_notifier(&netconsole_netdev_notifier);
 
-- 
2.39.5




