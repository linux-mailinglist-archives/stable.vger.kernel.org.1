Return-Path: <stable+bounces-266014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SMAhNKuUMWpknQUAu9opvQ
	(envelope-from <stable+bounces-266014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:23:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8C4694177
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:23:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BFaBYfP7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266014-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266014-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7D23179732
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F524477986;
	Tue, 16 Jun 2026 18:23:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87F13D88F6;
	Tue, 16 Jun 2026 18:23:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634206; cv=none; b=pVKlyeipAJy6yUCN0/uUm5TNqJefW7WmT+xJqT6OQWnX6VzR5CXMB4n3FVvdsXFN73tGNlqDX9A7Tv56hAiTj/OiNxezUpWH39YAIXGzRcBieu0L85rw4fauBiCCg4a3sa6SDUdhZqaQptXg/3/xtG9hdCI4Xt2vhWKz/UJCdA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634206; c=relaxed/simple;
	bh=Iq+xIceUWvmBCXsqQDA0rdprKBpYNDa7dnzqnwKLgIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsr8l5bYLUQl9ZXFuTDPN7HznyJ5rlDZanaCtfjgJ1NuggXMRncz95a1SFiucN6qSV9B1fYyX4rHDg9aOnfF2wdwyj55Koq0i9SvxrsxMM/HXFQJrbl3H1nSLK7PGdbItc7rkg+B1sHBTN7wVBvfni7TPTsCrk5hy6XtqifS0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BFaBYfP7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D2D1F000E9;
	Tue, 16 Jun 2026 18:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634205;
	bh=dp52Ci2csKjhukuDZ0YEkzrCfhUJlNVErMVkXF7YFjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BFaBYfP7cVJYtMTwmO/HEAc50dp7jN+fnpUGbsOGVfJi/5AGWDmhTbfN7QdYc6NAg
	 coqb45WmaVPo5tgf766PjY2EJeiJwxph3ZR/R0HC25TRrMBxuNZ42Y5EkRdsiAZ4rY
	 4+MQPT7E4mGuDAJLIaffc3WBHv2STMy/9PS4Xcc4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 5.15 211/411] RDMA/srp: bound SRP_RSP sense copy by the received length
Date: Tue, 16 Jun 2026 20:27:29 +0530
Message-ID: <20260616145111.974702916@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266014-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michael.bommarito@gmail.com,m:bvanassche@acm.org,m:jgg@nvidia.com,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,acm.org,nvidia.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,nvidia.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F8C4694177

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 13e91fd076306f5d0cdfa14f53d69e37274723c4 upstream.

srp_process_rsp() copies sense data from rsp->data + resp_data_len,
where resp_data_len is the full 32-bit value supplied by the SRP target
and is never checked against the number of bytes actually received
(wc->byte_len). The copy length is bounded to SCSI_SENSE_BUFFERSIZE, so
at most 96 bytes are copied, but the source offset is not bounded.

A malicious or compromised SRP target on the InfiniBand/RoCE fabric that
the initiator has logged into can return an SRP_RSP with
SRP_RSP_FLAG_SNSVALID set and a large resp_data_len. The receive buffer
is allocated at the target-chosen max_ti_iu_len, so the source of the
sense copy lands past the bytes actually received; with resp_data_len
near 0xFFFFFFFF it is gigabytes past the buffer and the read faults.

Copy the sense data only if it has not been truncated, that is, only if
the response header, the response data, and the sense region fit within
the bytes actually received; otherwise drop the sense and log. The
in-tree iSER and NVMe-RDMA receive paths already bound their parse by
wc->byte_len; this brings ib_srp into line with them.

Fixes: aef9ec39c47f ("IB: Add SCSI RDMA Protocol (SRP) initiator")
Link: https://patch.msgid.link/r/20260602220457.2542840-1-michael.bommarito@gmail.com
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/srp/ib_srp.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -1929,7 +1929,8 @@ static int srp_post_recv(struct srp_rdma
 	return ib_post_recv(ch->qp, &wr, NULL);
 }
 
-static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp)
+static void srp_process_rsp(struct srp_rdma_ch *ch, struct srp_rsp *rsp,
+			    u32 byte_len)
 {
 	struct srp_target_port *target = ch->target;
 	struct srp_request *req;
@@ -1970,10 +1971,27 @@ static void srp_process_rsp(struct srp_r
 		scmnd->result = rsp->status;
 
 		if (rsp->flags & SRP_RSP_FLAG_SNSVALID) {
-			memcpy(scmnd->sense_buffer, rsp->data +
-			       be32_to_cpu(rsp->resp_data_len),
-			       min_t(int, be32_to_cpu(rsp->sense_data_len),
-				     SCSI_SENSE_BUFFERSIZE));
+			u32 resp_len = be32_to_cpu(rsp->resp_data_len);
+			u32 sense_len = be32_to_cpu(rsp->sense_data_len);
+
+			/*
+			 * The sense data starts resp_data_len bytes past the
+			 * response data area; both lengths come from the
+			 * target-controlled response.  Copy the sense data
+			 * only if it has not been truncated, that is, only if
+			 * the full sense region fits within the bytes actually
+			 * received.  Otherwise the copy source would run past
+			 * the receive buffer (sized to the target-chosen
+			 * max_ti_iu_len), reading out of bounds.
+			 */
+			if (sizeof(*rsp) + (u64)resp_len + sense_len <= byte_len)
+				memcpy(scmnd->sense_buffer,
+				       rsp->data + resp_len,
+				       min(sense_len, SCSI_SENSE_BUFFERSIZE));
+			else
+				shost_printk(KERN_ERR, target->scsi_host,
+					     "dropping truncated sense data (resp_data_len %u sense_data_len %u, %u bytes received)\n",
+					     resp_len, sense_len, byte_len);
 		}
 
 		if (unlikely(rsp->flags & SRP_RSP_FLAG_DIUNDER))
@@ -2083,7 +2101,7 @@ static void srp_recv_done(struct ib_cq *
 
 	switch (opcode) {
 	case SRP_RSP:
-		srp_process_rsp(ch, iu->buf);
+		srp_process_rsp(ch, iu->buf, wc->byte_len);
 		break;
 
 	case SRP_CRED_REQ:



