Return-Path: <stable+bounces-160422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624CAFBEEE
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 02:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E495B1AA76C7
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 00:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F413625;
	Tue,  8 Jul 2025 00:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/y6Px3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF514128819;
	Tue,  8 Jul 2025 00:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932956; cv=none; b=Ls65O3RHXBVdXE92ZgJYaVnu/Gf2jYGd5Qm+KIlD3IKOV1R4f+zAmvFPynErUJj94uweczrHe3uFKQDzWq2WtaX/0DpDfHLBpJDP2yEjRsbop/IxZp8kBj9RO3PmlkwLvZIxspMT4PsaJEC9Wxt7Of8eNaUtUQAGLtbTvY4sLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932956; c=relaxed/simple;
	bh=2a9hDKsHy31E1vQnnQE8Z70lFs//x+5n4TmhNrq285s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nig6G71zv8FZABcJrF5bONM75jCJz61NduY6QMUnNNjkHSuZVOgIKHBx07cgvOSpDnscWxWTE8wy1EHW0vGOYPkVfplbOVZPflNFk9Rjgwxzl51fMc8JLWNI0ngPbzx8d2vLjMHlT/en/xd+VMhxkEFXGtcQBHbU1K5L7gYM+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/y6Px3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0A5C4CEE3;
	Tue,  8 Jul 2025 00:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751932956;
	bh=2a9hDKsHy31E1vQnnQE8Z70lFs//x+5n4TmhNrq285s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/y6Px3WBrqFXDL+p1vhihekV8Rk6dgf2ui/VZIOY6GblcJAfkBAshIG6zx8bEzgh
	 vCzPd/oPAEIr8qg5kf5oseBSPxTAfeg2mLAMrhU9nRV9cJ0DPR9JLjYJBanmNMwdND
	 jxUKacYk8DlGTKr5k1Ej8fW3boGkuC/GX16WDys63F6Q1srQADIpKUjMVQaoJkmGdn
	 v6hidt7QNMSwiPn8CnhoXNhOVEv5+ZlMvHh4WzPkmCf/+si3Zo180EO2lAylZkPwRK
	 ysfK6GrC3oj/q0+FhpF+mqYD3LIgsKT2IX/oWG1Ic7jCbhEqlfbELgzFuKtJUaOjJ2
	 WJ9GApB4mJNCQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Laurent Vivier <lvivier@redhat.com>,
	xuanzhuo@linux.alibaba.com,
	Jason Wang <jasowang@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 6.12 3/6] virtio_ring: Fix error reporting in virtqueue_resize
Date: Mon,  7 Jul 2025 20:02:27 -0400
Message-Id: <20250708000230.793347-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708000230.793347-1-sashal@kernel.org>
References: <20250708000230.793347-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.36
Content-Transfer-Encoding: 8bit

From: Laurent Vivier <lvivier@redhat.com>

[ Upstream commit 45ebc7e6c125ce93d2ddf82cd5bea20121bb0258 ]

The virtqueue_resize() function was not correctly propagating error codes
from its internal resize helper functions, specifically
virtqueue_resize_packet() and virtqueue_resize_split(). If these helpers
returned an error, but the subsequent call to virtqueue_enable_after_reset()
succeeded, the original error from the resize operation would be masked.
Consequently, virtqueue_resize() could incorrectly report success to its
caller despite an underlying resize failure.

This change restores the original code behavior:

       if (vdev->config->enable_vq_after_reset(_vq))
               return -EBUSY;

       return err;

Fix: commit ad48d53b5b3f ("virtio_ring: separate the logic of reset/enable from virtqueue_resize")
Cc: xuanzhuo@linux.alibaba.com
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Link: https://patch.msgid.link/20250521092236.661410-2-lvivier@redhat.com
Tested-by: Lei Yang <leiyang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

## Analysis Summary

**YES**, this commit should be backported to stable kernel trees.

Here's my extensive analysis:

### 1. **This is a clear bug fix for incorrect error reporting**

The commit fixes a critical error handling bug in `virtqueue_resize()`
where error codes from the resize operation (`virtqueue_resize_packed()`
or `virtqueue_resize_split()`) were being masked if
`virtqueue_enable_after_reset()` succeeded.

The specific bug pattern:
```c
// Before fix (buggy code):
err = virtqueue_resize_packed/_split(_vq, num);  // May return error
return virtqueue_enable_after_reset(_vq);        // Returns 0 on
success, masking 'err'

// After fix (correct code):
err = virtqueue_resize_packed/_split(_vq, num);
err_reset = virtqueue_enable_after_reset(_vq);
if (err_reset)
    return err_reset;
return err;  // Correctly returns the resize error
```

### 2. **The bug affects users and can cause silent failures**

According to the function documentation at lines 2787-2788, when
`-ENOMEM` is returned from resize, "vq can still work normally" with the
original ring size. However, with the bug, the caller would receive
success (0) instead of `-ENOMEM`, leading them to incorrectly believe
the resize succeeded when it actually failed. This could cause:
- Incorrect assumptions about queue capacity
- Performance issues if the application expected a different queue size
- Potential resource allocation mismatches

### 3. **The fix is small, contained, and low-risk**

The change is minimal - only 6 lines of code:
- Introduces a new local variable `err_reset`
- Properly preserves and returns the original error code
- No architectural changes or new features
- Only affects error propagation logic

### 4. **The bug exists in stable kernels**

- Bug introduced in v6.6-rc1 (commit ad48d53b5b3f)
- The feature (virtqueue_resize) exists since v6.0-rc1
- Therefore, stable kernels 6.6.x and later contain this bug

### 5. **Clear regression from refactoring**

The commit message explicitly states this "restores the original code
behavior" and includes a "Fix:" tag pointing to the commit that
introduced the regression. The original correct pattern was:
```c
if (vdev->config->enable_vq_after_reset(_vq))
    return -EBUSY;
return err;
```

### 6. **Meets stable kernel criteria**

Per stable kernel rules, this fix:
- Fixes a real bug that affects users (incorrect error reporting)
- Is already in Linus' tree (merged by Paolo Abeni)
- Is small and easily reviewable
- Has been tested (Tested-by: Lei Yang)
- Has multiple maintainer acks (Jason Wang, Michael S. Tsirkin)
- Does not add new features or make risky changes

### 7. **Similar commits context**

While the similar commits shown are feature additions (introducing
virtqueue_resize functionality), this commit is fundamentally different
- it's a bug fix for error handling, not a feature addition.

The fix ensures that callers of `virtqueue_resize()` receive accurate
error information, which is critical for proper error handling and
recovery in virtio drivers that use queue resizing functionality.

 drivers/virtio/virtio_ring.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 147926c8bae09..c0276979675df 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2741,7 +2741,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		     void (*recycle_done)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	int err;
+	int err, err_reset;
 
 	if (num > vq->vq.num_max)
 		return -E2BIG;
@@ -2763,7 +2763,11 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	else
 		err = virtqueue_resize_split(_vq, num);
 
-	return virtqueue_enable_after_reset(_vq);
+	err_reset = virtqueue_enable_after_reset(_vq);
+	if (err_reset)
+		return err_reset;
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
 
-- 
2.39.5


