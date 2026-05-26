Return-Path: <stable+bounces-254452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CI5FVQpFmqUiQcAu9opvQ
	(envelope-from <stable+bounces-254452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:14:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 000BF5DD79F
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01AEB3046E88
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 23:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022593CC9F6;
	Tue, 26 May 2026 23:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuQyOPGZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5613C4B86;
	Tue, 26 May 2026 23:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779837063; cv=none; b=hN/VdOcrWbhq0vaNw/jn/AloMr14X1OTbu0EwrNtAO/r9wwpC0x6lxThFJ13Y1gguy3dKt2XcSfMig9UayA6vQtrLqtCOfMz1quZ/ACOkrcKRo6GcXjXHYuHdJ58iq3RvhJou5rYT8JtplMtb5DmwIhnVIo98cMyGqCXNuc50Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779837063; c=relaxed/simple;
	bh=bc6+1BBrKtJ+ow8zT5hzg4AJG9zCu5/Qd7LFR0Jmlho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtiKcX4wxnM/JMBQB800wnPlDip0UuTkjIYcw0oEbuoiAqTWN4TOXIiaRPIjRnEKR7VjRESaCgzhrzIegyIFZ1igZawdbJcatfNQ+oXFuhRVVeKO7Ku7dzKSoyoK9Wg55575p4FvkKsM/9g5Xi2Qzbn1XMyp2WpJEYIte4/39no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuQyOPGZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D076A1F000E9;
	Tue, 26 May 2026 23:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779837062;
	bh=AzggQS+B8+GNoAyc/brbiV6G8bezGg+0C+i59qC/4LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PuQyOPGZJ5praIkU9vszxj9Wl8ds06s6StGnfA2raglzdxYtU0SV5xSrC91Hrh1Fp
	 0XSolYs8ROLVWutxEBXi4C0oTjneLrT+zQVbTnl8QEVSf7B5VEHMoTzgzSHkoVYQc4
	 9r3IsaxrIGGI6HS3+191CSTAU35Dm6m54agmdBQZ7Ev5h2rR4lNzuKwQcfdAIXuKQb
	 zcs/1GbKpUl4YsKktIlgZ5ftOnohApxhPNxGeksa6cHv74dBGXlECbCOvtsP36IJnR
	 dvMP6Si0wzzFQA1c3Zv74GrtOr8Qo2P1Fdo7EjncU2uNTjrSiHpqR3Cxbw8ZssCvxF
	 CaC8sWbps67BA==
Date: Tue, 26 May 2026 16:11:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Christopher Lusk <clusk@northecho.dev>, John Fastabend
 <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Message-ID: <20260526161101.691d4cb7@kernel.org>
In-Reply-To: <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
References: <20260526025154.60607-1-clusk@northecho.dev>
	<d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254452-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[northecho.dev,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 000BF5DD79F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 14:44:24 +0800 Jiayuan Chen wrote:
> If async_capable is set to 1, the zerocopy path in tls_sw_sendmsg() is 
> skipped.
> Unfortunately ktls with bpf_msg_pop_data() does not work correctly under 
> this
> copy path.
> 
> tls_clone_plaintext_msg() aliases msg_pl onto msg_en's plaintext area 
> (in-place encryption).
> 
> BPF runs bpf_msg_pop_data(msg, 0, 2). This shifts msg_pl's SG entry 
> forward by 2 bytes.
> The two SGs now point to the same page at different offsets. Physical 
> memory overlaps but the start of
> address differ.

Ugh, do you mean that the memcopy path is broken? There are other
conditions under which we may fall into it than just !async_capable :(
Small send with MSG_MORE is probably the easiest?

So we need to fix that one way or the other.

> I think selecting a sync provider via mask = CRYPTO_ALG_ASYNC is 
> sufficient to
> remove the -EINPROGRESS return path.
> 
> May be time to remove skmsg from ktls? (disable by default first, 
> re-enable via a new ktls module_param?)

Yes, we asked John F off-list to get his attention and I think there's
only a vague plan to start using kTLS + sockmap, no current user
(sorry if I misread / misremembered).

module params aren't a great API. If we want to deprecate it let's just
remove the integration in net-next. You have my vote..

