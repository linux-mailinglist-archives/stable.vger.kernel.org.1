Return-Path: <stable+bounces-108953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDCBA12114
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E2D188CA81
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03D1DB142;
	Wed, 15 Jan 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MB9qnsz1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2715A1DB13A;
	Wed, 15 Jan 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938361; cv=none; b=BiPZPDm/75NIXFZ7C+kvxk7Gm3bSVL4p0ifyWagBTmwjmiuR/XyScJoMqrHjVtObG/MpsvY/H0Y4F3wBGEBpLIBPSR19LmbPwaN8Nu4LCUuJ0SdaYxnuw9p8Rp9xhjENpx9AumhD/Cp6jVuUFHP6LTnthj7C9mqvaqn8zuDbk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938361; c=relaxed/simple;
	bh=8ZdW8dBqCuLzQQv41fBdMef2hDi3DkOvOV+YgCRGXkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNCBy4C4sq0wndjSe3VaowUmICSZhbgCy0bdP87vC4iUfMIJtrv2MEkYBUifbBZLTLpXfXYRtymtzQuOxpr6oRgqTyKTPrZVyVoDfpMyCYQ+1QJwIxLGY2QrsyHEFSSMzPpb8doPx7LJcvPPV/Mj4unJ/DhpLhlA0vahp7Wt6aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MB9qnsz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3035BC4CEDF;
	Wed, 15 Jan 2025 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938360;
	bh=8ZdW8dBqCuLzQQv41fBdMef2hDi3DkOvOV+YgCRGXkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MB9qnsz1mdrXXJ3dtX9gao9ISWv5a60cDLeGklhqFJtT+3rTui6vat84kpUIMZYpB
	 +84G7uzLRQzdXZN5QAzrP466E9Tu8Ml7ZyW80Xl/qYzvisJG2NchjEbbBP9E1tU0wq
	 lRSsOUSsKKteKGcJX3XYYayqO7OoWSKwYA2B7nm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 158/189] iio: dummy: iio_simply_dummy_buffer: fix information leak in triggered buffer
Date: Wed, 15 Jan 2025 11:37:34 +0100
Message-ID: <20250115103612.713090642@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

commit 333be433ee908a53f283beb95585dfc14c8ffb46 upstream.

The 'data' array is allocated via kmalloc() and it is used to push data
to user space from a triggered buffer, but it does not set values for
inactive channels, as it only uses iio_for_each_active_channel()
to assign new values.

Use kzalloc for the memory allocation to avoid pushing uninitialized
information to userspace.

Cc: stable@vger.kernel.org
Fixes: 415f79244757 ("iio: Move IIO Dummy Driver out of staging")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20241125-iio_memset_scan_holes-v1-9-0cb6e98d895c@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/dummy/iio_simple_dummy_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -48,7 +48,7 @@ static irqreturn_t iio_simple_dummy_trig
 	int i = 0, j;
 	u16 *data;
 
-	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (!data)
 		goto done;
 



