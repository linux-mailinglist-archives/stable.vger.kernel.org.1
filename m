Return-Path: <stable+bounces-211161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK6cDRpTcWkKCQAAu9opvQ
	(envelope-from <stable+bounces-211161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:28:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008C5ECC2
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 23:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92CCD7AF574
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A871D392B84;
	Wed, 21 Jan 2026 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="bypymIlw"
X-Original-To: stable@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01457366DB4;
	Wed, 21 Jan 2026 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025076; cv=none; b=be3UolYJroLirtq/6/N+33y4Cn73ZCQ5Uc3a9KNxKDlfv419DdZC8b4hbtwHQm/ftLAdcFTFJ0bDYhxojSXsyV+7aUiSa7EujqUPRBBgSCqFcUPFRXFSnNQO78zJYFP2MY7Ry7faPa2dKVUsCBWBV+eAN5CsNAkJQA0P/zngxCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025076; c=relaxed/simple;
	bh=2qL35MIG7BNi++fXU4P4fSAL+Xnojoei3uS8NjmbaKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHMyMqjd4xhd6dwperG9wg5cfkWbE+homAW11gZ5UhxXIzWPVFJ+Oc0t6fXuQEa7TexEPsZ/AFajipgpaFjAhUdrsW0xJvn4jOHdbybu6nAJ2s3Pvaxrc0ixDKQ5wfkqwIT0feiI2ZwU//BuQxYnAC9qqyqa7vu7abl95dEtks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=bypymIlw; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=wo9hsOHiOC8Sp48E4kWa0kncr2yxkwUS6duxQYBO1Ss=; b=bypymIlwyc7QBGDAMHl5jMhm9l
	IBrEkv1IiVPfqekTpjorkbxlAv6EYqiOS9QpCAdHUsrg+ISA0A3kxiHTAOxewKbu+LOo1PlPiwi0j
	zGekbPCjzFTuG9JPVl9Jkxie/koXGzJCdVHVamiPOYavwvWnrj319t3UtDViC4kjnhPOAlNDNZKsK
	rE49RFMee3YuB4kQ5vRQiVbSae5SQxFl5LM0E1TQNFRgHATCBXOz0cJhCQD2X/in0k+0hYq29YcuQ
	OiI/8KD8Ep6d543JD0GCTBmRJByfHyuJ4Wx8UdFFWFJNvAGvmtQ6Xns7+Xv8vJ09t7JL7to1h43Ox
	1rpazvm2Hml3OuJhLjT6avHJk/vDPvW4dATGBg7VMMxuKG9E9dCTOIykcgRyoPB46iIIWG817zTiA
	LMCVsOWXUcjx69ZRSu9hdEmuUUyOX4HgFXhtolGW7VZoZ3D3NmaOhrHPVm69g7q1aP6KHbThhx1RI
	ctlTVI1y3xTz0DEp9qDsgO/B;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vieER-00000001dzF-1HAF;
	Wed, 21 Jan 2026 19:51:11 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 04/19] smb: server: let recv_done() queue a refill when the peer is low on credits
Date: Wed, 21 Jan 2026 20:50:14 +0100
Message-ID: <9c7db488c53721cae463a856b318bdf3fcb0bf39.1769024269.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769024269.git.metze@samba.org>
References: <cover.1769024269.git.metze@samba.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samba.org,vger.kernel.org,kernel.org,gmail.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-211161-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,samba.org:dkim,samba.org:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,talpey.com:email]
X-Rspamd-Queue-Id: 8008C5ECC2
X-Rspamd-Action: add header
X-Spam: Yes

In captures I saw that Windows was granting 191 credits in a batch
when its peer posted a lot of messages. We are asking for a
credit target of 255 and 191 is 252*3/4.

So we also use that logic in order to fill the
recv buffers available to the peer.

Fixes: a7eef6144c97 ("smb: server: queue post_recv_credits_work in put_recvmsg() and avoid count_avail_recvmsg")
Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/server/transport_rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index c7abd621bd11..fc29b4c3b645 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -644,6 +644,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		struct smbdirect_data_transfer *data_transfer =
 			(struct smbdirect_data_transfer *)recvmsg->packet;
 		u32 remaining_data_length, data_offset, data_length;
+		int current_recv_credits;
 		u16 old_recv_credit_target;
 
 		if (wc->byte_len <
@@ -682,7 +683,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		}
 
 		atomic_dec(&sc->recv_io.posted.count);
-		atomic_dec(&sc->recv_io.credits.count);
+		current_recv_credits = atomic_dec_return(&sc->recv_io.credits.count);
 
 		old_recv_credit_target = sc->recv_io.credits.target;
 		sc->recv_io.credits.target =
@@ -702,7 +703,8 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			wake_up(&sc->send_io.credits.wait_queue);
 
 		if (data_length) {
-			if (sc->recv_io.credits.target > old_recv_credit_target)
+			if (current_recv_credits <= (sc->recv_io.credits.target / 4) ||
+			    sc->recv_io.credits.target > old_recv_credit_target)
 				queue_work(sc->workqueue, &sc->recv_io.posted.refill_work);
 
 			enqueue_reassembly(sc, recvmsg, (int)data_length);
-- 
2.43.0


