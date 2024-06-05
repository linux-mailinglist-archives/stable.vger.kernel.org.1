Return-Path: <stable+bounces-48013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9598FCB2D
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 13:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 794A6B24DF2
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 11:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C8C194149;
	Wed,  5 Jun 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz3sn4f6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8063419885B;
	Wed,  5 Jun 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588215; cv=none; b=tJotDGLEoeeTqFrV5pvGZz6gBlLqyplKrTWt43ArGZPpA4FwVIUtKeNL/Yh4jc9CK6tm+WaNY6jqwcpgAi/wm0nw5+FV/LO6Hf6HuphlXoCo33Ht+d8QPuvKz8KsiYLusy7h8VEx0i/YqH2Q2VlNRfn1tw4ECuVtth0Jc/+oKOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588215; c=relaxed/simple;
	bh=F7cpV+a+C7Mbpd4Oog7sdLoU5k2L8t8xst9Mf7jNOQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkymNMycWoAqaNyJhVzFiHuFDzUB35RedBqzxDDlAywkOUgLP4gnCcRPusTIyWkebVu8pJK4b87QJi1uqDOe6NKTcXgxmMKVvzcNJdMRUP2C6Bea1+gHvVoeMSk+Pe9N30UQzZy00FiFpd+fnZRF4dkwCkdZUkLX2rMHuZd7lwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz3sn4f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909BCC4AF07;
	Wed,  5 Jun 2024 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588215;
	bh=F7cpV+a+C7Mbpd4Oog7sdLoU5k2L8t8xst9Mf7jNOQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jz3sn4f6NJBNWErnpXXRXslCw3AzEvQ+DPaKcqtAx1CvCFuCaK6we4qHZX+Nf838u
	 HlbmOUHzXl+HjAKOEMzCnRkXwNUW7+nFnTqRhHawsdIwhiTSsgS58NIPOIL1NtiG8h
	 7cgoUutJt9/8CEX8oJ3jiW7UqhpmDMOgDs8WPOrGbdRYUiiQ02p9y64d1uHQ28bRAM
	 0DXhFuZGW6bN/aMplomyNqse9JidLQW7SsMScWkm/IFHXxhtRbtCTgFyKdzYuKbZHR
	 3RT7VgXcnvo70Zr4OTZfeWBlWqPV3LXqlBVS9tij5EUN+EHHRcZjLO0VAiLMWSNXc7
	 VEtQbiJPd0BJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sicong Huang <congei42@163.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	johan@kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH AUTOSEL 6.9 20/28] greybus: Fix use-after-free bug in gb_interface_release due to race condition.
Date: Wed,  5 Jun 2024 07:48:49 -0400
Message-ID: <20240605114927.2961639-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605114927.2961639-1-sashal@kernel.org>
References: <20240605114927.2961639-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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
index fd58a86b0888d..d022bfb5e95d7 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -693,6 +693,7 @@ static void gb_interface_release(struct device *dev)
 
 	trace_gb_interface_release(intf);
 
+	cancel_work_sync(&intf->mode_switch_work);
 	kfree(intf);
 }
 
-- 
2.43.0


