Return-Path: <stable+bounces-245283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AAgKF8KAmqknQEAu9opvQ
	(envelope-from <stable+bounces-245283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:57:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 268AC512C8E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 18:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A739731D15A8
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0BB3A4F23;
	Mon, 11 May 2026 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ynjo4Z8w"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013ED427A16
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516658; cv=none; b=lYLIAJs2q5WcA4+ni7pr2h7S+G2m6xG9Xes3IxT27RlfqQskl6KaLC++UbA+LLdm/uqzXl74gKJaIXbpdgvwjNIwhL0eu11EMJIPWWmPsMsMrK8/PJx3iCe3fHdlJIuk5RmfOpDnTNFvusulnI5gMsopaym4sCeqCIXEanDqTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516658; c=relaxed/simple;
	bh=kY1fyhLVuXPDHqK6I2Cp63vYnARfeisj7cQj5lN+148=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfqFUudnXJ90oxHWunZ2Wq8yziaCQFYCysbOolitgkyu7U9DfHMFZVj17rJ+v/BxgDe4Qt9FgUtFiGGegp0SjMp6c51F9zTKCxUKFcXpkFCv0mytAbGIwFdAjCY5y23OEaY3ieBHZ6Xu/Ph6DXr42d7hZGfRRnDnZS1Xu8e8Jxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ynjo4Z8w; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso27512575e9.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516655; x=1779121455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eCCkAQNWqQWXeHnKUGetC76Y6V4zwTgzDObriUATYXw=;
        b=Ynjo4Z8wTABgRgNuPZQhyyUyV5i4+E7TtrlO7Pt+dXA3pORfJVLfVYZtvdsF8K6Dhn
         7DrGapADSgqtPu+Wc/0yk++7lcHTIPlo0i4k/ARyfpRIkR29VCBfrLtbI0FuYOKFy9n7
         DQ4Lb8U/RaqFKaXznR60cnxGVsw35E07t1GcOUt8AL+aFpIT3P7Uxmc15/qDodhihYjn
         zGHJ310CvPSexyzYYGV4+rRGmGL5lrpujRJL2as9BSBxxHPFhksQpqChNIunHP4JVfDB
         itX/k2qboyRicWlVhardRPJISPcjHuwa8h2cUhF5TCMuluPh+b11827cHClqIcBN8Re2
         VyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516655; x=1779121455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCCkAQNWqQWXeHnKUGetC76Y6V4zwTgzDObriUATYXw=;
        b=Oh2AGiqRCi+j5dA9jEoS8LXOBiARKavIcf9J2bBV/N6FGFO3nK3VeiiFZs1rwel3oW
         94tsZjfyDnOAPG6u6fNJ9Js5vfMWbSrI1vtV8H8I+hwr6SveE3+DInUYRxHdF4WqKZa0
         eVcMurVpyBRcJJeuN4PCj6qyfVqw5L5z+fKsIoPdjCld8ZmGkIPSvwMEWUZWbI2cgtnO
         7WppCKRzUbpPi+Bkq76mFlnj0LDjQ9efpV7vu2tbA7qAhQsxkNBwBIfUdVmP4ZWJggEO
         F/WRXeA19amgR6wLTQeNpYJ6eIT6Su308bBpoURB1QuRturbFx+Jj14leVGCCRxchssD
         aSdg==
X-Gm-Message-State: AOJu0Yy+gTSg4TfPt0iNdUE9i5GgVh013MbhRkvMA27PxaKQl9TstQKt
	RHrZgI+Ds/1ctjSIlfAE8V3h12p2AHLFaXdkdntKz0vR9x5qemgZyU2fwbSn/99K
X-Gm-Gg: Acq92OFMOkHC3IgngxOOXUAXZ6TN7pBpoe42S/9KeypQcuYFMHoO+NMGQn24JYx6QBt
	HIuoHEkgaX1MKMtNEadmIbr2CTL5rBPpcYVaCGF/o2mf/NShG+3yImWiEFo9CSFRfTLOmr37AXC
	PGwtYxvFpub0Pcr2JmtAbsvhkJIuqoHj7B3yose2g42dlXPkzBz1fmWkuww027gMVMD5hGd/NEW
	M95xY++a+/ecNS00QENnnVQNT+R3v2OCaeTYXrfrfscO7DHL9m8Alh9PJIJVTtDYkick/7SP3r4
	3j6+ntSv6oUlAW60wErPtRbVAe6ErTOUJnRN299qEg4DiRbMZ7lxHeCXBrglF6YKWbpsBxfmu2Y
	pMIxQH3OBNEeopWBYfj7CTCrgvaHmlOPfbD7ltsfdHQO9GVJdVEElgrhkKEWFsbyfrNvJ9ZeVJR
	lA6GKeVh57snIugCDn9RnFCtiZEDN9PFaeJw+pk57lVzGw3Db7lQsgkLibALQNLOlahyrGLqXKX
	uOdBkyIJOChqud8Bnc3TAqo5FqjP7caT/dVx/yq/xZS3ZSEEQzU1ZIN96IzhXCGTqu0J/BceMx2
	Ioo+qHLOXTxtNkwQNxWUzPMtRyXB4clCfOtmhlcU9kg=
X-Received: by 2002:a05:600c:524e:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48e676c14b9mr236929905e9.29.1778516655409;
        Mon, 11 May 2026 09:24:15 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8e60edb0sm155815e9.8.2026.05.11.09.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:24:14 -0700 (PDT)
Date: Mon, 11 May 2026 18:24:13 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 05/10] bpf: preserve constant zero when doing partial
 register restore
Message-ID: <1601523c567973d32e7d1c80f0e4f421dd218a7c.1778516196.git.paul.chaignon@gmail.com>
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
X-Rspamd-Queue-Id: 268AC512C8E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245283-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Action: no action

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit e322f0bcb8d371f4606eaf141c7f967e1a79bcb7 ]

Similar to special handling of STACK_ZERO, when reading 1/2/4 bytes from
stack from slot that has register spilled into it and that register has
a constant value zero, preserve that zero and mark spilled register as
precise for that. This makes spilled const zero register and STACK_ZERO
cases equivalent in their behavior.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231205184248.1502704-7-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8309504d1660..eaeb996ff56a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4952,22 +4952,39 @@ static int check_stack_read_fixed_off(struct bpf_verifier_env *env,
 				copy_register_state(&state->regs[dst_regno], reg);
 				state->regs[dst_regno].subreg_def = subreg_def;
 			} else {
+				int spill_cnt = 0, zero_cnt = 0;
+
 				for (i = 0; i < size; i++) {
 					type = stype[(slot - i) % BPF_REG_SIZE];
-					if (type == STACK_SPILL)
+					if (type == STACK_SPILL) {
+						spill_cnt++;
 						continue;
+					}
 					if (type == STACK_MISC)
 						continue;
-					if (type == STACK_ZERO)
+					if (type == STACK_ZERO) {
+						zero_cnt++;
 						continue;
+					}
 					if (type == STACK_INVALID && env->allow_uninit_stack)
 						continue;
 					verbose(env, "invalid read from stack off %d+%d size %d\n",
 						off, i, size);
 					return -EACCES;
 				}
-				mark_reg_unknown(env, state->regs, dst_regno);
-				insn_flags = 0; /* not restoring original register state */
+
+				if (spill_cnt == size &&
+				    tnum_is_const(reg->var_off) && reg->var_off.value == 0) {
+					__mark_reg_const_zero(&state->regs[dst_regno]);
+					/* this IS register fill, so keep insn_flags */
+				} else if (zero_cnt == size) {
+					/* similarly to mark_reg_stack_read(), preserve zeroes */
+					__mark_reg_const_zero(&state->regs[dst_regno]);
+					insn_flags = 0; /* not restoring original register state */
+				} else {
+					mark_reg_unknown(env, state->regs, dst_regno);
+					insn_flags = 0; /* not restoring original register state */
+				}
 			}
 			state->regs[dst_regno].live |= REG_LIVE_WRITTEN;
 		} else if (dst_regno >= 0) {
-- 
2.43.0


