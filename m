Return-Path: <stable+bounces-216465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIvkDqLcj2l+UAEAu9opvQ
	(envelope-from <stable+bounces-216465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 03:23:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BCD13AC4C
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 03:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05DC7303C29B
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEBB1DE8AE;
	Sat, 14 Feb 2026 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA58MA7f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD278F59
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 02:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771035800; cv=none; b=nqdeNpV730G0ZyY8xQrqWKWfhzvhOpDE70sQlgk/zqyIrQaZ77XXDZVCQaRAfZcqvgh/o6cG+/0lLegsDWri7pDYhr5GFwiyK1He4RPJu8LijdTXMVv81b4PAPj8jVzzKzG12NyOxYRxDP6wXFl1fNNIl9tp2Mgw5U4QD7oZ9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771035800; c=relaxed/simple;
	bh=WaMW8U+mpgAIb1/bBuL3OQGoL1Qb9vs6UXI9i1ZMF9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNRwj+WEt98XrgcqZGlMEOi5FFhmrX3mOmmQoXHtBaekj/t6iAuB+KbDtLxPXfZr6upBvT2X2SHKk/y2rJBEloZa/6JJHQ194HrNnExZpCimHfXc7qRDUGxAxW64ubutnySNlE2bZEqzAeHI2fdrcmBOZ00xHap6Ep0HuMVemg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA58MA7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E145C116C6;
	Sat, 14 Feb 2026 02:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771035800;
	bh=WaMW8U+mpgAIb1/bBuL3OQGoL1Qb9vs6UXI9i1ZMF9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA58MA7f2/yHfZ6diKQNPeqo1d/dJIbCPwnp8So0TXUYvm/pPtUSvLSlx1EkwQdVk
	 KAXKT6tft69T9QV6zhwuNPim1S7b4Fr9/4x0h7rmMCrO73B4nOAHnl5xTfB5dViK1o
	 eiKQOh6sSOFrPjEtNLah0OsC+RmY3S+mAN5kYaj21T57zEIDxPfAfkRcE9C6vsrFEY
	 rEc2Yypf5oim5O7rgUqKJqijt7OLr0qFoYKcZQ3irQpP5rp6i4yHfEIl7+q/FQKVYu
	 5J1WdgezRdzGOeIrR+m9vm9DVxjj3sMdx6mcKLZcSlOL5OKXEEnoSAiisCTeTb2777
	 iHOAMT2aackxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Liu Song <liu.song13@zte.com.cn>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] PCI: endpoint: Avoid creating sub-groups asynchronously
Date: Fri, 13 Feb 2026 21:23:15 -0500
Message-ID: <20260214022316.4103092-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214022316.4103092-1-sashal@kernel.org>
References: <2026021308-foil-sycamore-7994@gregkh>
 <20260214022316.4103092-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216465-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zte.com.cn:email,msgid.link:url,cfs_work.work:url]
X-Rspamd-Queue-Id: 65BCD13AC4C
X-Rspamd-Action: no action

From: Liu Song <liu.song13@zte.com.cn>

[ Upstream commit 7c5c7d06bd1f86d2c3ebe62be903a4ba42db4d2c ]

The asynchronous creation of sub-groups by a delayed work could lead to a
NULL pointer dereference when the driver directory is removed before the
work completes.

The crash can be easily reproduced with the following commands:

  # cd /sys/kernel/config/pci_ep/functions/pci_epf_test
  # for i in {1..20}; do mkdir test && rmdir test; done

  BUG: kernel NULL pointer dereference, address: 0000000000000088
  ...
  Call Trace:
   configfs_register_group+0x3d/0x190
   pci_epf_cfs_work+0x41/0x110
   process_one_work+0x18f/0x350
   worker_thread+0x25a/0x3a0

Fix this issue by using configfs_add_default_group() API which does not
have the deadlock problem as configfs_register_group() and does not require
the delayed work handler.

Fixes: e85a2d783762 ("PCI: endpoint: Add support in configfs to associate two EPCs with EPF")
Signed-off-by: Liu Song <liu.song13@zte.com.cn>
[mani: slightly reworded the description and added stable list]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@kernel.org
Link: https://patch.msgid.link/20250710143845409gLM6JdlwPhlHG9iX3F6jK@zte.com.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/pci-ep-cfs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d8fe8a2d8e433..9fb35cf023316 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -23,7 +23,6 @@ struct pci_epf_group {
 	struct config_group group;
 	struct config_group primary_epc_group;
 	struct config_group secondary_epc_group;
-	struct delayed_work cfs_work;
 	struct pci_epf *epf;
 	int index;
 };
@@ -100,7 +99,7 @@ static struct config_group
 	secondary_epc_group = &epf_group->secondary_epc_group;
 	config_group_init_type_name(secondary_epc_group, "secondary",
 				    &pci_secondary_epc_type);
-	configfs_register_group(&epf_group->group, secondary_epc_group);
+	configfs_add_default_group(secondary_epc_group, &epf_group->group);
 
 	return secondary_epc_group;
 }
@@ -160,7 +159,7 @@ static struct config_group
 
 	config_group_init_type_name(primary_epc_group, "primary",
 				    &pci_primary_epc_type);
-	configfs_register_group(&epf_group->group, primary_epc_group);
+	configfs_add_default_group(primary_epc_group, &epf_group->group);
 
 	return primary_epc_group;
 }
@@ -522,15 +521,13 @@ static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
 		return;
 	}
 
-	configfs_register_group(&epf_group->group, group);
+	configfs_add_default_group(group, &epf_group->group);
 }
 
-static void pci_epf_cfs_work(struct work_struct *work)
+static void pci_epf_cfs_add_sub_groups(struct pci_epf_group *epf_group)
 {
-	struct pci_epf_group *epf_group;
 	struct config_group *group;
 
-	epf_group = container_of(work, struct pci_epf_group, cfs_work.work);
 	group = pci_ep_cfs_add_primary_group(epf_group);
 	if (IS_ERR(group)) {
 		pr_err("failed to create 'primary' EPC interface\n");
@@ -589,9 +586,7 @@ static struct config_group *pci_epf_make(struct config_group *group,
 
 	kfree(epf_name);
 
-	INIT_DELAYED_WORK(&epf_group->cfs_work, pci_epf_cfs_work);
-	queue_delayed_work(system_wq, &epf_group->cfs_work,
-			   msecs_to_jiffies(1));
+	pci_epf_cfs_add_sub_groups(epf_group);
 
 	return &epf_group->group;
 
-- 
2.51.0


