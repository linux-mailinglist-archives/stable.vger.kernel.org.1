Return-Path: <stable+bounces-116920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4FBA3A9DA
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE803189791C
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0612328137B;
	Tue, 18 Feb 2025 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn2Z3Rz7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0B28136D;
	Tue, 18 Feb 2025 20:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910541; cv=none; b=jr5tNdvCBw8Z5ivBGmpGxk0ld3dF/Mg9Jk2v+53Jd3YniY18ecem18Oj9Pa+RHok9gjBIdzZu6yuzHDV1kclKsNbx6TPSOgAJKBDCKlj7eK0pK7RlHct/+JE161HAuY5v/hBt8hHHtTiUXI5ZgBR5ZcpvPdORCfFn+WODTBEnvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910541; c=relaxed/simple;
	bh=+MCfZ3PiDMVDawojJv/00MM2ynUpq/aZUXJ5oFf0hjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uoyZtpqxtDIdNIaZQmXXKQJifqhO0F5gqPCq/MZ6GpkE9OvLEnLqYPFomPh30I6M6HTiE0vtvNkRuC/aA9J0KpA1QIBh+MfORDkXyo6H2UKKU7SlAYBDCI+AAutjRO1wvgkbhGRTkoLuvNIM3uxQIenScEyPBpKq9z7vVaWixj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn2Z3Rz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D69AC4CEE2;
	Tue, 18 Feb 2025 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910541;
	bh=+MCfZ3PiDMVDawojJv/00MM2ynUpq/aZUXJ5oFf0hjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cn2Z3Rz7G6VRtNkX5E7uHB+MHQZ/eOVcZbsOH7xYJ4dhUvoTVARYw6X1HlcVDYbLK
	 Rrxp59OYk8DjkiNv8oztr+XXRACMb+2+okIXUwEE5Ys3zPJgdwHZgI/QmOc3t2NyrM
	 n1LvRgNKLQIh9AQlHcD3nTiVT6Lkqx36E2SvxK1FBFcwlI8S9xFRG4BpTjN9Hj5Byz
	 AGd97Jph6NeuYvr37dK4PTxf7eG+HYdgc2cZve6uJc4tzIsCMGPqOSqJwa9sV2AO5x
	 M2vRIkjHXJoXCUfPXQXa3soktoThnKPWMWMZP02aFFdbugemKe2nEHKGO2V5nUCrQC
	 GVDQ1FOrhgWJA==
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
Subject: [PATCH AUTOSEL 5.15 6/6] um: virtio_uml: use raw spinlock
Date: Tue, 18 Feb 2025 15:28:47 -0500
Message-Id: <20250218202848.3593863-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202848.3593863-1-sashal@kernel.org>
References: <20250218202848.3593863-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
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
index 204e9dfbff1a0..19fe003932f71 100644
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
 
@@ -1214,7 +1214,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 		goto error_free;
 	vu_dev->sock = rc;
 
-	spin_lock_init(&vu_dev->sock_lock);
+	raw_spin_lock_init(&vu_dev->sock_lock);
 
 	rc = vhost_user_init(vu_dev);
 	if (rc)
-- 
2.39.5


