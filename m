Return-Path: <stable+bounces-235825-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKObIYG922lDGAkAu9opvQ
	(envelope-from <stable+bounces-235825-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 17:42:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4213E48F0
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 17:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF88A3014BC5
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBAA23D7DC;
	Sun, 12 Apr 2026 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BB/oLqz4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257A3D76
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776008553; cv=none; b=ItY2giBdeJfFAecNpSyRkPnwZAVpYOuvNVBJH2ZT4ujc89/GvuWn2W+uQDp7K+GVsrAWy6n4Pt19lw6Sgm8NHzcCA2LJmaJxektIQ9TQNb3rgoLcCgsyfq2BB+Xw6sDLYl82fpiDmVMiRo1NSU7Dcl6wSux1UmxMHrLA5tSEtes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776008553; c=relaxed/simple;
	bh=6EZ4uudlTlmt1z3B9/SeVUJSAjeCc5mAleyjMUXVJWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnnaMjJ9JyafH4fHzTqs/yIL4S6w5Alj7IcuLczUoTILeUxZA77ZColBxW/Vz77LY7qOzxv+gAQRhF4tL49pjnn9UQfSaIhZtmh/p/RnD6gfGD38DuD3E3MKX+2RqyuqMxlUaWOvi7TWVdUipf9qld44uo5yebH02YOvzuHItVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BB/oLqz4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f37c09352so190889b3a.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776008551; x=1776613351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=asIGxvququexs7PTZV6rQ9JxYEOvHAcXSlP0iwqlnoo=;
        b=BB/oLqz4M5PFWj5rIgUf+6acYCwCV2QRUt73FDizWZOFEZYQo6VI/UPRIty80Prl0K
         9GREfmFdbXI3INM93367IDttTY5j0y5vmUFEAAhI4HuR4WYV8Zte6ySpH6cruYgYFxmD
         QOeDTgzKCCoV6qjbGjuVTw6FnmvxCJug8nkx1QoGM952uo//MvUQO2UEcy7C0xnBh4je
         eBU89kbHb5tW0qG+UubMutV2aEG2kbe+XEDqmMvjGdckg/3q5IUdI6iZ+y/rugt8FqY+
         zMpkrmZ5zBs4GKcw/oVYc87gYttnzRMz6TIT92d26prDYsifbM5yksm5aflJLN7m7y7h
         Espg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776008551; x=1776613351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asIGxvququexs7PTZV6rQ9JxYEOvHAcXSlP0iwqlnoo=;
        b=a3CvvOhcTSO9vVL7dqn1ANVI7Ee/54KDMBZXHu/fERxU7r+7G7Q/z0a8IQeBnuRGId
         L1P9UBt0Ddzt3Dj0M7LZgm9M/nHl4bk/ztkOT9asn6QgM7Cp+CKslXALdX5nY2ug0aQK
         9eb3cmtMbCfrK6NBn0+oFTkHy+0IcNsQ4+4mk8alRZKACMb8X1ZWX/UdnI3q9loSZsnf
         RFAirX3C864d8xXSopygdfqKuqeEkAp32WG86KEtIjhxJvE1CVk0x4h7TN42bTICYP+D
         zkMjowfEnW1oZigMwaQaYXOyOtGMip4dPIKF1DHsJ4CEasrem5KmcPkpSqQwC+n/9dkI
         73+A==
X-Forwarded-Encrypted: i=1; AJvYcCXNu9gyzVcY0Wmv8+r3JAYDkcZLvNNLcDcxGD1veOxr03wV1CmW+/34yqVdOVs/wcUep16qqHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwYnv9aJuN0Q3Wv8A84qjV299In10Ka5XVvV+k1xeR6JoTbi48
	ouzlOXoKJV7hDwxx9beUzUTEJ+SKz0iaQJ06LzDzM2N20ZUiB/FKcMPO
X-Gm-Gg: AeBDiesj3TTYYJ67+wyTMGPz7+ZIDiImlNJiqcOHCOYYXXKMNv3FyHc/7HgP7WmOTPk
	V6X2qaZQ6MBrBysO3HlGlgyP+pPCVpJurbCKx5VpsBKNmlYGvJKp4HIo5gM7eNJOl7DPkBVKg0k
	8esmtfEeDd7afLvVYfT6ZRsdpxa+2t1FoWRxnK/y1A87BLNvG7ThhtSWIzXx+b1+HXfrR54VVMJ
	VjvnI+AjEKPpxDKOd7FxXhBo8ek9qtmEeR3Mlg1FMYe00lDuWF93c9S06c6PlgtzOMz9j1W/gAW
	sHYP11junXmokYh8YQAwQpH2T740i9n4+ZFot8Z1uc9OYMxOR0s4VYpuIh8Qj5Ok/IBqehMgIFc
	r+3gxAuwt53d1aAI/nlEr8MdQMMGYex1mXM1fBERKW0FksMMZfEi60xxjnZF/3lMuc9CYBm0bvZ
	6bHGxvP0MbYgRj4oZB32fJh54=
X-Received: by 2002:a05:6a20:728b:b0:395:acfc:b679 with SMTP id adf61e73a8af0-39fc9509e72mr14563770637.18.1776008551078;
        Sun, 12 Apr 2026 08:42:31 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:f515:539:1a62:ab91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921534918sm8255671a12.0.2026.04.12.08.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 08:42:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] md: fix kobject reference leak in md_import_device()
Date: Sun, 12 Apr 2026 23:42:19 +0800
Message-ID: <20260412154219.2560732-1-lgs201920130244@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-235825-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CB4213E48F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

md_import_device() initializes rdev->kobj with kobject_init() before
checking the device size and loading the superblock.

When one of the later checks fails, the error path still frees rdev
directly with kfree(). This bypasses the kobject release path and leaves
the kobject reference unbalanced.

After kobject_init(), release rdev through kobject_put() instead of
kfree().

Fixes: f9cb074bff8e ("Kobject: rename kobject_init_ng() to kobject_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/md/md.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6d73f6e196a9..4ce7512dc834 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3871,6 +3871,9 @@ static struct md_rdev *md_import_device(dev_t newdev, int super_format, int supe
 
 out_blkdev_put:
 	fput(rdev->bdev_file);
+	md_rdev_clear(rdev);
+	kobject_put(&rdev->kobj);
+	return ERR_PTR(err);
 out_clear_rdev:
 	md_rdev_clear(rdev);
 out_free_rdev:
-- 
2.43.0


