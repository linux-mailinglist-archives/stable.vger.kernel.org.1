Return-Path: <stable+bounces-233196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HGHLJnez2mn1QYAu9opvQ
	(envelope-from <stable+bounces-233196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:36:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EFD395D5B
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3EDC300BBAC
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CDB3CA485;
	Fri,  3 Apr 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7HXmV6T"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F13C5DB5
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230613; cv=none; b=mcnfJaa117oQ7n4cTaP49w4zl7pdTG2/1+pD7uis6TCTya83/3rsH1qxMWNbdwI8QwwPa1ouY65o57S2qpMDidXzmz+h1mGud/puhXkIIZZtT9m7prv15k9ARg9oX28kM9OEmyAYka/fTKdlvZYpzV8aDRBF3EHvBemECRhhwT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230613; c=relaxed/simple;
	bh=HBkYBrEkca8GEvY83Ie5b9xzor16l9/Xg/yi0HDqDFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMRZlcHm3hEdP//tK1ON6YWC5QaCbaGUY8AcKvQINVkLHlEz2AgrIi0x/Bod2FvxX4Y2ePkwczoFUNt3wxl0UiaOBB0Bxqek3KxiFSRC9vwmE7Cu7KH9z74xbKBbYmVX6s8yxBZfkjP7LwMSeMrgIdvRsuCQdjZAMRjoxLwOiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7HXmV6T; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso19742895e9.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775230610; x=1775835410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QroCHI5HdgwOj8FAryNMjzhzU2nvOMvbjZKJepTUlow=;
        b=T7HXmV6TmCavRI5ef0RuR9/8Qdzb3htBSQ7nWi4I2fZsQQp/XrW841MG0WsAUyV/cK
         NMSKm1YTVSYukuCu3QL3M6D1q63E5sv6zbkKXYXDyudaxr1jBOWImTURjImTfviVl8ET
         7QHMibPSl9AlCYX/8mPLd4DDcALYhMBieE8TiaKbCFdx288QcmqV4FcUQz4UvPmAb3uy
         e9+SInRttr0irGQpYnpUPJYoJhdnNyZqbQdcLCMQGOT4PTMypFwMIQI0KhNOaDHDlzyv
         Y8orKfbXnR0EKLTvnP8volFFRPyT2+eJleEYylUiPgTjVxZd9LyNHVDRI3ojb5KLg+tz
         dtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775230610; x=1775835410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QroCHI5HdgwOj8FAryNMjzhzU2nvOMvbjZKJepTUlow=;
        b=USW3GwclZBiiwPqMIhvfZM5tsM5iAqd9FACItIZHQ+i2TwcOMdGc3f0oXaUCaTNtbD
         6RBql0bpSC1ddRr8kvjU29dpjAiCHbia7fojfzW6QSasfQ6u/N+EfO/trYJtyaWWijOH
         iwKuF6YI+ZEInF5WGFfqlF3X7boQuG4p01SwRfCtCEvhhblOr6Y6vk8MxBfg0ehiWIRN
         0w9Uja+Wi0/GoW2WY6SG5/+sLFSPA7k/uifaFXfERcUrbRSoV0PyTzJSYdcMSFlg/BOX
         anuVBZGL3DIDRKa7ax7uYV76hkT2OJU92feVligWQD98VChmNFkg3qxggoQL6VUPEKUx
         7b2g==
X-Gm-Message-State: AOJu0YynX444Pq5YBoG9D+cEAcEdQB0Jo41c8qiLV2fRAQNDy7ApT+Ar
	Lp0g+borlLwYkSTwzQgSF3c2QIcamafmmX+tXUuZ9KWAPiH4JteOagxoUHd+UXGS
X-Gm-Gg: ATEYQzw8q/nCiYubSXofzAJ5AMDrabpYTXAwqFtZfDsl3dzLZVYD+cJaRn4ms918uHn
	zdHIndMqnX5Eog+3mpwFVOwoMUlDvUHUpqN22YLzmtV2uitWve0RhP/38uQASd6/alI7Q0tGmej
	x42ZKwJzFFdrYb3VkvC3/k+NxVesPar+ZmKK4XndiiwdGdZIWDieKZwdWiYnLoo8Wl9AUIZBxhO
	uywhPEeW8YkH0kKMlRaIMuHtHNNxtpFjeKBImgfRh6AgTIlARRW78xxSzn8XKfqfgWwtS7Fvlil
	zTznmaLUJqew8+W18d+ry+knR6U70gKNTNOsfmjcZkTfH5znNZg4zMotOHixFQdCqhtu1POnt5Q
	IIOk4kebIwBnHiomueqQlw4fP1BWH0TEki79TwEBN9G7KYqiLNaRV88fjjV8w4EtD9J3shmfcaC
	jr1VeGqUb3qLwL3hbVXRsLJMvD1OjYuqsA0qwj3CUdl1DfMmmqVi+1I8rYdVt4V7a7AgY0d26ba
	xdDGz95UhkqujwNZ4Y22vJdbvPSkeWiHDdT46i3q+Xr29HgiTRMyJMXhlRvbQfQAvnKaYbpXXGV
	Wgk17KQljyfu4uPnWVHK1uenIMfcGAKWNep07mKdNOQ=
X-Received: by 2002:a05:600c:45cf:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-4889945f8c3mr51729055e9.3.1775230610109;
        Fri, 03 Apr 2026 08:36:50 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c96ae484ac75459c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c96a:e484:ac75:459c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1c148sm35473175e9.5.2026.04.03.08.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:36:49 -0700 (PDT)
Date: Fri, 3 Apr 2026 17:36:48 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH stable 6.6 2/6] selftests/bpf: Test cross-sign 64bits range
 refinement
Message-ID: <bbf0c6cf0ed051619927d76a5344736e664c9929.1775206731.git.paul.chaignon@gmail.com>
References: <cover.1775206731.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775206731.git.paul.chaignon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-233196-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 41EFD395D5B
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


