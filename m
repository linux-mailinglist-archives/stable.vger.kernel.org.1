Return-Path: <stable+bounces-116844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16547A3A904
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893DC1898518
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80871E0DB5;
	Tue, 18 Feb 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2RJjHKt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F171E04BB;
	Tue, 18 Feb 2025 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910340; cv=none; b=Rq094EppmpyoWH9YabISIIb65uftzIX59TosPCXJMPt2cJNzg7gtxswXNjhKjvhBKBYm/hn0MIptEPZFEwr9+gJPDXPAfJr5ROUeBIVP7XK0AhX7frSPUO4iU7O0i5nxJ8twXXZmdseUCZG0x3X5dFKO/SQ/nOCa82Gii7IRcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910340; c=relaxed/simple;
	bh=ipAIJe/cD23BYEy/ee0ricZfs49Uy6vVbjyTxyzQdN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gSIKpNW1sZP4kECurhIF55w85M9IVbdLZQC+3BPruuOx8F7wfYC/6V75w7K34/U/qamSnSm1eNLzOi/s4ZQhb5dZuy9/riDjiuoxIycW40pLJQ9U21UENpd3HHCqJ5zQzbZZ7bZqB/i3FXr+Ykauo4LSDW9FX2WY7tJ62Tj19dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2RJjHKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC4BC4CEE4;
	Tue, 18 Feb 2025 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910340;
	bh=ipAIJe/cD23BYEy/ee0ricZfs49Uy6vVbjyTxyzQdN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2RJjHKtx/YnetTitxmJYu7zy95zKHDHO/tN02HXhBhjS35ilr4uZXQm3wemHqP7M
	 yWF76NUjjTeJCkPd5mVrH33murJjy6qzG33zpimq5bICDatqWNGg1pqQGFoQ5aqBgH
	 BpCR1pOUfp6hYC5/LXQEiung5ZfJ9/GqsbAUqK2AdEu+HqhswECr4gqMQaPWiExRiy
	 EI0Nag1TRQR2Z5mBYHBCmkmp9+qZ9Z3cAy69YqLATFHxgQp3O/2UsRmStayDqst0Jv
	 2CDLLtR4oBAAnBmDl8JGJ0YEqPxpBgcb9OTUyLM7ixlpRBwyI7YuqXGna/MwnQ+YZV
	 DGUbGc/uj3+OA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	jiri@resnulli.us,
	tiwei.btw@antgroup.com,
	u.kleine-koenig@pengutronix.de,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 22/31] um: virtio_uml: use raw spinlock
Date: Tue, 18 Feb 2025 15:24:42 -0500
Message-Id: <20250218202455.3592096-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
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
index 65df43fa9be58..ad8d78fb1d9aa 100644
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
@@ -246,7 +246,7 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	if (request_ack)
 		msg->header.flags |= VHOST_USER_FLAG_NEED_REPLY;
 
-	spin_lock_irqsave(&vu_dev->sock_lock, flags);
+	raw_spin_lock_irqsave(&vu_dev->sock_lock, flags);
 	rc = full_sendmsg_fds(vu_dev->sock, msg, size, fds, num_fds);
 	if (rc < 0)
 		goto out;
@@ -266,7 +266,7 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	}
 
 out:
-	spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
+	raw_spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
 	return rc;
 }
 
@@ -1239,7 +1239,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 		goto error_free;
 	vu_dev->sock = rc;
 
-	spin_lock_init(&vu_dev->sock_lock);
+	raw_spin_lock_init(&vu_dev->sock_lock);
 
 	rc = vhost_user_init(vu_dev);
 	if (rc)
-- 
2.39.5


