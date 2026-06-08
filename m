Return-Path: <stable+bounces-262056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e8rxHGzqJmpQnAIAu9opvQ
	(envelope-from <stable+bounces-262056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:14:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A68865890F
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 18:14:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-ilmenau.de header.s=tuil-dkim-1 header.b=omQQ1wDm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262056-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262056-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=tu-ilmenau.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E5FA30CAC7C
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7324C3CFF44;
	Mon,  8 Jun 2026 15:31:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C23CB2C7;
	Mon,  8 Jun 2026 15:31:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932669; cv=none; b=IlFJv93sJn2OENWLmkLB7uiX+/e07ZTV1VnTJRuM4HAulR0WG9g1A7oy+m3u2a1CXeQeH4wTcsWjKRQSxz+wUxxoPcjJvoDgjvcHnLLYwFirLPXh41B5ZzxDCZQKXgGVV4g0ENlbebAFGMPrzUrcnG2coy/uln983zKnKPHwC9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932669; c=relaxed/simple;
	bh=W9GHepxpS3a9NO8H2UUh9zgdFf1J5K0/egqzsE9mKRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuFKYs/ELzJkMYw2Ez+xviqIPQxjDYSnaYcrNcMRkSQ/NyNybua4bbjn0shqYw1kzeEZ5igyaVzQTBiQxgMuBXn7SVHs+61lnoe72fKqRq37U0xdveULTSrGxIr/Y+nE2xpl4YCEIXrQJmbFsDj9A6EezOxZwjbI6xR9GNIDygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=omQQ1wDm; arc=none smtp.client-ip=141.24.179.34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780932657; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=W9GHepxpS3a9NO8H2UUh9zgdFf1J5K0/egqzsE9mKRo=;
 b=omQQ1wDmjAatgUAIBDdbfTWn7V3QjfuEtX61TAiOuC+w5naRS9IsTFSsMv9qaC28omxie
 hXV+cy4/kvyObWm+wtSnnLwWcO/XDDi2NGYA4th8l4nVQ5AnAN63SpURjg6444LiveavrS1
 alIRQpuvBOgjDnmia5MSB3R1JfxCLn4dhHlJGxoxeQhEFor/SlGx6xO6AH3DvQcSdAvl0j+
 erknKwgnPJkEHH11/Ega/ydOAn/rKJkPrnwBoLeC1dJiNeAv/WcxPWCVDTRiXHT9mZ3eVZY
 rGcswiwHVEwJCIU8Z0gzzxDq1SWclrQO1jFG5BGy8P6dkf1/3n79T4DRKF8A==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B7D665FB24;
	Mon,  8 Jun 2026 17:30:57 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 964095FB0C;
	Mon,  8 Jun 2026 17:30:57 +0200 (CEST)
Message-ID: <36e1183c-22d7-4fec-ac20-751f54b18616@tu-ilmenau.de>
Date: Mon, 8 Jun 2026 17:30:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: fix potential out-of-bounds read in
 decode_new_up_state_weight()
To: Zhenhao Wan <whi4ed0g@gmail.com>, Ilya Dryomov <idryomov@gmail.com>,
 Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>,
 Josh Durgin <jdurgin@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
References: <20260606-ceph-fix-final-v1-1-e19325c14dd6@gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <20260606-ceph-fix-final-v1-1-e19325c14dd6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-ilmenau.de,quarantine];
	R_DKIM_ALLOW(-0.20)[tu-ilmenau.de:s=tuil-dkim-1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262056-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,dubeyko.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:whi4ed0g@gmail.com,m:idryomov@gmail.com,m:amarkuze@redhat.com,m:slava@dubeyko.com,m:jdurgin@redhat.com,m:ceph-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[raphael.zimmer@tu-ilmenau.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[tu-ilmenau.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raphael.zimmer@tu-ilmenau.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-ilmenau.de:dkim,tu-ilmenau.de:mid,tu-ilmenau.de:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A68865890F

On 06.06.26 5:51 PM, Zhenhao Wan wrote:
> The new_state section of an incremental OSD map is validated and skipped
> using a byte count computed as
> 
> 	len *= sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8));
> 
> The multiplication is evaluated in size_t, but the result is stored back
> into the u32 "len", truncating it.  A malicious or corrupted incremental
> map can supply a new_state element count >= 0x20000000 (struct_v >= 5) so
> that len * 8 wraps modulo 2^32 to a small value.  The following
> ceph_decode_need() then validates far fewer bytes than the section
> actually occupies.
> 
> new_state is then reprocessed with the unchecked ceph_decode_32() and
> ceph_decode_8() helpers, which have no per-iteration bounds check and
> rely entirely on that truncated up-front validation.  This can lead to
> a kernel out-of-bounds read past "end".
> 
> Compute the byte count in u64 and bounds-check it against the remaining
> buffer before skipping, mirroring the size_t-typed length checks used
> elsewhere in this file (e.g. decode_crush_names(), decode_pg_mapping()).
> The osd index used for the osd_state[] write is already bounds-checked
> against map->max_osd, so this is an out-of-bounds read, not a write.
> 
> Fixes: 930c53286977 ("libceph: apply new_state before new_up_client on incrementals")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
>  net/ceph/osdmap.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b5b0587a0cf..dd3023fe821e 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1842,6 +1842,7 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
>  	void *new_up_client;
>  	void *new_state;
>  	void *new_weight_end;
> +	u64 skip_len;
>  	u32 len;
>  	int ret;
>  	int i;
> @@ -1862,9 +1863,10 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
> 
>  	new_state = *p;
>  	ceph_decode_32_safe(p, end, len, e_inval);
> -	len *= sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8));
> -	ceph_decode_need(p, end, len, e_inval);
> -	*p += len;
> +	skip_len = (u64)len * (sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8)));
> +	if (skip_len > end - *p)
> +		goto e_inval;
> +	*p += skip_len;
> 
>  	/* new_weight */
>  	ceph_decode_32_safe(p, end, len, e_inval);
> 
> ---
> base-commit: dbe8d05c9750b107b10c15361aad40fbb350bedb
> change-id: 20260606-ceph-fix-final-16f4e1df5a5e
> 
> Best regards,
> --
> Zhenhao Wan <whi4ed0g@gmail.com>

Hi,
a patch for this issue has already been discussed on the ceph-devel
mailing list here:
https://lore.kernel.org/ceph-devel/b6c16cd9aa7bc31240a133d68cec03ea914f918a.camel@ibm.com/T/#t

Best regards,
Raphael

