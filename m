Return-Path: <stable+bounces-157867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2320DAE55D3
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840E07AECC8
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834D221FC7;
	Mon, 23 Jun 2025 22:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dNqFHrGw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92A5B676;
	Mon, 23 Jun 2025 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716913; cv=none; b=afLLZ6qe0L1tMMS4WaqCcNdkekmOg48mF6M5m8URi6op7H+MFDox42NHhb2nrdaaIUMksTFdQriM2mvvHrUfEqnG6Vc5QNCXh1QlLVo5xvnPW3q/boEG82RnCSoBlRhI+p1zYOqGLsA7gckg8yxey8K0X4I6ZZ5gXA62etVxSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716913; c=relaxed/simple;
	bh=njdzo8fGBmDKu5xpiPHZBgRDP8W+0ms7z1yon7HeDD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEqV+1qZEpO/MYt0UGi01YzaRV6RJJfO1vpwZQIgEA9mYcCc+LGxqcgeLV9GYe9sm+JsjdBIbhrF4bcqEJZyRTNbx6sTZKsn4VjSMzdnTw4dSojF3KZj/7juCTZ8Qko0bA1Ex5PhmOkShtlTRp5+R4hSr2ICfchmypq/ZO7NbVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dNqFHrGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618E6C4CEF1;
	Mon, 23 Jun 2025 22:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750716913;
	bh=njdzo8fGBmDKu5xpiPHZBgRDP8W+0ms7z1yon7HeDD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNqFHrGwYfkeXQkQYT644VeJ6luYouh46f42j1SYWUXX7vYxI3GJ9vyX4XcQGXAMI
	 a8IW7vBb93VqS+ejer4zasd0qkVzJSJHzuglr5hvY8xxMIijORQ778FetJzdgOd18a
	 BVtCq7hEj6RrXc7T+G/RpJLE1BlBe0lmytxHAy8M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 6.15 568/592] dm-table: check BLK_FEAT_ATOMIC_WRITES inside limits_lock
Date: Mon, 23 Jun 2025 15:08:46 +0200
Message-ID: <20250623130713.952127334@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Marzinski <bmarzins@redhat.com>

commit 85f6d5b729eaace1549f1dcc284d9865f2c3ec02 upstream.

dm_set_device_limits() should check q->limits.features for
BLK_FEAT_ATOMIC_WRITES while holding q->limits_lock, like it does for
the rest of the queue limits.

Fixes: b7c18b17a173 ("dm-table: Set BLK_FEAT_ATOMIC_WRITES for target queue limits")
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-table.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -431,13 +431,13 @@ static int dm_set_device_limits(struct d
 		return 0;
 	}
 
+	mutex_lock(&q->limits_lock);
 	/*
 	 * BLK_FEAT_ATOMIC_WRITES is not inherited from the bottom device in
 	 * blk_stack_limits(), so do it manually.
 	 */
 	limits->features |= (q->limits.features & BLK_FEAT_ATOMIC_WRITES);
 
-	mutex_lock(&q->limits_lock);
 	if (blk_stack_limits(limits, &q->limits,
 			get_start_sect(bdev) + start) < 0)
 		DMWARN("%s: adding target device %pg caused an alignment inconsistency: "



