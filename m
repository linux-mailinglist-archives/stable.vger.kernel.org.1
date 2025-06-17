Return-Path: <stable+bounces-152796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB9AADCB0E
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2133A171A60
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 12:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1B629009A;
	Tue, 17 Jun 2025 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7f4WhKQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240352DE1E7;
	Tue, 17 Jun 2025 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162958; cv=none; b=RjUwckOcqEBmumq/PtwAcRo1C16kY6cW6sJ/ZrnI5U2jMahpPbb+Ua+PGv/WQSnohFEOIeX2xnAUIXEMYKq7Yzn0ZfgINMd0M+HAIXNRyUqBur5ndShTk/QNOWbrZK8o9sLipaMDFfaBiTfsobGezRYCCZkJ17C6WMWmVTxK0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162958; c=relaxed/simple;
	bh=zklJJX37K1eEdGc685483qBRFhMz1cOfF8PTXJfhNOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CE+292aKH0TJ3FczuEQ/06ei18A1uguykfTA8XfGdKhGdinfnOufpybwWprUbW7Y6swJyj3dVwX42rOBZ5OmgMemt6hPQic3Ti10ISHid+4FuGEjYksJuEQpMsjdHsWBKMHydDDTp3cGNQq4VVFS0pJxEurQmjHjwr3PLYTvt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7f4WhKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBD0C4CEE3;
	Tue, 17 Jun 2025 12:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750162958;
	bh=zklJJX37K1eEdGc685483qBRFhMz1cOfF8PTXJfhNOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7f4WhKQ972vn2fwIURFnxH94NqQHsquf2v6wA29r8ACRhBQ7XBXMHtQ0fOBHpF7v
	 b8Js2fEicx/ch5925lhHQ9WhT2csyt41r9bOU3gCe01n5Bvt29JpQU62cN5F7GLQgJ
	 wjxKHaQc/MNAxq78YbwYvtGf80VdPOzuQfeGc3Zu35srYkeRqKn0EkYjKqBKrPWFK+
	 50f6yQbERFK6uXqnYd9CO/X1JGf9g2w9btCnjti0FqvWYRGny6NwBQcyDnRfsoN+BE
	 sYOwGIoZbitpko1U86ODq3cuOCm2rqhRqKq6QVmxlDWTxI3SowdN30HLgIVlTMNWJd
	 3LxnhveXomGCA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ziqi Chen <quic_ziqichen@quicinc.com>,
	Can Guo <quic_cang@quicinc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	peter.wang@mediatek.com,
	avri.altman@wdc.com,
	mani@kernel.org,
	quic_nguyenb@quicinc.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 07/12] scsi: ufs: core: Don't perform UFS clkscaling during host async scan
Date: Tue, 17 Jun 2025 08:22:16 -0400
Message-Id: <20250617122222.1968832-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617122222.1968832-1-sashal@kernel.org>
References: <20250617122222.1968832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.33
Content-Transfer-Encoding: 8bit

From: Ziqi Chen <quic_ziqichen@quicinc.com>

[ Upstream commit e97633492f5a3eca7b3ff03b4ef6f993017f7955 ]

When preparing for UFS clock scaling, the UFS driver will quiesce all
sdevs queues in the UFS SCSI host tagset list and then unquiesce them in
ufshcd_clock_scaling_unprepare(). If the UFS SCSI host async scan is in
progress at this time, some LUs may be added to the tagset list between
UFS clkscale prepare and unprepare. This can cause two issues:

1. During clock scaling, there may be I/O requests issued through new
added queues that have not been quiesced, leading to task abort issue.

2. These new added queues that have not been quiesced will be unquiesced
as well when UFS clkscale is unprepared, resulting in warning prints.

Therefore, use the mutex lock scan_mutex in
ufshcd_clock_scaling_prepare() and ufshcd_clock_scaling_unprepare() to
protect it.

Co-developed-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Ziqi Chen <quic_ziqichen@quicinc.com>
Link: https://lore.kernel.org/r/20250522081233.2358565-1-quic_ziqichen@quicinc.com
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my thorough analysis of the code and the race condition, here's
my assessment:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Bug Analysis

The commit fixes a **critical race condition** between UFS clock scaling
operations and async SCSI scanning that can lead to two serious issues:

### 1. **The Race Condition Explained**

Looking at the code changes, the issue occurs when:

**Before the fix**: `ufshcd_clock_scaling_prepare()` performs operations
in this order:
```c
blk_mq_quiesce_tagset(&hba->host->tag_set);  // Quiesce existing queues
mutex_lock(&hba->wb_mutex);
down_write(&hba->clk_scaling_lock);
```

**The race**: If `ufshcd_async_scan()` is running concurrently, it calls
`scsi_scan_host()` at line 8789, which:
1. Discovers new LUNs and adds them to the tagset
2. Creates new block queues for these LUNs
3. These new queues are **not quiesced** by the earlier
   `blk_mq_quiesce_tagset()` call

**After the fix**: The addition of `mutex_lock(&hba->host->scan_mutex)`
**before** `blk_mq_quiesce_tagset()` ensures:
```c
mutex_lock(&hba->host->scan_mutex);          // NEW: Serialize with
scanning
blk_mq_quiesce_tagset(&hba->host->tag_set);  // Now quiesces ALL queues
```

### 2. **Specific Problems This Fixes**

**Issue #1 - Task Abort**: Non-quiesced new queues can continue issuing
I/O during clock scaling, leading to task aborts when the UFS controller
changes power states mid-transaction.

**Issue #2 - Warning Messages**: In `ufshcd_clock_scaling_unprepare()`,
`blk_mq_unquiesce_tagset()` attempts to unquiesce ALL queues in the
tagset, including newly added ones that were never quiesced, triggering
warning messages.

### 3. **Why This Should Be Backported**

**Critical System Stability**: This fixes a race that can cause:
- I/O errors and potential data corruption during clock scaling
- System warnings and potential instability
- Unpredictable behavior during device discovery

**High Impact**: The race affects:
- **UFS storage devices** (widely used in mobile phones, tablets,
  servers)
- **Clock scaling operations** (essential for power management)
- **Device discovery** (happens during boot and hotplug)

**Low Risk Change**: The fix is minimal and surgical:
- Only adds `scan_mutex` synchronization around existing code
- No functional changes to the clock scaling or scanning logic
- Follows established kernel locking patterns (similar to other SCSI
  drivers)

**Timing-Dependent Bug**: This is exactly the type of race condition
that:
- May not be easily reproducible in testing
- Can appear randomly in production under load
- Becomes more likely with faster systems or specific timing conditions

### 4. **Code Quality Assessment**

The fix demonstrates good kernel programming practices:
- **Proper lock ordering**: Acquires `scan_mutex` first to serialize
  with scanning
- **Complete error handling**: Properly releases `scan_mutex` in error
  paths
- **Symmetric operations**: Both `prepare` and `unprepare` handle the
  mutex consistently
- **Minimal scope**: Changes only what's necessary to fix the race

### 5. **Comparison with Similar Commits**

Looking at the historical commits provided:
- This is similar to commit #4 (marked YES) which also fixes
  synchronization during async operations
- Unlike commits #1, #2, #3, #5 (marked NO) which are
  optimization/refactoring changes
- This is a **bug fix** addressing a real race condition, not a feature
  addition

**Conclusion**: This commit fixes a legitimate race condition that can
cause system instability in UFS-based systems. It's a small, well-
contained fix that addresses a critical synchronization issue without
introducing new features or architectural changes. This makes it an
ideal candidate for stable kernel backporting.

 drivers/ufs/core/ufshcd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 247e425428c88..b9fe86c661608 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1392,6 +1392,7 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba, u64 timeout_us)
 	 * make sure that there are no outstanding requests when
 	 * clock scaling is in progress
 	 */
+	mutex_lock(&hba->host->scan_mutex);
 	blk_mq_quiesce_tagset(&hba->host->tag_set);
 	mutex_lock(&hba->wb_mutex);
 	down_write(&hba->clk_scaling_lock);
@@ -1402,6 +1403,7 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba, u64 timeout_us)
 		up_write(&hba->clk_scaling_lock);
 		mutex_unlock(&hba->wb_mutex);
 		blk_mq_unquiesce_tagset(&hba->host->tag_set);
+		mutex_unlock(&hba->host->scan_mutex);
 		goto out;
 	}
 
@@ -1423,6 +1425,7 @@ static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, int err, bool sc
 	mutex_unlock(&hba->wb_mutex);
 
 	blk_mq_unquiesce_tagset(&hba->host->tag_set);
+	mutex_unlock(&hba->host->scan_mutex);
 	ufshcd_release(hba);
 }
 
-- 
2.39.5


