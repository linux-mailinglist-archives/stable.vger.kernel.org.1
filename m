Return-Path: <stable+bounces-245284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDEgIeMEAmpEnQEAu9opvQ
	(envelope-from <stable+bounces-245284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:33:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 022915123D2
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA743146E77
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8E242EED1;
	Mon, 11 May 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogDZOJYg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99B425CEA
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516672; cv=none; b=NNcPp9vVqvUANv06W45RrXO6T4nhSHvFPXuFlbDyUyG7IxkNkOJeW6vAEWmqK3cWZ2o/eFdFShlrgqzGCl2hqcXWZbi+INVBb2RoYw+Fz8ThtmdsL35K16z56FffT/R2f8IzVPnf2O+QL5cPB5dokttTaOBHPiaUoimmOn6pi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516672; c=relaxed/simple;
	bh=5+2sZfwL7dtWHX/IuXu2y2GpEGBjdz6F9TxH9T1rN64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq1J28ijyKfSH9MDZ9y9V5eK5eyJ2i75aBPUjJdUnJbvrI4KwtGYHwd1hJSWYZO1W/hUzvqfRqhzZYhFsjZjp8P/DEe70Em2g+NKf9pzMiRu+yVgacOaNLBpHEImQD42IJMdFQ1y9V2YBpHqQm07M6czKRs6NOdnsZ33d69Uv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogDZOJYg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so41147115e9.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516670; x=1779121470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/E9I88rDm0zBoMC7qxJTVZvb1m6xPKNfE+anogGAcb4=;
        b=ogDZOJYgARIrE9pkAeBhq0hJTZmD2jMDhbE7veC9ACdqxYLqlaovDGX3YvzZ5fnITZ
         ZFRrDby+Hcv4dyaMLma7k//9LCcx8Xi7KT2UyLwgm5lwy1UbhGCsHuWKAK51jilzaRym
         DFWxQFNPKt6GIGRmQYW/LBFSu8EskWA44rcIwe//grE49Mu7lHQstTPXMmmmXB/MGmde
         +WWJE8maxts9j3vgcmkpdI2RKvWBHMUGaOnq0GpU5uC+HnZsCc3N+t5gjW+KPXafiVZ7
         Sr1ac1N76SRWCpnPR9Unuxb2sXfjESVLuK3IiG+nttCqX7gPNxhJSzIJfJiew9oMyPMp
         0KeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516670; x=1779121470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E9I88rDm0zBoMC7qxJTVZvb1m6xPKNfE+anogGAcb4=;
        b=q/dP+n9FFvnNi7zjER7FtA/RSlix3q+dR598uj1ancQdHY0Hm78sNZLMBk5tBDVGiM
         lRat1EtOTef82SD7P2PKLFsxYz3tMr7rWfUxKDrjAe2YTFLqdGvM9gRoo7uDurkksQgT
         3tomHN2U/iGHD7WB9f7BBgE7hfUD6dFZ1MI5jsI6r/V6g/WCfP3oCySjLoXZwTzFY3yD
         I3mQ7glNwn/3z1FaJIiQ32KUwrnoNVUrUZvsYCpoQ+385kWWGzy82SP8oKMW7edDYrYH
         ZqPNH+4mCdSN0RRGLZ0OtxPD2TEYEV0kDiUPGpLSSX8GNXAN8Cp8Rh6XSEZ9BoFVYapB
         20dA==
X-Gm-Message-State: AOJu0YwEgV5PdyGAppS9//BGU5cjb4AGXWrGbIDHDGpDSMpzL/3zpxgQ
	Z3fOgaeRlaJCtCh1x+RPuoVSMrIuteHQmfyGE8TB7waP9+NdMpgWG6LOGKssfT6O
X-Gm-Gg: Acq92OHwpPXV3afmEp+FgvbPaA7idrJmeUcOmRRB9BcYckGFpia6V0lRlO2sQEZnRPB
	JgcdnKQQAAM1Pemk3W201aFcHqhFHjRaxRg2+Wqgl5E0OvVOrLZqAUuBerYOsYGRiHVFciG/Z7B
	1WBtuI8QtdaEjfkXiDJkO0I4QvAMyh4ERdJyUmemd9PCp1BwT2iU1onk7RJujrvTIPqo4327aSZ
	1ZXGsu0fxypEY8oNtwizt8XCX6tALtszaWsNQWOEtebJCjZicc3S1mFUznwFEdQyRqXKGPhf+uH
	A1Z8qPxm2PpLbozT8HdJDsge8hJGMNVWggZXqnh/gLYAThT7sENHndNQIE5BjgBS2kGUjfvOnsB
	bRL1ZmDb0muU3p8pXHnz5VI1vjbdSIlPfLP6EyBpUAnk3lOzWno3dG+iEDDbpC7PswNPvVNKSHL
	qN5H88+J58MXimV2QyM5RATymvKmw/5ISpKNG2La5zCukjduodL65Udxq3pz3lhgxQNK0YDwnC1
	Q/ibXUB6yxOyxWtI2p1FwgFPVzsnbAMv//LFX7Z+xDnaK8G/7MmoVRWv6Zwjuda/17VqWHK21zA
	bpkTDcVyyfD66tvLCiNbVk4TLT6m+RFxlAmQDM9jwICPWhasUivxcw==
X-Received: by 2002:a05:600c:4194:b0:48a:7965:b92a with SMTP id 5b1f17b1804b1-48e51f53980mr264108345e9.26.1778516669584;
        Mon, 11 May 2026 09:24:29 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548bb51d40sm25674402f8f.0.2026.05.11.09.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:24:28 -0700 (PDT)
Date: Mon, 11 May 2026 18:24:27 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 06/10] selftests/bpf: validate zero preservation for
 sub-slot loads
Message-ID: <4710f663dbf65ada32c05bcdccea46f2024bf0d9.1778516196.git.paul.chaignon@gmail.com>
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
X-Rspamd-Queue-Id: 022915123D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245284-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,iogearbox.net:email]
X-Rspamd-Action: no action

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit add1cd7f22e61756987865ada9fe95cd86569025 ]

Validate that 1-, 2-, and 4-byte loads from stack slots not aligned on
8-byte boundary still preserve zero, when loading from all-STACK_ZERO
sub-slots, or when stack sub-slots are covered by spilled register with
known constant zero value.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231205184248.1502704-8-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/progs/verifier_spill_fill.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index d9dabae81176..41fd61299eab 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -490,4 +490,75 @@ __naked void spill_subregs_preserve_stack_zero(void)
 	: __clobber_all);
 }
 
+char single_byte_buf[1] SEC(".data.single_byte_buf");
+
+SEC("raw_tp")
+__log_level(2)
+__success
+__naked void partial_stack_load_preserves_zeros(void)
+{
+	asm volatile (
+		/* fp-8 is all STACK_ZERO */
+		".8byte %[fp8_st_zero];" /* LLVM-18+: *(u64 *)(r10 -8) = 0; */
+
+		/* fp-16 is const zero register */
+		"r0 = 0;"
+		"*(u64 *)(r10 -16) = r0;"
+
+		/* load single U8 from non-aligned STACK_ZERO slot */
+		"r1 = %[single_byte_buf];"
+		"r2 = *(u8 *)(r10 -1);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		/* load single U8 from non-aligned ZERO REG slot */
+		"r1 = %[single_byte_buf];"
+		"r2 = *(u8 *)(r10 -9);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		/* load single U16 from non-aligned STACK_ZERO slot */
+		"r1 = %[single_byte_buf];"
+		"r2 = *(u16 *)(r10 -2);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		/* load single U16 from non-aligned ZERO REG slot */
+		"r1 = %[single_byte_buf];"
+		"r2 = *(u16 *)(r10 -10);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		/* load single U32 from non-aligned STACK_ZERO slot */
+		"r1 = %[single_byte_buf];"
+		"r2 = *(u32 *)(r10 -4);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		/* load single U32 from non-aligned ZERO REG slot */
+		"r1 = %[single_byte_buf];"
+		"r2 = *(u32 *)(r10 -12);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		/* for completeness, load U64 from STACK_ZERO slot */
+		"r1 = %[single_byte_buf];"
+		"r2 = *(u64 *)(r10 -8);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		/* for completeness, load U64 from ZERO REG slot */
+		"r1 = %[single_byte_buf];"
+		"r2 = *(u64 *)(r10 -16);"
+		"r1 += r2;"
+		"*(u8 *)(r1 + 0) = r2;" /* this should be fine */
+
+		"r0 = 0;"
+		"exit;"
+	:
+	: __imm_ptr(single_byte_buf),
+	  __imm_insn(fp8_st_zero, BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0))
+	: __clobber_common);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


