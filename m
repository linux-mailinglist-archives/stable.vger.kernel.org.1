Return-Path: <stable+bounces-220998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FFYBPNHo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 890151C7830
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0971344FBE9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F174BC00C;
	Sat, 28 Feb 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e88zCJ5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F0A4BC002;
	Sat, 28 Feb 2026 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301342; cv=none; b=gF2GQ9kFG5PaF8YFj0JKpSnbUtcb7XS4JPcn0FElxINMpnN+3AjtME+VrpRgAR6JZ0efJpNGNTruagfu9cZQFdtnLNVMO2n4YyfXJw1EctcDjSpucF6cwqrzo11q48ePWBLCGEyWcx78y9J21vBHXOCEQZ6RBSge75q1q9OeF64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301342; c=relaxed/simple;
	bh=kpzNSLO0+nDpaFQyrjX+Cxy8Ilx+5nvWcG0HcKXLtJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lYqpuRS0HE6LXfLZQgjclEkKz0HQFdQb/NEzyTJoudPUyaB4VNlT0deQwRPxQ7Ndq74+ij+cw/+eaeG73dQEtllTxuAzjyyGkHHwhIz+DkZ9KyggV4oR2ybuRgNvrHUf/ASNk1b0Pkp/QuLpXtHtB/3ln7WwrIatI3REe3b+Wms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e88zCJ5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56B0C19425;
	Sat, 28 Feb 2026 17:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301342;
	bh=kpzNSLO0+nDpaFQyrjX+Cxy8Ilx+5nvWcG0HcKXLtJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e88zCJ5uU0Y6qOW062GBykNAqkphJCD6RHmQKQlA82CAwZMkUzjhmgu2Ck7iS0Lkg
	 NcvRTRbzV5zAKsbph2BTypI+QgkaKRRsOjhM/iA9HWljSy8tm7WgpsY5sITScHw7W6
	 jEtk0ZIFcaP1jCE+5AMaUMH1A//qEqqEgPdLahm715yYC8usdyxvs0y/z/ZjBHgYu2
	 vS5UlwrYQRChMHdNwo/nKOhb31oRMPSPzC2M+7SNNfQNaqqVPECm3J3hHegow8tVyJ
	 9w9keHa1hsT2/dy5ba9ptUdgWICd200QmyrjxJTQ0laKXoHIqGKRusO4zx77wyBCNc
	 VuaFSkmf0L0AQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 529/752] media: ccs: Fix setting initial sub-device state
Date: Sat, 28 Feb 2026 12:44:00 -0500
Message-ID: <20260228174750.1542406-529-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220998-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 890151C7830
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
index 01ddfa332c700..3f7162f3d1e32 100644
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


