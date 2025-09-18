Return-Path: <stable+bounces-168007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E44C2B23280
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA437AC3E2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E567C280037;
	Tue, 12 Aug 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XsMuhDzr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A042DBF5E;
	Tue, 12 Aug 2025 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022729; cv=none; b=uoQQwf0YZEG045GjmE84ekYoIMBs6+0Mug64Ouy1m6POyaAGG8ywNYiQcWImFyebOPUT0HvQLqsUrFkFrTv3DYAabSa2g9fh+vcg5S1Q6MMUpry4Hf58225/cap+z22UnctqK/brlk+dVgumD8RM/Wk+7S+4TajpW1B8LrteWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022729; c=relaxed/simple;
	bh=0kKE/VO+Fn/Yccfhq0MdDwTMHQPRDb/GWclzSxgnsRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmyyGC+yUTcpYBGFPBlTcTKCdPhFHDuWnv92b/aZhw+cwIIgICNBE5+HnP2bqsOqaqqd2EZz/wZ/m+CYtsKihylJFHwiMKbtI7pCw2SGAktA8e+AuGGmVNSaChxbXAlYdpbVdcfb7Yc49KbnPbpUdcWeBTOGld3Y20h/z+9+rAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XsMuhDzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF1AC4CEF1;
	Tue, 12 Aug 2025 18:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022729;
	bh=0kKE/VO+Fn/Yccfhq0MdDwTMHQPRDb/GWclzSxgnsRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsMuhDzriyP7E7Qk3No0lXhPn/IsxsGW2qPCUY4TtbCFc9WSMO9F9CIJcAy/gtK8j
	 L8mUBmkMqLf0HiwvhTeRTwPfnIUCytGigYezD7BT55vQ49fJOWqieHiNpuS8Plo7n7
	 Vg6rlSyY5bDzLDu19/KipkiWOF7kAHzEcY5k/sDo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Helge Deller <deller@gmx.de>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 240/369] apparmor: Fix unaligned memory accesses in KUnit test
Date: Tue, 12 Aug 2025 19:28:57 +0200
Message-ID: <20250812173023.803265340@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

[ Upstream commit c68804199dd9d63868497a27b5da3c3cd15356db ]

The testcase triggers some unnecessary unaligned memory accesses on the
parisc architecture:
  Kernel: unaligned access to 0x12f28e27 in policy_unpack_test_init+0x180/0x374 (iir 0x0cdc1280)
  Kernel: unaligned access to 0x12f28e67 in policy_unpack_test_init+0x270/0x374 (iir 0x64dc00ce)

Use the existing helper functions put_unaligned_le32() and
put_unaligned_le16() to avoid such warnings on architectures which
prefer aligned memory accesses.

Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 98c0cc48e27e ("apparmor: fix policy_unpack_test on big endian systems")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/policy_unpack_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index f070902da8fc..a7ac0ccc6cfe 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -9,6 +9,8 @@
 #include "include/policy.h"
 #include "include/policy_unpack.h"
 
+#include <linux/unaligned.h>
+
 #define TEST_STRING_NAME "TEST_STRING"
 #define TEST_STRING_DATA "testing"
 #define TEST_STRING_BUF_OFFSET \
@@ -80,7 +82,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_U32_NAME) + 1;
 	strscpy(buf + 3, TEST_U32_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_U32_NAME) + 1) = AA_U32;
-	*((__le32 *)(buf + 3 + strlen(TEST_U32_NAME) + 2)) = cpu_to_le32(TEST_U32_DATA);
+	put_unaligned_le32(TEST_U32_DATA, buf + 3 + strlen(TEST_U32_NAME) + 2);
 
 	buf = e->start + TEST_NAMED_U64_BUF_OFFSET;
 	*buf = AA_NAME;
@@ -103,7 +105,7 @@ static struct aa_ext *build_aa_ext_struct(struct policy_unpack_fixture *puf,
 	*(buf + 1) = strlen(TEST_ARRAY_NAME) + 1;
 	strscpy(buf + 3, TEST_ARRAY_NAME, e->end - (void *)(buf + 3));
 	*(buf + 3 + strlen(TEST_ARRAY_NAME) + 1) = AA_ARRAY;
-	*((__le16 *)(buf + 3 + strlen(TEST_ARRAY_NAME) + 2)) = cpu_to_le16(TEST_ARRAY_SIZE);
+	put_unaligned_le16(TEST_ARRAY_SIZE, buf + 3 + strlen(TEST_ARRAY_NAME) + 2);
 
 	return e;
 }
-- 
2.39.5




