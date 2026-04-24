Return-Path: <stable+bounces-240855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P1qJiFz62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:41:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C145F68B
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1EB130031D9
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5633290A5;
	Fri, 24 Apr 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PtH5dgCZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52583C1976;
	Fri, 24 Apr 2026 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038015; cv=none; b=MwIx2Et8UvXh/lZrPo3fkUraxZU0GqeWGph5m+F7oKy7z5jAtCFeI3UNH5HhdGwCJryTedOV8RKSo2O4m2+O2bZUQihwqZrAb5fGbrMIeEvqH1nHFdMyRbml5XNGReu0/yWgLhK2URRkChk8rodICve73LgZavIME6idPJdLdaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038015; c=relaxed/simple;
	bh=10i0Fn4QOFgpyrBcl+xnUc4RJP/grZOIQId6ZtVQczk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EGxlQFw3+vdW65iDUSDM1WCzvuGwC/RqO1CXaM/z/CYriwvwvuOFibClHqkK9insjxdpvRVtvYSt/AsmnNoLU8RUexEXVLk9/3VlGXHDKyFMwVBmF4d50Y0jIGwO0KTRN6PiX0307021mqEuKAnVN/Xw/+/mOPZ6SzfxYUZlcOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PtH5dgCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B08BC19425;
	Fri, 24 Apr 2026 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038014;
	bh=10i0Fn4QOFgpyrBcl+xnUc4RJP/grZOIQId6ZtVQczk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtH5dgCZeOqVDy1ez4af5U+ziZAsXOVIuPLGtRvBWd6ZBDYWOWNfQcN/5anodKcaN
	 7fcLIE6QvwaUnlt5s9nd1i5sds/HUG7Db7uKnSFSt3EC7QyklY/GYjIlR49g8Qxb2z
	 wkaBKYoFbiA1VxN8YrG4VM3exz9OCy4upiS/OmB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+96f901260a0b2d29cd1a@syzkaller.appspotmail.com,
	Yihan Ding <dingyihan@uniontech.com>,
	Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.6 124/166] media: vidtv: fix pass-by-value structs causing MSAN warnings
Date: Fri, 24 Apr 2026 15:30:38 +0200
Message-ID: <20260424132558.823090762@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 065C145F68B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-240855-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,uniontech.com:email,syzkaller.appspot.com:url]

6.6-stable review patch.  If anyone has any objections, please let me know.

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



