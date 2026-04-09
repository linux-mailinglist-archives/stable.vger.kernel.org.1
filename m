Return-Path: <stable+bounces-235449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Eh2OMTW12mDTggAu9opvQ
	(envelope-from <stable+bounces-235449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:41:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD63CDBA3
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D3EC300DE14
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 16:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267003DA5B9;
	Thu,  9 Apr 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+4u6DaF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF328BE9;
	Thu,  9 Apr 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775752894; cv=none; b=fhR1iGhzNTS2V3W2PkRNi+0zg7eOvCwCcOkL3D3V//NQ6zkTOnNtAusLWvORPqe7dC3WHLcXb099Vlcx9IiwdwAvnW6fzypj7b4t0Xfiyc2d2ftWM4c4rBhK6xX37G6hjrxj4DpwPFuO3L8TkeTtClekJhimyh0k3RZNLlyVX+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775752894; c=relaxed/simple;
	bh=6zXW+2vpDaE6dfJoCWrlfA9JjKulqRk76elU+i487DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk+5pI0eoeCYV/hatSnind+KOGB8RxO1EPgwBS1+CQHfmSLobl3Ig4/JDPA6aANngnWRoS8Ps7EWlwdNjBvtB3mjFGXTtPBUSI1tJBaLTj1hkD8fSkN//jUcurEyywZ4XkczyHukwAaIZIIhEageGuobTcoKV4uxHdg5/HFVcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+4u6DaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB77C4CEF7;
	Thu,  9 Apr 2026 16:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775752894;
	bh=6zXW+2vpDaE6dfJoCWrlfA9JjKulqRk76elU+i487DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+4u6DaFYCpzAqCDLI9SEyluDVB91upu7RsV0LOFyCY07e2cMR0gzlGn7a2YevSlX
	 hO4CGlFY6EnEP+kERjeY29oLnAjYwACjlhZ72Q3UbzPs7W6SkYMsqAGIsI9vfkza3/
	 jiCTto8ZhPWhZ/e8PhUR8ygVp6xstejMsAP9kQY3YyJzUuc9SvoEw7PIjAWu26oMxK
	 Z/WnReJ5IJwcMnIbmUnym2LdZfC1vOuIe6tDGSIDswMyrsco8NzduTMOMSmUHc7Ie1
	 y6kCFKmHBZgJB3GmnJVAS85NoSLJ/ckabVG6Puh01d1C2yayzvi72I814h/vsT5lt7
	 tTiEUv+hnRbzQ==
Date: Thu, 9 Apr 2026 17:41:29 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
Subject: Re: [PATCH] nfc: llcp: fix u8 offset truncation in LLCP TLV parsers
Message-ID: <20260409164129.GO469338@kernel.org>
References: <20260405105938.1334488-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260405105938.1334488-1-snowwlake@icloud.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,outlook.com];
	TAGGED_FROM(0.00)[bounces-235449-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 36CD63CDBA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 12:59:38PM +0200, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() declare
> 'offset' as u8, but compare it against a u16 tlv_array_len:
> 
>     u8 type, length, offset = 0;
>     while (offset < tlv_array_len) {   /* tlv_array_len is u16 */
>         ...
>         offset += length + 2;          /* wraps at 256 */
>         tlv    += length + 2;
>     }
> 
> When tlv_array_len > 255 -- possible in nfc_llcp_parse_connection_tlv()
> when the peer has negotiated MIUX = 0x7FF (MIU = 2175 bytes), so that
> a CONNECT PDU can carry a TLV array of up to 2173 bytes -- the u8
> offset wraps back below tlv_array_len after every 128 zero-length TLV
> entries and the loop never terminates.  The 'tlv' pointer meanwhile
> advances without bound into adjacent kernel heap, causing:
> 
>   * an OOB read of kernel heap content past the skb end;
>   * a kernel page fault / oops once 'tlv' leaves mapped memory.

Is the more general explanation of this problem that the length of packet
data is used as the tlv_array_len parameter, and that length is not
verified to be within the expected bound?

I am also concerned that the packet data needs to be pulled
before it can be safely accessed.

> 
> This is reachable from any NFC P2P peer device within ~4 cm without
> requiring compromised NFCC firmware.

I think some further explanation is warranted here if that is the case.

> Fix: promote 'offset' from u8 to u16 in both parsers, matching the
> type of their tlv_array_len parameter.
> 
> nfc_llcp_parse_gb_tlv() takes GB bytes from the ATR_RES (max 44 bytes),
> so the wrap cannot occur in practice there.  Change it anyway for
> correctness and to prevent copy-paste reintroduction.

In the case of both nfc_llcp_parse_gb_tlv() it seems to me that wrap-around
can occur because the value of length, which is used to increment the value
of offset, is read from unverified packet data. Is the data validate
somewhere, or known to be correct?

If so, I expect this can also result in an overrun of tlv.

And I think the same problem exists in nfc_llcp_parse_gb_tlv().

> 
> Cc: stable@vger.kernel.org

A fixes tag is needed here.

> Signed-off-by: Lekë Hapçiu <framemain@outlook.com>

The patch should be targeted at net-next like this:

Subject: [PATCH net] ...

And please group together related patches - I see several for nfc -
in a patchset.

More on the Netdev development process can be found here
https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested

