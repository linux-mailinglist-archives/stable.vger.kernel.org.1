Return-Path: <stable+bounces-267371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 80DCNuMhNWq3nQYAu9opvQ
	(envelope-from <stable+bounces-267371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 13:02:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7FE6A559C
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 13:02:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j0ClgphB;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267371-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267371-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD843301F9C3
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE40346E51;
	Fri, 19 Jun 2026 11:02:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F429ACF6
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 11:02:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781866976; cv=none; b=Lumxx+TS7eFjfvHhR7zDrPWD8Aief/+hRM35ZG9zFvtFqhxA/4nSrC82gV62a7/nwfSFlfoMVe15Qv2wBcKl1WHiYWyyLkN00NILMkpnbN3jxOcpIgFtAbtDJLfNKXYx/1oCTps7NYmUKHTkR9bauzmpAx79xGLFuWuz8Y2yP7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781866976; c=relaxed/simple;
	bh=kwvcxH6Tz0OHpnFnkAP8wPmaS1edxlyxpgx911v3jnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qVPd2MwC2ubsbNwT7l+5M/WFOWjTsS//hgZjHFMbl1CMQvg0feATzUwzSKtSuBepg/KYZhylQDlK7SzJu66RAVrQ/oC6nTG7UyEtzqOW7MA8mpw1m+PFgD2ZU+Qk7TyIXU+FovzxyO/jmnlKT6jKmYs1H6Urdle53zpiwFVv7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0ClgphB; arc=none smtp.client-ip=209.85.128.45
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b9318997so13722085e9.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781866974; x=1782471774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=svkOZpQQq9NW7asD1cGAFjuew46RJC3YF/ZCnRaZE6g=;
        b=j0ClgphBajaDaxjxhwzLyI8GMDDSsmtl6Go/FwDZd1LvzYPyFe1R8j2IdOzF8xL7CC
         v7w4BPtmH4NPdQV4Ux7+Z7+jb41ntAxGw5FWl3Vbib0srf1ph2LEjPPiFxGZ77nfq3GE
         OQIvxuJJcJ6JzQAXsAEPfiftsNgkX5C+zVevjoVtHFXu98sRihFxC7su9Dm/EBZaA4Gu
         J5MteYw602CdBtzTSdrTNCnckzgsBKZ2kAm52eD04HSBo3v6ndHnITR/iKsUrQHoJo/I
         fuXDt/c++cDZoJF8jHMRlxAgOuSsOz2GgQ7q8H/FXCG3SsIIWnsNSvbFY5bt1EpkfEQ9
         KvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781866974; x=1782471774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svkOZpQQq9NW7asD1cGAFjuew46RJC3YF/ZCnRaZE6g=;
        b=k4r6lxFHhzmReQnfzG7JnDXQ9Cavh9tw6qz24nmWJg0Rvv0ravxdSf7L1PHEoRGVsC
         Gm9LJrRQRquAIeN90MaCkZAvMXwSrt0ZzC4FiRUE1FdjCMWjlTwQ2B34ESN51iX6xg4j
         tAw9oDpGny7P96Benl1o7jvdHS7EW7T94JtzngMgWSimPKqJs01TDPmI+i01sZGv7kKh
         gIIhdqdQ1wbg9Lf+V9lTrP7d6PWIHUhRix4yBZ0QjO1UOea/sHjCMWsRU0HKWnMmVSa1
         vDzXBVKUuD0XRBTefFzh52SISjCJVTgaUwcEcjDJkXh7pKrwRaz8Bc0PkGTZfujpxMHR
         Gj7w==
X-Forwarded-Encrypted: i=1; AFNElJ94nUc+bgT+ju37VJqlEkdwkYFyECyqqOjZAf+mDmKGovgJVTQv9dkdESyDM4JKzK16/ATA4DA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM73ibrz00BW84ErYbInFxVG4u62SMd1qZq3ZHNMD68vHDFdCP
	zVn9q8LNT4du8LKo5jaJL4itkt1+QqmU+g/qWljXRFXRVllSOjiJswwSfuH4
X-Gm-Gg: AfdE7cn33INjlXZr59Ee0PN73WZX0lMUOeKlTsIvceFLl7xgHWqauVZhQYEt9TDwM0B
	+j3SNAS9bOTWcq0k414CpRLrPtnp6xAUgnrRwYickhGTogdTVHIqSq1jQmH1OJPWGVn2eqm8+3b
	x2oOOaLInQLebIYCA8EK8tZZlhPv916fa6xs2ZzY7bLx4No4B7F5HxMsc963sMRX9JY/CDisf3y
	wqtGEah0X30VQ/HeJTpo5HM1gJ5REvsDpUGs8zZlU9D4y2EYhSAPbTmjeZ0dlbWrWtv38tjD/xk
	nD/XHtf1r0PRIqdZD5vpVFF7jS8sEEO6nmT+Dt8zxlW3EEQLPfvcS2NFMNcABGy44tm5hEEQ0QD
	a+P6z/MmzXf9mOa9yWRDFaxuzh4WMILqh3RwIYmTaVOffgkL8pydpXFFuJE9lNJ82/YVw
X-Received: by 2002:a05:600c:6050:b0:492:2e48:81e6 with SMTP id 5b1f17b1804b1-4923ef4ce21mr39156735e9.4.1781866973321;
        Fri, 19 Jun 2026 04:02:53 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650c115fe4sm7278073f8f.36.2026.06.19.04.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 04:02:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: xukuohai@huawei.com,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH bpf v2] bpf: Reset register bounds before narrowing retval range in check_mem_access()
Date: Fri, 19 Jun 2026 11:02:51 +0000
Message-ID: <20260619110251.2576334-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267371-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,kernel.org,vger.kernel.org,talencesecurity.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:xukuohai@huawei.com,m:eddyz87@gmail.com,m:jolsa@kernel.org,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,talencesecurity.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E7FE6A559C

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
Changes in v2:
  - Use [PATCH bpf] subject prefix per Jiri Olsa review
  - Rebased on bpf/master
  - No code change from v1

 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281..6de9af4115dd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6196,6 +6196,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 			 */
 			if (info.reg_type == SCALAR_VALUE) {
 				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
+					mark_reg_unknown(env, regs, value_regno);
 					err = __mark_reg_s32_range(env, regs, value_regno,
 								   range.minval, range.maxval);
 					if (err)
-- 
2.47.3


