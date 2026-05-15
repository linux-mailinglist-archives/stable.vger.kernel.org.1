Return-Path: <stable+bounces-247858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJ+1D/JpB2pA2QIAu9opvQ
	(envelope-from <stable+bounces-247858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:46:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 946BF55675E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BA17313DD50
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073CA3FF1D1;
	Fri, 15 May 2026 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7Zp0jVY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE32C3FF1A0;
	Fri, 15 May 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860252; cv=none; b=ubtENazVo+dmEMPIdtCiJUb+CjigY7CmxBlCJn6m/XiLyMp77P/9TVDJ21f8WbdbjcXswsjdXPYUd8nVbSs6eI4bmv3ioSMjGV42UAN/z6gPjrYgOiZX1OHD6M1LVv4dmZsdUCs1U7LVAEW54Rw70bUHRlUXsCIdgnE7UjZM1VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860252; c=relaxed/simple;
	bh=Ds6C+7cgT01GdYv8ATgRY6US0Kd79d0KWCUjzIIaK/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN8haRnfVC2QLujzj4SC0fhYWT+h87M+8/NNSSzW5Iuh2X61pzyswG5TTQSxKGSYYTjeFlw0XsVcKiaHE4YbMRHutp4I2ZkZkoWazdi3XZD0ZB5umxp4xUDLvqOR3P4F4Vn0qqRmwtB5lEjRHMvwk2F7VMnICmYYBVpnkVOk/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a7Zp0jVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DF9C2BCB0;
	Fri, 15 May 2026 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860252;
	bh=Ds6C+7cgT01GdYv8ATgRY6US0Kd79d0KWCUjzIIaK/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7Zp0jVYMGC/qoBVpfCA4u1yWMffb4haGBSSPsk/pUp4OrqJ7QiDZiUoiErD2QhUb
	 GKKRWaDhoEOGpb3d7ABpCcAOPfiz0n8y66CyzReJztSidkLi3Z2ckf3KbuH+vDLAZp
	 ndigyyU4c+Wdy6FOz65SjsoZAn9KuxDg+tVBa7qU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.12 006/144] media: chips-media: wave5: add missing spinlock protection for send_eos_event()
Date: Fri, 15 May 2026 17:47:12 +0200
Message-ID: <20260515154653.627734661@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 946BF55675E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[northwestern.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247858-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_SPAM(0.00)[0.983];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziyi Guo <n7l8m4@u.northwestern.edu>

commit f48050436746be75227fbc90066a8658cbe94d17 upstream.

Add spin_lock_irqsave()/spin_unlock_irqrestore() around send_eos_event()
calls in the VB2 buffer queue and streamoff callbacks to fix the missing
lock protection.

wave5_vpu_dec_buf_queue_dst() and streamoff_output() call send_eos_event()
without holding inst->state_spinlock. However, send_eos_event() has
lockdep_assert_held(&inst->state_spinlock) indicating that callers must
hold this lock.

Other callers of send_eos_event() properly acquire the spinlock:
- wave5_vpu_dec_finish_decode() acquires lock at line 431
- wave5_vpu_dec_encoder_cmd() acquires lock at line 821
- wave5_vpu_dec_device_run() acquires lock at line 1592

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Fixes: 9707a6254a8a6b ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1345,13 +1345,17 @@ static void wave5_vpu_dec_buf_queue_dst(
 
 	if (vb2_is_streaming(vb->vb2_queue) && v4l2_m2m_dst_buf_is_last(m2m_ctx)) {
 		unsigned int i;
+		unsigned long flags;
 
 		for (i = 0; i < vb->num_planes; i++)
 			vb2_set_plane_payload(vb, i, 0);
 
 		vbuf->field = V4L2_FIELD_NONE;
 
+		spin_lock_irqsave(&inst->state_spinlock, flags);
 		send_eos_event(inst);
+		spin_unlock_irqrestore(&inst->state_spinlock, flags);
+
 		v4l2_m2m_last_buffer_done(m2m_ctx, vbuf);
 	} else {
 		v4l2_m2m_buf_queue(m2m_ctx, vbuf);
@@ -1492,8 +1496,13 @@ static int streamoff_output(struct vb2_q
 	inst->codec_info->dec_info.stream_rd_ptr = new_rd_ptr;
 	inst->codec_info->dec_info.stream_wr_ptr = new_rd_ptr;
 
-	if (v4l2_m2m_has_stopped(m2m_ctx))
+	if (v4l2_m2m_has_stopped(m2m_ctx)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&inst->state_spinlock, flags);
 		send_eos_event(inst);
+		spin_unlock_irqrestore(&inst->state_spinlock, flags);
+	}
 
 	/* streamoff on output cancels any draining operation */
 	inst->eos = false;



