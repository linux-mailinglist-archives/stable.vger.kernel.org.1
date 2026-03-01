Return-Path: <stable+bounces-221892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG9nNO6ao2l4IAUAu9opvQ
	(envelope-from <stable+bounces-221892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:48:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FC01CBD2C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E400C3016D34
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7652C21F7;
	Sun,  1 Mar 2026 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RONaAQEd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF432C032E
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329389; cv=none; b=Hbao5XF5x1sNCP+ugee5q85HhT5cg37iuM9/89uK+LhjWhyIGMd2+FoKZaADoknPHlwxG9s7aA1v9QTpKSGaZmMtj5OMMshp8vwtVPK3gzrqpw6EOl+LdnOszCKrrNV0INjNVI6j1eZycg8Y6aiJ1rnKtJwxy8OynWP0m6+SVbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329389; c=relaxed/simple;
	bh=an+kZH9/bFV851z9SfvggVcsZnA8UHb8F9rX4uJQOn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jj/vxt+W+XLa1a0RD9RXk52DPwh7OOWHwJbFl54K6yBFtjxKTTo6yY9AkCCOwrJR6ZtZP8hXBO+CvwN5T21ph0D7LbVqytxppNW26Df/4DeLyIbvJnCKOWqPJH871OIpIUHNIZQBYy6NVw/Yk7P+ZZcE11vLg2S0kCZFuF5TwpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RONaAQEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE954C19425;
	Sun,  1 Mar 2026 01:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329389;
	bh=an+kZH9/bFV851z9SfvggVcsZnA8UHb8F9rX4uJQOn0=;
	h=From:To:Cc:Subject:Date:From;
	b=RONaAQEdxAdDH6IDDV++AqF2WK0DVmx12jIPgY3FGviCcmEU8M4XGSAnyseVtFgad
	 nN9fmJnWlAMY8usFkiEGXAmDygO5IQdfJggAwqkueM08W8Pa71r1V9VgTtoprdwsvM
	 RBzZdHjyN0F5LHT2TjWfjBKLaGE/ejYxkgTiC0QTX4BEdo2xjDP8idyzPwet0iVGzq
	 S1+pfYTurgqJ2k74vl32rbFQvbd09gfqhutNvbV7uuKwIfrIccgVrq4hxeGZ6Uz/wA
	 xvA+EOGDeQZTtrT5qdjxUwxgS4ifsbChCga7LsHTAO1z3ZiVpmVkqeA3/faYzjJa+1
	 RR5Jy8dYmEBPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dianders@chromium.org
Cc: Lee Jones <lee@kernel.org>
Subject: FAILED: Patch "mfd: core: Add locking around 'mfd_of_node_list'" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:43:07 -0500
Message-ID: <20260301014307.1705140-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221892-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,chromium.org:email]
X-Rspamd-Queue-Id: 63FC01CBD2C
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 20117c92bcf9c11afd64d7481d8f94fdf410726e Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Wed, 10 Dec 2025 11:30:03 -0800
Subject: [PATCH] mfd: core: Add locking around 'mfd_of_node_list'

Manipulating a list in the kernel isn't safe without some sort of
mutual exclusion. Add a mutex any time we access / modify
'mfd_of_node_list' to prevent possible crashes.

Cc: stable@vger.kernel.org
Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20251210113002.1.I6ceaca2cfb7eb25737012b166671f516696be4fd@changeid
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/mfd-core.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6925bedddc80b..a30f93bf030aa 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -22,6 +22,7 @@
 #include <linux/regulator/consumer.h>
 
 static LIST_HEAD(mfd_of_node_list);
+static DEFINE_MUTEX(mfd_of_node_mutex);
 
 struct mfd_of_node_entry {
 	struct list_head list;
@@ -104,9 +105,11 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
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
@@ -128,7 +131,8 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 
 	of_entry->dev = &pdev->dev;
 	of_entry->np = np;
-	list_add_tail(&of_entry->list, &mfd_of_node_list);
+	scoped_guard(mutex, &mfd_of_node_mutex)
+		list_add_tail(&of_entry->list, &mfd_of_node_list);
 
 	of_node_get(np);
 	device_set_node(&pdev->dev, of_fwnode_handle(np));
@@ -284,11 +288,13 @@ static int mfd_add_device(struct device *parent, int id,
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
@@ -358,11 +364,13 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
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





