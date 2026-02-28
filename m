Return-Path: <stable+bounces-220740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YF9VDo9Do2li+wQAu9opvQ
	(envelope-from <stable+bounces-220740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:35:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 630E01C72A6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A299C31918DE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0916C401D34;
	Sat, 28 Feb 2026 17:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeI3rUr/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0277401D2B;
	Sat, 28 Feb 2026 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300620; cv=none; b=HvPPCu7HzfIcxFyCSeovks7yiG4YEtQEl1qSnPFy1TUQn39h9gtDNhqG6X77F0/3GByoTAT0Mtkm+1K8giCCPVa3qxNETiEvaFE3lmy9rA9dAxyJGbuYfXDTjmHBPKcHNoj6hO62s4nvTeD9sMjjazJ1zQMbah6e5bbniUYY+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300620; c=relaxed/simple;
	bh=D69dLqnG4kE0GPvxaIQ4APaQPnLIBI7aapXZ5ZXWLI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZPvKMJeO3DXz751XQLGePgHg8iajqLPP759xlmLeHxe6RlZLimFbsB1HL0k6UJjwgzcKiwA71/QEAJNo9TDDriT5Q6jg2FAPbEqlqbhgkt4GVk/yn3pMgpsIhIVVPWx64TDa/1aM7FDQGf2FiHf1q/4DaNHMPJC7kOHsfLog28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeI3rUr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C50C116D0;
	Sat, 28 Feb 2026 17:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300620;
	bh=D69dLqnG4kE0GPvxaIQ4APaQPnLIBI7aapXZ5ZXWLI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QeI3rUr/A6I0buPeai/H/ikMWhiGnV55gPMoDQfIP9NciKDVb0dttI2+MwLVFFz16
	 DQFWqo1i5eHDm8jh9lkU6m71u65PzYc76w081tKlZIN81/QgjcRnAOEnLMsXT9faTR
	 s0u9eNYhQ8tup82AAZWxyvmUJBhoZhduOzE5xz4n6sDGRTSAkyHcpacR9VC7ocrYhj
	 qJPIrztz/MSSvZH9SgF+ePUue6StwtVz14AswRwPq7hLTdSdmd4WDqZ1T0pDpuEiiF
	 AqJDKIctuf5ztIaIDho0TgldLpTL7J/zF9MdFpmGxPVf3KPRkXC14MHBOIxmG8ecNs
	 CdYAwK7KfzSXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 661/844] mfd: core: Add locking around 'mfd_of_node_list'
Date: Sat, 28 Feb 2026 12:29:34 -0500
Message-ID: <20260228173244.1509663-662-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220740-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 630E01C72A6
X-Rspamd-Action: no action

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 20117c92bcf9c11afd64d7481d8f94fdf410726e ]

Manipulating a list in the kernel isn't safe without some sort of
mutual exclusion. Add a mutex any time we access / modify
'mfd_of_node_list' to prevent possible crashes.

Cc: stable@vger.kernel.org
Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20251210113002.1.I6ceaca2cfb7eb25737012b166671f516696be4fd@changeid
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/mfd-core.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 7d14a1e7631ee..c55223ce4327a 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -22,6 +22,7 @@
 #include <linux/regulator/consumer.h>
 
 static LIST_HEAD(mfd_of_node_list);
+static DEFINE_MUTEX(mfd_of_node_mutex);
 
 struct mfd_of_node_entry {
 	struct list_head list;
@@ -105,9 +106,11 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 	u64 of_node_addr;
 
 	/* Skip if OF node has previously been allocated to a device */
-	list_for_each_entry(of_entry, &mfd_of_node_list, list)
-		if (of_entry->np == np)
-			return -EAGAIN;
+	scoped_guard(mutex, &mfd_of_node_mutex) {
+		list_for_each_entry(of_entry, &mfd_of_node_list, list)
+			if (of_entry->np == np)
+				return -EAGAIN;
+	}
 
 	if (!cell->use_of_reg)
 		/* No of_reg defined - allocate first free compatible match */
@@ -129,7 +132,8 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 
 	of_entry->dev = &pdev->dev;
 	of_entry->np = np;
-	list_add_tail(&of_entry->list, &mfd_of_node_list);
+	scoped_guard(mutex, &mfd_of_node_mutex)
+		list_add_tail(&of_entry->list, &mfd_of_node_list);
 
 	of_node_get(np);
 	device_set_node(&pdev->dev, of_fwnode_handle(np));
@@ -286,11 +290,13 @@ static int mfd_add_device(struct device *parent, int id,
 	if (cell->swnode)
 		device_remove_software_node(&pdev->dev);
 fail_of_entry:
-	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
-		if (of_entry->dev == &pdev->dev) {
-			list_del(&of_entry->list);
-			kfree(of_entry);
-		}
+	scoped_guard(mutex, &mfd_of_node_mutex) {
+		list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
+			if (of_entry->dev == &pdev->dev) {
+				list_del(&of_entry->list);
+				kfree(of_entry);
+			}
+	}
 fail_alias:
 	regulator_bulk_unregister_supply_alias(&pdev->dev,
 					       cell->parent_supplies,
@@ -360,11 +366,13 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	if (cell->swnode)
 		device_remove_software_node(&pdev->dev);
 
-	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
-		if (of_entry->dev == &pdev->dev) {
-			list_del(&of_entry->list);
-			kfree(of_entry);
-		}
+	scoped_guard(mutex, &mfd_of_node_mutex) {
+		list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
+			if (of_entry->dev == &pdev->dev) {
+				list_del(&of_entry->list);
+				kfree(of_entry);
+			}
+	}
 
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
-- 
2.51.0


