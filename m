Return-Path: <stable+bounces-122067-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DE9A59DC8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B867A6D93
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980E9230BC8;
	Mon, 10 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NhlubuEP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A491C5F1B;
	Mon, 10 Mar 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627432; cv=none; b=RvdL7NkuWmUFqFiegZiprI6isuREX2W2OIQKp5xEX8uiwWg755jy3O0W2Ya2ENvFEm7aur567MQwtXE3M01EflqaJz9XMaPICfzfvJfhlpGQdM8Iry7/z6hK27GeSO2dyjVwbgcVJp1JIsi2o8rUaH8wPm0QhOqhcE8M3fNoJPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627432; c=relaxed/simple;
	bh=3BNs/nBQ7W5XfLvsNGkDX8iCOf/P0rqqsEVdOvvDvy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOUWPpQW6xBsI87/K+MabpSz9j68OV/R9zICllhV48UcisOdsA4znJl0hmEaTYnY+UBo/Ep4naaV7tRIBQ8tcPMJNo8zukUOHnv4OrbQrccNNQqJ2gBBHeI6m3aiKCR09RhUSnu3nPw9cQCEy/ppjvYeYrUWcBPX89jCRtJ6KL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NhlubuEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA8FC4CEEC;
	Mon, 10 Mar 2025 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627432;
	bh=3BNs/nBQ7W5XfLvsNGkDX8iCOf/P0rqqsEVdOvvDvy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NhlubuEP6h/aOy+1MANCFjWeRL42Vp+ckSZRZyJfvoc5quCRiXOXuaSo1sQu8HJCs
	 JEhElyU9nUFpv6F1ujCwWs+85qNA03N693LnAwp8aVUF9UKG97bukFQFgi8BqqmNbo
	 o4QlK4NOu5GSZz6fj8gWsdOrExkonjjemiYphT04=
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
Subject: [PATCH 6.12 128/269] rapidio: fix an API misues when rio_add_net() fails
Date: Mon, 10 Mar 2025 18:04:41 +0100
Message-ID: <20250310170502.824327377@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
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



