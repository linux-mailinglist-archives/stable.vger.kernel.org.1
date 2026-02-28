Return-Path: <stable+bounces-220977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGlbBkJJo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:00:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E91C7B62
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3852E317865A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DEE4ADDB6;
	Sat, 28 Feb 2026 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPt4pVgo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2B47CC62;
	Sat, 28 Feb 2026 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301322; cv=none; b=AhHt8Zr2U1VCFVu15fhG/rXGy+Kueu7ykJGSpR12k1zQG5r9Z26nVc5ph1fQxtvg4StdZXs3awIaAo1yz0zdcsV2u7aR6+iDDHUyyP0nIqwNRxmeO0M+2gNvVGEYjez1SSJh18TwWOXoSqahGSLJOKOahw7wuj2JpZt1galjGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301322; c=relaxed/simple;
	bh=IQjvhalWpQwPlwqWdn/YiZ8Y6HjnHhqlE+4DYC5gzl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkZYbXwkUw4TOsOrAPX/6Ai14AkkkrhawgecDHJ6CwIHZkTxCR9sVLWLEfZQyRi572DHnv11paAamhfmJEZAM45s4fMnCXR5a4j1JjZKNq6HC/Wk7KiIiDqZ8FgPpzE1FQWCKoI9jsdctgv18RpXwek1JVEibDiOUVy/HHnVkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPt4pVgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2752AC19423;
	Sat, 28 Feb 2026 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301321;
	bh=IQjvhalWpQwPlwqWdn/YiZ8Y6HjnHhqlE+4DYC5gzl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPt4pVgoQ96djKE739V4Xyv/spkAVS3xvqoscQ1fPbZ3zi9TwYofD56E7cAboX2QT
	 hgNmYP6YbsdhoIjofgiwYt0Xz7I30SiKgwyWQ/KgNfsS17USiY4YaC9pCi8jEAX6Pc
	 VzVS1zI0eX5BjRdW50YUkJ6shos4IoUGyT0Ggf66FFx6pIwFRoV8pS2AgBi+r5wWAU
	 8JEy76ycfyANDpkJa8az+N+6WKaTTFJF8ZBxIIyU5jpMpAmks/cxJXsvo7xNNg3LUX
	 gM8wzwP21mU3es4EYKihPfGPp1ZZdsqtjFvqEXpr/kliNL0iYEI5wpymrEC4D8/kAP
	 /VHrAA6pqaNKQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Alper Ak <alperyasinak1@gmail.com>,
	stable@vger.kernel.org,
	Michael Tretter <m.tretter@pengutronix.de>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 508/752] media: rockchip: rga: Fix possible ERR_PTR dereference in rga_buf_init()
Date: Sat, 28 Feb 2026 12:43:39 -0500
Message-ID: <20260228174750.1542406-508-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,pengutronix.de,collabora.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220977-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A8E91C7B62
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


