Return-Path: <stable+bounces-116354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A6A353D0
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 02:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D5B7A16D1
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 01:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA04586324;
	Fri, 14 Feb 2025 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BTEnjzar"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC539FD9
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739497199; cv=none; b=Fvxc1Z6Hqf1gRWl1agxYoHVB+4DKi3wvuPOx6VD/WJoW9f2KDcycxZXz9ko8BbqHoiSoPmfQQNi8QBKq7YT1jmjj3KVAEX2eXpCAYLujs3MSWZ12thfJc+K+yYIaYC5WqBsM8d1cJ5BsKiTRFo1QowtkWCj+r9oyNTJ3QjHrjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739497199; c=relaxed/simple;
	bh=nfP4yEj2vL6ycDB2Fk0sO0HXVXlyHmxmwJ3kr+6xh3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oxeVOtrQp7oN9TFHTED7qa9TBMbhdTlO//d8c7UxsUjtG4UQaObv7CUvFnXGmLy50GPcvnXH4GRxcVllHuGMrrYeHr+sKN5WC3mY2BCKei0R8K+dECB7UAL8HL282GTSlxbC04mWTqkRBO9kMxsCYrjaUAmp62+H0aY95BIo+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BTEnjzar; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43961ded371so28335e9.0
        for <stable@vger.kernel.org>; Thu, 13 Feb 2025 17:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739497195; x=1740101995; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j3rEr2PzHksO3Fsv/Zkc3QLfv1bYecXc0QZkWn8OD/Y=;
        b=BTEnjzarvcLT2lesiPvBw4Vm2J2V9ZErklfm6YWFta3EI+kSIkd9R/A9AS+fUP9Hna
         DsDCUcT1QN+9sHH8hRvqlIHhnGjXZ6tCwxu8H+jCAaU4xX9704DBZehaQnlm3CZoyk76
         rT9+45xVgVBM9lsJ0Peo/aItPvO0ADmr0A6DqPWh6t1iWPVGM21BoIenejPbbuJT4row
         FnQBgeaWK/1w8V6IT0s69RuP3ERBuR3WO7uQYvKAzCOwrMeTAUjqW2pisX52I2nFEK/9
         H33kB2zMqYQDk6Nm3vpaoPHQ0VwUcgFxdAJj7wWgsO1V8MvAdVkLImiYcIuWdL1WDZNO
         FQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739497195; x=1740101995;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3rEr2PzHksO3Fsv/Zkc3QLfv1bYecXc0QZkWn8OD/Y=;
        b=WNPCdxcsv7e6ybrIETlYYBOSA2h9qFMSOJVbqE14CJ3/dWAf6utPGzRwBMf9X9GuLJ
         GwGGpqhd/i+Um0Gduj8X6e7XS7oWuRgKuyOQmh/VpGfYi/zDjh4JVLq8VDprPTT9Drly
         MHpCj1PEzKa9IPapriTn44M1O5RA8+Gnf6vLPpEaagFuKzYay/LP7lHp010bxme8JiXW
         SMtPQNYh7AkwuCms9l7T3hOxVWOUAlmpYNSifXp4YUvcMZja4l+g2IRSZw0g3DFwuT1H
         mup8FWDFFOxe9C4lSjmzXOnXtqwcXDn7bdzI2wWNxHPMfRoKc6GeoaoIvqvkAgM2Lmyl
         0MCg==
X-Forwarded-Encrypted: i=1; AJvYcCU/kRxgJSB/sazi8wyo84Vf+XfDlwFUCsGjJ6ejIuNG/YIJ7kzadVk4kKXea2gXxhX8/NdM2M4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wkgiUc+mhltUT8VmzuGDozHO6HZGKAw3/BGfp2vqhQ0OlKhD
	XVuGK3/Cww/b3PvW0FgKCKJ2cmGXBzXudQar1BGzGdHiRI53uSrGnRlcgU14Bw==
X-Gm-Gg: ASbGncu5Qos3Juj5aozSbIy6Nj1XfP8RTafksEYZAWrAB9GmcSISJoKw21BkO96vR6N
	OhIkwphIuAoi+Yc/sRhDX7zRJLMXNGJWEVZmIGWSkbhAW+D4THMnNS3DzhQz46mUzhCT36T43gw
	umJS6vTAm3t6jnKkG49+OKYfF3lIe9rV7dHAlSVSiAYlJfj4ifeyAAU8sZ8C7/p7PlV5KceKHpG
	w7QL4c1hkGMBEHKlqWEIntNqdpFJVY7JICzwUnSgditVVDgbxAM3+ey+zftIdwMPEoX1uq5PLuc
	btJl
X-Google-Smtp-Source: AGHT+IERNn2wQZnS5W4hVQgg0jAgZlRsgDb+R9ON8DjwxOfnnnOh9Q5LS2mFbZr333r1gnG0bzGl5g==
X-Received: by 2002:a05:600c:6d19:b0:439:33c5:3872 with SMTP id 5b1f17b1804b1-43968364d78mr307105e9.5.1739497194866;
        Thu, 13 Feb 2025 17:39:54 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:fe28:cd9e:e03f:148e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961811315sm31377985e9.20.2025.02.13.17.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 17:39:54 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Fri, 14 Feb 2025 02:39:50 +0100
Subject: [PATCH] partitions: mac: fix handling of bogus partition table
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-partition-mac-v1-1-c1c626dffbd5@google.com>
X-B4-Tracking: v=1; b=H4sIAOWermcC/x2MQQqAIBAAvyJ7TtDNCvpKdBDbag+ZqEQg/j3pO
 DAzBRJFpgSzKBDp4cS3b6A7Ae60/iDJW2NAhYNCbWSwMXNulrysk0iT1saNiNhDa0Kknd//t6y
 1fiw47kBfAAAA
X-Change-ID: 20250214-partition-mac-2e7114c62223
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739497190; l=2407;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=nfP4yEj2vL6ycDB2Fk0sO0HXVXlyHmxmwJ3kr+6xh3g=;
 b=BV6zLc/d4z/D4NFAJ6tQJUcbU1o7Ri6FlL0LcWrpZEjcQxmvcFpXFJ8pS2zBfplOgKW4yhvJG
 dCLE32yp6MTB29egbiz4hhVQPEMdLnu9G4PPeY4ztgUBWeGVxoE1GkB
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Fix several issues in partition probing:

 - The bailout for a bad partoffset must use put_dev_sector(), since the
   preceding read_part_sector() succeeded.
 - If the partition table claims a silly sector size like 0xfff bytes
   (which results in partition table entries straddling sector boundaries),
   bail out instead of accessing out-of-bounds memory.
 - We must not assume that the partition table contains proper NUL
   termination - use strnlen() and strncmp() instead of strlen() and
   strcmp().

Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 block/partitions/mac.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index c80183156d68020e0e14974308ac751b3df84421..b02530d986297058de0db929fbf638a76fc44508 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -53,13 +53,25 @@ int mac_partition(struct parsed_partitions *state)
 	}
 	secsize = be16_to_cpu(md->block_size);
 	put_dev_sector(sect);
+
+	/*
+	 * If the "block size" is not a power of 2, things get weird - we might
+	 * end up with a partition straddling a sector boundary, so we wouldn't
+	 * be able to read a partition entry with read_part_sector().
+	 * Real block sizes are probably (?) powers of two, so just require
+	 * that.
+	 */
+	if (!is_power_of_2(secsize))
+		return -1;
 	datasize = round_down(secsize, 512);
 	data = read_part_sector(state, datasize / 512, &sect);
 	if (!data)
 		return -1;
 	partoffset = secsize % 512;
-	if (partoffset + sizeof(*part) > datasize)
+	if (partoffset + sizeof(*part) > datasize) {
+		put_dev_sector(sect);
 		return -1;
+	}
 	part = (struct mac_partition *) (data + partoffset);
 	if (be16_to_cpu(part->signature) != MAC_PARTITION_MAGIC) {
 		put_dev_sector(sect);
@@ -112,8 +124,8 @@ int mac_partition(struct parsed_partitions *state)
 				int i, l;
 
 				goodness++;
-				l = strlen(part->name);
-				if (strcmp(part->name, "/") == 0)
+				l = strnlen(part->name, sizeof(part->name));
+				if (strncmp(part->name, "/", sizeof(part->name)) == 0)
 					goodness++;
 				for (i = 0; i <= l - 4; ++i) {
 					if (strncasecmp(part->name + i, "root",

---
base-commit: ab68d7eb7b1a64f3f4710da46cc5f93c6c154942
change-id: 20250214-partition-mac-2e7114c62223

-- 
Jann Horn <jannh@google.com>


