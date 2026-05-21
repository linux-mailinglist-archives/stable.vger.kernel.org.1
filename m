Return-Path: <stable+bounces-253608-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGf2LXo7D2qZIAYAu9opvQ
	(envelope-from <stable+bounces-253608-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:06:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C85A9DA0
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 192DA349CE63
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB653672BF;
	Thu, 21 May 2026 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PG2XktR2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540C825B0B3;
	Thu, 21 May 2026 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377763; cv=none; b=Zu9Ohit2DqnMJg3CNfjn14qaZOFQxum4TwrAsPpd4xbYJ9ctjTrJEH0vud7bz4cQsb5GsUXLNGMeExtBvITuTCCIjI5qfHm2ZwXCQo6ST4ZnGmTCGSJQ4DRiwrJ9mpTzDVKywVk0HrA7hTqMfYBgElv6v5rOj7g5ap6bgcQHMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377763; c=relaxed/simple;
	bh=5dDy/aBj4E9U494Qv23Ul+WC06rY5CyC63djaVJpECk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFXYOoHNIcWqJbNEfu+tj7x8sEEKeOuL4mpa28C+5SQWifNHnGuatMWuXstasDA9PtT1dH5+X1AuCeoQ9MqKZs0Rmp/MT1ygd4MEEuEQGjBPqfogTj4XfyCYFJzJCVp9bWIware/aY2MkzjCxwJI+vGusTwL5Lw6VSpqu3etOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PG2XktR2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0847C1F000E9;
	Thu, 21 May 2026 15:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377762;
	bh=XsAMDB0q4nKocT90tbJUfWc/eUcL09U3cACOei5OtWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PG2XktR2z9H5ojAna5dJquvxmb9MMvzHNlj61U4EM993BVkH44o9J9S3pCBhulWgR
	 9TAsQjM94xzMd34dhMPglgf1jlfCVF5/l3wa6VpKNdaHnuhdeXMaBKfzP1Uf29HCjT
	 NACsF43hHl9CE0AGKDN+JfiYmH/HfeL7VG8bh5JY6gIEOxTdgjiYUCxinpfqELTktd
	 n6+y2wNBM8xZzOuObAUdCInziYzdkdFMNKfiSZqWkls5gpfYEfQi9BIuLKqcA/nDdC
	 YppkciFylJUBMKW7fEjEVkshfDJSGVJXZhmfY4cCNigivI1PmIuzfI11IXitvmwY/4
	 84qJbgnsxS5ZA==
Date: Thu, 21 May 2026 16:35:57 +0100
From: Simon Horman <horms@kernel.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev, david+nfc@ixit.cz,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] nfc: llcp: fix OOB reads and integer bugs in TLV
 parsers
Message-ID: <20260521153557.GE1506108@horms.kernel.org>
References: <20260519011937.12903-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519011937.12903-1-meatuni001@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253608-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,nfc];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 057C85A9DA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 09:19:35PM -0400, Muhammad Bilal wrote:
> This series fixes memory safety bugs in the NFC LLCP TLV parsing code,
> reachable from a remote NFC peer via crafted LLCP frames.
> 
> Patch 1 fixes nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv():
>   - u8 offset wraps to zero after 255 (widened to u16)
>   - OOB read of TLV header on truncated buffer
>   - OOB read of value field via attacker-controlled length byte
> 
> Patch 2 fixes nfc_llcp_recv_snl():
>   - OOB read of TLV header when tlv_len - offset == 1
>   - OOB read of SDREQ value via attacker-controlled length
>   - SIZE_MAX underflow when length == 0 in service_name_len,
>     bypassing the sn_len == 0 guard in nfc_llcp_sock_from_sn()
> 
> Previously reported to security@kernel.org on 2026-05-15. Willy Tarreau
> advised posting to public lists as NFC is currently orphaned.

Reviewed-by: Simon Horman <horms@kernel.org>

The AI generated review at sashiko.dev has flagged a number
or pre-existing problems.

While several of them do seem to impact the effectiveness of these
patches I would suggest treating them as items for possible follow-up.

I say that in order to expanding the scope of this patch-set.
Which I believe risks growing significantly if related issues
are solved; because I fully expect that to lead to more related issues.

So I advocate an incremental approach, starting with this
patchset in it's current form.

