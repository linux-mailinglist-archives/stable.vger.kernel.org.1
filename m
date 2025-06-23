Return-Path: <stable+bounces-156237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF67AE4EBE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9B8F17C92A
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326FA22156B;
	Mon, 23 Jun 2025 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G0u7C+Z2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EFF21CA07;
	Mon, 23 Jun 2025 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712918; cv=none; b=W47MCacRAYKYQsTr67Vftos4TiC81BsIuoBUXs+JsIvDUJEfuOQKXAyHX0k1Hd8sw7cZqYkVchm9LaVPs/ZDWUcvWfey+Xo+OtzMDjgZyJE4tqCE1c1kNlULdIBdEQWL8Jtnp8i3Sp2oWrb5R0KcHxGjeFb00yxzNwYWLAe/lfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712918; c=relaxed/simple;
	bh=F8p8XlXHhlgg9AxD0m9kMSWOGS+yP6cyz6s4i2rWkSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxK9CizTXKyVPgA5Onv0AmggfcQoDb9y37yIPt8gd70r5vm7wgvHWrcaNot7Ys8Z35iXwzeaThlrvQmLsg52Sdv24TlISN3ctS7Abv3gnetxs8Q2Rx3mYXnuABs1VyCMKUp3pA0ymrcpWMFWPVVo3qWYq5biKEtSZWac77iZUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G0u7C+Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52611C4CEEA;
	Mon, 23 Jun 2025 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750712918;
	bh=F8p8XlXHhlgg9AxD0m9kMSWOGS+yP6cyz6s4i2rWkSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0u7C+Z2KAICexeIwtkRPoWRzg+OlTMMpGsF+UvxCWbSo6697OmWaA5jRgg6Ut5ES
	 qaGPawB0SBQnpaOOUbSUjRWPPR4nkLhrO7xnxm2AADBQv1l3+jwjpp89SBTCCksW5X
	 7+el2eCL+izDtWV/VJe3SV+bzluydgc/rozbPGb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Maxime Ripard <mripard@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 155/222] media: tc358743: ignore video while HPD is low
Date: Mon, 23 Jun 2025 15:08:10 +0200
Message-ID: <20250623130616.744388858@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130611.896514667@linuxfoundation.org>
References: <20250623130611.896514667@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit 6829c5b5d26b1be31880d74ec24cb32d2d75f1ae ]

If the HPD is low (happens if there is no EDID or the
EDID is being updated), then return -ENOLINK in
tc358743_get_detected_timings() instead of detecting video.

This avoids userspace thinking that it can start streaming when
the HPD is low.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Tested-by: Maxime Ripard <mripard@kernel.org>
Link: https://lore.kernel.org/linux-media/20240628-stoic-bettong-of-fortitude-e25611@houat/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/tc358743.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index f042570bc5cae..f4ebe93a495c4 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -309,6 +309,10 @@ static int tc358743_get_detected_timings(struct v4l2_subdev *sd,
 
 	memset(timings, 0, sizeof(struct v4l2_dv_timings));
 
+	/* if HPD is low, ignore any video */
+	if (!(i2c_rd8(sd, HPD_CTL) & MASK_HPD_OUT0))
+		return -ENOLINK;
+
 	if (no_signal(sd)) {
 		v4l2_dbg(1, debug, sd, "%s: no valid signal\n", __func__);
 		return -ENOLINK;
-- 
2.39.5




