Return-Path: <stable+bounces-15748-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4417483B5F7
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F1D1F226E1
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4517C197;
	Thu, 25 Jan 2024 00:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkNPc9rc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31314385
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141793; cv=none; b=jVBp6+GnvZy/7RMPutMt96Gnb8uRHAw8XT2d2TIrEEqxiepSnTl59Nz2yHxriSRCLhC5OKaQUGnj8R4/Obur7tKltM2Gqw2GgCXqWAWXBwcBodXiOJKvyhHWhq7Ynj88UYw0R1bL7iLwKwrdOmoxbP5WEKu8WK3pcHdKcUdOlDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141793; c=relaxed/simple;
	bh=eXdEB/+EeDBWtSL7ExZqB7H260yn3hMBMFzmYUUT0oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dr2L4Cs5NGbT7BhrXH4i0MdiiBmfzdNPP3LJrHT5RDN32cyLj5sx+NLy6c4Zh/7hA77nt7+GvatZj4fsnVD7AB4g2Ec/DyazDu8jkl3VHgCQccbaj/bGAJ9dlDjIdD0bhpF0t24Gcsfkc921p+pMcOgxZxTuCMOCyylMad9/63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkNPc9rc; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso6701719e87.3
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141789; x=1706746589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qvg1RHKTSczA0Pc9F51yU6Uk7kRw2KvckXXPs4c9ms0=;
        b=GkNPc9rcymt7zUIguEx49kz4wk5/PNQ/lmJDssK8lXzHC/UP0+aI3WP6wztRpIPq0n
         xlQJU87sEPjkT77BtU+QTgcroiEzCOGx/e6ejFiRh55UAusCV363JOnhJOoc3vMCfBnv
         TZsZx4962nGD4UMfKyaap9SM5iM5SXAkT14kQceKrKoGBP2pmCi/ibLY82Bw9qSUIL7H
         Hqd4sa5Kg8ZHfqT5VsTwq51kYhT32n5N+iZLiRM6FcaAhP/cQWV5xcLhwwKmMRwV0xXI
         2Y2LrDzUHeRwSmaYUaIZeLiLaPoEDD26YW1zNCtNtjPzf6OMfEOWrnSJ37Z9U6rYZ/9s
         98Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141789; x=1706746589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qvg1RHKTSczA0Pc9F51yU6Uk7kRw2KvckXXPs4c9ms0=;
        b=JSBeHx5PvT7leQjFMv71C9UnzukUCtY0KjhQcLemTUovVdeR2LE30/Xm1xyD4KR5IZ
         JKzq/mEQ3P4kK8Ws5sbQyj/Y5KCDPNJjA4YPi0zeYtJCNOSsozjWd6bBwcHd7Yqt6Nmu
         tQcha6oeUppSVq2pkTygwODriQb3F9UOdH8m7YrAL1G/t5aTVw3RdQJtDEKjcnpbppDX
         sNY2b4CBwVXq55yhte8PaJtSWUqa+jhcvi0XobnZ1lO4Z2W/7TpaN4KMdlVPjN5IeWR5
         NMWw5YEcfA2C28KJ7TVZh/vj7BaquYGZ/LIW9eotZKzzkZr66JvnfhAoNonLSx/Xvmy5
         aFsQ==
X-Gm-Message-State: AOJu0Yxi3NDGoTFiAJQXqMm0rgpV0GPkq4t/qUZP+jZq9mdap4oRbhnH
	7bsIM22ib8bWGcdYSxADNKbvqJYv43pDWw5ZW8p8FGrVlVyTAjCoPtjQDXIf
X-Google-Smtp-Source: AGHT+IExMmi5B3uZKeoui8Gy9PxWnGRBShupB3R1TesPWLmmmzoc4zwKkj4ZvtKO/12qShfev7vHTA==
X-Received: by 2002:a05:6512:e96:b0:50e:712b:393f with SMTP id bi22-20020a0565120e9600b0050e712b393fmr32322lfb.80.1706141788727;
        Wed, 24 Jan 2024 16:16:28 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:28 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: stable@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	mykolal@fb.com,
	gregkh@linuxfoundation.org,
	mat.gienieczko@tum.de,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.6.y 08/17] selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
Date: Thu, 25 Jan 2024 02:15:45 +0200
Message-ID: <20240125001554.25287-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125001554.25287-1-eddyz87@gmail.com>
References: <20240125001554.25287-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 977bc146d4eb ]

This change prepares syncookie_{tc,xdp} for update in callbakcs
verification logic. To allow bpf_loop() verification converge when
multiple callback itreations are considered:
- track offset inside TCP payload explicitly, not as a part of the
  pointer;
- make sure that offset does not exceed MAX_PACKET_OFF enforced by
  verifier;
- make sure that offset is tracked as unbound scalar between
  iterations, otherwise verifier won't be able infer that bpf_loop
  callback reaches identical states.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-2-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/xdp_synproxy_kern.c   | 84 ++++++++++++-------
 1 file changed, 52 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index 07d786329105..614b8ae2c144 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -53,6 +53,8 @@
 #define DEFAULT_TTL 64
 #define MAX_ALLOWED_PORTS 8
 
+#define MAX_PACKET_OFF 0xffff
+
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
@@ -183,63 +185,76 @@ static __always_inline __u32 tcp_time_stamp_raw(void)
 }
 
 struct tcpopt_context {
-	__u8 *ptr;
-	__u8 *end;
+	void *data;
 	void *data_end;
 	__be32 *tsecr;
 	__u8 wscale;
 	bool option_timestamp;
 	bool option_sack;
+	__u32 off;
 };
 
-static int tscookie_tcpopt_parse(struct tcpopt_context *ctx)
+static __always_inline u8 *next(struct tcpopt_context *ctx, __u32 sz)
 {
-	__u8 opcode, opsize;
+	__u64 off = ctx->off;
+	__u8 *data;
 
-	if (ctx->ptr >= ctx->end)
-		return 1;
-	if (ctx->ptr >= ctx->data_end)
-		return 1;
+	/* Verifier forbids access to packet when offset exceeds MAX_PACKET_OFF */
+	if (off > MAX_PACKET_OFF - sz)
+		return NULL;
 
-	opcode = ctx->ptr[0];
+	data = ctx->data + off;
+	barrier_var(data);
+	if (data + sz >= ctx->data_end)
+		return NULL;
 
-	if (opcode == TCPOPT_EOL)
-		return 1;
-	if (opcode == TCPOPT_NOP) {
-		++ctx->ptr;
-		return 0;
-	}
+	ctx->off += sz;
+	return data;
+}
 
-	if (ctx->ptr + 1 >= ctx->end)
-		return 1;
-	if (ctx->ptr + 1 >= ctx->data_end)
+static int tscookie_tcpopt_parse(struct tcpopt_context *ctx)
+{
+	__u8 *opcode, *opsize, *wscale, *tsecr;
+	__u32 off = ctx->off;
+
+	opcode = next(ctx, 1);
+	if (!opcode)
 		return 1;
-	opsize = ctx->ptr[1];
-	if (opsize < 2)
+
+	if (*opcode == TCPOPT_EOL)
 		return 1;
+	if (*opcode == TCPOPT_NOP)
+		return 0;
 
-	if (ctx->ptr + opsize > ctx->end)
+	opsize = next(ctx, 1);
+	if (!opsize || *opsize < 2)
 		return 1;
 
-	switch (opcode) {
+	switch (*opcode) {
 	case TCPOPT_WINDOW:
-		if (opsize == TCPOLEN_WINDOW && ctx->ptr + TCPOLEN_WINDOW <= ctx->data_end)
-			ctx->wscale = ctx->ptr[2] < TCP_MAX_WSCALE ? ctx->ptr[2] : TCP_MAX_WSCALE;
+		wscale = next(ctx, 1);
+		if (!wscale)
+			return 1;
+		if (*opsize == TCPOLEN_WINDOW)
+			ctx->wscale = *wscale < TCP_MAX_WSCALE ? *wscale : TCP_MAX_WSCALE;
 		break;
 	case TCPOPT_TIMESTAMP:
-		if (opsize == TCPOLEN_TIMESTAMP && ctx->ptr + TCPOLEN_TIMESTAMP <= ctx->data_end) {
+		tsecr = next(ctx, 4);
+		if (!tsecr)
+			return 1;
+		if (*opsize == TCPOLEN_TIMESTAMP) {
 			ctx->option_timestamp = true;
 			/* Client's tsval becomes our tsecr. */
-			*ctx->tsecr = get_unaligned((__be32 *)(ctx->ptr + 2));
+			*ctx->tsecr = get_unaligned((__be32 *)tsecr);
 		}
 		break;
 	case TCPOPT_SACK_PERM:
-		if (opsize == TCPOLEN_SACK_PERM)
+		if (*opsize == TCPOLEN_SACK_PERM)
 			ctx->option_sack = true;
 		break;
 	}
 
-	ctx->ptr += opsize;
+	ctx->off = off + *opsize;
 
 	return 0;
 }
@@ -256,16 +271,21 @@ static int tscookie_tcpopt_parse_batch(__u32 index, void *context)
 
 static __always_inline bool tscookie_init(struct tcphdr *tcp_header,
 					  __u16 tcp_len, __be32 *tsval,
-					  __be32 *tsecr, void *data_end)
+					  __be32 *tsecr, void *data, void *data_end)
 {
 	struct tcpopt_context loop_ctx = {
-		.ptr = (__u8 *)(tcp_header + 1),
-		.end = (__u8 *)tcp_header + tcp_len,
+		.data = data,
 		.data_end = data_end,
 		.tsecr = tsecr,
 		.wscale = TS_OPT_WSCALE_MASK,
 		.option_timestamp = false,
 		.option_sack = false,
+		/* Note: currently verifier would track .off as unbound scalar.
+		 *       In case if verifier would at some point get smarter and
+		 *       compute bounded value for this var, beware that it might
+		 *       hinder bpf_loop() convergence validation.
+		 */
+		.off = (__u8 *)(tcp_header + 1) - (__u8 *)data,
 	};
 	u32 cookie;
 
@@ -635,7 +655,7 @@ static __always_inline int syncookie_handle_syn(struct header_pointers *hdr,
 	cookie = (__u32)value;
 
 	if (tscookie_init((void *)hdr->tcp, hdr->tcp_len,
-			  &tsopt_buf[0], &tsopt_buf[1], data_end))
+			  &tsopt_buf[0], &tsopt_buf[1], data, data_end))
 		tsopt = tsopt_buf;
 
 	/* Check that there is enough space for a SYNACK. It also covers
-- 
2.43.0


