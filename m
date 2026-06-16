Return-Path: <stable+bounces-263501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zChkOlmcMGoDVQUAu9opvQ
	(envelope-from <stable+bounces-263501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:44:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8A068B036
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:44:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=intel.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263501-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263501-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9563313D42A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 00:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A5E2673AA;
	Tue, 16 Jun 2026 00:40:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC131DF254;
	Tue, 16 Jun 2026 00:40:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570414; cv=none; b=Y+l/E3eIqcDuK/muN5ZvG2GKxp9NdQnnVZVuI1n3N/6fRHxTxIYcOI+JD7tTw2jNy/lE8CgheHjKfcGUmyQ1IHeQyXOk2Cqt/Ox10XOqBOwNS2o39Ewi/OiGqTIxcyvKCs/SrbQOJ5BI3Ox/EguFFSzA0ZtvVq45kehxQ6pY0v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570414; c=relaxed/simple;
	bh=y64Hdsminmjx9W7ytFK33QvspXrgwqvY1MAxeWoKCYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8mgYFpbktLHEwgxnQL2sY+4VPJN9BtB8r5VAX7RV4CmiAtaZyCcAVNTWSyCM2Qg24OFO6Y0i+AlUyE9Hal9Ppgb5NEhG70IrMJX1SCRAqGXlryKLuX5eyW0NElNeKPyJUIWTkNvTBJyA1nVkeTm7rXa9GPJEgL5LyBaoG7dFm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46CE1F000E9;
	Tue, 16 Jun 2026 00:40:12 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	flavien@nus.edu.sg,
	stable@vger.kernel.org
Subject: [PATCH 2/2] cxl/mce: Serialize the MCE handler against endpoint teardown
Date: Mon, 15 Jun 2026 17:40:07 -0700
Message-ID: <20260616004007.4186004-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616004007.4186004-1-dave.jiang@intel.com>
References: <20260616004007.4186004-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263501-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,stgolabs.net,intel.com,nus.edu.sg,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-cxl@vger.kernel.org,m:djbw@kernel.org,m:dave@stgolabs.net,m:jic23@kernel.org,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:flavien@nus.edu.sg,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E8A068B036

CXL endpoint has a shorter lifetime than CXL memdev state (mds) and
the MCE notifier is part of the mds. The MCE handler needs to take
a reference on the endpoint in order to keep it alive while operating
on it. Take the cxlmd lock to verify the endpoint is still valid and
take a reference on it before accessing it.

Reported-by: Flavien Solt <flavien@nus.edu.sg>
Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mce.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
index 47566015eb00..e684e411921b 100644
--- a/drivers/cxl/core/mce.c
+++ b/drivers/cxl/core/mce.c
@@ -7,13 +7,27 @@
 #include <cxlmem.h>
 #include "mce.h"
 
+static struct device *cxlmd_get_endpoint_dev(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+
+	if (!cxlmd)
+		return NULL;
+
+	guard(device)(&cxlmd->dev);
+	endpoint = cxlmd->endpoint;
+	if (IS_ERR_OR_NULL(endpoint))
+		return NULL;
+
+	return get_device(&endpoint->dev);
+}
+
 static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 			  void *data)
 {
 	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
 						    mce_notifier);
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
-	struct cxl_port *endpoint;
 	struct mce *mce = data;
 	u64 spa, spa_alias;
 	unsigned long pfn;
@@ -24,8 +38,13 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	if (!cxlmd)
 		return NOTIFY_DONE;
 
-	endpoint = cxlmd->endpoint;
-	if (IS_ERR_OR_NULL(endpoint))
+	/*
+	 * With the cxlmd device lock held, check the cxlmd->endpoint pointer
+	 * and then take a reference of the device in order to keep it alive
+	 * while accessing it.
+	 */
+	struct device *dev __free(put_device) = cxlmd_get_endpoint_dev(cxlmd);
+	if (!dev)
 		return NOTIFY_DONE;
 
 	spa = mce->addr & MCI_ADDR_PHYSADDR;
@@ -34,7 +53,7 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	if (!pfn_valid(pfn))
 		return NOTIFY_DONE;
 
-	spa_alias = cxl_port_get_spa_cache_alias(endpoint, spa);
+	spa_alias = cxl_port_get_spa_cache_alias(to_cxl_port(dev), spa);
 	if (spa_alias == ~0ULL)
 		return NOTIFY_DONE;
 
-- 
2.54.0


