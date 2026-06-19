Return-Path: <stable+bounces-267357-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oU5DGdEQNWo6mgYAu9opvQ
	(envelope-from <stable+bounces-267357-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 11:50:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E41536A5099
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 11:50:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nzJimoNp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267357-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267357-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EFEE30054E6
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 09:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17233D6DD;
	Fri, 19 Jun 2026 09:50:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99C740D569
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 09:50:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781862607; cv=none; b=GCqNtXXOnapdmmbSLF+kHMYEvOW2ftRhLs10wJgdbwH8rOgTSqV1f2FkAG005viKoBPSRqohhLKBs4neXtGpojk50fHR1YrBKwXcqigwDvrg9OdCI9H95g9G5eUc4gyF8Ny7g7HqouYv9Xf7CGNbGNtHOVw6IYsFVJTjo0Flqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781862607; c=relaxed/simple;
	bh=UAuG4vuG5CgKeF6G4DlWpnMnvTmR9AFwp6RBEUHrfe8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z23oOe7GF8CRBQQSzfCe6ASH8x+OqQzbtzlBC6UgImk64tIyuGrKgYrMkcDPin8TAHiZ9NB1Nvc89B6MjymSY3f+3aUKbHj1CXWF5P2zEqi3zulW5ig7yNIURGnzUAHKCccIrPsg+3epchg43TvhoOYAZLW2E6zTLvTkEOxf0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzJimoNp; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so16898605e9.0
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781862602; x=1782467402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U+dCt2TtpuobcPqEN3sLtws+gA8QvpbrhpYYtvYzphQ=;
        b=nzJimoNpU6NehT9fs0yByheSQnCHQbl/BdFPHa1k1l98ZLjoNL7EwZ4zLERa4IrNkz
         Tbht4828SdC2FaKlI5gcQYFl9pbaqXCDCAcjkVzomWS65Hyo7d6528qCtkS/dF/7d0x4
         ZMm4Q/3GoPBJj4yiiINfoebnDI3H7arTBSSWfsgX9zTn5VXeRke/izVCWilw+/lT6acg
         Oc0+GIzmmyw5r/74pUrABU+vlRAC9VFrrBFS/Ik+J7tkYxEz5JH5ITDh93e4Jx4gQbwm
         QxIhGktyNVx/Bt4xH7wkXFwPp2aY2NOLGfag0+gWp4al/0TEyiJsHJNovjy3zsC6LdqE
         08fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781862602; x=1782467402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+dCt2TtpuobcPqEN3sLtws+gA8QvpbrhpYYtvYzphQ=;
        b=LvRzDAEhk+7phuVccIljef2pupvGoTzAfamf54VelY/I46SbJoRo5xM6MF4s4IRfyf
         YuBn1IVbDk6haznq8lzGkvC42UlN+mB7GqrBgcdBr5QJfnS7q+lyjSK9pIdhy++ZiXpr
         aJjoZqivVu3qvVSXTjfMnS4BIr9wVrAMP0W2BPMIUeFblyab4pOc5cXCRjywUZTpMcEj
         qOphap08/DuQt6/tsm99lVjNPydA/uBItqI2jNKoA/dggJj4DUGx9wkFUR4bAJppM7K/
         7I8sRqvPn/b/kNWEIRvRrH/LdCyDzXyNZsgyQAdZQuffFd5RrU7piJwoLHdV2fRAMz2l
         suBg==
X-Forwarded-Encrypted: i=1; AFNElJ+sMrQ/Rz2Q4eFv5BhKQGnprNFxTLwpQCcIWI95F3z8EwxogPFiWMCzSC7hqP5rGXz4mf15kKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzf0q1dt98WTr+lFquVS6YA1g33XqP1Nx3BpR9JtxDTwvfsmVN
	O9kTqC4Z9Vefy7zPa1CrKFukHn/e4HEKgXhGfc/9ZHb4UCuiFF3KJJ3q83Gfeg==
X-Gm-Gg: AfdE7clNi+gwfoleK7YQxGWPc+brpmqUFLHFwU8f3KiNlcmN1HKq7THC8zNsTW7e1kw
	4mV7ro0XjObk6Smwv4bujdBTQ4DukyNXsj/6o82YwjS0pL5H1qwBeXLPnps8c8L8WCQYaDcfkFc
	6DMCO1Bd9WK9gDC3aalPTgJNRYZeyRYfXey571K190oa8UXSoX1IALKSQmTbPTOlSmgCMmm4Igm
	x9BLbJqa5l7hHuyVJ+F2oEhXihq+mmqbyKgxxVq2x1sEKwU9XdnJ1HCvEyOzRdRcmtWzdDDG+Vm
	83xcl1XddESCJWhG6o3H1JQA1totIHx7A7rr/9eOOVsDQAX1iR0Ynp4+piy9dSWp+oDYyNZaW4z
	cBvrCspOY/9rwLPCquhSQKCjJid7xZM1mWFcduN9iTaD3mSghJFyqtGFGxNgug4R0tElQExyPIV
	+7HSS4DBIPZUU=
X-Received: by 2002:a05:600c:4e05:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-49240e6c534mr44224975e9.25.1781862601718;
        Fri, 19 Jun 2026 02:50:01 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fcd7027sm57929595e9.1.2026.06.19.02.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:50:01 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 19 Jun 2026 11:49:59 +0200
To: Tristan Madani <tristmd@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Xu Kuohai <xukuohai@huawei.com>,
	Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] bpf: Reset register bounds before narrowing retval range
 in check_mem_access()
Message-ID: <ajUQxyD2fu8M4wal@krava>
References: <20260617120815.3910671-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617120815.3910671-1-tristmd@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267357-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:xukuohai@huawei.com,m:eddyz87@gmail.com,m:bpf@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[olsajiri@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,huawei.com,gmail.com,vger.kernel.org,talencesecurity.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olsajiri@gmail.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,krava:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E41536A5099

On Wed, Jun 17, 2026 at 12:08:15PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> When the BPF verifier processes a context load of an LSM hook return
> value, it calls __mark_reg_s32_range() to narrow the register to the
> hook's valid range. However, __mark_reg_s32_range() intersects the new
> range with the register's existing bounds using max_t()/min_t() rather
> than replacing them.
> 
> If the destination register carries stale bounds from a prior instruction
> (e.g. BPF_MOV64_IMM), the intersection can produce a range narrower than
> reality. The verifier then believes it knows the register's exact value,
> while at runtime the actual hook return value is loaded, creating a
> verifier/runtime mismatch that can be used to bypass BPF memory safety
> checks.
> 
> The else branch already calls mark_reg_unknown() to reset register state
> before any narrowing. Apply the same reset in the is_retval path so
> stale bounds are cleared before __mark_reg_s32_range() intersects.

hi,
you need to specify the bpf tree in the subject "[PATCH bpf] ..."

jirka


> 
> Fixes: 5d99e198be27 ("bpf, lsm: Add check for BPF LSM return value")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 54c6953a8b84..7e30dddc7721 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7532,6 +7532,7 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  			 */
>  			if (info.reg_type == SCALAR_VALUE) {
>  				if (info.is_retval && get_func_retval_range(env->prog, &range)) {
> +					mark_reg_unknown(env, regs, value_regno);
>  					err = __mark_reg_s32_range(env, regs, value_regno,
>  								   range.minval, range.maxval);
>  					if (err)
> -- 
> 2.47.3
> 
> 

