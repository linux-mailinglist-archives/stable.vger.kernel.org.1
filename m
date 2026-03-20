Return-Path: <stable+bounces-227514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFPDAaYfvWnG6QIAu9opvQ
	(envelope-from <stable+bounces-227514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:21:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDDD2D8A18
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E264930055A6
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8952C38A73D;
	Fri, 20 Mar 2026 10:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UvHqS4GP"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2405038D00E;
	Fri, 20 Mar 2026 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002081; cv=none; b=FU2lY0N44I3C2JBzTAI+7StfYW0OM3crpvvTy39mHk6uI1tHHxIhq9O/PqRUlnkYqa0wWs3ultEgSMw1ICn311yFeu5HPLDNVkbZvZY0x9gg+QEY1FG4o6sNuWr3yMtCk5Dbix40DUeobqJ6kAC9vF3ccDhyGOhs7N5BeGIw4vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002081; c=relaxed/simple;
	bh=WGHqbdyR2+lBKnDQcft9sq67hHECCtIjAMRZ7D8+sU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzm81tNuWnUCx+7s52odDA2AykHQwvJk4JtZo2h01aU5OoOIMvnePyPyYy7Br9frwcv+QOQ0VW3GHq1hVDzz3ShpgLcur8fgqiZebEMkdCvOsZzjhBNKpfBMiReEndFn6CgYX9OCsAYTu6a0c0bqiaMRGEnOkHwR96oRnR5dACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UvHqS4GP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9817720B710C;
	Fri, 20 Mar 2026 03:21:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9817720B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774002077;
	bh=19CNB2zQXS8NyoQR5qNGoT4wu6UHVDAwYpwlLon/SGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvHqS4GPXmAwSDsJV2CGD6is6qxrBdEd/fQEFR7lI8bj3Xd6dZm7vYLG74uCkpvy/
	 trJ6I22CHSivKcIXATqAH9wrWduKDeGMq3fDeLt+FmkO8JrlJm+73wniwj6Uz7T8JP
	 gvp8GI4RBGSNbdFn21RUkjW76zSTOgkYFfBLMhXM=
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: ptsm@linux.microsoft.com,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com,
	abhijit.gangurde@amd.com,
	puneet.gupta@amd.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] cdx: Fix double free when sysfs file creation fails
Date: Fri, 20 Mar 2026 03:21:17 -0700
Message-ID: <20260320102117.1554548-1-ptsm@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
References: <20260320101933.1554416-1-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-227514-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BDDD2D8A18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In cdx_create_res_attr(), if sysfs_create_bin_file() fails, the code
frees res_attr but doesn't set cdx_dev->res_attr[num] to NULL. This
leaves a dangling pointer in the array. Then cdx_destroy_res_attr()
frees the already-freed memory. Fix the double free by initializing
cdx_dev->res_attr[num] after sysfs_create_bin_file() completes.

Fixes: aeda33ab8160 ("cdx: create sysfs bin files for cdx resources")
Cc: stable@vger.kernel.org
Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
---
 drivers/cdx/cdx.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 9196dc50a48d..a4e03fb07c4c 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -768,7 +768,6 @@ static int cdx_create_res_attr(struct cdx_device *cdx_dev, int num)
 
 	sysfs_bin_attr_init(res_attr);
 
-	cdx_dev->res_attr[num] = res_attr;
 	sprintf(res_attr_name, "resource%d", num);
 
 	res_attr->mmap = cdx_mmap_resource;
@@ -777,8 +776,12 @@ static int cdx_create_res_attr(struct cdx_device *cdx_dev, int num)
 	res_attr->size = cdx_resource_len(cdx_dev, num);
 	res_attr->private = (void *)(unsigned long)num;
 	ret = sysfs_create_bin_file(&cdx_dev->dev.kobj, res_attr);
-	if (ret)
+	if (ret) {
 		kfree(res_attr);
+		return ret;
+	}
+
+	cdx_dev->res_attr[num] = res_attr;
 
 	return ret;
 }
-- 
2.49.0


