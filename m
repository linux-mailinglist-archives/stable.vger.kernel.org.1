Return-Path: <stable+bounces-48061-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE188FCBDF
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355201F25429
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B83195F13;
	Wed,  5 Jun 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubZtm4p8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90548194122;
	Wed,  5 Jun 2024 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588387; cv=none; b=H96ZhgksrFSVjaqXtEj46PRGJP1oDRwzOkwgZNzMUNIhJa3eNLxdlS0eIwU1bbWGty63VYjVnl3Z5idrEm00BoJ6f+x8hMafPsHQkIqgAExskWUAby7qkePol7rK/Ffk6UxtgzyXXiDwv3XCYY6675OpLVkUKPRQqopK1dlXI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588387; c=relaxed/simple;
	bh=kiI/Lw2TK9Xytq4SD7omgBRD9aRnbSVuuUnrkQXDmf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqSqyCf6GByONZ7U4rEwO46appL8nIpfqsEEMWRrt2ws1VtUBH/ib3EAzEDrk5JO/ngYfjjaSJuUqX+7Q59jIVQBXrrU3V5B7A3Decw4ChznhQpAJCyVjcTICwO+xi4aHDQ5wJYJnVIJnWapnaQ5pBnyf+PLuVQPHBZYdFvhyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubZtm4p8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A276AC4AF07;
	Wed,  5 Jun 2024 11:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588387;
	bh=kiI/Lw2TK9Xytq4SD7omgBRD9aRnbSVuuUnrkQXDmf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ubZtm4p8c1PCKM6veZi9iLgDWg9WCuFRFNVdTQ7vnDy3yBnB+tC7jVYrbFxAffm46
	 V6MfTFDbqVlu7fDx8n2RGQoqibYlNP9sv8yA/tMltngfMoYX0De+NkFeJ9ksdOCQNP
	 xBfz/VfjQWGd8dH7miX/aSpD51ZMheZDSpWKa56EpBPw21Sgt5GpZdqJps7xqYE0e5
	 NAHxdVOeV9ieVE2N26L6pAEyN+ub3jp9SZgr/LvcxjfI7ov3h+2o6QrX2C3Bwv28qN
	 qfMJ+JRYo6Wa0CIDabM2puKQoPLoMLk7vdUD9WJ4b52S7vqLRR8ZChLXJaT1DaL/vj
	 b8bFkK1Il86hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sicong Huang <congei42@163.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	johan@kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH AUTOSEL 6.6 16/20] greybus: Fix use-after-free bug in gb_interface_release due to race condition.
Date: Wed,  5 Jun 2024 07:51:59 -0400
Message-ID: <20240605115225.2963242-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605115225.2963242-1-sashal@kernel.org>
References: <20240605115225.2963242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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
index 9ec949a438ef6..52ef6be9d4499 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -694,6 +694,7 @@ static void gb_interface_release(struct device *dev)
 
 	trace_gb_interface_release(intf);
 
+	cancel_work_sync(&intf->mode_switch_work);
 	kfree(intf);
 }
 
-- 
2.43.0


