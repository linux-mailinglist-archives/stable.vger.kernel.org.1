Return-Path: <stable+bounces-20398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25554858F41
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 13:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585181C213E4
	for <lists+stable@lfdr.de>; Sat, 17 Feb 2024 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C743D6A02F;
	Sat, 17 Feb 2024 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kqwbEBQU"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD826A023
	for <stable@vger.kernel.org>; Sat, 17 Feb 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708172027; cv=none; b=T95K5KfPCH5jDxPzXh8YrYhKowrJeYpvxoY/qGI5QYXP8iPKw4PACrokul8lGtw158dW/5d1suIhgD6hCIf96A3nIO/YK0/esS7F6optNOhZFACq6BxxmW+59oOxZ9ordCnZ114wRgguJ4JhC3ZZ0uGaZrXrwfY3GhidK3306NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708172027; c=relaxed/simple;
	bh=bUHKGl73hmGWftah8yabQNN6Hwu/83ug2T1nexfoe0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hzQsvsvtVsmSSjWjEVbMjSv3Wauno44JmRMN1h0h0JB2jYEg8S0AB6/boRwxIaZ+GIBLq2m6wRUXd9rliuZ5NOeiyihjSWrbs/Cp6AcBe+qaAsGpZgCUIIY4XItxP6JLTLZZNZ/yrV+Wp7SeJmX/sFwGQWNBeQ0ZkZ/RFOsJzgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kqwbEBQU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ovarhB65lp1Wy61UDe6WEjO0J/Y5CD9FOsflZN9D4qA=; b=kqwbEBQU5gAKZr7PIbbZBo2WCd
	sWpm56tiYx5QL29I/SCMfY//Xw+mI2rr5udTQVm7O0ysVvPuPOSxceJJ/IL94+3YTjL8O8J9Qs5OD
	NINlBFetF3A394iPM2Bx5ldVmqoYCyNP8UxZmANSF65rM9amHNXegTE2g91gwlmoasumvpGZFRX4F
	MNSbkowFTq2VUL7evnMBn/URoTVAjtsT+SSG+u8U3A7y0kbX2HwIqJVJUjsSAwqYtfAGAO9uY1YUo
	rlVL8ol3JK5nCanV/UnGysiy+tXtwN7nPOuW2yBWVTRNK9wTVPvTzlV9rQK94+66gChCTCNKmpEXq
	XdaSkV8A==;
Received: from 179-125-79-204-dinamico.pombonet.net.br ([179.125.79.204] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rbJZW-000joD-2U; Sat, 17 Feb 2024 13:13:34 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: cascardo@igalia.com,
	jolsa@kernel.org,
	daniel@iogearbox.net,
	yhs@fb.com
Subject: [PATCH 6.1 2/3] bpf: Do cleanup in bpf_bprintf_cleanup only when needed
Date: Sat, 17 Feb 2024 09:13:16 -0300
Message-Id: <20240217121321.2045993-3-cascardo@igalia.com>
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
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 include/linux/bpf.h      |  2 +-
 kernel/bpf/helpers.c     | 16 +++++++++-------
 kernel/trace/bpf_trace.c |  6 +++---
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 0e4fb16cd5c1..bc4e6969899a 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2747,7 +2747,7 @@ struct bpf_bprintf_data {
 
 int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 			u32 num_args, struct bpf_bprintf_data *data);
-void bpf_bprintf_cleanup(void);
+void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
 
 /* the implementation of the opaque uapi struct bpf_dynptr */
 struct bpf_dynptr_kern {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 42141d59e9c6..64f41f58b37b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -781,12 +781,14 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
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
@@ -1018,7 +1020,7 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
 	err = 0;
 out:
 	if (err)
-		bpf_bprintf_cleanup();
+		bpf_bprintf_cleanup(data);
 	return err;
 }
 
@@ -1044,7 +1046,7 @@ BPF_CALL_5(bpf_snprintf, char *, str, u32, str_size, char *, fmt,
 
 	err = bstr_printf(str, str_size, fmt, data.bin_args);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return err + 1;
 }
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index bbf44095999f..263a54d0d9ee 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -395,7 +395,7 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return ret;
 }
@@ -453,7 +453,7 @@ BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void *, args,
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return ret;
 }
@@ -493,7 +493,7 @@ BPF_CALL_5(bpf_seq_printf, struct seq_file *, m, char *, fmt, u32, fmt_size,
 
 	seq_bprintf(m, fmt, data.bin_args);
 
-	bpf_bprintf_cleanup();
+	bpf_bprintf_cleanup(&data);
 
 	return seq_has_overflowed(m) ? -EOVERFLOW : 0;
 }
-- 
2.34.1


