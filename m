Return-Path: <stable+bounces-260082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kYvXMdoqIGpXyAAAu9opvQ
	(envelope-from <stable+bounces-260082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 15:23:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C851638016
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 15:23:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sang-engineering.com header.s=k1 header.b="NSyhkXk/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260082-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260082-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D249327CB5C
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795D480DDA;
	Wed,  3 Jun 2026 13:14:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA98481256
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 13:14:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492499; cv=none; b=DHPVfSpAzj1dxeOpqn15tIL0rXfqpEQXwbYwJXK5ytib8zrLNdmwcTkAZnudOG3KmHB7qskigb7cE5Oe3agFeby6G/fJWt6DykQWJoHdjjbcc8iQrndFoprmr/Ga0pl2rBeDQkoF8sw2+2qBRjc9zGJSO0z9OiD6H4wtIWWC+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492499; c=relaxed/simple;
	bh=mMYK5Q2ek6ZmeO361IA+ZAcaRRX6L05wod0xSsYtO4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qddvfKwQ52pX8DrJmqOQtSek2NOjO9YE0j/ZaXT7gAyJzMuUiffxiNMRg0fhiEEuWCVr6tDUTbV4m0rQvPm9uJdoQlPaZJ3YW7d9wi9chaxLRUqEASJgdgg2N97o8YjAqhW0pvmSD+5I+3zzBP2t0305bV6g1LqxMZP8DgpXFiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=NSyhkXk/; arc=none smtp.client-ip=194.117.254.33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Ouf7
	mBHEDsmccuHvUASszmfTiWBF750HqGo9Wt8MppI=; b=NSyhkXk/ty44OWCj2rVV
	3Bfrfw9pf9RN1wsp13bQO6Tb30JUW3a4ghLx7jmedLofQ/szChLp1+zYSWqrQBJl
	TaAk4m7qj71W6sF40luS3rpBxzaM+61MTVgGLRHQxSks+NUaLjQd1VLZsENadiqH
	9xcVieJs5eQY/swKEzfe0+aCSvzb063HJN3wJS0PsSb+qB5w7pAWrS6qhIxDaNXm
	Oqw6JRyj9eaib6iC9bwB7UrYODI4R0LDRIn5TGdAxlsn2XFJcDOUsMEIah4gDe0K
	89zBy/iIYUZfpLVpDbBckax69C0er9eU+LEcwYWZW7IYf5kjBDaCIFyflIDRgFm/
	Lg==
Received: (qmail 3289264 invoked from network); 3 Jun 2026 15:14:55 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jun 2026 15:14:55 +0200
X-UD-Smtp-Session: l3s3148p1@0US3NllToJ8ujnsK
Date: Wed, 3 Jun 2026 15:14:54 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Johan Hovold <johan@kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 05/10] i2c: core: fix adapter debugfs creation
Message-ID: <aiAozu6l6ohWCX3o@ninjato>
References: <20260511143715.729714-1-johan@kernel.org>
 <20260511143715.729714-6-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511143715.729714-6-johan@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[sang-engineering.com:s=k1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:johan@kernel.org,m:andi.shyti@kernel.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sang-engineering.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sang-engineering.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wsa@sang-engineering.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-260082-lists,stable=lfdr.de,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sang-engineering.com:dkim,sang-engineering.com:from_mime,sang-engineering.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ninjato:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C851638016

On Mon, May 11, 2026 at 04:37:10PM +0200, Johan Hovold wrote:
> Clients can be registered from bus notifier callbacks so the debugfs
> directory needs to be created before registering the adapter as clients
> use that directory as their debugfs parent.
> 
> Move debugfs creation before adapter registration to avoid having
> clients create their debugfs directories in the debugfs root (which is
> also more likely to fail due to name collisions).
> 
> Note that failure to allocate the adapter name must now be handled
> explicitly as debugfs_create_dir() cannot handle a NULL name (unlike
> device_add() which returns an error).
> 
> Fixes: 73febd775bdb ("i2c: create debugfs entry per adapter")
> Cc: stable@vger.kernel.org	# 6.8
> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


