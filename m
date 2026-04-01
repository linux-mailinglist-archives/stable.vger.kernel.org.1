Return-Path: <stable+bounces-232756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEjQAKX6zGnRYgYAu9opvQ
	(envelope-from <stable+bounces-232756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:59:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A347378F9A
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A87F13089704
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 10:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B3B3F6613;
	Wed,  1 Apr 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUinOOsy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A293DDDAE
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040994; cv=none; b=Y2O69K8rJu+AciStYZ6Vmaoja8n85AinEAtziqjjEUFVAJpcHuPOtJEkFm+CiLj9kwq0o6WaoC3TE7K5FVW78oWYl/2NEzT1MkNgvHy8lev5Yo9DVVbwnCjrkQulV3jVckLDEYUq9IbAkYusjMbRusTLcueYqDDMirKZo0yvT6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040994; c=relaxed/simple;
	bh=MyXYeM8EOJ+bWpDLvDHhshEwu7kHHDCWmI93VztoV1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTbsqwpFTWbGVeG6xgPsHlv2FvonLN/oVAxLOLZpiT1vGYsBMDeAdt6aoZEYA0ipF7r/wmojOZkA3CMOD86qwFg67VQTHYaIu9+O2uPuDyv7BQA9Y4exuqzZeKAANL/R45cUFrMh9LmWBRqQrFyXjgbhiHruJrEoeZelHzJgHlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUinOOsy; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35c2fe0d90fso3208783a91.1
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 03:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775040992; x=1775645792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmAkJIVOiyu2su4iByfPKFkvSEqhCvUzVY7v1mQwfiI=;
        b=rUinOOsyoZVrTFi8jkClv7cWjcfLOYBk/FI2/VPXzGCmXGnF+lY8ySybDZjU/PX+7m
         0Jfgdv4WnTBW5ErbMFev/wD8UK7TNFpvX4K+MS81UnkL/Vso/XOsk00+02H8GXvHWVI6
         iHs9IFDp5T1yF/wwxyuNl7VizZkywOCRKPltF3vQX+LQ0cz0ppJsLHLbsEytzXfrtyFi
         A+LqP9nff0dcu9tvL97hUA53PpNqk6a2pxtAirB8h7mB9jDBswkDVcA//bNykUBlyR4o
         RrW+YM1ym+47yhtrhHzccdwD8P/Jlab4yFxhNzUOG7YQ44inHOfDnVHz9qAwlFTzoJYo
         5lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775040992; x=1775645792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmAkJIVOiyu2su4iByfPKFkvSEqhCvUzVY7v1mQwfiI=;
        b=fjv/zJzVwJVCiS5rOpRfp0Qkw4GZfQ8dyqaJ5etB3lmLwZzx9CIIlH1nWfBiF11sns
         6PYgyeXrSPNGdgIZg1DEoa6tm2oZ5QtLZKdE9PgUrXT4klzXiTtIm9sB9+EeK7sDM185
         E0gyKyOy8Sjqvl6atvTSPfsbiSYZExYRA48K/+igMK106SG0tVRrBAhSM817WV4VRI7j
         bMIZEifOh6lGZ8pI2iDBqtx0epjxxaOEGUS+9jKS7LQMl4m5wFPNqO5lX14huUZJtAAA
         NhXxu8Gjxkwj3ithD16k2UEQ1j+0+VYyvm1rvJ6sahww87SIW/M9jdPK7z+en6Lt8DBE
         QHOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYAjAiOkBV6Et3hqcvChJpPNbI/gYKiDksdMUL5lKqfeeKfvB+N/7XHtF6zTgxrVpG5oLszVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrof3rlSqqITJj/4Pu0HqlCU3tEPSj6zWTDgwDB6Y8cRAPzwKz
	uCdI54DX+rSMXu1GGyVdmHVgnIFnVxTv/+CrGOoKoSZKA+wiPJtnPwbD
X-Gm-Gg: ATEYQzy3wmGat5nuqzLM8rE4e06fFkMc2fFEt7Kt3gDHjcqFlAgOWGsxf+zU2/dPXJz
	eHM2stdpDCAXUl1pfUzA9MhByRLe4wKoCFjxal/l/9zcy9vXWnKaOfJY9JF7QBnzJ/XSgReJWGW
	R0PYf+VZopUpYXRugCiJzv148/EpoC+eHBWCczUoW70MbTTd7rvjefrp0IC4Oq1QpiJC552Vkjd
	OW+MtBVGM/o1e8m03ynGCdm1PK2KDF+X9uoVLKHoLPjFqVhvO4DisrK8U+4/j5vDx6otPOwIjt4
	f5eOHyYXcYgjeaXRL5YBpPdriUP0D/IOFTOIrMdj+68PVnSajpmD/IiMd/PKt1BJiIXSp9Y2WiL
	goWoemRyFzeliHcN69oKcou996iaNSDf0ZUkgL1CHk/oN6bIq82WGRt67IPg9edDQzqaPpb6yE7
	kAnPmCV9gofP3WWWYOTyri
X-Received: by 2002:a17:90b:510d:b0:35a:18b1:c239 with SMTP id 98e67ed59e1d1-35dc6e9a466mr2738424a91.10.1775040991785;
        Wed, 01 Apr 2026 03:56:31 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba63e80bsm1679868a91.4.2026.04.01.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 03:56:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] btrfs: fix double free in create_space_info() error path
Date: Wed,  1 Apr 2026 18:56:19 +0800
Message-ID: <20260401105619.1506398-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232756-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[fb.com,suse.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 9A347378F9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When kobject_init_and_add() fails, the call chain is:

create_space_info()
-> btrfs_sysfs_add_space_info_type()
-> kobject_init_and_add()
-> failure
-> kobject_put(&space_info->kobj)
-> space_info_release()
-> kfree(space_info)

Then control returns to create_space_info():

btrfs_sysfs_add_space_info_type() returns error
-> goto out_free
-> kfree(space_info)

This causes a double free.

Keep the direct kfree(space_info) for the earlier failure path, but
after btrfs_sysfs_add_space_info_type() has called kobject_put(), let
the kobject release callback handle the cleanup.

Fixes: a11224a016d6d ("btrfs: fix memory leaks in create_space_info() error paths")
Cc: stable@vger.kernel.org
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - add the full failure path to the changelog

 fs/btrfs/space-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3f08e450f796..d7176eb2fcbf 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -311,7 +311,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 
 	ret = btrfs_sysfs_add_space_info_type(space_info);
 	if (ret)
-		goto out_free;
+		return ret;
 
 	list_add(&space_info->list, &info->space_info);
 	if (flags & BTRFS_BLOCK_GROUP_DATA)
-- 
2.43.0


