Return-Path: <stable+bounces-220181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHHtIPkvo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC8B1C585D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FFF3322DADC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432294BCAA5;
	Sat, 28 Feb 2026 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddC8ogpd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A774BCAA0;
	Sat, 28 Feb 2026 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300089; cv=none; b=JfLOdBABMY1ya5E8s+akOy18p9WNV8RBaVivCxLxGU+ls8dbf6zh6GdoxInKJxu68iV21YFH7pUYSPuStlPEslqWFem6j8o2YP07l9pbK2SG0Dz+op6n9KyLJeQdjrSNbhIc8jswzyaDgAuBz2AyvzimyEMU0QFNrSbs42bczyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300089; c=relaxed/simple;
	bh=z6QPyugg6VyaFBQ2lBqGIoU1ZPNNnRArOOY/e7Iit6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrBbUVwaw5HEjNwSmtKtDiCeLUD9WY3BrX/w1hVcJNBOpXwU1YfiHYsT+xbCv4fpFqWrpERR5jA55q1KDerNJAVHW25+RpEK2FjXfqSPwkhBkVmEDfu9R/vxzAhGSv/K6YW75Hcjt1AEwRHpmeBzgpToD62WgC419w6rfW3yAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddC8ogpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8978C19423;
	Sat, 28 Feb 2026 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300088;
	bh=z6QPyugg6VyaFBQ2lBqGIoU1ZPNNnRArOOY/e7Iit6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddC8ogpd094VRZl9X4uofD0F1P6PWMCPZkLII6nXhsllxelpFZwv5bal0QdNAyZUt
	 nLjMuw8eQKPhZSBSFmd88GMWxVvd+2ry/owyQsveAcPDaL9eXPHmTPPW1TITIcrmEG
	 MRqaNoK087K8gHdfdLZD+ed7q5R+f7n7SwyLbpAhquUE4RzuDnp6+jT+KZ78DuTo3B
	 emkQCbk83zyhIeCOmlS9IOhDN+EpyDdkJUCdK4tyLlv+b242hRaM3GlxvHxpk6upiN
	 RFHO3ydsLByJqUnPl/0cax+agvboaY3c5DUazyUoAWN2+YXeUL6RnuTRf6yV1VT1AG
	 J3NHPz6U28Pag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 103/844] arm64/ftrace,bpf: Fix partial regs after bpf_prog_run
Date: Sat, 28 Feb 2026 12:20:16 -0500
Message-ID: <20260228173244.1509663-104-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,goodmis.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220181-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0AC8B1C585D
X-Rspamd-Action: no action

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 276f3b6daf6024ae2742afd161e7418a5584a660 ]

Mahe reported issue with bpf_override_return helper not working when
executed from kprobe.multi bpf program on arm.

The problem is that on arm we use alternate storage for pt_regs object
that is passed to bpf_prog_run and if any register is changed (which
is the case of bpf_override_return) it's not propagated back to actual
pt_regs object.

Fixing this by introducing and calling ftrace_partial_regs_update function
to propagate the values of changed registers (ip and stack).

Reported-by: Mahe Tardy <mahe.tardy@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/bpf/20260112121157.854473-1-jolsa@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ftrace_regs.h | 25 +++++++++++++++++++++++++
 kernel/trace/bpf_trace.c    |  1 +
 2 files changed, 26 insertions(+)

diff --git a/include/linux/ftrace_regs.h b/include/linux/ftrace_regs.h
index 15627ceea9bcc..386fa48c4a957 100644
--- a/include/linux/ftrace_regs.h
+++ b/include/linux/ftrace_regs.h
@@ -33,6 +33,31 @@ struct ftrace_regs;
 #define ftrace_regs_get_frame_pointer(fregs) \
 	frame_pointer(&arch_ftrace_regs(fregs)->regs)
 
+static __always_inline void
+ftrace_partial_regs_update(struct ftrace_regs *fregs, struct pt_regs *regs) { }
+
+#else
+
+/*
+ * ftrace_partial_regs_update - update the original ftrace_regs from regs
+ * @fregs: The ftrace_regs to update from @regs
+ * @regs: The partial regs from ftrace_partial_regs() that was updated
+ *
+ * Some architectures have the partial regs living in the ftrace_regs
+ * structure, whereas other architectures need to make a different copy
+ * of the @regs. If a partial @regs is retrieved by ftrace_partial_regs() and
+ * if the code using @regs updates a field (like the instruction pointer or
+ * stack pointer) it may need to propagate that change to the original @fregs
+ * it retrieved the partial @regs from. Use this function to guarantee that
+ * update happens.
+ */
+static __always_inline void
+ftrace_partial_regs_update(struct ftrace_regs *fregs, struct pt_regs *regs)
+{
+	ftrace_regs_set_instruction_pointer(fregs, instruction_pointer(regs));
+	ftrace_regs_set_return_value(fregs, regs_return_value(regs));
+}
+
 #endif /* HAVE_ARCH_FTRACE_REGS */
 
 /* This can be overridden by the architectures */
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 59c2394981c72..325579c7da260 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2564,6 +2564,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
+	ftrace_partial_regs_update(fregs, bpf_kprobe_multi_pt_regs_ptr());
 	rcu_read_unlock();
 
  out:
-- 
2.51.0


