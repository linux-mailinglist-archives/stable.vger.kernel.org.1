Return-Path: <stable+bounces-254485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPdUEcJ8Fmp9mwcAu9opvQ
	(envelope-from <stable+bounces-254485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:10:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF25DF56D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 017E63035AB5
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 05:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D982F5491;
	Wed, 27 May 2026 05:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jmc3J/D2"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1A27A91D
	for <stable@vger.kernel.org>; Wed, 27 May 2026 05:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779858607; cv=none; b=SJQny1CKjRdCveV3vq51GyQ6RcPnM/AcfEPGClG0hZje0SAUZ7TRUXA+1axQtyfUjEzBPoRdFkl1nSLeW3PE4VaYPuiwvcAHQN6BZqgZFNE8rPpqvyGYHeWIrT37AVPgClwJll5lS5ccxGpCZpsNyEnGo0mcC7aDfrN4OjR9Wz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779858607; c=relaxed/simple;
	bh=VyOnXcpGm/inx51RutfGq0M/zxoQoXB4CG3Po2BqFqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A90IjSO4AMBPH4Ze2lz8cZWK1TSLueid27sccHx16RwmM7tuh66eo0UmTYs6DEZslEM5B9glTkGI+/2n2i2AqZk9Q2dZteIF0yFpfCmjrkxdajC9hcF2nGmWMhZDNmZOZhZJwO6dWhHLyeiDkqlJnoSSFbNQ8WjXnyItkPxc3R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jmc3J/D2; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4626d285-57ab-46c9-b75b-d56efe7417fc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779858593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BQ0nSkTL5Xw0hG+M09Zs46qBW5dJlnpLwrgeyBbp8zM=;
	b=jmc3J/D2MKDBzRQyVrJhMcKOg7DcjIo35waGrbNWqqUDD2uvYAnxUNieWRfUx8TCx3bJBA
	1m832uYzh717Erdn6fTDUoI5kcfSRrxYuSoAaL51KfTOSV7eBydmu+UBixmLOXrrMA0Z3l
	ulQAyHpkZ1tZijR56f0iGmj2mlRoF84=
Date: Wed, 27 May 2026 13:09:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christopher Lusk <clusk@northecho.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260526025154.60607-1-clusk@northecho.dev>
 <d92bc603-e345-4dee-9ae9-6ad45e4e6642@linux.dev>
 <20260526161101.691d4cb7@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260526161101.691d4cb7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254485-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[northecho.dev,gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 97DF25DF56D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 5/27/26 7:11 AM, Jakub Kicinski wrote:
> On Tue, 26 May 2026 14:44:24 +0800 Jiayuan Chen wrote:
>> If async_capable is set to 1, the zerocopy path in tls_sw_sendmsg() is
>> skipped.
>> Unfortunately ktls with bpf_msg_pop_data() does not work correctly under
>> this
>> copy path.
>>
>> tls_clone_plaintext_msg() aliases msg_pl onto msg_en's plaintext area
>> (in-place encryption).
>>
>> BPF runs bpf_msg_pop_data(msg, 0, 2). This shifts msg_pl's SG entry
>> forward by 2 bytes.
>> The two SGs now point to the same page at different offsets. Physical
>> memory overlaps but the start of
>> address differ.
> Ugh, do you mean that the memcopy path is broken? There are other
> conditions under which we may fall into it than just !async_capable :(
> Small send with MSG_MORE is probably the easiest?
>
> So we need to fix that one way or the other.


Yes, the memcopy path is broken, but only when combined with sockmap's 
pop helper.


msg_pl and msg_en share the underlying page:

                        msg_pl           msg_pl end
                          ^                     ^
                   |------|------------------|-------|
                   | hdr |   plaintext     |  tag  |
                   |------|------------------|-------|
                   ^                                      ^
                   |                                       |
               msg_en                         msg_en end

Before encryption, sge->offset += prot->prepend_size is applied
to msg_en so that the encryption's dst and src point to the same
block of memory.

But once pop has run — i.e. msg_pl's start advances — the encryption's 
dst and src
are no longer the same.

crypto_ctr_crypt():
When dst and src have the same address, crypto saves the encryption 
result into a
temporary buffer and then writes it back to dst.

When dst and src have different addresses, the crypto module treats them 
as two

separate buffers and stops considering in-place mode.

it's complicated to process pop/push + head/mid/tail...

>> I think selecting a sync provider via mask = CRYPTO_ALG_ASYNC is
>> sufficient to
>> remove the -EINPROGRESS return path.
>>
>> May be time to remove skmsg from ktls? (disable by default first,
>> re-enable via a new ktls module_param?)
> Yes, we asked John F off-list to get his attention and I think there's
> only a vague plan to start using kTLS + sockmap, no current user
> (sorry if I misread / misremembered).
>
> module params aren't a great API. If we want to deprecate it let's just
> remove the integration in net-next. You have my vote..

