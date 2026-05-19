Return-Path: <stable+bounces-249509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKCZLvUwDGpuZAUAu9opvQ
	(envelope-from <stable+bounces-249509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1536757B83C
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83F8A301693D
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F4537DE98;
	Tue, 19 May 2026 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxoYCZ9C"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A63DB65A
	for <stable@vger.kernel.org>; Tue, 19 May 2026 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183428; cv=none; b=i01H7NC+m/euxVwwE78v4OvKCHaGc5jhWZkaljzdp0RzzX8161/tgYZFv5WIuSaGMX+S04pbU4ovRNpWtNeM9aqRTEnUiGLneKCOhzmxU8ISSxtRZaVhEOQF2CrYQNP2/bSF+ouCKkZhZNd19nWQAQvXMKpIVVbd20XCOUsex/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183428; c=relaxed/simple;
	bh=HMLIMtsfl6OLQ7vhtU7AxU0029j1Uze2GS3kI7LukYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chRr/pt3PcPQRpalo62bx2w/sZI3FBkGRoT+kSjDj3RqbgPthgDi8bt00Dwa/CjbHylgQkE010ksNLiyuRSfHygjGSGPdtG7aGrotoaCBu9qX9oHbtW3umdQyvUaJQ59d/yM5MhF6hu7Ck+dHaft6d5v/yvjpEwGuRhN1T17mRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxoYCZ9C; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779183428; x=1810719428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMLIMtsfl6OLQ7vhtU7AxU0029j1Uze2GS3kI7LukYI=;
  b=HxoYCZ9CKLiQyv3NXmK9rqaKB9snmIfSI55QsHjnP0WMK+WxgC0sdhIf
   DgN+cKKFqIVRudWTkp8Ei2DSmtKScuuo0I/pMNMTal9HqHBob1gVfqh7/
   12fQ97rcrMDe7SeFdgbqN4p9uSDIS55VreQBpErf6RdrFCkSHpDupFpX/
   dzWA7t4fmWjxD7a+Zi2whqs0ynkwLUpSrRKIc3++L2fgVhBZy3M//+NoR
   +ds/46qT7Mm4g0VwYHEUVU2ePmNOQbmBuSpAWz6ZBPg2SckgifOZky7CX
   MoLxwIfbXBQYIQVF7h3yfzIBB9QUBqH7Dz4X6aUQa9T7SWtuvufQyCmm6
   g==;
X-CSE-ConnectionGUID: Mo562Fh2Syi5qNmdjafSEg==
X-CSE-MsgGUID: poFvbYbqT1ichUFQuyqBZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83912889"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="83912889"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:06 -0700
X-CSE-ConnectionGUID: 91ZAE7I+Tqyc6i9iCtaNOg==
X-CSE-MsgGUID: 6JaDpcOUS4C6oy8jAJr4aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241551465"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 02:37:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: stable@vger.kernel.org
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Xifer <xiferdev@gmail.com>,
	jodeliukas@gmail.com,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 03/10] resource: Rename 'tmp' variable to 'full_avail'
Date: Tue, 19 May 2026 12:36:26 +0300
Message-ID: <20260519093633.16395-4-ilpo.jarvinen@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249509-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,msgid.link:url,linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1536757B83C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 66475b5dc4e4f88f1ed6f403067e08bd90286af5 upstream.

__find_resource_space() has variable called 'tmp'. Rename it to
'full_avail' to better indicate its purpose.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Xifer <xiferdev@gmail.com>
Link: https://patch.msgid.link/20260324165633.4583-4-ilpo.jarvinen@linux.intel.com
---
 kernel/resource.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 1b8d3101bdc6..8c5fcb30fc33 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -727,39 +727,39 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 				 struct resource_constraint *constraint)
 {
 	struct resource *this = root->child;
-	struct resource tmp = *new, avail, alloc;
+	struct resource full_avail = *new, avail, alloc;
 	resource_alignf alignf = constraint->alignf;
 
-	tmp.start = root->start;
+	full_avail.start = root->start;
 	/*
 	 * Skip past an allocated resource that starts at 0, since the assignment
-	 * of this->start - 1 to tmp->end below would cause an underflow.
+	 * of this->start - 1 to full_avail->end below would cause an underflow.
 	 */
 	if (this && this->start == root->start) {
-		tmp.start = (this == old) ? old->start : this->end + 1;
+		full_avail.start = (this == old) ? old->start : this->end + 1;
 		this = this->sibling;
 	}
 	for(;;) {
 		if (this)
-			tmp.end = (this == old) ?  this->end : this->start - 1;
+			full_avail.end = (this == old) ?  this->end : this->start - 1;
 		else
-			tmp.end = root->end;
+			full_avail.end = root->end;
 
-		if (tmp.end < tmp.start)
+		if (full_avail.end < full_avail.start)
 			goto next;
 
-		resource_clip(&tmp, constraint->min, constraint->max);
-		arch_remove_reservations(&tmp);
+		resource_clip(&full_avail, constraint->min, constraint->max);
+		arch_remove_reservations(&full_avail);
 
 		/* Check for overflow after ALIGN() */
-		avail.start = ALIGN(tmp.start, constraint->align);
-		avail.end = tmp.end;
+		avail.start = ALIGN(full_avail.start, constraint->align);
+		avail.end = full_avail.end;
 		avail.flags = new->flags;
-		if (avail.start >= tmp.start) {
+		if (avail.start >= full_avail.start) {
 			alloc.flags = avail.flags;
 			if (alignf) {
 				alloc.start = alignf(constraint->alignf_data,
-						     &avail, &tmp,
+						     &avail, &full_avail,
 						     size, constraint->align);
 			} else {
 				alloc.start = avail.start;
@@ -777,7 +777,7 @@ next:		if (!this || this->end == root->end)
 			break;
 
 		if (this != old)
-			tmp.start = this->end + 1;
+			full_avail.start = this->end + 1;
 		this = this->sibling;
 	}
 	return -EBUSY;
-- 
2.47.3


