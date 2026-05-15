Return-Path: <stable+bounces-247859-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NsYBFJpB2qZ2AIAu9opvQ
	(envelope-from <stable+bounces-247859-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:43:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8C25566F4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8B60313FFC3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ED63FF1D8;
	Fri, 15 May 2026 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jW2zIsy4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738FA3FF1CD;
	Fri, 15 May 2026 15:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860255; cv=none; b=Vhd39t9i1/39SHZkCt4KfA/X61sQR/Z0eOOqZ4Xdj7EiletkBI3vehJF4UZomDxjXB1qbVoo+cSn0C0eiEqrpFX4PzoGHG87HBpQQGO2vOk//virM3DGXaxMidoBmcLzFoGbFE261val7P2OWQOaCv1x9oC9sJsschEnEqOMCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860255; c=relaxed/simple;
	bh=hUSOUCMKxmn9+L+WSGXvkHUODeqIR9Qk2Nz6qVDCve0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9pOc4hAiRlz0PNROwhmGC5c/umy4mHVrHguLrZefy5oqk6uhsVZQdP5Jbyq8dSs+AWSkXTufafCIrhAMqSAxorjY0/EAUynwkJEuqccD3NyOA2D4tUD7xnLr/IInnkrEX70giKAdHOhUTc8jjBS8UN+DY1tlMuDXZWkL9sFJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jW2zIsy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D3BC2BCB0;
	Fri, 15 May 2026 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860255;
	bh=hUSOUCMKxmn9+L+WSGXvkHUODeqIR9Qk2Nz6qVDCve0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jW2zIsy4qTFR9EfM2BfuUj5rtp/+4fRIhm/O87drSAmjqQMl6SujaWJFWVVvEpKkk
	 lXkD34AZ+U4IgAD4otH5VVfpgmqjrvB7gcRaRD+zS/fG455azDj/Q0kz/Iq8+a9uiC
	 Ll/vJ1maWj4aE4MN+Opz24kDDQK5uLuLZp6IE1lo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ziyi Guo <n7l8m4@u.northwestern.edu>,
	Nicolas Dufresne <nicolas.dufresne@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.12 007/144] media: chips-media: wave5: add missing spinlock protection for handle_dynamic_resolution_change()
Date: Fri, 15 May 2026 17:47:13 +0200
Message-ID: <20260515154653.652721537@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6C8C25566F4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [5.34 / 15.00];
	SEM_URIBL(3.50)[northwestern.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247859-lists,stable=lfdr.de];
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

commit cb8bdd3ffca280d014311ab395651d33f58a8708 upstream.

Add spin_lock_irqsave()/spin_unlock_irqrestore() around the
handle_dynamic_resolution_change() call in initialize_sequence() to fix
the missing lock protection.

initialize_sequence() calls handle_dynamic_resolution_change() without
holding inst->state_spinlock. However, handle_dynamic_resolution_change()
has lockdep_assert_held(&inst->state_spinlock) indicating that callers
must hold this lock.

Other callers of handle_dynamic_resolution_change() properly acquire the
spinlock:
- wave5_vpu_dec_finish_decode()
- wave5_vpu_dec_device_run()

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Fixes: 9707a6254a8a6b ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1625,6 +1625,7 @@ static int initialize_sequence(struct vp
 {
 	struct dec_initial_info initial_info;
 	int ret = 0;
+	unsigned long flags;
 
 	memset(&initial_info, 0, sizeof(struct dec_initial_info));
 
@@ -1646,7 +1647,9 @@ static int initialize_sequence(struct vp
 		return ret;
 	}
 
+	spin_lock_irqsave(&inst->state_spinlock, flags);
 	handle_dynamic_resolution_change(inst);
+	spin_unlock_irqrestore(&inst->state_spinlock, flags);
 
 	return 0;
 }



