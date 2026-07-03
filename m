Return-Path: <stable+bounces-271640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M61KHZ5SR2qsWAAAu9opvQ
	(envelope-from <stable+bounces-271640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 08:11:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFA56FEFA2
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 08:11:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=TBYJ32O1;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271640-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271640-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C458301F991
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 06:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26400360ECA;
	Fri,  3 Jul 2026 06:11:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D2207DF7
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 06:11:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783059099; cv=none; b=jIKUuH+QuPVG6IkK7EpdBk/aQ5s2cpBRfqVQmALIZjopCTfR1vT2qevWUCa0vV58KVGavow8FyivzAEmgxBTZ8rVckeWCdUvMr+oHRchfr1ChxRu4scq/o0wymlRViLoue62wB1RgWfcxKPJNkjss9r+SQmFtCQVna/K0fhm33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783059099; c=relaxed/simple;
	bh=RQUCvdA+MVI6q4EFQD0YutZcNYyTZYIxmj8GOv13Kgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0bz+5c6LOKI9uFgXYJey6rFSxir1CpFc9PRaB4udJMVNzg92swKJN2Onl/x2HWmBQt2ErwU4tU3QuNCiT7RkRQ2Xrb/3hjXue7jSRxvHlpniKLc1pLVWkl+ZxCkQaNLAzw6F7LBB7AF6jymaYKgsHgDPOCYxLBv3aNZC6o2+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TBYJ32O1; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so782825e9.0
        for <stable@vger.kernel.org>; Thu, 02 Jul 2026 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783059097; x=1783663897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PX/Sa5apQ3btYbp8NQIQflFTzJ1yYIUBG+U4cPBbk5w=;
        b=TBYJ32O14koPBv8rHEotXuKraJsr8DKp09yD/d22XHJiuBu2LAoRyHF5AH2LcTu+18
         qJJ9Cf+RvRgz/8D6m9hVtyZqUAAmJKM3O6XQsQ5Zxs7j+CAZfVgXV9MQAMPWQFmeJ3CV
         4hGhaLlSPi4PfGs61mChw6wOSG71NaY1KrmCYDSX/Hr3eeDzUBMkP0PQhtsYcrRovE92
         h+GPG74ZFa1PCwSCLjcxq7gBLtlf3CN4OKMQDvJB4Mnu2pbKYNgcieSrnSv0XVXhaMDz
         bIiDt48OBBKU1Ros9bGVQht88fs8p3S3TYfO5ptsuntc4lXaGQXmneHLilGw2ogl7DeN
         gl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783059097; x=1783663897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PX/Sa5apQ3btYbp8NQIQflFTzJ1yYIUBG+U4cPBbk5w=;
        b=IWm68mpt5mB28Aiu36RGhCVA/halLplqaucALdDlje0QTUZiqvhA3jTw0idBcSugRm
         ANkVr7osrycxMzSKSu4LZz6DlrjODIwN16GT/TG2ds20r/IPkvBJ3QrWH1xd2lDHyXQR
         1LbFo5IfeUPkSI4+OwxlftXXrZwxbLNSGv1w0MVMQ+hajAHm8uFi/u4Oi+qYGnuG2Mjn
         AjPv1BCuN7LI7G/S3qRuizQGX7wqwCUBClsZ7sVsGEiEXatmpalYK9rLPrduPpKVVOg1
         ieK0ULYkYBjf63xlo0R8wksdsGIarvKiZ+q4eWHvl8ucVd5QiPbRcRWNUN/daOBRds9J
         x8jA==
X-Gm-Message-State: AOJu0YyURFfg4dO2lK3EA+OzLQK5wPmw+AKpEIXRauskcZp1tkbQrPhK
	KsAnXfGwdxJQdIb2Tf5HvMhYZ2tQRtEjlnG3X92or7iezqJFF/41G5+EuiUBo4QHFeqI7qBKlCM
	pHnkp
X-Gm-Gg: AfdE7cnnJsrBjG2swVvmgyI+ae8YJh14gRmGHp2DXvGv3aenvN4R0WlPDcwbHgwesvu
	N7T8/6CJEB9hvWIMVxhxHx3/LHTTHL5tUxw2wnnoE3Rv1YKjVSBA1uTemwEMIaCEwRTaFyNjl3m
	n4csF2OAPQs9GT8nAgkRi94rV63BCg/JlemG0vqAHWCprEFIh6G1+x+CvV2K4oUGOJFJ21mH1gH
	QlSEPg8npZxrFrZzjnhEad9P5iOVnVqjy5mHRECYFeHHdcq+rUNsttj0KzAzRmlpJRcc/9ljgiC
	nkF0Ml7sb/a8OUFo5AMNx+D3S/s6CdgaKpvw+fB7v+EUYxNvOeS3qFMeZ7mMTJocUojH3srPhl5
	ctKvkCLneSQTvnG8B/T3criuwQQ8uZiTEGLN+0AOSg33Iq8CK/z0+SHFGNfEX76dZBPR08bIWXR
	H0DHFO8qsXssW0YoRCQcWZbdEAEbgKoLPFAiAMu4M=
X-Received: by 2002:a05:600d:c:b0:493:b771:ddf9 with SMTP id 5b1f17b1804b1-493c2b3d048mr98662765e9.1.1783059096646;
        Thu, 02 Jul 2026 23:11:36 -0700 (PDT)
Received: from localhost (27-53-162-24.adsl.fetnet.net. [27.53.162.24])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb67156csm1057496fac.18.2026.07.02.23.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 23:11:34 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 6.1 1/1] bpf, arm64: Reject out-of-range B.cond targets
Date: Fri,  3 Jul 2026 14:11:25 +0800
Message-ID: <20260703061126.125313-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271640-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:shung-hsi.yu@suse.com,m:daniel@iogearbox.net,m:puranjay@kernel.org,m:ast@kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:from_mime,suse.com:email,suse.com:mid,suse.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCFA56FEFA2

From: Daniel Borkmann <daniel@iogearbox.net>

commit 48d83d94930eb4db4c93d2de44838b9455cff626 upstream.

aarch64_insn_gen_cond_branch_imm() calls label_imm_common() to
compute a 19-bit signed byte offset for a conditional branch,
but unlike its siblings aarch64_insn_gen_branch_imm() and
aarch64_insn_gen_comp_branch_imm(), it does not check whether
label_imm_common() returned its out-of-range sentinel (range)
before feeding the value to aarch64_insn_encode_immediate().

aarch64_insn_encode_immediate() unconditionally masks the value
with the 19-bit field mask, so an offset that was rejected by
label_imm_common() gets silently truncated. With the sentinel
value SZ_1M, the resulting field ends up with bit 18 (the sign
bit of the 19-bit signed displacement) set, and the CPU decodes
it as a ~1 MiB *backward* branch, producing an incorrectly
targeted B.cond instruction. For code-gen locations like the
emit_bpf_tail_call() this function is the only barrier between
an overflowing displacement and a silently miscompiled branch.

Fix it by returning AARCH64_BREAK_FAULT when the offset is out
of range, so callers see a loud failure instead of a silently
misencoded branch. validate_code() scans the generated image
for any AARCH64_BREAK_FAULT and then lets the JIT fail.

Fixes: 345e0d35ecdd ("arm64: introduce aarch64_insn_gen_cond_branch_imm()")
Fixes: c94ae4f7c5ec ("arm64: insn: remove BUG_ON from codegen")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Puranjay Mohan <puranjay@kernel.org>
Link: https://lore.kernel.org/r/20260415121403.639619-1-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Tested that after applying this patch BPF selftests running on aarch64
still passes in 6.6[1]. On 6.1 I only checked that it compiles.

1: https://github.com/kernel-patches/linux-stable/actions/runs/28640243380/job/84934703682?pr=7
---
 arch/arm64/lib/insn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/lib/insn.c b/arch/arm64/lib/insn.c
index 44bb90ee2f41..a50f6c061c27 100644
--- a/arch/arm64/lib/insn.c
+++ b/arch/arm64/lib/insn.c
@@ -423,6 +423,8 @@ u32 aarch64_insn_gen_cond_branch_imm(unsigned long pc, unsigned long addr,
 	long offset;
 
 	offset = label_imm_common(pc, addr, SZ_1M);
+	if (offset >= SZ_1M)
+		return AARCH64_BREAK_FAULT;
 
 	insn = aarch64_insn_get_bcond_value();
 
-- 
2.54.0


