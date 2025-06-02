Return-Path: <stable+bounces-150386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99439ACB732
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6042B4C4952
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D250F22F755;
	Mon,  2 Jun 2025 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuQfVIxr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B022F74E;
	Mon,  2 Jun 2025 15:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876960; cv=none; b=pHOCKt0r/ffDZLXmZFperrTGVHvs0SqxHpX8sgbw/87lGOmJQMG107tSl/HpkStsLDGATkRlq/uPoKbDwY7UaBLcOBGVtw9wlsGKeIIPzpSXfjcbUfslpaLZzZgfPRdz8LmHjTM4JnW9ZZXSZPTogyV8SQXwfFFeq+OBHtfx4EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876960; c=relaxed/simple;
	bh=hqbYJ9eJpsAWNr6fNZXC8Cc2hR+tUqVYB6v3bfVmGto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+pKGRT+4MKGX2S8WNiYSxLWSc/MDu/C9cnSMxDdGIyZV5lVTD+HkJQSp6kpwX/upIsBmyoCg8QF+niw57sJJlFUx0Pt8FVu3zcG/ji91jaJR/NlcxNXTzzE/S42g2oKRBhXWYzYYlRktw3GD8iyZehpz3htGzVPh44HqNNOtCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuQfVIxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874EAC4CEEB;
	Mon,  2 Jun 2025 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748876959;
	bh=hqbYJ9eJpsAWNr6fNZXC8Cc2hR+tUqVYB6v3bfVmGto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vuQfVIxrdXEoFmnyAQ65MQZyY2dkfHkdko9d491gumY+gEF3F5O/A8RIvkmf4s+en
	 1ra86PZ3PrrKqr6x3wS2xan1OvzjXO/7V7Xmw0Xlx9/ZuDY/QVRNS6Fn6wDTomg1Js
	 jHG2WMGAfVXneGXacPaZeU62WhvSYb2b8OMYsJzk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 127/325] firmware: arm_ffa: Set dma_mask for ffa devices
Date: Mon,  2 Jun 2025 15:46:43 +0200
Message-ID: <20250602134324.963304962@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit cc0aac7ca17e0ea3ca84b552fc79f3e86fd07f53 ]

Set dma_mask for FFA devices, otherwise DMA allocation using the device pointer
lead to following warning:

WARNING: CPU: 1 PID: 1 at kernel/dma/mapping.c:597 dma_alloc_attrs+0xe0/0x124

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 248594b59c64d..5bda5d7ade42d 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -191,6 +191,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
+	dev->dma_mask = &dev->coherent_dma_mask;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
-- 
2.39.5




