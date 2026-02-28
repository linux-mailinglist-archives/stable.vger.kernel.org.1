Return-Path: <stable+bounces-220646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OuIH+JRo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:36:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D51401C8718
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C86AF367058C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C03EEECF;
	Sat, 28 Feb 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ1yQrC4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751093EEEC6;
	Sat, 28 Feb 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300528; cv=none; b=lZEzWj8902gFQ78dELkmF1i2I6kpKXRl2s/DWT02r4mh00+6ZWpBEIJe/KDomzgtZvPlqzs0nXwW5LxRRt5Xa5AqGSJPA4mXmvuaygha2eHCyy7KNmPPy1mcfY/P9pJ5J0zLS9yK6wQWbsLFWQ/LFBQDJP8W/tIDaVctFlBhv1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300528; c=relaxed/simple;
	bh=IQjvhalWpQwPlwqWdn/YiZ8Y6HjnHhqlE+4DYC5gzl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fteMP3sxh/swzq4a966gd6j4j5yU8uirpGjp6DB1kVplL7ileIJV14XRj8roiqiy1WqPJCpQj+tSvT4SE68L9JGmEivQlrtndoSlD2w5S43hCih6Cyu7ITzzQrhZav/45UI6wSogiLjM1AIUZKa8sv3Gsh+Ah7HtsdAliCy4bu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ1yQrC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1D9C19423;
	Sat, 28 Feb 2026 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300528;
	bh=IQjvhalWpQwPlwqWdn/YiZ8Y6HjnHhqlE+4DYC5gzl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZJ1yQrC4yuuJV+t8mv9KZwCOdBVNXogPcteMlEJF65TaXQs7phpv27jUMxjpH9IX6
	 Iq9DsBhkeai0nJ1fQrTXPbcUrIgN4+xkcxh6XSU1b0IYOX3aQ1ot/YYu5K9rVBfTMM
	 yQ3VZ7UV6au9ZWGnsExiYqcS16rDBTcdFk/w5mF/abnJsYgCkAxRqPzH4q5m/n35kv
	 aCWDQAEmRA1mi9siXj5Yj5OvP9Ew7IE1P0Ctdf9N+fwmjXFPLvPpKRMQucTLctsIqZ
	 /bS44QB+sWP3W/JaJPdS3Aq+IXvHy92imT+6EA75ndmuT5Txvd2Q+/SW2sWAROw9ht
	 BUpC5/9zicYIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alper Ak <alperyasinak1@gmail.com>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 567/844] media: rockchip: rga: Fix possible ERR_PTR dereference in rga_buf_init()
Date: Sat, 28 Feb 2026 12:28:00 -0500
Message-ID: <20260228173244.1509663-568-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,pengutronix.de,collabora.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220646-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: D51401C8718
X-Rspamd-Action: no action

From: Alper Ak <alperyasinak1@gmail.com>

[ Upstream commit 81f8e0e6a2e115df9274d0289779f8fca694479c ]

rga_get_frame() can return ERR_PTR(-EINVAL) when buffer type is
unsupported or invalid. rga_buf_init() does not check the return value
and unconditionally dereferences the pointer when accessing f->size.

Add proper ERR_PTR checking and return the error to prevent
dereferencing an invalid pointer.

Fixes: 6040702ade23 ("media: rockchip: rga: allocate DMA descriptors per buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rockchip/rga/rga-buf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/rockchip/rga/rga-buf.c b/drivers/media/platform/rockchip/rga/rga-buf.c
index 730bdf98565a5..bb575873f2b24 100644
--- a/drivers/media/platform/rockchip/rga/rga-buf.c
+++ b/drivers/media/platform/rockchip/rga/rga-buf.c
@@ -80,6 +80,9 @@ static int rga_buf_init(struct vb2_buffer *vb)
 	struct rga_frame *f = rga_get_frame(ctx, vb->vb2_queue->type);
 	size_t n_desc = 0;
 
+	if (IS_ERR(f))
+		return PTR_ERR(f);
+
 	n_desc = DIV_ROUND_UP(f->size, PAGE_SIZE);
 
 	rbuf->n_desc = n_desc;
-- 
2.51.0


