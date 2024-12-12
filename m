Return-Path: <stable+bounces-102160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAE39EF0E3
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80CAA189BDDA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52AC223C47;
	Thu, 12 Dec 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wcSpbxDO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A75211A34;
	Thu, 12 Dec 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020202; cv=none; b=ZO+eewuBNyMOAH0qcMZahXZ3Kpv/fJ0WJqx5n87X+ZqGbgauSyApRjvdinu7JL5h/IufiOczf0EFs0chcJLuX7NuWWdkoMxcmMUV9V8w7dL0nvEW1jGSIXYVUWN3+Qx6GnYVBv/o/ZTCYUE86W+bmWFmQ2yv5b8Q35JdnpLSypw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020202; c=relaxed/simple;
	bh=rd56mwIlO2VdkmOpyU8RRa4SZG7uPoYj9lsPtQUQ15w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRUwJKs9i3JofvQSWxvrlhH2kDGpriZ0Ly7M0hAJnH9HkRxVuO3BfvGLWRyu4vX7P3CIQitVn4r2cYPnaz81BlsiP4YE0BjVviVCKBfgAKyaY6uWSQzIIlWaA1pIADe+gLkaIY1aiJXabsglCUbK07kUgt75yvQoyL68sYaoP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wcSpbxDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58C1C4CECE;
	Thu, 12 Dec 2024 16:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020202;
	bh=rd56mwIlO2VdkmOpyU8RRa4SZG7uPoYj9lsPtQUQ15w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wcSpbxDOXeQQ9z+CVUS7UKDNF/zIz1p062Z4LHY3CLH5WNL4t7IZ9pYSbbjl7EGA/
	 uIXrACZ51yybzpDfy9pPY0SXCJNHI456JZOlq6kVZZGMX7R04mlNVz5AhGI1sWnRbY
	 yIE8mFUuMZi0v62J/NgL4N8x0AA+NtPN+cMxkTB0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.1 405/772] ublk: fix ublk_ch_mmap() for 64K page size
Date: Thu, 12 Dec 2024 15:55:50 +0100
Message-ID: <20241212144406.659624218@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit d369735e02ef122d19d4c3d093028da0eb400636 upstream.

In ublk_ch_mmap(), queue id is calculated in the following way:

	(vma->vm_pgoff << PAGE_SHIFT) / `max_cmd_buf_size`

'max_cmd_buf_size' is equal to

	`UBLK_MAX_QUEUE_DEPTH * sizeof(struct ublksrv_io_desc)`

and UBLK_MAX_QUEUE_DEPTH is 4096 and part of UAPI, so 'max_cmd_buf_size'
is always page aligned in 4K page size kernel. However, it isn't true in
64K page size kernel.

Fixes the issue by always rounding up 'max_cmd_buf_size' with PAGE_SIZE.

Cc: stable@vger.kernel.org
Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20241111110718.1394001-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/ublk_drv.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -325,12 +325,21 @@ static inline char *ublk_queue_cmd_buf(s
 	return ublk_get_queue(ub, q_id)->io_cmd_buf;
 }
 
+static inline int __ublk_queue_cmd_buf_size(int depth)
+{
+	return round_up(depth * sizeof(struct ublksrv_io_desc), PAGE_SIZE);
+}
+
 static inline int ublk_queue_cmd_buf_size(struct ublk_device *ub, int q_id)
 {
 	struct ublk_queue *ubq = ublk_get_queue(ub, q_id);
 
-	return round_up(ubq->q_depth * sizeof(struct ublksrv_io_desc),
-			PAGE_SIZE);
+	return __ublk_queue_cmd_buf_size(ubq->q_depth);
+}
+
+static int ublk_max_cmd_buf_size(void)
+{
+	return __ublk_queue_cmd_buf_size(UBLK_MAX_QUEUE_DEPTH);
 }
 
 static inline bool ublk_queue_can_use_recovery_reissue(
@@ -930,7 +939,7 @@ static int ublk_ch_mmap(struct file *fil
 {
 	struct ublk_device *ub = filp->private_data;
 	size_t sz = vma->vm_end - vma->vm_start;
-	unsigned max_sz = UBLK_MAX_QUEUE_DEPTH * sizeof(struct ublksrv_io_desc);
+	unsigned max_sz = ublk_max_cmd_buf_size();
 	unsigned long pfn, end, phys_off = vma->vm_pgoff << PAGE_SHIFT;
 	int q_id, ret = 0;
 



