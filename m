Return-Path: <stable+bounces-220232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBK6KD8yo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F070F1C5B5A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10D831BC309
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9DF301EF3;
	Sat, 28 Feb 2026 17:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhdAuNtl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45BA301EEA;
	Sat, 28 Feb 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300136; cv=none; b=gI+ZbXUy+pA6Ons+mTwbW4v5W2wsrLl9o4IN9POH1cEsiZP7TWKFjuJ0RQNbJhyJ73tmfjEtxqHvGs4GDOsBBiKl889Zf8KTgqD9+RCsBfJ43gG5IbcEQfPWLFQu4lO3i0qxF8AOSwrofjb3zw+FFZUKax5B0sBeWpTcuCRYnns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300136; c=relaxed/simple;
	bh=jxCt0uMfHKs951p72ivQYkem2ETitUUGW3QD0odWOgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgqwOynMD/u6bGQb/+yv6eZoIxZx2ft4w2vU5yyzpY19pj/tcnMGkVRR00wn2Skh5NoKw9i57+K55a8DHpd37BUESMBqC6KPd/K2QkETlnox2UIa1/bgqXE9n5MIAuTZRgGK6Zgz/YqeHH6y2GBnWr749G5ahKOSzsAneQwdXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhdAuNtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09D8C116D0;
	Sat, 28 Feb 2026 17:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300136;
	bh=jxCt0uMfHKs951p72ivQYkem2ETitUUGW3QD0odWOgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhdAuNtlxjtOLTbF/o+6uyYc2BtiCP86OFLrXf0z8QYvy9YB8AWCsQtHiG0g3EVX5
	 48Tvu9OKirE+qlD8AGUYoKy1pV5e8g+9UDqKfufFw/PDolxMim6tRNWlBq5HVlrCtm
	 8mWM92ctQMf0w84n7f2N5vn/zDEZj0kzHHfik0TH1DNby2mHuzvpuIbXX002L3cPEV
	 cxYcrkTdV5yRYCUV/50DLt9aUw7tUC2OWmvKH83D7Ri5r/OEGOesZ4ZgO1jmPyPaBU
	 KadAopWSHDyipX5n/dLA8exdD0k7Hs1ppc2dAFbBbgX3wbQuldn8GLHE/d4pntcdFd
	 Cawuq4gt6Cf3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 154/844] media: omap3isp: set initial format
Date: Sat, 28 Feb 2026 12:21:07 -0500
Message-ID: <20260228173244.1509663-155-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220232-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F070F1C5B5A
X-Rspamd-Action: no action

From: Hans Verkuil <hverkuil+cisco@kernel.org>

[ Upstream commit 7575b8dfa91f82fcb34ffd5568ff415ac4685794 ]

Initialize the v4l2_format to a default. Empty formats are
not allowed in V4L2, so this fixes v4l2-compliance issues:

	fail: v4l2-test-formats.cpp(514): !pix.width || !pix.height
test VIDIOC_G_FMT: FAIL

Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/ti/omap3isp/ispvideo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/ti/omap3isp/ispvideo.c b/drivers/media/platform/ti/omap3isp/ispvideo.c
index 68e6a24be5614..eb33a776f27c9 100644
--- a/drivers/media/platform/ti/omap3isp/ispvideo.c
+++ b/drivers/media/platform/ti/omap3isp/ispvideo.c
@@ -1288,6 +1288,7 @@ static const struct v4l2_ioctl_ops isp_video_ioctl_ops = {
 static int isp_video_open(struct file *file)
 {
 	struct isp_video *video = video_drvdata(file);
+	struct v4l2_mbus_framefmt fmt;
 	struct isp_video_fh *handle;
 	struct vb2_queue *queue;
 	int ret = 0;
@@ -1330,6 +1331,13 @@ static int isp_video_open(struct file *file)
 
 	memset(&handle->format, 0, sizeof(handle->format));
 	handle->format.type = video->type;
+	handle->format.fmt.pix.width = 720;
+	handle->format.fmt.pix.height = 480;
+	handle->format.fmt.pix.pixelformat = V4L2_PIX_FMT_UYVY;
+	handle->format.fmt.pix.field = V4L2_FIELD_NONE;
+	handle->format.fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
+	isp_video_pix_to_mbus(&handle->format.fmt.pix, &fmt);
+	isp_video_mbus_to_pix(video, &fmt, &handle->format.fmt.pix);
 	handle->timeperframe.denominator = 1;
 
 	handle->video = video;
-- 
2.51.0


