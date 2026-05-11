Return-Path: <stable+bounces-245286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JYjGgcFAmo3nQEAu9opvQ
	(envelope-from <stable+bounces-245286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:34:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC89051240F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB2F31340E4
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE493D6472;
	Mon, 11 May 2026 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeqjQRqU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5633FBEA3
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516698; cv=none; b=X46fK422IcGQPSv2qc6VEO87umbIyGzAjaOxVNYl3Yc1DwaPymtSk2C/ooqsR5WFNPBHUaoLKl2RYwVHdyJhpycMG6yJQK5xYqH1f1cBAaYOTr2z4RDTZZYvhqOECRP/J1KrWyRTWWY5DyNiF5yQ2Pyplpjpj+cyss18Op2kIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516698; c=relaxed/simple;
	bh=cAlq8Knqi2XXEi3cjJd9XnbPmrErCtf006kZs0yqRjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5EytzIKIKwE8Kl1c23I6esj92fCMrHYSM/wcdj7sjp9I7UF1Cp31vHcsedudWIvzGUW9lLfTNEzpNkQgos1VhTpL5DYvv79n2z5N8fqMn+44LhfIDsriuw/QsVfZkUJR/U99Mjg0t6mX+rhf8+Go6hhnTNMxCTMsa02r4BXBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeqjQRqU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48896199cbaso41490945e9.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516695; x=1779121495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d8tD/Y9JUzxe5D8dlEBlgm1pFIW28alZdpH77ZxpDo8=;
        b=aeqjQRqUpoKZtna/iLsfXe4tER8R0QHn3wjAwS+kfrsXfwRst9cG1ICOB8Lvz9/Qxq
         cmS+nZnjNDp+1Jm8xE3CgN+VUyWcCkhR7SMH18byq5xpkKouXpUSNZK5cx1/eyW7zGB+
         JRfjB0A3eAB+1oTAZv/b/MccNlJzcnRprINRcItijSLzPYlTVr0bqj9pYeWSmRRfZHxk
         fndjYw6551fahNHDqrDdJFwldpUEeEb/vYxNW+pY4VrwCh4AWETzjS9a2oZwgw7R2wCd
         +IR5ojL5STj6vM513aOsXhvtNci4WE3Stdc3Nl4PgDf+QmuS3zsaEhcR4n7/FFU/gU8H
         cu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516695; x=1779121495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8tD/Y9JUzxe5D8dlEBlgm1pFIW28alZdpH77ZxpDo8=;
        b=I1iO6kOWS1gF2AU59AKH/rc4M36iERS+ZsfQ39HyDFOuXPJ0ibq7669avin9PmXAKq
         yesfPhKivjszp2FMLzsyIMecfXQu1w2TM42Wdsz0QIwRkK+gAV0jqDUm20EPIP6LKqXQ
         DiiLub4pSLulqSc88XqPORskjGsK6vXcvNnxXqTaBLVY0pokm88/6AcY4sK+UAyF/7uN
         f65RqTwgAvKdFZtg+BzGAQ47/+vBvXToAX+pB3c3JJgKe5rCPlhQSvZgkV8nXKhmyQiQ
         mKfvWp8aPCfsBSzq9onFMyYwOvGU2A87iQO18cYxg8LTEtnK6XxL9sJhgJoLpaoO1xol
         WHbw==
X-Gm-Message-State: AOJu0Yxhg4sGNHm6B3jbV2ftW7M9QEZ72bKlV1z2LcvlXUV6P7osmOio
	q86myKUUAvh+TsbNcgLu9fEWb8Qvk6zHiqwuTh5IWnGMsTb7uKVxmKG9EK0c/0QV
X-Gm-Gg: Acq92OGYSMx2RaW/glFy00THggQgll77It0kCAV+WnddPuWvFGKOH54CTuw7wJDBJ9m
	p+HTnNMwCdgrqaIaXDhtSDRw95gd30p3cQrdn3xdil7XP0g9+TKt7vye8Qb5TJI4bo2l4UtF9pI
	7lHUl0Wr878cPxWajk8kCVQ+iUHYyFkZqoxMhgIFge9u6g14p9E5ZcJqLSrxcfmejHfoZtZzHOy
	vvhXVtgmUVFGPNXwbnckxgpuh5EmCg0lS2SD5jrJTJDCZmPtuBHkTiHJYsK+027XIC6jvmywW9F
	VqQetB9+uCQW2pGSOZBtaZgnvrAxi0ZsBmnr0iVfBPAGyhbBiTDumknq3hF87pwMsMajijHyzhM
	kS5ojgWRcuOqDJBisN+V1KC6Vrqhquv47tMY0grH2gLnSGqatnrYAUQ6FpV+OLV1zn3h/CzNTnl
	32FBbF8C6QZKk5xJH6vJmyS/1LXfWaYJ9noT9q5SAsi1XKZ/g7veMN7c0QenaNuMXKDgnDWvN2s
	5qDOCrFQ9mBnnVswF2M6iKfs4XfJAU9QeBUPCF8gXnnDOwCFQUFt6ftI1tnxe2TT8E3THAsW8iP
	hTWRcD0ejME2jAQnZQvgNiRfORHUmmKbnGDAEqI0e60=
X-Received: by 2002:a5d:5d0b:0:b0:43d:c2bc:21b4 with SMTP id ffacd0b85a97d-4515b525d65mr38683392f8f.16.1778516695088;
        Mon, 11 May 2026 09:24:55 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120ec0asm26276309f8f.17.2026.05.11.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:24:54 -0700 (PDT)
Date: Mon, 11 May 2026 18:24:52 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 08/10] selftests/bpf: validate precision logic in
 partial_stack_load_preserves_zeros
Message-ID: <d0aa16d9a5961165dc7e0dc792bb28c321370c2a.1778516196.git.paul.chaignon@gmail.com>
References: <cover.1778516196.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778516196.git.paul.chaignon@gmail.com>
X-Rspamd-Queue-Id: DC89051240F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245286-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,iogearbox.net:email]
X-Rspamd-Action: no action

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 064e0bea19b356c5d5f48a4549d80a3c03ce898b ]

Enhance partial_stack_load_preserves_zeros subtest with detailed
precision propagation log checks. We know expect fp-16 to be spilled,
initially imprecise, zero const register, which is later marked as
precise even when partial stack slot load is performed, even if it's not
a register fill (!).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231205184248.1502704-10-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_spill_fill.c    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 41fd61299eab..df4920da3472 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -495,6 +495,22 @@ char single_byte_buf[1] SEC(".data.single_byte_buf");
 SEC("raw_tp")
 __log_level(2)
 __success
+/* make sure fp-8 is all STACK_ZERO */
+__msg("2: (7a) *(u64 *)(r10 -8) = 0          ; R10=fp0 fp-8_w=00000000")
+/* but fp-16 is spilled IMPRECISE zero const reg */
+__msg("4: (7b) *(u64 *)(r10 -16) = r0        ; R0_w=0 R10=fp0 fp-16_w=0")
+/* and now check that precision propagation works even for such tricky case */
+__msg("10: (71) r2 = *(u8 *)(r10 -9)         ; R2_w=P0 R10=fp0 fp-16_w=0")
+__msg("11: (0f) r1 += r2")
+__msg("mark_precise: frame0: last_idx 11 first_idx 0 subseq_idx -1")
+__msg("mark_precise: frame0: regs=r2 stack= before 10: (71) r2 = *(u8 *)(r10 -9)")
+__msg("mark_precise: frame0: regs= stack=-16 before 9: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs= stack=-16 before 8: (73) *(u8 *)(r1 +0) = r2")
+__msg("mark_precise: frame0: regs= stack=-16 before 7: (0f) r1 += r2")
+__msg("mark_precise: frame0: regs= stack=-16 before 6: (71) r2 = *(u8 *)(r10 -1)")
+__msg("mark_precise: frame0: regs= stack=-16 before 5: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs= stack=-16 before 4: (7b) *(u64 *)(r10 -16) = r0")
+__msg("mark_precise: frame0: regs=r0 stack= before 3: (b7) r0 = 0")
 __naked void partial_stack_load_preserves_zeros(void)
 {
 	asm volatile (
-- 
2.43.0


