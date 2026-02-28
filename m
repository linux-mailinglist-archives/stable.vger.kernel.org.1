Return-Path: <stable+bounces-220626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qErFBgpBo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:24:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 858AD1C6F2E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C977A355721F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E1B3E7C66;
	Sat, 28 Feb 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwKb2chR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E8A3E7C5A;
	Sat, 28 Feb 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300509; cv=none; b=hvDWvl2aLBRYqT3tWLv49WAiW25e472a2vPeq6uoCP/goFwJyZvqPXaEZfzcIgwf8eqjJ4z1MCm0u27GlxvIDY5/uLSI92TWvAEV/yW+iynFd5qQEQgrSGaO3aqgxNyBh7O4iydqD3YnSfMicmrTAoxxMY9eok/VT3Vcstkay64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300509; c=relaxed/simple;
	bh=KfCY36v7csohLFe6Tj9FcXVGf/LUUQD4ry8UwLdhics=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSbUe0iplad/PhpHLMJAADYc825K6GG2iVtS+IeKsw3vnxA4P46nbblqpnyQvWuScGQAkD0t3q/qDdmY7hZy276kovYRo1mYPO9X65gGV/sPwUBH7Ypm0eFPsVV0Co8MsUEvkAw57NZrXggagDKpZH19OXATpklJZFE0njHLvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwKb2chR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DEEC19424;
	Sat, 28 Feb 2026 17:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300509;
	bh=KfCY36v7csohLFe6Tj9FcXVGf/LUUQD4ry8UwLdhics=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwKb2chRJs6RnosDunUb4x1z4kukafK9rdxqZ8zKUJysEOhdo9zo51b+Soki+SPiu
	 9pvrdjDa0a/AGK+J4N2ZQojoUcgDQK21poipIC203VDlpps/qABj6qmit8gPcJbY2R
	 93S04h8JNgdm+M30hQAFk/lh/ki+6gBK8b4ZmhxWuC+y5TnPDQLvy1xHRnhMph4BW+
	 w6JNomUQlRSNevz1SUf0Tep7Oa4apO0bcN15ezQORgEatJPlSwpC/37AP0AuPqRLWT
	 Xrocdu+4CZ3jDModJrUqzdvcKpwakPmhJiroQImf9O6LZwU9UTO4UMqyRXy6fHGLET
	 Wppp0oDp6kZKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 547/844] media: v4l2-mem2mem: Add a kref to the v4l2_m2m_dev structure
Date: Sat, 28 Feb 2026 12:27:40 -0500
Message-ID: <20260228173244.1509663-548-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220626-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email,nxp.com:email]
X-Rspamd-Queue-Id: 858AD1C6F2E
X-Rspamd-Action: no action

From: Nicolas Dufresne <nicolas.dufresne@collabora.com>

[ Upstream commit db6b97a4f8041e479be9ef4b8b07022636c96f50 ]

Adding a reference count to the v4l2_m2m_dev structure allow safely
sharing it across multiple hardware nodes. This can be used to prevent
running jobs concurrently on m2m cores that have some internal resource
sharing.

Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[hverkuil: fix typos in v4l2_m2m_put documentation]
Stable-dep-of: e0203ddf9af7 ("media: verisilicon: Avoid G2 bus error while decoding H.264 and HEVC")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-mem2mem.c | 23 +++++++++++++++++++++++
 include/media/v4l2-mem2mem.h           | 21 +++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
index fec93c1a92317..ae0de54d4c3e1 100644
--- a/drivers/media/v4l2-core/v4l2-mem2mem.c
+++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
@@ -90,6 +90,7 @@ static const char * const m2m_entity_name[] = {
  * @job_work:		worker to run queued jobs.
  * @job_queue_flags:	flags of the queue status, %QUEUE_PAUSED.
  * @m2m_ops:		driver callbacks
+ * @kref:		device reference count
  */
 struct v4l2_m2m_dev {
 	struct v4l2_m2m_ctx	*curr_ctx;
@@ -109,6 +110,8 @@ struct v4l2_m2m_dev {
 	unsigned long		job_queue_flags;
 
 	const struct v4l2_m2m_ops *m2m_ops;
+
+	struct kref kref;
 };
 
 static struct v4l2_m2m_queue_ctx *get_queue_ctx(struct v4l2_m2m_ctx *m2m_ctx,
@@ -1200,6 +1203,7 @@ struct v4l2_m2m_dev *v4l2_m2m_init(const struct v4l2_m2m_ops *m2m_ops)
 	INIT_LIST_HEAD(&m2m_dev->job_queue);
 	spin_lock_init(&m2m_dev->job_spinlock);
 	INIT_WORK(&m2m_dev->job_work, v4l2_m2m_device_run_work);
+	kref_init(&m2m_dev->kref);
 
 	return m2m_dev;
 }
@@ -1211,6 +1215,25 @@ void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev)
 }
 EXPORT_SYMBOL_GPL(v4l2_m2m_release);
 
+void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev)
+{
+	kref_get(&m2m_dev->kref);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_get);
+
+static void v4l2_m2m_release_from_kref(struct kref *kref)
+{
+	struct v4l2_m2m_dev *m2m_dev = container_of(kref, struct v4l2_m2m_dev, kref);
+
+	v4l2_m2m_release(m2m_dev);
+}
+
+void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev)
+{
+	kref_put(&m2m_dev->kref, v4l2_m2m_release_from_kref);
+}
+EXPORT_SYMBOL_GPL(v4l2_m2m_put);
+
 struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
 		void *drv_priv,
 		int (*queue_init)(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq))
diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
index bf6a09a04dcf8..31de25d792b98 100644
--- a/include/media/v4l2-mem2mem.h
+++ b/include/media/v4l2-mem2mem.h
@@ -547,6 +547,27 @@ v4l2_m2m_register_media_controller(struct v4l2_m2m_dev *m2m_dev,
  */
 void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev);
 
+/**
+ * v4l2_m2m_get() - take a reference to the m2m_dev structure
+ *
+ * @m2m_dev: opaque pointer to the internal data to handle M2M context
+ *
+ * This is used to share the M2M device across multiple devices. This
+ * can be used to avoid scheduling two hardware nodes concurrently.
+ */
+void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev);
+
+/**
+ * v4l2_m2m_put() - remove a reference to the m2m_dev structure
+ *
+ * @m2m_dev: opaque pointer to the internal data to handle M2M context
+ *
+ * Once the M2M device has no more references, v4l2_m2m_release() will be
+ * called automatically. Users of this method should never call
+ * v4l2_m2m_release() directly. See v4l2_m2m_get() for more details.
+ */
+void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev);
+
 /**
  * v4l2_m2m_ctx_init() - allocate and initialize a m2m context
  *
-- 
2.51.0


