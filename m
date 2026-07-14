Return-Path: <stable+bounces-274190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jmZBH94DVmoFyAAAu9opvQ
	(envelope-from <stable+bounces-274190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:39:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFD8752F39
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:39:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ajw33idr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274190-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274190-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51E38301C1B7
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 09:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E999040B373;
	Tue, 14 Jul 2026 09:39:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC92918DB2A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:39:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021953; cv=none; b=IGAssQyWaeB/5asd/Y2WVSVfFiHL4XjZ/iXX2kSy8TCoee5nxcJKTcgHYV+kJtHVAwCJDYuOewh+Q8ddvXvd18vNJVlyNOomaGnOrsOfYv5RCMel7tK1vxscXhqAga6ehEujE4nOwJ6pjdM5NIappVC7/69sWSrLOwAQlVQB1Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021953; c=relaxed/simple;
	bh=mfnEbSScsujRwoxasSxyWdhvlmzfSWWEe+mMVO63fwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4do5q5y3c4LhyDXmiqiEhRnNlZVU4XmeHIpnvPxmxGhi5iEKMwHQtTjVB60AwOOu8pE02cos6U7aO3VxR/fBT0gJDkYbPDB0mUx+CdT1e8F2Dyc+ej9fSSesdZP/kqEhH2Bddoa0bMe8EevPvSIKimw2xWWYBQJOMAAKp/5Ck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ajw33idr; arc=none smtp.client-ip=209.85.160.181
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c0cea8883so6572401cf.1
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 02:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784021950; x=1784626750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wL+dQXVVG1jrwdjXyQWY9fUn4W24MWcB/WCkDuLFzik=;
        b=Ajw33idrKx2wBknLRObepsEF2PyiQ5p/GpEFEudsDvoqMAiujy5gWefUB/St074/X5
         9rF0RzZy2qCl3dlktddBqoI0e0kSXOPtrEVLuaNQef+p48ZMm+Xm3MFN+bnzsZcrbUXu
         EQFPC2uE5kotDPwJOmjPM3ieuaHpW198N9d4YM+59/JgRBVtShihMyMq033aMDBAX/0a
         pFobB7xmEetSo2Eb6iUkfLMkXyzF4tSCejdJXhEWGqvVGpLhXcqwZstXvhIJcIRelAK8
         9kdVdYq0aa/QQNX1Bw2fI+rcTbnf/WenW30eRlQcqgPJWvhDeTS2cniXfepkKsj4U8EY
         G0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021950; x=1784626750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wL+dQXVVG1jrwdjXyQWY9fUn4W24MWcB/WCkDuLFzik=;
        b=HRZ5G/bXS7LeY7otUAIgx937tOWEyDsgq6apa4EANk8ybLDh172DmejjWnAObRmTPs
         IUdBaW7bPVman3XPrgJE3po1dk2YXpQroIEOjhc6kOjZLsdlKrJnjEo/7mS7g4h3QTOI
         zUetN91YeLovWJCIHJHML5JZ5nwLc88E3P8KO1TgPk1uDOOxHFYUoNN2V5VhNPXx35ju
         z81nF9abVqa0QThu8NP/k2sHXrCvpl8QRxXgOwtTdWBCWwTXa4iXdk9Vud0/mDEbDRIq
         0zFcublqrK6sz0NZhKSoIslzIRilNVTlkbdvCkJQ+RsxBc/zJJLmDgbHub31BKBv1eyT
         5RHA==
X-Forwarded-Encrypted: i=1; AHgh+RpS387BH8p8wM/g0onmNOziXVAo7N7sVGJ3Lna4o06Q2bMUnF7SgMgocVZ+C42myti+saSRQVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfpil5oINdKuPWLpNYVWyUmToUAaFy7xXjrVRwU2cXz/RpkFv0
	TiBiQ528J0iD37WSg38IDzFZ+p7+M2iI1qCxsKzS6KebaYgrZrdgBpSC
X-Gm-Gg: AfdE7cnVSCBhiMWyY2PRjRgKa2oZHr4yHyzi/0rAt5o9C4h5XC3F8/lHQTs3pYBZN+i
	0K1v0SsrCxwqAckKMbtsRaWF4vqsSX/lyASSh9SiE7LoezbXc1GSSuvYViaFDLPSLxRUciK+Mod
	mcRJAlKEsHy4cugRnqlqVgFehNGFs4bbXuiv9uebPFzp/53CCWrCVVm+KOnm3gIA9GS2Fj+fhY1
	Weaf+pYGT3XCBGFNjJY46bmhApYLEcvnRlEQlMTpk9rlI5lwZH829JYdtYGeQJR3fBGBvMPg4BX
	ZMUdldnEZHBUIvCMJ8FD0Hzmqbm88v7eWb5Fhl3U+my2sajeReYJqnZtedpISBoveDQ52lynx+2
	Js0yh5LBF3lPGzewDrWJytDGgNW6SSmIJsT5Q2yAM+UwYX6SFpDxUHR4R1NTP2JdsZ1dnNjjWVF
	lPk8cV9LVP7E6a16CrbRhtwesyTcLnMNCZixAKLKPIIlZWXbqNlLdWDvIy2abod9u4zmram31b
X-Received: by 2002:a05:622a:1e07:b0:51c:4f35:81b8 with SMTP id d75a77b69052e-51cbf73e524mr120889981cf.7.1784021949680;
        Tue, 14 Jul 2026 02:39:09 -0700 (PDT)
Received: from localhost.localdomain ([202.8.105.115])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caacf2a75sm111460511cf.13.2026.07.14.02.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:39:09 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Matt Mullins <mmullins@mmlx.us>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v5 1/2] bpf: Reject negative const offsets for buffer pointers
Date: Tue, 14 Jul 2026 02:38:45 -0700
Message-ID: <20260714093846.18159-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-274190-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:ast@kernel.org,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:emil@etsalapatis.com,m:jolsa@kernel.org,m:john.fastabend@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:shuah@kernel.org,m:song@kernel.org,m:yonghong.song@linux.dev,m:shung-hsi.yu@suse.com,m:mmullins@mmlx.us,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:sun.jian.kdev@gmail.com,m:stable@vger.kernel.org,m:johnfastabend@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,etsalapatis.com,linux.dev,suse.com,mmlx.us,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EFD8752F39

The verifier rejects variable offsets for PTR_TO_TP_BUFFER and PTR_TO_BUF
accesses, but it currently accepts a constant negative offset produced by
pointer arithmetic.

Commit 022ac0750883 ("bpf: use reg->var_off instead of reg->off for
pointers") moved constant pointer offsets from reg->off to reg->var_off.
However, __check_buffer_access() continued to check only the instruction
offset. An access with reg->var_off equal to -8 and an instruction offset
of zero therefore passes verification.

For writable raw tracepoints, the access end is also calculated from the
unsigned reg->var_off.value. An eight-byte access starting at -8 wraps
the calculated end to zero, allowing the program to load and attach
without increasing max_tp_access.

After ensuring that reg->var_off is constant, calculate the effective
access start using signed arithmetic and reject it when it is negative.
Use the validated start to calculate the access end for both
PTR_TO_TP_BUFFER and PTR_TO_BUF.

Fixes: 022ac0750883 ("bpf: use reg->var_off instead of reg->off for pointers")
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org # 5.2.0
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/verifier.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6515d4d3c003..9f1333676365 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5326,14 +5326,11 @@ static int check_max_stack_depth(struct bpf_verifier_env *env)
 static int __check_buffer_access(struct bpf_verifier_env *env,
 				 const char *buf_info,
 				 const struct bpf_reg_state *reg,
-				 argno_t argno, int off, int size)
+				 argno_t argno, int off, int size,
+				 u32 *access_end)
 {
-	if (off < 0) {
-		verbose(env,
-			"%s invalid %s buffer access: off=%d, size=%d\n",
-			reg_arg_name(env, argno), buf_info, off, size);
-		return -EACCES;
-	}
+	s64 start;
+
 	if (!tnum_is_const(reg->var_off)) {
 		char tn_buf[48];
 
@@ -5344,6 +5341,15 @@ static int __check_buffer_access(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
+	start = (s64)reg->var_off.value + off;
+	if (start < 0) {
+		verbose(env,
+			"%s invalid negative %s buffer offset: off=%d, var_off=%lld\n",
+			reg_arg_name(env, argno), buf_info, off, (s64)reg->var_off.value);
+		return -EACCES;
+	}
+
+	*access_end = start + size;
 	return 0;
 }
 
@@ -5351,14 +5357,14 @@ static int check_tp_buffer_access(struct bpf_verifier_env *env,
 				  const struct bpf_reg_state *reg,
 				  argno_t argno, int off, int size)
 {
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size);
+	err = __check_buffer_access(env, "tracepoint", reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	env->prog->aux->max_tp_access = max(reg->var_off.value + off + size,
-					    env->prog->aux->max_tp_access);
+	env->prog->aux->max_tp_access = max(access_end, env->prog->aux->max_tp_access);
 
 	return 0;
 }
@@ -5370,13 +5376,14 @@ static int check_buffer_access(struct bpf_verifier_env *env,
 			       u32 *max_access)
 {
 	const char *buf_info = type_is_rdonly_mem(reg->type) ? "rdonly" : "rdwr";
+	u32 access_end;
 	int err;
 
-	err = __check_buffer_access(env, buf_info, reg, argno, off, size);
+	err = __check_buffer_access(env, buf_info, reg, argno, off, size, &access_end);
 	if (err)
 		return err;
 
-	*max_access = max(reg->var_off.value + off + size, *max_access);
+	*max_access = max(access_end, *max_access);
 
 	return 0;
 }
-- 
2.43.0


