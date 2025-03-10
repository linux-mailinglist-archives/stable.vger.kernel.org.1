Return-Path: <stable+bounces-122452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BBA59FBA
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEF73A4A91
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5440322DFB1;
	Mon, 10 Mar 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fhzYkfd3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221E223702;
	Mon, 10 Mar 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628532; cv=none; b=pXGp2fYtXVFY8Y5xsDAxwLfFoyCr421lOyCbn0LesiqJClgVUZ6GfRa3VuOxsFRE9S5+8yJiBU2Q6LUo61cCXmnFXqtczLbfEzai1qGCv3fHaZY9QF1wuk0AtbZ94jG7Cr6DJv84h73hiz+a4BRGTHhlpddtuY7n6fglYFFSnR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628532; c=relaxed/simple;
	bh=sp3Nqy5ySqS+t7wiIhMz8Ay5pSzMlxQkOoFlv4zvk3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWj7ChzIf+/kE+DCXkD+NlEqXq2Vldv/9dkshakVGR6lsCMHDsKf33+FaAxFtNv7RoIaTRvzb0JZwBYjkQOg3DgnnTAs2AIJvmGDikcoxZCjTtnJMlSEcXtRg12nD4PjoLD/8Jdbu23/5rg83mB3AMwBBEohyL6R5v7+FRlCCJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fhzYkfd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF32C4CEED;
	Mon, 10 Mar 2025 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628531;
	bh=sp3Nqy5ySqS+t7wiIhMz8Ay5pSzMlxQkOoFlv4zvk3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhzYkfd36zmAyNkHcL+q3COhKtag8pjMe4oBqxu76ULNEEdIxexwcAbfbcv1ZEM2+
	 itv6Qbsfo/zuBROnbGICaokAJAx/pxahvWx24adK03RkF2N2d8DUu5aHRjwkJdaItm
	 HSTHvo4DKRnoLrooQbY4qUDN7wmcDu/q8PhzHaL8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 058/109] ublk: set_params: properly check if parameters can be applied
Date: Mon, 10 Mar 2025 18:06:42 +0100
Message-ID: <20250310170429.880835679@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
References: <20250310170427.529761261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit 5ac60242b0173be83709603ebaf27a473f16c4e4 ]

The parameters set by the set_params call are only applied to the block
device in the start_dev call. So if a device has already been started, a
subsequently issued set_params on that device will not have the desired
effect, and should return an error. There is an existing check for this
- set_params fails on devices in the LIVE state. But this check is not
sufficient to cover the recovery case. In this case, the device will be
in the QUIESCED or FAIL_IO states, so set_params will succeed. But this
success is misleading, because the parameters will not be applied, since
the device has already been started (by a previous ublk server). The bit
UB_STATE_USED is set on completion of the start_dev; use it to detect
and fail set_params commands which arrive too late to be applied (after
start_dev).

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Fixes: 0aa73170eba5 ("ublk_drv: add SET_PARAMS/GET_PARAMS control command")
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250304-set_params-v1-1-17b5e0887606@purestorage.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 35580ad45ce6e..f2a99e5d304dd 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1873,9 +1873,12 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 	if (ph.len > sizeof(struct ublk_params))
 		ph.len = sizeof(struct ublk_params);
 
-	/* parameters can only be changed when device isn't live */
 	mutex_lock(&ub->mutex);
-	if (ub->dev_info.state == UBLK_S_DEV_LIVE) {
+	if (test_bit(UB_STATE_USED, &ub->state)) {
+		/*
+		 * Parameters can only be changed when device hasn't
+		 * been started yet
+		 */
 		ret = -EACCES;
 	} else if (copy_from_user(&ub->params, argp, ph.len)) {
 		ret = -EFAULT;
-- 
2.39.5




