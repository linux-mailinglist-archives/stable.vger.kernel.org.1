Return-Path: <stable+bounces-220224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GZ6K/Qxo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E801C5AF4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 261BF31A5853
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468764EA373;
	Sat, 28 Feb 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+2VK+l6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C243EBF04;
	Sat, 28 Feb 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300130; cv=none; b=eGYiEspdPFpQBRk30xd+Yio2ijyTy2WVzcPnKaVKoU588L2BD60zE4ecP321oeIBOa49QG/5sF+gU3rh03RX3VNZIJCv5nz7QpbHtKUqS5HZZY39bx9SCMv+V85O6seVt2pKnl0WsnmVrDO/uzI0sULGtIwo3RLxHSejpjRaosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300130; c=relaxed/simple;
	bh=t10jh7auqoVFgMP5n7zmmJ4OCC6qifmcq7N6D2hKXAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQQJTULXpLnJWVzFHVU7i+8ZWobDhDpVFwHIcr3lG8YwPBlj9Pe3C4BTr8BRyPV4X6j1OhscWRIu4JFKcihfZga6gQTA4gfCwjCnE3mZuenkXZ1HFLJJGZRnF006rvytFyJ4Y8vIQqQHEHFjewZUbsbFFTefMGCLjajFvAzDr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+2VK+l6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCDAC116D0;
	Sat, 28 Feb 2026 17:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300129;
	bh=t10jh7auqoVFgMP5n7zmmJ4OCC6qifmcq7N6D2hKXAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+2VK+l6mUgtozbDWvCHxPo1sWomFjXyN+CoSsybAvwE2Fq2DKIUaNRph+GWwD+UW
	 fwoiqLH/YHZV/wc2zJhSS3iK5ly3GgVLNc0D1kLZDHGyFjHs4VLGXkb2HLAkBna3uD
	 o4ftCaYLxMjq+kYrnrf2L9ZZL1jgWQuyKYn2jWKb8LPf6UJd8kiyKRv4K7XdbejCV/
	 MX3YW7FMsF7WJ7pHXIhIbzLx1re8sJolJdVUyAQPMffknfysBV8wKIEW+UH0faji/A
	 PqIQK0fjb9w3OJA+q50uiJWjHcvzda+refk5+zc5T0cwoLfMlsoLIpQSFaHPy9t5oS
	 LMyMDXiWOe2DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 146/844] media: dvb-core: dmxdevfilter must always flush bufs
Date: Sat, 28 Feb 2026 12:20:59 -0500
Message-ID: <20260228173244.1509663-147-sashal@kernel.org>
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
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220224-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,huawei];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:email]
X-Rspamd-Queue-Id: 18E801C5AF4
X-Rspamd-Action: no action

From: Hans Verkuil <hverkuil@xs4all.nl>

[ Upstream commit c4e620eccbef76aa5564ebb295e23d6540e27215 ]

Currently the buffers are being filled until full, which works fine
for the transport stream, but not when reading sections, those have
to be returned to userspace immediately, otherwise dvbv5-scan will
just wait forever.

Add a 'flush' argument to dvb_vb2_fill_buffer to indicate whether
the buffer must be flushed or wait until it is full.

Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dmxdev.c  | 8 ++++----
 drivers/media/dvb-core/dvb_vb2.c | 5 +++--
 include/media/dvb_vb2.h          | 6 ++++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 8c6f5aafda1d6..17184b3674904 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -397,11 +397,11 @@ static int dvb_dmxdev_section_callback(const u8 *buffer1, size_t buffer1_len,
 	if (dvb_vb2_is_streaming(&dmxdevfilter->vb2_ctx)) {
 		ret = dvb_vb2_fill_buffer(&dmxdevfilter->vb2_ctx,
 					  buffer1, buffer1_len,
-					  buffer_flags);
+					  buffer_flags, true);
 		if (ret == buffer1_len)
 			ret = dvb_vb2_fill_buffer(&dmxdevfilter->vb2_ctx,
 						  buffer2, buffer2_len,
-						  buffer_flags);
+						  buffer_flags, true);
 	} else {
 		ret = dvb_dmxdev_buffer_write(&dmxdevfilter->buffer,
 					      buffer1, buffer1_len);
@@ -452,10 +452,10 @@ static int dvb_dmxdev_ts_callback(const u8 *buffer1, size_t buffer1_len,
 
 	if (dvb_vb2_is_streaming(ctx)) {
 		ret = dvb_vb2_fill_buffer(ctx, buffer1, buffer1_len,
-					  buffer_flags);
+					  buffer_flags, false);
 		if (ret == buffer1_len)
 			ret = dvb_vb2_fill_buffer(ctx, buffer2, buffer2_len,
-						  buffer_flags);
+						  buffer_flags, false);
 	} else {
 		if (buffer->error) {
 			spin_unlock(&dmxdevfilter->dev->lock);
diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
index 29edaaff7a5c9..7444bbc2f24d9 100644
--- a/drivers/media/dvb-core/dvb_vb2.c
+++ b/drivers/media/dvb-core/dvb_vb2.c
@@ -249,7 +249,8 @@ int dvb_vb2_is_streaming(struct dvb_vb2_ctx *ctx)
 
 int dvb_vb2_fill_buffer(struct dvb_vb2_ctx *ctx,
 			const unsigned char *src, int len,
-			enum dmx_buffer_flags *buffer_flags)
+			enum dmx_buffer_flags *buffer_flags,
+			bool flush)
 {
 	unsigned long flags = 0;
 	void *vbuf = NULL;
@@ -306,7 +307,7 @@ int dvb_vb2_fill_buffer(struct dvb_vb2_ctx *ctx,
 		}
 	}
 
-	if (ctx->nonblocking && ctx->buf) {
+	if (flush && ctx->buf) {
 		vb2_set_plane_payload(&ctx->buf->vb, 0, ll);
 		vb2_buffer_done(&ctx->buf->vb, VB2_BUF_STATE_DONE);
 		list_del(&ctx->buf->list);
diff --git a/include/media/dvb_vb2.h b/include/media/dvb_vb2.h
index 8cb88452cd6c2..0fbbfc65157e6 100644
--- a/include/media/dvb_vb2.h
+++ b/include/media/dvb_vb2.h
@@ -124,7 +124,7 @@ static inline int dvb_vb2_release(struct dvb_vb2_ctx *ctx)
 	return 0;
 };
 #define dvb_vb2_is_streaming(ctx) (0)
-#define dvb_vb2_fill_buffer(ctx, file, wait, flags) (0)
+#define dvb_vb2_fill_buffer(ctx, file, wait, flags, flush) (0)
 
 static inline __poll_t dvb_vb2_poll(struct dvb_vb2_ctx *ctx,
 				    struct file *file,
@@ -166,10 +166,12 @@ int dvb_vb2_is_streaming(struct dvb_vb2_ctx *ctx);
  * @buffer_flags:
  *		pointer to buffer flags as defined by &enum dmx_buffer_flags.
  *		can be NULL.
+ * @flush:	flush the buffer, even if it isn't full.
  */
 int dvb_vb2_fill_buffer(struct dvb_vb2_ctx *ctx,
 			const unsigned char *src, int len,
-			enum dmx_buffer_flags *buffer_flags);
+			enum dmx_buffer_flags *buffer_flags,
+			bool flush);
 
 /**
  * dvb_vb2_poll - Wrapper to vb2_core_streamon() for Digital TV
-- 
2.51.0


