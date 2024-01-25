Return-Path: <stable+bounces-15749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 970CF83B5F8
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 01:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287AB1F22F77
	for <lists+stable@lfdr.de>; Thu, 25 Jan 2024 00:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65C399;
	Thu, 25 Jan 2024 00:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM+VrxNV"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601527F
	for <stable@vger.kernel.org>; Thu, 25 Jan 2024 00:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706141794; cv=none; b=YATWm3MrFsIBLm09vIWQRE6Ef+LUDZNXQ0KHler33UHF6AB0NKW7C8tubdrFsU4zpyz4uQO3+TGGHSPSH4ijvUFD/gePWcesfZpgKykzsDKAxf63Xk/obXuFv8X08lgFL/x4zIg9PacbVfwNI4CwI1D2B/RM6yMNX3HRHyRQXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706141794; c=relaxed/simple;
	bh=hUpGAyhK9Tw9eyc6H6/7eoIvkl9nvmoGV3vU1DgdYq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1Sg5Tz6xWkBu5oi1GvElwphApCYubwviMV33moX5Xz99IgFK4NQTN2f6rnZPtN4jiTkcHup8uJE7fnLUF0aJiSLLub8lXWhqgS6LzEHL4DE09He5tekc7LLG88t5mNp4cvqWgs8bEcuVJpAIyx7wuNiTzHu1hrdMSBLPU04Lks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM+VrxNV; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf2fdd518bso7838331fa.1
        for <stable@vger.kernel.org>; Wed, 24 Jan 2024 16:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706141790; x=1706746590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfIHik2+Sc6iDAJpwNgJHZvON/HnqHKn80ogHpolnLc=;
        b=UM+VrxNVatDrAVoIheK9HWcn2+ja9UrhxnR+XuoX0d/SMqUtiwk8VlMAWOQkPDYYUB
         pLl+tlSdROfOdXBYW5obdEcnVzDPLxP4kHrm97QJyjrRFzNl312NJgZjZRlNzD1WeW8i
         /1OBZIcZ5tpvXkorKZby+aCTBz8gkp4raS0ndV8Ujen6ZQonU13RKZkTcD4/nnGDv6lT
         4MiYE4E/Fk1/AVmC/Ruiz39pQiNUS37xupAQGfngaHch4avlhOb6Eiqujm3g9TegYOlD
         UwyOvhsyWKFs9wApnYJgu1o5tnWAeiXQFL4dIAZReinK1laqGER4SRBXHbhU7JnDFIub
         92TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706141790; x=1706746590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfIHik2+Sc6iDAJpwNgJHZvON/HnqHKn80ogHpolnLc=;
        b=HZtPhB+T+eIihpGA4HzG4PXPtgvtbM9o1fFWv/Kc2P8nZ3duLsPjufkkvJInib7R/W
         nbNt4GFQdVFXYp5W3eMvX09OGmI1sejKTbMpOV4YKLJnCiygNMV+iMYZtvlyVmXfqZZb
         +2Am1OLf00yNXgw+JPDZtaEPJvejTVLb6IJSA5GvGoxxz+2lrBNNpd1h7w1iWXmNqRuL
         eGNRHrFa9v9hyVG3bEGLolOmdKygQnb7W+pwYV08W1rdyJ7nxF8foGpcl9LoL1qt2VcD
         VAQ9KHQc5pKBhUcd6mlUHcx7jBovJiyO9dQcBehsmF0/TxPixPDkbNXBfZEcEJez+AN5
         QQTg==
X-Gm-Message-State: AOJu0YwDCEn9zOhdKix5Cq9KocyeHS5WHgwQ6Pt5YSoKZl2eMs0VRgTi
	WEzLx1Sp//QZY2nGVKB2QUfQiN9jonVRAeK4TNnDkBkoRu6sYlSUU0nidtF/
X-Google-Smtp-Source: AGHT+IFpyzYv1gEuzO/fEmyc5tia7eXHlMIQaE2VxMnip++tPYlfgxRfBWzyt2XfelW65v+pH4qJkg==
X-Received: by 2002:a05:6512:2303:b0:510:194e:4df4 with SMTP id o3-20020a056512230300b00510194e4df4mr26877lfu.175.1706141789955;
        Wed, 24 Jan 2024 16:16:29 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm217363ejn.80.2024.01.24.16.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:16:29 -0800 (PST)
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
Subject: [PATCH 6.6.y 09/17] selftests/bpf: track string payload offset as scalar in strobemeta
Date: Thu, 25 Jan 2024 02:15:46 +0200
Message-ID: <20240125001554.25287-10-eddyz87@gmail.com>
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

[ Upstream commit 87eb0152bcc1 ]

This change prepares strobemeta for update in callbacks verification
logic. To allow bpf_loop() verification converge when multiple
callback iterations are considered:
- track offset inside strobemeta_payload->payload directly as scalar
  value;
- at each iteration make sure that remaining
  strobemeta_payload->payload capacity is sufficient for execution of
  read_{map,str}_var functions;
- make sure that offset is tracked as unbound scalar between
  iterations, otherwise verifier won't be able infer that bpf_loop
  callback reaches identical states.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231121020701.26440-3-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/progs/strobemeta.h  | 78 ++++++++++++-------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testing/selftests/bpf/progs/strobemeta.h
index e02cfd380746..40df2cc26eaf 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -24,9 +24,11 @@ struct task_struct {};
 #define STACK_TABLE_EPOCH_SHIFT 20
 #define STROBE_MAX_STR_LEN 1
 #define STROBE_MAX_CFGS 32
+#define READ_MAP_VAR_PAYLOAD_CAP					\
+	((1 + STROBE_MAX_MAP_ENTRIES * 2) * STROBE_MAX_STR_LEN)
 #define STROBE_MAX_PAYLOAD						\
 	(STROBE_MAX_STRS * STROBE_MAX_STR_LEN +				\
-	STROBE_MAX_MAPS * (1 + STROBE_MAX_MAP_ENTRIES * 2) * STROBE_MAX_STR_LEN)
+	 STROBE_MAX_MAPS * READ_MAP_VAR_PAYLOAD_CAP)
 
 struct strobe_value_header {
 	/*
@@ -355,7 +357,7 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 					     size_t idx, void *tls_base,
 					     struct strobe_value_generic *value,
 					     struct strobemeta_payload *data,
-					     void *payload)
+					     size_t off)
 {
 	void *location;
 	uint64_t len;
@@ -366,7 +368,7 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 		return 0;
 
 	bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
-	len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN, value->ptr);
+	len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, value->ptr);
 	/*
 	 * if bpf_probe_read_user_str returns error (<0), due to casting to
 	 * unsinged int, it will become big number, so next check is
@@ -378,14 +380,14 @@ static __always_inline uint64_t read_str_var(struct strobemeta_cfg *cfg,
 		return 0;
 
 	data->str_lens[idx] = len;
-	return len;
+	return off + len;
 }
 
-static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
-					  size_t idx, void *tls_base,
-					  struct strobe_value_generic *value,
-					  struct strobemeta_payload *data,
-					  void *payload)
+static __always_inline uint64_t read_map_var(struct strobemeta_cfg *cfg,
+					     size_t idx, void *tls_base,
+					     struct strobe_value_generic *value,
+					     struct strobemeta_payload *data,
+					     size_t off)
 {
 	struct strobe_map_descr* descr = &data->map_descrs[idx];
 	struct strobe_map_raw map;
@@ -397,11 +399,11 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 
 	location = calc_location(&cfg->map_locs[idx], tls_base);
 	if (!location)
-		return payload;
+		return off;
 
 	bpf_probe_read_user(value, sizeof(struct strobe_value_generic), location);
 	if (bpf_probe_read_user(&map, sizeof(struct strobe_map_raw), value->ptr))
-		return payload;
+		return off;
 
 	descr->id = map.id;
 	descr->cnt = map.cnt;
@@ -410,10 +412,10 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 		data->req_meta_valid = 1;
 	}
 
-	len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN, map.tag);
+	len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN, map.tag);
 	if (len <= STROBE_MAX_STR_LEN) {
 		descr->tag_len = len;
-		payload += len;
+		off += len;
 	}
 
 #ifdef NO_UNROLL
@@ -426,22 +428,22 @@ static __always_inline void *read_map_var(struct strobemeta_cfg *cfg,
 			break;
 
 		descr->key_lens[i] = 0;
-		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
+		len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN,
 					      map.entries[i].key);
 		if (len <= STROBE_MAX_STR_LEN) {
 			descr->key_lens[i] = len;
-			payload += len;
+			off += len;
 		}
 		descr->val_lens[i] = 0;
-		len = bpf_probe_read_user_str(payload, STROBE_MAX_STR_LEN,
+		len = bpf_probe_read_user_str(&data->payload[off], STROBE_MAX_STR_LEN,
 					      map.entries[i].val);
 		if (len <= STROBE_MAX_STR_LEN) {
 			descr->val_lens[i] = len;
-			payload += len;
+			off += len;
 		}
 	}
 
-	return payload;
+	return off;
 }
 
 #ifdef USE_BPF_LOOP
@@ -455,14 +457,20 @@ struct read_var_ctx {
 	struct strobemeta_payload *data;
 	void *tls_base;
 	struct strobemeta_cfg *cfg;
-	void *payload;
+	size_t payload_off;
 	/* value gets mutated */
 	struct strobe_value_generic *value;
 	enum read_type type;
 };
 
-static int read_var_callback(__u32 index, struct read_var_ctx *ctx)
+static int read_var_callback(__u64 index, struct read_var_ctx *ctx)
 {
+	/* lose precision info for ctx->payload_off, verifier won't track
+	 * double xor, barrier_var() is needed to force clang keep both xors.
+	 */
+	ctx->payload_off ^= index;
+	barrier_var(ctx->payload_off);
+	ctx->payload_off ^= index;
 	switch (ctx->type) {
 	case READ_INT_VAR:
 		if (index >= STROBE_MAX_INTS)
@@ -472,14 +480,18 @@ static int read_var_callback(__u32 index, struct read_var_ctx *ctx)
 	case READ_MAP_VAR:
 		if (index >= STROBE_MAX_MAPS)
 			return 1;
-		ctx->payload = read_map_var(ctx->cfg, index, ctx->tls_base,
-					    ctx->value, ctx->data, ctx->payload);
+		if (ctx->payload_off > sizeof(ctx->data->payload) - READ_MAP_VAR_PAYLOAD_CAP)
+			return 1;
+		ctx->payload_off = read_map_var(ctx->cfg, index, ctx->tls_base,
+						ctx->value, ctx->data, ctx->payload_off);
 		break;
 	case READ_STR_VAR:
 		if (index >= STROBE_MAX_STRS)
 			return 1;
-		ctx->payload += read_str_var(ctx->cfg, index, ctx->tls_base,
-					     ctx->value, ctx->data, ctx->payload);
+		if (ctx->payload_off > sizeof(ctx->data->payload) - STROBE_MAX_STR_LEN)
+			return 1;
+		ctx->payload_off = read_str_var(ctx->cfg, index, ctx->tls_base,
+						ctx->value, ctx->data, ctx->payload_off);
 		break;
 	}
 	return 0;
@@ -501,7 +513,8 @@ static void *read_strobe_meta(struct task_struct *task,
 	pid_t pid = bpf_get_current_pid_tgid() >> 32;
 	struct strobe_value_generic value = {0};
 	struct strobemeta_cfg *cfg;
-	void *tls_base, *payload;
+	size_t payload_off;
+	void *tls_base;
 
 	cfg = bpf_map_lookup_elem(&strobemeta_cfgs, &pid);
 	if (!cfg)
@@ -509,7 +522,7 @@ static void *read_strobe_meta(struct task_struct *task,
 
 	data->int_vals_set_mask = 0;
 	data->req_meta_valid = 0;
-	payload = data->payload;
+	payload_off = 0;
 	/*
 	 * we don't have struct task_struct definition, it should be:
 	 * tls_base = (void *)task->thread.fsbase;
@@ -522,7 +535,7 @@ static void *read_strobe_meta(struct task_struct *task,
 		.tls_base = tls_base,
 		.value = &value,
 		.data = data,
-		.payload = payload,
+		.payload_off = 0,
 	};
 	int err;
 
@@ -540,6 +553,11 @@ static void *read_strobe_meta(struct task_struct *task,
 	err = bpf_loop(STROBE_MAX_MAPS, read_var_callback, &ctx, 0);
 	if (err != STROBE_MAX_MAPS)
 		return NULL;
+
+	payload_off = ctx.payload_off;
+	/* this should not really happen, here only to satisfy verifer */
+	if (payload_off > sizeof(data->payload))
+		payload_off = sizeof(data->payload);
 #else
 #ifdef NO_UNROLL
 #pragma clang loop unroll(disable)
@@ -555,7 +573,7 @@ static void *read_strobe_meta(struct task_struct *task,
 #pragma unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_STRS; ++i) {
-		payload += read_str_var(cfg, i, tls_base, &value, data, payload);
+		payload_off = read_str_var(cfg, i, tls_base, &value, data, payload_off);
 	}
 #ifdef NO_UNROLL
 #pragma clang loop unroll(disable)
@@ -563,7 +581,7 @@ static void *read_strobe_meta(struct task_struct *task,
 #pragma unroll
 #endif /* NO_UNROLL */
 	for (int i = 0; i < STROBE_MAX_MAPS; ++i) {
-		payload = read_map_var(cfg, i, tls_base, &value, data, payload);
+		payload_off = read_map_var(cfg, i, tls_base, &value, data, payload_off);
 	}
 #endif /* USE_BPF_LOOP */
 
@@ -571,7 +589,7 @@ static void *read_strobe_meta(struct task_struct *task,
 	 * return pointer right after end of payload, so it's possible to
 	 * calculate exact amount of useful data that needs to be sent
 	 */
-	return payload;
+	return &data->payload[payload_off];
 }
 
 SEC("raw_tracepoint/kfree_skb")
-- 
2.43.0


