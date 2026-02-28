Return-Path: <stable+bounces-220231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AINKMnA0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4CB1C5E52
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 059AB3112F24
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DE54F799B;
	Sat, 28 Feb 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOJeT4Mq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6747CC92;
	Sat, 28 Feb 2026 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300136; cv=none; b=GE2XD7CTICg3t3IokjqrXPksSiYQLC9fL5U+kJU8VplZbV9FNgjqQLkPFno/qlGe8avKq+0lbCjjqVFBaXuXS0S+3cXpXi4U22F7VubMYNBzwmGwpVEEEO/dspFDVaere449m3cGOHxMwMbH7mgHq1p8zDA3pHVdwy+bYVUu3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300136; c=relaxed/simple;
	bh=diWvckYIFXeOe6phtc9YGTOKJ+joKOgIt1D2BRCZP48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJ+lFs8U0H80x8SeVuH5CkJ1N6EocftPIgVpQXuzlzKqd2xRJKkxbzkCDWR9kzbHavP/FsTLlCxjHI1BjLvJW1+AMr5EIhUfU2rui66eJ4PTdwKhURsWfdkGhWtf+DntS+P0gAAXmHz152pbrVz8A9RjltmWc+XsoCxUnYMquoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOJeT4Mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F0EC19423;
	Sat, 28 Feb 2026 17:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300135;
	bh=diWvckYIFXeOe6phtc9YGTOKJ+joKOgIt1D2BRCZP48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IOJeT4MqFws2Wx7mwFVMmdUkrEC8A3f+QPiKvKMNy8KLzbJWC9gYSFwPoFj9Wo7q9
	 HXwbq8r5xgy9yqqK9kjnfDjBWU9aiY+fg24GoNRqtsqxunhuWDEJiodyNq3eg4uq1q
	 XLT7XhlS6tsMbHQ6SEYql+k5UXBhCWbZkLFZg0IKCKUeTKe3InfN8vvuSpo5+/VxWC
	 V21Vs7T4nWhDC2M8DMtsDUZHZRFgipctr6BptH81FSANn9BcGOc6GY/WTC9swd4tgO
	 8X6YFuu0WzxhvmsV9Wfxg0vbylMI12jtP4ea369AhzJ/FbI61E45LPQoVAvEQKndqE
	 RkNpFohRrofNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 153/844] media: omap3isp: isppreview: always clamp in preview_try_format()
Date: Sat, 28 Feb 2026 12:21:06 -0500
Message-ID: <20260228173244.1509663-154-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220231-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1C4CB1C5E52
X-Rspamd-Action: no action

From: Hans Verkuil <hverkuil+cisco@kernel.org>

[ Upstream commit 17e1e1641f74a89824d4de3aa38c78daa5686cc1 ]

If prev->input != PREVIEW_INPUT_MEMORY the width and height weren't
clamped. Just always clamp.

This fixes a v4l2-compliance error:

	fail: v4l2-test-subdevs.cpp(171): fse.max_width == ~0U || fse.max_height == ~0U
	fail: v4l2-test-subdevs.cpp(270): ret && ret != ENOTTY
test Try VIDIOC_SUBDEV_ENUM_MBUS_CODE/FRAME_SIZE/FRAME_INTERVAL: FAIL

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/ti/omap3isp/isppreview.c   | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/ti/omap3isp/isppreview.c b/drivers/media/platform/ti/omap3isp/isppreview.c
index e383a57654de8..5c492b31b5160 100644
--- a/drivers/media/platform/ti/omap3isp/isppreview.c
+++ b/drivers/media/platform/ti/omap3isp/isppreview.c
@@ -1742,22 +1742,17 @@ static void preview_try_format(struct isp_prev_device *prev,
 
 	switch (pad) {
 	case PREV_PAD_SINK:
-		/* When reading data from the CCDC, the input size has already
-		 * been mangled by the CCDC output pad so it can be accepted
-		 * as-is.
-		 *
-		 * When reading data from memory, clamp the requested width and
-		 * height. The TRM doesn't specify a minimum input height, make
+		/*
+		 * Clamp the requested width and height.
+		 * The TRM doesn't specify a minimum input height, make
 		 * sure we got enough lines to enable the noise filter and color
 		 * filter array interpolation.
 		 */
-		if (prev->input == PREVIEW_INPUT_MEMORY) {
-			fmt->width = clamp_t(u32, fmt->width, PREV_MIN_IN_WIDTH,
-					     preview_max_out_width(prev));
-			fmt->height = clamp_t(u32, fmt->height,
-					      PREV_MIN_IN_HEIGHT,
-					      PREV_MAX_IN_HEIGHT);
-		}
+		fmt->width = clamp_t(u32, fmt->width, PREV_MIN_IN_WIDTH,
+				     preview_max_out_width(prev));
+		fmt->height = clamp_t(u32, fmt->height,
+				      PREV_MIN_IN_HEIGHT,
+				      PREV_MAX_IN_HEIGHT);
 
 		fmt->colorspace = V4L2_COLORSPACE_SRGB;
 
-- 
2.51.0


