Return-Path: <stable+bounces-20403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F702858F46
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 13:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA931F221B7
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 12:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83A46A01E;
	Sat, 17 Feb 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DB1TNDfj"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE06A02A
	for <stable@vger.kernel.org>; Sat, 17 Feb 2024 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172032; cv=none; b=Ne2HcYdvy79BOYeeWRB1dNprkwVUwQjEh6+SzfEVtcPik6D9okqjaDTJ0hT5u3M2oGmRl/Khy8NeWloRQKH46rgb8tPNGzPv+osN5JoKBF9zTMzpLCpHl+un0ozjrrVip/YuHVDS3OgFsCwIOXzI/afezg2xSyedN68jAu0hFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172032; c=relaxed/simple;
	bh=42PPBn3D+500Ph8zhbHZDziBMxj6zooiIFSCY6EdKvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HpjMUDVttVagdmljPunNVoGB2m73URuy9BFKLmao27TdG3zekQas3tqKkCqjK4MA1u4NCicKIxPWF/uwFidXYg8LNLBgZLPQK388d+/bPFvYVNVJ969BWpA3TuHBsM0dqGS7MPHWZ4b8V3B1C2xL+DAFZeQT5V73iL/EkXimZ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DB1TNDfj; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dgb14UKCASzi/JoD1nvKXVvdDzFpQg89rVf4qncAcGU=; b=DB1TNDfjQRpxLVvCl3bxBismrK
	tn/pxIPTeNoTw5ZPmvfi86z+j93g0ICq6WgxmNsj+RpiqwtNw4BnEw5WYqC912ytKd239WCPsbQ8C
	kYjA+Zdbn1eUvxfQdBWtlSieNKrw/hYtK/yQ3+O/c7WhUNIl+gD61u4/H0sSrT04MzGBDqQoqSo9W
	gcP1+qms29Ze3jJBhl3D7YXgOC5Qa/nbZN2zUEYLlSw1d2MRHjpOb5/MLSOafhFzBjXwepipFksSg
	o7beuX71Vjh+qKCG78CvfXDpjF7Dkk0quRGCIp1AFArim2MKOfBEWfVjHnCqPYHs2gaZ9fPsE9RoN
	91nMkpHA==;
Received: from 179-125-79-204-dinamico.pombonet.net.br ([179.125.79.204] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rbJZj-000joD-Pj; Sat, 17 Feb 2024 13:13:48 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: cascardo@igalia.com,
	jolsa@kernel.org,
	daniel@iogearbox.net,
	yhs@fb.com
Subject: [PATCH 5.15 4/4] bpf: Remove trace_printk_lock
Date: Sat, 17 Feb 2024 09:13:21 -0300
Message-Id: <20240217121321.2045993-8-cascardo@igalia.com>
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

commit e2bb9e01d589f7fa82573aedd2765ff9b277816a upstream.

Both bpf_trace_printk and bpf_trace_vprintk helpers use static buffer guarded
with trace_printk_lock spin lock.

The spin lock contention causes issues with bpf programs attached to
contention_begin tracepoint [1][2].

Andrii suggested we could get rid of the contention by using trylock, but we
could actually get rid of the spinlock completely by using percpu buffers the
same way as for bin_args in bpf_bprintf_prepare function.

Adding new return 'buf' argument to struct bpf_bprintf_data and making
bpf_bprintf_prepare to return also the buffer for printk helpers.

  [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
  [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/

Reported-by: Hao Sun <sunhao.th@gmail.com>
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20221215214430.1336195-4-jolsa@kernel.org
[cascardo: there is no bpf_trace_vprintk in 5.15]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 include/linux/bpf.h      |  3 +++
 kernel/bpf/helpers.c     | 31 +++++++++++++++++++------------
 kernel/trace/bpf_trace.c | 11 +++--------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d18f717b6e7e..ef8fc639a575 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2287,10 +2287,13 @@ struct btf_id_set;
 bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
 
 #define MAX_BPRINTF_VARARGS		12
+#define MAX_BPRINTF_BUF			1024
 
 struct bpf_bprintf_data {
 	u32 *bin_args;
+	char *buf;
 	bool get_bin_args;
+	bool get_buf;
 };
 
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cfa23c7112ed..c8827d1ff3c5 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -710,19 +710,20 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 /* Per-cpu temp buffers used by printf-like helpers to store the bprintf binary
  * arguments representation.
  */
-#define MAX_BPRINTF_BUF_LEN	512
+#define MAX_BPRINTF_BIN_ARGS	512
 
 /* Support executing three nested bprintf helper calls on a given CPU */
 #define MAX_BPRINTF_NEST_LEVEL	3
 struct bpf_bprintf_buffers {
-	char tmp_bufs[MAX_BPRINTF_NEST_LEVEL][MAX_BPRINTF_BUF_LEN];
+	char bin_args[MAX_BPRINTF_BIN_ARGS];
+	char buf[MAX_BPRINTF_BUF];
 };
-static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
+
+static DEFINE_PER_CPU(struct bpf_bprintf_buffers[MAX_BPRINTF_NEST_LEVEL], bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
 
-static int try_get_fmt_tmp_buf(char **tmp_buf)
+static int try_get_buffers(struct bpf_bprintf_buffers **bufs)
 {
-	struct bpf_bprintf_buffers *bufs;
 	int nest_level;
 
 	preempt_disable();
@@ -732,15 +733,14 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 		preempt_enable();
 		return -EBUSY;
 	}
-	bufs = this_cpu_ptr(&bpf_bprintf_bufs);
-	*tmp_buf = bufs->tmp_bufs[nest_level - 1];
+	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
 
 	return 0;
 }
 
 void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
 {
-	if (!data->bin_args)
+	if (!data->bin_args && !data->buf)
 		return;
 	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
 		return;
@@ -765,7 +765,9 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data)
 {
+	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
 	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
+	struct bpf_bprintf_buffers *buffers = NULL;
 	size_t sizeof_cur_arg, sizeof_cur_ip;
 	int err, i, num_spec = 0;
 	u64 cur_arg;
@@ -776,14 +778,19 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 		return -EINVAL;
 	fmt_size = fmt_end - fmt;
 
-	if (data->get_bin_args) {
-		if (num_args && try_get_fmt_tmp_buf(&tmp_buf))
-			return -EBUSY;
+	if (get_buffers && try_get_buffers(&buffers))
+		return -EBUSY;
 
-		tmp_buf_end = tmp_buf + MAX_BPRINTF_BUF_LEN;
+	if (data->get_bin_args) {
+		if (num_args)
+			tmp_buf = buffers->bin_args;
+		tmp_buf_end = tmp_buf + MAX_BPRINTF_BIN_ARGS;
 		data->bin_args = (u32 *)tmp_buf;
 	}
 
+	if (data->get_buf)
+		data->buf = buffers->buf;
+
 	for (i = 0; i < fmt_size; i++) {
 		if ((!isprint(fmt[i]) && !isspace(fmt[i])) || !isascii(fmt[i])) {
 			err = -EINVAL;
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc85a87f020..a1dc0ff1962e 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -360,8 +360,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	return &bpf_probe_write_user_proto;
 }
 
-static DEFINE_RAW_SPINLOCK(trace_printk_lock);
-
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
@@ -371,9 +369,8 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
+		.get_buf	= true,
 	};
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
 	int ret;
 
 	ret = bpf_bprintf_prepare(fmt, fmt_size, args,
@@ -381,11 +378,9 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	if (ret < 0)
 		return ret;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, data.bin_args);
+	ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
 
-	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
+	trace_bpf_trace_printk(data.buf);
 
 	bpf_bprintf_cleanup(&data);
 
-- 
2.34.1


