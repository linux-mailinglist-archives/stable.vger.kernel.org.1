Return-Path: <stable+bounces-248672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIl1LyZZB2orzwIAu9opvQ
	(envelope-from <stable+bounces-248672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:34:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 307705553AB
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA90E31BC640
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDC33F9270;
	Fri, 15 May 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+67j09Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C33FF1BD;
	Fri, 15 May 2026 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862335; cv=none; b=rJpN5z2pXVl5bePBaF2UuDMx/RjfJsjsQCDEktda0B/qWYz6rWRtnY1BcIw1fGDwqTAxpvrzv39xch+RuKJhyKltM7bjwKuGfuljJgIVKVNV1Ylkb1DjNBk6Y/SG70C4rdQhe0OTLUYlFKxp1tKPjEhoi9/EOqQNV2qMa+Keg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862335; c=relaxed/simple;
	bh=JI8KR+GV0u4o6qiD/RkyAzRi2abWmG/mB90OCO5RKVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPdIuz2vVpwlCCC1LydSqn14jYt47jHTQRkaJPvGEGe7b+gFH5EPJBJRQ3CgYp7H9sf21M7sikKiKG4YBJLBMwqeZtqQAKQXUNBiZ4zJtVD6LfoVGdnTPzP+6frkvUnQTfmXCFc2Kmd047lLFxgQFcEc+ww+FPbZtmnMLQZQVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+67j09Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0339DC2BCB0;
	Fri, 15 May 2026 16:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862335;
	bh=JI8KR+GV0u4o6qiD/RkyAzRi2abWmG/mB90OCO5RKVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+67j09Q5tXDJbS0FWPh1Xqokr6rSCJq15Co59dxePXO9c/D2zviSw0hZEFxrxVZh
	 7gzX+jNKlN+duBdlU+HNnuc2LhIhXmSysutmCGCdc2n6vgvjmYVtbm5tQIEd54la5w
	 ASaOLeWXDfRfrYsxW8WztLyR71QAfmPhYeEeiqMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guoniu Zhou <guoniu.zhou@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 7.0 010/201] media: nxp: imx8-isi: Reduce minimum queued buffers from 2 to 0
Date: Fri, 15 May 2026 17:47:08 +0200
Message-ID: <20260515154658.760304540@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 307705553AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248672-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,nxp.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,ideasonboard.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guoniu Zhou <guoniu.zhou@nxp.com>

commit 2f38622d0f85f317be9e6b131da6cd511db94fd2 upstream.

Fix a hang issue when capturing a single frame with applications like cam
in libcamera. It would hang waiting for the driver to complete the buffer,
but streaming never starts because min_queued_buffers was set to 2.

The ISI module uses a ping-pong buffer mechanism that requires two buffers
to be programmed at all times. However, when fewer than 2 user buffers are
available, the driver use internal discard buffers to fill the remaining
slot(s). Reduce minimum queued buffers from 2 to 0 allows streaming to
start without any queued buffers.

Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20260312-isi_min_buffers-v2-1-d5ea1c79ad81@nxp.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
@@ -1410,7 +1410,7 @@ int mxc_isi_video_register(struct mxc_is
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->buf_struct_size = sizeof(struct mxc_isi_buffer);
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_queued_buffers = 2;
+	q->min_queued_buffers = 0;
 	q->lock = &video->lock;
 	q->dev = pipe->isi->dev;
 



