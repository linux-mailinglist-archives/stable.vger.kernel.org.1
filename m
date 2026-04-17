Return-Path: <stable+bounces-238505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK/dLXFa4mn65AAAu9opvQ
	(envelope-from <stable+bounces-238505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 18:06:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F59B41CE71
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 18:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10A72307E1F9
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 16:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6703346FA7;
	Fri, 17 Apr 2026 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtX3uirh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C933F597;
	Fri, 17 Apr 2026 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441883; cv=none; b=gKHzN1b/p/hybVqGXLqAwgEaJH/nhOeXWWxNpqC3iMDzMI3Yz/6RjlSpeb8851hX62fWwEHwkV1T+1LVbi8MVUEmPt1SXZhBkg4D+WqTCSDcEfs29SxmzqzqgLM8kyQqSMBHS+d0gnxtqpmAyUZa79CsiPgZeLksqY6YPA8jGus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441883; c=relaxed/simple;
	bh=eoOHNTLXUuxqHa7GYHnN9Zwr2758O72sKIxIKArJBIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hk9KudJqc8qXn4tH6Dr1jckXSOXUev695v0JEGEPcLXs4tgFtMNPLYlkhwD+eNI1d3SlXiDqo6T+1CmGhPwZ6gXX3uWbbL2+jFp/gMozpZz6BAl0Vmiort9Kir5gYVOXAKfE4qZPsEU5RKvnImhp48QZdQFvnRKXbLR8ziNL39Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtX3uirh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D91C19425;
	Fri, 17 Apr 2026 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776441883;
	bh=eoOHNTLXUuxqHa7GYHnN9Zwr2758O72sKIxIKArJBIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KtX3uirhW9fpWjIycPD5JAaW3aJgAtxCrbsRGXTVJv7w2dV4GuQJ7uydCiHkg9AC8
	 2CNIoTSBvAHY7u2bpZDQZZBO686KN+wno/YKCHatdDGKQzD+r/ZSfPYVMmG/7Sh3n4
	 AYUxKJv9gxE8WyldqefJutDHoR87ZUsekuSHQBOVEvyDG2I1vRSztw63X44UnfAjEm
	 dTFn7eGvhmjbRovJ5dP3cM8AWhnI8Pws2hs7KveK4dUj6jDrUhJ/+/Wx8AIJIJX8jQ
	 OcvjgBXaCccNBi99Ql+NhxSOzhZxDpaImW63pVnSBY6GXLjIQK1b0ejv1TLVMM/VbY
	 KZW2wkvWj+ySA==
Date: Fri, 17 Apr 2026 17:04:38 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
Subject: Re: [PATCH net v3 2/4] nfc: llcp: fix TLV parsing in parse_gb_tlv
 and parse_connection_tlv
Message-ID: <20260417160438.GH31784@horms.kernel.org>
References: <20260414233534.55973-3-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414233534.55973-3-snowwlake@icloud.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238505-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,outlook.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[icloud.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 1F59B41CE71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 01:35:31AM +0200, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() walk TLV
> arrays whose length and content come from a peer-supplied frame.  The
> parsing loop has three weaknesses:
> 
>  1. `offset` is declared u8 while `tlv_array_len` is u16.  In
>     parse_connection_tlv() the TLV array can reach ~2173 bytes (MIUX
>     up to 0x7FF), so 128 zero-length TLVs wrap `offset` back to 0 and
>     the loop never terminates while `tlv` advances past the buffer.
> 
>  2. The guard `offset < tlv_array_len` only proves one byte is
>     available, but the body reads tlv[0] (type) and tlv[1] (length).
>     When one byte remains, tlv[1] is out of bounds.
> 
>  3. `length` is read from peer data and used to advance `tlv` without
>     being checked against the remaining array space.  A crafted length
>     walks `tlv` past the buffer; the next iteration reads tlv[0]/tlv[1]
>     from adjacent memory.
> 
> The llcp_tlv8() and llcp_tlv16() accessors additionally read tlv[2]
> and tlv[2..3]; a zero-length TLV makes those reads out of bounds.
> 
> Fix: promote `offset` to u16; add two per-iteration guards, one for
> the TLV header and one for the TLV value; require length >= 1 for all
> TLVs before the type dispatch and length >= 2 for the llcp_tlv16()
> accessors (MIUX, WKS).  Return -EINVAL on malformed input.
> 
> Reached on ATR_RES (parse_gb_tlv) and on CONNECT/CC PDUs before a
> connection is established (parse_connection_tlv).  Both are
> triggerable from any NFC peer within ~4 cm, without authentication.

As per my comment on patch 1/4, I don't understand the relationship
between the last sentence above and this patch.

> 
> Reported-by: Simon Horman <horms@kernel.org>
> Fixes: d646960f7986 ("NFC: Add LLCP sockets")

I think the hash but not the subject is correct in the fixes line.
IOW, I think this should be:

Fixes: d646960f7986 ("NFC: Initial LLCP support")

> Cc: stable@vger.kernel.org
> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>

Otherwise, looks good to me.


While looking over this I noticed that nfc_llcp_connect_sn() seems
to have the same kind of problem. You may wish to address that as
a follow-up.

...

