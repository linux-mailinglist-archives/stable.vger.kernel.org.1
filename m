Return-Path: <stable+bounces-254249-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EJmJrhBFWrJTwcAu9opvQ
	(envelope-from <stable+bounces-254249-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:46:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE95D14A6
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 08:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62265303EF66
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 06:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB23639732F;
	Tue, 26 May 2026 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i0h5xWi6"
X-Original-To: stable@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83A3B5846;
	Tue, 26 May 2026 06:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777888; cv=none; b=cwFGLzalRpf2T9sEM0Xk+ihmBkkTUawOLVDbwIFITNHZb0NO/4LdZkedjnSTURsbTOgiIXn7nz/0+lRLyxu8Ntgd2JGHrNuamZuV7vBFZLyGYWxt7ZPhnY2L3uIeM54e6se6hcUdLn/91RckPqQQckps/tDbdMudbPlYrQ3024A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777888; c=relaxed/simple;
	bh=cLgEFYb9vPxgOhRC0ZF0n+Bf95kheC+pGLWemGnfodE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOesS0ucj/xXlBQzYWRMJR+dk7S2ZLyiDd+ME3FkFz2kL9lrk26ux1pdiEOHuWcOdOBD6kAkujlbjVqZpMd/wVUu05GRxT1CGHEgvIo8rM+cN4E4egZi95iU+SUsInuWOiB0bcImhzDjUkfLi9KAkrhacH9LG0VGkh63aqLp0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i0h5xWi6; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779777874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DeEV2RRWQsIvQLf46WVN6yblZQZCu/TNWjyKT0rKgO4=;
	b=i0h5xWi64e1mCrdbRhD8PWRHV36oUuAj4/VLRHWQReoudCWnkWInwKKpUcV7qG/JaiPp8i
	pMroPjWZ2cxNNWigqTfR5/p7JtasT6W6NfOXGiP0mAsqmSnXTXB1uai1/rxxp4LaEwV42c
	4MGluiNqz8aHSOst79LbTtdz0t7WSNc=
Date: Tue, 26 May 2026 14:44:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
To: Christopher Lusk <clusk@northecho.dev>, Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526025154.60607-1-clusk@northecho.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260526025154.60607-1-clusk@northecho.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254249-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,northecho.dev:email]
X-Rspamd-Queue-Id: E8DE95D14A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/26/26 10:51 AM, Christopher Lusk wrote:
> The kTLS TX path can hand an open record to a sk_msg verdict
> program before encryption.  If the verdict applies fewer bytes
> than the open record contains, tls_push_record() splits
> ctx->open_rec into the record being encrypted and a remainder.
> The synchronous path reattaches that remainder before continuing.
>
> With an async AEAD provider, crypto_aead_encrypt() can return
> -EINPROGRESS after ctx->open_rec has been unhooked but before the
> split remainder is reattached.  The remainder is no longer
> reachable through ctx->open_rec or ctx->tx_list, silently dropping
> transmitted data and leaking the unreachable tls_rec.  The same
> composition also entangles the user-page zerocopy lifetime rules
> with an async completion path.
>
> A sockmap cannot be attached to a socket after an inet ULP is
> installed: sk_psock_init() returns -EINVAL when
> inet_csk_has_ulp() is true.  So the supported ordering for
> sockmap + kTLS TX is sockmap first, TLS_TX setup second.  When
> TLS_TX setup sees an existing sk_psock, allocate the AEAD with
> CRYPTO_ALG_ASYNC masked out and latch the TX zerocopy gate
> (sw_ctx_tx->async_capable) so the buggy composition becomes
> structurally unreachable.  Ordinary kTLS sockets without sk_msg
> BPF attached are unaffected and continue to use async-capable
> providers.
>
> Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
> Cc: stable@vger.kernel.org # 4.20+
> Signed-off-by: Christopher Lusk <clusk@northecho.dev>
> Assisted-by: Codex:gpt-5.5
> Assisted-by: Claude:claude-opus-4-7
> ---
>
> Changes since v2 [1]:
> - Per netdev maintainer guidance [2], replace the Option-C
>    drain-on-error fix with a setup-time surface narrowing in
>    tls_set_sw_offload(): when a sockmap is already attached at
>    TLS_TX setup, request a synchronous AEAD (CRYPTO_ALG_ASYNC in
>    the allocation mask) and set sw_ctx_tx->async_capable = 1.
>    Both moves are needed: latching async_capable alone disables
>    zerocopy but tls_do_encryption() can still return -EINPROGRESS
>    on the copy path; selecting a sync provider removes that return
>    path for sk_msg-attached sockets.
> - Drop the selftest from the series per Jakub's note that the
>    existing sockmap + TLS coverage at
>    tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c exercises
>    this configuration [3].  That suite covers sockmap + kTLS
>    policy paths broadly; the specific async-pcrypt pass-then-drop
>    failure mode from the v2 reproducer was validated for v3 on
>    QEMU/KVM with a KASAN+LOCKDEP-instrumented kernel against net
>    base 2156a29aecff before send.
> - Single-patch series.
>
> Changes since v1:
> - v1's remainder-rooting fix was incomplete; Sashiko AI review
>    surfaced a real UAF in the v2 follow-up that John Fastabend
>    endorsed on the v1 thread [4].  The surface-narrowing approach
>    in v3 makes both failure modes unreachable by avoiding the
>    async + sk_msg composition entirely rather than patching each
>    continuation point.
>
> [1] https://lore.kernel.org/all/20260521025840.976378-1-clusk@northecho.dev/
> [2] https://lore.kernel.org/all/20260525133028.58494274@kernel.org/
> [3] https://lore.kernel.org/all/20260525133048.2dc6d8d3@kernel.org/
> [4] https://lore.kernel.org/all/huduxtn6parzgiaf5cyiyrrvjjvx6jsdedowvrd4nkwmuyeind@j6migjgofh2i/
>
>   net/tls/tls_sw.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 964ebc268..0000000 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2867,7 +2867,20 @@ int tls_set_sw_offload(struct sock *sk, int tx,
>   	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
>
>   	if (!*aead) {
> -		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
> +		u32 mask = 0;
> +
> +		if (tx) {
> +			struct sk_psock *psock;
> +
> +			psock = sk_psock_get(sk);
> +			if (psock) {
> +				mask = CRYPTO_ALG_ASYNC;
> +				sw_ctx_tx->async_capable = 1;
> +				sk_psock_put(sk, psock);
> +			}
> +		}
> +
> +		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, mask);
>   		if (IS_ERR(*aead)) {
>   			rc = PTR_ERR(*aead);
>   			*aead = NULL;
> --
> 2.54.0

If async_capable is set to 1, the zerocopy path in tls_sw_sendmsg() is 
skipped.
Unfortunately ktls with bpf_msg_pop_data() does not work correctly under 
this
copy path.

tls_clone_plaintext_msg() aliases msg_pl onto msg_en's plaintext area 
(in-place encryption).

BPF runs bpf_msg_pop_data(msg, 0, 2). This shifts msg_pl's SG entry 
forward by 2 bytes.
The two SGs now point to the same page at different offsets. Physical 
memory overlaps but the start of
address differ.

I think selecting a sync provider via mask = CRYPTO_ALG_ASYNC is 
sufficient to
remove the -EINPROGRESS return path.

May be time to remove skmsg from ktls? (disable by default first, 
re-enable via a new ktls module_param?)



