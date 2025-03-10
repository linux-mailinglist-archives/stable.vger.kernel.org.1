Return-Path: <stable+bounces-121798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF69A59C57
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5052B16E47D
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE7230BED;
	Mon, 10 Mar 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IJEwxmhD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39FC230BD5;
	Mon, 10 Mar 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626659; cv=none; b=DO/NGooznW/j5jxtCojdHVCYf5AP3KxikN01REg9sJP6JjUgLGjwOEqyqgnvdYshCLDz6Doamx60sFcAa8UTU4na2CYosWgL1h0/iZdSurXWDplwsw0cjwKAUNteHDEYFXp6P9LR7QWvIq0STB2IlKQ8LIeOcDK1FM7oJ5P5UQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626659; c=relaxed/simple;
	bh=dUUQCezPFGQD25IQq0TfrDxMdW2XHLn4I4NHOINBwx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/7zYrMHwh/fSDCYg+q7wrY+giZqyT3jztpir0+vGPHvih/GlJUWGCOVPN075NZg1qObwFeLdwwrfMntuzk2Ws5Q4miueDq9HcI86a/Frcqn4jkU51KTd3JXIxp+rMJuWIPS84X0a/9xLnZO2lEBzEBWNAq3UtIlsgDh8q0jgpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IJEwxmhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE83C4CEE5;
	Mon, 10 Mar 2025 17:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626659;
	bh=dUUQCezPFGQD25IQq0TfrDxMdW2XHLn4I4NHOINBwx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IJEwxmhDPa+M583EZk18/LJUSkMNKvut6N3BtZoGyxu0McMWBpAiP5ljnxnZKNa8a
	 E/s9ZTIGuKXwuXwgLuurVh3Qc5d47moHTWooe5nVKYL72Mo3OI9LqF3IOomhncl+iY
	 rDMHMNToAx5vYBWepaFfhRxdcdPlFJ/5V7J6riXc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <haoxiang_li2024@163.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.13 067/207] rapidio: fix an API misues when rio_add_net() fails
Date: Mon, 10 Mar 2025 18:04:20 +0100
Message-ID: <20250310170450.430919757@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <haoxiang_li2024@163.com>

commit b2ef51c74b0171fde7eb69b6152d3d2f743ef269 upstream.

rio_add_net() calls device_register() and fails when device_register()
fails.  Thus, put_device() should be used rather than kfree().  Add
"mport->net = NULL;" to avoid a use after free issue.

Link: https://lkml.kernel.org/r/20250227073409.3696854-1-haoxiang_li2024@163.com
Fixes: e8de370188d0 ("rapidio: add mport char device driver")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Yang Yingliang <yangyingliang@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rapidio/devices/rio_mport_cdev.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -1742,7 +1742,8 @@ static int rio_mport_add_riodev(struct m
 		err = rio_add_net(net);
 		if (err) {
 			rmcd_debug(RDEV, "failed to register net, err=%d", err);
-			kfree(net);
+			put_device(&net->dev);
+			mport->net = NULL;
 			goto cleanup;
 		}
 	}



