Return-Path: <stable+bounces-257995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMBpC7ghG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:43:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 480FD6103B1
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39A3C300FB37
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9C2344DB9;
	Sat, 30 May 2026 17:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r1hsy6eq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E121B191;
	Sat, 30 May 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162873; cv=none; b=XR8PyPK0KEOLILJst3URoKAawLDtIcLgo1LfnyspTr5YgzVTAxPqiPjTLDB/+d9bpvyq2/fQrCAYE18e9Fk2XMrsXeqlyd1QCNanD1DyrXn3hjxMn9wG0oLvCKB3zHyEXBxjlYRiIKe8ai4erqPykN1mh//7SYiQky7WwxHOdFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162873; c=relaxed/simple;
	bh=CVNrLAIzAmzooID7gvTjnK/DUFUiPgW38X6duMiwNcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHmmVd1x91FeMyaJsOKMmDgNdlfL6OZdQnRedkUgolIlKyPAlsmvrZvuma3cJJ8uFEBkVvYNyy2ooIwBMpHv1qEnVs1ichG/tteskt70Yw4IA3RBAyvGbEozeQWG7ex2tjY65WxV3VXKNLkbkta4xDOS4VvAZfw9LpQgQWFgIb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r1hsy6eq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C0F1F00893;
	Sat, 30 May 2026 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162871;
	bh=+CQ1SDJ73PXAmohAq3RDcqKlG2EqbfFFYfyZ1RZ2GTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r1hsy6eqrkf2FU+FVPTWR/XQ0GZjBmunrDBvj3ihJDg31MECh3i1vg8F4ZkHITsH+
	 ULd07Hb3L8tni2wptJXrtukP54ChyysCxiQSIazFZ3nWHH5jYuAiGOJ9j8h1ZMzoEU
	 1S8eWsC/cQtR/awCQqJnSu/8cGKX3DgTfXLjrtv4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+96f901260a0b2d29cd1a@syzkaller.appspotmail.com,
	Yihan Ding <dingyihan@uniontech.com>,
	Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 5.15 088/776] media: vidtv: fix pass-by-value structs causing MSAN warnings
Date: Sat, 30 May 2026 17:56:42 +0200
Message-ID: <20260530160242.610939519@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-257995-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,uniontech.com,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,96f901260a0b2d29cd1a,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,appspotmail.com:email,syzkaller.appspot.com:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,uniontech.com:email]
X-Rspamd-Queue-Id: 480FD6103B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>

commit 5f8e73bde67e931468bc2a1860d78d72f0c6ba41 upstream.

vidtv_ts_null_write_into() and vidtv_ts_pcr_write_into() take their
argument structs by value, causing MSAN to report uninit-value warnings.
While only vidtv_ts_null_write_into() has triggered a report so far,
both functions share the same issue.

Fix by passing both structs by const pointer instead, avoiding the
stack copy of the struct along with its MSAN shadow and origin metadata.
The functions do not modify the structs, which is enforced by the const
qualifier.

Fixes: f90cf6079bf67 ("media: vidtv: add a bridge driver")
Cc: stable@vger.kernel.org
Reported-by: syzbot+96f901260a0b2d29cd1a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=96f901260a0b2d29cd1a
Tested-by: syzbot+96f901260a0b2d29cd1a@syzkaller.appspotmail.com
Suggested-by: Yihan Ding <dingyihan@uniontech.com>
Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/test-drivers/vidtv/vidtv_mux.c |    4 +-
 drivers/media/test-drivers/vidtv/vidtv_ts.c  |   50 +++++++++++++--------------
 drivers/media/test-drivers/vidtv/vidtv_ts.h  |    4 +-
 3 files changed, 29 insertions(+), 29 deletions(-)

--- a/drivers/media/test-drivers/vidtv/vidtv_mux.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_mux.c
@@ -233,7 +233,7 @@ static u32 vidtv_mux_push_pcr(struct vid
 	/* the 27Mhz clock will feed both parts of the PCR bitfield */
 	args.pcr = m->timing.clk;
 
-	nbytes += vidtv_ts_pcr_write_into(args);
+	nbytes += vidtv_ts_pcr_write_into(&args);
 	m->mux_buf_offset += nbytes;
 
 	m->num_streamed_pcr++;
@@ -363,7 +363,7 @@ static u32 vidtv_mux_pad_with_nulls(stru
 	args.continuity_counter = &ctx->cc;
 
 	for (i = 0; i < npkts; ++i) {
-		m->mux_buf_offset += vidtv_ts_null_write_into(args);
+		m->mux_buf_offset += vidtv_ts_null_write_into(&args);
 		args.dest_offset  = m->mux_buf_offset;
 	}
 
--- a/drivers/media/test-drivers/vidtv/vidtv_ts.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_ts.c
@@ -48,7 +48,7 @@ void vidtv_ts_inc_cc(u8 *continuity_coun
 		*continuity_counter = 0;
 }
 
-u32 vidtv_ts_null_write_into(struct null_packet_write_args args)
+u32 vidtv_ts_null_write_into(const struct null_packet_write_args *args)
 {
 	u32 nbytes = 0;
 	struct vidtv_mpeg_ts ts_header = {};
@@ -56,21 +56,21 @@ u32 vidtv_ts_null_write_into(struct null
 	ts_header.sync_byte          = TS_SYNC_BYTE;
 	ts_header.bitfield           = cpu_to_be16(TS_NULL_PACKET_PID);
 	ts_header.payload            = 1;
-	ts_header.continuity_counter = *args.continuity_counter;
+	ts_header.continuity_counter = *args->continuity_counter;
 
 	/* copy TS header */
-	nbytes += vidtv_memcpy(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memcpy(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       &ts_header,
 			       sizeof(ts_header));
 
-	vidtv_ts_inc_cc(args.continuity_counter);
+	vidtv_ts_inc_cc(args->continuity_counter);
 
 	/* fill the rest with empty data */
-	nbytes += vidtv_memset(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memset(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       TS_FILL_BYTE,
 			       TS_PACKET_LEN - nbytes);
 
@@ -83,17 +83,17 @@ u32 vidtv_ts_null_write_into(struct null
 	return nbytes;
 }
 
-u32 vidtv_ts_pcr_write_into(struct pcr_write_args args)
+u32 vidtv_ts_pcr_write_into(const struct pcr_write_args *args)
 {
 	u32 nbytes = 0;
 	struct vidtv_mpeg_ts ts_header = {};
 	struct vidtv_mpeg_ts_adaption ts_adap = {};
 
 	ts_header.sync_byte     = TS_SYNC_BYTE;
-	ts_header.bitfield      = cpu_to_be16(args.pid);
+	ts_header.bitfield      = cpu_to_be16(args->pid);
 	ts_header.scrambling    = 0;
 	/* cc is not incremented, but it is needed. see 13818-1 clause 2.4.3.3 */
-	ts_header.continuity_counter = *args.continuity_counter;
+	ts_header.continuity_counter = *args->continuity_counter;
 	ts_header.payload            = 0;
 	ts_header.adaptation_field   = 1;
 
@@ -102,27 +102,27 @@ u32 vidtv_ts_pcr_write_into(struct pcr_w
 	ts_adap.PCR    = 1;
 
 	/* copy TS header */
-	nbytes += vidtv_memcpy(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memcpy(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       &ts_header,
 			       sizeof(ts_header));
 
 	/* write the adap after the TS header */
-	nbytes += vidtv_memcpy(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_memcpy(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       &ts_adap,
 			       sizeof(ts_adap));
 
 	/* write the PCR optional */
-	nbytes += vidtv_ts_write_pcr_bits(args.dest_buf,
-					  args.dest_offset + nbytes,
-					  args.pcr);
-
-	nbytes += vidtv_memset(args.dest_buf,
-			       args.dest_offset + nbytes,
-			       args.buf_sz,
+	nbytes += vidtv_ts_write_pcr_bits(args->dest_buf,
+					  args->dest_offset + nbytes,
+					  args->pcr);
+
+	nbytes += vidtv_memset(args->dest_buf,
+			       args->dest_offset + nbytes,
+			       args->buf_sz,
 			       TS_FILL_BYTE,
 			       TS_PACKET_LEN - nbytes);
 
--- a/drivers/media/test-drivers/vidtv/vidtv_ts.h
+++ b/drivers/media/test-drivers/vidtv/vidtv_ts.h
@@ -90,7 +90,7 @@ void vidtv_ts_inc_cc(u8 *continuity_coun
  *
  * Return: The number of bytes written into the buffer.
  */
-u32 vidtv_ts_null_write_into(struct null_packet_write_args args);
+u32 vidtv_ts_null_write_into(const struct null_packet_write_args *args);
 
 /**
  * vidtv_ts_pcr_write_into - Write a PCR  packet into a buffer.
@@ -101,6 +101,6 @@ u32 vidtv_ts_null_write_into(struct null
  *
  * Return: The number of bytes written into the buffer.
  */
-u32 vidtv_ts_pcr_write_into(struct pcr_write_args args);
+u32 vidtv_ts_pcr_write_into(const struct pcr_write_args *args);
 
 #endif //VIDTV_TS_H



