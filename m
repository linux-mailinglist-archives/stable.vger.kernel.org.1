Return-Path: <stable+bounces-20396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE20858F40
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 13:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62BE01F221AC
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD26A02B;
	Sat, 17 Feb 2024 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HLe3v2qi"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157CB54BDE
	for <stable@vger.kernel.org>; Sat, 17 Feb 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172023; cv=none; b=AXiqcmWVqACvv/eGZeAgHEP5maplKeBzN7IdXeiT2OypENp9Kp1Bycryneahw7ZL0vHU7sWU0AJ22moNg6fASxrS0zQc8DVSOwoxIDfCotsjtvX4Hq4gKi7sijKzMNYbLh7ORy8r/Zel4v6h1tQ2/aet+QGFCdWGnQ5UzHbGb9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172023; c=relaxed/simple;
	bh=jL+h2WrdtbXhK0Y0CU/NoHUcoZZX4YRNOTE8ZTdj6QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iLf8/g7skTY3TGWhl+fiNGQrFaz+YzbBTCxJKKD8GKM3qIgMsDlh5bl0gC7KFfROTeRWX0jhG0ynusNjm3k8c91l53IpjxTmiCe20zLY66l1XMwTKWWzLHFH9AhNBy4qUgVabTiYdUtHOxuR8uNBz6sXdNo9nhz63+UaoxP2jF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HLe3v2qi; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6L9qSPyiHXqte/E+1H0RHlwot0o3duwsyeq5hX3AO+w=; b=HLe3v2qiHcbuH7NW5NhfDoN3QO
	/eYH3lqgh+7KmN3739Fdvw/LLRWsSScK/kyu7xbgCAnD+BZp0hDRotasUltOmdMn7LDM87zjCJdEx
	kfwJj+iQM7HCrFYwFgPrczzWJJ8ON6s7V9PeWAz0tmnpkOVh1+/MRtvVItT3y6R7OqUIml9lmd53F
	5WUnMpAZGxS1EKNBm4EhIyY7TXWpNB24BPiJxL3d4uIM7tcfCEfJ/b+/9Xey9ODO4vPtEWyyA/VrE
	XVDBbqu2zk1xwaT8r048eKULGkCWBh7SuNBr88aNIFqHWO91ZsT10sfYqKyq+6hgm7OraFHHrQsyJ
	VrtKxzIg==;
Received: from 179-125-79-204-dinamico.pombonet.net.br ([179.125.79.204] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rbJZT-000joD-DB; Sat, 17 Feb 2024 13:13:32 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: cascardo@igalia.com,
	jolsa@kernel.org,
	daniel@iogearbox.net,
	yhs@fb.com
Subject: [PATCH 6.1 1/3] bpf: Add struct for bin_args arg in bpf_bprintf_prepare
Date: Sat, 17 Feb 2024 09:13:15 -0300
Message-Id: <20240217121321.2045993-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217121321.2045993-1-cascardo@igalia.com>
References: <20240217121321.2045993-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

commit 78aa1cc9404399a15d2a1205329c6a06236f5378 upstream.

Adding struct bpf_bprintf_data to hold bin_args argument for
bpf_bprintf_prepare function.

We will add another return argument to bpf_bprintf_prepare and
pass the struct to bpf_bprintf_cleanup for proper cleanup in
following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20221215214430.1336195-2-jolsa@kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 include/linux/bpf.h      |  7 ++++++-
 kernel/bpf/helpers.c     | 24 +++++++++++++-----------
 kernel/bpf/verifier.c    |  3 ++-
 kernel/trace/bpf_trace.c | 34 ++++++++++++++++++++--------------
 4 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c04a61ffac8a..0e4fb16cd5c1 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2740,8 +2740,13 @@ bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
 #define MAX_BPRINTF_VARARGS		12
 
+struct bpf_bprintf_data {
+	u32 *bin_args;
+	bool get_bin_args;
+};
+
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-			u32 **bin_buf, u32 num_args);
+			u32 num_args, struct bpf_bprintf_data *data);
 void bpf_bprintf_cleanup(void);
 
 /* the implementation of the opaque uapi struct bpf_dynptr */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 34135fbd6097..42141d59e9c6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -795,16 +795,16 @@ void bpf_bprintf_cleanup(void)
  * Returns a negative value if fmt is an invalid format string or 0 otherwise.
  *
  * This can be used in two ways:
- * - Format string verification only: when bin_args is NULL
+ * - Format string verification only: when data->get_bin_args is false
  * - Arguments preparation: in addition to the above verification, it writes in
- *   bin_args a binary representation of arguments usable by bstr_printf where
- *   pointers from BPF have been sanitized.
+ *   data->bin_args a binary representation of arguments usable by bstr_printf
+ *   where pointers from BPF have been sanitized.
  *
  * In argument preparation mode, if 0 is returned, safe temporary buffers are
  * allocated and bpf_bprintf_cleanup should be called to free them after use.
  */
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
-			u32 **bin_args, u32 num_args)
+			u32 num_args, struct bpf_bprintf_data *data)
 {
 	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
 	size_t sizeof_cur_arg, sizeof_cur_ip;
@@ -817,12 +817,12 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (bin_args) {
+	if (data->get_bin_args) {
 		if (num_args && try_get_fmt_tmp_buf(&tmp_buf))
 			return -EBUSY;
 
 		tmp_buf_end = tmp_buf + MAX_BPRINTF_BUF_LEN;
-		*bin_args = (u32 *)tmp_buf;
+		data->bin_args = (u32 *)tmp_buf;
 	}
 
 	for (i = 0; i < fmt_size; i++) {
@@ -1023,24 +1023,26 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 }
 
 BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
-	   const void *, data, u32, data_len)
+	   const void *, args, u32, data_len)
 {
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	int err, num_args;
-	u32 *bin_args;
 
 	if (data_len % 8 || data_len > MAX_BPRINTF_VARARGS * 8 ||
-	    (data_len && !data))
+	    (data_len && !args))
 		return -EINVAL;
 	num_args = data_len / 8;
 
 	/* ARG_PTR_TO_CONST_STR guarantees that fmt is zero-terminated so we
 	 * can safely give an unbounded size.
 	 */
-	err = bpf_bprintf_prepare(fmt, UINT_MAX, data, &bin_args, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, args, num_args, &data);
 	if (err < 0)
 		return err;
 
-	err = bstr_printf(str, str_size, fmt, bin_args);
+	err = bstr_printf(str, str_size, fmt, data.bin_args);
 
 	bpf_bprintf_cleanup();
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 23b6d57b5eef..1a29ac4db6ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7448,6 +7448,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	struct bpf_reg_state *fmt_reg = &regs[BPF_REG_3];
 	struct bpf_reg_state *data_len_reg = &regs[BPF_REG_5];
 	struct bpf_map *fmt_map = fmt_reg->map_ptr;
+	struct bpf_bprintf_data data = {};
 	int err, fmt_map_off, num_args;
 	u64 fmt_addr;
 	char *fmt;
@@ -7472,7 +7473,7 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 	/* We are also guaranteed that fmt+fmt_map_off is NULL terminated, we
 	 * can focus on validating the format specifiers.
 	 */
-	err = bpf_bprintf_prepare(fmt, UINT_MAX, NULL, NULL, num_args);
+	err = bpf_bprintf_prepare(fmt, UINT_MAX, NULL, num_args, &data);
 	if (err < 0)
 		verbose(env, "Invalid format string\n");
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f4a494a457c5..bbf44095999f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -377,18 +377,20 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	   u64, arg2, u64, arg3)
 {
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
-	u32 *bin_args;
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	static char buf[BPF_TRACE_PRINTK_SIZE];
 	unsigned long flags;
 	int ret;
 
-	ret = bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
-				  MAX_TRACE_PRINTK_VARARGS);
+	ret = bpf_bprintf_prepare(fmt, fmt_size, args,
+				  MAX_TRACE_PRINTK_VARARGS, &data);
 	if (ret < 0)
 		return ret;
 
 	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
+	ret = bstr_printf(buf, sizeof(buf), fmt, data.bin_args);
 
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
@@ -426,25 +428,27 @@ const struct bpf_func_proto *bpf_get_trace_printk_proto(void)
 	return &bpf_trace_printk_proto;
 }
 
-BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, data,
+BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
 	   u32, data_len)
 {
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	static char buf[BPF_TRACE_PRINTK_SIZE];
 	unsigned long flags;
 	int ret, num_args;
-	u32 *bin_args;
 
 	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
-	    (data_len && !data))
+	    (data_len && !args))
 		return -EINVAL;
 	num_args = data_len / 8;
 
-	ret = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
+	ret = bpf_bprintf_prepare(fmt, fmt_size, args, num_args, &data);
 	if (ret < 0)
 		return ret;
 
 	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, bin_args);
+	ret = bstr_printf(buf, sizeof(buf), fmt, data.bin_args);
 
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
@@ -471,21 +475,23 @@ const struct bpf_func_proto *bpf_get_trace_vprintk_proto(void)
 }
 
 BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
-	   const void *, data, u32, data_len)
+	   const void *, args, u32, data_len)
 {
+	struct bpf_bprintf_data data = {
+		.get_bin_args	= true,
+	};
 	int err, num_args;
-	u32 *bin_args;
 
 	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
-	    (data_len && !data))
+	    (data_len && !args))
 		return -EINVAL;
 	num_args = data_len / 8;
 
-	err = bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
+	err = bpf_bprintf_prepare(fmt, fmt_size, args, num_args, &data);
 	if (err < 0)
 		return err;
 
-	seq_bprintf(m, fmt, bin_args);
+	seq_bprintf(m, fmt, data.bin_args);
 
 	bpf_bprintf_cleanup();
 
-- 
2.34.1


