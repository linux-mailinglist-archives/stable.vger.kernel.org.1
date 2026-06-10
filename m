Return-Path: <stable+bounces-262511-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4rXAKpd7KWqjXgMAu9opvQ
	(envelope-from <stable+bounces-262511-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:58:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 199D566A805
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:58:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X3NmxFad;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262511-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262511-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA7BB314DAFE
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4DE3F0ABB;
	Wed, 10 Jun 2026 14:44:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4892D3D9674;
	Wed, 10 Jun 2026 14:44:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102657; cv=none; b=rfmwEWCGMG++03mtnpR+ul1n0KtxZYhqemqL/ZYFVTTQawZEaGAynBqYE5qeh/b6hycv+2a9m1Xu6kvDsDOxLmd7LQAaX9vMjwy8AmPrQZA7V7NLh+/vwIO6o+S7LH4udyKG6IvS4ZtEpx7BOQibI5IgsMqfr0iQ6Vd0a4pvOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102657; c=relaxed/simple;
	bh=CzpOn/vnwhVqBK82tea3EwQywjpBoBgwUkewtYnNrAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+qGBi63kbKA2AMy2/Hp70TwJYoBNDshornRUOzVA594MRYBjjnz605ouDm69Vcz9vkujaCw40pmBx/OHFraXBG3+KCq6rLBrGPo0MN9Gk+lzOD4sOzT/KyEMiaFKC8eyMsu8ZaTrVZrxDcA03D5lq9RAfrRVc9hGJX/hI7E90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3NmxFad; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA51A1F00893;
	Wed, 10 Jun 2026 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781102656;
	bh=CzpOn/vnwhVqBK82tea3EwQywjpBoBgwUkewtYnNrAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X3NmxFadAqcgwkw+SRXv8eNX+AUDM/Gs/rUuiilkfyMlhfw7k26da4J2+cXdqgFFP
	 dgKTNGV9OdEtUiRISczL6GO2aER3JmdM1ldMsRu2ETkqwdLTuFXsaZZZNyjnMAAjA7
	 x6pikG1o7kEhFj8x3lTrl6mS1jkIIf4OMWH+8mw0kpYlRbzFiuuz6MfTpp/0aLJIaR
	 6DwxFgBhp9IXmidgVGR97IZB6ieYa4YkVr1rklWxNSIPNj1nC8yfm7zuHvpsCuSA19
	 9lnTsC7weOYgrLFTYBTLYO6AKIED/ClgUbsnY2gllMDMtsH4vLmjdd8qIqlEyLscjX
	 OxMSk5nh50I3w==
Date: Wed, 10 Jun 2026 08:44:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmet-auth: reject short AUTH_RECEIVE buffers
Message-ID: <ail4PgdFd3Xljugs@kbusch-mbp>
References: <20260609182431.2437882-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609182431.2437882-1-michael.bommarito@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262511-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:hare@suse.de,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:axboe@kernel.dk,m:linux-nvme@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,kbusch-mbp:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 199D566A805

On Tue, Jun 09, 2026 at 02:24:31PM -0400, Michael Bommarito wrote:
> nvmet_execute_auth_receive() trusts the AUTH_RECEIVE allocation length
> after checking only that it is nonzero and matches the transfer length.
> In the SUCCESS1 and FAILURE1/default states, that lets a remote NVMe-oF
> initiator reach the fixed-size DH-HMAC-CHAP response builders with a
> kmalloc() buffer shorter than the response, so nvmet_auth_success1() and
> nvmet_auth_failure1() write past the allocation; both only WARN_ON the
> short length and then format the message anyway.

Thanks, applied to nvme-7.2.

