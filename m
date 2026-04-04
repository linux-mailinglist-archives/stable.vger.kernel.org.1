Return-Path: <stable+bounces-233270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBzYILHI0GkMAAcAu9opvQ
	(envelope-from <stable+bounces-233270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:15:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DD739A5D6
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52F5330137BF
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C1A3A4F3F;
	Sat,  4 Apr 2026 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gwdh5yuT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E11328690
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290308; cv=none; b=cKTs8v49ZTOctKWB0Pv8b6ARImzHj7VouWOcKYOq4JOUUwuJvHYcGnIKaT4oYfFl3/MgyJaNJrra39xj8UzqbVBDZeTBNja31RQYnpM3HRJ5KsMFYF+BXzfLkJxJZuGso4Zpffw/RQBgB21hpEVaQg8rkN8Yy8LW4ngwnL8YY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290308; c=relaxed/simple;
	bh=HBkYBrEkca8GEvY83Ie5b9xzor16l9/Xg/yi0HDqDFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+xv16QSyFZ5v87QO7Pl+3NOZSdB7kjMYNMfAO2LL+7MnE9nZnNi+W1Ve85ImqdNUBO/a5LD2myTcs4EQKMnanE1qQtwoC34ZUmoclXC7N+CBNkCmaKfPaejwJpt9maPpWXv4zD+v/ZpxhPWKauu+Rp0OV76yjyQbN9YTZ1Rrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gwdh5yuT; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf906b007so1368545f8f.0
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775290305; x=1775895105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QroCHI5HdgwOj8FAryNMjzhzU2nvOMvbjZKJepTUlow=;
        b=Gwdh5yuTxXr8OlhllmDZveO6xsSiuD89gVf2/e3Z2HhEt8n/fX4fqukyi7I+5nBO7R
         W+vPl+KeXl2O6aNP4obZSfL2AeBjR7DpvZet38l37QvxhsIw6deShvxYyNufOuCl8/x1
         8bhrSWp8i4mqD576X/IJkNdUOlMZ0oALUlbck2EGCiQqGrESLz9TtoljCI36rTOKKWek
         Wk0STwML+zRL4j33+qZE/8Q7MSgMp0j7dhoUsPMAUFxZyQevalIQcHjunDHmHRKI9kDK
         FmugAws53YJvpc6U6m2kQQOfB1eBOzjqveS//p+a4be3ZAjFyt8MTJ49biu+NKUcPgOu
         8ppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290305; x=1775895105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QroCHI5HdgwOj8FAryNMjzhzU2nvOMvbjZKJepTUlow=;
        b=QdLimlk5e4lYxL2UaHAs3o4/uIcTVFJC9Se/qCcClz8mr1esdzuvmoRazCThwYfoJj
         4MMbwN83+/hIpEtnNDWJ1x9B2hqUh45PXi+7MDs52HdWIrfzQ5VKflpTAVZf2Qs+3SYg
         9uO8h+VfSVzuwsA+4qczlJKXDTYlC61Ay7ZhGsGt3EQ5yV9hEhOCG0MXf88Pyrx51Vvj
         PN80Kc3SWHzsB7CYtq9iiUoJz+WKASbw7ipHKXBOYvhjqSUAKbxUoe+SDGmhtse6iTu2
         BIIcODpMK7zbjAZtYY8mbsVR9Dwzq6mh6HoVYS1s2Ce8w7AOb9En7q+LT6W91PRQzSLz
         jIaw==
X-Gm-Message-State: AOJu0Yx5euiymPahxkDSjz+TurDAoS4F2D+wqj4tDasDctMu7HtTF9f+
	p3HHAs80s91uhDhS2zC90EpGWcqey9p/7rtxnacPiHk9WPfMZ/2Bo7XXyGJk4nAh
X-Gm-Gg: AeBDievWMGADxVz7HIx/VBBFwgNDsAcAXItCRENYMpCM6BJSEB37UjruelH1lybG4kL
	l6NC6tNFN2mmB81q+6cWZocsjCDEJj2AYoX0U/oNYgwIlaG4zCRgxVPGPpB+5SCcdLENEU62TlW
	RndBaZai/ytqmfhBIc+ywmzLSFcATmdsNF0K7R64TTmjpptPOsw91aaj/HgzdcXEUnGYFWjvxU2
	BnP60kEr/Xw3W4sAA5jaMK0Cdk6JTCZuZwSnVlLw1KGGL+Z5u3yR4Em5KKOUNRfSj4kzLnZ5Zra
	TnhFZB/H6PiZO30httNc5bfB3gtREh1+hLfOdvbnB891yPmz1cPw4lUjasrFs5uweHeJ5AYczkd
	GyQzd6O1GtSfrOzJyFSw3e5MscykBnXHiynObBCwm6Q2eissYkA2gqY7Ub16iw2eNZAtRXusobV
	+aEFRI37lIpL4/x9GbrF6LOW4VzTnKvXVR8NQQlMHlVs+Lt3YWvvga7+ujC2DQ8UrxwOaT/gmSF
	M46lcAuEoAF1kvzrp8KnGUvCMqluqD2fgS63tTwpzs7TB9wxerRDWsgX7G28LHPXzzvTYBhyFoc
	snIj7YhAxH4fNJKrRTu2altzQ72RHXAk+tOZYODCajc=
X-Received: by 2002:a05:6000:420c:b0:43d:1cec:4767 with SMTP id ffacd0b85a97d-43d292da9fbmr8367294f8f.36.1775290304701;
        Sat, 04 Apr 2026 01:11:44 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00359acd79a267583c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:359a:cd79:a267:583c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a71f7sm24577983f8f.1.2026.04.04.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:11:44 -0700 (PDT)
Date: Sat, 4 Apr 2026 10:11:42 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.12 2/6] selftests/bpf: Test cross-sign 64bits range
 refinement
Message-ID: <bbf0c6cf0ed051619927d76a5344736e664c9929.1775289842.git.paul.chaignon@gmail.com>
References: <cover.1775289842.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775289842.git.paul.chaignon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233270-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 13DD739A5D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 26e5e346a52c796190e63af1c2a80a417fda261a ]

This patch adds coverage for the new cross-sign 64bits range refinement
logic. The three tests cover the cases when the u64 and s64 ranges
overlap (1) in the negative portion of s64, (2) in the positive portion
of s64, and (3) in both portions.

The first test is a simplified version of a BPF program generated by
syzkaller that caused an invariant violation [1]. It looks like
syzkaller could not extract the reproducer itself (and therefore didn't
report it to the mailing list), but I was able to extract it from the
console logs of a crash.

The principle is similar to the invariant violation described in
commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
JSET"): the verifier walks a dead branch, uses the condition to refine
ranges, and ends up with inconsistent ranges. In this case, the dead
branch is when we fallthrough on both jumps. The new refinement logic
improves the bounds such that the second jump is properly detected as
always-taken and the verifier doesn't end up walking a dead branch.

The second and third tests are inspired by the first, but rely on
condition jumps to prepare the bounds instead of ALU instructions. An
R10 write is used to trigger a verifier error when the bounds can't be
refined.

Link: https://syzkaller.appspot.com/bug?extid=c711ce17dd78e5d4fdcf [1]
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Link: https://lore.kernel.org/r/a0e17b00dab8dabcfa6f8384e7e151186efedfdd.1753695655.git.paul.chaignon@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index a0bb7fb40ea5..fe3e2b326c6b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1200,4 +1200,122 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+/* This test covers the bounds deduction on 64bits when the s64 and u64 ranges
+ * overlap on the negative side. At instruction 7, the ranges look as follows:
+ *
+ * 0          umin=0xfffffcf1                 umax=0xff..ff6e  U64_MAX
+ * |                [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]        |
+ * |----------------------------|------------------------------|
+ * |xxxxxxxxxx]                                   [xxxxxxxxxxxx|
+ * 0    smax=0xeffffeee                       smin=-655        -1
+ *
+ * We should therefore deduce the following new bounds:
+ *
+ * 0                             u64=[0xff..ffd71;0xff..ff6e]  U64_MAX
+ * |                                              [xxx]        |
+ * |----------------------------|------------------------------|
+ * |                                              [xxx]        |
+ * 0                                        s64=[-655;-146]    -1
+ *
+ * Without the deduction cross sign boundary, we end up with an invariant
+ * violation error.
+ */
+SEC("socket")
+__description("bounds deduction cross sign boundary, negative overlap")
+__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("7: (1f) r0 -= r6 {{.*}} R0=scalar(smin=-655,smax=smax32=-146,umin=0xfffffffffffffd71,umax=0xffffffffffffff6e,smin32=-783,umin32=0xfffffcf1,umax32=0xffffff6e,var_off=(0xfffffffffffffc00; 0x3ff))")
+__retval(0)
+__naked void bounds_deduct_negative_overlap(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	w3 = w0;			\
+	w6 = (s8)w0;			\
+	r0 = (s8)r0;			\
+	if w6 >= 0xf0000000 goto l0_%=;	\
+	r0 += r6;			\
+	r6 += 400;			\
+	r0 -= r6;			\
+	if r3 < r0 goto l0_%=;		\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test covers the bounds deduction on 64bits when the s64 and u64 ranges
+ * overlap on the positive side. At instruction 3, the ranges look as follows:
+ *
+ * 0 umin=0                      umax=0xffffffffffffff00       U64_MAX
+ * [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]            |
+ * |----------------------------|------------------------------|
+ * |xxxxxxxx]                                         [xxxxxxxx|
+ * 0      smax=127                                smin=-128    -1
+ *
+ * We should therefore deduce the following new bounds:
+ *
+ * 0  u64=[0;127]                                              U64_MAX
+ * [xxxxxxxx]                                                  |
+ * |----------------------------|------------------------------|
+ * [xxxxxxxx]                                                  |
+ * 0  s64=[0;127]                                              -1
+ *
+ * Without the deduction cross sign boundary, the program is rejected due to
+ * the frame pointer write.
+ */
+SEC("socket")
+__description("bounds deduction cross sign boundary, positive overlap")
+__success __log_level(2) __flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("3: (2d) if r0 > r1 {{.*}} R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
+__retval(0)
+__naked void bounds_deduct_positive_overlap(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 = (s8)r0;			\
+	r1 = 0xffffffffffffff00;	\
+	if r0 > r1 goto l0_%=;		\
+	if r0 < 128 goto l0_%=;		\
+	r10 = 0;			\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* This test is the same as above, but the s64 and u64 ranges overlap in two
+ * places. At instruction 3, the ranges look as follows:
+ *
+ * 0 umin=0                           umax=0xffffffffffffff80  U64_MAX
+ * [xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx]        |
+ * |----------------------------|------------------------------|
+ * |xxxxxxxx]                                         [xxxxxxxx|
+ * 0      smax=127                                smin=-128    -1
+ *
+ * 0xffffffffffffff80 = (u64)-128. We therefore can't deduce anything new and
+ * the program should fail due to the frame pointer write.
+ */
+SEC("socket")
+__description("bounds deduction cross sign boundary, two overlaps")
+__failure __flag(BPF_F_TEST_REG_INVARIANTS)
+__msg("3: (2d) if r0 > r1 {{.*}} R0_w=scalar(smin=smin32=-128,smax=smax32=127,umax=0xffffffffffffff80)")
+__msg("frame pointer is read only")
+__naked void bounds_deduct_two_overlaps(void)
+{
+	asm volatile("			\
+	call %[bpf_get_prandom_u32];	\
+	r0 = (s8)r0;			\
+	r1 = 0xffffffffffffff80;	\
+	if r0 > r1 goto l0_%=;		\
+	if r0 < 128 goto l0_%=;		\
+	r10 = 0;			\
+l0_%=:	r0 = 0;				\
+	exit;				\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


