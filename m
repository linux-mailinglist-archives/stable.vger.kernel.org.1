Return-Path: <stable+bounces-236093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM8cIAf33Gl/YgkAu9opvQ
	(envelope-from <stable+bounces-236093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:00:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 139783ECE12
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B1CE303266A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFED3CEB82;
	Mon, 13 Apr 2026 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVhPRJuD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA53CB2C1
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088604; cv=none; b=MQ4aPHH4OwGhlKN7bSpM8LZ5nOsKVXqK9ykd1vDrFDiF8/1ZZpt4f19+dsbwspu/Yc+lIlYVEclVWlA+fIcgKZteh8ybdHiO1dXHZR0zMpK1XTGcq948UiMM7Zma87Kf4CoNQ3FI87DbhjCJZnCqt60u6Fogp0WfrnBXc38SJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088604; c=relaxed/simple;
	bh=Hpvv+IN2EELEEcnD5YwW84ys/b/L7dP7YW1BRzo/t8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F9QDNXgFpgIFOCcTfizu14un2fFMENFLrmHvGmR/Okr38C1Yj+Yj6+2SS5MTyZqv2ubewwFSSsp/8slR2eGQILT6gaAIS7POOcaYQglJB4gVOo23SpaBuM2uNH89Q/8ratGiFgjWAvmBmRMGFTB8JObxI+PZFmxbAtl0PVnH1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVhPRJuD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c648bc907ebso3180443a12.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776088602; x=1776693402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwI7fhoIYuDnAceYOXsnx6dLQgMpnwbjObgo8mwaSj4=;
        b=kVhPRJuDq7yFzsHSk2U9Vb5efnwz6LzIgQSv9kE4LTe1GsvjMdpKz89Hg2pDWkHXdA
         sTTYSQBzdsv8N8HXDedTb7q159RjfBKKZ+cI/rKMSZFhIUpEnPYkL9G8CU4arhq7KEg+
         dZc7njBroO+FiLHvMYTi8tldCTI8JZ1aShsHXodD52bzww56ToamtqpCbd9dG1AXTa9m
         dDhTwzF6veIMjzpK6rhqDnIRMglcz7bLvOYijIXdZSVFcpOhk539mR4qS5BzQ/tqrWoS
         g5Pwi8W85anYs6EdOymUqRBLNFH443TSmQ+xkDrBSM+CBlcA9x86Osg0OVa88qZ7EdHR
         28JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776088602; x=1776693402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwI7fhoIYuDnAceYOXsnx6dLQgMpnwbjObgo8mwaSj4=;
        b=LiB945qWwgbZtNFHCZ3IEZvU3MRo8u4wVutBiZyFlPPhs010od/isD+fXK9E37TBAW
         oLLVEt9Enyap6CwT2VnifGLgiqYEWcV98JNczMDOVSR2USjhF9S18FCbTATAckkdXK3V
         xgZL7/bWLk5OrHCTH2ef7MKYCqse8lcuWq011J0K8P6OSkEXESU+nGJJpZThcVnAcqwk
         s2AexIRsGemxEbyQjDC/sdOm743VhYgPLxbWg6Il0egXuHwj83V9+ba3x1Ww1mV6B6OX
         jpQnIoO0RQm6aUvKKPMsPLY1QzGnWMSDgzh2U21ZohouIYxNIALenryzvLaMMgKPvWqU
         aAqw==
X-Forwarded-Encrypted: i=1; AFNElJ/P2gK1mYfyjfPzWSIEOiMD6BtsYsRnkWbWg6jr8B1Cnq7MS+wZOHa1TXLjz+XpMNB+NgTz2po=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnCjL6c5Kwv4uFeJdmT1pHLORb1+FjpVnPlSJoxAxaepzvMVy2
	mz0wjSijmGp/HVA7g9SIiijk7sVMUdmk4QGX0NiaIpdk29MAF0AbnnV1
X-Gm-Gg: AeBDietJBqzG7583cTSjKYU2ilSJ2CbqMp1NWjDRdizT144MZb5NucnR/DA3T1MsaXl
	qiTiEta+9V9mg86Teze1TFFs65t1NtJSbVEGd55YrpWkgMVVmeiWreegCyqP2N75zbpYqmbRpbC
	FbfH1qqoG5v4Pl6uBYCcse1IjVw7yCm4LWXD9FjMy0aVuEUhGpBOBUHKBvwObSFNRWYXzxl0E3V
	W0QmlDH8io+Ps/ShNkiL/PeElFHbe8NGblYyrGb2du1H9JblRCL7pTWdPSizHiNe85XX8hrUIne
	LSevcID8/GmvtfNRDo8jayWHcRXjtAA9xMhh0BQPBqmt13aHu7rooBGYUn109YyiGTthM7Bv6BS
	7QDkNrFAPOJruOl1Wm3SDPCsi0RJ4DgENyXwnisjd+hQQ/m3xqvuiXVmpVmBZhR25CGBEsEGiyC
	qw8c2trLga6eUygE2Xo3x5xYVYYw6h8Nw=
X-Received: by 2002:a17:902:b698:b0:2b2:aa93:cc5f with SMTP id d9443c01a7336-2b2d597609dmr100423715ad.10.1776088602230;
        Mon, 13 Apr 2026 06:56:42 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b468273ccfsm12585665ad.43.2026.04.13.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:56:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] device-dax: Fix refcount leak in __devm_create_dev_dax() error path
Date: Mon, 13 Apr 2026 21:56:25 +0800
Message-ID: <20260413135625.2890908-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-236093-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 139783ECE12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the embedded struct device in dev_dax is
expected to be released through the device core with put_device().

In __devm_create_dev_dax(), several failure paths after
device_initialize() free dev_dax directly instead of dropping the device
reference, which bypasses the normal device core lifetime handling and
leaks the reference held on the embedded struct device.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by assigning dev->type before device_initialize(), so the
release callback is available, use put_device() in the
post-initialization error paths, and keep dev_dax range cleanup explicit
since it is not handled by dev_dax_release().

Fixes: c2f3011ee697f ("device-dax: add an allocation interface for device-dax instances")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

v2:
  - clarify the commit message around the device reference leak
  - drop the unsupported use-after-free claim
  - set dev->type before device_initialize() so put_device() can use the
    release callback on post-init failures
  - simplify the post-initialization error paths to use explicit range
    cleanup plus put_device()

 drivers/dax/bus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..2d92674d0d6e 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1453,6 +1453,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	}
 
 	dev = &dev_dax->dev;
+	dev->type = &dev_dax_type;
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
@@ -1499,7 +1500,6 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	dev->devt = inode->i_rdev;
 	dev->bus = &dax_bus_type;
 	dev->parent = parent;
-	dev->type = &dev_dax_type;
 
 	rc = device_add(dev);
 	if (rc) {
@@ -1522,14 +1522,13 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	return dev_dax;
 
 err_alloc_dax:
-	kfree(dev_dax->pgmap);
 err_pgmap:
 	free_dev_dax_ranges(dev_dax);
 err_range:
-	free_dev_dax_id(dev_dax);
+	put_device(dev);
+	return ERR_PTR(rc);
 err_id:
 	kfree(dev_dax);
-
 	return ERR_PTR(rc);
 }
 
-- 
2.43.0


