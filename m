Return-Path: <stable+bounces-116875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EAEA3A967
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88910176838
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FA621323E;
	Tue, 18 Feb 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoL3qxMI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D647213228;
	Tue, 18 Feb 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910426; cv=none; b=RPUIlGbUJqoeA5BsT2YWGKHVww+WvT0MlInNlQl3sRR8OjXB6XytRQ03l98c6LknpuUpoFu5DnGHfkPj8mDP4mGvsrGszU7P661Vy+L6eHvGTksKUNlZQHLQy//R/jFHOtoAA0Qj/0wC0YoVDphJ2H0h8EFtiw8jiuapBDyHoYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910426; c=relaxed/simple;
	bh=wOAL4Oqj9IeI2buYcEwBIqcYqke3ieKR71XPdXq3GHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BhGXvYFOFoFodBSWkHCwMbNTuYjc0UOJfJDv/ZdGzlwSkCgaBv1spEMi8x9JiuYia168MeUjN+cqDEdXiprvPsq6tViVrJXx3Qjhy76MU4mpHpfoY0M5MSn4ofXJfC0HLtboMN0eEx6VAy7z32Mf9sOzAR/C9Fb7jCASHdYPeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoL3qxMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E632AC4CEE2;
	Tue, 18 Feb 2025 20:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910426;
	bh=wOAL4Oqj9IeI2buYcEwBIqcYqke3ieKR71XPdXq3GHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OoL3qxMIT3VwI76PFpXkjVypuiPwzPHrdr/TxrPOt1GWFs44hcUsGPfHMwcFLdX5W
	 0zJQ9r6Mj8RvofjeHx6kG7ajwd4Z74+EsX0kwcOnauyxW2eTV7TSGUrp/ymUzgrtXV
	 XcfqawlEiqriR2lhqKJq4kNiZlCc+GA0mK3BXN6xwf/0t4nLzkA0zcugZExlFFRfhW
	 MLGXhScjpq1/JiKe/NYezV5TfZX5+914hHELVf0eavyubW1sEXXWy54pfyJ1c9imn6
	 4yUbQRnBxr1ge5yP3xb7VU36omdlfSTrM0Jz/rwMu7T92gnNSmV8RsWnslDddqIxpT
	 7wG31Apbyhg9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	mst@redhat.com,
	tiwei.btw@antgroup.com,
	jiri@resnulli.us,
	u.kleine-koenig@pengutronix.de,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 22/31] um: virtio_uml: use raw spinlock
Date: Tue, 18 Feb 2025 15:26:08 -0500
Message-Id: <20250218202619.3592630-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit daa1a05ba431540097ec925d4e01d53ef29a98f1 ]

This is needed because at least in time-travel the code
can be called directly from the deep architecture and
IRQ handling code.

Link: https://patch.msgid.link/20250110125550.32479-7-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/virtio_uml.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 2b6e701776b6b..f0020e7c908d0 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -52,7 +52,7 @@ struct virtio_uml_device {
 	struct platform_device *pdev;
 	struct virtio_uml_platform_data *pdata;
 
-	spinlock_t sock_lock;
+	raw_spinlock_t sock_lock;
 	int sock, req_fd, irq;
 	u64 features;
 	u64 protocol_features;
@@ -247,7 +247,7 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	if (request_ack)
 		msg->header.flags |= VHOST_USER_FLAG_NEED_REPLY;
 
-	spin_lock_irqsave(&vu_dev->sock_lock, flags);
+	raw_spin_lock_irqsave(&vu_dev->sock_lock, flags);
 	rc = full_sendmsg_fds(vu_dev->sock, msg, size, fds, num_fds);
 	if (rc < 0)
 		goto out;
@@ -267,7 +267,7 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	}
 
 out:
-	spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
+	raw_spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
 	return rc;
 }
 
@@ -1220,7 +1220,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 		goto error_free;
 	vu_dev->sock = rc;
 
-	spin_lock_init(&vu_dev->sock_lock);
+	raw_spin_lock_init(&vu_dev->sock_lock);
 
 	rc = vhost_user_init(vu_dev);
 	if (rc)
-- 
2.39.5


