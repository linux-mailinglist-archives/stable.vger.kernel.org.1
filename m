Return-Path: <stable+bounces-245288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NsvLEUMAmrpnQEAu9opvQ
	(envelope-from <stable+bounces-245288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:05:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED0512FB7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95E7830608C7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE687427A10;
	Mon, 11 May 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQMFL0ZF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27223401497
	for <stable@vger.kernel.org>; Mon, 11 May 2026 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516713; cv=none; b=u+lYoDoK+ijveDPCCWT0Ydjs+2bpolbunYnskaIAHa3oyHSSFeJgFJYjQjO9MFue1T383x32k+sNU4KzWArKvt1+ZYb4+4InWFMAI1zZjwz6DMgNxPI2D3P5RKkqPTCo5jBOeCehzw8Fx2+mpNdTltXUX2JZZskuHIu0ZrD453I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516713; c=relaxed/simple;
	bh=FKGA2NRsHn0ASAz6QWiE12aOFIAe1SstDyOrFhCiNXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2Ie/pOKogcsdA760IUP5WnuPTseIy3DCNJlV3tsweO0jvSzLPdHp9JTo4gvG8QzqdaDCC7Yhdnh7Jm2yVLb56iBy/Qyy2/Eosa6P74EDctXqguzzaB75VcJBkH3Uaav96/uWaeNwSrnXeVqIQrJnIyMmrAQJCdr6I8ejUZt2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQMFL0ZF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso39854295e9.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 09:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516710; x=1779121510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tcTJ4XUAj66oG8KVYB8yvxHdPtEGcOuVV331K9CdIuY=;
        b=ZQMFL0ZFUDxolVFJB902oM6PGnl54kho4a26geEtR2HPrq0qzpeBDt8AkZ9WOSJgeM
         76j2/NCm4M3ZjWV1PxcvytZwArSjv2+OrnXRzUVTZdz3e3dJ6GGXIbJ6UcMumDzS8oqp
         sxxSPNAYpiJn3+etkEAmeUCuSbOyh1gsQfseldY9G1pm2Sx/VAfuPytnl5cDMbCeyx7a
         kNkCi4QXXfTawsC6SoPgbaTChNMI2IllpWdtiSxdLXjUD4aCu/EJf7f0obSDgZsZnP/c
         86KWiVSOTy2owBjz3exR4sBP2OOSjLV9ivcltE1r22hf5ZzdRymtPoM6e4o7vuck8S7P
         QfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516710; x=1779121510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcTJ4XUAj66oG8KVYB8yvxHdPtEGcOuVV331K9CdIuY=;
        b=DPnEfK4TqpN5Vy0Zr+q1EOlk4Vzoox2j4wk0bcMtqzeDQcQuzyf20mJfF6e4UdghQE
         aMya6waq0VEDLpC69l4+nhd7/7Wewxmr2VD/Dgscl22/SHMbOBB/+3YQ/16UtktROriq
         2U6DzIGcv6HA8jC9oc6l+jvoD4cbtK3+Yy3l53/HneBp9FntPWT+xKTl4gc85ulWEpE0
         qMAR1fL2/NpJvajlsRyGDjOHwRcNyyQQ02EPyLFU2cYjRgIVeZaiXb9f0uJTjR0Ect1N
         PfqF6Ttp0Wphvohx8sGuzltLyyBWermxc0/+HmB3MOy1abdc3glI0cr32JZZJ7ieULFy
         qdCQ==
X-Gm-Message-State: AOJu0Yzzm4r+wZgL05qg3mlZhnH67bOWCdSXH8ku+xkHAtmG3gas2X7W
	bIuLyiIJGJYrMEuTYZq72INN2u3P4VMW+tvLwz9/ibWR60WoakmFuW0DxMYWHGny
X-Gm-Gg: Acq92OF8t9v3CnnYtbUCuOn5HFeOY9Rm4gNQUmu3Rl4x7jUe9KddjuDdPEXkeD7Csqf
	AZl+fSbGYmsKptPrHGCzdLO9KIZ3p8I/GYZeAi29IEvdfdBbvDVF0VCfzL0EgDuHxmyt+EonxuB
	tz8qsKdn5KxEdQ32jpzmMNz25eHPOG1KP/NhxIt0m+2ggdUF1RcHlr/Am/D8y1V1x9jMBkxnXUt
	YTxkYjlmtVdKQsN4xtz/gzH6WPnTWfqjOC9C8M9AnYyRDIKmYlySp/V2k3nD+FjIK279thfIMjM
	VbB+j4kVCfWrJ3eoVpqmlXJRNLJeioddogeWX8ahtRUOlbkw6Crj/ss0MN4lMto4OLctxilHRY7
	olM1Z58wd72ICiVDvcoGdD4fYlRrzEN0yEW5yX8AYZ/hT3L2sojI3Ns7+10y+ClekOY5ox/zWj2
	YEgVdXpu60pVkcpk0JI0GZZy1RnMBSoyzQRq/bwSkK690nyok8yvjpJ2IR6WbkVpLfipCLoPqh3
	afE5ra1Z2sObgGgrWAeM7qvNMkEib2EG6TN5rJ45WCFvp6THYa4XgTreXXEazZSAzJua9yD6F7J
	Mm32TDUG2RBXoIdvnLrYByqDlq1BFR9Lx3q33g5z1eg=
X-Received: by 2002:a05:600c:4e01:b0:489:a4:e578 with SMTP id 5b1f17b1804b1-48e706b1f5bmr188333625e9.14.1778516710321;
        Mon, 11 May 2026 09:25:10 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f76596008310132d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f765:9600:8310:132d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6f9fc89asm207300345e9.0.2026.05.11.09.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:25:09 -0700 (PDT)
Date: Mon, 11 May 2026 18:25:08 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>
Subject: [PATCH 6.6.y 09/10] bpf: handle fake register spill to stack with
 BPF_ST_MEM instruction
Message-ID: <a07c9b1152a29ac350e5c8f5724f51f95afe385a.1778516196.git.paul.chaignon@gmail.com>
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
X-Rspamd-Queue-Id: 80ED0512FB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,iogearbox.net,kernel.org,gmail.com,epfl.ch,outlook.com];
	TAGGED_FROM(0.00)[bounces-245288-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,iogearbox.net:email]
X-Rspamd-Action: no action

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 482d548d40b0af9af730e4869903d4433e44f014 ]

When verifier validates BPF_ST_MEM instruction that stores known
constant to stack (e.g., *(u64 *)(r10 - 8) = 123), it effectively spills
a fake register with a constant (but initially imprecise) value to
a stack slot. Because read-side logic treats it as a proper register
fill from stack slot, we need to mark such stack slot initialization as
INSN_F_STACK_ACCESS instruction to stop precision backtracking from
missing it.

Fixes: 41f6f64e6999 ("bpf: support non-r10 register spill/fill to/from stack in precision tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/r/20231209010958.66758-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/verifier.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 705582bdda68..f6040169ef74 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4678,7 +4678,6 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 		__mark_reg_known(&fake_reg, insn->imm);
 		fake_reg.type = SCALAR_VALUE;
 		save_register_state(env, state, spi, &fake_reg, size);
-		insn_flags = 0; /* not a register spill */
 	} else if (reg && is_spillable_regtype(reg->type)) {
 		/* register containing pointer is being spilled into stack */
 		if (size != BPF_REG_SIZE) {
-- 
2.43.0


