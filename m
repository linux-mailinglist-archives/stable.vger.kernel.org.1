Return-Path: <stable+bounces-263500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +KipEm6bMGppVAUAu9opvQ
	(envelope-from <stable+bounces-263500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:40:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A4668AFC1
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:40:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=intel.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263500-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-263500-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 67E8F300FA9C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 00:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F226E70E;
	Tue, 16 Jun 2026 00:40:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CCA26B0A9;
	Tue, 16 Jun 2026 00:40:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570412; cv=none; b=BbL9gwsasqXdj8Nyh+17KXsJ3EP8bfXygsw069ezy6dQxt8Nfy5GWwAv2UC+OcZxD3vIQJP1ERFQE6jSmxjTD2ZnLjtG5rn0khEUFwRYVia2/hUr0wxLwkyR55hVHlZSwQkiNMTCbYpe6EY1+XRjE+Vd+BlHG6rwsxgogMmJDqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570412; c=relaxed/simple;
	bh=0MkC9oVz7pcU4q6HdydzRJTXQH7mJHogluYw5IUeE9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwCWqJ8HewBeP7X+xFB1mGM1TstC1LCUSBRpiXkjQyzwTUP+qEWh7F1I85jCDt0tN0TW922ENxwzfga9w/vELnGOOZ7GbFplYjLUs1eTFglw3X1b5MJbUj9nsGOEDHltSaM67TmDPmbEVOLFl4UlFn2m06x9mcXXk+INtquAc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C531F00A3A;
	Tue, 16 Jun 2026 00:40:11 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	flavien@nus.edu.sg,
	stable@vger.kernel.org
Subject: [PATCH 1/2] cxl/mce: Validate memdev and endpoint before dereference in cxl_handle_mce()
Date: Mon, 15 Jun 2026 17:40:06 -0700
Message-ID: <20260616004007.4186004-2-dave.jiang@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263500-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,stgolabs.net,intel.com,nus.edu.sg,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-cxl@vger.kernel.org,m:djbw@kernel.org,m:dave@stgolabs.net,m:jic23@kernel.org,m:alison.schofield@intel.com,m:vishal.l.verma@intel.com,m:flavien@nus.edu.sg,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:email,intel.com:mid,intel.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3A4668AFC1

cxlmd and endpoint are both used in cxl_handle_mce() without proper
validation, which can lead to NULL pointer dereference or invalid pointer
dereference. The notifier is registered in cxl_memdev_state_create()
when the CXL PCI driver first binds, before the memdev is published and
before it is attached to a CXL topology.

Add checks to cxlmd and endpoint to ensure they are valid before usage.

Reported-by: Flavien Solt <flavien@nus.edu.sg>
Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mce.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
index ff8d078c6ca1..47566015eb00 100644
--- a/drivers/cxl/core/mce.c
+++ b/drivers/cxl/core/mce.c
@@ -13,7 +13,7 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
 						    mce_notifier);
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
-	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_port *endpoint;
 	struct mce *mce = data;
 	u64 spa, spa_alias;
 	unsigned long pfn;
@@ -21,7 +21,11 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
 	if (!mce || !mce_usable_address(mce))
 		return NOTIFY_DONE;
 
-	if (!endpoint)
+	if (!cxlmd)
+		return NOTIFY_DONE;
+
+	endpoint = cxlmd->endpoint;
+	if (IS_ERR_OR_NULL(endpoint))
 		return NOTIFY_DONE;
 
 	spa = mce->addr & MCI_ADDR_PHYSADDR;
-- 
2.54.0


