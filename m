Return-Path: <stable+bounces-211284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sa4hN29pcmmKkgAAu9opvQ
	(envelope-from <stable+bounces-211284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:16:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF116C2EA
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CA853063194
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222472EBDFD;
	Thu, 22 Jan 2026 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="SLPQwO37"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7B2DECC5;
	Thu, 22 Jan 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102363; cv=none; b=V4S30QA4sYB5Uy3yb7ae8zGy5+fHU76a8RU/QYENAVev5NfxLrdU3TM5CDiU8+lT/uKBZAW7zQTIyr8u1OkNyMKiT7LJPIrbvLaaEKMvFzlQc4lk2czLQM/qbuYfdg08INPNFgL57va9Etrtzj+pdowBrM0dYcyPdOAQzuUMIxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102363; c=relaxed/simple;
	bh=/rRFCH+ykYIjJQDEkEYpbFwT2vGPMunJB8qyBq0geC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1kyH448yJRFLk9dFG/iSTf+grhJ1bMN0NNIrRc4WMdP10PUEpyGR6bPPLmdSRBV9qbaNqDLMv1m9be1DS5DyESO7AVvXzKrjskpEaYuoyIYwsqlohumFJjRYT+0jY9Cj7q6yHQ8rugUd1oBi3IMKfM28Q+NmwjxQ4BkBIQyLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=SLPQwO37; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=rukEouGRX99p96faBHev5UqIrepG8fvM58ceQz7LAVA=; b=SLPQwO37qNsSf0iSROgaUOXEIU
	Qunp+M93of8lV+iVZjoY0OkQAayEWFipWJKu6C8aL8lYrFFYtWsx6HnwtsVOJGpeQdrTu6xoDS7+e
	QVd+RNdvGwltzzBPndfKymVQk5ieCpM0HBhTicP1SQQDiCVMSbMjjvCOf0F0yCzOEWYtOIyEpu+79
	fOYOStcCQeHpWMVy5j4UC04HKvB5pBbf8QGXHOZ0xZ6V7mTnkuqexUYc55Eu6Omqe5TQkDQSmsWng
	ReRpMuo98pTPajKMO4YrlidOxDlApwyytj5ZagVdmqbRgdh38R6L2gm7uixnvFwyWefejG4LDXfcl
	t/8WV/LFV2Vw9h+l4NRQUVzOtRA/YJ+ytgTGUjtByDjw0qCQOEX/Yb21t+r7h7LHY/9Yf01os9QVh
	7brCG4zTNLwRIqIQ+3ZPfGYvwETFF+Lw3EBftRztdbVIi4br4wgeB9LdoBowbyCOrBLfSrz6FV6ym
	hEXwIge/8GHxxNDdfvPSzfpN;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1viyKm-00000001q03-3ZRS;
	Thu, 22 Jan 2026 17:19:04 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	stable@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH v2 20/20] smb: client: let send_done handle a completion without IB_SEND_SIGNALED
Date: Thu, 22 Jan 2026 18:17:00 +0100
Message-ID: <9509720326ae8844b59032630ae8a5c90baffdc3.1769101771.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769101771.git.metze@samba.org>
References: <cover.1769101771.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samba.org,vger.kernel.org,gmail.com,talpey.com,microsoft.com,kernel.org];
	GREYLIST(0.00)[pass,meta];
	TAGGED_FROM(0.00)[bounces-211284-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.926];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,samba.org:dkim,samba.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,talpey.com:email]
X-Rspamd-Queue-Id: 0EF116C2EA
X-Rspamd-Action: add header
X-Spam: Yes

With smbdirect_send_batch processing we likely have requests without
IB_SEND_SIGNALED, which will be destroyed in the final request
that has IB_SEND_SIGNALED set.

If the connection is broken all requests are signaled
even without explicit IB_SEND_SIGNALED.

Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/client/smbdirect.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 88fefb901c27..01d55bcc6d0f 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -554,6 +554,32 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	log_rdma_send(INFO, "smbdirect_send_io 0x%p completed wc->status=%s\n",
 		request, ib_wc_status_msg(wc->status));
 
+	if (unlikely(!(request->wr.send_flags & IB_SEND_SIGNALED))) {
+		/*
+		 * This happens when smbdirect_send_io is a sibling
+		 * before the final message, it is signaled on
+		 * error anyway, so we need to skip
+		 * smbdirect_connection_free_send_io here,
+		 * otherwise is will destroy the memory
+		 * of the siblings too, which will cause
+		 * use after free problems for the others
+		 * triggered from ib_drain_qp().
+		 */
+		if (wc->status != IB_WC_SUCCESS)
+			goto skip_free;
+
+		/*
+		 * This should not happen!
+		 * But we better just close the
+		 * connection...
+		 */
+		log_rdma_send(ERR,
+			"unexpected send completion wc->status=%s (%d) wc->opcode=%d\n",
+			ib_wc_status_msg(wc->status), wc->status, wc->opcode);
+		smbd_disconnect_rdma_connection(sc);
+		return;
+	}
+
 	/*
 	 * Free possible siblings and then the main send_io
 	 */
@@ -567,6 +593,7 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	lcredits += 1;
 
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
+skip_free:
 		if (wc->status != IB_WC_WR_FLUSH_ERR)
 			log_rdma_send(ERR, "wc->status=%s wc->opcode=%d\n",
 				ib_wc_status_msg(wc->status), wc->opcode);
-- 
2.43.0


