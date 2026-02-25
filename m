Return-Path: <stable+bounces-219585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKo1Dk7ZnmkTXgQAu9opvQ
	(envelope-from <stable+bounces-219585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:13:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A961964D0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 12:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D4A330055CA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4561393DF4;
	Wed, 25 Feb 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5im3rpU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888CF393DEB;
	Wed, 25 Feb 2026 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772017979; cv=none; b=bTL4KeoC8uwQLyze2w9c21gv6jBWLFctRJ6nAzAlL4Sf+aDJfZ6bVjPDMnrg2BQNY17OHbiVkaAU/W/fuydS2z+J5ce2wewEGj6dkeuRGOs7wb8PsKICaHK0PSSr/p9/F63oBvuXTy9qSzrSWkvEe82k4ScCy8WiECCnjzPdRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772017979; c=relaxed/simple;
	bh=AIOWAd8Dlt/5ms9fT6CrYW4koN+0gwQ84aeIXWTJXlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SGyqTl2YQZb1ipKpfLUqsZegVrJf7TEA+ZPaYu+InxaZm6JBSbYwJYQIPu8DJ2482ywLCNrmLWtxQLLkSQigtFx/Fe0DcC7QNgel+TjYdl45VQso0ZGJRl1J4mHewPjGrDO2A0kHF46FtO3QGoHjCadzNg7O3JWU+pFgX/s4wA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5im3rpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3423C116D0;
	Wed, 25 Feb 2026 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772017979;
	bh=AIOWAd8Dlt/5ms9fT6CrYW4koN+0gwQ84aeIXWTJXlw=;
	h=From:To:Cc:Subject:Date:From;
	b=L5im3rpU6xNVqZDUqXO0x48txzFtnQezNx57OfC7DpD+KFmjaTAT+9KheR2ydjkOm
	 u/lKY6SWRZ1QOWUSlDenXZZt7v6ODRHSOnmh/kiaoiBcaL9kkzSTa7KhijyBsltyyD
	 BhuXbB2/gn5K130QGHy91D9mg+YKobHc/+r5RO8sNgSvoX0nv0Xn2gd9SGyPXOQPGq
	 GzNKPpgu6/vKLoUgPrbOpo83ul3XH5/3RmsrgG5eopeJx5CgeTqVPyJC9zlGfPej7/
	 P/e6k/Ee92cD3pCY95fIzfJvxLnIURqA/3zC4Amxt5A1+C6BuZ8akoIvnoJkjsG4Df
	 NZiwZbU/hTm0g==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf] bpf: Fix kprobe_multi cookies access in show_fdinfo callback
Date: Wed, 25 Feb 2026 12:12:49 +0100
Message-ID: <20260225111249.186230-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,fb.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219585-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jolsa@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78A961964D0
X-Rspamd-Action: no action

We don't check if cookies are available on the kprobe_multi link
before accessing them in show_fdinfo callback, we should.

Cc: stable@vger.kernel.org
Fixes: da7e9c0a7fbc ("bpf: Add show_fdinfo for kprobe_multi")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9bc0dfd235af..0b040a417442 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2454,8 +2454,10 @@ static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
 					 struct seq_file *seq)
 {
 	struct bpf_kprobe_multi_link *kmulti_link;
+	bool has_cookies;
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	has_cookies = !!kmulti_link->cookies;
 
 	seq_printf(seq,
 		   "kprobe_cnt:\t%u\n"
@@ -2467,7 +2469,7 @@ static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
 	for (int i = 0; i < kmulti_link->cnt; i++) {
 		seq_printf(seq,
 			   "%llu\t %pS\n",
-			   kmulti_link->cookies[i],
+			   has_cookies ? kmulti_link->cookies[i] : 0,
 			   (void *)kmulti_link->addrs[i]);
 	}
 }
-- 
2.53.0


