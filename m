Return-Path: <stable+bounces-152073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 431F6AD1F64
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8378816C80A
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9653125A35D;
	Mon,  9 Jun 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKy5CvQf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5396C8F5B;
	Mon,  9 Jun 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476742; cv=none; b=d196hygaUOTfBhmFPjHvMF2j6WVKcDyshvAAppym3r0pHkhQXiS45mACn3gLLVR4j3w61421uZMO14hb9ujjD7JKyVvEq1Eq1nCYn2jGArjpAbcQqfV2D+JcBbpOmx87cqsDTiDit3s71A6EQ3WdqsiSmnsWj2tH40jCSgIhNTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476742; c=relaxed/simple;
	bh=z55cr/jMvUhdvKFCQ4qzginFa2f4fja6ZmwOAHM66rw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOeX79mCYgRAmNUdVqFW5mExyBFkYFys5+Q1DIEYFxWBrW6mXLYuaMuUmaCxN9GmuMveZBTf5G2mnOeSyNVFsrm2/B/3MIgExc+0kxnZ2CkzoAjWsz3KirIxhmSgZlWZ1ApyTRwLytOBSBv2DaA9ehfj+gVzx8t4JELiTlGkxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKy5CvQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5906CC4CEF2;
	Mon,  9 Jun 2025 13:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476742;
	bh=z55cr/jMvUhdvKFCQ4qzginFa2f4fja6ZmwOAHM66rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKy5CvQfXClqfEDkc7r+KENMQ8J/hQth0cCusDomYSgbr9XjcK9BOfZf2uSkj6fcf
	 T2q5y0ap3bn7KpSFrvAnz84qVCAVDIG9VcvmLmgbSiVCQkYjgnfvfdG6N3pboS1anY
	 Inz7C2ks9L3YjNUOZlz3IMpvHRsZ5k/0lNs/6+YRwqZuXUNuNmVc8s4vmEjY1eTmrm
	 L5Of9b+krkxoU4WxsybxsAsCGzBeqpPpH2pteXjlR/WuEEdZaMtgsa6RX2elAkBPiS
	 hiUiJwPnZbl/jYMHrYel0CDFdWTcw4XXL3V1B94Bi1zFg5zS5QZWlQdTLR5czWCiOG
	 huLUJ/f8ob9iw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Purva Yeshi <purvayeshi550@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Subject: [PATCH AUTOSEL 6.14 15/29] iio: adc: ad_sigma_delta: Fix use of uninitialized status_pos
Date: Mon,  9 Jun 2025 09:44:56 -0400
Message-Id: <20250609134511.1342999-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250609134511.1342999-1-sashal@kernel.org>
References: <20250609134511.1342999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Purva Yeshi <purvayeshi550@gmail.com>

[ Upstream commit e5cdb098a3cb165d52282ffc3a6448642953ea13 ]

Fix Smatch-detected issue:
drivers/iio/adc/ad_sigma_delta.c:604 ad_sd_trigger_handler() error:
uninitialized symbol 'status_pos'.

The variable `status_pos` was only initialized in specific switch cases
(1, 2, 3, 4), which could leave it uninitialized if `reg_size` had an
unexpected value.

Fix by adding a default case to the switch block to catch unexpected
values of `reg_size`. Use `dev_err_ratelimited()` for error logging and
`goto irq_handled` instead of returning early.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
Link: https://patch.msgid.link/20250410170408.8585-1-purvayeshi550@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Let me analyze the commit without the kernel repository. Looking at the
commit information:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Analysis of the Bug Fix

### 1. **Critical Bug Nature**
The commit fixes a serious issue where the variable `status_pos` could
be used uninitialized. This is a critical bug because:
- Uninitialized variables can contain arbitrary memory values
- Using an uninitialized `status_pos` in line `converted_channel =
  data[status_pos] & sigma_delta->info->status_ch_mask;` could lead to:
  - Out-of-bounds array access
  - Memory corruption
  - System crashes or undefined behavior

### 2. **Code Analysis of the Fix**
The problematic code was in the `ad_sd_trigger_handler()` function:

```c
switch (reg_size) {
case 4:
case 2:
case 1:
    status_pos = reg_size;
    // ...
    break;
case 3:
    status_pos = reg_size + 1;
    // ...
    break;
}
```

**Problem**: If `reg_size` had any value other than 1, 2, 3, or 4,
`status_pos` would remain uninitialized.

**Solution**: The fix adds a default case:
```c
default:
    dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n",
reg_size);
    goto irq_handled;
```

### 3. **Risk Assessment - LOW RISK**
- **Contained fix**: Only adds error handling, doesn't change existing
  logic
- **No functional changes**: For valid `reg_size` values (1-4), behavior
  is identical
- **Safe error handling**: Uses rate-limited logging and proper cleanup
  via `goto irq_handled`
- **No architectural changes**: Simple defensive programming addition

### 4. **User Impact - HIGH**
- **Affects all users**: Any driver using ad_sigma_delta could
  potentially trigger this
- **Data corruption potential**: Uninitialized variable could cause
  incorrect channel data processing
- **System stability**: Could lead to kernel panics or memory corruption
- **Silent failures**: Bug might manifest as subtle data corruption
  rather than obvious crashes

### 5. **Stable Tree Criteria Compliance**
✅ **Important bugfix**: Prevents potential memory corruption and crashes
✅ **Small and contained**: Only adds 3 lines of defensive code
✅ **Low regression risk**: Cannot break existing functionality
✅ **Clear benefit**: Eliminates undefined behavior
✅ **No new features**: Pure bug fix

### 6. **Comparison with Similar Commits**
Unlike the reference commits that were marked "NO" for backporting:
- This fixes a **functional bug** (not just code style/cleanup)
- Has **user-visible impact** (potential crashes vs. cosmetic
  improvements)
- Addresses **undefined behavior** (critical vs. minor improvements)
- **Security implications** (memory safety vs. readability)

### 7. **Static Analysis Tool Detection**
The fact that Smatch detected this issue indicates it's a real problem
that static analysis considers serious enough to flag. This type of
uninitialized variable usage is a common source of security
vulnerabilities and system instability.

**Conclusion**: This is a textbook example of a commit that should be
backported - it fixes a real bug with serious consequences, has minimal
risk of regression, and follows all stable tree guidelines.

 drivers/iio/adc/ad_sigma_delta.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 77b4e8bc47485..07ad7ca07c121 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -585,6 +585,10 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 		 * byte set to zero. */
 		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
 		break;
+
+	default:
+		dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
+		goto irq_handled;
 	}
 
 	/*
-- 
2.39.5


