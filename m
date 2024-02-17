Return-Path: <stable+bounces-20400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3789858F45
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 13:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C41B21890
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED996A023;
	Sat, 17 Feb 2024 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OEMq1O0X"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161446A01A
	for <stable@vger.kernel.org>; Sat, 17 Feb 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172028; cv=none; b=cEfLFBYdrB7lt+TuC8wctnR/NKwv7LSvVKORzEkBcc5/h5UDsOk96adhDDMvk6zBvW49IZpyGKM4NvOGjwTiSxuJjIZWNeknjN7burNmQ+ZZCox/cssHwxdoYR1Qa9Hu08JqwuOedaatZ/vlJz/i4ROJJmJL4gEnO4g1kYhQfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172028; c=relaxed/simple;
	bh=Y4lY9orR4MmunmU3NZrbHYxgBKnFT06NJ589NJ4sPUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WY0AMQ7aWgGFYIaU+nKKeIblmFKa0tlm3700fJ5R1/oZ7nqMKYGUWs6HGsokf3HXg30fYVnx4vxvBuOtLzkgciBTrYxeplFbTrZwtXG0qiBDEC4gatN+neTm3vJ3LkSTAwEPoPpmzWDLzoEPnMa68h6AYLF1Q7l1MpRJcZbPrq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OEMq1O0X; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iA20Wlp3WQivtlXyyMmgE9mueiK3MW2+y3/DaQR3VhQ=; b=OEMq1O0XFdQwuZvuG1lnL8YpaS
	66gJBsMWYex4CBAL7Ae5EYxnx22Wf1i1pDDiPw5oFDaLh4bAtSDyW2FZWPpIlSjJAlAfAFgMnmSgf
	oydG/pm6O08otyXVoYTcrFH/vktXZQhPPbiN+2ioWmrfrRBwQ8fOrfIg3zj2CPMTEB4NLH1aYz8bA
	fTkMf+euW7nSFRWBhTl3Zx2Ug0En8cN6Rm8CFsmn4WQ3Q04m+z8YX7xiorH8EM4jG6FO1FHUPc6zE
	ZtdaNqtE2wPy8bJowRvKZU7uhClQbRowc83DxIBIckDKVjN1BnSrmeivCF8r9aTlQiomI6ppiS/dg
	UoK08c/A==;
Received: from 179-125-79-204-dinamico.pombonet.net.br ([179.125.79.204] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rbJZZ-000joD-4b; Sat, 17 Feb 2024 13:13:37 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: cascardo@igalia.com,
	jolsa@kernel.org,
	daniel@iogearbox.net,
	yhs@fb.com
Subject: [PATCH 6.1 3/3] bpf: Remove trace_printk_lock
Date: Sat, 17 Feb 2024 09:13:17 -0300
Message-Id: <20240217121321.2045993-4-cascardo@igalia.com>
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
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 include/linux/bpf.h      |  3 +++
 kernel/bpf/helpers.c     | 31 +++++++++++++++++++------------
 kernel/trace/bpf_trace.c | 20 ++++++--------------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index bc4e6969899a..1ca1902af23e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2739,10 +2739,13 @@ struct btf_id_set;
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
index 64f41f58b37b..6a61a98d602c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -753,19 +753,20 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
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
@@ -775,15 +776,14 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
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
@@ -808,7 +808,9 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data)
 {
+	bool get_buffers = (data->get_bin_args && num_args) || data->get_buf;
 	char *unsafe_ptr = NULL, *tmp_buf = NULL, *tmp_buf_end, *fmt_end;
+	struct bpf_bprintf_buffers *buffers = NULL;
 	size_t sizeof_cur_arg, sizeof_cur_ip;
 	int err, i, num_spec = 0;
 	u64 cur_arg;
@@ -819,14 +821,19 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
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
index 263a54d0d9ee..3fdde232eaa9 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -368,8 +368,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	return &bpf_probe_write_user_proto;
 }
 
-static DEFINE_RAW_SPINLOCK(trace_printk_lock);
-
 #define MAX_TRACE_PRINTK_VARARGS	3
 #define BPF_TRACE_PRINTK_SIZE		1024
 
@@ -379,9 +377,8 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	u64 args[MAX_TRACE_PRINTK_VARARGS] = { arg1, arg2, arg3 };
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
+		.get_buf	= true,
 	};
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
 	int ret;
 
 	ret = bpf_bprintf_prepare(fmt, fmt_size, args,
@@ -389,11 +386,9 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	if (ret < 0)
 		return ret;
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
-	ret = bstr_printf(buf, sizeof(buf), fmt, data.bin_args);
+	ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
 
-	trace_bpf_trace_printk(buf);
-	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
+	trace_bpf_trace_printk(data.buf);
 
 	bpf_bprintf_cleanup(&data);
 
@@ -433,9 +428,8 @@ BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
 {
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
+		.get_buf	= true,
 	};
-	static char buf[BPF_TRACE_PRINTK_SIZE];
-	unsigned long flags;
 	int ret, num_args;
 
 	if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
@@ -447,11 +441,9 @@ BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
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


