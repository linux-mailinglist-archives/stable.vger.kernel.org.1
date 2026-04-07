Return-Path: <stable+bounces-233482-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDSQAlNd1GlrtQcAu9opvQ
	(envelope-from <stable+bounces-233482-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:26:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 078ED3A8B14
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87ABB300B47E
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 01:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D288021018A;
	Tue,  7 Apr 2026 01:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nJZSA9oC"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2279211A09
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 01:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525191; cv=none; b=Cq5yqkSxlQejQtdWftpyuV8GlLMB1NBi1dmvmePAixkAKKS/zgb9cyREC74aDceeOQ26MdcnGzuswCRATzT7m03nBTf5vObjO2mDjnxm4jtMohzBkN8Ag3HNguZgSTJdXv8z5SE8y+dfXflIb5R3fu/dvgHI9LBxs0hyD5bjK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525191; c=relaxed/simple;
	bh=dVILt1iLbW9F7TOlyKfK5PT3r7yL8XE5R4xlV05lU2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFwpahDehp9T/Rp96S+GRveVQRtCT07RYxkic5QIN/iZroDNFH1MmT0eELnOdcCqDb0BtMr8QZgM7QXOT4V+iAYkBfLhbWZHH6bsXJoJxp6lZKs43z0QE6dLZEEe9welxNUo1AxSCiOOfoiOhCDBIEwtcfieX//dIQD+E4zcU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nJZSA9oC; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 Apr 2026 18:25:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775525177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=euWRknGGJoLsZnDSjgyoR/3x+tUQI1fMgnlSdPtl2Ss=;
	b=nJZSA9oCoqyBwc4kpihQiPaqanTRL6HaqfMrlXAGWgpkozZ43AB8upcT6Yt0IULldqZlgu
	zySMdC4zpYVQV4VQuM9AMLIxjLSjUvAiGXSHc0TIjUvZgpqu5HTel2eOzghc7gWgT8AV6N
	hMl+vQEtwoqSEnRrFslDBwUhQMJTlb8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Werner Kasselman <werner@verivus.ai>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lawrence Brakmo <brakmo@fb.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] bpf: add is_locked_tcp_sock guard for sock_ops rtt_min
 access
Message-ID: <2026471147.8A6S.martin.lau@linux.dev>
References: <20260406224953.2787289-1-werner@verivus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406224953.2787289-1-werner@verivus.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,fb.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-233482-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,verivus.com:email]
X-Rspamd-Queue-Id: 078ED3A8B14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 10:49:56PM +0000, Werner Kasselman wrote:
> sock_ops_convert_ctx_access() generates BPF instructions to inline
> context field accesses for BPF_PROG_TYPE_SOCK_OPS programs. For
> tcp_sock-specific fields like snd_cwnd, srtt_us, etc., it uses the
> SOCK_OPS_GET_TCP_SOCK_FIELD() macro which checks is_locked_tcp_sock
> and returns 0 when the socket is not a locked full TCP socket.
> 
> However, the rtt_min field bypasses this guard entirely: it emits a raw
> two-instruction load sequence (load sk pointer, then load from
> tcp_sock->rtt_min offset) without checking is_locked_tcp_sock first.
> 
> This is a problem because bpf_skops_hdr_opt_len() and
> bpf_skops_write_hdr_opt() in tcp_output.c set sock_ops.sk to a
> tcp_request_sock (cast from request_sock) during SYN-ACK processing,
> with is_fullsock=0 and is_locked_tcp_sock=0. If a SOCK_OPS program
> with BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG reads ctx->rtt_min in this
> callback, the generated code treats the tcp_request_sock pointer as a
> tcp_sock and reads at offsetof(struct tcp_sock, rtt_min) -- which is
> well past the end of the tcp_request_sock allocation, causing an
> out-of-bounds slab read.

This is not limited to hdr related CB flags.

It also happens to earlier CB flags that have a request_sock, such as
BPF_SOCK_OPS_RWND_INIT.

> 
> The rtt_min field was introduced in the same commit as the other
> tcp_sock fields but was given hand-rolled access code because it reads
> a sub-field (rtt_min.s[0].v, a minmax_sample) rather than a direct
> struct member, making it incompatible with the SOCK_OPS_GET_FIELD()
> macro. This hand-rolled code omitted the is_fullsock guard that the
> macro provides. The guard was later renamed to is_locked_tcp_sock in
> commit fd93eaffb3f9 ("bpf: Prevent unsafe access to the sock fields in the BPF timestamping callback").
> 
> Add the is_locked_tcp_sock guard to the rtt_min case, replicating the
> exact instruction pattern used by SOCK_OPS_GET_FIELD() including
> proper handling of the dst_reg==src_reg case with temp register
> save/restore. Use offsetof(struct minmax_sample, v) for the sub-field
> offset to match the style in bpf_tcp_sock_convert_ctx_access().
> 
> Found via AST-based call-graph analysis using sqry.
> 
> Fixes: 44f0e43037d3 ("bpf: Add support for reading sk_state and more")
> Cc: stable@vger.kernel.org
> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  net/core/filter.c | 47 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb0..58f0735b18d9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10830,13 +10830,54 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
>  		BUILD_BUG_ON(sizeof(struct minmax) <
>  			     sizeof(struct minmax_sample));
>  
> +		/* Unlike other tcp_sock fields that use
> +		 * SOCK_OPS_GET_TCP_SOCK_FIELD(), rtt_min requires a
> +		 * custom access pattern because it reads a sub-field
> +		 * (rtt_min.s[0].v) rather than a direct struct member.
> +		 * We must still guard the access with is_locked_tcp_sock
> +		 * to prevent an OOB read when sk points to a
> +		 * tcp_request_sock (e.g., during SYN-ACK processing via
> +		 * bpf_skops_hdr_opt_len/bpf_skops_write_hdr_opt).
> +		 */
> +		off = offsetof(struct tcp_sock, rtt_min) +
> +		      offsetof(struct minmax_sample, v);
> +	{
> +		int fullsock_reg = si->dst_reg, reg = BPF_REG_9, jmp = 2;
> +
> +		if (si->dst_reg == reg || si->src_reg == reg)
> +			reg--;
> +		if (si->dst_reg == reg || si->src_reg == reg)
> +			reg--;
> +		if (si->dst_reg == si->src_reg) {
> +			*insn++ = BPF_STX_MEM(BPF_DW, si->src_reg, reg,
> +					  offsetof(struct bpf_sock_ops_kern,
> +					  temp));
> +			fullsock_reg = reg;
> +			jmp += 2;
> +		}
> +		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
> +						struct bpf_sock_ops_kern,
> +						is_locked_tcp_sock),
> +				      fullsock_reg, si->src_reg,
> +				      offsetof(struct bpf_sock_ops_kern,
> +					       is_locked_tcp_sock));
> +		*insn++ = BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);
> +		if (si->dst_reg == si->src_reg)
> +			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,
> +				      offsetof(struct bpf_sock_ops_kern,
> +				      temp));
>  		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
>  						struct bpf_sock_ops_kern, sk),
>  				      si->dst_reg, si->src_reg,
>  				      offsetof(struct bpf_sock_ops_kern, sk));
> -		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
> -				      offsetof(struct tcp_sock, rtt_min) +
> -				      sizeof_field(struct minmax_sample, t));
> +		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg, off);
> +		if (si->dst_reg == si->src_reg) {
> +			*insn++ = BPF_JMP_A(1);
> +			*insn++ = BPF_LDX_MEM(BPF_DW, reg, si->src_reg,
> +				      offsetof(struct bpf_sock_ops_kern,
> +				      temp));

There is an existing bug in this copy-and-paste codes [1] and now is
repeated here, so please find a way to refactor it to be reusable instead of
duplicating it.

This also needs a test. It should be a subtest of [1],
so [1] need to land first.

[1]: https://lore.kernel.org/bpf/20260406031330.187630-1-jiayuan.chen@linux.dev/

