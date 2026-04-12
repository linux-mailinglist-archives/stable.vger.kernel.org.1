Return-Path: <stable+bounces-235799-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GDoKSlD22mx/AgAu9opvQ
	(envelope-from <stable+bounces-235799-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 09:00:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C173E2F6A
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 09:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB58F302AC2C
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DDA306498;
	Sun, 12 Apr 2026 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLfU1jeD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C741C71
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 07:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775977226; cv=none; b=E0q07gGEXtXkOvbzZIrwlJ5kNTsR8HO3pNo6t0cILO32/62IKgjv1PeM0jTkbx9gmQgXFFrXSsTiKs6pb17Zldjvqat/AiAttR4o2NkR12Cx3e61cHG8kgPI3qW8LtZKHJAw2S3bSpQfVSRWJ4P+Sj6FW9riv7ARs89xhi9QKTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775977226; c=relaxed/simple;
	bh=ad9MM76H3qA9Zm7zGQguyywPJdrDLgkSlTE6M7PNjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KosX6CdIn02Fyq3Ob43jH+CTMLz6ju7JYTrYrykZcJ+g2/ukOZ6pfFS36fm5kO7lWDN1a0kbwKyv4hgA5iNc8ayq4S+zXRRAxYYtzAvnoNxcASqgsjxkzcd2QdlgQnVBaKhYmgaZ/xC6t0y1FBvbwywLzS6gahjvpGOJJVIldVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLfU1jeD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2adff872068so17561565ad.1
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775977225; x=1776582025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agxSRs+wZOd7cJK+5GqSX8xmNcbffxfyow5lUhwJHXU=;
        b=RLfU1jeDB0QcLU6yoq0DSphkvC2ZedtGBQANvfP39al0Xey+Gl2DCzzBaawSQsspmV
         xdAojTbPeexAnx0gXu13GagRZ3pBWXM5UgAj5kG1fEW2iRcqSESQNCfBdj05bGWQrUce
         CoRbqytSTv8jz06gRpn0cfR6H4btauwrL4X9/152Z1/1XqHkQortAMRviBn5da5ihEe+
         JZSzPngIwHcmaPL3IJdMSk5UxRVHzJe92gmPPxzDp9aQ/zHk/pkc9vQVa5uzwsUBGVhX
         6yDMjomF7jaQqRPkYWd6u72ptFaTE7CnPHnzJEMQeAIMSWcZPtBKya5Oir9MNHwWrWCG
         /HPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775977225; x=1776582025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agxSRs+wZOd7cJK+5GqSX8xmNcbffxfyow5lUhwJHXU=;
        b=fJgNUxwuV0Tqn9skk7xdlAMUqwAkwaur1dpWHQkE6pCQAZCYOWGdRim0QHRXZ74DDK
         5hLMp8aiFMYp5tDviu5hf/GZfIyvHBRnhna55dBmJhGxQho954egZhM25O8y+ZFxWgNg
         BMlo/e5gnF/YhAgdpBOjwPWNquVEdCHHjoewzEL9TS8FIiUygwUTYt2BHgtiY8wb8cwt
         EE/oYA/BGy+HJf4dR2b+jYExuxjBICgKexKQpTVWli8vIeyMPjISAbW0SkARxwn7WuTN
         fH6NRMwcb9FCeiwaAGTqtu2MoESh1WY7xaAwVMCGgf0gvEZjC3l2RlJXAEiHn7mP46O2
         5ePA==
X-Forwarded-Encrypted: i=1; AFNElJ/groae9uJDa738dAYMRFezNQU9V02EzpaTmklEsm6F7mRhkqj6jhMyya+t3UckHGV+K867thA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0YbbIJ48I6xEIcAagx50AAnv8svR7CkHUomWSPmijSx9GkAL
	K8SzgKbdUl/iygEitHX+Qrqpi32o3GGUAIWMJ+vOxgLlfTyB/9a+OhAa
X-Gm-Gg: AeBDiesUwwa5BVMco/ziNlXmm7o1TmhhwZ2cNh4kIjcmWBU+mp/wpLrrxKIn+eI/cyA
	oQ6MSxJZvW2f5J4BipUkYnkIQDFP1xIheSQ2n3R7Oc7vFt2dw/43vQ+PQbrSG9EiQ43Xb2QecPa
	JOjLjOLBUNCPvBVxWN4k9kR71/NfK5y0eVNAn/pvLFSCsHLtsg3ZTqlstxZQSMpkxQqRFJkc5kR
	gcxB/7Q4CFL38l5jqSZAIS3L5YdKuNqvLtfz5bHPL2BkDv2clkrSJEkm07yDh4HmcRcS/O9TOu9
	AKroj930BgxCd5vDmqeEDKhO4d8gycdSXJB1wiRTmU3gr5EIpD081uxCeg0xOkn3zbsBiCWJf7o
	c7i+1+8fcS2XSgCot+bekq8nDtfeAMAth80nR2Xu1hxQMqyV1pAaJI/qXNPefJ1mvvNa8JgwkOH
	+du84px4QFQeJRwKnbxWqB
X-Received: by 2002:a17:903:b8e:b0:2b2:647b:a744 with SMTP id d9443c01a7336-2b2d5a584d8mr101853925ad.24.1775977222380;
        Sun, 12 Apr 2026 00:00:22 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45c217ba6sm1798355ad.36.2026.04.12.00.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 00:00:22 -0700 (PDT)
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
Subject: [PATCH v2] device-dax: Fix refcount leak in __devm_create_dev_dax() error path
Date: Sun, 12 Apr 2026 15:00:10 +0800
Message-ID: <20260412070010.2402830-1-lgs201920130244@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235799-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 34C173E2F6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the embedded struct device in dev_dax is
expected to be released through the device core with put_device().

In __devm_create_dev_dax(), several failure paths after
device_initialize() free dev_dax directly instead of dropping the device
reference, which bypasses the normal device core lifetime handling and
leaks the reference held on the embedded struct device.

Fix this by assigning dev->type before device_initialize(), so the
release callback is available, use put_device() in the
post-initialization error paths, and keep dev_dax range cleanup explicit
since it is not handled by dev_dax_release().

Fixes: c2f3011ee697f ("device-dax: add an allocation interface for device-dax instances")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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


