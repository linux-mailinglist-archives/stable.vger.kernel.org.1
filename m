Return-Path: <stable+bounces-195490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51334C787F5
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 11:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 76B6136710
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1DC2D8766;
	Fri, 21 Nov 2025 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JfzNSQ4U"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1B72ED16B
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719505; cv=none; b=jZ6YKT3x8nePb0Fx+V5iX9hErZtPO1QQfmdPfivjY/F1c2LUaXGz/45hUR0HJtD7QxdIwV8go6TORo8b+5smiceHEdSssmd9kZNnzTLNbP3dUhZ4eSsjmsUdSz7JNzbImXxKl8gcLUWtm/tEJveY4UyRvulYUDQfIDXFiSaTWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719505; c=relaxed/simple;
	bh=NNbhXflv5R2vEixobq/WA2G1uBqr//AH3LROjVRZg2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MuLmWMAf4m6mvX7+SufG9k9WGHhEy2K4XT9BUy4KZOXO21Aisf5Bopa4ZbUDOF0n6slC6mfzUxMK4jXSJLObmaz5eVmDcDPqwMjZsjxD0x4L+0ZbeU5gXX3jXV9wNysHK3oJlrtQRQNf+PILQF/axfq9kQFPB6xWxQ9fAxKYHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JfzNSQ4U; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so12740595e9.0
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 02:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763719497; x=1764324297; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kYHDN3XWhdrUYswWPNAoZZ7SN5o3+zAlN+kFhNb/5Zw=;
        b=JfzNSQ4UhwlOBH9D2AIByvtjhu5cftluWC4dUqTdrN+sZsMppKRTBPVPgJm1WqxxOR
         l2pLxaLQnJqrkahJUuXIVtLrhqly97D3MTNSELQ3ABFwxZ/l08SMeW6p+mojpWGvND3z
         nm8iwwEM+tr2BhvK+uo7Mv/LygO/aU7IaIu52bEjGDtMFBPGm1lLjHWOJTFehnmVMuoI
         V6WtfUJvG3WKE4F4TrFJWYE2D9LQHSUV0vtuOAWVgzQaDo1VMD9FMry9VfWUHw/JBua8
         +CV5zUJV5AiPvfiJAsWkTZEL9ISo/DifpSNWISGHf3G4GfZdMq5Ome19lNCzyuFwOiD8
         g3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719497; x=1764324297;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYHDN3XWhdrUYswWPNAoZZ7SN5o3+zAlN+kFhNb/5Zw=;
        b=EkumNhBDV/ppFRTk0qiOrozNBJJ0HSyjOsHiJ3DMphQBncFmSfI8OgAn2MYKj/z1cF
         evBU/EckKTJbFhvDwum700oMwfoQxC/zuq2HwGwJeNSwUo6nFK1bkC7+/rlFYE47qmtE
         o0LX6YNOkqVSfOwqsj0NBbujSxHVYmbAC6LzMLjFgCKyefszciR/+yok3yQ0CVq8mLxB
         YHVOI96BWH/MtTKXG6cZCD+7y9JbQXIWb/N0sCLDiuAn+wgyqYAwvgkSEnxn9PMYIp4d
         2UchgaB6pUGN5VesFPchhtRu8BkImsdFDQzMqI55tOGTf5zVnhXnISvUYTCcousVa5i6
         9aWg==
X-Forwarded-Encrypted: i=1; AJvYcCVbEcO89RwrcT1ebZbRQ3Wcw8NisPHsMmhHUe8S7IEmci393myTzwIe4D+UcXZRZJf+1jLg4SM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyj3bnsE/yA5P4b2ay16OAExXhYFA0dBCXAtdh13MgPv2GC4Fz
	AkNdTGIz/MZ/XSixxVhgmvcTRLHCY5sbtWkTk7IXHrml+V0OXkQyAgnABbiExxsf0q0=
X-Gm-Gg: ASbGnctbWCfZvJeHol+9PFiTjSBqsc0HtIa74gckOEAG0WJiCJFX9q878sqdyhwM1bm
	01eXPkM6+gSqM3icdlXESP7z1USvAgL1Bvx4YwdCbPlxp4O0xJ4uIM02AfTvC5tiYSOcnEbZ2DB
	di1kU2uAgB7QYxeJ9KyGl9YgbkHoHblC+uOQN43DO6c+Ua70G298Br/W2liS+btvSCNnX/J7LnR
	zN0KmOn0s3d22zLBS2fVZUB/oCiDIvX8t3gtGFERXOrWv4OpRoIMbBwEK1wfJiJNbKfqGh3BuY0
	M+zbdfoY/uC3j9Oe5hxy7dk9DYO3xh3TtNL6LtRmC97HYFoLyXkFucpFnyM5/bYfznOaovyZFOg
	1mttfX8X6Yy/V7fd5KjwSDQekIrRd27QdfbG2mAAsBxhjOzAAWqFKPtBKNLDbESevu16JE6U34T
	YkJlxnvA==
X-Google-Smtp-Source: AGHT+IElB02/Ep10lh/BdZNWOZ9UNe38Adz4Jl7bRbLXN2uP/3XG5Ln17dAUNkGE9BVFgHs6RC5NGw==
X-Received: by 2002:a05:600c:450f:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-477c10c84b8mr13860705e9.2.1763719497047;
        Fri, 21 Nov 2025 02:04:57 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ab1f:63b4:bcef:12ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a973390csm81773385e9.4.2025.11.21.02.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:04:56 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Nov 2025 11:04:50 +0100
Subject: [PATCH] platform/x86: intel: chtwc_int33fe: don't dereference
 swnode args
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-int33fe-swnode-fix-v1-1-713e7b7c6046@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEE5IGkC/x2MywqAIBAAfyX23IKPFOtXooPkVnvR0Kgg+vek4
 wzMPFAoMxUYmgcynVw4xQqybWDefFwJOVQGJZSRUknkeGi9EJYrpkC48I3keht8Z5yxAmq4Z6r
 6n47T+346GurqZAAAAA==
X-Change-ID: 20251121-int33fe-swnode-fix-e896da458560
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4348;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=9xVvg4mqL3TmJeRf+mIeyELW8a1RoZesNOGIJ+GdEnw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpIDlEX/VgktNV+bsy2NxBqjCK5duKZTAMJa7fj
 0jMweZ04CaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaSA5RAAKCRAFnS7L/zaE
 w1bPD/9RfxiKvUpDCwYrGdj+Icl4v2zSnwkHsEEIyrVtF3KvQG7UI8S+BgVClRg7dBgGGvLZB2h
 vXhgRcnD8Hvzh3kK1TNEZpCmnUaRfMR50+TkP3ga9JG83k4dy0KG++KHmrrdf3gjpaiFqFAI6qF
 LR8xytBXigkPSAmg90sSnN1rXuJnLGnSbeB7tKc5uzjLIq7c3nNXOXTDWSfY0XeiC0wvlsC2B4f
 kW1gmOroFNN7742gzCdqWGQInnMhYBhMCjhxT+olvWoJj0eHu5J2qsMwhDUHNvwfMi/vxjXf81e
 7zx1G82I9L17/cbj4Q7MM/9AIg/lRbvrE6e2lurYvvQpwJ1xbufKKs8mPyn0QdHp6jB3Tv2mXlo
 11VEpFEBNCXmX+s8vue4A6Iuf+/8m32qxWksBVieYb+C84Zzh16Frce6Agdi4q7aZIfwu0tZqYR
 5IXbs+7puPT3B9gKMdYntCYQ09qptG+EFB3PcY9gIYTkbP/mGSM63tW54UGgk+YO8g9lBV4nHpF
 lfbLGAkJiMMFDdjI670h8okJhIrxx+lW7htSNfEzdxN8NZG5Erj/ZzIxzhE4mmzx4xN/gJfhRyD
 oaa2OYpDG5/7ZnB8AmAOa8V1nr0z9ASFFXgUf5HhYSpbo+wbg5bShzGCxaX8aiOhbYcTlsh/RMG
 /skRf2I+9HI1fxA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Members of struct software_node_ref_args should not be dereferenced
directly but set using the provided macros. Commit d7cdbbc93c56
("software node: allow referencing firmware nodes") changed the name of
the software node member and caused a build failure. Remove all direct
dereferences of the ref struct as a fix.

However, this driver also seems to abuse the software node interface by
waiting for a node with an arbitrary name "intel-xhci-usb-sw" to appear
in the system before setting up the reference for the I2C device, while
the actual software node already exists in the intel-xhci-usb-role-switch
module and should be used to set up a static reference. Add a FIXME for
a future improvement.

Fixes: d7cdbbc93c56 ("software node: allow referencing firmware nodes")
Fixes: 53c24c2932e5 ("platform/x86: intel_cht_int33fe: use inline reference properties")
Cc: stable@vger.kernel.org
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20251121111534.7cdbfe5c@canb.auug.org.au/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
This should go into the reset tree as a fix to the regression introduced
by the reset-gpio driver rework.
---
 drivers/platform/x86/intel/chtwc_int33fe.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
index 29e8b5432f4c9eea7dc45b83d94c0e00373f901b..d183aa53c318ba8d57c7124c38506e6956b3ee36 100644
--- a/drivers/platform/x86/intel/chtwc_int33fe.c
+++ b/drivers/platform/x86/intel/chtwc_int33fe.c
@@ -77,7 +77,7 @@ static const struct software_node max17047_node = {
  * software node.
  */
 static struct software_node_ref_args fusb302_mux_refs[] = {
-	{ .node = NULL },
+	SOFTWARE_NODE_REFERENCE(NULL),
 };
 
 static const struct property_entry fusb302_properties[] = {
@@ -190,11 +190,6 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 {
 	software_node_unregister_node_group(node_group);
 
-	if (fusb302_mux_refs[0].node) {
-		fwnode_handle_put(software_node_fwnode(fusb302_mux_refs[0].node));
-		fusb302_mux_refs[0].node = NULL;
-	}
-
 	if (data->dp) {
 		data->dp->secondary = NULL;
 		fwnode_handle_put(data->dp);
@@ -202,7 +197,15 @@ static void cht_int33fe_remove_nodes(struct cht_int33fe_data *data)
 	}
 }
 
-static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
+static void cht_int33fe_put_swnode(void *data)
+{
+	struct fwnode_handle *fwnode = data;
+
+	fwnode_handle_put(fwnode);
+	fusb302_mux_refs[0] = SOFTWARE_NODE_REFERENCE(NULL);
+}
+
+static int cht_int33fe_add_nodes(struct device *dev, struct cht_int33fe_data *data)
 {
 	const struct software_node *mux_ref_node;
 	int ret;
@@ -212,17 +215,25 @@ static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
 	 * until the mux driver has created software node for the mux device.
 	 * It means we depend on the mux driver. This function will return
 	 * -EPROBE_DEFER until the mux device is registered.
+	 *
+	 * FIXME: the relevant software node exists in intel-xhci-usb-role-switch
+	 * and - if exported - could be used to set up a static reference.
 	 */
 	mux_ref_node = software_node_find_by_name(NULL, "intel-xhci-usb-sw");
 	if (!mux_ref_node)
 		return -EPROBE_DEFER;
 
+	ret = devm_add_action_or_reset(dev, cht_int33fe_put_swnode,
+				       software_node_fwnode(mux_ref_node));
+	if (ret)
+		return ret;
+
 	/*
 	 * Update node used in "usb-role-switch" property. Note that we
 	 * rely on software_node_register_node_group() to use the original
 	 * instance of properties instead of copying them.
 	 */
-	fusb302_mux_refs[0].node = mux_ref_node;
+	fusb302_mux_refs[0] = SOFTWARE_NODE_REFERENCE(mux_ref_node);
 
 	ret = software_node_register_node_group(node_group);
 	if (ret)
@@ -345,7 +356,7 @@ static int cht_int33fe_typec_probe(struct platform_device *pdev)
 		return fusb302_irq;
 	}
 
-	ret = cht_int33fe_add_nodes(data);
+	ret = cht_int33fe_add_nodes(dev, data);
 	if (ret)
 		return ret;
 

---
base-commit: cba510406ba76569782ead6007a0e4eb5d34a7ab
change-id: 20251121-int33fe-swnode-fix-e896da458560

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


