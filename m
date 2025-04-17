Return-Path: <stable+bounces-134170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A99A9298B
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B943E1B639F3
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE9C2571BA;
	Thu, 17 Apr 2025 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VpmCrAIj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5E2566F7;
	Thu, 17 Apr 2025 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915305; cv=none; b=T+nzDuA/dy7kj0YXCjmUgrNa48UE37GxEKWZnHERYWrDzTTqgos19z7Sf3+MMx1pySUz7F+HpU7/yV9wD40Od7Ljk8yBAU7o/6Vq0BQlI2W5VFRzbgGQ0c1umbP3qsjZ8ZD8H7qVrtohVCUDEa0/QH6tv7JRm2GYru4+27JziiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915305; c=relaxed/simple;
	bh=r9uKmoj5HvGkWQHRAEikIhT+mEv1DaErW0v73I4QXKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiiNWjbsYl2XsmVVpJtKfnJl6yT+J29OcN29Po6H64spPEv/AFQg2uMLBCnzcrI/QrNSIXmWn4sO7Mb0bDHyCqzFy3/FMHu6sUsohS/6RhBvu1PXpUD/WSBqxUvmyZfWtfvLWcVX3edQRY22FwpLjtJI4ICQ6wIyOa0sXkvVn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VpmCrAIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C387C4CEE4;
	Thu, 17 Apr 2025 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915305;
	bh=r9uKmoj5HvGkWQHRAEikIhT+mEv1DaErW0v73I4QXKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpmCrAIjeJenpGQMDeWl7UKqtIG3vCZbXJ7PZCHFTlt00JkDKz2DjtpERhpAqY2/b
	 SXHXq7PlwEp2t01wEYW/8KT45x8b+R+buHfiDL67rxCbbgbn2CKsuRTTmIxIp5AquL
	 N0rxCK1oRhQ1BJIUm5jFdKadVpjUeVIWAvyy97fw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev, Michael Kelley <mhklinux@outlook.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	"https://lore.kernel.org/r/SN6PR02MB415723FBCD79365E8D72CA5FD4D82"@SN6PR02MB4157.namprd02.prod.outlook.com
Subject: [PATCH 6.12 058/393] zstd: Increase DYNAMIC_BMI2 GCC version cutoff from 4.8 to 11.0 to work around compiler segfault
Date: Thu, 17 Apr 2025 19:47:47 +0200
Message-ID: <20250417175109.922533357@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

From: Ingo Molnar <mingo@kernel.org>

[ Upstream commit 1400c87e6cac47eb243f260352c854474d9a9073 ]

Due to pending percpu improvements in -next, GCC9 and GCC10 are
crashing during the build with:

    lib/zstd/compress/huf_compress.c:1033:1: internal compiler error: Segmentation fault
     1033 | {
          | ^
    Please submit a full bug report,
    with preprocessed source if appropriate.
    See <file:///usr/share/doc/gcc-9/README.Bugs> for instructions.

The DYNAMIC_BMI2 feature is a known-challenging feature of
the ZSTD library, with an existing GCC quirk turning it off
for GCC versions below 4.8.

Increase the DYNAMIC_BMI2 version cutoff to GCC 11.0 - GCC 10.5
is the last version known to crash.

Reported-by: Michael Kelley <mhklinux@outlook.com>
Debugged-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: https://lore.kernel.org/r/SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/zstd/common/portability_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portability_macros.h
index 0e3b2c0a527db..0dde8bf56595e 100644
--- a/lib/zstd/common/portability_macros.h
+++ b/lib/zstd/common/portability_macros.h
@@ -55,7 +55,7 @@
 #ifndef DYNAMIC_BMI2
   #if ((defined(__clang__) && __has_attribute(__target__)) \
       || (defined(__GNUC__) \
-          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
+          && (__GNUC__ >= 11))) \
       && (defined(__x86_64__) || defined(_M_X64)) \
       && !defined(__BMI2__)
   #  define DYNAMIC_BMI2 1
-- 
2.39.5




