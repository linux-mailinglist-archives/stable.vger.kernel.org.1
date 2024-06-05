Return-Path: <stable+bounces-48100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 826DF8FCC5B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A691C209D9
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2C51990A9;
	Wed,  5 Jun 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX9n36Ut"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0631990A5;
	Wed,  5 Jun 2024 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588512; cv=none; b=jvxtXOmclKkHrAGEOOK29+SQQqSaVoOvGQYfKqemIUug3GJuvnwU2majOY587pC5uo4E3dE+FGMpt3JF8XIfc242yaUd7A9uHfUJ67933JU7ckI9Of9QA8sEVrGdOB4g2W6dlRGc29cfgsuIVc+ULL4VUoSxzidSwaxwi8WgTgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588512; c=relaxed/simple;
	bh=GiBI9huflYab0YbVxrB6G6qk+Ybte+LFytlgYBm241o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfF1NjtMu48wW8N/fdiXemV8+Xhkmkwduxr1LQAQf0/yqHt+koRdevoE7FX9wzuBEC7mxfk2yhfJ1k90Jp0NBV+JnocQdX7Dm52jzNh3i+jYdZT8uLCi1ZmwiyHsblQ9aNkUUmmN7Xg5Ip0vMZ38c9I/xAanTBfeezypK55xEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX9n36Ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E84C4AF07;
	Wed,  5 Jun 2024 11:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588512;
	bh=GiBI9huflYab0YbVxrB6G6qk+Ybte+LFytlgYBm241o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IX9n36Utmi3UwSfu8o/m3nDis8A24FkCxL3zpucan6yLQGtOmp1vbFu30BvO6Rd8w
	 OqsPWKds3jTe0gWBLB2oX2YFMY0keG8lzwE6wMBGIgMDnPcRZZtc/4BmIqbDsyc2YK
	 /7rSvW9OYHYfb4wEk1DiQq2eZ7xyhdyOXj1V/TQr7f6/gOoqDNyNd2UHb2DVwzytJC
	 WstjBnMtVyUnmumkJAgzc+8UAmawtCLvDBhlx/m3hL+irkes81UHdBoqHY7YXGu+aP
	 4LM0h0xufX1/px1xjAZSvaOoInJ6IHF7KlO77V8pdKv2cg6RwGtDLQqNlL+xHih9G3
	 UNGHAsbIZ58wA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sicong Huang <congei42@163.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	johan@kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH AUTOSEL 5.4 5/5] greybus: Fix use-after-free bug in gb_interface_release due to race condition.
Date: Wed,  5 Jun 2024 07:54:58 -0400
Message-ID: <20240605115504.2964549-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115504.2964549-1-sashal@kernel.org>
References: <20240605115504.2964549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.277
Content-Transfer-Encoding: 8bit

From: Sicong Huang <congei42@163.com>

[ Upstream commit 5c9c5d7f26acc2c669c1dcf57d1bb43ee99220ce ]

In gb_interface_create, &intf->mode_switch_completion is bound with
gb_interface_mode_switch_work. Then it will be started by
gb_interface_request_mode_switch. Here is the relevant code.
if (!queue_work(system_long_wq, &intf->mode_switch_work)) {
	...
}

If we call gb_interface_release to make cleanup, there may be an
unfinished work. This function will call kfree to free the object
"intf". However, if gb_interface_mode_switch_work is scheduled to
run after kfree, it may cause use-after-free error as
gb_interface_mode_switch_work will use the object "intf".
The possible execution flow that may lead to the issue is as follows:

CPU0                            CPU1

                            |   gb_interface_create
                            |   gb_interface_request_mode_switch
gb_interface_release        |
kfree(intf) (free)          |
                            |   gb_interface_mode_switch_work
                            |   mutex_lock(&intf->mutex) (use)

Fix it by canceling the work before kfree.

Signed-off-by: Sicong Huang <congei42@163.com>
Link: https://lore.kernel.org/r/20240416080313.92306-1-congei42@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/greybus/interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index 67dbe6fda9a13..5412031fb67c5 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -694,6 +694,7 @@ static void gb_interface_release(struct device *dev)
 
 	trace_gb_interface_release(intf);
 
+	cancel_work_sync(&intf->mode_switch_work);
 	kfree(intf);
 }
 
-- 
2.43.0


