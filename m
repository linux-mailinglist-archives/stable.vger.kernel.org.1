Return-Path: <stable+bounces-152145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED725AD2007
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 15:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD73A2D03
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBA625C6F9;
	Mon,  9 Jun 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+ApJxHi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9158BFF;
	Mon,  9 Jun 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476878; cv=none; b=lJkwl0EXsmHvgruxXKoLz8lYpdxV2w2xYQFPmWw/Rmyk46DrupQNvbwW6MQ35qvjyGlyQdRjZfUHyejkrN9Ovr6i7qhQ3V+M+9QoT+pmlAd0jSYEPEZKyevY/TwyftiGIUZsge0ECyztjqhXSUNe0U+rSQS6iUWA2PwtxNw8Wbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476878; c=relaxed/simple;
	bh=jqRXoo6IEZ6rg6oPtIrRxJfBWqngIj4deDagxLChHZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wf83uiOM+Saix4cMPjWdEX8HLNFklpXk4ZvYUokolt/qowuzE+WwD3p4uE6YMYcnrrr+eaFcXO4vMoISYvkpUYfIq+09BDUQpLCTHYWftleRI3XvOTHS+2AfaK7NoMmvyGyydd9fqaqZtQ0R5pLhRNv+SjcmvjPPEzDds+N8E4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+ApJxHi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A435C4CEEB;
	Mon,  9 Jun 2025 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476877;
	bh=jqRXoo6IEZ6rg6oPtIrRxJfBWqngIj4deDagxLChHZA=;
	h=From:To:Cc:Subject:Date:From;
	b=H+ApJxHiLCmI17qzf9RTIlQqEX9lqMSjUNq0RmYjdUzEae5ZfDzE/xD4r1au42we9
	 Dxd5yqn7lFfvmW66kvQDmXbjssfNiTutAciKMRkclWqSQ77K3lWW/SGAzdyywQCYwr
	 AvfvivRu0TjTZgd4tfEZqRH4DE3lkma3OwlJ6Ym6OaOzYO7Y36rJyyXrMXON1AuJ/e
	 ZPo15vXWSXIIWwtRrfqvYAU5WM/dnd1AAmuTndE3wkN6B7MnNSTlr2DHRD0jAugWxe
	 0PcB0CK1WK+UD0NNeWZebn4nNxRA3YxpItyzia7QfZqCHmYLBn8CUwNtEJPtcHrQYN
	 o0NNOOYTrNW6A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yu Kuai <yukuai3@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	song@kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/12] md/md-bitmap: fix dm-raid max_write_behind setting
Date: Mon,  9 Jun 2025 09:47:44 -0400
Message-Id: <20250609134755.1345286-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.185
Content-Transfer-Encoding: 8bit

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 2afe17794cfed5f80295b1b9facd66e6f65e5002 ]

It's supposed to be COUNTER_MAX / 2, not COUNTER_MAX.

Link: https://lore.kernel.org/linux-raid/20250524061320.370630-14-yukuai1@huaweicloud.com
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Now I have a clear understanding. Let me analyze the specific code
change in the commit:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Analysis of the Bug Fix

### 1. The Bug
The code in `md_bitmap_new_disk_sb()` incorrectly validates
`write_behind` against `COUNTER_MAX` instead of `COUNTER_MAX / 2`:

```c
- if (write_behind > COUNTER_MAX)
+       if (write_behind > COUNTER_MAX / 2)
                write_behind = COUNTER_MAX / 2;
```

### 2. Why This is a Real Bug

The comment immediately above this code explicitly states:
```c
/*
 - FIXME: write_behind for RAID1.  If not specified, what
 - is a good choice?  We choose COUNTER_MAX / 2 arbitrarily.
 */
```

The intent is clearly to limit write_behind to `COUNTER_MAX / 2`, but
the validation check was incorrectly comparing against `COUNTER_MAX`.
This creates an inconsistency where:
- Values between `COUNTER_MAX / 2` and `COUNTER_MAX` would pass the
  check
- But then get clamped to `COUNTER_MAX / 2` anyway
- This means the validation isn't serving its intended purpose

### 3. Impact on Users

This bug affects:
- **dm-raid users**: When creating new bitmap superblocks for RAID
  arrays with write-behind configured
- **Data consistency**: While not causing data corruption, it creates
  confusion about the actual limits
- **Configuration validation**: Users might set values that appear to be
  accepted but are silently reduced

### 4. Consistency with Other Code

The fix aligns with the pattern used elsewhere:
- In `dm-raid.c`: The validation correctly checks `value / 2 >
  COUNTER_MAX` (equivalent check for sector-based values)
- The clamping value of `COUNTER_MAX / 2` is consistently used as the
  default throughout the codebase

### 5. Backport Criteria

This commit meets the stable kernel backport criteria:
- **It fixes a bug**: Incorrect validation logic that doesn't match the
  intended behavior
- **Simple and contained**: One-line change with minimal risk
- **Clear fix**: The correct value is obvious from the surrounding code
  and comment
- **User-visible impact**: Affects configuration validation for dm-raid
  users

### 6. Similar Historical Commits

Looking at the similar commits provided:
- Commit #1 (backported): Added validation to prevent setting
  max_write_behind without write-mostly devices
- Commit #4 (backported): Fixed missing bitmap updates with write-mostly
  devices

Both of these were backported and dealt with correctness issues in the
write-behind functionality, establishing a pattern that such fixes are
considered stable-worthy.

### 7. Risk Assessment

- **Low risk**: Single character change ('/' to '/ 2')
- **Well-understood**: The correct limit is documented in the comment
- **No ABI changes**: Just tightens an existing validation check
- **Fail-safe**: Makes the validation more restrictive, not less

## Conclusion

This is a clear bug fix that corrects an incorrect validation check to
match the documented and intended behavior. The fix is trivial, safe,
and addresses a real issue that affects dm-raid users. It should be
backported to ensure consistent behavior across stable kernel versions.

 drivers/md/md-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index b26e22dd9ba2e..cb84a4ab8d70f 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -546,7 +546,7 @@ static int md_bitmap_new_disk_sb(struct bitmap *bitmap)
 	 * is a good choice?  We choose COUNTER_MAX / 2 arbitrarily.
 	 */
 	write_behind = bitmap->mddev->bitmap_info.max_write_behind;
-	if (write_behind > COUNTER_MAX)
+	if (write_behind > COUNTER_MAX / 2)
 		write_behind = COUNTER_MAX / 2;
 	sb->write_behind = cpu_to_le32(write_behind);
 	bitmap->mddev->bitmap_info.max_write_behind = write_behind;
-- 
2.39.5


