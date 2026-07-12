Return-Path: <stable+bounces-273529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pJn4OPURVGqjhgMAu9opvQ
	(envelope-from <stable+bounces-273529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 00:15:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 361827461E1
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 00:15:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=jh++NTkP;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273529-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273529-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E47D3003610
	for <lists+stable@lfdr.de>; Sun, 12 Jul 2026 22:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C037F019;
	Sun, 12 Jul 2026 22:15:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180743793A2
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 22:15:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894513; cv=none; b=PKiz25uhygW9gnYAgOma1b6mnVZFPJHIRu6WK4rDZYE5alWI2PmglDz0izIq4jKkkzcuOP7Go9FkDCTWNl0xUnFATsjre2OH30TaHQOzveA0ovc4UYFzpiS2o6OwccOdItmSzRg4FZRXFP2Nra7eSFkILAg9P2ifKYhvPifOyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894513; c=relaxed/simple;
	bh=1hgSOoWiw+HnAX87diwB++9TUNULMJEA+gJgDazuzsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSJ+Y7TaOKy9M7+3W2ZywXIq7JrstWjxVqAZ4YKJCbFF0VjdnD2+Xk9iyy+C3nqR5uYjo9R2DNKP82mORkfN/rVSIYQ+azHyTeuQpORAxl94Fp28rD2sw2kZnTqSiKMUu/RmiWb8GtvGFf3Ys/4hQesP2SIsGUdJ85XoqzK9iWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jh++NTkP; arc=none smtp.client-ip=95.215.58.171
Message-ID: <f4b2b659-036b-49f7-8f6b-5f173a1eb380@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783894499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CboKgCXRP0GTBlCnZOK+gyQj14lL7ieETZEex5S6D9Y=;
	b=jh++NTkPV62UCIQg8hXCIhD1nhDLIkHnieo9pd7zi4w7eMzrD28pgxa0kyDLJT3Ouhe31O
	4yQvFtiEwXETIihEM8yX91paFdKFJsJTsgIVwRllACL4n3O3o4sLa0XFFJUqoMUOn3qxKd
	+Jr8Tgs/eaveyOKLBiOL23qJEgKTETA=
Date: Sun, 12 Jul 2026 23:14:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] nfc: llcp: reject PDUs shorter than the LLCP header
To: "Doruk (0sec)" <doruk@0sec.ai>
Cc: david@ixit.cz, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260711072702.70231-1-doruk@0sec.ai>
 <be1731eb-e6ec-4015-92e4-c09fd88019e6@linux.dev>
 <CAPdMp1p=72WXe-8w5Y9viBuB6YvZWZomNc9xQzXEg-qe1WVN0A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAPdMp1p=72WXe-8w5Y9viBuB6YvZWZomNc9xQzXEg-qe1WVN0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:david@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-273529-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 361827461E1

On 12/07/2026 17:02, Doruk (0sec) wrote:
> Hi Vadim
> 
> this was reproduced from userspace on unmodified
> linux-next (bee763d5f341) without RF hardware.
> 
> It's the peer-RX path, not a local command skb:
> 
> virtual_ncidev_write (peer NCI DATA) -> nci_rx_data_packet
> -> nfc_tm_data_received -> nfc_llcp_data_received
> -> rx_work -> nfc_llcp_rx_skb -> nfc_llcp_recv_connect

Ok, fair, but in this case it's better to check skb->len in
nfc_llcp_data_received - no need to setup a worker when skb is not
correct.

> 
> Bring the LLCP link up via a normal NFC-DEP activation, then send
> one NCI DATA packet with a 1-byte CONNECT PDU. skb->len - 2 wraps
> to 0xffffffff and the TLV walk runs off the end:
> 
> BUG: KFENCE: out-of-bounds read in nfc_llcp_recv_connect+0x9f6/0xf80
> nfc_llcp_recv_connect+0x9f6 -> nfc_llcp_rx_work -> process_one_work
> read 4219B past a 704B skbuff_small_head from virtual_ncidev_write
> R14: 00000000ffffffff (wrapped tlv_array_len)
> 
> With the guard: rx_skb runs for all 600 short PDUs, recv_connect
> reached 0 times, 0 reports.
> 
> The bound stays "<", not "<=" -- a header-only SYMM/DISC/DM is
> exactly 2 bytes and must still dispatch; AGF uses "<=" only
> because an AGF frame must also carry a sub-PDU. I'll drop the
> "same guard as AGF" line from the commit message.
> 
> Instantiating /dev/virtual_nci needs privilege, but that's just
> the syzbot transport; the 1-byte CONNECT is what a remote NFC-DEP
> peer emits, and the DEP layer imposes no minimum LLCP length.
> Impact is a proximity OOB read (DoS).
> 
> I can send the full reproducer if you'd like.
> 
> best
> Doruk
> 
> On Sun, Jul 12, 2026 02:01 PM, Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 11/07/2026 08:27, Doruk Tan Ozturk wrote:
>>> nfc_llcp_rx_skb() reads the two-byte LLCP header (DSAP/SSAP/PTYPE) and
>>> dispatches by PDU type; several handlers then derive a TLV-array length as
>>> skb->len - LLCP_HEADER_SIZE. Neither nfc_llcp_rx_skb() nor its callers
>>> guarantee the frame is at least LLCP_HEADER_SIZE bytes, and a sub-header
>>
>> that's not correct. there are 2 ways to get to nfc_llcp_rx_skb() - via
>> nfc_llcp_recv_agf() or through commands/locally generated skbs. The
>> first one checks against LLCP_HEADER_SIZE, while latter one creates skb
>> payload with correct LLCP header size. Do you have a reproducer to
>> trigger the issue?
>>
>>
>>> PDU does reach it: digital_in_recv_dep_res() and digital_tg_recv_dep_req()
>>> strip the DEP header with skb_pull() after only checking the DEP header
>>> size, so a DEP I-PDU carrying a 0- or 1-byte LLCP payload is handed up as
>>> a sub-2-byte skb.
>>>
>>> For a CONNECT or CC PDU, nfc_llcp_recv_connect() and nfc_llcp_recv_cc()
>>> then pass skb->len - LLCP_HEADER_SIZE to nfc_llcp_parse_connection_tlv().
>>> For skb->len < 2 that subtraction underflows: truncated into the u16
>>> tlv_array_len parameter it becomes ~0xFFFE, and for a CONNECT to the SDP
>>> SAP, nfc_llcp_connect_sn() uses a size_t and underflows to SIZE_MAX. The
>>> TLV parsers bound their walk relative to that length, so they read far
>>> past the end of the skb.
>>>
>>> The aggregated-frame path (nfc_llcp_recv_agf()) already drops sub-PDUs
>>> shorter than the header. Apply the same guard once, in the dispatcher, so
>>
>> that not exactly correct, it drops skbs which are shorter or equal to
>> the header, the check added in this patch is not correct then.
>>
>>> every PDU type is covered.
>>>
>>> Found by 0sec (https://0sec.ai) using automated source analysis; the
>>> missing guard is evident from source. Compile-tested.
>>>
>>> Fixes: d646960f7986 ("NFC: Initial LLCP support")
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: 0sec:claude-opus-4-8
>>> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>>> ---
>>>    net/nfc/llcp_core.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
>>> index aed5fe1afef0..e3b3077e0e83 100644
>>> --- a/net/nfc/llcp_core.c
>>> +++ b/net/nfc/llcp_core.c
>>> @@ -1481,6 +1481,9 @@ static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb)
>>>    {
>>>        u8 dsap, ssap, ptype;
>>>
>>> +     if (skb->len < LLCP_HEADER_SIZE)
>>> +             return;
>>> +
>>>        ptype = nfc_llcp_ptype(skb);
>>>        dsap = nfc_llcp_dsap(skb);
>>>        ssap = nfc_llcp_ssap(skb);
>>


