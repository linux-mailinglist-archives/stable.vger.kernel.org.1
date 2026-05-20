Return-Path: <stable+bounces-249812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAqHNxqXDWoMzwUAu9opvQ
	(envelope-from <stable+bounces-249812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:12:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8F58C274
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 852A130AB460
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E223DB30B;
	Wed, 20 May 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSVv4SBl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4F13D1CA2;
	Wed, 20 May 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275378; cv=none; b=nD8ANLD0CNgkf6r+OjbII/swnd1h01iLcc01N3RDEsGbj4B35WUfjxHhQ2ZfWzayrKJ7m9tLe+T47lW76do8dOfatrYcM2ZeDXBaFIbhKhkKiqMXRO1XG+1yI8bS1Nil/fun3Ts9oDELqlgh/OXsTekRPuJ28IXNQTkxJN0IvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275378; c=relaxed/simple;
	bh=QMYj2pAwBtdo5Z660R6eClhAO0iC3DdrN7pvFa3XJl0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=N/cYyMMSYyDlWva1ULAQBbVX9S0JuMzKX+Rp63vRT6ZwS6j8phrXERiF+Uu6wp/YlUrVAOfPtlbckcFdgHbweMwdnwtz/kJlnaO/FhKhoXuVMaOPdaTyIIWNbw0FlxJFT1lIVNMrZH8lpA5B1Aar53fZfoRRzVKbKa2Bii+PmPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSVv4SBl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2951F000E9;
	Wed, 20 May 2026 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779275377;
	bh=07YSU633IALLB22qkUu99X1yCvwGnRkcK7XpElqYhBM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kSVv4SBlBw/L9EJocRfYlo0psPEvB5tqoxS06dB2Bkbu2eCBwZsX482U+z+d6RH34
	 dflJpJDbJYpVd4PkrIDHFF/DvN80m9Ogg0aD+ztBPGrLykNnbJpCwViI+4DZsE2JRK
	 qrFojf0WtNpPk1rb1DmiOUWSTRfa9f6AE47c7hjB2mVpRAhu86vd1e97N00gGkDYoZ
	 1DiH1L6nS1tZz31my9SIPYteya4ZRaaJjlcFyQfTr2qKYy2WU7j0FAM97ZTRX2l7fo
	 WeyNjYC3jyphuOCBqpF6mI8ZL7XzQeRKExbfXy7ZN9lEY0j6LSUbjf7WAOhfZ5PMiE
	 bGEshQ4TJxTGw==
Content-Type: multipart/mixed; boundary="===============1243832924483732727=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <646104384170b8d95ce979ba3d0bd87a808e5dd2a1f6b2bc4e0a346ca38e654d@mail.kernel.org>
In-Reply-To: <20260520102715.3033936-1-rollkingzzc@gmail.com>
References: <20260520102715.3033936-1-rollkingzzc@gmail.com>
Subject: Re: [PATCH v3] bpf, sockmap: keep sk_msg copy state in sync
From: bot+bpf-ci@kernel.org
To: rollkingzzc@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,jakub@cloudflare.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,zerocling0077@gmail.com,2045gemini@gmail.com,rollkingzzc@gmail.com,stable@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 20 May 2026 11:09:36 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249812-lists,stable=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 87E8F58C274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============1243832924483732727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714..223d78708486 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -2794,6 +2835,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  {
>  	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
>  	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
> +	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
> +	bool rsge_copy = false;
>  	u8 *raw, *to, *from;
>  	struct page *page;
>
> @@ -2866,6 +2909,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  			sk_msg_iter_var_prev(i);
>  		psge = sk_msg_elem(msg, i);
>  		rsge = sk_msg_elem_cpy(msg, i);
> +		rsge_copy = sk_msg_elem_is_copy(msg, i);
>
>  		psge->length = start - offset;
>  		rsge.length -= psge->length;

Could copy + len overflow and cause an out-of-bounds write? In
bpf_msg_push_data(), the len parameter is an unbounded u32 value passed
from a bpf program. When calculating the allocation size, copy + len can
overflow a 32-bit integer:

    page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
                       get_order(copy + len));

If copy + len wraps around, alloc_pages() will allocate an undersized
buffer. Later, the destination pointer for shifting tail data is
calculated as:

    to = raw + front + len

Due to len being a large value, front + len wraps around and results in a
large positive 32-bit offset (zero-extended to 64-bit). The subsequent
memcpy(to, from, back) then performs a controlled out-of-bounds write well
past the allocated page.

Does bpf_msg_push_data() leak uninitialized kernel memory? The function
allocates a new memory page:

    page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
                       get_order(copy + len));

Since the allocation does not include the __GFP_ZERO flag, the new len
bytes inserted into the message are never explicitly zeroed or initialized.
If the bpf program does not manually overwrite these bytes and the message
is transmitted over a socket, this could leak uninitialized kernel memory
to the network or userspace.

Could the ring buffer state become corrupted when data is appended exactly
at the end of the message and the ring buffer is full?

If data is appended exactly at the end of the message (start == offset +
l), the loop finishes with i pointing to the unused slot msg->sg.end. If
the ring buffer is full (!space), the coalescing fallback logic reads:

    copy = msg->sg.data[i].length

Because i points to an unused slot, its length is 0, making copy == 0, and
the fallback coalescing block is bypassed. The function then
unconditionally calls:

    sk_msg_iter_next(msg, end)

which increments msg->sg.end. Since the ring buffer was already full,
advancing msg->sg.end causes it to wrap around and equal msg->sg.start.
This could corrupt the ring buffer state and overwrite the first element
without calling put_page(), leading to page leaks.

[ ... ]

> @@ -2891,23 +2935,34 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
>  	/* Shift one or two slots as needed */
>  	sge = sk_msg_elem_cpy(msg, new);
>  	sg_unmark_end(&sge);
> +	sge_copy = sk_msg_elem_is_copy(msg, new);
>
>  	nsge = sk_msg_elem_cpy(msg, i);
> +	nsge_copy = sk_msg_elem_is_copy(msg, i);
>  	if (rsge.length) {
>  		sk_msg_iter_var_next(i);
>  		nnsge = sk_msg_elem_cpy(msg, i);
> +		nnsge_copy = sk_msg_elem_is_copy(msg, i);
>  		sk_msg_iter_next(msg, end);
>  	}

Should rsge.offset be adjusted after splitting? When rsge is created
from a split entry, the code does not include:

    rsge.offset += start - offset;

to correctly adjust the offset. The rsge points to the tail portion of
the split entry but retains the original offset, which appears incorrect.
This could cause the residual entry to point to the wrong data within
the page.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26156967283
--===============1243832924483732727==--

