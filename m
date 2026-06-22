Return-Path: <stable+bounces-267821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /FNbNNy+OWrEwwcAu9opvQ
	(envelope-from <stable+bounces-267821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 01:01:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7E6B2BE6
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 01:01:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=siuOBNh8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267821-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267821-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB3443037169
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 23:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E633E344;
	Mon, 22 Jun 2026 23:01:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833E2D1911
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 23:01:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169288; cv=none; b=n3wUlLdYMtWUjYeMVJSXoDt8wr2ykXaBmXeg8aLFau+k7oIrSrLfABv6OUoZ1LhHDzNsJ5c+Sl3qu9vWvz/0qB+G7mn3f9y2FMGJX3OYphoP1FIM9KZgk40X7B90GJexhPEe16wk3TG9gnT5Kt5iUkJ0IcuSjDMRd/R/V0q9ajs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169288; c=relaxed/simple;
	bh=M6hXi84S5gmVIUuWj+KozD+bYt5YW3hsLAnkoVvRJf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6C4T/Enic9TnuCVzIOhe11FSgQX9uXez91fvskn2eSoYht1o3kwBQw0obPWtIu3fOKlmPYnoSnBUx4dIWYPqTjV3KffedK+ovnJcYW0623Phpi6Cr6J8xsV9pTROiwb51iEdq9V/Zup62YTU/DzNZx243RMwr/nEpgw38EqKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=siuOBNh8; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4923fb1f095so37230105e9.1
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782169286; x=1782774086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl7x5/Ly0sc1rwSAjd0rqRNSTSQbeRuLQa2LMGScITQ=;
        b=siuOBNh8g0yWlcpVkpkGAcldwx1oAYYM2L8BeAQCS8RkgvQY/jDfo23ANv3MV2Jy+6
         Ucv2Vs/EcZqAENPWHGSUpM57CTNR1tAvq48HgF6W6v8EbEU6e15LNm0e+UBhrqEu4PrX
         2piNXHSN6wmpEa6lBwarP67fMzKUM8SBHk4bFc5aE5PcqQEWfxNfZiVaVH6l+tKXpW1/
         YcVslVgWIh7ttehfaGFAWL2GpzU+L+v1wJz8hVzvEDN0oWieSBPgpZdxCH7evn7k/K3+
         oZOVXLpmLQDaRm1z5cl8PQi+4U2YG1DNKjnoe05fjFid9pFzn7ve3Dy3qtSs8EP/C6kY
         dhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169286; x=1782774086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gl7x5/Ly0sc1rwSAjd0rqRNSTSQbeRuLQa2LMGScITQ=;
        b=lKrcL6+zdKhDw5G4jh3SW75RwzLQgkU0tup9KzaH19PQtq/HJEvu//8Yz7yHjoAqN8
         kSqomNi5yugCSBvu8vwfyLkdGo2Mgi+muu6dlsEjkPGSG83QYJ4M8rkAbuIcNZpO77i6
         hG8vVtYcbsi5/s1//KCqj/Sb6a1NVM0h/ip5LEeatTjIYR4DG5xMbFOtOTrkZuyg687O
         Ff2RiZNCkTjPeLCZBq52SOCDzkX/dBv9mt67bl+c8lakLdcUVgZrTZdT8msg+s5e2yqW
         PwAUf34jZAsuYVKdoZeTnq2idyOu1D+ciRhskk2M2iaxopgPVPBAskbpHJIO0NohrTKq
         5sPg==
X-Forwarded-Encrypted: i=1; AFNElJ8cgjJHXLs5AUs/zYxlhk9reS3FWNNzSrrIFO2g+5CZXbX9w7/02bR8KE/jJeCsTrEPLxdaM58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzUFjhIoP9kIvGtOnjq+AWC8YRG0N2TH7zR8VbMQmAldFaEJg
	PZtM24vP9vXy007Nr5EDkiD7QxAhCq+RGNhMYAyhS04qCm0TpkYhFHM=
X-Gm-Gg: AfdE7clxfiRPOQSpQjRHDw4UuBm1FMPpsiY/gBJdMEei/d6ZGFkgX4+hVPuwDIqwc5m
	QZtoAmIqDd9hVDP+xmV2yB9p32zwrPf6EpT9DViV++PkVxXdPvN5GR+/K5A7XKnOQvhm5/GtWQ0
	xMc//TuX66LVSWx5ZpUqJMqqrxgppmgKZ9QA09Nb3q861ZFoVuXjFdFvhMsCq2o3Q9T8CVg0I1k
	Zhf9VrDC98pzA8yLIwQabAN2XZPxBozuewmAE1+kA/vXmnJ32QMH38mL9OEnJo5BEyQw2pE+tgl
	Eoxfo6Mt02SZOYBEefF0mdKVkMqDc9rWtT/7z7d2vhTGnR7MYPuF4LZmqESqvGMWuWc9X9sBejq
	PaJ+67RKN0KFLFTuiWWHvhNxL/T4BoB5Zr23oPA6qhQ2uVVwAnc49ht2uOw==
X-Received: by 2002:a05:600c:8b77:b0:492:4911:8a with SMTP id 5b1f17b1804b1-4925b35a0f9mr2465495e9.12.1782169285687;
        Mon, 22 Jun 2026 16:01:25 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm371339255e9.5.2026.06.22.16.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:01:24 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH bpf v3 1/2] bpf: Reset register bounds before narrowing retval range in check_mem_access()
Date: Mon, 22 Jun 2026 23:01:22 +0000
Message-ID: <20260622230123.3695446-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622230123.3695446-1-tristmd@gmail.com>
References: <20260622230123.3695446-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,kernel.org,linux.dev,vger.kernel.org,talencesecurity.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267821-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:xukuohai@huawei.com,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talencesecurity.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40A7E6B2BE6

From: Tristan Madani <tristan@talencesecurity.com>

When the BPF verifier processes a context load of an LSM hook return
value, it calls __mark_reg_s32_range() to narrow the register to the
hook's valid range. However, __mark_reg_s32_range() intersects the new
range with the register's existing bounds using max_t()/min_t() rather
than replacing them.

If the destination register carries stale bounds from a prior instruction
(e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
reality. The verifier then believes it knows the register's exact value,
while at runtime the actual hook return value is loaded, creating a
verifier/runtime mismatch that can be used to bypass BPF memory safety
checks.

The else branch already calls mark_reg_unknown() to reset register state
before any narrowing. Apply the same reset in the is_retval path so
stale bounds are cleared before __mark_reg_s32_range() intersects.

Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a2b348f98080..21a365d436a5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6201,6 +6201,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			 */
 			if (info.reg_type == SCALAR_VALUE) {
 				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
+					mark_reg_unknown(env, regs, value_regno);
 					err = __mark_reg_s32_range(env, regs, value_regno,
 								   range.minval, range.maxval);
 					if (err)
-- 
2.47.3


