Return-Path: <stable+bounces-152132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B038AD1FF6
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E5B3B0966
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B7813CF9C;
	Mon,  9 Jun 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVeH3On/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88B25A2CD;
	Mon,  9 Jun 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476853; cv=none; b=lPda5JH30tIvCHC2PUp2jqLDTxbOgLa+eql7QpJZrW+MW95aDSugrtzeFF/4re59DHDK15qwY7M4Pf/YBCCmCSDio5g7eDRvbDJUkWHEwH2S05bAesp+uvB2u84zB3J5YbTCEYrpXhAzh+bBPBUrPgS8hZj/w6JLGrF497hwUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476853; c=relaxed/simple;
	bh=n9hEVNd8tHOgjn/9oeG6CKb1eZrPMuGpoadrEMuYz4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g78cVuOBWGYPZtA3W4pF6KlWd4fVpf2OupDUaHxA/sc4PlWJKxnXLv2ebUK+ZZP2ls+hxazkRDiKShdhQrvcsyLn5gW0TXqWU4PLboejakU52tJAU3tiN6haXFRyS86XOvgGzc1Jh36zP567vAMKJLNPfgZrapHb+6sHkB/vJ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVeH3On/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25831C4CEED;
	Mon,  9 Jun 2025 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476853;
	bh=n9hEVNd8tHOgjn/9oeG6CKb1eZrPMuGpoadrEMuYz4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVeH3On/Pp6IRz5+m2FrByuSmjAdVG2XU/fmcP6aGht2cDcOzMdOdQHfM9j9geFQ9
	 dleg05Ybu8bK8VLRAAMMK9Bheen5g3ur3J0ff2uKz5EJRtgoWuQD9Ol4KLzwQZzIGg
	 SWbN1t9wOI0/1XkRQXoD0X8y3B1EauwcsN5V2ENEn/q4XNMux3gWGDUQyDPCL220AR
	 /ndsRrN9lL9OIqz1DAfEFJJn9ztX1kdBlchZb4rJqJP3idOLeQEAaTebFjt9L4Mhxa
	 i/7jc3RTlwhFCrciw/CB5+JHvdqKKpskbXbauKitwYUgPdh7x5jJCzNtEg0EjqrYv0
	 Q2VBEKypGPv/A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Sasha Levin <sashal@kernel.org>,
	marcelo.schmitt1@gmail.com,
	mazziesaccount@gmail.com,
	javier.carrasco.cruz@gmail.com,
	peterz@infradead.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH AUTOSEL 6.1 04/16] iio: pressure: zpa2326: Use aligned_s64 for the timestamp
Date: Mon,  9 Jun 2025 09:47:13 -0400
Message-Id: <20250609134725.1344921-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134725.1344921-1-sashal@kernel.org>
References: <20250609134725.1344921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.141
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 886a446b76afddfad307488e95e87f23a08ffd51 ]

On x86_32 s64 fields are only 32-bit aligned.  Hence force the alignment of
the field and padding in the structure by using aligned_s64 instead.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Link: https://patch.msgid.link/20250413103443.2420727-19-jic23@kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis, here is my determination:

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Critical Bug Fix**: The commit fixes a subtle but serious alignment
   bug that can cause **buffer overruns** on 32-bit architectures. The
   original code uses a plain `u64 timestamp` field in the sample
   structure, which is only guaranteed 4-byte alignment on x86_32 and
   other 32-bit architectures.

2. **Security Impact**: As shown in the
   `iio_push_to_buffers_with_timestamp()` function at line `((int64_t
   *)data)[ts_offset] = timestamp;`, the code performs a 64-bit write at
   a calculated offset. If the buffer is only 4-byte aligned but the
   offset calculation assumes 8-byte alignment, this can result in:
   - Buffer overflow beyond the allocated structure
   - Memory corruption of adjacent stack variables
   - Potential information leaks to userspace

3. **Pattern of Similar Fixes**: Looking at similar commits:
   - Commit #2 (mprls0025pa: use aligned_s64) was marked for stable with
     `Fixes:` tag
   - Commit #5 (ms5611 Fix buffer element alignment) was marked for
     stable
   - The analysis document shows this is part of a systematic campaign
     to fix these issues since 2020

4. **Small, Contained Change**: The fix is minimal - simply changing
   `u64 timestamp` to `aligned_s64 timestamp`. This ensures the
   timestamp field is properly 8-byte aligned through the `__aligned(8)`
   attribute, preventing any alignment issues.

5. **Architecture-Specific Vulnerability**: The bug specifically affects
   32-bit architectures where s64 has only 4-byte natural alignment.
   This makes it a real issue for ARM32 and other 32-bit platforms still
   in use.

6. **Recent Related Security Fix**: The same file had a recent security
   fix (commit 6007d10c5262) for information leaks, showing this driver
   has active security concerns that need addressing in stable trees.

The commit follows the stable tree rules perfectly: it fixes an
important bug with minimal changes and low regression risk. The
alignment issue can cause actual crashes or data corruption on affected
architectures, making it a clear candidate for stable backporting.

 drivers/iio/pressure/zpa2326.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index fdb1b765206bc..7f352a79c1a55 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -582,7 +582,7 @@ static int zpa2326_fill_sample_buffer(struct iio_dev               *indio_dev,
 	struct {
 		u32 pressure;
 		u16 temperature;
-		u64 timestamp;
+		aligned_s64 timestamp;
 	}   sample;
 	int err;
 
-- 
2.39.5


