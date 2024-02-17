Return-Path: <stable+bounces-20401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ED5858F43
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 13:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E347A283B6B
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9948D6A02B;
	Sat, 17 Feb 2024 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OkaJf2GI"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A799F6A024
	for <stable@vger.kernel.org>; Sat, 17 Feb 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172029; cv=none; b=tWg2EhZ2IVLO68jLdt4Dez+pbIrdUUFVJljRQmssNfa/aF4ZVSlAGHsXT4XhGMNyMGyQvkEXSYCzQLgX3NbLZmNf9AFAHY9cpe0ewrWN5hIAZXkKJOZuudmTBvE0ivqxdmTWBDFCCG3j/coMRd/zbmLPkEGoYW4Irla4iT9ssFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172029; c=relaxed/simple;
	bh=XjwZcWToKA0GRsubTHjFaUoRGW0Z+QG5j1QPdPcRkq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPmGAnUn7lI+6gtQj7PQrojr5rCwWLH4c4C5fhMOlrn7MNjT/lWFy7PgcdypYXw1d2QXavF68pzu6rZkKk72FEneP/e6ahm1c0rDSOEdergciXGvGmv+nn46j9FlGMZT6j8QUkKQwXIoRGWFjxnsR1L/sD/WFClODnmFLfU35z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OkaJf2GI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NLkFhd6p6h3/OrvzTkarne/6zOBvULIHrgykIAVnD9A=; b=OkaJf2GITNVrSXbpOH0EdTPE78
	fj8s9eOd9Edv8CRqbYFUibazFM+eJZlPxFFKg8nC5BAWyVjU+3WCdtwKrfled9vKV0/5Z9tR4wugE
	9J9C6i7/4E3Y9UCOHPk7KFd9U8YqPIgPs2a9uyzpjDYsYy/XKnSHERHf7XNhdFqUS9DOSA2dYy08e
	yc05qGxNC7FWaWrROeLvWqVGMfn/2vrYBcF/tcS1D/MpJIkN3L34hqkPs1PYyGHWfgBe5XmFfkTlu
	KlZ7NUQliVLuRz8HaJWpZcoZie/j+FmYP+VsI5pgKqe+3VumUclNZGDFUXOw4DDM2G13nLR/2N2Ak
	JRTtHhcA==;
Received: from 179-125-79-204-dinamico.pombonet.net.br ([179.125.79.204] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rbJZg-000joD-QY; Sat, 17 Feb 2024 13:13:45 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: cascardo@igalia.com,
	jolsa@kernel.org,
	daniel@iogearbox.net,
	yhs@fb.com
Subject: [PATCH 5.15 3/4] bpf: Do cleanup in bpf_bprintf_cleanup only when needed
Date: Sat, 17 Feb 2024 09:13:20 -0300
Message-Id: <20240217121321.2045993-7-cascardo@igalia.com>
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

commit f19a4050455aad847fb93f18dc1fe502eb60f989 upstream.

Currently we always cleanup/decrement bpf_bprintf_nest_level variable
in bpf_bprintf_cleanup if it's > 0.

There's possible scenario where this could cause a problem, when
bpf_bprintf_prepare does not get bin_args buffer (because num_args is 0)
and following bpf_bprintf_cleanup call decrements bpf_bprintf_nest_level
variable, like:

  in task context:
    bpf_bprintf_prepare(num_args != 0) increments 'bpf_bprintf_nest_level = 1'
    -> first irq :
       bpf_bprintf_prepare(num_args == 0)
       bpf_bprintf_cleanup decrements 'bpf_bprintf_nest_level = 0'
    -> second irq:
       bpf_bprintf_prepare(num_args != 0) bpf_bprintf_nest_level = 1
       gets same buffer as task context above

Adding check to bpf_bprintf_cleanup and doing the real cleanup only if we
got bin_args data in the first place.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20221215214430.1336195-3-jolsa@kernel.org
[cascardo: there is no bpf_trace_vprintk in 5.15]
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 include/linux/bpf.h      |  2 +-
 kernel/bpf/helpers.c     | 16 +++++++++-------
 kernel/trace/bpf_trace.c |  4 ++--
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index c738e98b426b..d18f717b6e7e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2295,6 +2295,6 @@ struct bpf_bprintf_data {
 
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data);
-void bpf_bprintf_cleanup(void);
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 20796e387e2c..cfa23c7112ed 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -738,12 +738,14 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 	return 0;
 }
 
-void bpf_bprintf_cleanup(void)
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data)
 {
-	if (this_cpu_read(bpf_bprintf_nest_level)) {
-		this_cpu_dec(bpf_bprintf_nest_level);
-		preempt_enable();
-	}
+	if (!data->bin_args)
+		return;
+	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
+		return;
+	this_cpu_dec(bpf_bprintf_nest_level);
+	preempt_enable();
 }
 
 /*
@@ -975,7 +977,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 	err = 0;
 out:
 	if (err)
-		bpf_bprintf_cleanup();
+		bpf_bprintf_cleanup(data);
 	return err;
 }
 
@@ -1001,7 +1003,7 @@ BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
 
 	err = bstr_printf(str, str_size, fmt, data.bin_args);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return err + 1;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 33da2ff59b96..2bc85a87f020 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -387,7 +387,7 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return ret;
 }
@@ -435,7 +435,7 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 
 	seq_bprintf(m, fmt, data.bin_args);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return seq_has_overflowed(m) ? -EOVERFLOW : 0;
 }
-- 
2.34.1


