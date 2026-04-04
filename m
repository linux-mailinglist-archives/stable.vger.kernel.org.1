Return-Path: <stable+bounces-233274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPY7D6jI0GkMAAcAu9opvQ
	(envelope-from <stable+bounces-233274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:15:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D7D39A5CF
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1904D3006B7D
	for <lists+stable@lfdr.de>; Sat,  4 Apr 2026 08:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C58933B6C6;
	Sat,  4 Apr 2026 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7dWRpcA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C22C76025
	for <stable@vger.kernel.org>; Sat,  4 Apr 2026 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775290532; cv=none; b=IBuPOy3EBGFgwK29c6ipfga7qisc9ye4gzk1sgbZwAWysk12caAACGOo3PtHgWbPd3JxOdn7nJ+0zBJzwNROUIoh8yu7ZgCCFP24Tq+Cy3ZY3AZk2jCYtAqn7uTBv6bI6SUu/iJaI92hbs9BeVEagmsQSYjrf0lZ8MGFgRGrfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775290532; c=relaxed/simple;
	bh=UGUakupRFwqfRj0Wf1MgzHYZcLxI2TG7a8ChlRShHs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tg0NQnY/E+dyCFTB1vRZYh8am8vaA4yejZBjTuOybO5JF++FU8F+HNp5vI0SaJoT9KKyq4vbN2AFgfz7OSywZKPgOkCg/han41t9DUMmgRRSfdhlJ417uIJSBZ14dr9P4Qoj7rYudSXbN+4hmrERTGfxo+ykVvVgj+hRd6ao4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7dWRpcA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so32173215e9.3
        for <stable@vger.kernel.org>; Sat, 04 Apr 2026 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775290529; x=1775895329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9QtDAtuj+DI+rbavi9AYYmBMM9A4IkRJ4xbnMdUWd8=;
        b=j7dWRpcA0WVaJXutAWLVDF5WNy+JJW05lVpJbB3DDfVztSzMqfy6rGfxnM37r/nhS1
         4yuFDQ+HWXemgJEAIRvjAHy4nIh+4npUDU8C7wqfqXY8rO3nIdh1R1CaIpvFOhSD+bCG
         Ubu5VQ9KfaRiLb3yDiyNQ3+kHA40srhV3NQGR3FSxh5964hyjApVXP/H/s53KOmA+Ski
         7BP61MAPpy705hHtD0lrQ97xRBRsg5VG8oGBnXgJz14CgTiqFiZoQu3aixl0skVB84bf
         z1yFeRfDywAqt+jLgVe4+Gtq6Wn2C+i+SxW+NeC4rbZGpn63Uysfd8/5VcnDKFyh8sO7
         PXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775290529; x=1775895329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9QtDAtuj+DI+rbavi9AYYmBMM9A4IkRJ4xbnMdUWd8=;
        b=ifY5JuQKp41dmQ0J5nfVAtt9AibstwHdquVSO5t6m9kvhTmvdhnrGnoQsWHDjxISc0
         HQeQOCY6cSuOXtelp/HqsMcxAXmfogxyl8uGVp+UdlQ622fJPwYN9/5UQT1rhHDGuAAI
         L/Yl5nBD4ZGPaaSzjdPkQ8PGkCfKvwvXSqz5+tgkrUCEa5q4TIG6jnAfnlmKivxufFmL
         UT2VcCrUzfhE5Z9XT4br6MbmsFV6V2THCPP7yBIji5t9oFNwk86GK9OxdA/Eoxwj0DAD
         GsPcvSpz/D+MKo8XpZ9kkJLmSPvZHGUQUt5bm4M3pMY08AvcyufOT36oa4YWPJwAc4/B
         hu3g==
X-Gm-Message-State: AOJu0YzWyZ3g+SzwyY1w9UIkC5UTVlYNeBhj8Sb8eNe09EeNUJM5P2Ud
	0TlAPmfqzYDA3F0l2sKXnZdyOhZtzucxHOmJjOfmdGvic7uQRufClZjJjdtMpgN6
X-Gm-Gg: AeBDievpZljCUYBhqV4rsjQAiegOmQplktgsXa6/TF1egbMTLOjR20U0NRIWmCLIBs+
	irOBSNXgOT8rBLXrs4burcSHzXEV0B3zc7ttRsNqgw7/jozLHQDOC1KDazSz0e7Iqh6ZoSqywK5
	0FXDK1mnUPrOq40sOylvnqHR6oedQ6Bh5q+NzbAN9kSbuy/23qqCv5orqWyKgyZxA9uF0ikQ4vu
	F87iBq5ytGdkxiYUbKuBC2vQymt+/zgJeqJWtZq1c1Oiixcll4Y67r+hQ6bnImGTDy9eFoOV/on
	rvYH2gzgr7Z1RAKVdXmDDSwqs6lRQ+1Q0OLgf+OvEmW9dB5whmXgPACfvyolBHajU+94GIEjxST
	fnhuLQYe77O0J8yRbmzufYqDDeNrwpCkUAudVZ85DBLBtZNe/n03D/ZxOcgKffQnHH7cmsTOL5r
	AsMNzbK8IfTSgm5dBEUHyljt2txVJ2Xc/JeYlINXAP7aohwtWQufYQsILCRTrCr8pmFwhX0A98v
	eGh2sRSmXv38P0vmSWyWSzOQVniI06jmoEtDODrIQz+UsdZ8b2mfUSvE2gmMJT0ubCEuKNJX8zc
	aQ6bmQPJyckSlUyo4h5RVML3WNZdALUidQuz+gzoJsM=
X-Received: by 2002:a05:600c:310a:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-488997ee02cmr85127125e9.29.1775290528642;
        Sat, 04 Apr 2026 01:15:28 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00359acd79a267583c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:359a:cd79:a267:583c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4889f6843dfsm86019415e9.12.2026.04.04.01.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 01:15:28 -0700 (PDT)
Date: Sat, 4 Apr 2026 10:15:26 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH stable 6.12 6/6] selftests/bpf: test refining u32/s32 bounds
 when ranges cross min/max boundary
Message-ID: <ba33eedcb64f447d5ea0025606c76fd4f00b22bd.1775289842.git.paul.chaignon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,suse.com,kernel.org,etsalapatis.com];
	TAGGED_FROM(0.00)[bounces-233274-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: D3D7D39A5CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit f81fdfd16771e266753146bd83f6dd23515ebee9 ]

Two test cases for signed/unsigned 32-bit bounds refinement
when s32 range crosses the sign boundary:
- s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
  s32 range tail before sign boundary overlaps with u32 range.
- s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
  s32 range head after the sign boundary overlaps with u32 range.

This covers both branches added in the __reg32_deduce_bounds().

Also, crossing_32_bit_signed_boundary_2() no longer triggers invariant
violations.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20260306-bpf-32-bit-range-overflow-v3-2-f7f67e060a6b@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index e6297e9dd2ed..5feb07584084 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1110,7 +1110,7 @@ l0_%=:	r0 = 0;						\
 SEC("xdp")
 __description("bound check with JMP32_JSLT for crossing 32-bit signed boundary")
 __success __retval(0)
-__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
+__flag(BPF_F_TEST_REG_INVARIANTS)
 __naked void crossing_32_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
@@ -1318,4 +1318,41 @@ l0_%=:	r0 = 0;				\
 	: __clobber_all);
 }
 
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case1(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 < 0x3 goto 1f;		/* on fall-through u32 range [3..U32_MAX]  */	\
+	if w0 s> 0x1 goto 1f;		/* on fall-through s32 range [S32_MIN..1]  */	\
+	if w0 s< 0x0 goto 1f;		/* range can be narrowed to  [S32_MIN..-1] */	\
+	r10 = 0;			/* thus predicting the jump. */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case2(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 > 0x80000003 goto 1f;	/* on fall-through u32 range [0..S32_MIN+3] */	\
+	if w0 s< -3 goto 1f;		/* on fall-through s32 range [-3..S32_MAX] */	\
+	if w0 s> 5 goto 1f;		/* on fall-through s32 range [-3..5] */		\
+	if w0 <= 5 goto 1f;		/* range can be narrowed to  [0..5] */		\
+	r10 = 0;			/* thus predicting the jump */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


