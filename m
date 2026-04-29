Return-Path: <stable+bounces-241903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDMABI8g8mm/oAEAu9opvQ
	(envelope-from <stable+bounces-241903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:15:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D08F496A83
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 17:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 193BD300FC56
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8023502A5;
	Wed, 29 Apr 2026 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdmXAjCP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883211CBA;
	Wed, 29 Apr 2026 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475302; cv=none; b=DSlYMuvBe5ho947lo1YHAG6Rq+5pcbAlflNmXvBcEDvytE+GzQTXuKzmP6nIWK7AcjGrYSfO/yhUKBIHKzUHIEhQPaxmDwC7JsW2448vbrwKzeLeW1Vdvd9kpNxgFeCtcy6kblqOUvvHsPYX91jNp9OaOtTm1pZHCNI1vATKwQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475302; c=relaxed/simple;
	bh=1v6yu6Y0TOkhpVr86ozssxSFAtMUEknFXI14N8XRY4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dy5Oe0nnVyd0im3ISx+LbezivOLL2n0jTVUQUAIJjuqyGvEgImM8BpfBe1aLs+zpnfCTNy+YaGU7cPCld7u7jwPLpRoTiHl2n2NZUmg9HPlzd0/oiT2f3zm0pDhiNpDZQaBxpPjNAJ/hRZHpegzeBTR3TYkkPPIAY4JjLUB5ZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdmXAjCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BE7C19425;
	Wed, 29 Apr 2026 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475302;
	bh=1v6yu6Y0TOkhpVr86ozssxSFAtMUEknFXI14N8XRY4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdmXAjCP/v1YQOGNIns4NZSOWJB4SSRsHGWGAs5y1E9ElPw402C+yG0nTVsDzGxGX
	 gq18rne6XqE/NlvfyMUp5kxQQFBnFjyTyfEKvIyZ+nA6CRn6A0hJPoJTcaKbef6T3u
	 lZerAzS8WakzSvO564MzaJ8gO3JDIUzrQwfnvH3cmu/GdNbhcLs/wKPoA8taUsl/46
	 +YQU6OSkVI3SEFanL79NPvsXbc9uO12w8y3x+Ib2q3DgEn3ia+w6MqPLdy/tXAfH3L
	 V4jSpJQiMqnGUJluypXJwSXE7j0yqAsl8W+aHr5uAuTerVomGnkANGHzhAdwfCEzqZ
	 gmEzBnYnL3UAw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wI6WR-00000000lPA-3Pgr;
	Wed, 29 Apr 2026 17:08:19 +0200
Date: Wed, 29 Apr 2026 17:08:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: reject devices with unregistered buses
Message-ID: <afIe495IbAe7EeDt@hovoldconsulting.com>
References: <20260427102852.2174-1-johan@kernel.org>
 <DI50WG9XK1I4.1R6DXSZSWFRDC@kernel.org>
 <afHZWasOhRaeBCnt@hovoldconsulting.com>
 <DI5LDIQW45PE.LPIWCARJV7WC@kernel.org>
 <afHsgv9SUqfn-G1x@hovoldconsulting.com>
 <DI5Q29QMNVNH.1B2N4VBA2ZVQW@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI5Q29QMNVNH.1B2N4VBA2ZVQW@kernel.org>
X-Rspamd-Queue-Id: 5D08F496A83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241903-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hovoldconsulting.com:mid]

On Wed, Apr 29, 2026 at 04:52:08PM +0200, Danilo Krummrich wrote:
> On Wed Apr 29, 2026 at 1:33 PM CEST, Johan Hovold wrote:
> > It seems we have differing definitions of "bug", but to me this is
> > clearly a bug in driver core.
> 
> I think we do -- you are saying it is a bug that the driver core does not print
> a warning when a caller introduces a bug on its own due to an ordering
> violation.

No, I'm saying that it's a bug in driver core to silently treat a device
that is registered before its bus as a bus-less device.

Johan

