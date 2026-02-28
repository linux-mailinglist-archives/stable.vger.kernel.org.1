Return-Path: <stable+bounces-220648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SExDI/NRo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:37:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E43931C872D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E70A367E5DB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8983EDF19;
	Sat, 28 Feb 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ/zi3C8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224063EEEFA;
	Sat, 28 Feb 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300530; cv=none; b=GKGgG7tdkkDAarh1fO03bhT8x/ue0w4uFO1NWDqpC1VYLo5bD3cBEi5O+UUJdcCPovcHwDvA1u1DcsDgf95fUzEDO7IS0jCFHXNXRDRa4EmFw+B7JOvYPP7Wh8iaudBGaF1cL7i25Ej4MdaREnDTb6JXhJ+fTMYS657N0Z8CKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300530; c=relaxed/simple;
	bh=jTSiQC9oqbGfXKaSWS6H02vRGlzbFECj8Q/rj0mZThc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jihl4hkS3+uyH1TTMla6wNLwf5zg4FOQSaO5+2lnRy3i4xXITTMPfv3RHt5oCpnoyyISMf9fKatx4YRLvcrWz0Q6VRCDe878aXQAC8mZgzVwK6u4tp9wAWpyd8itAKc+GoP9wxAyS2IsJ+pAaikndilu0As6V+pUZ4lenDUWg1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ/zi3C8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C18CC116D0;
	Sat, 28 Feb 2026 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300530;
	bh=jTSiQC9oqbGfXKaSWS6H02vRGlzbFECj8Q/rj0mZThc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJ/zi3C809uCdo8mxVIsGZGrQETXlWscnE3fyEMPG5IGLyM84FZagk/YZlYXh7bEE
	 7sHimypY3leO1hv8BjnmPSKn57kkkDPqG2Pf96tp6mHUwwYQ0aZC6HguduA8IuQznp
	 vlzzNzsTf7gBEIY5BAADe/lFUF7FZ9xep/7wBe5wLgDBABBFNZREVzplCBAa8NdvJK
	 PpdZDz4oeRS4a+dcr5i+V1BGQaGRNf7HZlIDvpq+2gQSu+HrP4mMFd+nzJaY2WQRuy
	 0yjjCkYsR8BMdHz3OFABxjqs0v5WcQAw9r+xXhFpZ3ZlDT0KUcJWEL+OfnSq7GY9i/
	 mdHVQwDIZv2mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zilin Guan <zilin@seu.edu.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 569/844] media: tegra-video: Fix memory leak in __tegra_channel_try_format()
Date: Sat, 28 Feb 2026 12:28:02 -0500
Message-ID: <20260228173244.1509663-570-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220648-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:email]
X-Rspamd-Queue-Id: E43931C872D
X-Rspamd-Action: no action

From: Zilin Guan <zilin@seu.edu.cn>

[ Upstream commit 43e5302d22334f1183dec3e0d5d8007eefe2817c ]

The state object allocated by __v4l2_subdev_state_alloc() must be freed
with __v4l2_subdev_state_free() when it is no longer needed.

In __tegra_channel_try_format(), two error paths return directly after
v4l2_subdev_call() fails, without freeing the allocated 'sd_state'
object. This violates the requirement and causes a memory leak.

Fix this by introducing a cleanup label and using goto statements in the
error paths to ensure that __v4l2_subdev_state_free() is always called
before the function returns.

Fixes: 56f64b82356b7 ("media: tegra-video: Use zero crop settings if subdev has no get_selection")
Fixes: 1ebaeb09830f3 ("media: tegra-video: Add support for external sensor capture")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/tegra-video/vi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index c9276ff76157f..14b327afe045e 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -438,7 +438,7 @@ static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
 		.target = V4L2_SEL_TGT_CROP_BOUNDS,
 	};
 	struct v4l2_rect *try_crop;
-	int ret;
+	int ret = 0;
 
 	subdev = tegra_channel_get_remote_source_subdev(chan);
 	if (!subdev)
@@ -482,8 +482,10 @@ static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
 		} else {
 			ret = v4l2_subdev_call(subdev, pad, get_selection,
 					       NULL, &sdsel);
-			if (ret)
-				return -EINVAL;
+			if (ret) {
+				ret = -EINVAL;
+				goto out_free;
+			}
 
 			try_crop->width = sdsel.r.width;
 			try_crop->height = sdsel.r.height;
@@ -495,14 +497,15 @@ static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
 
 	ret = v4l2_subdev_call(subdev, pad, set_fmt, sd_state, &fmt);
 	if (ret < 0)
-		return ret;
+		goto out_free;
 
 	v4l2_fill_pix_format(pix, &fmt.format);
 	chan->vi->ops->vi_fmt_align(pix, fmtinfo->bpp);
 
+out_free:
 	__v4l2_subdev_state_free(sd_state);
 
-	return 0;
+	return ret;
 }
 
 static int tegra_channel_try_format(struct file *file, void *fh,
-- 
2.51.0


