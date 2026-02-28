Return-Path: <stable+bounces-220668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGJJGuA+o2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:15:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD3D1C6C0F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23791303B4F4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9CD3F4291;
	Sat, 28 Feb 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPRfWGwF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7853F428B;
	Sat, 28 Feb 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300550; cv=none; b=aH5+cPF7a3HVESg/pgcCO0ddAbAYdbuG7hR9SZ1hPg/U+wmzN2nPSOLr7iDl57W6pMRXf6Sjk6X2tBfLAow0jQ160rLrAiHW4eLnTyUXqboSjJU6DbCDahdkvppwtMgXre87Sh4MruY4L6AMpyEFNqSrDMZzJO9oo5UHkHAu6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300550; c=relaxed/simple;
	bh=GQKo0lJwUgci+4iLYMerITetvNArF4HuD8WCFFnS5BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rh0GW4OMRpHJC1+HpTTCJ01jqQvTXNNe0hFwUqAdXsKJX5H58o89O5vruY5zB83RFQaFdSd9uCg3zYyqIzvyK2JDPzobAEm1c7ddQyBoiYQ10zk7Dwhi09ne6HQE+AKgYYIskB3Nfu4e8DuvHU43SpPdeiPM77nKpSMtxVSgqD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPRfWGwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E93C19423;
	Sat, 28 Feb 2026 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300549;
	bh=GQKo0lJwUgci+4iLYMerITetvNArF4HuD8WCFFnS5BU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LPRfWGwF84wqBrWy8jGzx3/BW9JHAf6bNWyBZjohBUGU/uslFFuKmvlXSXJiJfZ3o
	 P3jCxNEjqYmFHJg+zSzZO58HdQgaOKygFEOvtLyJQgV/f97fHN44yfTlQ2tRamVKWN
	 VGgkvlI1a7HBQO0j8ISh0ACosTCxBTlnzLkcWEXOzZQ2QTxz5dCrYSTNg9jRtX5EdS
	 VrLauKveQCt1rwAtd1TQ4Fwde/PbWNv6kr+Pjy3lEwozBlVCyjbGacQmB3Nk7fHzyl
	 cxBO8plvG5MImlcQpD4xN+ryoL1jaUIHgrBDf4tHKhUnmbvJgI2GA00vI7FIenOyfj
	 UpSrYCaIWTLJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 589/844] media: ccs: Fix setting initial sub-device state
Date: Sat, 28 Feb 2026 12:28:22 -0500
Message-ID: <20260228173244.1509663-590-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220668-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DAD3D1C6C0F
X-Rspamd-Action: no action

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 31e5191aa11931b53e1242acef4f4375f00ca523 ]

Fix setting sub-device state for non-source sub-devices.

Fixes: 5755be5f15d9 ("media: v4l2-subdev: Rename .init_cfg() operation to .init_state()")
Cc: stable@vger.kernel.org # for v6.8 and later
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/ccs/ccs-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ccs/ccs-core.c b/drivers/media/i2c/ccs/ccs-core.c
index 3cacc7d904935..8d30e808a635b 100644
--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -2940,6 +2940,8 @@ static void ccs_cleanup(struct ccs_sensor *sensor)
 	ccs_free_controls(sensor);
 }
 
+static const struct v4l2_subdev_internal_ops ccs_internal_ops;
+
 static int ccs_init_subdev(struct ccs_sensor *sensor,
 			   struct ccs_subdev *ssd, const char *name,
 			   unsigned short num_pads, u32 function,
@@ -2952,8 +2954,10 @@ static int ccs_init_subdev(struct ccs_sensor *sensor,
 	if (!ssd)
 		return 0;
 
-	if (ssd != sensor->src)
+	if (ssd != sensor->src) {
 		v4l2_subdev_init(&ssd->sd, &ccs_ops);
+		ssd->sd.internal_ops = &ccs_internal_ops;
+	}
 
 	ssd->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	ssd->sd.entity.function = function;
@@ -3062,6 +3066,10 @@ static const struct media_entity_operations ccs_entity_ops = {
 	.link_validate = v4l2_subdev_link_validate,
 };
 
+static const struct v4l2_subdev_internal_ops ccs_internal_ops = {
+	.init_state = ccs_init_state,
+};
+
 static const struct v4l2_subdev_internal_ops ccs_internal_src_ops = {
 	.init_state = ccs_init_state,
 	.registered = ccs_registered,
-- 
2.51.0


