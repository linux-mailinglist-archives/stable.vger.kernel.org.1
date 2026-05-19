Return-Path: <stable+bounces-249507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOJzIvIwDGrdZAUAu9opvQ
	(envelope-from <stable+bounces-249507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E118457B82D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFA2730D04E9
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3B73EFFB6;
	Tue, 19 May 2026 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXKPXRn6"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16E1B4F0A
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183412; cv=none; b=V1ayb00FRPR/pNCoQHWfeK/2tkxsPt+w8Ry3W0cKwkAf8DdzCE7p1Ok+WuXqm5LWq7ug9/0crt9e+BEkIQ59d+1TmGTdvsntxcBZCJZjqX91BlR5mIIiMbTfGUenmY0uqhUEkQ5SVE8x3hBEk982xzcLDG/sd/NRr8wbcY768fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183412; c=relaxed/simple;
	bh=VJKt5ZQjsXTpvYdGn8DrgpvlWwwfAnuMrHHdm99kaKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s080SCJVOewTgsA5aUIyvLO8Ja+uQ5fu8iR7CrMNvyuakkQjUx4IEWZOvSI721VtTPfLR+FbOflZcOEDLqFMRAD1Q/UHkWQJ5GJeCSPkVLqtGgDh87aFqTPIXt0BOSAAdeSkxRWkN3o2B/kk2EpBma8EpxvER6wNbPxGtaBVXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXKPXRn6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183411; x=1810719411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VJKt5ZQjsXTpvYdGn8DrgpvlWwwfAnuMrHHdm99kaKQ=;
  b=YXKPXRn6jz5csD4GdnXnQpfqCQpg5IGzrfdOoN9xAO5XLCDv9cqBZ0tp
   b7acCPb+yJx7h6GHM+YM0wh03kc3yK6yVCvjQ8SdrNeUoBghKO79zKN81
   ndW6tIjfJ+vrE0DViv8Pk/W316ZqDqf+n9v6Zc7QEBpX8v5WlxK8Ul8Vr
   alFoSQI2rkHKyBlcQeJ73j7Z/NJGXDBdtyiF1VIRfQKmLKNk5y042PHQl
   JuxvrNQwF7Kbdd3w1xDrjEdVTo6cAgINXffM1bn6eHbfHXSfNnjxO2CVQ
   yLVMp0LOspBbe3Crs0vmHd+YC7x+cUB5ZGxkd9sYDbFo2Dgpj83SlEelS
   A==;
X-CSE-ConnectionGUID: q5/1grTPTBSAK9rgxhRhew==
X-CSE-MsgGUID: MW0mSyzxRZ2O2/2EzOOxsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="67583824"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="67583824"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:36:50 -0700
X-CSE-ConnectionGUID: gOx0MTU8RJa4yBhtJKtRMw==
X-CSE-MsgGUID: 2fD3NpklQdCItNm+MWWS4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="244701634"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:36:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 01/10] resource: Add __resource_contains_unbound() for internal contains checks
Date: Tue, 19 May 2026 12:36:24 +0300
Message-ID: <20260519093633.16395-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
References: <20260519093633.16395-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249507-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[leemhuis.info,gmail.com,linux.intel.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,msgid.link:url,linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E118457B82D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit edfaa81d5da5fbfe3c73fece3ca0417a04cc4ba2 upstream.

__find_resource_space() currently uses resource_contains() but for
tentative resources that are not yet crafted into the resource tree. As
resource_contains() checks that IORESOURCE_UNSET is not set for either of
the resources, the caller has to hack around this problem by clearing the
IORESOURCE_UNSET flag (essentially lying to resource_contains()).

Instead of the hack, introduce __resource_contains_unbound() for cases like
this.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Xifer <xiferdev@gmail.com>
Link: https://patch.msgid.link/20260324165633.4583-2-ilpo.jarvinen@linux.intel.com
---
 include/linux/ioport.h | 20 +++++++++++++++++---
 kernel/resource.c      |  4 ++--
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 5533a5debf3f..19d5e04564d9 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -304,14 +304,28 @@ static inline unsigned long resource_ext_type(const struct resource *res)
 {
 	return res->flags & IORESOURCE_EXT_TYPE_BITS;
 }
-/* True iff r1 completely contains r2 */
-static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
+
+/*
+ * For checking if @r1 completely contains @r2 for resources that have real
+ * addresses but are not yet crafted into the resource tree. Normally
+ * resource_contains() should be used instead of this function as it checks
+ * also IORESOURCE_UNSET flag.
+ */
+static inline bool __resource_contains_unbound(const struct resource *r1,
+					       const struct resource *r2)
 {
 	if (resource_type(r1) != resource_type(r2))
 		return false;
+
+	return r1->start <= r2->start && r1->end >= r2->end;
+}
+/* True iff r1 completely contains r2 */
+static inline bool resource_contains(const struct resource *r1, const struct resource *r2)
+{
 	if (r1->flags & IORESOURCE_UNSET || r2->flags & IORESOURCE_UNSET)
 		return false;
-	return r1->start <= r2->start && r1->end >= r2->end;
+
+	return __resource_contains_unbound(r1, r2);
 }
 
 /* True if any part of r1 overlaps r2 */
diff --git a/kernel/resource.c b/kernel/resource.c
index bb966699da31..1e2f1dfc0edd 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -754,7 +754,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 		/* Check for overflow after ALIGN() */
 		avail.start = ALIGN(tmp.start, constraint->align);
 		avail.end = tmp.end;
-		avail.flags = new->flags & ~IORESOURCE_UNSET;
+		avail.flags = new->flags;
 		if (avail.start >= tmp.start) {
 			alloc.flags = avail.flags;
 			if (alignf) {
@@ -765,7 +765,7 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 			}
 			alloc.end = alloc.start + size - 1;
 			if (alloc.start <= alloc.end &&
-			    resource_contains(&avail, &alloc)) {
+			    __resource_contains_unbound(&avail, &alloc)) {
 				new->start = alloc.start;
 				new->end = alloc.end;
 				return 0;
-- 
2.47.3


