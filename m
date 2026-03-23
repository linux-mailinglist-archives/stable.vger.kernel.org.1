Return-Path: <stable+bounces-228949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCq/EfBYwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-228949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:14:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3572F60AD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C48333550C4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1E3AE6E1;
	Mon, 23 Mar 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m/uTThII"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448623C4FF;
	Mon, 23 Mar 2026 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277580; cv=none; b=ows17Vd9TfVomyK+gZbFGjp9t7UW0j5r1NxZtEYGk2eTENPXqjm6GKtDEG8uGLvyTx0AVo9JgeylX/ojl7zLHbB+DThD/XfxmLYIfrhroT8wFNcBKIRtRrWJe7xqOcj0BH3K2iZVp6aAS9J1z+w93vO0wOA1TK+8+/Ffnhg1clI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277580; c=relaxed/simple;
	bh=1KCrG6n4qxDQcalfWTM2z2ykFMn8qKn1Yr/kk1lYkgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1TMwlTL0xX/kt3yWUfBV8cZ0MUCtCtg/IkCwO+pUp+RA62T49mY3XgOyPRKozW+5sr7tTQbAksKou9WBYfxb4aycgdtGQu0YVgurpr410bB9UqCZ1R5gartOXR6frhQNQ27FCsSKifx1KdMmGx9ypP92QufacudBtXNt5mXv3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m/uTThII; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EFDC4CEF7;
	Mon, 23 Mar 2026 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277579;
	bh=1KCrG6n4qxDQcalfWTM2z2ykFMn8qKn1Yr/kk1lYkgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m/uTThIIWSDsx3t205dHJswW/ShOejKlpq/rLcME4OOaQENa/TYiq9qPDQGFL00AJ
	 f1wYcuPiW9nCzf8Odt153z4WjjhrBk8j83JUfHdjb467jio4c26ewKswAlNR7Yfb+p
	 k0BNNoF9TXvEV8VDowpXnQfZpl3nFcXcweY4jDo0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 038/567] media: tegra-video: Fix memory leak in __tegra_channel_try_format()
Date: Mon, 23 Mar 2026 14:39:18 +0100
Message-ID: <20260323134534.739554541@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-228949-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9F3572F60AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index a2f21c70a5bc8..e8ba23e5bcde0 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -440,7 +440,7 @@ static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
 		.target = V4L2_SEL_TGT_CROP_BOUNDS,
 	};
 	struct v4l2_rect *try_crop;
-	int ret;
+	int ret = 0;
 
 	subdev = tegra_channel_get_remote_source_subdev(chan);
 	if (!subdev)
@@ -484,8 +484,10 @@ static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
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
@@ -497,14 +499,15 @@ static int __tegra_channel_try_format(struct tegra_vi_channel *chan,
 
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




