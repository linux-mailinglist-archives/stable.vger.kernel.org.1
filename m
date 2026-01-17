Return-Path: <stable+bounces-210137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6CDD38D4F
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 10:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 970363022AAD
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AE3333436;
	Sat, 17 Jan 2026 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFYlQ8zV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98610FD
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768641167; cv=none; b=uq+hFgb7nEKndEBnYjk4jkTlXJz0Y0TUWLDMaQiyfInTrch7VnAjU5A3e3lAntJ/y0jPmULyPbOsJdhPeh5aGghGZYjIzQ75UEFBsRA8IC6dD+O+pwvTU2Iu94EaKPzrUCvLMSxSlyPMbpc3/Hk1StjKFDz1+9mPlH9cIZBjN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768641167; c=relaxed/simple;
	bh=azcZbVnhaqcYPvbtuV79VjUbEUhlxyg9oKvTSqV9gl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gQR+Ia5xQgreWkCxMrp37ADZsgNC/se2Tb/WwQ/jQQoW+sd2A3X7fDgTTSHA5hX5gq+cfxHPyONFyAo10dB1PgiBUGQ+1G9GoTqPWzo3qAoDSz4LvHLMObUjvbQrF2DAfcMwNFk0ihwYfPk2TS+3nasmwo3PnK5AjshYKWe9YHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFYlQ8zV; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81f4e136481so1330808b3a.3
        for <stable@vger.kernel.org>; Sat, 17 Jan 2026 01:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768641165; x=1769245965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+JCaXQ16amp6hMUtWaxk+pdDmeoh4XrN4ClHnLFtuU=;
        b=CFYlQ8zVvcV/aDW8KaILOl140CViD0BHjmCM8+VhFpO9q1KoJqeKGl6DIoVHCN74US
         uHNtVlGI66NbtqfDZcSZRSTT6ngAScXGyEZjlhFhuP7tun9wgvBOXAC6f5tbnqLpyALf
         yoYm/r0B1zoizXS35LDnVxCra1ZXxyLjigZmCXEPHZKW2LiAP7FHgOkPZ8AAK/oepLUM
         AWv1YZmiWy2uX/nY7SqPKLmnxk+8ug5iK9UZ0vIQ3s6kS1vISguJMfaIvyeU0BFc6BnO
         ybKYVhtRuMXOU6AZua4/2CiT/ySdhEfrFH6MkAzgKA3yfuxYAgtoRn6+YU0fOKr0CQ7D
         5iIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768641165; x=1769245965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+JCaXQ16amp6hMUtWaxk+pdDmeoh4XrN4ClHnLFtuU=;
        b=YkX0wDLeoyCShRBxl2YjS8oRKTGg69IKIqmP8PfAn4lnEGNw2FSZys8EuDUQCeggF6
         MAhmdmHlAE5D2T1TymCnGhJJSkTA3AwkZY6cQ1xiXi3+yLXAHsfqaUBgVNIqj/tAPeEP
         9Krbtx1Qeqo1SBJIiMi0n0VvglnzEYDBn2I/ZY6iNk8b9FXRUSC9jCSJ2J7vzlP6c2M2
         NtPnK08JV8FkzpVfXV2Rr6bwlf7YSQ2sNXO4KDRizQB9/ArMhNrXMgJIyQ19uULC0uAu
         PgVEjDt9ZJ8DdKxYltxYxreBp4sOZU4/6fwvawdvcpDhkrV76f8nVAgAXVT3ljwHPHEM
         xfrg==
X-Forwarded-Encrypted: i=1; AJvYcCVTzqR/gAwNTu+PMENf9nCghlxGDvJGZFxQ5tX9gM570PVgyOo8EHgG+HLjBQyHnH0ARo/Goz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPIFP2DDtrs19SgF0LQJSsW2n3jAs2xraNo/gigfE5WzPqTie
	vjhTY7pf6AquUQmIr/sHuNFH2+ufEc8ztTOyref5B0o+xszjyUkMbuK/
X-Gm-Gg: AY/fxX6pPgGaaDQGFeIlnV5l6KDQh7OURpejv4giy2kNxBUGQGhWjxevAli0S5TIRrw
	TrUoaRYBPRitH4xcP3Ne9wGgZkGK+X9WqeD0Ax77J97+MEz8x4zxbj1ezrSZroUu99etF9dIna1
	hO+J4dFkNS9EYPkEPW5WbR8NaCB/ITBWRWU+NTRpDpxdxBWJE84tKenGCjc9gWLSKq/wuDGotco
	CATRZ2L+N7y1X38PRJieqjzcP75F5PcA4AnbouLyKYieg29NzsE3n+5WxNHCAMamBfriiorrtEM
	uw19n1tpXD9orOXOTRw8RjQ9aIuzXPABAB1u7mhRBYr0SunJEOsSrYaT1/rj13R4kEp/5JkcR+0
	5Crhdcr73UwcciFuEaVMgnxKku7Tt1t3+Qw8vgqPYrifx2zfossnJKaP9iOap5JjL+BBk2N2LRG
	N0TOnQ31XqOHyiDhZdgb97IdenIsuO5Cx3l8cnF3LG0M1KUmNxG19TKPEmJEgF34RTMUAOVr6MT
	ZptWueghkgDy7DukAN68ajifljCeWOlCRtI/RNoDTw1JVU=
X-Received: by 2002:a05:6a00:2e09:b0:819:bad0:11c6 with SMTP id d2e1a72fcca58-81fa1881497mr4768446b3a.66.1768641164762;
        Sat, 17 Jan 2026 01:12:44 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1278460sm4021131b3a.38.2026.01.17.01.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 01:12:44 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: robh@kernel.org,
	saravanak@google.com
Cc: grant.likely@secretlab.ca,
	shawn.guo@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>
Subject: [PATCH] of: fix reference count leak in of_alias_scan()
Date: Sat, 17 Jan 2026 09:12:38 +0000
Message-Id: <20260117091238.481243-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_find_node_by_path() returns a device_node with its refcount
incremented. When kstrtoint() fails or dt_alloc() fails, the function
continues to the next iteration without calling of_node_put(), causing
a reference count leak.

Add of_node_put(np) before continue on both error paths to properly
release the device_node reference.

Fixes: 611cad720148 ("dt: add of_alias_scan and of_alias_get_id")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/of/base.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 0b65039ece53a..57420806c1a2b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1942,13 +1942,17 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 			end--;
 		len = end - start;
 
-		if (kstrtoint(end, 10, &id) < 0)
+		if (kstrtoint(end, 10, &id) < 0) {
+			of_node_put(np);
 			continue;
+		}
 
 		/* Allocate an alias_prop with enough space for the stem */
 		ap = dt_alloc(sizeof(*ap) + len + 1, __alignof__(*ap));
-		if (!ap)
+		if (!ap) {
+			of_node_put(np);
 			continue;
+		}
 		memset(ap, 0, sizeof(*ap) + len + 1);
 		ap->alias = start;
 		of_alias_add(ap, np, id, start, len);
-- 
2.34.1


