Return-Path: <stable+bounces-227286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGUfJzzyu2nkqQIAu9opvQ
	(envelope-from <stable+bounces-227286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:55:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817F2CB74D
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34D25306E617
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041E93D3339;
	Thu, 19 Mar 2026 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCAjrs/G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84E3C3C01
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924785; cv=none; b=Kto3BDyH0PojboI0d979J73dyIYu76mzjfbNhspjKg77IU6B0DaMHlhcdQOn7nimgU8E8Nzc2v7b/7WM6epjmF5WY1GmUwc0bP1jHIhbDTGmBHuw0Jz0PTK0+c9U7Dt4l8pzWkKiVYzmS4U9gzhN7cFZhe/ounfMVPDExgWNZqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924785; c=relaxed/simple;
	bh=VS4Bva7twUM4AimrbsKw6qlBBzXS/aw6S9yaeoiS6I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYNHzlw6bFGcODkAtrpILfW1OGKMEtXQL/hMueRu6R97SYPzC5vRpQez7p6RGErSdbf0pIXjRLgJRPOgmffvFkKolYByxP9Zz3PfXlEJVvKRCPi6CGToya0+1MIqrVFpWiMBqxa6JHu1kkpyJ/8T66ZKszRI75qPR4byR967u9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCAjrs/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9273C19424;
	Thu, 19 Mar 2026 12:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773924785;
	bh=VS4Bva7twUM4AimrbsKw6qlBBzXS/aw6S9yaeoiS6I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCAjrs/GZnpZcVX+ocBunXZU9XjDtahDqrdT0JYdOY8fj6O+axrk+bGH7emT5v8bt
	 CLwmxW/G8QZV3QlaU0zl2QO4j8GQFWbIszGMe5OHPw8Dk43uqTdvpufMBM29zTaFgi
	 tci325VZIxeHvuz9MYZm7Q9D89qB7pD2DzIy30hlftKntkwQ61MBUwQVlHz4yujJbd
	 LZ1AkffcX4O5UQcAby8vjl1xMSCgcQj1s2+iaYRhTzfzM5r+Yko8IrWz79yp3EZVOF
	 u4KCqlHBH+kO78xan0mFhrR1SePfL/t5pnrNPLWE7WOiI2E0E6brvTRI+2NPfW6Lm9
	 xc32YQMrDrdVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mehul Rao <mehulrao@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ublk: fix NULL pointer dereference in ublk_ctrl_set_size()
Date: Thu, 19 Mar 2026 08:53:03 -0400
Message-ID: <20260319125303.2390790-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031728-bunch-limelight-a7e5@gregkh>
References: <2026031728-bunch-limelight-a7e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.dk,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227286-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: 1817F2CB74D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mehul Rao <mehulrao@gmail.com>

[ Upstream commit 25966fc097691e5c925ad080f64a2f19c5fd940a ]

ublk_ctrl_set_size() unconditionally dereferences ub->ub_disk via
set_capacity_and_notify() without checking if it is NULL.

ub->ub_disk is NULL before UBLK_CMD_START_DEV completes (it is only
assigned in ublk_ctrl_start_dev()) and after UBLK_CMD_STOP_DEV runs
(ublk_detach_disk() sets it to NULL). Since the UBLK_CMD_UPDATE_SIZE
handler performs no state validation, a user can trigger a NULL pointer
dereference by sending UPDATE_SIZE to a device that has been added but
not yet started, or one that has been stopped.

Fix this by checking ub->ub_disk under ub->mutex before dereferencing
it, and returning -ENODEV if the disk is not available.

Fixes: 98b995660bff ("ublk: Add UBLK_U_CMD_UPDATE_SIZE")
Cc: stable@vger.kernel.org
Signed-off-by: Mehul Rao <mehulrao@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ adapted `&header` to `header` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 965460d4fc76e..2729b1556e810 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3604,15 +3604,22 @@ static int ublk_ctrl_get_features(const struct ublksrv_ctrl_cmd *header)
 	return 0;
 }
 
-static void ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
+static int ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_cmd *header)
 {
 	struct ublk_param_basic *p = &ub->params.basic;
 	u64 new_size = header->data[0];
+	int ret = 0;
 
 	mutex_lock(&ub->mutex);
+	if (!ub->ub_disk) {
+		ret = -ENODEV;
+		goto out;
+	}
 	p->dev_sectors = new_size;
 	set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
+out:
 	mutex_unlock(&ub->mutex);
+	return ret;
 }
 
 struct count_busy {
@@ -3902,8 +3909,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_end_recovery(ub, header);
 		break;
 	case UBLK_CMD_UPDATE_SIZE:
-		ublk_ctrl_set_size(ub, header);
-		ret = 0;
+		ret = ublk_ctrl_set_size(ub, header);
 		break;
 	case UBLK_CMD_QUIESCE_DEV:
 		ret = ublk_ctrl_quiesce_dev(ub, header);
-- 
2.51.0


