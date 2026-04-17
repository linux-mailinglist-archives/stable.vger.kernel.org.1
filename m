Return-Path: <stable+bounces-238486-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDyvLaUv4ml22gAAu9opvQ
	(envelope-from <stable+bounces-238486-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:03:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7341B6C6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A225830315FA
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 13:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2239C623;
	Fri, 17 Apr 2026 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzd68kGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890337C920;
	Fri, 17 Apr 2026 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430827; cv=none; b=jZ8sfKIj+HSvXcLQjGffxGRfoI2SyaE1hrzLNxsgUv2ZJcHGaBjc4nOuoUeVCLuEmKu1oUL2E2X3F1AqrMPf3CousQphk5eJ22FZgfaG+i3cy3IOyQCzwdOmVctJjVTYe04IFSjvAqZajoIGXzCwLyxw6+iJJ9sxJfb7yVW2vR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430827; c=relaxed/simple;
	bh=hoRRIwUCRVuXUDUPc5I+d1W4LdLrzH/IYjZ9W5JT7F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZLD5eyBn52x+5d0Q2Kutu8CpuwBgjSo3Ry+rtdPMitDOXzOmwUFaQ9jIvJ+fXHafr4MoESplSV+1fq/xBX6KZoFiz1caPLeMc67hje6gkkct7vWeCH1Z8E3sbqjAjrNl/OguNMaU0oVUniE1/CtbTD1P/tSB0fyj4TaqY/CWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzd68kGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41000C19425;
	Fri, 17 Apr 2026 13:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776430827;
	bh=hoRRIwUCRVuXUDUPc5I+d1W4LdLrzH/IYjZ9W5JT7F4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzd68kGXVxZtPkRRPWCLVmJwga6d6I45qXcSHQnYAj+HG7Gg/o3VE83mxb4bx77QP
	 hg/vh00kC0rCkZzMr5KTTS+d7B0g0NMIczv+tIJ5fxdFtHus1s0eLWNz5D+NYyzEVp
	 quDAA+J1q/e0d4P44wio46yREuJKha5sScog+xlt/IC+fBaXNZNiSPGf9onVyRn0+7
	 kdIu2qwHB234x/J/sQK3LBRd3Nd6IPyrnmvM3ICRclmEfrMurvTDSABcSkpIMWZYp+
	 vrPqzzXbA0iMq431KixdU77hRfZ8OeGhOY3ElvowenrJNWY3p+wcaZJv/NOqRA9i8M
	 6EdKWa5RRQy/A==
Date: Fri, 17 Apr 2026 14:00:22 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?utf-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
Subject: Re: [PATCH net v3 1/4] nfc: nci: fix u8 underflow in
 nci_store_general_bytes_nfc_dep
Message-ID: <20260417130022.GC31784@horms.kernel.org>
References: <20260414233534.55973-2-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260414233534.55973-2-snowwlake@icloud.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238486-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 65B7341B6C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 01:35:30AM +0200, Lekë Hapçiu wrote:
> From: Lekë Hapçiu <framemain@outlook.com>
> 
> nci_store_general_bytes_nfc_dep() computes the General Bytes length by
> subtracting a fixed header offset from the peer-supplied atr_res_len
> (POLL) or atr_req_len (LISTEN) field:
> 
>     ndev->remote_gb_len = min_t(__u8,
>         atr_res_len - NFC_ATR_RES_GT_OFFSET,   /* offset = 15 */
>         NFC_ATR_RES_GB_MAXSIZE);
> 
> Both length fields are __u8.  When a malicious NFC-DEP peer sends an
> ATR_RES/ATR_REQ whose length is smaller than the fixed offset (< 15
> or < 14 respectively), the subtraction wraps:
> 
>     atr_res_len = 0  ->  (u8)(0 - 15) = 241
>     min_t(__u8, 241, NFC_ATR_RES_GB_MAXSIZE=47) = 47
> 
> The subsequent memcpy then reads 47 bytes beyond the valid activation
> parameter data into ndev->remote_gb[].  This buffer is later fed to
> nfc_llcp_parse_gb_tlv() as a TLV array.
> 
> Reject the frame with NCI_STATUS_RF_PROTOCOL_ERROR when the length is
> below the required offset, and propagate the error out of
> nci_rf_intf_activated_ntf_packet() instead of silently accepting the
> malformed packet.

This does not seem to be consistent with the handling of other in
nci_rf_intf_activated_ntf_packet() when it calls other functions similar to
nci_rf_intf_activated_ntf_packet().

I suggest dropping this part of the fix, and addressing
nci_rf_intf_activated_ntf_packet() in a more holistic manner
if this kind of change is desired.

> 
> Reachable from any NFC peer within ~4 cm during RF activation, prior
> to any pairing.

I do not understand how this statement relates to this change.
Could you explain?

> 
> Fixes: c4fbb6515709 ("NFC: NCI: Add NFC-DEP support to NCI data exchange")

I am unable to find a commit with either that hash or subject.

It seems to me that this problem was introduced in:

767f19ae698e ("NFC: Implement NCI dep_link_up and dep_link_down")

-- 
pw-bot: changes-requested

