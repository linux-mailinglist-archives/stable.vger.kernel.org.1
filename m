Return-Path: <stable+bounces-254654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LvRKf5CF2ov/AcAu9opvQ
	(envelope-from <stable+bounces-254654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:16:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 321A75E96E5
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA0C7302796F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F78636A366;
	Wed, 27 May 2026 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ValWSb2X"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2936680F
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909366; cv=none; b=p340L/R9ALaB4SuCosn2fm10LWzALsd4FS5wxjw2LmCilJwk1aMrKzpqqzjHsmrK6nTYdw40qif818dQK+3Px9qK2H/LzWf1flk6iE9hs1zITYZG7Ef6kkeckoTh3rEt1v0GI9M1uFco0qQF5aS+PeK4s6n4wbY/lb/0QPYd0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909366; c=relaxed/simple;
	bh=W3T4QxdLFfHbdc/KmpcaHHy9IfSTsNZ4bf6F6ZMHiTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epYHrJ++iVSPfgl2aYUgd5kVILp6xFn0tPwRbKbbQxNFOa4yZG73bYs0hRKw/cqISwiQH7ypcUA7L2/tjBhJOeUzOL7K99NL9qr+2Pt8mAbEnBB3+l+8MnbxySRJr0DigXQtFxRJeRccaTQbykC0i18e+OfuthqeDA7LdrgT4oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ValWSb2X; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c80227b1f6cso4521209a12.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779909364; x=1780514164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jVdozbgHNmRboTjJqPe1n9RlPVUR0qDZvYcaF2yAV8s=;
        b=ValWSb2XLrdf3Bw6PhZo9e+CRjbSLnpGiuOU5m4gAa41n1wUh8H8bFDhf+XAJslB2h
         /448U7HWQ4FjK9XeYxEPgefvubM0bnISKWa4CRNt0kdZhJW9VR8eJ7A4/2z6Zm/BPAGf
         g6as7/kz4YuAY9lGEGPGfeXwks+Jj/7TSoPLrbW/RwJALfQtBo8XlwucBqaWKcOBQLM1
         2nYgOZYX6G9y4RbrYBZYfdvtIJGEs8VsQOZL0pzOdXDwcAwwdy3+n3B2fxv6xsZk+2vM
         EdM5rf0i0mq4LAgb3fqvp63PgK+3fNb1QQoxS1zJs6PpS2hYI52rHrKMfSfmjckYmd9Q
         b4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909364; x=1780514164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVdozbgHNmRboTjJqPe1n9RlPVUR0qDZvYcaF2yAV8s=;
        b=ABa+ACVp1AtLslpSkpcjBU07oacheABUP41guG2SJXrPkFirangWERIkp27Om82Sst
         GWq+K47Hp0d3EnYRNOgLQe6yyuUAHF/L+TXmoij1ChrAnmi7V/Ha+B/40ZeWVU6/823N
         MlMOVSoa9g7e7PiafAzAdzhIzjO3+axZGu12vP4HVPD3Rft6A+DW+JEKdgaQ45ql/gSX
         fd0xE+XwV3mNT3u0jeSfOZOUyHrDY3c4z0HFgn3WCCB6qWi/rZVopclcfkS5jDT23hV6
         55adf8Fzo/KphkBkDi6JPmEAclXQaGmwF+gJLtjsNFOLQ8Huums+qRN4fPgErrxU5iyd
         TDDg==
X-Forwarded-Encrypted: i=1; AFNElJ/P683ulGrD2yAjR2tQdNkjq4I8a0qi9q4vU5u3wiBCVRE2kZOkv28OCW+DaVPLFA6oLQBosTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmyudYMCHodvs3qsjK5wzJlRkrE3AV52tJ4L2DBsmuGBNQ4ZRL
	DOi5dkgmEswRIDTsYfUvJcjCriKdHBrBGDr5XblLAwOXU0sqc4vJB59iAPo1KSoV
X-Gm-Gg: Acq92OFW7qNwNCaiANTeISHZ76KBc5l0wOatuzH/46j7E5hn1CxjCkCRsklT6kI2Wyo
	JZ4JjHKSZjpH5aefxLUbVM62JR0YYByzOrDPlORw0euJERU8zRASL9BSJyZw+kcSRdNxzPmgkGP
	SJNt8Vsemf5nf91Z0Hq4wsZdHPa/F4pAdC410CQPFOTw5r2WmhxNPzAF6ztdnZ6oMUfLQGl4Bzl
	vElfYXQSxQiUUhT0NcpN7p8bIvCJBwDoucPT3hxYAacmUiKQpuQtTqKpraEbeYd4pP6IcdzZSPQ
	QhWLva3zrbqYayGG63HMxC3MAIsu7cBVWUU2SRhldiE5SgEc7fgEBpvtbmMaM6vsxlx//puLYI1
	Kdpt6mmM02hknpUYt1o5fwwyn+FQNHHlCTMHsuWGFOjf1qaSAv2wkPTH2MAkARRrpOwwAW3GYhI
	kf5XUyHVd37jDq6yToo3nmzAsIYqwChUxQ
X-Received: by 2002:a05:6a00:2384:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-8415f0f02cbmr22578450b3a.10.1779909364354;
        Wed, 27 May 2026 12:16:04 -0700 (PDT)
Received: from john-p8 ([98.97.42.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bb18bsm3595235b3a.34.2026.05.27.12.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:16:03 -0700 (PDT)
Date: Wed, 27 May 2026 12:16:02 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Christopher Lusk <clusk@northecho.dev>, Sabrina Dubroca <sd@queasysnail.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Message-ID: <ahdAboFpUAZ8aaWm@john-p8>
References: <20260526025154.60607-1-clusk@northecho.dev>
 <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
 <20260526161101.691d4cb7@kernel.org>
 <4626d285-57ab-46c9-b75b-d56efe7417fc@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4626d285-57ab-46c9-b75b-d56efe7417fc@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254654-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 321A75E96E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 01:09:44PM +0800, Jiayuan Chen wrote:
>
>On 5/27/26 7:11 AM, Jakub Kicinski wrote:
>>On Tue, 26 May 2026 14:44:24 +0800 Jiayuan Chen wrote:
>>>If async_capable is set to 1, the zerocopy path in tls_sw_sendmsg() is
>>>skipped.
>>>Unfortunately ktls with bpf_msg_pop_data() does not work correctly under
>>>this
>>>copy path.
>>>
>>>tls_clone_plaintext_msg() aliases msg_pl onto msg_en's plaintext area
>>>(in-place encryption).
>>>
>>>BPF runs bpf_msg_pop_data(msg, 0, 2). This shifts msg_pl's SG entry
>>>forward by 2 bytes.
>>>The two SGs now point to the same page at different offsets. Physical
>>>memory overlaps but the start of
>>>address differ.
>>Ugh, do you mean that the memcopy path is broken? There are other
>>conditions under which we may fall into it than just !async_capable :(
>>Small send with MSG_MORE is probably the easiest?
>>
>>So we need to fix that one way or the other.
>
>
>Yes, the memcopy path is broken, but only when combined with sockmap's 
>pop helper.
>
>
>msg_pl and msg_en share the underlying page:
>
>                       msg_pl           msg_pl end
>                         ^                     ^
>                  |------|------------------|-------|
>                  | hdr |   plaintext     |  tag  |
>                  |------|------------------|-------|
>                  ^                                      ^
>                  |                                       |
>              msg_en                         msg_en end
>
>Before encryption, sge->offset += prot->prepend_size is applied
>to msg_en so that the encryption's dst and src point to the same
>block of memory.
>
>But once pop has run — i.e. msg_pl's start advances — the encryption's 
>dst and src
>are no longer the same.
>
>crypto_ctr_crypt():
>When dst and src have the same address, crypto saves the encryption 
>result into a
>temporary buffer and then writes it back to dst.
>
>When dst and src have different addresses, the crypto module treats 
>them as two
>
>separate buffers and stops considering in-place mode.
>
>it's complicated to process pop/push + head/mid/tail...

For our use case (not deployed yet, but deployed in non-kTLS case)
all we do is observe data and possible drop the skb if it has
malicious HTTP headers for example.

All this push/pop/... in the middle of the kTLS stack is painful.

One option we start rejecting these helpers? That would resolve most
the pain I suspect. The original thought was we do have use cases
now for userspace proxy where we insert headers.

>
>>>I think selecting a sync provider via mask = CRYPTO_ALG_ASYNC is
>>>sufficient to
>>>remove the -EINPROGRESS return path.
>>>
>>>May be time to remove skmsg from ktls? (disable by default first,
>>>re-enable via a new ktls module_param?)
>>Yes, we asked John F off-list to get his attention and I think there's
>>only a vague plan to start using kTLS + sockmap, no current user
>>(sorry if I misread / misremembered).

I'm not against a cleaner solution here.

Another idea: We just add a simple sockops BPF hook with the sk_buff?
No updating sg lists, manipulating data packet sizes and so on.

That would solve the vast majority of any future use case if we have
a user that really started running kTLS and wanted the security stack
to keep working. Even openssl usage of kTLS has really ground to a
halt after it was initially added as far as I can tell.

Something like this already on the list for recv side of tcp.

  [PATCH v3 bpf-next 10/11] bpf: tcp: Add SOCK_OPS rcvlowat hook

>>
>>module params aren't a great API. If we want to deprecate it let's just
>>remove the integration in net-next. You have my vote..

