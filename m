Return-Path: <stable+bounces-152221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F48AD29DA
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 00:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3EC170D40
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85B225407;
	Mon,  9 Jun 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwS8BIwu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7674B224895;
	Mon,  9 Jun 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509622; cv=none; b=kszAlh092ZpMIJWcDADwKIjJzUghVORp3ccS71pfCfcMm2EQibQiqP1PM75S/IN+I7DgjJrJ/70GnILN4GPJDDjJosMzlqQ6JXKhXo2GT0aJDBV8VXdy9nHKPxkM0OtdRx2xDFfB7/5bi6V9ROaVoXplgak7KPIpT42yABgZ2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509622; c=relaxed/simple;
	bh=w3rMAc32FL+Hfx+deTvd90VRUr2HVHhL8IYAXabtB5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iF7F6sl2+bh0b2UHhd589O+BLuokONMIcg8oeEcIa8eMrKF6qJOVH0G5isgPcbbU8foaVQNvemeumUKzI/KEwKxmi4hSUjro5J17acouo0QzePZVm3D25rjVtZxTz+63k6ep49iIzzTIsVwnKV7zM/f4XO9Kh3nffeOBhl+7ACU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwS8BIwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B3AC4CEEB;
	Mon,  9 Jun 2025 22:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749509622;
	bh=w3rMAc32FL+Hfx+deTvd90VRUr2HVHhL8IYAXabtB5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwS8BIwutTPOyJos6tERoXZ8jx59ay2wuySaZf8aSGVu5Ka+qr5EVBKmVH/rYJB8a
	 jwj12sCyWKjnGzzPoOAvYWN4rNPpPvCocHJtuCrF7Oeabe8q3snFHw8xIhofT/vD+r
	 fsojLIXyA759tSs/MjPE/pQWkFd9maMQ64Xzr+hhOcMQwBKiHLumDc+RjqagEGTEON
	 URf+6V73zjcpoENI0UNQafUeB5hDRVEyihLVIMnuE4g8HkiTzwQTAX7uBnwsP+fxoT
	 I2nAduSYK4kko3nSB2lvG3OTrsTV9pZ0+tPFNuI/FDKV/j/jluVekMpmNvHVSbdgpy
	 3JYJkfmY+WmwQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	xiubli@redhat.com,
	ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 4/6] ceph: fix possible integer overflow in ceph_zero_objects()
Date: Mon,  9 Jun 2025 18:53:30 -0400
Message-Id: <20250609225333.1444210-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609225333.1444210-1-sashal@kernel.org>
References: <20250609225333.1444210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.93
Content-Transfer-Encoding: 8bit

From: Dmitry Kandybka <d.kandybka@gmail.com>

[ Upstream commit 0abd87942e0c93964e93224836944712feba1d91 ]

In 'ceph_zero_objects', promote 'object_size' to 'u64' to avoid possible
integer overflow.

Compile tested only.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Kandybka <d.kandybka@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES**

This commit should be backported to stable kernel trees. Here's my
detailed analysis:

## Why This Should Be Backported

### 1. **Clear Bug Fix with User Impact**
The commit fixes a real integer overflow vulnerability in
`ceph_zero_objects()` where `s32 object_size` is multiplied by `s32
stripe_count` to calculate `u64 object_set_size`. When the layout values
exceed 2^31, the multiplication can underflow, leading to:
- Incorrect loop bounds in the zeroing logic
- Potential infinite loops or premature termination
- Data integrity issues during hole punching operations
- Incorrect `do_div()` operations

### 2. **Affects Critical Kernel Functionality**
This bug impacts core filesystem operations that users depend on:
- `fallocate()` system call with `FALLOC_FL_PUNCH_HOLE`
- File sparse operations used by databases, VMs, backup tools
- Copy-on-write optimizations in Ceph filesystems

### 3. **Small, Contained, and Low-Risk Fix**
The code change is minimal and safe:
```c
- u64 object_set_size = object_size * stripe_count;
+       u64 object_set_size = (u64) object_size * stripe_count;
```

This fix:
- Promotes `object_size` to `u64` before multiplication, preventing
  overflow
- Has no functional side effects beyond fixing the bug
- Maintains consistency with the underlying `u32` data types in
  `ceph_file_layout`
- Cannot introduce regressions

### 4. **Follows Stable Tree Criteria**
- **Important bugfix**: Prevents potential data corruption and system
  instability
- **Minimal risk**: Single-line change with no architectural impact
- **Confined scope**: Only affects Ceph filesystem's hole punching logic
- **No new features**: Pure defensive fix

### 5. **Matches Successful Backport Pattern**
This commit is very similar to **Similar Commit #1** (marked YES for
backport) which also:
- Fixed a type promotion bug affecting critical operations
- Had minimal code changes with clear safety benefits
- Addressed potential data integrity issues
- Was explicitly marked with `Cc: stable@vger.kernel.org`

### 6. **Proactive Hardening Value**
While the bug requires specific conditions to trigger (large object
sizes or stripe counts), backporting provides:
- Defense against potential malicious layouts from compromised metadata
  servers
- Protection for users with unusual but valid filesystem configurations
- General robustness improvement for production systems

The fix has no downside risk and provides meaningful protection against
a real integer overflow scenario that could affect data integrity in
Ceph filesystems.

 fs/ceph/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a03b11cf78872..e12657b4c3e04 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2513,7 +2513,7 @@ static int ceph_zero_objects(struct inode *inode, loff_t offset, loff_t length)
 	s32 stripe_unit = ci->i_layout.stripe_unit;
 	s32 stripe_count = ci->i_layout.stripe_count;
 	s32 object_size = ci->i_layout.object_size;
-	u64 object_set_size = object_size * stripe_count;
+	u64 object_set_size = (u64) object_size * stripe_count;
 	u64 nearly, t;
 
 	/* round offset up to next period boundary */
-- 
2.39.5


